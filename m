Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B7671002
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjARB3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjARB3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:29:51 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7293D937
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:29:49 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id NSV00145;
        Wed, 18 Jan 2023 09:29:45 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.16; Wed, 18 Jan 2023 09:29:45 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <amit@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] virtio_console: Use strscpy() to instead of strncpy()
Date:   Tue, 17 Jan 2023 20:29:44 -0500
Message-ID: <20230118012944.2436-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202311809294543931178e023b6202010069c7424e9b5
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/char/virtio_console.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 6a821118d553..d5ac4d955bc8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1666,9 +1666,8 @@ static void handle_control_message(struct virtio_device *vdev,
 				"Not enough space to store port name\n");
 			break;
 		}
-		strncpy(port->name, buf->buf + buf->offset + sizeof(*cpkt),
-			name_size - 1);
-		port->name[name_size - 1] = 0;
+		strscpy(port->name, buf->buf + buf->offset + sizeof(*cpkt),
+			name_size);
 
 		/*
 		 * Since we only have one sysfs attribute, 'name',
-- 
2.27.0

