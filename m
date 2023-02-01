Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F94A6868AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBAOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjBAOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:10 -0500
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 06:43:05 PST
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6282E0D0;
        Wed,  1 Feb 2023 06:43:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 663D9C033A;
        Wed,  1 Feb 2023 15:35:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1675262104; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=lDLZ/xjvrtcN+1CWCH6iD2koCwn6Eb1LpwYqcz6QtGM=;
        b=bZ55zZJ5eoXQhSN7w9SMB4VCaK51BKzgXkS33yOHee5bB2bhkPDekZpgtZ93c/YxCRE4lj
        ucP6wYBafqEQ4SNVYXa+DD8qqy3gnRx0R01rnQWNjyWybCCtgxv9zgv4i8Tf3tBUmv3lBP
        pFRu7HlgOucmf3Eb+CbBzy9BJLSWfwcbCA6r60JD0KySH1eEtuheqw9A4zQijH8Vq8t7k9
        nQN+AWJYpWUnuilcqLkg7GvI4deowbc2IX/ABCe8mEG/QfFOrNopolv0QVTrPFn7dSpwBg
        Ppc3o7UfL9AtjanRkaLAay/rCZYwQW21UmgD0hn7VmgT1YuFneII41Cba86oAw==
From:   Frieder Schrempf <frieder@fris.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 4/7] rtc: Move BSM defines to separate header for DT usage
Date:   Wed,  1 Feb 2023 15:34:26 +0100
Message-Id: <20230201143431.863784-5-frieder@fris.de>
In-Reply-To: <20230201143431.863784-1-frieder@fris.de>
References: <20230201143431.863784-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

To be able to use the BSM defines in the devicetree, move the defines
to a separate header within the dt-bindings directory.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 include/dt-bindings/rtc/rtc.h | 11 +++++++++++
 include/uapi/linux/rtc.h      |  6 +-----
 2 files changed, 12 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/rtc/rtc.h

diff --git a/include/dt-bindings/rtc/rtc.h b/include/dt-bindings/rtc/rtc.h
new file mode 100644
index 000000000000..b0cc06d368c0
--- /dev/null
+++ b/include/dt-bindings/rtc/rtc.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef _DT_BINDINGS_RTC_H
+#define _DT_BINDINGS_RTC_H
+
+#define RTC_BSM_DISABLED	0
+#define RTC_BSM_DIRECT		1
+#define RTC_BSM_LEVEL		2
+#define RTC_BSM_STANDBY		3
+
+#endif /* _DT_BINDINGS_RTC_H */
diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index 97aca4503a6a..9e78c17b5733 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -12,6 +12,7 @@
 #ifndef _UAPI_LINUX_RTC_H_
 #define _UAPI_LINUX_RTC_H_
 
+#include <dt-bindings/rtc/rtc.h>
 #include <linux/const.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
@@ -141,11 +142,6 @@ struct rtc_param {
 #define RTC_PARAM_CORRECTION		1
 #define RTC_PARAM_BACKUP_SWITCH_MODE	2
 
-#define RTC_BSM_DISABLED	0
-#define RTC_BSM_DIRECT		1
-#define RTC_BSM_LEVEL		2
-#define RTC_BSM_STANDBY		3
-
 #define RTC_MAX_FREQ	8192
 
 
-- 
2.39.1

