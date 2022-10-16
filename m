Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1204E5FFE90
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJPKAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJPKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:00:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD0BBF;
        Sun, 16 Oct 2022 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MKqPgF/XFYs2KR3+OAXr1sj0GArXfpzBxS1AoP5GxUo=; b=DJABaRRvmQEnDFynyXCeEj/sjN
        /j5KIIJiRVycHSB7SGXnkdoRURZJvrFHmjS+B3qbQ5fm5NKxMTiaZxBO0QUnpd+ZI+gewcQZxz08C
        j26Cp0G6BEy/xRS7hI2f9zNQ+iPfmz+jVdD5xnkuNtGqz/76cezsGJINJOURVE8krwo7FGThRlUbN
        Idg+qr0H6aWazInFEPSLqolo0YP7uPmXUmhm0HlhZ4iYy5xXGHscCpdAVt0W09Nl0o7t1Cw80PLxI
        RgPpnplPAaXVl6Fhsoif+L/E/PSgoDTgpvIlU3k+bGFrns5Y1Njy8j3K5h1FuAdRH3IQX1VBhECB/
        1LPJtIUA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ok0R2-0090yT-A7; Sun, 16 Oct 2022 09:59:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3D84300110;
        Sun, 16 Oct 2022 11:59:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39B812024B7CA; Sun, 16 Oct 2022 11:59:49 +0200 (CEST)
Date:   Sun, 16 Oct 2022 11:59:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arjan <8vvbbqzo567a@nospam.xutrox.com>
Cc:     Cody Yao-oc <CodyYao-oc@zhaoxin.com>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, shyaololo@163.com
Subject: Re: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
Message-ID: <Y0vWFXQ2vLBaM3Ki@hirez.programming.kicks-ass.net>
References: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
 <Y0gpsTiUqa/ZbvRh@hirez.programming.kicks-ass.net>
 <b38ecb38-2709-0c75-fe08-375dd4a87d5f@nospam.xutrox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38ecb38-2709-0c75-fe08-375dd4a87d5f@nospam.xutrox.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 11:53:14AM +0200, Arjan wrote:
> On 13-10-2022 17:07, Peter Zijlstra wrote:
> > On Mon, Jun 07, 2021 at 09:31:09AM +0800, Cody Yao-oc wrote:
> > > From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> > > 
> > > Nano processor may not fully support rdpmc instruction, it works well
> > > for reading general pmc counter, but will lead to GP(general protection)
> > > when accessing fixed pmc counter. Futhermore, family/model information
> > > is same between Nano processor and ZX-C processor, it leads to zhaoxin
> > > pmu driver is wrongly loaded for Nano processor, which resulting boot
> > > kernal fail.
> > > 
> > > To solve this problem, stepping information will be checked to distinguish
> > > between Nano processor and ZX-C processor.
> > > 
> > > [https://bugzilla.kernel.org/show_bug.cgi?id=212389]
> > > 
> > > Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
> > > Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> > 
> > *sigh*.. so this email address doesn't exist, as such I can't apply this
> > patch. Consider it dropped.
> 
> If it's about my email address: The address exists and works.
> If the nospam part bothers you, that part can be left out. You may leave the reported-by line out if you want to.

The SoB address (CodyYao-oc@zhaoxin.com) bounced for me -- since that's
the patch author that is somewhat important.
