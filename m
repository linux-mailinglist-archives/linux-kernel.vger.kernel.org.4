Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654373E13C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjFZN4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjFZN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:56:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037110F9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0rEA/uEfed01/Gt7XdBcSA9QvbPhuyrvPdp9Fai05Htdjn7lEkHqAzvKXBxIG5EMQNK56o1c6IBAas3EQnH+wzFwst2Iv4uR0NdeEzIrcD7HnJZDr6eyjkLQw8wfivHQgrO0+3RHxJuogWIMKguteaIcLikk/ke5Sg46qPdjd388JTWsIdNbRGjdfaW/pWMx2glGfcw3djtYQeUsw8uDET1pw9hAJLQ6fKwYONCqlvbj06L1YwH8LZjwTjoKx+AXyGVCSw8ZS5WUAUp9cQf+LHYSAQaKXYrx59xjWbd8wnxcpZIYH4xeStNaZsVP/AON03Up0yBXF/k1SHZ2/Uttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbVU5i95L+F96yzyH8AkG3KPRyncqMw9WwG59ejN4eU=;
 b=irMsr8P28rbZ1KnPd/ut6akUHtq3X7fQWpoVPRR89172gyb8j5o+fEAy7LhWClS7HLvc2zDHvbtqifivgkwzq9Z4NVygLlBqih7duY8X8z9enEgWzjI6xhhHyJHKn9UljG/fFHkJWWIuwaGgtThmMFPVhtn4oEuxTtVPwLwPKgH71O7ncdzhixdg/Gyo2klWWS8h1hC5KFtcFr/JuSb6LYC7O6qgSqZUEZWdS1bWyE2vFUQFvDcFmUp9ks4rdKQuTqp0Nnvngr3LtBE71obKkXZQ5edwgvbLWuOFHdKDHJsP9wBmCPK5DecA0jfZMAD3md+VAU42D6lywLFvo341jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbVU5i95L+F96yzyH8AkG3KPRyncqMw9WwG59ejN4eU=;
 b=zMFuxtkcytX5vpg4vUJaq+24htUOcJY8wDnpfgVriBKDoDEHywLq5WNmiIM8PfPUQgyn363a7PgdXYnS212YnLxFmuNZXlOalbGRC+U/lguoT4bmj+prc3JQBq19RLuk5TF0J6zh4NlU3sX6xQ/gKkRqP2ETejw1o3bIPs+dP7I=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Mon, 26 Jun
 2023 13:56:29 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::3e) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 13:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 13:56:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:27 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 08:56:22 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/10] ASoC: amd: acp: store platform device reference created in pci probe call
Date:   Mon, 26 Jun 2023 19:25:08 +0530
Message-ID: <20230626135515.1252063-5-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
References: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 45658931-7192-4756-8d14-08db764d244d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQVKZb5cOHQx+w6Ojb4OdSYjbGqV93WzWsKwN2P44YlopULLfx54ktc2PO4ZiK1dL70meuo/U5Ryf7iLumpBcaOC/m+95/uLQItEHcROgNYYNEWX2KBXPC/atO2LsIR8s0KabvDTkJ+GR8RAVcm6u8nCvTjHASpS51NDq3J3ZRqhf9pQaashgQkD8k7n5QK7l7c1FKe2yCLpnBDlBl8jbxqxsKslbIDZQTyVCEZeTTWaNdkoGnt/LpvBDGtvCl4t3m+GCM74E6a371pI1o3lKkNKpbh9zE47c0jSH1IUe8H/mJ6EsdjtAXQtayQfDaKiK48iBItMYw/ouH5qC4xvPJdGQyJ8ToWuAkNERJMT1rSQ4+RriznlWXesQI2hTCjt89CDU2Q7EYhf/IvXds0aZItaF9UC6oKoc1Wj4aCawEvft4E9aSu7BYZscLQ7Bfdq+lNNsUtxOsT33KtQegcbVuYgLtkV8XIjFJXlCig7e4iiUd91EV75UXek2TdDDpMIcXVE5RiRYbJck/UNfQZOB+jIrIhpSkcGmkkbATaHWPhwQ8JCNGQXAk40tNI7qMQpjgV3hjvN3XL/GBAeBI/bleLHd9nMjfkp3O4N6Jm9r5fEgbbTM/uNdIb5lIgAsF9pLjBeXJOPjkHgJ79RTLFNciMtI7hFV1BLd4rywfR7VdigOL03PS8+i6bBHVuNcBcH687/NiTEuIwxOe2KQLLwRfGZDf5Wgvgc8OXLbrr2KpxROOzx9fLW+MhUpbMls4jZE/1Nc7xtKlx8zKbgBt0gbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(82310400005)(47076005)(478600001)(7696005)(2616005)(54906003)(426003)(110136005)(336012)(83380400001)(6666004)(1076003)(26005)(2906002)(186003)(5660300002)(70206006)(40460700003)(36756003)(356005)(4326008)(81166007)(82740400003)(70586007)(40480700001)(8936002)(8676002)(41300700001)(316002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:56:29.6209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45658931-7192-4756-8d14-08db764d244d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the platform device reference created in pci driver,
it will be used in restoring the interrupts during system level resume.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 2 +-
 sound/soc/amd/acp/amd.h     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index a51cf7f32f7d..4fedad1b740e 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -140,7 +140,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		ret = PTR_ERR(pdev);
 		goto unregister_dmic_dev;
 	}
-
+	chip->chip_pdev = pdev;
 	return ret;
 
 unregister_dmic_dev:
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 0d8c0febbbfc..f53613216397 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -115,6 +115,7 @@ struct acp_chip_info {
 	char *name;		/* Platform name */
 	unsigned int acp_rev;	/* ACP Revision id */
 	void __iomem *base;	/* ACP memory PCI base */
+	struct platform_device *chip_pdev;
 };
 
 struct acp_stream {
-- 
2.25.1

