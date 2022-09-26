Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11755EA859
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiIZO0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiIZOZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:25:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C4765C7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664195863; x=1695731863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F4O/JRQEvf1m5qaZZ+4zbYvSClMWjgA/AuhrksjfPdo=;
  b=G/fAmgzvORcLqS8utt7elwF4Ag4jf6sNlMUdzr1QXhaKlGmrrg1tlE1D
   g46oNcIFDlXkrf8ai7Kbmm/otpg+7cfa/C3dNvEvHOhH2iYe4Tsoi+0PK
   MMFW0kS1NQwPoJb7UQ+FQ7M5ktY5lV7qANZDgOjCGCy0wuPzj33mjqJl3
   /fCuiUhF1ehmD/pxuJ/9ZlX+Qyl5hIaSR/ZP/B14+PaYwLHtLkTorZ5WE
   qBJYef1+6kyCtkSHKua6sDTm9w2n/NQb8K1z7bIScYtkEVJhEqz9sPLVe
   QhKqmpNGzNjInITwaK3UPvZn86eUIkrq3ObKjg/GF5WOwp46Ipsver+t2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="281388433"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="281388433"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 05:37:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="683511207"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683511207"
Received: from fmirus-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.4])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 05:37:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] serial: Convert serial_rs485 to kernel doc
Date:   Mon, 26 Sep 2022 15:37:35 +0300
Message-Id: <20220926123735.50804-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert struct serial_rs485 comments to kernel doc format.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 include/uapi/linux/serial.h | 61 +++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index cea06924b295..67d4bc663521 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -107,37 +107,56 @@ struct serial_icounter_struct {
 	int reserved[9];
 };
 
-/*
+/**
+ * struct serial_rs485 - serial interface for controlling RS485 settings.
+ * @flags:			RS485 feature flags.
+ * @delay_rts_before_send:	Delay before send (milliseconds).
+ * @delay_rts_after_send:	Delay after send (milliseconds).
+ * @addr_recv:			Receive filter for RS485 addressing mode
+ *				(used only when %SER_RS485_ADDR_RECV is set).
+ * @addr_dest:			Destination address for RS485 addressing mode
+ *				(used only when %SER_RS485_ADDR_DEST is set).
+ * @padding0:			Padding (set to zero).
+ * @padding1:			Padding (set to zero).
+ * @padding:			Deprecated, use @padding0 and @padding1 instead.
+ *				Do not use with @addr_recv and @addr_dest (due to
+ *				overlap).
+ *
  * Serial interface for controlling RS485 settings on chips with suitable
  * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by your
  * platform. The set function returns the new state, with any unsupported bits
  * reverted appropriately.
+ *
+ * serial_rs485::flags bits are:
+ * * %SER_RS485_ENABLED		- RS485 enabled.
+ * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
+ * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.
+ * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
+ * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if supported).
+ * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
+ * * %SER_RS485_ADDR_RECV	- Receive address filter (enables @addr_recv).
+ *				  Requires %SER_RS485_ADDRB.
+ * * %SER_RS485_ADDR_DEST	- Destination address (enables @addr_dest).
+ *				  Requires %SER_RS485_ADDRB.
  */
-
 struct serial_rs485 {
-	__u32	flags;			/* RS485 feature flags */
-#define SER_RS485_ENABLED		(1 << 0)	/* If enabled */
-#define SER_RS485_RTS_ON_SEND		(1 << 1)	/* Logical level for
-							   RTS pin when
-							   sending */
-#define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Logical level for
-							   RTS pin after sent*/
+	__u32	flags;
+#define SER_RS485_ENABLED		(1 << 0)
+#define SER_RS485_RTS_ON_SEND		(1 << 1)
+#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
 #define SER_RS485_RX_DURING_TX		(1 << 4)
-#define SER_RS485_TERMINATE_BUS		(1 << 5)	/* Enable bus
-							   termination
-							   (if supported) */
-
-/* RS-485 addressing mode */
-#define SER_RS485_ADDRB			(1 << 6)	/* Enable addressing mode */
-#define SER_RS485_ADDR_RECV		(1 << 7)	/* Receive address filter */
-#define SER_RS485_ADDR_DEST		(1 << 8)	/* Destination address */
+#define SER_RS485_TERMINATE_BUS		(1 << 5)
+#define SER_RS485_ADDRB			(1 << 6)
+#define SER_RS485_ADDR_RECV		(1 << 7)
+#define SER_RS485_ADDR_DEST		(1 << 8)
 
-	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
-	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
+	__u32	delay_rts_before_send;
+	__u32	delay_rts_after_send;
 
-	/* The fields below are defined by flags */
+	/* private: The fields below are defined by flags */
 	union {
-		__u32	padding[5];		/* Memory is cheap, new structs are a pain */
+		/* private: Memory is cheap, new structs are a pain. */
+		__u32	padding[5];
 
 		struct {
 			__u8	addr_recv;

-- 
tg: (2eb6f6da8b51..) rs485/kdoc (depends on: supported-fix/intro-kernel_serial_rs485_to_user_rs485)
