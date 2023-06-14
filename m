Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2972FB31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjFNKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjFNKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:37:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F77A7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLpFdeyX0wVQGWobteFLw8uRReUKgf7dmudj7THNYGy6o3/KKeff3WmeDaV388zANY4jQLcbovP9R29HQhGfVhaJ3fBxxfg/JKrAvmxRX8pPJCG0CTYyW/xFdcb6rszsK1YrbXy3P+gQxnBE8SmFPyx2SeTOi2Lg3HsCWnxtJ77d3bbCrd8tLz7EDpilhcNJPz7erd3u5Lj4O7JwLYueMgLkiT/lSFQgqsd5+u2+nBziUpReX38U++Jx/ldxaEpo5kougLW4bp4iaY9G/SxBlUvyx5PwXt5OTw3/Qw80EL3ya0iOQmnNyXutLiqZY/NiZG1QMukJAnxeTpd0dSPsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiMHjPGW2Wje+Cj3oFfNZUgOCuSGvkV/UBqBNcUk8JM=;
 b=DpIPU1C063n3YxvKHCikamx4XROi08TxrpqiYEfE1Q3Wsi1Bhd0eElMwMscUnqwjz2tBlXJFlndjNPRUMING8faRO6HCC6zfcE1wfT4BejqfdPOxZHmjqsnrmp9NxQ/U7EvWau9+QvSo5ybZbi67mSykTCAWLVAfcCW7QI/HdG2lJ2k3Ze0EcP/LprgqO9LuAk70+OKD2BRPF+EaRiC8gv3wwA3vRxK55MSWEAvJNNwObhV8aROymoL3KxDEVAq8mIVhVwlFlGgMt1bMe2ao3Jho5xJnJbk85DcwfLBGFoKwl3Q74/g/QRt7jKRd6pvxhSFQeA7NgM9SQr+3IWP2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiMHjPGW2Wje+Cj3oFfNZUgOCuSGvkV/UBqBNcUk8JM=;
 b=jSVxDIGtMwLAoo8gDSGjLWiFWCnmoxzOUIK6IbjL5TFK406gK909nGKyujsL29T8W/0+y3+NIH9NbnmVB25wTFI4wvH/lF7nLDUUcD0kmLZKHk9M6quDQ3dkuyZFXEzrIqlb+DlNAgsqg8DMKfTcrUBmhUCDx662Op/D8EGb4KA=
Received: from BYAPR07CA0102.namprd07.prod.outlook.com (2603:10b6:a03:12b::43)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Wed, 14 Jun
 2023 10:37:20 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:12b:cafe::f0) by BYAPR07CA0102.outlook.office365.com
 (2603:10b6:a03:12b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 10:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 10:37:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 05:37:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 05:37:19 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Wed, 14 Jun 2023 05:37:08 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <syed.sabakareem@amd.com>, <mastan.katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: SOF: amd: Add support for IPC with a reply_size set to zero
Date:   Wed, 14 Jun 2023 16:07:05 +0530
Message-ID: <20230614103707.2246296-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: f435a0dc-52de-4bbd-3049-08db6cc35507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkIbKINLp9VvJ3oJS6BJHPvzQ84CCUo185OT2Bi7Sdc1ccdjyYYpgyQGGj7uKaDK5yxE0yUWP+/IwjbStA5QKO0vFKdxiANCzXbeuprESK2x1eILuSogUGUMQLGtiwWd4iM8h1qLAGQyNJSMaRjSLaOGg3cnB6FLtJ/8JkQrCgMcdBsL6r3O6z9gqe69ciY5D6Pv0hFUFYCMipXXBHhjAp9CvZP5T3Dlqw/vBtH57yPIeWYflpxT09zsUixQpsHRNniyuL50hc1j2r793b41VJ6cUKEvz13ft0BZHfHQ5APd9G0K+uH6BziA5ozluLevleVgtlYy5G0KtA/CI+brama4steWe9F+SJnY5dKTmi7nxHPoennE2qa+PUEhYlMxdKcXCemouGePDeFOwxgl4X17fZZqtKycZeSV8Crbkv1FKGne5g5iwvmbMmpp4mqIAbA4+Ml5WfwdF9ViB0sqWS7rZwwZRhQYk4nt+aHb+AuUK+upA2j+IYt+mvrKOBOpUA6qb13vHIDVcu75B+0M6Tb6TFwTLzaeFOvQSVJytKTYYdL24S3GYoRwSepIWc/yEKt/y99u44H3Ya0lT0AAdpr2KaEH5WITBDZY14vvuowOiuEKrpAaFnSwYcAekIIdvSCMT2btQ4zJLLHBrJwru0fYEZZC+Zwl/X9PLG0Zb5e1SSb40J6v0cfeWpu4sVXAa6NpiYpCHOjVz1QAP4JVjxdIzqOQLdE8IcaJ1Lrhnkr+LhJh0G7fHrWwpnjxssHRNe9Ntnzypj2LafxPMZTw/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(110136005)(36756003)(41300700001)(6666004)(316002)(7696005)(5660300002)(8936002)(70586007)(478600001)(54906003)(8676002)(70206006)(4326008)(82310400005)(7416002)(86362001)(47076005)(186003)(40460700003)(26005)(1076003)(82740400003)(356005)(4744005)(2906002)(2616005)(36860700001)(81166007)(336012)(426003)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 10:37:20.3076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f435a0dc-52de-4bbd-3049-08db6cc35507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for IPC tx_message with a reply_size set to zero,
return zero when message reply_size is zero at acp_dsp_ipc_get_reply().

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/sof/amd/acp-ipc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 749e856dc601..8a0fc635a997 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -130,6 +130,13 @@ static void acp_dsp_ipc_get_reply(struct snd_sof_dev *sdev)
 		memcpy(msg->reply_data, &reply, sizeof(reply));
 		ret = reply.error;
 	} else {
+		/*
+		 * To support an IPC tx_message with a
+		 * reply_size set to zero.
+		 */
+		if (!msg->reply_size)
+			goto out;
+
 		/* reply correct size ? */
 		if (reply.hdr.size != msg->reply_size &&
 		    !(reply.hdr.cmd & SOF_IPC_GLB_PROBE)) {
-- 
2.25.1

