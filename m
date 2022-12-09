Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F8647E65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLIHR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLIHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:17:53 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8971AA11;
        Thu,  8 Dec 2022 23:17:50 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id bx10so4317784wrb.0;
        Thu, 08 Dec 2022 23:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+yITXud0X/ZAcTv3o4ks1/uA+y77wuhRyG/xgZE2LM=;
        b=ztZK5WJ4fFy9wb0115QUvY9u51YgPPp4QrC1Xj+InENdHtda5WpUBYHnWCs6RF35vm
         WwL7P0znonO9525UUJ/DtwN6A8634q97mXiQl/XtyEaN+MfpGR73bUW8Yh2tAwa+j5jm
         /ReCa7oJnKBQLrl90/Y8W3k4+57m9VfwsFZpNpMGXPmDYC1BiMuJbwAGrwIYyOCWuTD4
         GT67Nyxhr3HH79pC5lt5F8V+Tro3l7Cx0qXld/nD+RpjS62Zr6gkCyoxDwbE81dlI61p
         VB7oyDoKNbzSNnbtJrDIwUT0PzBHguGuJ6kqOq+zaCaldzTlaTqfz3pfVw8WP5LDCEFu
         xlEw==
X-Gm-Message-State: ANoB5pnCjXugRC+TKSbwgfCyD5xt7EU70Eul9aVghThIYSHe/TDftwnf
        p5fXH0bFvaVTBuZYZffj6mQ=
X-Google-Smtp-Source: AA0mqf7KNUQWA1LeH8AdJxZntwBQ9+UtMRooxbZdwDVjn6ZA9ejUX6pZ6aMDIfnKejffcCVHUgsWxg==
X-Received: by 2002:a5d:6f15:0:b0:242:bef:80a1 with SMTP id ay21-20020a5d6f15000000b002420bef80a1mr4943379wrb.2.1670570268813;
        Thu, 08 Dec 2022 23:17:48 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0023657e1b980sm615350wri.53.2022.12.08.23.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 23:17:48 -0800 (PST)
Message-ID: <6614f5d2-d99b-ea8a-f660-7a3433499a9f@kernel.org>
Date:   Fri, 9 Dec 2022 08:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] tty: fix out-of-bounds access in
 tty_driver_lookup_tty()
Content-Language: en-US
To:     Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20221207075236.23171-1-svens@linux.ibm.com>
 <20221207075236.23171-2-svens@linux.ibm.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221207075236.23171-2-svens@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 12. 22, 8:52, Sven Schnelle wrote:
> When specifying an invalid console= device like console=tty3270,
> tty_driver_lookup_tty() returns the tty struct without checking
> whether index is a valid number.
> 
> To reproduce:
> 
> qemu-system-x86_64 -enable-kvm -nographic -serial mon:stdio \
> -kernel ../linux-build-x86/arch/x86/boot/bzImage \
> -append "console=ttyS0 console=tty3270"
> 
> This crashes with:
> 
> [    0.748921]   No soundcards found.
> [    0.749293] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [    0.750125] cfg80211: failed to load regulatory.db
> [    0.750611] ------------[ cut here ]------------
> [    0.751100] refcount_t: saturated; leaking memory.
> [    0.751603] WARNING: CPU: 0 PID: 1 at lib/refcount.c:22 refcount_warn_saturate+0x51/0x110
> [    0.752438] Modules linked in:
> [    0.752772] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc7-00194-gc911e8eba40a-dirty #15
> [    0.753609] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-2.fc37 04/01/2014
> [..]
> [    0.763352] Call Trace:
> [    0.763648]  <TASK>
> [    0.763907]  tty_open+0x5be/0x6f0
> [    0.764304]  chrdev_open+0xbd/0x230
> [    0.764694]  ? cdev_device_add+0x80/0x80
> [    0.765217]  do_dentry_open+0x1e0/0x410
> [    0.765719]  path_openat+0xca9/0x1050
> [    0.766224]  do_filp_open+0xaa/0x150
> [    0.766694]  file_open_name+0x133/0x1b0
> [    0.767260]  filp_open+0x27/0x50
> [    0.767674]  console_on_rootfs+0x14/0x4d
> [    0.768189]  kernel_init_freeable+0x1e4/0x20d
> [    0.768726]  ? rest_init+0xc0/0xc0
> [    0.769108]  kernel_init+0x11/0x120
> [    0.769480]  ret_from_fork+0x22/0x30
> [    0.769863]  </TASK>
> [    0.770128] ---[ end trace 0000000000000000 ]---
> [    0.770599] BUG: kernel NULL pointer dereference, address: 00000000000000ef
> [    0.771265] #PF: supervisor read access in kernel mode
> [    0.771773] #PF: error_code(0x0000) - not-present page
> [    0.772311] PGD 0 P4D 0·
> [    0.772609] Oops: 0000 [#1] PREEMPT SMP PTI
> [    0.773066] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.1.0-rc7-00194-gc911e8eba40a-dirty #15
> [    0.774027] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-2.fc37 04/01/2014
> [    0.774878] RIP: 0010:tty_open+0x268/0x6f0
> [..]
> [    0.783386] Call Trace:
> [    0.783715]  <TASK>
> [    0.784013]  chrdev_open+0xbd/0x230
> [    0.784444]  ? cdev_device_add+0x80/0x80
> [    0.784920]  do_dentry_open+0x1e0/0x410
> [    0.785389]  path_openat+0xca9/0x1050
> [    0.785813]  do_filp_open+0xaa/0x150
> [    0.786240]  file_open_name+0x133/0x1b0
> [    0.786746]  filp_open+0x27/0x50
> [    0.787244]  console_on_rootfs+0x14/0x4d
> [    0.787800]  kernel_init_freeable+0x1e4/0x20d
> [    0.788383]  ? rest_init+0xc0/0xc0
> [    0.788881]  kernel_init+0x11/0x120
> [    0.789356]  ret_from_fork+0x22/0x30
> [    0.789842]  </TASK>
> [    0.790163] Modules linked in:
> [    0.790502] CR2: 00000000000000ef
> [    0.790861] ---[ end trace 0000000000000000 ]---
> [    0.791332] RIP: 0010:tty_open+0x268/0x6f0
> [..]
> [    0.799648] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> [    0.800479] Kernel Offset: 0x10400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    0.801534] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Yes, this makes sense as a sanity check for all drivers. But I would 
_also_ disallow registering such a console in vt:
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3075,6 +3075,11 @@ int vt_kmsg_redirect(int new)
   * The console must be locked when we get here.
   */

+static int vt_console_setup(struct console *co, char *options)
+{
+       return co->index >= MAX_NR_CONSOLES ? -EINVAL : 0;
+}
+
  static void vt_console_print(struct console *co, const char *b, 
unsigned count)
  {
         struct vc_data *vc = vc_cons[fg_console].d;
@@ -3158,6 +3163,7 @@ static struct tty_driver *vt_console_device(struct 
console *c, int *index)

  static struct console vt_console_driver = {
         .name           = "tty",
+       .setup          = vt_console_setup,
         .write          = vt_console_print,
         .device         = vt_console_device,
         .unblank        = unblank_screen,

That means dmesg would say:
   Console: colour dummy device 80x25
   printk: console [ttyS0] enabled

And not:
   Console: colour dummy device 80x25
   printk: console [tty3270] enabled
   printk: console [ttyS0] enabled

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>   drivers/tty/tty_io.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index de06c3c2ff70..1ac6784ea1f9 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1224,14 +1224,16 @@ static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
>   {
>   	struct tty_struct *tty;
>   
> -	if (driver->ops->lookup)
> +	if (driver->ops->lookup) {
>   		if (!file)
>   			tty = ERR_PTR(-EIO);
>   		else
>   			tty = driver->ops->lookup(driver, file, idx);
> -	else
> +	} else {
> +		if (idx >= driver->num)
> +			return ERR_PTR(-EINVAL);
>   		tty = driver->ttys[idx];
> -
> +	}
>   	if (!IS_ERR(tty))
>   		tty_kref_get(tty);
>   	return tty;

thanks,
-- 
js
suse labs

