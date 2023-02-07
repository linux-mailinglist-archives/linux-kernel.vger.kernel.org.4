Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEC568CC7C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBGCNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBGCNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:13:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5571D126C1;
        Mon,  6 Feb 2023 18:13:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT7rjIYrsj11tyOxzJQDjzWo6D/GhV4x828wb8SsZ8lUHXs53URCsy/sKfT99Pa9H8uMknKn6Kx+krv1ooVH3boN0ibRIX0AzcH4y5pU7tmVGqcUcETUIuguryImdblVuk6mlxl/0zs9cyU5QiXbpomkCzXCWfJ4a3X+w00y4S3Edt+ZrWzGHPYQlvm7FUzAHV12s1mLXKs8H89sp6NPFT9lEL0H10LBOWKRUy+q5PsFo6M2MjdlFfZqlhVPB1AcdyZf0wiwJDvu91AH63bToIv4bk6+EHJzTREU4dqYG0cnyd2n1CF2v3b4J1ey4ixDpeIUSP+Ws9mqHPKdjvEARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHvSa2g4hNeOzr9M62wgTB+qUZMF+ngYbbgeM2PLVOI=;
 b=bkw1GU9m8og5ZfrGxvMLpSqG+DZdv4nK1GxZDo6FzdlZpWQbwwVpkWjv3mF+jiuw6l13C2FFJPfFSL7234uBeWBoZtuZEtvkBCuxU0/fYorZBQXINeyPfdgnIYAV1Z3xpt38nC6kZZ0dSIj50VK5uIOhQKMVZN2Vjilymg6/jpdmVJyk+qFasGUUac9EtDUwqq8GxOj7KgFkK8pWiuMBFsbAJmetpiXIBuRPryC5VpjEXQ16hJQpa9rd/EGNPB619vtyhri77hwYC4GI5PEF53iNfZODC7/WmLkOseCYPczlwi04oGmEtm9OZkmAgjvkd3/pf4fLcSNrvCl/0gKBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHvSa2g4hNeOzr9M62wgTB+qUZMF+ngYbbgeM2PLVOI=;
 b=BW5Zcguz//x3gFF+urarwHTF7MiEihDV/3q9Wh9Fgy2i/z0xLQLqkMOcMDyiLXoF50/Te+2KWO0r4+Pt0Vl5oNOy/XnE6rQqa6bdxtlx4lWMgfJjhfrCu6FEl2A82ydIl4eNWHNZZmrXYDw/yVwuS4TfRFdTeay3LeZg/2d3VYc=
Received: from MW3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:303:2b::32)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 02:13:10 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::f2) by MW3PR05CA0027.outlook.office365.com
 (2603:10b6:303:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.16 via Frontend
 Transport; Tue, 7 Feb 2023 02:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.31 via Frontend Transport; Tue, 7 Feb 2023 02:13:09 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 20:13:04 -0600
From:   Brad Larson <blarson@amd.com>
To:     <broonie@kernel.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brad@pensando.io>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v9 15/15] spi: pensando-sr: Add AMD Pensando SoC System Resource
Date:   Mon, 6 Feb 2023 18:12:56 -0800
Message-ID: <20230207021256.69115-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Y8lMNUH/lJuJPbLp@sirena.org.uk>
References: <Y8lMNUH/lJuJPbLp@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: c78fc69c-db8b-4b9a-0677-08db08b0dbe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbl0hNq+SPjUqdptVCrCmBJ2iHJqzZDr3SgrwhG/FMQlFkyvTCyTH04W6G5fK8rGcmhdktWQot7Zss4AwzdX0ktRNXLvnTT3RtAHFqzEgLwyU2PARinA7kl8sTBCI5nn3U5JW9EffriU3YATYgB2WzgJWP7RZjF4ExI1BpPgx0zqknStrWXtuunrTdO6lBzVrRfpZrVEohhea2UGijKlo/T+SE3JOwo2WNXjN6BKaQ8kr0Cq7CuAbKK/2AIk1Qo2UVcfvGf50OpkvnyiqeL3A4UHk+H5Na6Xm/CXb75BfXYXcPWR8S0B+K2SKHabcHHz8yqb1oT/DJReYbcv79qa2p0gXmFgP32H3wd2HAOVJWPe2Gs2totVVLdLG7iuK3POvvv3h6l+2b9GiXXWxP2CU9kw6AMf0e4f/TU3f7UB1k0Grmwt8mJY+Tt99uHN/pGKpOS1ZBegkzXC1Y8bDFqkZC+CK7QMliaS5kS4uaiZYgPsagfftmE6/rpzCd7VKI+Dka4JkSiemXhkoKSJmBm1Bcm7zAGQuze06i3WHCsDuq8i3KjPR8j7uQvdOat272YHoIbOq6TF78vVE6y0wlv9VwOHfZ1WPuIQZcI+q/VhxwVGRqX57EcalFb22zAJUeRJ4btXLPdWHG8tqRHOA06a3IB8zIPDKHeZsrsvK/FP/Dwv1/UM+m3U1zC/sBdTbkBAoYtHVhG7JnSv5XFXMoccUMAxmFYvBsy/WsErk6pegnc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(478600001)(316002)(54906003)(53546011)(7406005)(1076003)(7416002)(4744005)(186003)(2616005)(16526019)(82310400005)(26005)(36756003)(6666004)(5660300002)(82740400003)(426003)(40480700001)(40460700003)(83380400001)(47076005)(336012)(8676002)(2906002)(6916009)(4326008)(70206006)(70586007)(356005)(81166007)(36860700001)(41300700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 02:13:09.7653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78fc69c-db8b-4b9a-0677-08db08b0dbe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 13:57, Mark Brown wrote:
> On Wed, Jan 18, 2023 at 07:51:36PM -0800, Brad Larson wrote:
>
>> Add support for the AMD Pensando SoC System Resource chip using
>> the SPI interface.  The device functions are accessed using
>> four chip-selects and the device can be a CPLD or FPGA depending
>> on functionality.
>
>> ---
>>  drivers/spi/Kconfig           |  14 ++
>>  drivers/spi/Makefile          |   1 +
>>  drivers/spi/spi-pensando-sr.c | 454 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 469 insertions(+)
>
> This isn't a SPI controller driver so doesn't belong here,
> drivers/soc might be a better fit based on the summary above?

Thanks for the guidance, the only other proper location mentioned was
in drivers/misc.  Given this driver is common to all AMD Pensando SoCs and
only relevant to Pensando devices I'll move this to drivers/soc/amd.

Regards,
Brad
