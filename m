Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE686F0572
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243596AbjD0MMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbjD0MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:12:37 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 05:12:10 PDT
Received: from www484.your-server.de (www484.your-server.de [78.47.237.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7898469E;
        Thu, 27 Apr 2023 05:12:10 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www484.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <k.graefe@gateware.de>)
        id 1ps0AJ-000Duo-Pn; Thu, 27 Apr 2023 13:51:59 +0200
Received: from [2003:ca:6730:e8f8:a2c4:4e1c:f83c:db4b] (helo=tethys.gateware.dom)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <k.graefe@gateware.de>)
        id 1ps0AJ-000Hyr-3H; Thu, 27 Apr 2023 13:51:59 +0200
From:   =?UTF-8?q?Konrad=20Gr=C3=A4fe?= <k.graefe@gateware.de>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>
Cc:     =?UTF-8?q?Konrad=20Gr=C3=A4fe?= <k.graefe@gateware.de>,
        stable@vger.kernel.org
Subject: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Date:   Thu, 27 Apr 2023 13:51:19 +0200
Message-Id: <20230427115120.241954-1-k.graefe@gateware.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023042625-rendition-distort-fe06@gregkh>
References: <2023042625-rendition-distort-fe06@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: k.graefe@gateware.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26889/Thu Apr 27 09:25:48 2023)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CDC-ECM specification requires an USB gadget to send the host MAC
address as uppercase hex string. This change adds the appropriate
modifier.

Cc: stable@vger.kernel.org
Signed-off-by: Konrad Gräfe <k.graefe@gateware.de>
---
Added in v3

 lib/vsprintf.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index be71a03c936a..8aee1caabd9e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1269,9 +1269,10 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 {
 	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
 	char *p = mac_addr;
-	int i;
+	int i, pos;
 	char separator;
 	bool reversed = false;
+	bool uppercase = false;
 
 	if (check_pointer(&buf, end, addr, spec))
 		return buf;
@@ -1281,6 +1282,10 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 		separator = '-';
 		break;
 
+	case 'U':
+		uppercase = true;
+		break;
+
 	case 'R':
 		reversed = true;
 		fallthrough;
@@ -1292,9 +1297,14 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 
 	for (i = 0; i < 6; i++) {
 		if (reversed)
-			p = hex_byte_pack(p, addr[5 - i]);
+			pos = 5 - i;
+		else
+			pos = i;
+
+		if (uppercase)
+			p = hex_byte_pack_upper(p, addr[pos]);
 		else
-			p = hex_byte_pack(p, addr[i]);
+			p = hex_byte_pack(p, addr[pos]);
 
 		if (fmt[0] == 'M' && i != 5)
 			*p++ = separator;
@@ -2279,6 +2289,7 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  * - 'm' For a 6-byte MAC address, it prints the hex address without colons
  * - 'MF' For a 6-byte MAC FDDI address, it prints the address
  *       with a dash-separated hex notation
+ * - '[mM]U' For a 6-byte MAC address in uppercase hex
  * - '[mM]R' For a 6-byte MAC address, Reverse order (Bluetooth)
  * - 'I' [46] for IPv4/IPv6 addresses printed in the usual way
  *       IPv4 uses dot-separated decimal without leading 0's (1.2.3.4)
@@ -2407,6 +2418,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'M':			/* Colon separated: 00:01:02:03:04:05 */
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
+					/* [mM]U (Uppercase hex) */
 					/* [mM]R (Reverse order; Bluetooth) */
 		return mac_address_string(buf, end, ptr, spec, fmt);
 	case 'I':			/* Formatted IP supported
-- 
2.34.1

