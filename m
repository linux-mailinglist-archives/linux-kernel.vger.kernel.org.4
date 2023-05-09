Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04D6FC8B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjEIOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjEIOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232E198
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6C662DDD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0EBC4339B;
        Tue,  9 May 2023 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683641911;
        bh=FgcLdJUu6stLQ0xpuvit88CceYDhfEW12tIoP9y3M0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ro98zdmyVGQHMTLoHsCjKyjsoiXWZetDmV/4qkZfcBNyK+hwUZU+P0QXXBxfvK2bb
         vsQKr1pzKj90sbuMDxhRHj1ZRTYCybkCAsL/EOdbjqd5tRdq1R+0KuZPyWGhXwH9hN
         W3OYhEseqFiKKij2WMb6klzOzdsxqycNitDFsGqD4oxBkLPBKggFKYksaOAeSzVsIu
         V1y1ePbgh1LDTBADAS+rQR0gdRc6WfLckoy9D52cey6z1npiExIBvgOKuTg426aQWu
         e2/FXsmV8QU/VZAvX5wAQYMeC2lrPiTvzpOszTDhII5H0kbKtiWeK+kiguPTN8rtEt
         Hq+ZCp+G1s77g==
Date:   Tue, 9 May 2023 16:18:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit is
 valid
Message-ID: <ZFpWNIoTo9FfO2t5@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de>
 <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx>
 <87v8h62vwp.ffs@tglx>
 <ZFoVg9UmItpIaA69@lothringen>
 <877cth1xyd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cth1xyd.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 02:38:50PM +0200, Thomas Gleixner wrote:
> On Tue, May 09 2023 at 11:42, Frederic Weisbecker wrote:
> > On Sat, May 06, 2023 at 01:36:22AM +0200, Thomas Gleixner wrote:
> >> Unless you think about the theoretical case of an unlimited number of
> >> threads sharing the signal_struct which all concurrently try to allocate
> >> a timer id and then releasing it immediately again (to avoid resource
> >> limit exhaustion). Theoretically possible, but is this a real concern
> >> with a timer ID space of 2G?
> >
> > I didn't go that far actually, it was just me misunderstanding that loop and
> > especially the (id =~start) part. Now I got it.
> >
> > I guess the for statement can just be:
> >
> > for (; start != id; id++)
> 
> My brain based compiler complains about uninitialized usage of @id. I'm
> pretty sure it's rightfully complaining and a real compiler would agree,
> no?

*sigh* I should think more before pressing answer these days :)
