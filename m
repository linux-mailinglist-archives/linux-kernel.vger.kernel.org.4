Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583156494AF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiLKOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 09:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLKOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 09:33:02 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B79AE55;
        Sun, 11 Dec 2022 06:33:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m18so22042234eji.5;
        Sun, 11 Dec 2022 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WqUoVsa+BZHuhTAxrHNAL1fk+hhKzh6lmfruqRjY0A=;
        b=jPUk5MmJC1Yk5Z2lJVMKIUZeENrXcJRCrfX05/D8yhtxJoNCYszsHmt2p2p4KWciGQ
         KSlwBONTrm3tJUWBljCfT7/9F2Gb1uFo0lzulQJIxYwhVwn1Wdv4CjiAxmxySnKfF8DX
         hFC2fItx/DBfX3epAlQbeiyvfgH6kO4IQxe4CQNTO+fzK9CNWqc/wyklcX2uNsS0vurq
         5AAS4hOeZliQVTsQSvjRmNk86qidAQJAHvfHFVi7LjODNE/VvLcvR7nL7VUqIDesYKU+
         FNnC81h0OJAHm3/cLBeGlUnkAnlBwKbigbfQ0GQP6E4lB7EgrtPbZLP1xy0vun4JwqnA
         0RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WqUoVsa+BZHuhTAxrHNAL1fk+hhKzh6lmfruqRjY0A=;
        b=UQfL5/9ml0VEwvs0Lv8Rp2KHJzdoI04XxjdrGKxct6LEf4sBY8pwzsEg7q1bp4LFzK
         ZbtpiCtTREHnhLOscNgAg2fZkuHgrzvoqZ6XIC7sNe3ew30O0XK97/jr0zl7V5j/UJpx
         I0gKnIW1FGpUZb/w3E2NBaGmlV7mmR3QSO+3HrGIQw1hXmLmGHAdWTRikxSsTrdUcYav
         z9r25AUDSxOzAPorY5MQpodT8/hzFr3e0mUkliz2dK+C0R3feOFfc47z4SvFTTBIBWRN
         oYUv5BY/0pYtqyqm39O953/gTmfDnkhD8UlFo61csz5GMp71e90ZMrdsMLhJCv1HXlzE
         4WNQ==
X-Gm-Message-State: ANoB5pmOBKE/LA+Nc5qglrdvKZILq0d+vP0CCyReeiGwxUm0/8FraO+w
        6XQz0RgILpQGOYmycd3QJJbs9lcmINhvrqK/mBj0LuhGHZNylQ==
X-Google-Smtp-Source: AA0mqf4z6PP5SzJzPWAAWwf8R91KnwRFRKIJ2bB6LCnlJmYvJvSeGrnwY1YYE+qBAFA0DTBEU4wvNaYo0dE/6IXjN+Q=
X-Received: by 2002:a17:906:3604:b0:78d:99a0:7cf6 with SMTP id
 q4-20020a170906360400b0078d99a07cf6mr79046763ejb.56.1670769179467; Sun, 11
 Dec 2022 06:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20221209082247.6330-1-dinghui@sangfor.com.cn> <ae9ee90e-e890-e054-6cf9-8acadd6012b9@oracle.com>
In-Reply-To: <ae9ee90e-e890-e054-6cf9-8acadd6012b9@oracle.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Sun, 11 Dec 2022 22:32:46 +0800
Message-ID: <CAOptpSO-TMhqR35RW4Sssm29NA=8rJ6-9TgjTVpGKpYOeS_8sA@mail.gmail.com>
Subject: Re: [PATCH] scsi: iscsi_tcp: Fix UAF when access shost attr during
 session logout
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Ding Hui <dinghui@sangfor.com.cn>, lduncan@suse.com,
        cleech@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 6:07 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 12/9/22 2:22 AM, Ding Hui wrote:
> > During iscsi session logout, if another task accessing shost ipaddress
> > attr at this time, we can get a KASAN UAF report like this:
> >
> > [  276.941685] ==================================================================
> > [  276.942144] BUG: KASAN: use-after-free in _raw_spin_lock_bh+0x78/0xe0
> > [  276.942535] Write of size 4 at addr ffff8881053b45b8 by task cat/4088
> > [  276.943511] CPU: 2 PID: 4088 Comm: cat Tainted: G            E      6.1.0-rc8+ #3
> > [  276.943997] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> > [  276.944470] Call Trace:
> > [  276.944943]  <TASK>
> > [  276.945397]  dump_stack_lvl+0x34/0x48
> > [  276.945887]  print_address_description.constprop.0+0x86/0x1e7
> > [  276.946421]  print_report+0x36/0x4f
> > [  276.947358]  kasan_report+0xad/0x130
> > [  276.948234]  kasan_check_range+0x35/0x1c0
> > [  276.948674]  _raw_spin_lock_bh+0x78/0xe0
> > [  276.949989]  iscsi_sw_tcp_host_get_param+0xad/0x2e0 [iscsi_tcp]
> > [  276.951765]  show_host_param_ISCSI_HOST_PARAM_IPADDRESS+0xe9/0x130 [scsi_transport_iscsi]
> > [  276.952185]  dev_attr_show+0x3f/0x80
> > [  276.953005]  sysfs_kf_seq_show+0x1fb/0x3e0
> > [  276.953401]  seq_read_iter+0x402/0x1020
> > [  276.954260]  vfs_read+0x532/0x7b0
> > [  276.955113]  ksys_read+0xed/0x1c0
> > [  276.955952]  do_syscall_64+0x38/0x90
> > [  276.956347]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [  276.956769] RIP: 0033:0x7f5d3a679222
> > [  276.957161] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 32 c0 0b 00 e8 a5 fe 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> > [  276.958009] RSP: 002b:00007ffc864d16a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [  276.958431] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f5d3a679222
> > [  276.958857] RDX: 0000000000020000 RSI: 00007f5d3a4fe000 RDI: 0000000000000003
> > [  276.959281] RBP: 00007f5d3a4fe000 R08: 00000000ffffffff R09: 0000000000000000
> > [  276.959682] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
> > [  276.960126] R13: 0000000000000003 R14: 0000000000000000 R15: 0000557a26dada58
> > [  276.960536]  </TASK>
> > [  276.961357] Allocated by task 2209:
> > [  276.961756]  kasan_save_stack+0x1e/0x40
> > [  276.962170]  kasan_set_track+0x21/0x30
> > [  276.962557]  __kasan_kmalloc+0x7e/0x90
> > [  276.962923]  __kmalloc+0x5b/0x140
> > [  276.963308]  iscsi_alloc_session+0x28/0x840 [scsi_transport_iscsi]
> > [  276.963712]  iscsi_session_setup+0xda/0xba0 [libiscsi]
> > [  276.964078]  iscsi_sw_tcp_session_create+0x1fd/0x330 [iscsi_tcp]
> > [  276.964431]  iscsi_if_create_session.isra.0+0x50/0x260 [scsi_transport_iscsi]
> > [  276.964793]  iscsi_if_recv_msg+0xc5a/0x2660 [scsi_transport_iscsi]
> > [  276.965153]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
> > [  276.965546]  netlink_unicast+0x4d5/0x7b0
> > [  276.965905]  netlink_sendmsg+0x78d/0xc30
> > [  276.966236]  sock_sendmsg+0xe5/0x120
> > [  276.966576]  ____sys_sendmsg+0x5fe/0x860
> > [  276.966923]  ___sys_sendmsg+0xe0/0x170
> > [  276.967300]  __sys_sendmsg+0xc8/0x170
> > [  276.967666]  do_syscall_64+0x38/0x90
> > [  276.968028]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [  276.968773] Freed by task 2209:
> > [  276.969111]  kasan_save_stack+0x1e/0x40
> > [  276.969449]  kasan_set_track+0x21/0x30
> > [  276.969789]  kasan_save_free_info+0x2a/0x50
> > [  276.970146]  __kasan_slab_free+0x106/0x190
> > [  276.970470]  __kmem_cache_free+0x133/0x270
> > [  276.970816]  device_release+0x98/0x210
> > [  276.971145]  kobject_cleanup+0x101/0x360
> > [  276.971462]  iscsi_session_teardown+0x3fb/0x530 [libiscsi]
> > [  276.971775]  iscsi_sw_tcp_session_destroy+0xd8/0x130 [iscsi_tcp]
> > [  276.972143]  iscsi_if_recv_msg+0x1bf1/0x2660 [scsi_transport_iscsi]
> > [  276.972485]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
> > [  276.972808]  netlink_unicast+0x4d5/0x7b0
> > [  276.973201]  netlink_sendmsg+0x78d/0xc30
> > [  276.973544]  sock_sendmsg+0xe5/0x120
> > [  276.973864]  ____sys_sendmsg+0x5fe/0x860
> > [  276.974248]  ___sys_sendmsg+0xe0/0x170
> > [  276.974583]  __sys_sendmsg+0xc8/0x170
> > [  276.974891]  do_syscall_64+0x38/0x90
> > [  276.975216]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > We can easily reproduce by two tasks:
> > 1. while :; do iscsiadm -m node --login; iscsiadm -m node --logout; done
> > 2. while :; do cat /sys/devices/platform/host*/iscsi_host/host*/ipaddress; done
> >
> >             iscsid                |        cat
> > ----------------------------------+-------------------------------------------------
> > |- iscsi_sw_tcp_session_destroy   |
> >   |- iscsi_session_teardown       |
> >     |- device_release             |
> >       |- iscsi_session_release    |  |- dev_attr_show
> >         |- kfree                  |    |- show_host_param_ISCSI_HOST_PARAM_IPADDRESS
> >                                   |      |- iscsi_sw_tcp_host_get_param
> >                                   |        |- r/w tcp_sw_host->session (UAF)
> >   |- iscsi_host_remove            |
> >   |- iscsi_host_free              |
> >
> > Since shost hold a pointer to session which is belong to cls_session by its
> > priv tcp_sw_host, so we should get a ref of cls_session, and after
> > iscsi_host_remove() the sysfs is cleared, then we can drop the ref.
> >
>
> Nice bug report and thanks for the patch. I think though we should just
> split the removal from the freeing. The removal will wait on users
> accessing sysfs files for us, so once they return we know we can just
> free things.
>
> Something like this:
>
>

Hi, dinghui and Mike, I submitted patches to fix this issue one year
ago. But I missed Mike's
reply because I was new to the community, so the patches did not keep on.

https://lore.kernel.org/linux-scsi/20210407012450.97754-1-haowenchao@huawei.com/

Because of my negligence, this bug has been discovered so far, and I
apologize for this.
