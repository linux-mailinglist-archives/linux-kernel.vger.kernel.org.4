Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106796499C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiLLHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiLLHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:52:02 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B8EBC13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:52:00 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id e13so11650385edj.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPeFGUaHTJ1OHT1orz70mgQ9caGycjrR7/B9hb8U0NI=;
        b=wSliinrCvlOjgtY69QR3NB2pO5ZPon/z22nedK426HKF5VyPWTdhejpuyoQDCw5NzV
         6kFqXsNtswhXGmKQzVfweqKtsTKFtbK74Ip5/vd2/TJTs8JQdjfNiHIni0VmjAomOTR6
         QYW+ziwMR+wi1hncN1Hh+ReIhKDHV68wzLGRbghelmn2vD52a93NPCEnqOV/gP9+R2gq
         +0T5tf4fU1b8eTpskGdjWc8r2cmPA5eLU7KV01yxayo4sQnSSecNfgmJKIf9NqrHfuU/
         1Ri7pe+mBFFtidZZoGgDnfj5QdLZ8lMVwzhErtNLl1Mq9/yZDfx76xwi6+aOvAFXFzpF
         vwQA==
X-Gm-Message-State: ANoB5pmJ5wML1CvP8BnIY6/byVmwUEiYYAg94nTpt+F5HkkSJ0aIbMPv
        lUW/N2Zeovkw0MGwyK/5W2Ujrq6nUFE=
X-Google-Smtp-Source: AA0mqf4g7T1g7EW+SEhGd/iD0KZqZXnkKXtYG6+1kLQGySWhernduC9fbDyXV3mIp34XpoVagSK42w==
X-Received: by 2002:a05:6402:3895:b0:468:354a:4d6 with SMTP id fd21-20020a056402389500b00468354a04d6mr12087150edb.20.1670831519442;
        Sun, 11 Dec 2022 23:51:59 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id i10-20020a0564020f0a00b004678b543163sm3561107eda.0.2022.12.11.23.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 23:51:59 -0800 (PST)
Message-ID: <eb1ac914-3d1a-fa1e-fcc4-d82b8c45351d@kernel.org>
Date:   Mon, 12 Dec 2022 08:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] tty/vt: fix sleeping function called from invalid
 context in do_con_write()
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>, deller@gmx.de,
        gregkh@linuxfoundation.org, zhangxuezhi1@coolpad.com,
        ilpo.jarvinen@linux.intel.com, daniel.vetter@ffwll.ch,
        daniel.starke@siemens.com
Cc:     liwei391@huawei.com, linux-kernel@vger.kernel.org
References: <20221212023530.2498025-1-zengheng4@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221212023530.2498025-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 12. 22, 3:35, Zeng Heng wrote:
> Here is a BUG report from syzkaller:
> 
> BUG: sleeping function called from invalid context at kernel/printk/printk.c:2565
> 
> 3 locks held by mingetty/6405:
>   #0: ffff8881109b7098 (&tty->ldisc_sem){++++}-{0:0},
> 	at: tty_ldisc_ref_wait+0x22/0x80
>   #1: ffff8881109b7130 (&tty->atomic_write_lock){+.+.}-{3:3},
> 	at: file_tty_write.constprop.0+0x26f/0x8c0
>   #2: ffff8880147293e0 (&gsm->tx_lock){....}-{2:2},
> 	at: gsmld_write+0x5e/0x140
> 
> Call Trace:
>   __might_resched.cold+0x222/0x26b
>   console_lock+0x17/0x80
>   do_con_write+0x10f/0x1e30
>   con_write+0x21/0x40
>   gsmld_write+0xcb/0x140
>   file_tty_write.constprop.0+0x471/0x8c0
>   vfs_write+0x9ef/0xde0
>   ksys_write+0x127/0x250
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> And another bug report caused by the same reason is shown as below:
> 
> BUG: spinlock wrong CPU on CPU#2, mingetty/30460
>   lock: 0xffff8880340553c8, .magic: dead4ead, .owner: mingetty/30460, .owner_cpu: 1
> Call Trace:
>   dump_stack_lvl+0xcd/0x134
>   do_raw_spin_unlock+0x1af/0x230
>   _raw_spin_unlock_irqrestore+0x1e/0x70
>   gsmld_write+0xde/0x140
> 
> In gsmld_write(), in case of race condition, it would fetch the spin-lock
> and disable IRQ. But in the following trace, do_con_write() attempt to down
> semaphore which would probably cause re-schedule task and in further, IRQs
> woud be ignored for a quite time.

Wasn't this fixed in gsmld yet? In any case:

NACK

as it is wrong. This should be fixed in gsmld instead.

> Add if condition in do_con_write(). When the current task is in atomic
> context, return immediately.
> 
> Fixes: 32dd59f96924 ("tty: n_gsm: fix race condition in gsmld_write()")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>   drivers/tty/vt/vt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 981d2bfcf9a5..7662b6eb0836 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
>   	struct vt_notifier_param param;
>   	bool rescan;
>   
> -	if (in_interrupt())
> +	if (in_interrupt() || irqs_disabled())
>   		return count;
>   
>   	console_lock();
> @@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
>   {
>   	struct vc_data *vc;
>   
> -	if (in_interrupt())	/* from flush_to_ldisc */
> +	if (in_interrupt() || irqs_disabled())	/* from flush_to_ldisc */
>   		return;
>   
>   	/* if we race with con_close(), vt may be null */

-- 
js
suse labs

