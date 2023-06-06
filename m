Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185EE724105
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjFFLf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjFFLfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:35:52 -0400
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C7010D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:35:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---.TMrLcZL_1686051336;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.TMrLcZL_1686051336)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 19:35:37 +0800
Date:   Tue, 06 Jun 2023 19:35:36 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     "Juergen Gross" <jgross@suse.com>,
        "kernel list" <linux-kernel@vger.kernel.org>,
        "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        "Alexey Makhalov" <amakhalov@vmware.com>,
        "Pv-drivers" <Pv-drivers@vmware.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "X86 ML" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Song Liu" <song@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH RFC 13/43] x86/paravirt: Use relative reference for
 original instruction
Message-ID: <20230606113536.GA106605@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <d0e601438f4d140c0c383c6ad09483b34c7c572e.1682673543.git.houwenlong.hwl@antgroup.com>
 <44e2fb4d-151c-dba9-9cb8-0d99c3668a6f@suse.com>
 <4D9D12CE-87A7-485F-B8F6-A9F77156C372@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D9D12CE-87A7-485F-B8F6-A9F77156C372@vmware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:40:54PM +0800, Nadav Amit wrote:
> 
> 
> > On Jun 1, 2023, at 2:29 AM, Juergen Gross <jgross@suse.com> wrote:
> > 
> > On 28.04.23 11:50, Hou Wenlong wrote:
> >> Similar to the alternative patching, use relative reference for original
> >> instruction rather than absolute one, which saves 8 bytes for one entry
> >> on x86_64.  And it could generate R_X86_64_PC32 relocation instead of
> >> R_X86_64_64 relocation, which also reduces relocation metadata on
> >> relocatable builds. And the alignment could be hard coded to be 4 now.
> >> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> >> Cc: Thomas Garnier <thgarnie@chromium.org>
> >> Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >> Cc: Kees Cook <keescook@chromium.org>
> > 
> > Reviewed-by: Juergen Gross <jgross@suse.com>
> > 
> > I think this patch should be taken even without the series.
> 
> It looks good to me, I am just not sure what the alignment is needed
> at all.
> 
> Why not to make the struct __packed (like struct alt_instr) and get rid
> of all the .align directives? Am I missing something?

Yes, making the struct __packed can save more space. If I understand
correctly, it could be done even without this patch but it may lead to
misaligned memory access. However, it seems to not matter as I didn't
find any related log for packing struct alt_instr. I can do such things
if needed.

Thanks.
