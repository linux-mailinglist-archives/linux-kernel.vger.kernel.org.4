Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0165BDA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbjACKHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbjACKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:06:49 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096B12A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4coSDhKU7mwRMnUBHyZf53rh/zHTShyJKZjrQJqxxZQ=; b=B12V0JeslL/XIkP4Z0lltsBBWc
        tZfAKB3JMY2U5lPpdVnMCkPvGczQgL1+b/2r2g+EqYedCqWcm8B0KryJnEicwXfHgzJY2masjoF5G
        Fkj2Sv1EeyWY8ckdQ5TCl7O8l3OP4iNffTqkUi6KUhBMCvW0FbKMQSnEDX27CEHgggGkBn/sFB4zc
        iBhIdqNwZ7QDp4Um4klM1db2XMzsCGv08GUDglexnqvEah9iKrNEu+TWfamME0iqX5IP9ARs9HRS+
        n3CEWveF+U3eDsbkiovi2+ebb4u1rwhW1/okbMbLc9ywBwOLdm1Jyize/tnfpw16eebMsnaDUdpRS
        ZqBUObGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35908)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pCeBw-0005Bw-TV; Tue, 03 Jan 2023 10:06:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pCeBu-0001xj-1a; Tue, 03 Jan 2023 10:06:42 +0000
Date:   Tue, 3 Jan 2023 10:06:42 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug-report] possible performance problem in ret_to_user_from_irq
Message-ID: <Y7P+MjPNA6Tg8JBr@shell.armlinux.org.uk>
References: <7ecb8f3c-2aeb-a905-0d4a-aa768b9649b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ecb8f3c-2aeb-a905-0d4a-aa768b9649b5@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 04:45:20PM +0800, Hui Tang wrote:
> hi folks.
> 
> I found a performance problem which is introduced by commit
> 32d59773da38 ("arm: add support for TIF_NOTIFY_SIGNAL").
> After the commit,  any bit in the range of 0..15 will cause
> do_work_pending() to be invoked. More frequent do_work_pending()
> invoked possible result in worse performance.
> 
> Some of the tests I've done， as follows:
> lmbench test			base		with patch
> ./lat_ctx -P 1 -s 0  2		7.3167		11.04
> ./lat_ctx -P 1 -s 16 2          8.0467		14.5367
> ./lat_ctx -P 1 -s 64 2		7.8667		11.43
> ./lat_ctx -P 1 -s 16 16		16.47		18.3667
> ./lat_pipe -P 1			28.1671		44.7904
> 
> libMicro-0.4.1 test		base		with patch
> ./cascade_cond -E -C 200\
>  -L -S -W -N "c_cond_1" -I 100	286.3333	358
> 
> When I adjust test bit, the performance problem gone.
> -	movs	r1, r1, lsl #16
> +	ldr	r2, =#_TIF_WORK_MASK
> +	tst	r1, r2
> 
> Does anyone have a good suggestion for this problem?
> should just test _TIF_WORK_MASK, as before?

I think it should be fine - but I would suggest re-organising the
TIF definitions so that those TIF bits that shouldn't trigger
do_work_pending are not in the first 16 bits.

Note that all four bits in _TIF_SYSCALL_WORK need to stay within
an 8-bit even-bit-aligned range, so the value is suitable for an
immediate assembly constant.

I'd suggest moving the TIF definitions for 20 to 19, and 4..7 to
20..23, and then 8 to 4.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
