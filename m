Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D446CC81B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjC1QfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1QfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:35:21 -0400
X-Greylist: delayed 594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 09:35:17 PDT
Received: from 9.mo563.mail-out.ovh.net (9.mo563.mail-out.ovh.net [46.105.73.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C8AF1C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:35:17 -0700 (PDT)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
        by mo563.mail-out.ovh.net (Postfix) with ESMTPS id E872A22BCC;
        Tue, 28 Mar 2023 16:15:54 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <sven.schwermer@disruptive-technologies.com>; Tue, 28 Mar 2023 16:15:54 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.20.150])
        by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id B41B0FD6C6;
        Tue, 28 Mar 2023 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 28 Mar
 2023 18:15:54 +0200
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee.jones@linaro.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <andy.shevchenko@gmail.com>, <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH v8 1/6] devres: provide devm_krealloc_array()
Date:   Tue, 28 Mar 2023 18:15:36 +0200
Message-ID: <20230328161541.599463-2-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328161541.599463-1-jjhiblot@traphandler.com>
References: <20230328161541.599463-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX1.emp2.local (172.16.2.81) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 1349391039146637787
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepughirhgvtghtohhrfedruggvrhhprdhmrghilhdqohhuthdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehieef
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the managed variant of krealloc_array().
This internally uses devm_krealloc() and as such is usable with all memory
allocated by devm_kmalloc() (or devres functions using it implicitly like
devm_kmemdup(), devm_kstrdup() etc.).

Managed realloc'ed chunks can be manually released with devm_kfree().

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 include/linux/device.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 44e3acae7b36..a9624478ac24 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -223,6 +223,19 @@ static inline void *devm_kcalloc(struct device *dev,
 {
 	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
+static inline void *devm_krealloc_array(struct device *dev,
+					void *p,
+					size_t new_n,
+					size_t new_size,
+					gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+
+	return devm_krealloc(dev, p, bytes, flags);
+}
 void devm_kfree(struct device *dev, const void *p);
 char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
 const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
-- 
2.25.1

