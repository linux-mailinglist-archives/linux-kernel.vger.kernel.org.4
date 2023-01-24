Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFCA6794C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjAXKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjAXKHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:07:21 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB73EC7B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:07:17 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id v5so17700284edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zHkweA6iYFq5hv3LlLMfnp5HhSGrGkvJmG6beL3iC4=;
        b=JPj/xZYLvB3WduU5dW/14nuDHkeHy+N/VzpCnWI+6Ylrm+mWvtgMjzQtHiVQy5amMr
         uhUHNBCPGLNCY76mG9QXKSoDQQKYJ5Ya0HgJRpn933Rm/Fuf/jSggILB2dYWA6vlz7Av
         Y/z6FtrXi9/1/aK50KXZjiXWVhQTFh7SbQ0mzWKYNrOflIuyjN8Iiti+FBh+VqlfRBw2
         0/qtkuyb81ucpNy1emxX8ufNrSqGBLigFhCETFByw+ts7RCsRdWl9KtzTLBPZIrBIWcR
         wnoB/AF6J/45EhIXy36EHmx0JvPDpVqTYM0Md1nyllyBBp5Y7TcZ2mAZWjHLesr4hNKO
         ur+Q==
X-Gm-Message-State: AFqh2kr6MMrjECgqTGr3WvSmYZyCUttwqPGjZKg1I3epW5UnBajGsEgC
        Aq/thBIZAV4TW1N4grdcIpk=
X-Google-Smtp-Source: AMrXdXvDYxqG0b9CPsfApoyf6KbrzAxGDXnis8L/DvXUEc/CNbqpJJAC1GfQBmAXWOolljbeMEt5Iw==
X-Received: by 2002:a05:6402:1cb2:b0:49e:f052:d9d3 with SMTP id cz18-20020a0564021cb200b0049ef052d9d3mr13193053edb.15.1674554835955;
        Tue, 24 Jan 2023 02:07:15 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id g12-20020a056402180c00b00499703df898sm834191edy.69.2023.01.24.02.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:07:15 -0800 (PST)
Message-ID: <30855835-d455-fbf0-ccb1-0bcaf5b9f622@kernel.org>
Date:   Tue, 24 Jan 2023 11:07:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] vc_screen: reload & check struct vc_data pointer in
 vcs_read() to avoid UAF
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1674514099-17696-1-git-send-email-george.kennedy@oracle.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1674514099-17696-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 01. 23, 23:48, George Kennedy wrote:
> After a call to console_unlock() in vcs_read() the vc_data struct can be
> freed by vc_deallocate(). Because of that, the struct vc_data pointer needs
> to be reloaded and checked for NULL to avoid the UAF below when vcs_size()
> is called.
> 
> Syzkaller reported a UAF in vcs_size().
> 
> BUG: KASAN: use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:215)
> Read of size 4 at addr ffff8881137479a8 by task 4a005ed81e27e65/1537

Could you trim the stack traces a bit, for example as follows?

> CPU: 0 PID: 1537 Comm: 4a005ed81e27e65 Not tainted 6.2.0-rc5 #1
> Hardware name: Red Hat KVM, BIOS 1.15.0-2.module
> Call Trace:
>   <TASK>
> __asan_report_load4_noabort (mm/kasan/report_generic.c:350)
> vcs_size (drivers/tty/vt/vc_screen.c:215)
> vcs_read (drivers/tty/vt/vc_screen.c:415)
> vfs_read (fs/read_write.c:468 fs/read_write.c:450)
> ...
>   </TASK>
> 
> Allocated by task 1191:
 > ...
 > kmalloc_trace (mm/slab_common.c:1069)
> vc_allocate (./include/linux/slab.h:580 ./include/linux/slab.h:720
>      drivers/tty/vt/vt.c:1128 drivers/tty/vt/vt.c:1108)
> con_install (drivers/tty/vt/vt.c:3383)
> tty_init_dev (drivers/tty/tty_io.c:1301 drivers/tty/tty_io.c:1413
>      drivers/tty/tty_io.c:1390)
> tty_open (drivers/tty/tty_io.c:2080 drivers/tty/tty_io.c:2126)
> chrdev_open (fs/char_dev.c:415)
> do_dentry_open (fs/open.c:883)
> vfs_open (fs/open.c:1014)
> ...
> 
> Freed by task 1548:
 > ...
> kfree (mm/slab_common.c:1021)
> vc_port_destruct (drivers/tty/vt/vt.c:1094)
> tty_port_destructor (drivers/tty/tty_port.c:296)
> tty_port_put (drivers/tty/tty_port.c:312)
> vt_disallocate_all (drivers/tty/vt/vt_ioctl.c:662 (discriminator 2))
> vt_ioctl (drivers/tty/vt/vt_ioctl.c:903)
> tty_ioctl (drivers/tty/tty_io.c:2776)
> ...
> 
> The buggy address belongs to the object at ffff888113747800
>   which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 424 bytes inside of
>   1024-byte region [ffff888113747800, ffff888113747c00)
> 
> The buggy address belongs to the physical page:
> page:00000000b3fe6c7c refcount:1 mapcount:0 mapping:0000000000000000
>      index:0x0 pfn:0x113740
> head:00000000b3fe6c7c order:3 compound_mapcount:0 subpages_mapcount:0
>      compound_pincount:0
> anon flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> raw: 0017ffffc0010200 ffff888100042dc0 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff888113747880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888113747900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888113747980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                    ^
>   ffff888113747a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888113747a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> Disabling lock debugging due to kernel taint
> 
> Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>   drivers/tty/vt/vc_screen.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index 1850bacdb5b0..efa4f14fc9c0 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -403,7 +403,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   		poll->event = 0;
>   	read = 0;
>   	ret = 0;
> -	while (count) {
> +	while (vc && count) {
>   		unsigned int this_round, skip = 0;
>   		int size;
>   
> @@ -465,9 +465,17 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   		pos += this_round;
>   		read += this_round;
>   		count -= this_round;
> +
> +		/* Reload if more to do. May have been freed by vc_deallocate()
> +		 * after console_unlock()
> +		 */
> +		if (count)
> +			vc = vcs_vc(inode, &viewed);
>   	}
>   	*ppos += read;
> -	if (read)
> +	if (!vc)
> +		ret = -ENXIO;

Wouldn't it make more sense to simply return from the loop immediately 
(goto unlock_out)? So that you wouldn't need to add vc to the while 
condition and the added 'if (count)' would contain also this 'if (!vc)?

> +	else if (read)
>   		ret = read;
>   unlock_out:
>   	console_unlock();

thanks,
-- 
js
suse labs

