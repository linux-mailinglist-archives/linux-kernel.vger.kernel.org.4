Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E77056F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEPTUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEPTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554BD86AF;
        Tue, 16 May 2023 12:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56E563E42;
        Tue, 16 May 2023 19:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F66C433EF;
        Tue, 16 May 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684264818;
        bh=/YeNawdh+oXFKTr0sy424iogPM406LAx5W7VDSqlidM=;
        h=From:To:Cc:Subject:Date:From;
        b=x4guEzn6i6g07MTgAw/xrdPb7tYg0jgEBLLTHZgHh2SyEmdnMziwtQ1NYa/4+exvy
         +N3sI36ZP0Wsl4VI4tyD7kWmr37b7F/DOxuzLUdFkB4VZlhVVtKGvgmLo60dovJvGu
         dfbQhAssAPtDTv7SPoMte5VO5I9NNQ68w5lUrgNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] driver core: class: properly reference count class_dev_iter()
Date:   Tue, 16 May 2023 21:20:14 +0200
Message-Id: <2023051610-stove-condense-9a77@gregkh>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Lines:  50
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/YeNawdh+oXFKTr0sy424iogPM406LAx5W7VDSqlidM=; b=owGbwMvMwCRo6H6F97bub03G02pJDCnJ17P3XawPS+FX2ZOxhG/nyl2Xk2bw9BzY/U47ssb4y 96Wr59aO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi3KcYZrOn5b/afWdS8APf U9xRXX218zXNZjMsWOq73dDq7ot3apcuT/jIP3+VRbdULAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When class_dev_iter is initialized, the reference count for the subsys
private structure is incremented, but never decremented, causing a
memory leak over time.  To resolve this, save off a pointer to the
internal structure into the class_dev_iter structure and then when the
iterator is finished, drop the reference count.

Reported-and-tested-by: syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com
Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 2 ++
 include/linux/device/class.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index ac1808d1a2e8..05d9df90f621 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -320,6 +320,7 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 		start_knode = &start->p->knode_class;
 	klist_iter_init_node(&sp->klist_devices, &iter->ki, start_knode);
 	iter->type = type;
+	iter->sp = sp;
 }
 EXPORT_SYMBOL_GPL(class_dev_iter_init);
 
@@ -361,6 +362,7 @@ EXPORT_SYMBOL_GPL(class_dev_iter_next);
 void class_dev_iter_exit(struct class_dev_iter *iter)
 {
 	klist_iter_exit(&iter->ki);
+	subsys_put(iter->sp);
 }
 EXPORT_SYMBOL_GPL(class_dev_iter_exit);
 
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 9deeaeb457bb..abf3d3bfb6fe 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -74,6 +74,7 @@ struct class {
 struct class_dev_iter {
 	struct klist_iter		ki;
 	const struct device_type	*type;
+	struct subsys_private		*sp;
 };
 
 int __must_check class_register(const struct class *class);
-- 
2.40.1

