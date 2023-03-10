Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C636B4DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCJQ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCJQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:58:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D34305D8;
        Fri, 10 Mar 2023 08:56:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l1so5923851pjt.2;
        Fri, 10 Mar 2023 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678467376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7QjpiB3OBqpizQlSa36YLLw1Stnz2orOhJL4O2Jbpc=;
        b=Fk8fCxitiI6GdXI1b9924iEBzI7RX4H+flxXLAi3QOMxUdMfP+/Dk9N1ua4HslJC9X
         Hb+u+UZexEXHEVglQNs/xyu+JLLPX2MlFTT+PHogBIB/4F2/8GSnSUWJzFzBJUoBycfj
         orUjxo8EpgWnzumVZwI01320147+WWIIbFmGc/19ko6uZluJKYPDyy5H7kqKu/oNio0c
         gtLZLtEISLuh+QYOakU5cIG6KA0TNVDV97ppXyOi0l0xj2WMuPpQjmw4Ej1TrFS2RowL
         ghmomLEE3dsfOxKTmGCSkUE7mgOs+N7zmfbat7RXWJYe/Ro4YgJLJL3FEa2KyYG4fnPu
         sNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7QjpiB3OBqpizQlSa36YLLw1Stnz2orOhJL4O2Jbpc=;
        b=MbIGg3MRImHdfTPWwRq3S61UDeDpozgUR/xq4dTM3hedkXTrcPGt9U7RVVQdj9sthm
         Pf0+Qml6xsRjmlMo8tvdUXlo1HIl1JeT5Q1U5yBIOE4qznm7TS53tpWox1AObhLGbJMJ
         bumIUumQHQk3gI7RajO/TRzM34lrbdlZfPb5rGndQzFuZJMloN3mtRNJlvz5i02n6UY7
         K6xRgQaX2zhB3SSS2UufwN3tt66HCSbEIt3E+p6mj+oDw7gQVmpG56woauWRtSuXQr+T
         PdrKCFvxb0TqXbdpiWzOUG/U8hhWWR8iQMoQy3ealQi0NhPm6gTwaNJJbDC+z9yExVzB
         do3A==
X-Gm-Message-State: AO0yUKVfiENAtsvp7JItJ7dlDJ2ITZ5FKVrcLKn7V+zxsibJ4pgF4H8H
        kein2TMrRlfm/uOOsBi2YLQ=
X-Google-Smtp-Source: AK7set/78ENATSm278ou4BY3T5Nq+QqYsRnZw596kxmZ9lJygZ6a3gt5nUBuErO3SpzYHU5F2VTPog==
X-Received: by 2002:a05:6a20:7d86:b0:c6:bd82:ea2d with SMTP id v6-20020a056a207d8600b000c6bd82ea2dmr36872479pzj.2.1678467376608;
        Fri, 10 Mar 2023 08:56:16 -0800 (PST)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7880f000000b005a7f8a326a3sm71843pfo.50.2023.03.10.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:56:16 -0800 (PST)
From:   Wei Chen <harperchen1110@gmail.com>
To:     mchehab@kernel.org
Cc:     zhongbaisong@huawei.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: dvb-usb: az6027: Fix three null-ptr-deref in az6027_i2c_xfer()
Date:   Fri, 10 Mar 2023 16:56:04 +0000
Message-Id: <20230310165604.3093483-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In az6027_i2c_xfer, msg is controlled by user. When msg[i].buf is null, 
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()") 
fix the null-ptr-deref bug when msg[i].addr is 0x99. However, null-ptr-deref 
also happens when msg[i].addr is 0xd0 and 0xc0. We add check on msg[i].len to 
prevent null-ptr-deref.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/media/usb/dvb-usb/az6027.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index 7d78ee09be5e..a31c6f82f4e9 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -988,6 +988,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			/* write/read request */
 			if (i + 1 < num && (msg[i + 1].flags & I2C_M_RD)) {
 				req = 0xB9;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (msg[i].len << 8);
 				length = msg[i + 1].len + 6;
@@ -1001,6 +1005,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 
 				/* demod 16bit addr */
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (2 << 8);
 				length = msg[i].len - 2;
@@ -1026,6 +1034,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			} else {
 
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = msg[i].buf[0] & 0x00FF;
 				value = msg[i].addr + (1 << 8);
 				length = msg[i].len - 1;
-- 
2.25.1

