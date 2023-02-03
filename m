Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F167B6890E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjBCHc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCHc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:32:57 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A390C79237;
        Thu,  2 Feb 2023 23:32:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso573235pjb.3;
        Thu, 02 Feb 2023 23:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bl6Sk47HkvLOT4g5kYdWwukzPWPY0tzuMQrBIW1g8c=;
        b=AMCAgKswDcLXDth+I3fOp9QfA6ARnDu/3jPhvONTQsHbn3EjNOXMzsipS7J2QXhWyV
         soealD3NdbJYzjr/lIQW78ua0OXLOmdIdEwNvXI9Xrl/TZd2j9/ZgMOe8U0IJuSq2kpC
         L/0/xyXNv2OwZx+R+v6ghRnLwWCAIEnqCzKq2ahGbwwfGln+8oPgYJmS04Wez6qDCOTm
         XVa4mNWtl9LUvUwJ7kqoS6xOz+Xw3b5e6Qz3Iwc+rghtdISHHGi3t8jiG7qKd94SWmKv
         OPQgWE+WbQgwRy5SAjwcmUVolOvA5JB15FgVgjUfb8V67mVzfUuipqmpsi28Hbtk/LuZ
         rMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Bl6Sk47HkvLOT4g5kYdWwukzPWPY0tzuMQrBIW1g8c=;
        b=hAZUDgBw90YIC3m6xmeYHeMrlm7QVQQILXqBpSmG/S6LjTan44lZubTeIYxrTz05J4
         kt7qkCqTOhTsK8pN7a8U2/QHI2RIiU6lNQYOXkjmMCYq+qZyNJKWGxzW9RQdyUT2VDnh
         gwenclx6AwntPynS2tK8f/iBZpMpJN6GwnpVoUZJRPjGg8E2WE5EDGg4iGLy2KL6U/kI
         dOj6M0kqPWnrUtQWc2uKeJbvjZeFasvg9KTtq/hjq0bE6bWwgMQjjHq9CnABuipB9R8r
         Qqp5ZZTO38Zfuurbu7TXK2YITVcC9bLuLXOXoDqIDDTpUEk5KRvnkzZiaAZi2yQoyr7e
         Em9Q==
X-Gm-Message-State: AO0yUKWWGivBg+lmYg2/Tcf8JAPdj42XEITS2CtJk8I4iQHkx0raHFhH
        ZvNav3xCuf8bz0OXs5LnwgEbQumL9Rc=
X-Google-Smtp-Source: AK7set9/q0axN3f4rDzK4IZ7phmSdSamza3e5sDIYKUR4j57UlcO3iO8qr+LgprHMQ59luC60FzqOQ==
X-Received: by 2002:a17:902:c40f:b0:191:7d3:7fdd with SMTP id k15-20020a170902c40f00b0019107d37fddmr4333669plk.60.1675409575901;
        Thu, 02 Feb 2023 23:32:55 -0800 (PST)
Received: from zj-T470P.. ([103.135.104.6])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f7ce00b00195f249e688sm867202plw.248.2023.02.02.23.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:32:55 -0800 (PST)
From:   Zhu Zhongjie <zhongjiezhu1@gmail.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhongjie Zhu <zhongjiezhu1@gmail.com>
Subject: [PATCH v1] USB: core: hub: fix usb_hub worker blocking drain_all_pages() worker issue
Date:   Fri,  3 Feb 2023 15:32:50 +0800
Message-Id: <20230203073250.3465-1-zhongjiezhu1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Zhongjie Zhu <zhongjiezhu1@gmail.com>

When disconnecting a usb mass storege, if there are a lot of inodes
like 10 thousands files need to be freed, the invalidate_inodes() will
run for a loog time to freeing all inodes, this will block other worker
to run on the cpu, so mark the usb_hub workqueue to WQ_CPU_INTENSIVE to
avoid this situation.

Sometimes the flowing call stack will hanppen: the cma_alloc() will be
blocked at __flush_work() by the hub_event worker.

usb_hub worker:
Call trace:
[<ffffffc010335e84>] invalidate_inodes+0xc0/0x294
<ffffffc0103659cc>] __invalidate_device+0x44/0xbc
[<ffffffc01059efe4>] invalidate_partition+0x7c/0xac
[<ffffffc01059ed54>] del_gendisk+0x148/0x35c
[<ffffffc0107620e4>] sd_remove+0x58/0xc4
[<ffffffc01070cb3c>] device_release_driver_internal+0x184/0x248
[<ffffffc010709e40>] bus_remove_device+0xdc/0x104
[<ffffffc0107068dc>] device_del+0x2b0/0x534
[<ffffffc01075c1a8>] __scsi_remove_device+0xc8/0x14c
[<ffffffc01075b788>] scsi_forget_host+0x60/0x7c
[<ffffffc010750040>] scsi_remove_host+0x84/0x130
[<ffffffc010882d60>] usb_stor_disconnect+0x7c/0xd0
[<ffffffc010828430>] usb_unbind_interface+0xc0/0x25c
[<ffffffc01070cb3c>] device_release_driver_internal+0x184/0x248
[<ffffffc010709e40>] bus_remove_device+0xdc/0x104
[<ffffffc0107068dc>] device_del+0x2b0/0x534
[<ffffffc010825b38>] usb_disable_device+0x80/0x180
[<ffffffc010817ef0>] usb_disconnect+0x128/0x314
[<ffffffc01081c95c>] hub_event+0x99c/0x16c8
[<ffffffc01011ed94>] process_one_work+0x2e8/0x574
[<ffffffc01011f2cc>] worker_thread+0x2ac/0x5e8
[<ffffffc0101252b4>] kthread+0x14c/0x15c
[<ffffffc010083ff0>] ret_from_fork+0x10/0x18

cma_alloc():
Call trace
[<ffffffc010090c18>] __switch_to+0x244/0x264
[<ffffffc0112153e0>] __schedule+0x564/0x754
[<ffffffc011215660>] schedule+0x90/0xc4
[<ffffffc011219468>] schedule_timeout+0x4c/0x1d0
[<ffffffc011216814>] do_wait_for_common+0xf8/0x1b4
[<ffffffc0112163bc>] wait_for_completion+0x50/0x68
[<ffffffc010119d94>] __flush_work.llvm.11756653060903382828+0x270/0x324
[<ffffffc0102d51e4>] drain_all_pages+0x224/0x2a8
[<ffffffc0103031fc>] start_isolate_page_range+0x1e4/0x2dc
[<ffffffc010e25624>] aml_cma_alloc_range+0xfc/0x3ec
[<ffffffc0103072e0>] cma_alloc+0x1ac/0x6d8

Signed-off-by: Zhongjie Zhu <zhongjiezhu1@gmail.com>
---
 drivers/usb/core/hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 9eca403af2a8..850549b30277 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5904,7 +5904,8 @@ int usb_hub_init(void)
 	 * device was gone before the EHCI controller had handed its port
 	 * over to the companion full-speed controller.
 	 */
-	hub_wq = alloc_workqueue("usb_hub_wq", WQ_FREEZABLE, 0);
+	hub_wq = alloc_workqueue("usb_hub_wq",
+			WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
 	if (hub_wq)
 		return 0;
 
-- 
2.34.1

