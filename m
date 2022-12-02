Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220466410AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiLBWdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiLBWdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:33:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBEDEC0AE;
        Fri,  2 Dec 2022 14:33:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r26so8206509edc.10;
        Fri, 02 Dec 2022 14:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKtY0PCIbwOrLL3mI4KdSnkCzj1WtOxnZ//2cdus9tE=;
        b=fV9QYuMo7r8ovhJQx4HRp3/8U5kAGujDa/A8VSel4cQlwVJtGZg3rH4u+jWD8aCLAN
         rv5j8kYAvXk5am4ZoHdSY6Z5JFcNdItahMKtIbGnog7Ktxc69AJKLYD+huaGycbi2yrB
         8/ESqaWyh/bOJVLjGatXhrTwm3JHXidlX7kC/ARYsZqy2Us/6srLtcMEatZKYEZpteFO
         jhCj3EMdy1ElqlkzsIVu9XVSr/XBkL2r2jMx2RHDv1nT3pmVb82okJAyqJhuJ/w2onSi
         pThUlDm/4A8vQSGgikhRV6rPSTB6ao5e5F/pOEI/1+LA/jOUd5CPa4zl+ujKC1/KCXOO
         T6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKtY0PCIbwOrLL3mI4KdSnkCzj1WtOxnZ//2cdus9tE=;
        b=WEFG9Ow1vuG6Ryy+d16wLIdxuH4+G39Ld1pQh+vrOERQRDA0erM+6YMGjsW9iSWOG7
         aJJ8AaJGwJxsgbe+P4BmW41VDD1VkLDlePO78bBgET/psrtPWX0vPLx9znGbd+D6EGtv
         uBSqaGsQnLcC3S0xv1bPZTVmRcHcIHdRWiA15u+HLcKIu/+rcILj7+Va6c2cNdAUBzuN
         oCA1nxlvPMd4zjYcYD3qZoCjs0RjB4wHb10vCpBG0B8glIS2IMY4fbrhKWcum8JBssan
         C7KqP+du8zp8iQrAl+E+v+53FuEdVaQvKY5mzL59kWur5SWc7KhTwQGP3z1+liH2hWJW
         4Scw==
X-Gm-Message-State: ANoB5pmr7x/OPkncX8bUb2GwdnSaAC7J8A5L7xKYdSPAqHJWMknj/Ign
        9OgK0ZCQwtln6yQX2aa0X3k=
X-Google-Smtp-Source: AA0mqf6gYaHpgdG60QQdrhpbzY4l8e7eNstPWqagpSECCxThLI38EofHeNpogbcvq+h7FH+UMYWjFg==
X-Received: by 2002:aa7:c055:0:b0:45a:1af2:ed6d with SMTP id k21-20020aa7c055000000b0045a1af2ed6dmr50115866edo.364.1670020420656;
        Fri, 02 Dec 2022 14:33:40 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:40 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] platform/surface: aggregator: Add target and source IDs to command trace events
Date:   Fri,  2 Dec 2022 23:33:21 +0100
Message-Id: <20221202223327.690880-4-luzmaximilian@gmail.com>
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

Add command source and target IDs to trace events.

Tracing support for the Surface Aggregator driver was originally
implemented at a time when only two peers were known: Host and SAM. We
now know that there are at least five, with three actively being used
(Host, SAM, KIP; four with Debug if you want to count manually enabling
that interface). So it makes sense to also explicitly name the peers
involved when tracing.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/trace.h | 73 +++++++++++++++++++--
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/surface/aggregator/trace.h b/drivers/platform/surface/aggregator/trace.h
index 2a2c17771d01..55cc61bba1da 100644
--- a/drivers/platform/surface/aggregator/trace.h
+++ b/drivers/platform/surface/aggregator/trace.h
@@ -96,6 +96,7 @@ TRACE_DEFINE_ENUM(SSAM_SSH_TC_POS);
 #define SSAM_SEQ_NOT_APPLICABLE		((u16)-1)
 #define SSAM_RQID_NOT_APPLICABLE	((u32)-1)
 #define SSAM_SSH_TC_NOT_APPLICABLE	0
+#define SSAM_SSH_TID_NOT_APPLICABLE	((u8)-1)
 
 #ifndef _SURFACE_AGGREGATOR_TRACE_HELPERS
 #define _SURFACE_AGGREGATOR_TRACE_HELPERS
@@ -150,12 +151,44 @@ static inline u32 ssam_trace_get_request_id(const struct ssh_packet *p)
 	return get_unaligned_le16(&p->data.ptr[SSH_MSGOFFSET_COMMAND(rqid)]);
 }
 
+/**
+ * ssam_trace_get_request_tid() - Read the packet's request target ID.
+ * @p: The packet.
+ *
+ * Return: Returns the packet's request target ID (TID) field if the packet
+ * represents a request with command data, or %SSAM_SSH_TID_NOT_APPLICABLE
+ * if not (e.g. flush request, control packet).
+ */
+static inline u32 ssam_trace_get_request_tid(const struct ssh_packet *p)
+{
+	if (!p->data.ptr || p->data.len < SSH_COMMAND_MESSAGE_LENGTH(0))
+		return SSAM_SSH_TID_NOT_APPLICABLE;
+
+	return get_unaligned_le16(&p->data.ptr[SSH_MSGOFFSET_COMMAND(tid)]);
+}
+
+/**
+ * ssam_trace_get_request_sid() - Read the packet's request source ID.
+ * @p: The packet.
+ *
+ * Return: Returns the packet's request source ID (SID) field if the packet
+ * represents a request with command data, or %SSAM_SSH_TID_NOT_APPLICABLE
+ * if not (e.g. flush request, control packet).
+ */
+static inline u32 ssam_trace_get_request_sid(const struct ssh_packet *p)
+{
+	if (!p->data.ptr || p->data.len < SSH_COMMAND_MESSAGE_LENGTH(0))
+		return SSAM_SSH_TID_NOT_APPLICABLE;
+
+	return get_unaligned_le16(&p->data.ptr[SSH_MSGOFFSET_COMMAND(sid)]);
+}
+
 /**
  * ssam_trace_get_request_tc() - Read the packet's request target category.
  * @p: The packet.
  *
  * Return: Returns the packet's request target category (TC) field if the
- * packet represents a request with command data, or %SSAM_TC_NOT_APPLICABLE
+ * packet represents a request with command data, or %SSAM_SSH_TC_NOT_APPLICABLE
  * if not (e.g. flush request, control packet).
  */
 static inline u32 ssam_trace_get_request_tc(const struct ssh_packet *p)
@@ -232,8 +265,18 @@ static inline u32 ssam_trace_get_request_tc(const struct ssh_packet *p)
 		{ SSAM_RQID_NOT_APPLICABLE,		"N/A" }		\
 	)
 
-#define ssam_show_ssh_tc(rqid)						\
-	__print_symbolic(rqid,						\
+#define ssam_show_ssh_tid(tid)						\
+	__print_symbolic(tid,						\
+		{ SSAM_SSH_TID_NOT_APPLICABLE,		"N/A"      },	\
+		{ SSAM_SSH_TID_HOST,			"Host"     },	\
+		{ SSAM_SSH_TID_SAM,			"SAM"      },	\
+		{ SSAM_SSH_TID_KIP,			"KIP"      },	\
+		{ SSAM_SSH_TID_DEBUG,			"Debug"    },	\
+		{ SSAM_SSH_TID_SURFLINK,		"SurfLink" }	\
+	)
+
+#define ssam_show_ssh_tc(tc)						\
+	__print_symbolic(tc,						\
 		{ SSAM_SSH_TC_NOT_APPLICABLE,		"N/A"  },	\
 		{ SSAM_SSH_TC_SAM,			"SAM"  },	\
 		{ SSAM_SSH_TC_BAT,			"BAT"  },	\
@@ -313,6 +356,8 @@ DECLARE_EVENT_CLASS(ssam_command_class,
 	TP_STRUCT__entry(
 		__field(u16, rqid)
 		__field(u16, len)
+		__field(u8, tid)
+		__field(u8, sid)
 		__field(u8, tc)
 		__field(u8, cid)
 		__field(u8, iid)
@@ -320,14 +365,18 @@ DECLARE_EVENT_CLASS(ssam_command_class,
 
 	TP_fast_assign(
 		__entry->rqid = get_unaligned_le16(&cmd->rqid);
+		__entry->tid = cmd->tid;
+		__entry->sid = cmd->sid;
 		__entry->tc = cmd->tc;
 		__entry->cid = cmd->cid;
 		__entry->iid = cmd->iid;
 		__entry->len = len;
 	),
 
-	TP_printk("rqid=%#06x, tc=%s, cid=%#04x, iid=%#04x, len=%u",
+	TP_printk("rqid=%#06x, tid=%s, sid=%s, tc=%s, cid=%#04x, iid=%#04x, len=%u",
 		__entry->rqid,
+		ssam_show_ssh_tid(__entry->tid),
+		ssam_show_ssh_tid(__entry->sid),
 		ssam_show_ssh_tc(__entry->tc),
 		__entry->cid,
 		__entry->iid,
@@ -430,6 +479,8 @@ DECLARE_EVENT_CLASS(ssam_request_class,
 		__field(u8, tc)
 		__field(u16, cid)
 		__field(u16, iid)
+		__field(u8, tid)
+		__field(u8, sid)
 	),
 
 	TP_fast_assign(
@@ -439,16 +490,20 @@ DECLARE_EVENT_CLASS(ssam_request_class,
 		__entry->state = READ_ONCE(request->state);
 		__entry->rqid = ssam_trace_get_request_id(p);
 		ssam_trace_ptr_uid(p, __entry->uid);
+		__entry->tid = ssam_trace_get_request_tid(p);
+		__entry->sid = ssam_trace_get_request_sid(p);
 		__entry->tc = ssam_trace_get_request_tc(p);
 		__entry->cid = ssam_trace_get_command_field_u8(p, cid);
 		__entry->iid = ssam_trace_get_command_field_u8(p, iid);
 	),
 
-	TP_printk("uid=%s, rqid=%s, ty=%s, sta=%s, tc=%s, cid=%s, iid=%s",
+	TP_printk("uid=%s, rqid=%s, ty=%s, sta=%s, tid=%s, sid=%s, tc=%s, cid=%s, iid=%s",
 		__entry->uid,
 		ssam_show_request_id(__entry->rqid),
 		ssam_show_request_type(__entry->state),
 		ssam_show_request_state(__entry->state),
+		ssam_show_ssh_tid(__entry->tid),
+		ssam_show_ssh_tid(__entry->sid),
 		ssam_show_ssh_tc(__entry->tc),
 		ssam_show_generic_u8_field(__entry->cid),
 		ssam_show_generic_u8_field(__entry->iid)
@@ -474,6 +529,8 @@ DECLARE_EVENT_CLASS(ssam_request_status_class,
 		__field(u8, tc)
 		__field(u16, cid)
 		__field(u16, iid)
+		__field(u8, tid)
+		__field(u8, sid)
 	),
 
 	TP_fast_assign(
@@ -484,16 +541,20 @@ DECLARE_EVENT_CLASS(ssam_request_status_class,
 		__entry->rqid = ssam_trace_get_request_id(p);
 		__entry->status = status;
 		ssam_trace_ptr_uid(p, __entry->uid);
+		__entry->tid = ssam_trace_get_request_tid(p);
+		__entry->sid = ssam_trace_get_request_sid(p);
 		__entry->tc = ssam_trace_get_request_tc(p);
 		__entry->cid = ssam_trace_get_command_field_u8(p, cid);
 		__entry->iid = ssam_trace_get_command_field_u8(p, iid);
 	),
 
-	TP_printk("uid=%s, rqid=%s, ty=%s, sta=%s, tc=%s, cid=%s, iid=%s, status=%d",
+	TP_printk("uid=%s, rqid=%s, ty=%s, sta=%s, tid=%s, sid=%s, tc=%s, cid=%s, iid=%s, status=%d",
 		__entry->uid,
 		ssam_show_request_id(__entry->rqid),
 		ssam_show_request_type(__entry->state),
 		ssam_show_request_state(__entry->state),
+		ssam_show_ssh_tid(__entry->tid),
+		ssam_show_ssh_tid(__entry->sid),
 		ssam_show_ssh_tc(__entry->tc),
 		ssam_show_generic_u8_field(__entry->cid),
 		ssam_show_generic_u8_field(__entry->iid),
-- 
2.38.1

