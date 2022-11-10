Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57C623D14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiKJIDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiKJIDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40702BB2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668067329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+9i8OhydFba5DJ5WEoqEn0GpBo7XQiRyZXUoAQZSKXw=;
        b=CGQCdFOsLs7Gq8Huj1RYR0RosR63UiNIea54pQf926P9jV9IyRiDjQPdLhjj7FB4Micequ
        HFa55hAp255yVM2JSV07gIcULRgAy3EE+IjQgj8FkQWzUqMd+1II9A2TVK1a5QWArr+TcZ
        mRbX3LqLfG9r1P9gGQNrHk73PacU3ik=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-JT59ReYLMfaQmPNZnTJezg-1; Thu, 10 Nov 2022 03:02:08 -0500
X-MC-Unique: JT59ReYLMfaQmPNZnTJezg-1
Received: by mail-pg1-f199.google.com with SMTP id x23-20020a634857000000b0043c700f6441so622171pgk.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9i8OhydFba5DJ5WEoqEn0GpBo7XQiRyZXUoAQZSKXw=;
        b=dNntNze+hEs8LKubPaqCq3q6I2Ql9sIS9NmqKxCZvjUG7eTdexn4P6laqIvOLS2Twm
         wvD7yz3hGguo5bh8yCDnnG7cIJjRmwAF8eBkBZTYTgOIQx/wB9zjG1gyn93FBCWJoWZO
         fHmLfVj39f+OukhfgjEm7h149KeHddPQfIjJpkXIHVYL4wTcpKRzjKT7u6g5cewB6KDo
         XyNhXikw43MQPpWPEYiDpaKP6AYOdXXouIc3eRkmCCL4x8K3SEAk7qYsw2jCg90tD1Lz
         1B06nMwxzPE/AoZmoll4gVc/0oMMbO7iQll5CzmONaX7UuS19Y4O+GRfgiDzuBniryLZ
         VgZA==
X-Gm-Message-State: ACrzQf1f0IqdYx3dF2kc5UGdseuS5aBjkjYC8Efn/rG284MxJz/VRhkk
        cWZfanA1tI5k+SKZy7TQSUuMt1FhS+G+XJrRQ7n2/7mJCqdJjAbpRvVfD2O5M8b5ZyBp+L/l0po
        syQmpHNvgRjnMp3F/9scUMWyO
X-Received: by 2002:a05:6a00:16c1:b0:563:177f:99ee with SMTP id l1-20020a056a0016c100b00563177f99eemr64280779pfc.7.1668067325731;
        Thu, 10 Nov 2022 00:02:05 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5yslBGXty4dTanvbKMrVsTvIZV2WFd1TRSIO+dOGiek5G+4D1x1sy9QxNs7SJbmVNIyKMaXA==
X-Received: by 2002:a05:6a00:16c1:b0:563:177f:99ee with SMTP id l1-20020a056a0016c100b00563177f99eemr64280762pfc.7.1668067325347;
        Thu, 10 Nov 2022 00:02:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902da8c00b0017eb2d62bbesm10572248plx.99.2022.11.10.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 00:02:04 -0800 (PST)
Date:   Thu, 10 Nov 2022 09:01:47 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        gautam.dawar@xilinx.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vdpa_sim: fix possible memory leak in
 vdpasim_net_init() and vdpasim_blk_init()
Message-ID: <20221110080147.bpfumiab2yt7nehf@sgarzare-redhat>
References: <20221110050446.3932031-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221110050446.3932031-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 10, 2022 at 01:04:46PM +0800, ruanjinjie wrote:
>Inject fault while probing module, if device_register() fails in
>vdpasim_net_init() or vdpasim_blk_init(), but the refcount of kobject is
>not decreased to 0, the name allocated in dev_set_name() is leaked.
>Fix this by calling put_device(), so that name can be freed in
>callback function kobject_cleanup().
>
>(vdpa_sim_net)
>unreferenced object 0xffff88807eebc370 (size 16):
>  comm "modprobe", pid 3848, jiffies 4362982860 (age 18.153s)
>  hex dump (first 16 bytes):
>    76 64 70 61 73 69 6d 5f 6e 65 74 00 6b 6b 6b a5  vdpasim_net.kkk.
>  backtrace:
>    [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>    [<ffffffff81731d53>] kstrdup+0x33/0x60
>    [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>    [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>    [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>    [<ffffffffa0270013>] 0xffffffffa0270013
>    [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>    [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>    [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>    [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>    [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>    [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
>(vdpa_sim_blk)
>unreferenced object 0xffff8881070c1250 (size 16):
>  comm "modprobe", pid 6844, jiffies 4364069319 (age 17.572s)
>  hex dump (first 16 bytes):
>    76 64 70 61 73 69 6d 5f 62 6c 6b 00 6b 6b 6b a5  vdpasim_blk.kkk.
>  backtrace:
>    [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>    [<ffffffff81731d53>] kstrdup+0x33/0x60
>    [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>    [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>    [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>    [<ffffffffa0220013>] 0xffffffffa0220013
>    [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>    [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>    [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>    [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>    [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>    [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
>Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>---
>v2:
>- add fault inject message
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 4 +++-
> 2 files changed, 6 insertions(+), 2 deletions(-)

Thanks for the v2 of this patch!
It LGTM, just a couple of comments about the submit process.

Usually when you get A-b R-b's and the patch doesn't change, it's better 
to bring them in later versions.

Also, we had suggested reporting the Fixes tag, because usually when we 
fix a bug it's good to identify which patch introduced the problem, so 
it's easier to backport this fix into stable versions of the kernel.
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes

In this case we should use the following tags:

Fixes: 899c4d187f6a ("vdpa_sim_blk: add support for vdpa management tool")
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

With them:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

