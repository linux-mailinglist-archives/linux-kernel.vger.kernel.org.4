Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA75B340A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiIIJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiIIJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:33:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60137.outbound.protection.outlook.com [40.107.6.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6D12169F;
        Fri,  9 Sep 2022 02:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdQ8z3Yb2sIb6MaZejIhaHp4+VQ3jdOkHJd+QXevLG0UasN+2kt+Xd0bW541rrsrF/J612lzUq64fQZcVIgXhPOBIs/1yRXVoH4jIb94C/vxF8suJaXGW8uceWJCxmBvLbF5T/HFvctJepHxULljWS02e9R5kx4ylUJlpet0qyHyAvR5dUNplsXlUxBeLjnClJNCa88pJIeraNUjHmMHJ1K+8jK/3EdLilVN115gx3e2s4vwuw/SrQslT6yMMOyOTlVtLCvSl0shuz71PkgrRM5qiMgpgkq7LeQtfZZCtwhGcLe/Nahb20hHVst11ZWwbn4/5wrhyOaAsqWW6xscYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEcJPi4IHwRqO90LgmNp/TvlhR1DzQakJL9Wwot/XIU=;
 b=W2fo+TpkmSAaUtXkPEJPhvv6ECk1Wc/wxaWzLZF5jcWcCSHgfXK+OakeSSFIE+fVfaMlKUyvYnFm17H9Rp231I9xiRQD9R3XvcvqpHnINwQjUovxTWaJbWn8w3n58f2duXGfg2I9hcnXq2F85WqORSSDojhdAzlU4Q0ViTm1zbo8NYTjhaT5mL3IJxuKze5jm85mQMbsbl1UimxEMAXmjruFuWNg4XrkF6uG2f1pGtWZFmFuluG37ZIadH4GJOAjWxLkQlFZFYmcQR4qCmr4Zbv3SN0h/JoKYqrdeRTryjckM9bZjurrwDs/K+QUme49jrfimNH3v45HGC937BMkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=alpha.franken.de smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEcJPi4IHwRqO90LgmNp/TvlhR1DzQakJL9Wwot/XIU=;
 b=F0y74jjJcxfCGf92LCyNSF6XUdFSG3owJUY15EWPj/M87JtSlrbUQNL6bDeCwbDQ41+opIcfeS+EKCb9FQ3+iD0w4proe+5ULq6PchnBfay2hidXoLynCaLzg3bJlA6uMQ4cdj2fT0svnnZ2Iw7fhW1IyfOcVBVDAkcpwF2Iw+w=
Received: from DU2P250CA0025.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::30)
 by PR3PR07MB6682.eurprd07.prod.outlook.com (2603:10a6:102:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 09:30:47 +0000
Received: from DBAEUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:231:cafe::61) by DU2P250CA0025.outlook.office365.com
 (2603:10a6:10:231::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20 via Frontend
 Transport; Fri, 9 Sep 2022 09:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DBAEUR03FT030.mail.protection.outlook.com (100.127.142.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 09:30:46 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 2899UjHn027590;
        Fri, 9 Sep 2022 09:30:45 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v2] mips: Select SPARSEMEM_EXTREME
Date:   Fri,  9 Sep 2022 11:30:42 +0200
Message-Id: <20220909093042.23071-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT030:EE_|PR3PR07MB6682:EE_
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 116805ed-0c98-427b-e8e2-08da9245f9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WilyZ46ytDORKthrWfUdmOVVJzx/fF6J0SyjMcX/RvGW9IQlH4rzaZSvR5VzTOYcViNHWCgGCoAhBnAxaAKlY+o0lqDuZdPmatGmxFy7QyIl5vwnXisIa2w4u9QC0DpTLwnAj4CWPShCtmHZPosRUu0sU6bXvKMvViVnmoiFhoW2XKJZkEPnCMoXICCLNfh50/TdE25jwwEnq7HR0Md2KeQlhes6GHw/Ewb/k3/xSr3EL5buLxeI/pmyV3K1h5T56c2zBwu50N0Z3OxmOwok/DhPSxSdat902RvIqaGw4uIv9HdfJnLVsbgMn7AUcJZ8lOqIUC8LknI2RZV5/Cj/CSJa9ep+eujdBYXh2QJ7j5M0EtddmBy0/N7djhJRn5pqGacsDjPvqU3uLagSfrtsmSt6N0XB/rsaF6sXyzvrS/osrjFCNYcfyLS0SD0hxUzF8FuZhtytNXB/k6EAW8YijtfjlZleq5CODaOy3e+22IewRlYgwgJ+ctmzQC1jV/SSXIekLYAkV+Q1OZhrX9boPwzK1NKMftQM8e8fA/di45tQ8mk2xtfR/gIcqLx5jnbxVaRIhNuhMGBs5zeHgVEA1lxmlWkZxz+uzXZGSdSt02DSE4nmVWUMNi26qIVTAAWyNWY+MnVbDwyP6oQakL1igGSz/UDWObRDRv/TzB4/kRZnUha1eA2z7H7+E9ZmGosXiANaDZ/ZmOyHXJ0KXnz4Mp0q+Cv+0DzrrMyX2eLZMr6mmQWr/VwY3GjlqZfR+fBYRYPp4fpmR0/RYUZphpLXH4jNkqsXtBnZQwzXvttm0jQ=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(26005)(478600001)(6666004)(41300700001)(83380400001)(186003)(1076003)(47076005)(4744005)(2906002)(8936002)(2616005)(5660300002)(82310400005)(316002)(336012)(40480700001)(54906003)(6916009)(40460700003)(356005)(70586007)(8676002)(70206006)(82960400001)(4326008)(81166007)(36756003)(86362001)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6682
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Commit c46173183657 ("MIPS: Add NUMA support for Loongson-3") has increased
.bss size of the Octeon kernel from 16k to 16M. Providing the conditions
for SPARSEMEM_EXTREME avoids the waste of memory.

Thomas has tested the loogsoon64 kernel, where .bss is being reduced by
this patch from 16.5M to 515k.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ec21f89..25dd4c5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2669,7 +2669,6 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	bool
-	select SPARSEMEM_STATIC if !SGI_IP27
 
 config NUMA
 	bool "NUMA Support"
-- 
2.10.2

