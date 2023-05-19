Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33050709323
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjESJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjESJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31819F;
        Fri, 19 May 2023 02:31:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DFE01FE32;
        Fri, 19 May 2023 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugcbMtUVSg/JEQCF/ffdQbD74DRPki/gHVZsQRV0nYo=;
        b=ACI44F4lJ7x6KsD3jha2MvlCilQFDWrPPRA0ln6EcFVdt5gMSIggfV8sn9OU8nv/vkLn07
        7oZdMXU/GmTGdJN7BycrJVqfy4Zbl1nUGBMct6RGsdZD6xZzIsgezzpBlZR5q1JvkjCbkl
        BY7uY3IQE9ou0mGegyJxWOy+mawxfeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugcbMtUVSg/JEQCF/ffdQbD74DRPki/gHVZsQRV0nYo=;
        b=Q5wt7OjMrkaLKqvvdlMbacT6kqY0pCj41ewRYNrLs05nEVM+wnqRcKxQg6LAG2sDnXTNQM
        ZoS6KuuhpyuYpKBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B84913A12;
        Fri, 19 May 2023 09:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6GEOAvZBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:34 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 07/36] ALSA: usb-audio: Define USB MIDI 2.0 specs
Date:   Fri, 19 May 2023 11:30:45 +0200
Message-Id: <20230519093114.28813-8-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230519093114.28813-1-tiwai@suse.de>
References: <20230519093114.28813-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new structs and constants from USB MIDI 2.0 specification,
to be used in the upcoming MIDI 2.0 support in USB-audio driver.

A new class-specific endpoint descriptor and group terminal block
descriptors are defined.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/linux/usb/midi-v2.h | 94 +++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 include/linux/usb/midi-v2.h

diff --git a/include/linux/usb/midi-v2.h b/include/linux/usb/midi-v2.h
new file mode 100644
index 000000000000..ebbffcae0417
--- /dev/null
+++ b/include/linux/usb/midi-v2.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * <linux/usb/midi-v2.h> -- USB MIDI 2.0 definitions.
+ */
+
+#ifndef __LINUX_USB_MIDI_V2_H
+#define __LINUX_USB_MIDI_V2_H
+
+#include <linux/types.h>
+#include <linux/usb/midi.h>
+
+/* A.1 MS Class-Specific Interface Descriptor Types */
+#define USB_DT_CS_GR_TRM_BLOCK	0x26
+
+/* A.1 MS Class-Specific Interface Descriptor Subtypes */
+/* same as MIDI 1.0 */
+
+/* A.2 MS Class-Specific Endpoint Descriptor Subtypes */
+#define USB_MS_GENERAL_2_0	0x02
+
+/* A.3 MS Class-Specific Group Terminal Block Descriptor Subtypes */
+#define USB_MS_GR_TRM_BLOCK_UNDEFINED	0x00
+#define USB_MS_GR_TRM_BLOCK_HEADER	0x01
+#define USB_MS_GR_TRM_BLOCK		0x02
+
+/* A.4 MS Interface Header MIDIStreaming Class Revision */
+#define USB_MS_REV_MIDI_1_0		0x0100
+#define USB_MS_REV_MIDI_2_0		0x0200
+
+/* A.5 MS MIDI IN and OUT Jack Types */
+/* same as MIDI 1.0 */
+
+/* A.6 Group Terminal Block Types */
+#define USB_MS_GR_TRM_BLOCK_TYPE_BIDIRECTIONAL	0x00
+#define USB_MS_GR_TRM_BLOCK_TYPE_INPUT_ONLY	0x01
+#define USB_MS_GR_TRM_BLOCK_TYPE_OUTPUT_ONLY	0x02
+
+/* A.7 Group Terminal Default MIDI Protocol */
+#define USB_MS_MIDI_PROTO_UNKNOWN	0x00 /* Unknown (Use MIDI-CI) */
+#define USB_MS_MIDI_PROTO_1_0_64	0x01 /* MIDI 1.0, UMP up to 64bits */
+#define USB_MS_MIDI_PROTO_1_0_64_JRTS	0x02 /* MIDI 1.0, UMP up to 64bits, Jitter Reduction Timestamps */
+#define USB_MS_MIDI_PROTO_1_0_128	0x03 /* MIDI 1.0, UMP up to 128bits */
+#define USB_MS_MIDI_PROTO_1_0_128_JRTS	0x04 /* MIDI 1.0, UMP up to 128bits, Jitter Reduction Timestamps */
+#define USB_MS_MIDI_PROTO_2_0		0x11 /* MIDI 2.0 */
+#define USB_MS_MIDI_PROTO_2_0_JRTS	0x12 /* MIDI 2.0, Jitter Reduction Timestamps */
+
+/* 5.2.2.1 Class-Specific MS Interface Header Descriptor */
+/* Same as MIDI 1.0, use struct usb_ms_header_descriptor */
+
+/* 5.3.2 Class-Specific MIDI Streaming Data Endpoint Descriptor */
+struct usb_ms20_endpoint_descriptor {
+	__u8  bLength;			/* 4+n */
+	__u8  bDescriptorType;		/* USB_DT_CS_ENDPOINT */
+	__u8  bDescriptorSubtype;	/* USB_MS_GENERAL_2_0 */
+	__u8  bNumGrpTrmBlock;		/* Number of Group Terminal Blocks: n */
+	__u8  baAssoGrpTrmBlkID[];	/* ID of the Group Terminal Blocks [n] */
+} __packed;
+
+#define USB_DT_MS20_ENDPOINT_SIZE(n)	(4 + (n))
+
+/* As above, but more useful for defining your own descriptors: */
+#define DECLARE_USB_MS20_ENDPOINT_DESCRIPTOR(n)			\
+struct usb_ms20_endpoint_descriptor_##n {			\
+	__u8  bLength;						\
+	__u8  bDescriptorType;					\
+	__u8  bDescriptorSubtype;				\
+	__u8  bNumGrpTrmBlock;					\
+	__u8  baAssoGrpTrmBlkID[n];				\
+} __packed
+
+/* 5.4.1 Class-Specific Group Terminal Block Header Descriptor */
+struct usb_ms20_gr_trm_block_header_descriptor {
+	__u8  bLength;			/* 5 */
+	__u8  bDescriptorType;		/* USB_DT_CS_GR_TRM_BLOCK */
+	__u8  bDescriptorSubtype;	/* USB_MS_GR_TRM_BLOCK_HEADER */
+	__u16 wTotalLength;		/* Total number of bytes */
+} __packed;
+
+/* 5.4.2.1 Group Terminal Block Descriptor */
+struct usb_ms20_gr_trm_block_descriptor {
+	__u8  bLength;			/* 13 */
+	__u8  bDescriptorType;		/* USB_DT_CS_GR_TRM_BLOCK */
+	__u8  bDescriptorSubtype;	/* USB_MS_GR_TRM_BLOCK */
+	__u8  bGrpTrmBlkID;		/* ID of this Group Terminal Block */
+	__u8  bGrpTrmBlkType;		/* Group Terminal Block Type */
+	__u8  nGroupTrm;		/* The first member Group Terminal in this block */
+	__u8  nNumGroupTrm;		/* Number of member Group Terminals spanned */
+	__u8  iBlockItem;		/* String ID of Block item */
+	__u8  bMIDIProtocol;		/* Default MIDI protocol */
+	__u16 wMaxInputBandwidth;	/* Max input bandwidth capability in 4kB/s */
+	__u16 wMaxOutputBandwidth;	/* Max output bandwidth capability in 4kB/s */
+} __packed;
+
+#endif /* __LINUX_USB_MIDI_V2_H */
-- 
2.35.3

