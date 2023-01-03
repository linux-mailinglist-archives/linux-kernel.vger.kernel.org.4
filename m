Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9D65C204
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjACOei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjACOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:34:33 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6725EE27
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QMZBZ22IGBh45Cf/NuWC5djX29Cio7BfdtoICqFLw8c=; b=vzoZM0xwgbok6IYxVXqs12zdCr
        TuabIQ9nU3oiOJcpn9227fxmFE4ePZADHDcPzbXP9D4grvwld0YCZER64IK63BKVAL5Nri8yfouF5
        UozlfO+LfJiiOOCzwcuhQ0Ps85nz22Bii8JwmXzQW8TZ8xzxRI145iD+s2S50qh/ed/fZsjfhukqA
        84NvaCAM9zCsi2EUdYd+esPEM1WXtvVCvi15lC30pD97myua40DT4pM/82lz/YSb781nVP3v28Qts
        C5hg2a5MKZeQNYrm7Z+LdV3NhgU71wYvzsi2WgPF14ceGCYvTa6HYqdghaNekCBRPW2nt7hPI1NMv
        60ptpCyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35932)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pCiN2-0005QQ-2I; Tue, 03 Jan 2023 14:34:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pCiMz-00028E-7l; Tue, 03 Jan 2023 14:34:25 +0000
Date:   Tue, 3 Jan 2023 14:34:25 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hui Tang <tanghui20@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug-report] possible performance problem in ret_to_user_from_irq
Message-ID: <Y7Q88aBpxfWRqzTe@shell.armlinux.org.uk>
References: <7ecb8f3c-2aeb-a905-0d4a-aa768b9649b5@huawei.com>
 <Y7P+MjPNA6Tg8JBr@shell.armlinux.org.uk>
 <50a5ebdb-4107-26cc-a2f6-da551d99ff38@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a5ebdb-4107-26cc-a2f6-da551d99ff38@kernel.dk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 07:25:26AM -0700, Jens Axboe wrote:
> On 1/3/23 3:06?AM, Russell King (Oracle) wrote:
> > On Mon, Dec 26, 2022 at 04:45:20PM +0800, Hui Tang wrote:
> >> hi folks.
> >>
> >> I found a performance problem which is introduced by commit
> >> 32d59773da38 ("arm: add support for TIF_NOTIFY_SIGNAL").
> >> After the commit,  any bit in the range of 0..15 will cause
> >> do_work_pending() to be invoked. More frequent do_work_pending()
> >> invoked possible result in worse performance.
> >>
> >> Some of the tests I've done? as follows:
> >> lmbench test			base		with patch
> >> ./lat_ctx -P 1 -s 0  2		7.3167		11.04
> >> ./lat_ctx -P 1 -s 16 2          8.0467		14.5367
> >> ./lat_ctx -P 1 -s 64 2		7.8667		11.43
> >> ./lat_ctx -P 1 -s 16 16		16.47		18.3667
> >> ./lat_pipe -P 1			28.1671		44.7904
> >>
> >> libMicro-0.4.1 test		base		with patch
> >> ./cascade_cond -E -C 200\
> >>  -L -S -W -N "c_cond_1" -I 100	286.3333	358
> >>
> >> When I adjust test bit, the performance problem gone.
> >> -	movs	r1, r1, lsl #16
> >> +	ldr	r2, =#_TIF_WORK_MASK
> >> +	tst	r1, r2
> >>
> >> Does anyone have a good suggestion for this problem?
> >> should just test _TIF_WORK_MASK, as before?
> > 
> > I think it should be fine - but I would suggest re-organising the
> > TIF definitions so that those TIF bits that shouldn't trigger
> > do_work_pending are not in the first 16 bits.
> > 
> > Note that all four bits in _TIF_SYSCALL_WORK need to stay within
> > an 8-bit even-bit-aligned range, so the value is suitable for an
> > immediate assembly constant.
> > 
> > I'd suggest moving the TIF definitions for 20 to 19, and 4..7 to
> > 20..23, and then 8 to 4.
> 
> Like this?
> 
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index aecc403b2880..7f092cb55a41 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -128,15 +128,16 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>  #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
>  #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
>  #define TIF_UPROBE		3	/* breakpointed or singlestepping */
> -#define TIF_SYSCALL_TRACE	4	/* syscall trace active */
> -#define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
> -#define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
> -#define TIF_SECCOMP		7	/* seccomp syscall filtering active */
> -#define TIF_NOTIFY_SIGNAL	8	/* signal notifications exist */
> +#define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
>  
>  #define TIF_USING_IWMMXT	17
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
> -#define TIF_RESTORE_SIGMASK	20
> +#define TIF_RESTORE_SIGMASK	19
> +#define TIF_SYSCALL_TRACE	20	/* syscall trace active */
> +#define TIF_SYSCALL_AUDIT	21	/* syscall auditing active */
> +#define TIF_SYSCALL_TRACEPOINT	22	/* syscall tracepoint instrumentation */
> +#define TIF_SECCOMP		23	/* seccomp syscall filtering active */
> +
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)

Yep, LGTM, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
