Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B46A6D60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCANuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCANuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:50:01 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE32A2594B;
        Wed,  1 Mar 2023 05:49:59 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321AXgXm018614;
        Wed, 1 Mar 2023 05:11:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Hbqx1Sh/+668yO6FdmK/sWvFgeCxN2Kdo3QK41KFHkQ=;
 b=O82D50Qh5b5m4ah6G1PzJbaa9jMFsdTFqCmPlHVvovpMZ1MiemQrNOeF9jQ8JsvUVpAC
 X234h9n2SmPGZB5Vh1QDqv3D3nnmAyAriH7rrf8BH22/C+Fax3SHtGxNdzSAxQPDuIjO
 AGbmsfDOGkMKnTt4hc1+C0CiMJbs0bwJHruOahYN+z30nhx0bdP6rCt22EVuu6oOvIXH
 jVmhTk1INTe+CvnVv0L4meSVBj2wDD4cCPUTgMBxiqQTvkw1I7NMO6Adg2Yx8XpTNiXG
 rrlwGpjU98eqsezXHBkaFGKf1pxTrBi9gh/XirYK9KBAn2LBP9l1et7+rBhTWEJb4pQj lA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3p25280m00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 05:11:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQVIGJeAqD7t9p3plOX8v433eGIClajHD4xY2NQJM7jU13Q+gwnDz6qARS/2EeyUIV/GK+Z8wFZCrifCUMyhZ1xdm568KnI25k4fFV7appg5DoxW4q3DXgZAingBOQxPPomocrOV98d10NAiJmADkgHTulPy/4wXJ1jEZ9bw/0nSGcdmYxyE0dDivXPNjrYSEumhksB3WkXYFfZWkKO8+s4zcU+HQqnI/iMXW9xZrCf5jU01aZKpYXIdZFDUiCI8LMiQ3cOHo3eZSMUFgS1udEMfB3b8q40roDroS7jkLsWJpoBEY/vC77e/pNfqVg8lrBOW49jsNlRt/WXdiwBGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbqx1Sh/+668yO6FdmK/sWvFgeCxN2Kdo3QK41KFHkQ=;
 b=ogiCpEFTeO68h3txdG8Ra7l4QDkDOvQXvXdf4ffMtTv0kFvOzKW2l8QJM8c046uOptmnNTrE6+lKDHlQihAbcvnfQQ9RbSN2mgbmJxhu/pdfUUyB0u53ED8K2D1I7yxiiHRMnUgNqxgOuwAW7Tra8rVWKa8zvvKAnkTzBxZnz0tWLIqQXsy2hWaIywOkAWOLfLcbsWXyv0eINCGr4+hulxt6p8MYbL4zpPeo3ZO/k6YlbINJtxdB1lcNIsC3k4/8SUVkOc7fdSYlr+I7FLKGF8I6j4gwOM3Xz4pLUZC/A/0Tw0jQd2MOJE6NLI9lRpPNDQgHKl7W1uXeLtnBgyffug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbqx1Sh/+668yO6FdmK/sWvFgeCxN2Kdo3QK41KFHkQ=;
 b=hwxEuG7mVQ4BuW4vqqKjM5Qp9JcgYdT5CwWlbSyrgb1g79Mm1FBSKjm+I/9RGRbDQvtWpxi8VwG6V39FbNEP1jJhqetLa0Qr5RSppE8Ow5Lh/IigeG0/mOm/cpgPbrSPXyqx32n/dHwUjjz4yvcHEayqV71M770HItY+nwkCYew=
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by BYAPR07MB5766.namprd07.prod.outlook.com (2603:10b6:a03:9a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Wed, 1 Mar
 2023 13:11:43 +0000
Received: from BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::b5) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 13:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT068.mail.protection.outlook.com (10.13.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.6 via Frontend Transport; Wed, 1 Mar 2023 13:11:43 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBff2005228
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 05:11:42 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Mar 2023 14:11:28 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Wed, 1 Mar 2023 14:11:28 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBSEl006143;
        Wed, 1 Mar 2023 14:11:28 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 321DBPv8006126;
        Wed, 1 Mar 2023 14:11:25 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>
Subject: [PATCH 0/7] PHY: Add support for USXGMII and dual refclk configurations in Cadence Torrent PHY
Date:   Wed, 1 Mar 2023 14:11:18 +0100
Message-ID: <20230301131125.6084-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT068:EE_|BYAPR07MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: e85440d1-3bd5-4585-cf35-08db1a568108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaMerQg9RhccF8Difrq1meWh+HMXKbVc2mqQ+0DoqveyRtA+kZM/TelNMXIFd0CsF1vJm+ZXd1XeZqlNlP74OQDdR2Ec2sj9PTJu8dcV21Apgc2eP24y2hdgnn7xcjHda8JPKWyPqpasXFpcRjmrDtSLmz/xiP54xzqhsKEq0hmwPFrxE0wyC/zH3v5GMbAjzOdTaRLId7/QkKCH/2B5DHft1IYVt5cmSP+ZhFqdqqJ9m5IAmYBiRFn0u1bff3cW74G7yT0ku4wnMbs9N5E3KY367x2LIl4YVqw93XUk+8FpP1L0B0a2vigf8Fu9huNhTe9PyYRE0LDMdt/rZpsbErLfsSnhO9cTOfXR1k20sRv5e9vxQOZ8CmxOGjK1+VWOTQAU7IgZ45lZjfbC8muXp+8Fn+jGLcMOvr3hcaxrymYoZFmKKGmEcf3tHtmfXFf8gJeShjkgt0tq7iqDtUmMib7QhzDIPUWmCfLcCjkcdYsIsc4SsP3HGjcMmDgjE4xeUpfUhsJNgaMEhi7lDRc6qO7JeFZPXOwpa/Iew5rq7Ava3fr9ZfwDRsPirV0DvqelrpgJKodlA270SdvbThniXmesl9xGo0FvMY1iTWcVoHOsPRdVyhtdiXsgVv+0GQK2Bv4Oa7O1cs60+A7EOyiAhBhw1H/CVHDNWJYPWWHEgulVZiiSwh2Cj6jPAxrOZvHG
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(36092001)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(186003)(40480700001)(82740400003)(2906002)(7636003)(83380400001)(356005)(4326008)(41300700001)(70586007)(8936002)(336012)(1076003)(8676002)(70206006)(47076005)(426003)(478600001)(6666004)(5660300002)(26005)(2616005)(966005)(54906003)(110136005)(82310400005)(36756003)(86362001)(316002)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:11:43.5842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85440d1-3bd5-4585-cf35-08db1a568108
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5766
X-Proofpoint-GUID: vRdovWnVAED0O7dqkhr-Au43zkosoaLF
X-Proofpoint-ORIG-GUID: vRdovWnVAED0O7dqkhr-Au43zkosoaLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_09,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=858 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010111
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends Torrent PHY driver functionality to support
dual input reference clocks by implementing key:value pair table for
all settings instead of a 3D matrix.
It also adds support for single and multilink USXGMII configurations.

The changes have been validated on TI J721E and J7200 platforms.

This patch series is dependent on [1] and should be applied on
top of this.

[1] https://lore.kernel.org/linux-phy/20230227133104.29788-1-sjakhade@cadence.com/

Roger Quadros (1):
  phy: cadence-torrent: Use key:value pair table for all settings

Swapnil Jakhade (6):
  phy: cadence-torrent: Add single link USXGMII configuration for
    156.25MHz refclk
  dt-bindings: phy: cadence-torrent: Add bindings to support dual input
    reference clock configurations
  phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink
    configuration
  phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
    multilink configuration
  dt-bindings: phy: cadence-torrent: Add a separate compatible for TI
    J7200
  phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
    multilink config for TI J7200

 .../bindings/phy/phy-cadence-torrent.yaml     |   36 +-
 drivers/phy/cadence/phy-cadence-torrent.c     | 2431 +++++++++--------
 2 files changed, 1358 insertions(+), 1109 deletions(-)

-- 
2.34.1

