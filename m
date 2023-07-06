Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB05C74A77D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGFXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGFXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:17:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EC1BC2;
        Thu,  6 Jul 2023 16:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpo6ykLbcjcm3MZr/TBgYGZp9rzFInHL74JPqAUwnPM+E44z3uyT3qBDDZqNomqq9X1V0LqrOB3UpbTTBzsF8OWob/OIMhtPK3ftqHnad1mvFOwz4lX/5hveviYvyBpwvXxzgjyl+N59WHGatSE24Fd+Jh4sWlj4XzC2NAXqZgo6cbFLvF5NzCeyfH3y4Up+5nsVUPqAtlhG0xtCBmjaR9AdN1WM5i5NnELxIqbfq5Fm39pQ8fVxL8IrM3iPDv3jdZ/1ajWRlzrHtCz7tdCdcIWsAyPYKKIQdGukbeUpy5ON25Z/B3xbc2UzGZQWcOvqmUMKdPxFMuqaHS+8HGbKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2uR+tZYMebNpdyh3FCWJEs8zmJnm06UK/gcEuzaNWU=;
 b=I5kgH6PzUUTccQgHNjwhlae8i2lp1mTBrjNHhMQUfA+zeoeEDk5V8cpHlIPqpLuiwKHL4iP+Y7pNF5H1Iwxfyb4v5YxD1ddZRa8IzO8WkiR+LTsAsZpKp6hi14hSNYiTMYBRoCm4PakvSJUfSnPYSZyblGNkCoZpEZtP+m4DQYhRckXL+u9dcqJ5z+2ubMnlnlTgUYVDA6Hqq9CcL7FgbntghAzHGAbDQsKZihXxlbGQFhaNmv6dwrpqRZGAE0w6swX5/JJAQz8xVlQPVnNa0pywUP1ExrzJ6otUTbaIxeZKGDXH3umnZjI7DRTdYuhg3kMDHUxCNiQ6xnevt3kulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2uR+tZYMebNpdyh3FCWJEs8zmJnm06UK/gcEuzaNWU=;
 b=NSReKHlbX4hPfg3Eys2UqLHXhv3J+RjjxSBPDWPmL2CQxhiSf23b2eBnbKEBttPNxg+vbNlkCh6YhURqjgtkkrKGnMSyfdvfJfocIxRjYKazm0wE8fNFaHGOjujduAYWlNSLKGQksc+t0F2nnQ+Dtn7Am514ovtAbyDz68wvyS4=
Received: from MW4PR03CA0337.namprd03.prod.outlook.com (2603:10b6:303:dc::12)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 23:17:52 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::9e) by MW4PR03CA0337.outlook.office365.com
 (2603:10b6:303:dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 23:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 23:17:52 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 18:17:50 -0500
From:   Shannon Nelson <shannon.nelson@amd.com>
To:     <rdunlap@infradead.org>, <jasowang@redhat.com>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <shannon.nelson@amd.com>, <brett.creeley@amd.com>
CC:     <netdev@vger.kernel.org>, <drivers@pensando.io>,
        <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH virtio] pds_vdpa: protect Makefile from unconfigured debugfs
Date:   Thu, 6 Jul 2023 16:17:18 -0700
Message-ID: <20230706231718.54198-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|SJ0PR12MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 776f3dd4-f7fe-42ab-5b1e-08db7e7738cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zvf2U5vb6YJG0t2a0j2qWAOzMUS6rsU93U8Esr3lcg91P+DGwOJgGOLjbcnJuZxa5n+StmIc6VYWmCosaY9DMfpQveltVMB33/0wXZwlGvsCiqHVevmsLMX+ZvO8tupBUfc8As+JaZpgQBxF6F0sT5Z6OgV77RikvB5N965GC3tAjLdsjfVGuXeH9wfsAXdill2DgDaqV66uVfXIS7gYlP9Jgn1a6hQF08zPh8WXz6Py1v5CAkEL6VXs1BLhFC8wN4RMeJDfeSUPBLHns8n93eGsRuHhA+fJnN8eETKn9ob8qhAPCPoOxY/5mN4D2U4Hdw7+/tAive0ZYXKxwbpf2BwYiTkfD+AICW0/Q35fg420YRPTamFzPxoG+++RLjK2G1mKRofaDCr0eiTTUNHpCb3zDeVhiMMkRVFgPipth50sq17UPqHmvMSqa3Wexd8RyPeggUsu60tplVEkhD7Hn3fazSp8tKkH6gbD29xvefVpV7zAsqoLwn8gHJQ/QmXzALgvviKvyfHg+VDErXzWm3vs9L0FsI2zclYXce0ZQD0J/9qe2701gwZZLLxMDZrxdAdXTv4T8xwVc2I5R6C6FKgCo7IMK8l3UTO4XsKybzxPfOXH12EPfjyJIcmS3YKiTbL7Et9xJpWvrCEyo49mQpAZbnwVl7Va0J6Z6F5PomEE/zI2fZSobEz4kHdyJ8gsoTI9Vp1+uZDCRlOVL0gtCFFnWJoBtMMA0ZznonWau6y8atnxRAEtrD1N64y3EcLz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(4744005)(5660300002)(44832011)(86362001)(2906002)(82310400005)(40460700003)(40480700001)(16526019)(966005)(47076005)(186003)(336012)(426003)(36860700001)(83380400001)(26005)(1076003)(81166007)(82740400003)(356005)(110136005)(54906003)(70206006)(70586007)(316002)(2616005)(8936002)(6636002)(8676002)(478600001)(6666004)(4326008)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 23:17:52.0659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776f3dd4-f7fe-42ab-5b1e-08db7e7738cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs.h protects itself from an undefined DEBUG_FS, so it is
not necessary to check it in the driver code or the Makefile.
The driver code had been updated for this, but the Makefile had
missed the update.

Link: https://lore.kernel.org/linux-next/fec68c3c-8249-7af4-5390-0495386a76f9@infradead.org/
Fixes: a16291b5bcbb ("pds_vdpa: Add new vDPA driver for AMD/Pensando DSC")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
index 2e22418e3ab3..c2d314d4614d 100644
--- a/drivers/vdpa/pds/Makefile
+++ b/drivers/vdpa/pds/Makefile
@@ -5,6 +5,5 @@ obj-$(CONFIG_PDS_VDPA) := pds_vdpa.o
 
 pds_vdpa-y := aux_drv.o \
 	      cmds.o \
+	      debugfs.o \
 	      vdpa_dev.o
-
-pds_vdpa-$(CONFIG_DEBUG_FS) += debugfs.o
-- 
2.17.1

