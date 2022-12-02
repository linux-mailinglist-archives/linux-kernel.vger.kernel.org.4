Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B7C6410A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiLBWdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiLBWdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:33:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45881EBC92;
        Fri,  2 Dec 2022 14:33:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m19so8207684edj.8;
        Fri, 02 Dec 2022 14:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZvT2BrJWUgYMbwn3ocx26UrzsJe4/rr8jByj9AM/40=;
        b=PJUcfZQ2pP0SvbdjdVKl4KmEhk8EznUJVyJ2cwVQy40vub6TzrMXcGVwURBe2m5ZWq
         WEdtQpvjkVvEqJSkJQbGqJa7HNaOsEOGPIVO/f9yysk+eYuHL5ogzaOdKO1Q6237VWN4
         xFSk4lKcSb3M1I899YyYeTybqVCpyMEYYtmgEcXax6GWP/HQiBJjVDhMwGgZ4vYxX1mD
         2tlA18FLic3yI0THcqShNFDnZ1AgGMHb/BY+ObV0qYnabupvAqCuSL6TqbgRDGryJn6+
         CxaLic9kuifbG9VXnZiQiSWw/uSBRLFIegIjHZZJ0tNUt6wh7TFdII4nvrAKUauhkyqY
         mqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZvT2BrJWUgYMbwn3ocx26UrzsJe4/rr8jByj9AM/40=;
        b=g6cWlJz/Zz93NzXQAAwsmHM9UxI80d+cdOhJ3gQQu221fNrZhAgqmSdwsiDSIL9p9j
         CfdrROpEg2jgn0DhcWXhDk7RemFJmrmhH8YPcexshAnpogDL08hN47mTNQ/HG2NujKw9
         1+Pn3uy5anlQPhIwwPkwlH3fYmDTP1HHsxCIzf7vPjEeL4YuYsBfVfxNZJ0wDsdQh1Gp
         ZRLTXE4G6FZV2S+cRYYG7dNVAwXxlPfjLwv6e9v/D5H2c13VHAvxohbY/Z9sHQZxemqt
         CAyQYobW5asi26K02jaMuujOYVVnJApZfxLiyD5Xy2crs34J8nCETUuF+MUxJ+XXE9Bm
         n7qQ==
X-Gm-Message-State: ANoB5pkzV+TCkPGIEdd3QFfgKd0u5SPym+UWXqZ779mSAIh1KeBINJcb
        DXVBacX55E/7rI6vcgU1tLH3CmXjAZNkEA==
X-Google-Smtp-Source: AA0mqf4gu/fnjQ4meh6apI2V0jFsLHOV40XPRcLgeKOHxviIit0mXbaUHv+Tgeep5O0DFiqwE1VY4w==
X-Received: by 2002:a05:6402:509:b0:466:7500:b5df with SMTP id m9-20020a056402050900b004667500b5dfmr65577268edv.48.1670020419552;
        Fri, 02 Dec 2022 14:33:39 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:38 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] platform/surface: aggregator: Improve documentation and handling of message target and source IDs
Date:   Fri,  2 Dec 2022 23:33:20 +0100
Message-Id: <20221202223327.690880-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202223327.690880-1-luzmaximilian@gmail.com>
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `tid_in` and `tid_out` fields of the serial hub protocol command
struct (struct ssh_command) are actually source and target IDs,
indicating the peer from which the message originated and the peer for
which it is intended.

Change the naming of those fields accordingly and improve the protocol
documentation. Additionally, introduce an enum containing all currently
known peers, i.e. targets and sources.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../driver-api/surface_aggregator/client.rst  |  4 +-
 .../driver-api/surface_aggregator/ssh.rst     | 36 +++++++++--------
 .../platform/surface/aggregator/controller.c  | 12 +++---
 .../platform/surface/aggregator/ssh_msgb.h    |  4 +-
 .../surface/aggregator/ssh_request_layer.c    | 11 ++---
 include/linux/surface_aggregator/controller.h |  4 +-
 include/linux/surface_aggregator/serial_hub.h | 40 +++++++++++++------
 7 files changed, 64 insertions(+), 47 deletions(-)

diff --git a/Documentation/driver-api/surface_aggregator/client.rst b/Documentation/driver-api/surface_aggregator/client.rst
index 27f95abdbe99..9d7411223a84 100644
--- a/Documentation/driver-api/surface_aggregator/client.rst
+++ b/Documentation/driver-api/surface_aggregator/client.rst
@@ -191,7 +191,7 @@ data received from it is converted from little-endian to host endianness.
             *       they do not correspond to an actual SAM/EC request.
             */
            rqst.target_category = SSAM_SSH_TC_SAM;
-           rqst.target_id = 0x01;
+           rqst.target_id = SSAM_SSH_TID_SAM;
            rqst.command_id = 0x02;
            rqst.instance_id = 0x03;
            rqst.flags = SSAM_REQUEST_HAS_RESPONSE;
@@ -241,7 +241,7 @@ one of the generator macros, for example via:
 
    SSAM_DEFINE_SYNC_REQUEST_W(__ssam_tmp_perf_mode_set, __le32, {
            .target_category = SSAM_SSH_TC_TMP,
-           .target_id       = 0x01,
+           .target_id       = SSAM_SSH_TID_SAM,
            .command_id      = 0x03,
            .instance_id     = 0x00,
    });
diff --git a/Documentation/driver-api/surface_aggregator/ssh.rst b/Documentation/driver-api/surface_aggregator/ssh.rst
index bf007d6c9873..18fd0f0aee84 100644
--- a/Documentation/driver-api/surface_aggregator/ssh.rst
+++ b/Documentation/driver-api/surface_aggregator/ssh.rst
@@ -13,6 +13,7 @@
 .. |DATA_NSQ| replace:: ``DATA_NSQ``
 .. |TC| replace:: ``TC``
 .. |TID| replace:: ``TID``
+.. |SID| replace:: ``SID``
 .. |IID| replace:: ``IID``
 .. |RQID| replace:: ``RQID``
 .. |CID| replace:: ``CID``
@@ -219,13 +220,13 @@ following fields, packed together and in order:
      - |u8|
      - Target category.
 
-   * - |TID| (out)
+   * - |TID|
      - |u8|
-     - Target ID for outgoing (host to EC) commands.
+     - Target ID for commands/messages.
 
-   * - |TID| (in)
+   * - |SID|
      - |u8|
-     - Target ID for incoming (EC to host) commands.
+     - Source ID for commands/messages.
 
    * - |IID|
      - |u8|
@@ -286,19 +287,20 @@ general, however, a single target category should map to a single reserved
 event request ID.
 
 Furthermore, requests, responses, and events have an associated target ID
-(``TID``). This target ID is split into output (host to EC) and input (EC to
-host) fields, with the respecting other field (e.g. output field on incoming
-messages) set to zero. Two ``TID`` values are known: Primary (``0x01``) and
-secondary (``0x02``). In general, the response to a request should have the
-same ``TID`` value, however, the field (output vs. input) should be used in
-accordance to the direction in which the response is sent (i.e. on the input
-field, as responses are generally sent from the EC to the host).
-
-Note that, even though requests and events should be uniquely identifiable
-by target category and command ID alone, the EC may require specific
-target ID and instance ID values to accept a command. A command that is
-accepted for ``TID=1``, for example, may not be accepted for ``TID=2``
-and vice versa.
+(``TID``) and source ID (``SID``). These two fields indicate where a message
+originates from (``SID``) and what the intended target of the message is
+(``TID``). Note that a response to a specific request therefore has the source
+and target IDs swapped when compared to the original request (i.e. the request
+target is the response source and the request source is the response target).
+See (:c:type:`enum ssh_request_id <ssh_request_id>`) for possible values of
+both.
+
+Note that, even though requests and events should be uniquely identifiable by
+target category and command ID alone, the EC may require specific target ID and
+instance ID values to accept a command. A command that is accepted for
+``TID=1``, for example, may not be accepted for ``TID=2`` and vice versa. While
+this may not always hold in reality, you can think of different target/source
+IDs indicating different physical ECs with potentially different feature sets.
 
 
 Limitations and Observations
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 43e765199137..54bfb1f3d2dc 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -994,7 +994,7 @@ static void ssam_handle_event(struct ssh_rtl *rtl,
 
 	item->rqid = get_unaligned_le16(&cmd->rqid);
 	item->event.target_category = cmd->tc;
-	item->event.target_id = cmd->tid_in;
+	item->event.target_id = cmd->sid;
 	item->event.command_id = cmd->cid;
 	item->event.instance_id = cmd->iid;
 	memcpy(&item->event.data[0], data->ptr, data->len);
@@ -1777,35 +1777,35 @@ EXPORT_SYMBOL_GPL(ssam_request_sync_with_buffer);
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_get_firmware_version, __le32, {
 	.target_category = SSAM_SSH_TC_SAM,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x13,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_off, u8, {
 	.target_category = SSAM_SSH_TC_SAM,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x15,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_display_on, u8, {
 	.target_category = SSAM_SSH_TC_SAM,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x16,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_exit, u8, {
 	.target_category = SSAM_SSH_TC_SAM,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x33,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_ssh_notif_d0_entry, u8, {
 	.target_category = SSAM_SSH_TC_SAM,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x34,
 	.instance_id     = 0x00,
 });
diff --git a/drivers/platform/surface/aggregator/ssh_msgb.h b/drivers/platform/surface/aggregator/ssh_msgb.h
index f3ecad92eefd..438873e06098 100644
--- a/drivers/platform/surface/aggregator/ssh_msgb.h
+++ b/drivers/platform/surface/aggregator/ssh_msgb.h
@@ -189,8 +189,8 @@ static inline void msgb_push_cmd(struct msgbuf *msgb, u8 seq, u16 rqid,
 
 	__msgb_push_u8(msgb, SSH_PLD_TYPE_CMD);		/* Payload type. */
 	__msgb_push_u8(msgb, rqst->target_category);	/* Target category. */
-	__msgb_push_u8(msgb, rqst->target_id);		/* Target ID (out). */
-	__msgb_push_u8(msgb, 0x00);			/* Target ID (in). */
+	__msgb_push_u8(msgb, rqst->target_id);		/* Target ID. */
+	__msgb_push_u8(msgb, SSAM_SSH_TID_HOST);	/* Source ID. */
 	__msgb_push_u8(msgb, rqst->instance_id);	/* Instance ID. */
 	__msgb_push_u16(msgb, rqid);			/* Request ID. */
 	__msgb_push_u8(msgb, rqst->command_id);		/* Command ID. */
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index 69132976d297..90634dcacabf 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -920,13 +920,14 @@ static void ssh_rtl_rx_command(struct ssh_ptl *p, const struct ssam_span *data)
 	 * Check if the message was intended for us. If not, drop it.
 	 *
 	 * Note: We will need to change this to handle debug messages. On newer
-	 * generation devices, these seem to be sent to tid_out=0x03. We as
-	 * host can still receive them as they can be forwarded via an override
-	 * option on SAM, but doing so does not change tid_out=0x00.
+	 * generation devices, these seem to be sent to SSAM_SSH_TID_DEBUG. We
+	 * as host can still receive them as they can be forwarded via an
+	 * override option on SAM, but doing so does not change the target ID
+	 * to SSAM_SSH_TID_HOST.
 	 */
-	if (command->tid_out != 0x00) {
+	if (command->tid != SSAM_SSH_TID_HOST) {
 		rtl_warn(rtl, "rtl: dropping message not intended for us (tid = %#04x)\n",
-			 command->tid_out);
+			 command->tid);
 		return;
 	}
 
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index d11a1c6e3186..8932bc0bae18 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -912,10 +912,10 @@ enum ssam_event_mask {
 	})
 
 #define SSAM_EVENT_REGISTRY_SAM	\
-	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_SAM, 0x01, 0x0b, 0x0c)
+	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_SAM, SSAM_SSH_TID_SAM, 0x0b, 0x0c)
 
 #define SSAM_EVENT_REGISTRY_KIP	\
-	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_KIP, 0x02, 0x27, 0x28)
+	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_KIP, SSAM_SSH_TID_KIP, 0x27, 0x28)
 
 #define SSAM_EVENT_REGISTRY_REG(tid)\
 	SSAM_EVENT_REGISTRY(SSAM_SSH_TC_REG, tid, 0x01, 0x02)
diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
index 45501b6e54e8..5c4ae1a26183 100644
--- a/include/linux/surface_aggregator/serial_hub.h
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -83,23 +83,21 @@ enum ssh_payload_type {
 
 /**
  * struct ssh_command - Payload of a command-type frame.
- * @type:    The type of the payload. See &enum ssh_payload_type. Should be
- *           SSH_PLD_TYPE_CMD for this struct.
- * @tc:      Command target category.
- * @tid_out: Output target ID. Should be zero if this an incoming (EC to host)
- *           message.
- * @tid_in:  Input target ID. Should be zero if this is an outgoing (host to
- *           EC) message.
- * @iid:     Instance ID.
- * @rqid:    Request ID. Used to match requests with responses and differentiate
- *           between responses and events.
- * @cid:     Command ID.
+ * @type: The type of the payload. See &enum ssh_payload_type. Should be
+ *        SSH_PLD_TYPE_CMD for this struct.
+ * @tc:   Command target category.
+ * @tid:  Target ID. Indicates the target of the message.
+ * @sid:  Source ID. Indicates the source of the message.
+ * @iid:  Instance ID.
+ * @rqid: Request ID. Used to match requests with responses and differentiate
+ *        between responses and events.
+ * @cid:  Command ID.
  */
 struct ssh_command {
 	u8 type;
 	u8 tc;
-	u8 tid_out;
-	u8 tid_in;
+	u8 tid;
+	u8 sid;
 	u8 iid;
 	__le16 rqid;
 	u8 cid;
@@ -280,6 +278,22 @@ struct ssam_span {
 	size_t len;
 };
 
+/**
+ * enum ssam_ssh_tid - Target/source IDs for Serial Hub messages.
+ * @SSAM_SSH_TID_HOST:     We as the kernel Serial Hub driver.
+ * @SSAM_SSH_TID_SAM:      The Surface Aggregator EC.
+ * @SSAM_SSH_TID_KIP:      Keyboard and perihperal controller.
+ * @SSAM_SSH_TID_DEBUG:    Debug connector.
+ * @SSAM_SSH_TID_SURFLINK: SurfLink connector.
+ */
+enum ssam_ssh_tid {
+	SSAM_SSH_TID_HOST     = 0x00,
+	SSAM_SSH_TID_SAM      = 0x01,
+	SSAM_SSH_TID_KIP      = 0x02,
+	SSAM_SSH_TID_DEBUG    = 0x03,
+	SSAM_SSH_TID_SURFLINK = 0x04,
+};
+
 /*
  * Known SSH/EC target categories.
  *
-- 
2.38.1

