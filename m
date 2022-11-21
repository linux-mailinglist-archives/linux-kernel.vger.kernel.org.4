Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67987632E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKUVKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiKUVJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:09:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA9CB9D6;
        Mon, 21 Nov 2022 13:09:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8809D612AE;
        Mon, 21 Nov 2022 21:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA0DC433C1;
        Mon, 21 Nov 2022 21:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669064978;
        bh=iYLn0Rig1qnVDn1eNpU4htq4bgiZs6XfxjVqB3e5tBI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=I4+qHnATIh2cfI7HN46Mwj957qIlezDd7DRJLg2MOnzqPoyHWIUgB2U0On37uqh3k
         1z1dJO/oFU2lFF1tQhTWmDVB7vXK++O3pW2WRnaOuSHclp8uu1EgAkAP+NRr6FTMY6
         wrALwL2fSiOND/VaR5LEnPtZjmCKZPX99XPXUbgVQMQ3YaSN4ZHORVOOTXW0suZo+g
         H3nnF5VWRtpuWB7uBMSNO/LjIZgLKJW1ASbx3TvPgvtKIFwEv2NRVnlx6xRKxY7/mM
         b9LIoH9eQZNYMpF057ufF2aidhuikmZmfDTHlzM+OP9Ns1td3DJ0WQ+EA83B8QgrXK
         6PcK3c/vVZKAQ==
Date:   Mon, 21 Nov 2022 22:09:35 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
cc:     benjamin.tissoires@redhat.com, gregkh@suse.de, marcel@holtmann.org,
        rdunlap@infradead.org, jirislaby@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+8b1641d2f14732407e23@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: core: fix shift-out-of-bounds in
 hid_report_raw_event
In-Reply-To: <20221116071428.191437-1-zhangpeng362@huawei.com>
Message-ID: <nycvar.YFH.7.76.2211212209240.6045@cbobk.fhfr.pm>
References: <20221116071428.191437-1-zhangpeng362@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022, Peng Zhang wrote:

> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Syzbot reported shift-out-of-bounds in hid_report_raw_event.
> 
> microsoft 0003:045E:07DA.0001: hid_field_extract() called with n (128) >
> 32! (swapper/0)
> ======================================================================
> UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:1323:20
> shift exponent 127 is too large for 32-bit type 'int'
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.1.0-rc4-syzkaller-00159-g4bbf3422df78 #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS
> Google 10/26/2022
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:151 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x3a6/0x420 lib/ubsan.c:322
>  snto32 drivers/hid/hid-core.c:1323 [inline]
>  hid_input_fetch_field drivers/hid/hid-core.c:1572 [inline]
>  hid_process_report drivers/hid/hid-core.c:1665 [inline]
>  hid_report_raw_event+0xd56/0x18b0 drivers/hid/hid-core.c:1998
>  hid_input_report+0x408/0x4f0 drivers/hid/hid-core.c:2066
>  hid_irq_in+0x459/0x690 drivers/hid/usbhid/hid-core.c:284
>  __usb_hcd_giveback_urb+0x369/0x530 drivers/usb/core/hcd.c:1671
>  dummy_timer+0x86b/0x3110 drivers/usb/gadget/udc/dummy_hcd.c:1988
>  call_timer_fn+0xf5/0x210 kernel/time/timer.c:1474
>  expire_timers kernel/time/timer.c:1519 [inline]
>  __run_timers+0x76a/0x980 kernel/time/timer.c:1790
>  run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1803
>  __do_softirq+0x277/0x75b kernel/softirq.c:571
>  __irq_exit_rcu+0xec/0x170 kernel/softirq.c:650
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
>  sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1107
> ======================================================================
> 
> If the size of the integer (unsigned n) is bigger than 32 in snto32(),
> shift exponent will be too large for 32-bit type 'int', resulting in a
> shift-out-of-bounds bug.
> Fix this by adding a check on the size of the integer (unsigned n) in
> snto32(). To add support for n greater than 32 bits, set n to 32, if n
> is greater than 32.
> 
> Reported-by: syzbot+8b1641d2f14732407e23@syzkaller.appspotmail.com
> Fixes: dde5845a529f ("[PATCH] Generic HID layer - code split")
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>  drivers/hid/hid-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9c1d31f63f85..bd47628da6be 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1315,6 +1315,9 @@ static s32 snto32(__u32 value, unsigned n)
>  	if (!value || !n)
>  		return 0;
>  
> +	if (n > 32)
> +		n = 32;
> +
>  	switch (n) {
>  	case 8:  return ((__s8)value);

Applied, thanks for fixing this.

-- 
Jiri Kosina
SUSE Labs

