Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7068B6F11F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345386AbjD1Gtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345251AbjD1Gth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:49:37 -0400
Received: from www484.your-server.de (www484.your-server.de [78.47.237.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C858330F1;
        Thu, 27 Apr 2023 23:49:34 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www484.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <k.graefe@gateware.de>)
        id 1psHv7-000KXe-Jc; Fri, 28 Apr 2023 08:49:29 +0200
Received: from [2003:ca:6730:e8f8:9fd6:4f62:9dbd:374f] (helo=tethys.gateware.dom)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <k.graefe@gateware.de>)
        id 1psHv6-0005zg-Tg; Fri, 28 Apr 2023 08:49:28 +0200
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
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     =?UTF-8?q?Konrad=20Gr=C3=A4fe?= <k.graefe@gateware.de>,
        stable@vger.kernel.org
Subject: [PATCH v4 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Date:   Fri, 28 Apr 2023 08:49:04 +0200
Message-Id: <20230428064905.145858-1-k.graefe@gateware.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427115120.241954-2-k.graefe@gateware.de>
References: <20230427115120.241954-2-k.graefe@gateware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: k.graefe@gateware.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26889/Thu Apr 27 09:25:48 2023)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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

Changes since v3:
* Added documentation
* Added test cases
* Use string_upper() after conversion to simplify conversion loop
* Fixed maybe-uninitalized variable warning

Added in v3

 Documentation/core-api/printk-formats.rst | 15 ++++++++++-----
 lib/test_printf.c                         |  2 ++
 lib/vsprintf.c                            |  5 +++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index dbe1aacc79d0..1ec682bdfe94 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -298,11 +298,13 @@ MAC/FDDI addresses
 
 ::
 
-	%pM	00:01:02:03:04:05
-	%pMR	05:04:03:02:01:00
-	%pMF	00-01-02-03-04-05
-	%pm	000102030405
-	%pmR	050403020100
+	%pM	00:01:02:03:aa:bb
+	%pMR	aa:bb:03:02:01:00
+	%pMF	00-01-02-03-aa-bb
+	%pMU	00:01:02:03:AA:BB
+	%pm	00010203aabb
+	%pmR	bbaa03020100
+	%pmU	00010203AABB
 
 For printing 6-byte MAC/FDDI addresses in hex notation. The ``M`` and ``m``
 specifiers result in a printed address with (M) or without (m) byte
@@ -316,6 +318,9 @@ For Bluetooth addresses the ``R`` specifier shall be used after the ``M``
 specifier to use reversed byte order suitable for visual interpretation
 of Bluetooth addresses which are in the little endian order.
 
+For uppercase hex notation the ``U`` specifier shall be used after the ``M``
+and ``m`` specifiers.
+
 Passed by reference.
 
 IPv4 addresses
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 46b4e6c414a3..7f4de2ecafbc 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -416,9 +416,11 @@ mac(void)
 	const u8 addr[6] = {0x2d, 0x48, 0xd6, 0xfc, 0x7a, 0x05};
 
 	test("2d:48:d6:fc:7a:05", "%pM", addr);
+	test("2D:48:D6:FC:7A:05", "%pMU", addr);
 	test("05:7a:fc:d6:48:2d", "%pMR", addr);
 	test("2d-48-d6-fc-7a-05", "%pMF", addr);
 	test("2d48d6fc7a05", "%pm", addr);
+	test("2D48D6FC7A05", "%pmU", addr);
 	test("057afcd6482d", "%pmR", addr);
 }
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index be71a03c936a..c82616c335e0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1301,6 +1301,9 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 	}
 	*p = '\0';
 
+	if (fmt[1] == 'U')
+		string_upper(mac_addr, mac_addr);
+
 	return string_nocheck(buf, end, mac_addr, spec);
 }
 
@@ -2280,6 +2283,7 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  * - 'MF' For a 6-byte MAC FDDI address, it prints the address
  *       with a dash-separated hex notation
  * - '[mM]R' For a 6-byte MAC address, Reverse order (Bluetooth)
+ * - '[mM]U' For a 6-byte MAC address in uppercase hex
  * - 'I' [46] for IPv4/IPv6 addresses printed in the usual way
  *       IPv4 uses dot-separated decimal without leading 0's (1.2.3.4)
  *       IPv6 uses colon separated network-order 16 bit hex with leading 0's
@@ -2407,6 +2411,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'M':			/* Colon separated: 00:01:02:03:04:05 */
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
+					/* [mM]U (Uppercase hex) */
 					/* [mM]R (Reverse order; Bluetooth) */
 		return mac_address_string(buf, end, ptr, spec, fmt);
 	case 'I':			/* Formatted IP supported
-- 
2.34.1

