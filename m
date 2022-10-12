Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E35FC8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJLPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJLPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:53:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D3F253C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:53:47 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 124591EC0725;
        Wed, 12 Oct 2022 17:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665590021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n37CuGT72/BdjSCMX/SbC87AZ3K1N+NFaoL8bgbkin4=;
        b=nYK7i3NzdisKMQUmD20WD6kGnXBpnm+PARQn5OMi7eRiexD52OcFK/VHEWa8AAZnhtuEiE
        YFqI1WM7Rhb2wTxZkw8tC9l8+WEokLWEvabMA2JVIdzJv91y9b5zoG8/vjbSrZ1Gwf2pu6
        RXRQepIIFkz4H9wTBqQfxKMvc2/0dvk=
Date:   Wed, 12 Oct 2022 17:53:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        jailhouse-dev@googlegroups.com, xen-devel@lists.xenproject.org,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 1/2] x86: Check return values from early_memremap calls
Message-ID: <Y0bjBP6/Eyg8B25k@zn.tnic>
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
 <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
 <Y0GTUg1ACpKZYMHY@nazgul.tnic>
 <201850b3-5126-cd79-637f-79f198dd409d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201850b3-5126-cd79-637f-79f198dd409d@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:13:20AM -0400, Ross Philipson wrote:
> I am already using the pr_* macros in the patches. Are you asking me to do
> something

Yes. You do

pr_X("prefix_string: msg"

while you should set the prefix string and do

pr_X("msg".

As said, grep the tree for examples where pr_fmt() is set.
arch/x86/kernel/cpu/bugs.c is a good example.

> When I was working on the patches I asked Andrew Cooper at Citrix what
> action I should take if any of the calls in the Xen code failed. I
> believe he told me it was basically fatal and that panic() would be
> fine there.

Yes, that should be confirmed by people who know the code and you should
mention in the commit message at least that panicking is the only viable
thing to do in the respective case. If, as Jürgen says, it is actually
better to panic() in those cases, especially if it otherwise would make
debugging harder, then sure, by all means.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
