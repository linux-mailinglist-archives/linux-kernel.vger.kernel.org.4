Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD860633BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiKVL6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiKVL6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:58:36 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB451D314
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:58:34 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so6951270iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKHuIGxqAbu0jbWetDr2gJPqWgLoOwSRyFaRwID8lBg=;
        b=wMgwQabm9tYbrUDaUsUQI2pHST7W1Fzc5bbxctW7N9DSSRcj8a6P7gRQMZbFxbnXfR
         PwVIa0ElHKWBHFpI5dEPPCHHYdzN9joiXn8R4dVC9h1dw/JZiceu0uYwYgsjmIlbR6SW
         XRZfFs71lBN3Xz2T15YjLI/yFYA6xarO4dyKx4ZmnfMWp7Xz0+kBUClhV3Z/eap2ymXo
         Kzs7dI3nQa2OYVsjphGqumhsqBoOZcmrvVB2MTXPiJoDXXa1dhOzF5btbXDWvBAbJx86
         oK63cQfT7aysS54eVArY7WmWhqLgoWJRzezs9poZaJmePL7lfydBa24YtWHsuY+0GDyH
         WrwQ==
X-Gm-Message-State: ANoB5pnsGKdavWZnGQOPQSF+VuP22EhSINVC0dmWKvnf9VNSnIONPC9d
        RytzeQ7oajrcynt9I1oxboFW9sIMDvVhUqOZwasx7iMRCC11
X-Google-Smtp-Source: AA0mqf6DSRgksgaHM7Q/sxhvjoS0Z4aD3ObeoOyf94fzhSEzd75C51ZmnaF7hmMFGaup//UPCMkUZ1dkhjgrz66uKaOHeMu0rom3
MIME-Version: 1.0
X-Received: by 2002:a92:d750:0:b0:302:4bf3:237d with SMTP id
 e16-20020a92d750000000b003024bf3237dmr1444453ilq.312.1669118314164; Tue, 22
 Nov 2022 03:58:34 -0800 (PST)
Date:   Tue, 22 Nov 2022 03:58:34 -0800
In-Reply-To: <55a7be14-6ebc-2ee8-34a2-98781b32e29c@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000343ab505ee0de486@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in expire_timers
From:   syzbot <syzbot+38ee3533e07da8749f85@syzkaller.appspotmail.com>
To:     liaoyu15@huawei.com
Cc:     arnd@arndb.de, catalin.marinas@arm.com, liaoyu15@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2022/11/22 2:35, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    b6e7fdfd6f6a Merge tag 'iommu-fixes-v6.1-rc5' of git://git..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11c28f95880000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=95fb379f123ba8ce
>> dashboard link: https://syzkaller.appspot.com/bug?extid=38ee3533e07da8749f85
>> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>
> Fix data race between virtual_ncidev_close() and virtual_ncidev_open().
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

This crash does not have a reproducer. I cannot test it.

> b6e7fdfd6f6a
>
> --- a/drivers/nfc/virtual_ncidev.c
> +++ b/drivers/nfc/virtual_ncidev.c
> @@ -161,12 +161,8 @@ static int virtual_ncidev_close(struct inode *inode,
> struct file *file)
>
>     if (state == virtual_ncidev_enabled) {
>         state = virtual_ncidev_disabling;
> -       mutex_unlock(&nci_mutex);
> -
>         nci_unregister_device(ndev);
>         nci_free_device(ndev);
> -
> -       mutex_lock(&nci_mutex);
>     }
>
>     state = virtual_ncidev_disabled;
> -- 
