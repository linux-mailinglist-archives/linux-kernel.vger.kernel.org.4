Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5677A5FF03F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJNOZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJNOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:25:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D74227926;
        Fri, 14 Oct 2022 07:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbNz5K3ysNf9/16rJFpXBE5kxQCtcKUfJm+JErK+Y5IrlPFsCmeuH12JjKXtytCb3VrTQ7bzFnBuzrg4QtNabFV31mq6wrCwBUqnQQnI9e1nmM/Uhnn4IU9iL8YKBZ5msyRwmpSDVdPmlq9dKlDSjXrX0DxRfO2L11WwJugslXyAP3TxITnO38wDN/KhJdwYkZ24h4cOwlRsJYS7O3XOEQnEp0pnJmxUlLuZYjZFLxP1hwDL7NEjJjpdFexqIN+Gv59dwVnrEjTurUAhZ1e8zJMH6YYj/Cm5hlU8IeX5Nc6s5D/X6CdWB/SiJEr1TONK2VBZeptGpQfLT8iGm1YABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCtG09+zsQyIKf6/gU539ZkBKNLSsDTfxNVf0Zeln+4=;
 b=aNnw4hIqgInNfTTVOYrJE4W4/d5XMmZrIJMMkV5ZwrC245fPBW8Ck6fPypnMUg2wKvY62T11+CQdSOc5br9S/A/mxEL8YepitaQJcrGmxXmuiSFbUw7ysRzDP77vbq0jZWz1vL6V9fsRtnIN7g40wt3sMXs2GklkVXFx7GRk4h31vsVI8nPePfI3V8pduKa7ivY3fWL45aXw1JoIPyxQH1iv7UD+dpIUmLIosoxsnmD4y1J0eYqbHbVGTqf91dp7efA/wjZpFx7slyIe2W/cgxLERMMDEWqNTjxI0rBCzOXyxOXK+ybOmxtZAbGhn6+SQk1WQl3wzGPtSCo/1byIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCtG09+zsQyIKf6/gU539ZkBKNLSsDTfxNVf0Zeln+4=;
 b=pFHdHbYoLxBpMj3M6f4M7bi/yvw/cdGOzfzIGzc6ZNAtjJL9d+BHdbRdX1AccHsosGGiw48zjF6ACqzyz3LxfV7HKK7+g9T3zJHcji6um7w2yO5SlLtI7nkndy/Tam7QBrlJNL9SGcLa3He2ktW1fecFdHmHozw9hq97S1yupZw=
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 14:24:57 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::28) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Fri, 14 Oct 2022 14:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 14:24:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 09:24:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 07:24:55 -0700
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 14 Oct 2022 09:24:54 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 0/2] Documentation: Start Spanish translation and include HOWTO
Date:   Fri, 14 Oct 2022 09:24:52 -0500
Message-ID: <20221014142454.871196-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013184816.354278-1-carlos.bilbao@amd.com>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 7236bab8-65f4-4e18-a7a8-08daadefde6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjkpE0ECDDB0hbGMQllk6ddClmxeaQ0YURw+ZKBRol8elfl/RMNItBp+vchS4J1Y33AUDq9QaToF49Q2A5WzjFqlIGH3UVJSpjJAQegA8CD0CrJJbb206Z/2Tr386zo7iparX44ND5coZNRdYLln4gFTkKeBqMBmbtzrh4lQAO7HMn+c2hAbDqLFGjbUHYA2RiMbh1krDT6JvwoULHHAQjTy8yDcr5TPjIdKQW7OFeDxZFW4G9A9jtbJdSVzqKAknOPzoPgOYFfZQ0dP/aYZMmYDGchaDHnjs44kXjQOyY1p2mKbmjXYzlhu5ZFGQexsAsga38wagUOCLYrISQSUZYQ9kWDz3xU2rka8YxjvagPTCJe83xOonUw/DKontcLhMzgZ6DtgkLGmCJBRwy4pOt2y6c/07XKXnZ1/Z9+X0Yv9aWC2dvnVATDPg1SfnXFrPHuwH9WY5Leh6e96NgvRbus76hqiEeDSEsEdzehbzuquBptPyk/gLyufRjbUAO/+h4l0qAlIdH4EGy3VMEN0zXu/ub6UcR4wsdunbw2cREhMC6qS4Af5r3J+ASNgj55VsJILCZX8Lb8netjQ7eXEOYu2RwgalP/AtvYIHTaNl4jmVdOL1bo8WfBBiNhgR/tobLKrOBMB/Yke7v1+zqj36vjWtaAVY48MtTKEeqBWAKJPbtMf/aysNUaAHskzlqPjoBesmmvHegnZpLIdgMzyKAsVxOB6p6w7aVjvNJhs572+xgIuFjlevLnT0vy+Oa70P6aLk9pVpcIYd/jZX18sO8C6GlrHffQxuOHTAm0USQA1ijKC5n/QKXpzv+Ag6Zu5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(478600001)(8676002)(4326008)(81166007)(26005)(7696005)(41300700001)(44832011)(2616005)(4744005)(1076003)(5660300002)(8936002)(336012)(186003)(2906002)(426003)(47076005)(83380400001)(36756003)(36860700001)(82740400003)(82310400005)(356005)(40480700001)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 14:24:56.5145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7236bab8-65f4-4e18-a7a8-08daadefde6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spanish is the second most spoken language in the world. This patch set
starts the process of translating critical kernel documentation into the
Spanish language.

Changes since v1:
  - Added me as MAINTAINER
  - Fixed warnings of kernel test robot
  - Use imperative form in second commit
  - Improved minor translation details

Carlos Bilbao (2):
  Documentation: Start translations to Spanish
  Documentation: Add HOWTO Spanish translation into rst based build system

  Documentation/translations/index.rst          |   1 +
  .../translations/sp_SP/disclaimer-sp.rst      |   6 +
  Documentation/translations/sp_SP/howto.rst    | 617 ++++++++++++++++++
  Documentation/translations/sp_SP/index.rst    |  80 +++
  MAINTAINERS                                   |   5 +
  5 files changed, 709 insertions(+)
  create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
  create mode 100644 Documentation/translations/sp_SP/howto.rst
  create mode 100644 Documentation/translations/sp_SP/index.rst
