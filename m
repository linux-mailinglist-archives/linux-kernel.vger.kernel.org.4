Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A76738CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFURPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFURPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:15:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382CF19A6;
        Wed, 21 Jun 2023 10:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEqmwMRZajVHCGusKbutvSUPJN97pDQCqnhC3T/hNRRubTUZoUJnBDHP0a7sWC/X9omH4fODEVeVsec+K9Tcl8Q6O5YMeAfXXELWFXeVe/5XLQQUSLN2H0aVu2/z0YPwTopcGsizHE0d9jpouNT/R14HM54yQHy6MyeNTAQh9ORea8Md6PZGT211TknRNtQ4mTMFyk1CYFLVnd0djkijaiDlAKi7w7KVvkXZwGaYS99qSDG0yC/nF+XkF1KHt2e2VRNnsxD9i42mYRYiWya0eVZ5G/70H3tsJKlku7jOb0+RZLcA/Gg53pnRiJAnZV90iEc6ngbGqiDUODuoXf1lyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=609xD2dnEMgA7/HSkrlkczFpbKXyrhtaP3/ft9b9EUU=;
 b=VuqrBsqPYMdUnur+eMkKlSmuYCcE8x/wtCSYRjusmCfjNpKxdJfAthoYylbHqKyB6LLqH7cTcP7gSF2Pc1x19NhEIwDOtSaNM/vyyuzKxbS/GkV9eIpJOE/mC2WJZTabOOGAcMUYTP7p/HF8/SRYfMnVp/yhkl/uUlIEWxa2kXguCKSlOyXTDDEIFMekwxa6sUR8uvw2hkCF89JT8v7MLTMTuth0CJW1BogqOKGivUO2ewWz60B7uLHRLhDK0+Kd2GNRrtyz9AWlFzZWNhgkuNOQxJAjx4mAs1EEy/VKxT+j8/V0snt4Wlkz6V61PczOea5jebSQblWersfxGNOZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=609xD2dnEMgA7/HSkrlkczFpbKXyrhtaP3/ft9b9EUU=;
 b=5UH4yYoiIjUcR+Kh1kiDa2boybL5dM4DPG9tSOhvebV8KRzuuzz9muU9msPhnr0BsLKH5LCXMUEnRVJuWTSJ+Oo2xrLDoX1wiP2y6cybRqrQPwLAKCUl9xjFvrpONuGyaVUFZv4ng6OGLRh7dq68yJrI6J0+OBhT4fk+awp02jo=
Received: from CY8PR12CA0061.namprd12.prod.outlook.com (2603:10b6:930:4c::20)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 17:15:07 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::83) by CY8PR12CA0061.outlook.office365.com
 (2603:10b6:930:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 17:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.24 via Frontend Transport; Wed, 21 Jun 2023 17:15:06 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 12:15:06 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH v2 0/1] Add translation of researcher-guidelines
Date:   Wed, 21 Jun 2023 17:14:56 +0000
Message-ID: <20230621171457.443362-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BN9PR12MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f11a9c6-66db-4dbc-8468-08db727b0f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3TTxV7ThO37okDT738G+DnlpMl8zy6yDsNOD94+58U/CSqrZC6C6VB+crdhCw+h6hO/GMW+v1b6liHiVw5QICOhfSqkCReWKtk9gqilW1/w7hWUVAXKHg2FQkVRyie6rR5X62hsZaiNBYnUtN1Di3g1D6bSqCdlthoSnzw6xOaWlDQDsW98KxsLSfY3zOUpKAvmkOIrxlKYLXYIG8effSYRdIQyko15kvxsM5K53k+PmJhwGZyy/bBTis71utjjm23KlIC8fqEF/bJzwgoiuNPof80+TEKFNJQ9R0qx3705aTr+WHpNCkOtiN4/uJDLqLhJkjZR7z1vWT0Y/8QhbysuGXxy3KWvTSHeYlTwhmGsHEMEllGMtLYvdOA93X9kOiSu+8MZfYKJSeOsZO3IwDdVeoHu76Ne6MJJx4aO8kcCCy1c8Mg4Nl1HXYGZszyubTvXQA2zvxPYPOsdoHcFn2ooNI39DbaQVnbkuKPgDmZ4s/iHbNcYNSNS3jCdMtAqUp9Mp+nj7gZnhxI6Mh+YPFmekI7aDaRPMrReupzMqJeJGDwUJG9NCbOyp8nwpuEA1Mmp1Sh71PNzMCaxjEcgf+ONwvadNdWcelT9BbqK6riWH4dQtMopZAbM7M6jCsAzrN+cqIhL26HjbECA1y/gKui9d2rYk0tOZXHJX1Szsq59J2TK+s+IqKN7iBQnvnwDOjnzw1TQlOCkMm7e1N6Fwm4XkHLHU/2ePXBVh+4TJAxDOC25dK/6IggFegEQg6zv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(40460700003)(4326008)(6916009)(186003)(16526019)(2616005)(356005)(81166007)(82310400005)(86362001)(36860700001)(82740400003)(1076003)(26005)(47076005)(336012)(426003)(36756003)(54906003)(7696005)(478600001)(6666004)(40480700001)(8676002)(8936002)(41300700001)(5660300002)(2906002)(4744005)(44832011)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:15:06.9399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f11a9c6-66db-4dbc-8468-08db727b0f8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
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

From: Avadhut Naik <Avadhut.Naik@amd.com>

Add Spanish translation of Documentation/process/researcher-guidelines.rst

Changes from v1:
 (https://lore.kernel.org/linux-doc/acaf049e-640d-0a57-0e62-75aa55fb3b27@amd.com/T/#t)
 - Incorporate v1 feedbackk

Avadhut Naik (1):
  docs/sp_SP: Add translation of process/researcher-guidelines

 .../translations/sp_SP/process/index.rst      |   1 +
 .../sp_SP/process/researcher-guidelines.rst   | 152 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/researcher-guidelines.rst

-- 
2.34.1

