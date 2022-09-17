Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9A5BB561
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiIQBr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIQBrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:47:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B0A261A;
        Fri, 16 Sep 2022 18:47:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so1398789pjk.4;
        Fri, 16 Sep 2022 18:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p4qLwPQbh2y3xerrbhSEmHTu5O5lnkqyFzO1RkekXek=;
        b=MPWkXn48PM0IzJIvCyzY9PfHGikAAuWK/FYuekd7Ag8JoaO1rkHfvtA78QJGZ2iLzS
         ijKNvuHRK7DHG2D4cQ9NpaKteLVmq1LaQZ6so9uO2pJfeWmoRgNiip40ONtsBpHTRT7L
         n5oH0iH0CJ3kWX0mZ9n8U3mBmt266B7mWeho35FDq2KARQAZipDJizTKndgLUym2wbq6
         r41PA2QcXPXQL8JAPuo80IJ/WQdUOU0ug+SAJKj9LrsEzfSO+uGuThwbBujnSPW81Hx5
         89eow/VH8YCcsJrqSVoSDfX8QlpdudEzrluH1J8SWlgvi6mGTtxoEKYrPbkV5rdXOCUi
         s5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p4qLwPQbh2y3xerrbhSEmHTu5O5lnkqyFzO1RkekXek=;
        b=7pdUvRSCEhvQ5J4aQYQuAipDZjrzcXAdFgJjUfW9bEpEf4z5tZeFim1l5pli4veGFx
         G+xGm6GniGCwWaIRTwOzBeYkDpo+xqZUldIEk6M01AJSl1XJRienMSDSMQnhNrPEP/Yz
         dkOSs3dSjYOumSmAVZObHNP90yjriXc6kAVCn0IOnROUhyvuWUaHZiDFTTFYSHBEjhGW
         FeL+I0pqbwo7Ard2QzNFc0ARjO3FXalCrrND8UCPbcCYXFdHBKtnqT89HVEVof9CO7Fj
         thWJpsEn5V0eLoK4Re1LlggTbOSozRaKXZ4aSOvZSE26kSLMn0XApP1L9A+cXG26Mg68
         wz3Q==
X-Gm-Message-State: ACrzQf3IOchfX+4gjEQoCD9d6MGaYuWOHPdxGSnTxzh/od/uQCwX1M7d
        ixPbB9z3TmJ+PcvCezQjTwo=
X-Google-Smtp-Source: AMsMyM4P9uyIwQ5pVUd4iSM3nWnuGI0wBkbfJ9XjQgRG6IdPdTtiqG0zu/bkTrBLrHQ7BjdG1s9T6w==
X-Received: by 2002:a17:902:720c:b0:172:a1ff:8c21 with SMTP id ba12-20020a170902720c00b00172a1ff8c21mr2530330plb.159.1663379272897;
        Fri, 16 Sep 2022 18:47:52 -0700 (PDT)
Received: from localhost ([36.112.182.114])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b0017824e7065fsm13712731plg.180.2022.09.16.18.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:47:52 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+e653e3f67251b6139aaa@syzkaller.appspotmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com,
        soenke.huster@eknoes.de, linux-bluetooth@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, 18801353760@163.com,
        yin31149@gmail.com
Subject: Re: [syzbot] BUG: corrupted list in kobject_add_internal (4)
Date:   Sat, 17 Sep 2022 09:47:40 +0800
Message-Id: <20220917014739.5624-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000008a7a3f05e8ad02f6@google.com>
References: <0000000000008a7a3f05e8ad02f6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 26 Aug 2022 08:27:06, AM Sönke Huster <soenke.huster@eknoes.de> wrote:
>Hi Luiz,
>
>On 25.08.22 20:58, Luiz Augusto von Dentz wrote:
>> Hi Sönke,
>> 
>> On Thu, Aug 25, 2022 at 8:08 AM Sönke Huster <soenke.huster@eknoes.de> wrote:
>>>
>>> Hi,
>>>
>>>
>>>
>>> While fuzzing I found several crashes similar to the following:
>>>
>>>
>>>         [    5.345731] sysfs: cannot create duplicate filename '/devices/virtual/bluetooth/hci0/hci0:0'
>>>
>>>         [...]
>>>
>>>         [    5.430464] BUG: KASAN: use-after-free in klist_add_tail+0x1bd/0x200
>>>
>>>         [    5.430464] Write of size 8 at addr ffff88800bfcc468 by task kworker/u3:1/43
>>>
>>>         [    5.430464]
>>>
>>>         [    5.430464] CPU: 0 PID: 43 Comm: kworker/u3:1 Not tainted 5.19.0-12855-g13f222680b8f #2
>>>
>>>         [    5.430464] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>>>
>>>         [    5.430464] Workqueue: hci0 hci_rx_work
>>>
>>>         [    5.430464] Call Trace:
>>>
>>>         [    5.430464]  <TASK>
>>>
>>>         [    5.430464]  dump_stack_lvl+0x45/0x5d
>>>
>>>         [    5.430464]  print_report.cold+0x5e/0x5e5
>>>
>>>         [    5.430464]  kasan_report+0xb1/0x1c0
>>>
>>>         [    5.430464]  klist_add_tail+0x1bd/0x200
>>>
>>>         [    5.430464]  device_add+0xa6b/0x1b80
>>>
>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
>>>
>>>         [    5.430464]  le_conn_complete_evt+0x117f/0x17d0
>>>
>>>         [    5.430464]  hci_le_conn_complete_evt+0x226/0x2c0
>>>
>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
>>>
>>>         [    5.430464]  hci_event_packet+0x636/0xf60
>>>
>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
>>>
>>>         [    5.430464]  process_one_work+0x8df/0x1530
>>>
>>>         [    5.430464]  worker_thread+0x575/0x11a0
>>>
>>>         [    5.430464]  kthread+0x29d/0x340
>>>
>>>         [    5.430464]  ret_from_fork+0x22/0x30
>>>
>>>         [    5.430464]  </TASK>
>>>
>>>         [    5.430464]
>>>
>>>         [    5.430464] Allocated by task 44:
>>>
>>>         [    5.430464]  kasan_save_stack+0x1e/0x40
>>>
>>>         [    5.430464]  __kasan_kmalloc+0x81/0xa0
>>>
>>>         [    5.430464]  device_add+0xcae/0x1b80
>>>
>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
>>>
>>>         [    5.430464]  le_conn_complete_evt+0x117f/0x17d0
>>>
>>>         [    5.430464]  hci_le_conn_complete_evt+0x226/0x2c0
>>>
>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
>>>
>>>         [    5.430464]  hci_event_packet+0x636/0xf60
>>>
>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
>>>
>>>         [    5.430464]  process_one_work+0x8df/0x1530
>>>
>>>         [    5.430464]  worker_thread+0x575/0x11a0
>>>
>>>         [    5.430464]  kthread+0x29d/0x340
>>>
>>>         [    5.430464]  ret_from_fork+0x22/0x30
>>>
>>>         [    5.430464]
>>>
>>>         [    5.430464] Freed by task 43:
>>>
>>>         [    5.430464]  kasan_save_stack+0x1e/0x40
>>>
>>>         [    5.430464]  kasan_set_track+0x21/0x30
>>>
>>>         [    5.430464]  kasan_set_free_info+0x20/0x40
>>>
>>>         [    5.430464]  __kasan_slab_free+0x108/0x190
>>>
>>>         [    5.430464]  kfree+0xa9/0x360
>>>
>>>         [    5.430464]  device_add+0x33a/0x1b80
>>>
>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
>>>
>>>         [    5.430464]  hci_le_cis_estabilished_evt+0x517/0xa70
>>>
>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
>>>
>>>         [    5.430464]  hci_event_packet+0x636/0xf60
>>>
>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
>>>
>>>         [    5.430464]  process_one_work+0x8df/0x1530
>>>
>>>         [    5.430464]  worker_thread+0x575/0x11a0
>>>
>>>         [    5.430464]  kthread+0x29d/0x340
>>>
>>>         [    5.430464]  ret_from_fork+0x22/0x30
>>>
>>>
>>>
>>> I think I fixed a similar issue in d5ebaa7c5f6f ("Bluetooth: hci_event: Ignore multiple conn complete events"). Here, the problem was that multiple connection complete events for the same handle called hci_conn_add_sysfs multiple times, but if it is called with an existing connection conn->dev->p is freed.
>>>
>>> This is because device_add is called - its documentation contains this sentence: "Do not call this routine or device_register() more than once for any device structure".
>>>
>>>
>>>
>>> This here is similar: First, an hci_le_conn_complete_evt creates a new connection.
>>>
>>> Afterwards, an hci_le_cis_estabilished_evt with the same handle finds that connection, and tries to add it to sysfs again, freeing conn->dev->p. Now, an event that might use that connection such as here the hci_le_conn_complete_evt triggers a use after free.
>>>

Syzkaller reports a bug as follows [1]:
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:33!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[...]
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 kobj_kset_join lib/kobject.c:164 [inline]
 kobject_add_internal+0x18f/0x8f0 lib/kobject.c:214
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:410
 device_add+0x368/0x1e90 drivers/base/core.c:3452
 hci_conn_add_sysfs+0x9b/0x1b0 net/bluetooth/hci_sysfs.c:53
 hci_le_cis_estabilished_evt+0x57c/0xae0 net/bluetooth/hci_event.c:6799
 hci_le_meta_evt+0x2b8/0x510 net/bluetooth/hci_event.c:7110
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x63d/0xfd0 net/bluetooth/hci_event.c:7495
 hci_rx_work+0xae7/0x1230 net/bluetooth/hci_core.c:4007
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

I think they are the same problems:
A hci_le_conn_complete_evt creates a new connection, and calls
hci_conn_add_sysfs(). Then hci_le_cis_estabilished_evt with the same handle
finds that connection, and will also calls hci_conn_add_sysfs(), which maybe
triggering corrupted list bug.

Link: https://syzkaller.appspot.com/bug?id=da3246e2d33afdb92d66bc166a0934c5b146404a [1]

>>>
>>>
>>> I bisected this bug and it was introduced with  26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections").
>>>
>>>
>>>
>>> The same happens with hci_le_create_big_complete_evt: Here, multiple events trigger the following bug:
>>>
>>>
>>>
>>>         [    6.898080] BUG: kernel NULL pointer dereference, address: 0000000000000058
>>>
>>>         [    6.898081] #PF: supervisor read access in kernel mode
>>>
>>>         [    6.898083] #PF: error_code(0x0000) - not-present page
>>>
>>>         [    6.898085] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>
>>>         [    6.898090] Workqueue: hci0 hci_rx_work
>>>
>>>         [    6.898092] RIP: 0010:klist_next+0x12/0x160
>>>
>>>         [    6.898128] Call Trace:
>>>
>>>         [    6.898129]  <TASK>
>>>
>>>         [    6.898130]  ? bt_link_release+0x20/0x20
>>>
>>>         [    6.898133]  device_find_child+0x37/0xa0
>>>
>>>         [    6.898136]  hci_conn_del_sysfs+0x71/0xa0
>>>
>>>         [    6.898138]  hci_conn_cleanup+0x17a/0x2c0
>>>
>>>         [    6.898141]  hci_conn_del+0x14a/0x240
>>>
>>>         [    6.898144]  hci_le_create_big_complete_evt+0x3d8/0x470
>>>
>>>         [    6.898146]  ? hci_le_remote_feat_complete_evt+0x3e0/0x3e0
>>>
>>>         [    6.898148]  hci_le_meta_evt+0x155/0x230
>>>
>>>         [    6.898150]  hci_event_packet+0x328/0x820
>>>
>>>         [    6.898152]  ? hci_conn_drop+0x100/0x100
>>>
>>>         [    6.898155]  hci_rx_work+0x725/0xb70
>>>
>>>         [    6.898157]  process_one_work+0x2a6/0x5d0
>>>
>>>         [    6.898160]  worker_thread+0x4a/0x3e0
>>>
>>>         [    6.898162]  ? process_one_work+0x5d0/0x5d0
>>>
>>>         [    6.898164]  kthread+0xed/0x120
>>>
>>>         [    6.898165]  ? kthread_complete_and_exit+0x20/0x20
>>>
>>>         [    6.898167]  ret_from_fork+0x22/0x30
>>>
>>>         [    6.898170]  </TASK>
>>>
>>>
>>>
>>> I bisected this bug and it was introduced with eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections").
>>>
>>>
>>>
>>> I am not really sure how to solve that. As far as I understand, previously we simply set an unused handle as connection handle, and checked for that before setting the correct handle and adding it to sysfs. But here, adding it to sysfs seems to happen in a different function and the handle is already set.
>> 
>> We should probably check if link-type, if it is an ISO link it shall
>> not be created via Connection Complete events and they have their own
>> events to create that.
>> 
>
>But then the problem of duplicate hci_le_cis_estabilished_evt / hci_le_create_big_complete_evt still exists, isn't it? For example if the connection is created through a hci_le_cis_req_evt, and afterwards two hci_le_cis_estabilished_evt arrive, the second event calls hci_conn_add_sysfs a second time which frees parts of the device structure.
>
>>> Best
>>> Sönke
I wonder that if we need both two patches? Because they
seems to be used to patch different bugs?
