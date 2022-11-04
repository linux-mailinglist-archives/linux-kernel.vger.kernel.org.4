Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6262D619F5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiKDR67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKDR64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:58:56 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597AE23BC6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:58:55 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id r205-20020a1c44d6000000b003cf9bd60855so452011wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBSiUsyeZWpb5wZ4VZ7zXev1ZPwSaDrVY+3gcnvCBuw=;
        b=YUJ/OAJ9UiGY5kHZ8a7cM7ondxqy8jVv3e8MkGu1Y8sylpVg5/81V9PRHK0HWrmwxG
         PS8iyB0kfiz+Rgs1esC6CZjs2aKZxx/Fb8pssu9ZbFxVUYlbXlmxyrdtyI+SRliH329A
         LJVmindCFlDSrdBjbvFTvQvN1nbC4r5U3jBh4zuL1KXqGbCgFxEr7X+0aaTG3YbTc5rG
         DM3rxG4TPfouMoHgf/hy1gF8V+afSNKvBAZSiHrWjAQ4IEu29yaTgE8LZItafZVhBCrn
         WNtr7OaPzZWc+vs3sHj9R5Wn5kx21F8BpIW6UjWUsp8tN3sE1l0M7us+cvZOqQN/q3Sn
         CMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBSiUsyeZWpb5wZ4VZ7zXev1ZPwSaDrVY+3gcnvCBuw=;
        b=6myy6jbsox/spNrU8JEFMWUpZKsuYVI7prY6XxHeXn7phP2GFLa80/bAya1izL+uYE
         wok44XBQYarPvxr/IGsW+UKRaan6cOwSPBNTgLc4sO225YrWFfm89JBCzdZtrjI2PPoI
         vYD8EQPox45oq0yZXRVpRxfCJgQdBdbJ6mPNzzSBdSpTMoNZKGB221U2RY2SBmKO/U2b
         5wObUh87wgO7w5iOKQpG+qacJ2l7hyreL0Unw/yiPshX3Iqbhx4nT65lFWIbtXja1Dnw
         rm/3iy7z0npJ67EFQkkW0n8BA/qgjMakbfkU0ndA1BWU8rckhIItOppY+qWtmb51xGw1
         ifVQ==
X-Gm-Message-State: ACrzQf0bzuy+n3jdYEXqm+moh5rxEzo9pouVzfTCUupDy+WXiiugBGdJ
        fQtR9A+j8jXUBk/b9YTgGdMmFgiJke4=
X-Google-Smtp-Source: AMsMyM5F3/NI7pxYOIRoNPmiurDb7iiZKYJF5NI+fvKdeXfDKTjs3dGo4JwpqG5u+sFaNa61CY1dmAluqXY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:6696:b522:be5f:6acc])
 (user=glider job=sendgmr) by 2002:a05:6000:104:b0:236:a6f4:c67f with SMTP id
 o4-20020a056000010400b00236a6f4c67fmr23246693wrx.82.1667584733770; Fri, 04
 Nov 2022 10:58:53 -0700 (PDT)
Date:   Fri,  4 Nov 2022 18:58:49 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104175849.2782567-1-glider@google.com>
Subject: [PATCH] misc/vmw_vmci: fix an infoleak in vmci_host_do_receive_datagram()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        georgezhang@vmware.com, bryantan@vmware.com, vdasa@vmware.com,
        pv-drivers@vmware.com,
        syzbot+39be4da489ed2493ba25@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`struct vmci_event_qp` allocated by qp_notify_peer() contains padding,
which may carry uninitialized data to the userspace, as observed by
KMSAN:

  BUG: KMSAN: kernel-infoleak in instrument_copy_to_user ./include/linux/instrumented.h:121
   instrument_copy_to_user ./include/linux/instrumented.h:121
   _copy_to_user+0x5f/0xb0 lib/usercopy.c:33
   copy_to_user ./include/linux/uaccess.h:169
   vmci_host_do_receive_datagram drivers/misc/vmw_vmci/vmci_host.c:431
   vmci_host_unlocked_ioctl+0x33d/0x43d0 drivers/misc/vmw_vmci/vmci_host.c:925
   vfs_ioctl fs/ioctl.c:51
  ...

  Uninit was stored to memory at:
   kmemdup+0x74/0xb0 mm/util.c:131
   dg_dispatch_as_host drivers/misc/vmw_vmci/vmci_datagram.c:271
   vmci_datagram_dispatch+0x4f8/0xfc0 drivers/misc/vmw_vmci/vmci_datagram.c:339
   qp_notify_peer+0x19a/0x290 drivers/misc/vmw_vmci/vmci_queue_pair.c:1479
   qp_broker_attach drivers/misc/vmw_vmci/vmci_queue_pair.c:1662
   qp_broker_alloc+0x2977/0x2f30 drivers/misc/vmw_vmci/vmci_queue_pair.c:1750
   vmci_qp_broker_alloc+0x96/0xd0 drivers/misc/vmw_vmci/vmci_queue_pair.c:1940
   vmci_host_do_alloc_queuepair drivers/misc/vmw_vmci/vmci_host.c:488
   vmci_host_unlocked_ioctl+0x24fd/0x43d0 drivers/misc/vmw_vmci/vmci_host.c:927
  ...

  Local variable ev created at:
   qp_notify_peer+0x54/0x290 drivers/misc/vmw_vmci/vmci_queue_pair.c:1456
   qp_broker_attach drivers/misc/vmw_vmci/vmci_queue_pair.c:1662
   qp_broker_alloc+0x2977/0x2f30 drivers/misc/vmw_vmci/vmci_queue_pair.c:1750

  Bytes 28-31 of 48 are uninitialized
  Memory access of size 48 starts at ffff888035155e00
  Data copied to user address 0000000020000100

Use memset() to prevent the infoleaks.

Also speculatively fix qp_notify_peer_local(), which may suffer from the
same problem.

Reported-by: syzbot+39be4da489ed2493ba25@syzkaller.appspotmail.com
Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index e71068f7759b3..844264e1b88cc 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -854,6 +854,7 @@ static int qp_notify_peer_local(bool attach, struct vmci_handle handle)
 	u32 context_id = vmci_get_context_id();
 	struct vmci_event_qp ev;
 
+	memset(&ev, 0, sizeof(ev));
 	ev.msg.hdr.dst = vmci_make_handle(context_id, VMCI_EVENT_HANDLER);
 	ev.msg.hdr.src = vmci_make_handle(VMCI_HYPERVISOR_CONTEXT_ID,
 					  VMCI_CONTEXT_RESOURCE_ID);
@@ -1467,6 +1468,7 @@ static int qp_notify_peer(bool attach,
 	 * kernel.
 	 */
 
+	memset(&ev, 0, sizeof(ev));
 	ev.msg.hdr.dst = vmci_make_handle(peer_id, VMCI_EVENT_HANDLER);
 	ev.msg.hdr.src = vmci_make_handle(VMCI_HYPERVISOR_CONTEXT_ID,
 					  VMCI_CONTEXT_RESOURCE_ID);
-- 
2.38.1.431.g37b22c650d-goog

