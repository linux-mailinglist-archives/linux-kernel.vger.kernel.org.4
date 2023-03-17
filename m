Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3ED6BE839
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCQLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCQLeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:34:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910BA8C55
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so4861236pjt.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znKfKtHV6TgFWLrDIG0H6CwhrMa6Sg0ibY+beHEykvU=;
        b=ueqNZvZn+HPM/j87SWRqQzkqDAM75u9n1eh0Ej8ZqQ5w4ZsnWheJsDzwp60Jtezhyo
         OC4CifyjKZYzPQM7wNV4Lez3j5u55SR2ZzclpJBDyp0CYKTJ2SwQXtWvlWj2cvmdY97a
         +STY2TuVveQdjgZTYR1ozzT1wSJccym7hxbInqTZlbtbmTDETsP6cnPm7y4Z8BH/WsTo
         n85euSBP3Bf1kLhUjXNKrY9E3kX0IqwZIP1yui7quTzz4weWt/s2YF0Y86AITyuz8EuJ
         at6v903i3AEidzNB3kh0mHbQHIBiDUF6bp2xZE/poJuVJBHDeeaZukQHOhzD6JZHJmDH
         t7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znKfKtHV6TgFWLrDIG0H6CwhrMa6Sg0ibY+beHEykvU=;
        b=Jc1VRqaGjQTlhQpFp4yITSXcokloameEpgSYEFWpbw1VCvDdSofLav5H0yVu0xefmo
         tQ66ppWt9w+51fN1q6+JMZURJu5DMxpyuOwHY0fGv7RUV5mIKMBt+1aZSidfrXYNPGn3
         LRGi7PI+i8PiXSh61F4Aeq167LtR+tLsoqvYGtfrijpacYsuURMkyZ+19HzSRhmz+rpO
         7t7q1ylnUVLLi3OJFrsce2TM6BQD9hHvPEJP5pEA6mFaqadyslcTqOehn57MPuShDS9s
         uB4tRn+xS3BcwGiDFTx9DaM77yCH3Zvh444zH5+9g1s/AQA/jupZGVRd1FtDAV2PsLtH
         hxdA==
X-Gm-Message-State: AO0yUKU1Dm0k5dbSNPMqod6MSSSxklpVAMOHP6URYhVXoMO+nZKkyfRs
        VNauRUfkXKnq0nh4JRhSHKP4dA==
X-Google-Smtp-Source: AK7set/LgrS1REaYSHbX7wy9zHzuHqlQGfTkMV7xpn0Bgj4jZ+J0GnfpGtRwL4MisMzUmi3zDFRDKg==
X-Received: by 2002:a17:90b:17cb:b0:23d:3057:12a3 with SMTP id me11-20020a17090b17cb00b0023d305712a3mr7729422pjb.27.1679052797846;
        Fri, 17 Mar 2023 04:33:17 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:33:17 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 09/11] tools: PCI: Add 'C' option to support continuous transfer
Date:   Fri, 17 Mar 2023 20:32:36 +0900
Message-Id: <20230317113238.142970-10-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new command line option 'C' to specify the number of transfers to
perform continuously. This option helps to detect problem of DMAC in DMA
transfers. By default, the number is set to 1.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/pci/pcitest.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 441b54234635..a66b28e1e65e 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -35,6 +35,7 @@ struct pci_test {
 	bool		write;
 	bool		copy;
 	unsigned long	size;
+	unsigned long	count;
 	bool		use_dma;
 };
 
@@ -115,6 +116,7 @@ static int run_test(struct pci_test *test)
 
 	if (test->write) {
 		param.size = test->size;
+		param.count = test->count;
 		if (test->use_dma)
 			param.flags = PCITEST_FLAGS_USE_DMA;
 		ret = ioctl(fd, PCITEST_WRITE, &param);
@@ -127,6 +129,7 @@ static int run_test(struct pci_test *test)
 
 	if (test->read) {
 		param.size = test->size;
+		param.count = test->count;
 		if (test->use_dma)
 			param.flags = PCITEST_FLAGS_USE_DMA;
 		ret = ioctl(fd, PCITEST_READ, &param);
@@ -139,6 +142,7 @@ static int run_test(struct pci_test *test)
 
 	if (test->copy) {
 		param.size = test->size;
+		param.count = test->count;
 		if (test->use_dma)
 			param.flags = PCITEST_FLAGS_USE_DMA;
 		ret = ioctl(fd, PCITEST_COPY, &param);
@@ -171,10 +175,13 @@ int main(int argc, char **argv)
 	/* set default size as 100KB */
 	test->size = 0x19000;
 
+	/* set default transfer count */
+	test->count = 1;
+
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:C:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -221,6 +228,9 @@ int main(int argc, char **argv)
 	case 's':
 		test->size = strtoul(optarg, NULL, 0);
 		continue;
+	case 'C':
+		test->count = strtoul(optarg, NULL, 0);
+		continue;
 	case 'd':
 		test->use_dma = true;
 		continue;
@@ -243,6 +253,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-C <count>		Number of The continuous data transfers {default: 1}\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;
-- 
2.25.1

