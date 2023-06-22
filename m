Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D33739743
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjFVGP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFVGPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D2E1731
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687414479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6U7Jgyq5pY8OJlZBHmNv7DI17/H9KRKPjBl2RMWjLNY=;
        b=eQlXRADauHtV6adGbPVg3hhHZh6zV4Oak+znCLKYv4+HNT7a6g/JVXSeZdwEyASVFkrRsc
        DTyJuJUJuitnDHT8+wM8LTMw1g0g8CJDYPLTOC41f2ybMBgahA7oyKLp6HCM/RvCRcvVnA
        3jI8tBZjDQblTeL3vmVnRSDZFZ/ZSu8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328--OvydtiqMWWr4Qz_YLs_ug-1; Thu, 22 Jun 2023 02:14:38 -0400
X-MC-Unique: -OvydtiqMWWr4Qz_YLs_ug-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51bca893729so1613784a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687414477; x=1690006477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U7Jgyq5pY8OJlZBHmNv7DI17/H9KRKPjBl2RMWjLNY=;
        b=E2GK4VbgrwLIOrt+yS6wtLOQtHAfTKbU+Ondrx58ItTt6cB4M+sXjlS7cvoMg7mmV6
         FoF8eZEr2mKEbNrCI/i54nAYFURtQVRC1BPdgdEZ323fMZoZsmvVkXSnh4TWV0vZTm7C
         2lkdn3ipPRVoBjtb7lC2s/oEuFaHkLylB8KXerM5OS19zSkYmyoA0U9PV4hamYuDcVCL
         BmzmcoTvE1lNyD9QhWLICxpYmod2puI+hDCZ4AEIT+5F6az39NhVR08DNjA4qUX4Difu
         0P703lJNp0usaHuvcCDkdqaCD+w6nIQjkHkqXwtfTP+xyCIl2F1J93KWXyBqhzStRRfB
         K5Dw==
X-Gm-Message-State: AC+VfDykv5MoiP8qOjH2mbfDbc4sOKqbvBfOugzxEV+dXTM/T9ndUBX3
        Wtu3zvKzZWn7NXUk44o/k6eE/LwgOGIzEE7xP7cOKIwyw5CRGE99A3b0oLk+vTomrP8hfW/U/kw
        vguCM0IWSesr+Ly0voVwh3pvC
X-Received: by 2002:a17:907:1c07:b0:94f:956:b3f7 with SMTP id nc7-20020a1709071c0700b0094f0956b3f7mr18112725ejc.2.1687414477206;
        Wed, 21 Jun 2023 23:14:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kiHBugT6iJqkIz8a+U0lLXflhRfdcAKLD7sLp+R33WreQ6sCwEufnpAYyQ9KBgPCLpee+bA==
X-Received: by 2002:a17:907:1c07:b0:94f:956:b3f7 with SMTP id nc7-20020a1709071c0700b0094f0956b3f7mr18112634ejc.2.1687414475008;
        Wed, 21 Jun 2023 23:14:35 -0700 (PDT)
Received: from redhat.com ([2.52.159.126])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906698700b009745417ca38sm4083600ejr.21.2023.06.21.23.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 23:14:34 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:14:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Edward Liaw <edliaw@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Roberts, Martin" <martin.roberts@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Message-ID: <20230622021322-mutt-send-email-mst@kernel.org>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
 <ZJIuG9hyTYIIDbF5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJIuG9hyTYIIDbF5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:54:19PM +0000, Edward Liaw wrote:
> On Fri, Jun 09, 2023 at 03:27:24AM -0400, Michael S. Tsirkin wrote:
> > This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.
> This commit was also breaking kernel tests on a virtual Android device
> (cuttlefish).  We were seeing hangups like:
> 
> [ 2889.910733] INFO: task kworker/u8:2:6312 blocked for more than 720 seconds.
> [ 2889.910967]       Tainted: G           OE      6.2.0-mainline-g5c05cafa8df7-ab9969617 #1
> [ 2889.911143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2889.911389] task:kworker/u8:2    state:D stack:12160 pid:6312  ppid:2      flags:0x00004000
> [ 2889.911567] Workqueue: writeback wb_workfn (flush-254:57)
> [ 2889.911771] Call Trace:
> [ 2889.911831]  <TASK>
> [ 2889.911893]  __schedule+0x55f/0x880
> [ 2889.912021]  schedule+0x6a/0xc0
> [ 2889.912110]  schedule_timeout+0x58/0x1a0
> [ 2889.912200]  wait_for_common+0xf7/0x1b0
> [ 2889.912289]  wait_for_completion+0x1c/0x40
> [ 2889.912377]  f2fs_issue_checkpoint+0x14c/0x210
> [ 2889.912504]  f2fs_sync_fs+0x4c/0xb0
> [ 2889.912597]  f2fs_balance_fs_bg+0x2f6/0x340
> [ 2889.912736]  ? can_migrate_task+0x39/0x2b0
> [ 2889.912872]  f2fs_write_node_pages+0x77/0x240
> [ 2889.912989]  do_writepages+0xde/0x240
> [ 2889.913094]  __writeback_single_inode+0x3f/0x360
> [ 2889.913231]  writeback_sb_inodes+0x320/0x5f0
> [ 2889.913349]  ? move_expired_inodes+0x58/0x210
> [ 2889.913470]  __writeback_inodes_wb+0x97/0x100
> [ 2889.913587]  wb_writeback+0x17e/0x390
> [ 2889.913682]  wb_workfn+0x35f/0x500
> [ 2889.913774]  process_one_work+0x1d9/0x3b0
> [ 2889.913870]  worker_thread+0x251/0x410
> [ 2889.913960]  kthread+0xeb/0x110
> [ 2889.914052]  ? __cfi_worker_thread+0x10/0x10
> [ 2889.914168]  ? __cfi_kthread+0x10/0x10
> [ 2889.914257]  ret_from_fork+0x29/0x50
> [ 2889.914364]  </TASK>
> [ 2889.914565] INFO: task mkdir09:6425 blocked for more than 720 seconds.
> [ 2889.916065]       Tainted: G           OE      6.2.0-mainline-g5c05cafa8df7-ab9969617 #1
> [ 2889.916255] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2889.916450] task:mkdir09         state:D stack:13016 pid:6425  ppid:6423   flags:0x00004000
> [ 2889.916656] Call Trace:
> [ 2889.916900]  <TASK>
> [ 2889.917004]  __schedule+0x55f/0x880
> [ 2889.917129]  schedule+0x6a/0xc0
> [ 2889.917273]  schedule_timeout+0x58/0x1a0
> [ 2889.917425]  wait_for_common+0xf7/0x1b0
> [ 2889.917535]  wait_for_completion+0x1c/0x40
> [ 2889.917670]  f2fs_issue_checkpoint+0x14c/0x210
> [ 2889.917844]  f2fs_sync_fs+0x4c/0xb0
> [ 2889.917969]  f2fs_do_sync_file+0x3a8/0x8c0
> [ 2889.918090]  ? mt_find+0xa0/0x1a0
> [ 2889.918216]  f2fs_sync_file+0x2f/0x60
> [ 2889.918310]  vfs_fsync_range+0x74/0x90
> [ 2889.918567]  __se_sys_msync+0x176/0x270
> [ 2889.918730]  __x64_sys_msync+0x1c/0x40
> [ 2889.918873]  do_syscall_64+0x53/0xb0
> [ 2889.918996]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 2889.919178] RIP: 0033:0x7540b08bcf47
> [ 2889.919297] RSP: 002b:00007fff5fcbeea8 EFLAGS: 00000206 ORIG_RAX: 000000000000001a
> [ 2889.919496] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007540b08bcf47
> [ 2889.919828] RDX: 0000000000000004 RSI: 0000000000001000 RDI: 00007540b4ae7000
> [ 2889.920227] RBP: 0000000000000000 R08: 721e0000010b0016 R09: 0000000000000003
> [ 2889.920435] R10: 0000000000000100 R11: 0000000000000206 R12: 00005d2f95fd2f08
> [ 2889.920793] R13: 00005d2f95fbc310 R14: 00007540b08e1bb8 R15: 00005d2f95fbc310
> [ 2889.921072]  </TASK>
> 
> in random tests in the LTP (linux test project) test suite.
> 
> > ---
> > 
> > Since v1:
> > 	fix build error
> > 
> > Still completely untested as I'm traveling.
> > Martin, Suwan, could you please test and report?
> > Suwan if you have a better revert in mind pls post and
> > I will be happy to drop this.
> > 
> > Thanks!
> > 
> This revert appears to have resolved the test failures for me.
> 
> Tested-by: edliaw@google.com

Oh interesting, can you share how to reproduce the failures?
Then maybe Suwan Kim can take a look at fixing up the patch.

-- 
MST

