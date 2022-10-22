Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BFE608B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJVJro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJVJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:47:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::70a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F28531CD16;
        Sat, 22 Oct 2022 01:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee/hO+LQxBVxKY5VCSfTGW03wvtE4vntBZPbw8XODae8dkIuvzuNA1UhgH3F0/lMrb/P+ItvJQ7iM71tzj3Cl0gAGFjuunHe5z1OXQ+c32cnmR5OvGJZaeLeKJmYoxJNkUX19saUYZrrNxlRI2ejJSSgel/r8bKUCyQ6DbHCMZh7tasP3aQGWutZ9PTypVtxy1m5dpUw/rdIHEpEuL7NcEcnIEwKKYxrMNGflKzsEFPZZl0PB07ke/Dla7pJPiv9BGYMcyrKqoEJ15m9NaucDKvLVV41E+zLGM8mMm2XSUsU/OPef/hxVw8cnR0+dqWT1bUZFf7pUhlqxHciXdApYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI4vUbJmtQyYdtFH2oJUDMUOmjfpK9Qlndg8sr6/xvg=;
 b=MhkWLR4a582c6xxTutrs1eIg9XyfWLPA69cuxFa95MzHud7o17toeZvNhnYoohbxR9qOMubrU9sa2USz9s2ymcr9jFiEftgJiyvLxH4jyd3s7yAEl2r+Yx8BiEDRfyx3ukz2PmfNhAxRxz20FFBh1CvLj5ZqwD8yn9x6+p+k+Gxq+N4S/Epp8YwF2jorcHsgxY3Dw9Z/mHqhSJF/+d75zoD7yEzjtLl5sjg1Z+0fCaxMK/xAKGR8TsOBLm9UapJ5xYiqym4ngUtGRu5IgQS4/oIbFgtWAMwo+3hGyQChL95RU9OZkiuTAj9ucFDQvYgWSA5yLc7IptGw/UtBKYQVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI4vUbJmtQyYdtFH2oJUDMUOmjfpK9Qlndg8sr6/xvg=;
 b=np+SXvdgaDkn9iLf8O8FWZplHtHZAtZBLlhcVUMjTMoQMLSp+Fa18t0gxmWb+c/FTO7xUNONtsLeStmQ/i3dsXlEKLzwN9wZDKPaNzGxbIxtWiIFxASyA7OAwPGHYu7UsByWeByM5rAiHdF1XBAD/rrY/qm8h3WuCnFEn1IpdRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS4P190MB1855.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:506::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Sat, 22 Oct
 2022 08:26:41 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::a621:b61f:de56:b8%7]) with mapi id 15.20.5746.021; Sat, 22 Oct 2022
 08:26:40 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 0/2] dt-bindings: mtd: marvell-nand: Add YAML scheme
Date:   Sat, 22 Oct 2022 11:26:24 +0300
Message-Id: <20221022082628.23876-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::9) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AS4P190MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d06803b-c696-4073-6f10-08dab4072518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhORo8fOQtOVERj6ifhG+1CpPNvjdyZqDafvqKz22pvX/EcfCz1uSBIhQQoYGVytzESl0SpclM8GC9uigRqhwCiyTXYNpgSaQ9TebsX0h9Xdr8AP9B5OOEuQuuw/RcxUxEuotiy6xgMt0en6wKky0eB1nHx+lCx1o/CFNdhvx70gTYkQoyx2s8T+Ox3QJY6uk/RVV+HuTiEplgJw40KyM+KYevUxVIPTdv8b57psU2pvnNy2Nm6RH+IrVFfW7DklWq+lLzxqrfSJ0jQC+5rJwgi4j2oyUfPrUmuEsmCrGer6t6ZTe0ZY0stA65h7i+BzDRavyt5WOjrM9cUPUTDZSIAwS1+t041T5idA3AWJyo4MVQ7rR1qfyOtH9NrgAZQnIQFW4EzQgqjG4D5I+kBGmLcYjdgPkt/iGZrU3DHgZbQ3ltv0ZQPJWlFmDylEzjgU3WP/PubDV7j+BpE36/qJCnL/EmBNyAT+Ks1ZpvvDfGobnRC5C81/6hTbKqijxzN69GCzDv9h6+UJfsGAbWAsAfJVTV0/PcKzIBAqT/Z47+RU/hb8RlB9nAzTPlRhUxwmsRmvO3d3YaQ93H+RnDGvbwXr7lRkb8oC0MG8NQn9uEGjrasnFd/vX+ZljiQQaM6Q5fLxJ0SIKKdSFtgzd2dp4PzaGv5RKKlbbZNR6lBIijP2nAbO5raRzbbUe0F1z0ZCu5/c8kbfJfQ/MscsxyIqmZpo0Y4axIOGG8JjaiIucnqRZG+H9W4faT6u77x0OZqmwSWKSyPqhE1ztMpgHPcQAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(34036004)(136003)(366004)(376002)(39840400004)(346002)(396003)(451199015)(1076003)(186003)(6506007)(52116002)(6512007)(107886003)(6666004)(5660300002)(83380400001)(7416002)(4744005)(26005)(44832011)(41320700001)(4326008)(2616005)(508600001)(54906003)(41300700001)(6486002)(8936002)(66556008)(110136005)(66946007)(8676002)(66476007)(316002)(2906002)(86362001)(36756003)(38350700002)(38100700002)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Mog6M/hKXNiA7+oqxEMSj1WzhW8tYm0HfHtujcpZw1iBt9wgt40fC5Hq5D5?=
 =?us-ascii?Q?VpXl2K4k6IWDR/AW/CSXAYfr7ovVIg1cxWinCTCNfkkO1biz5zuTYg6gE7N1?=
 =?us-ascii?Q?nJPZtYfDiJaPXB9VId78gcaa+xLgTA2EYgakJc3XfdZtlSMXTY6qvTqQfgzq?=
 =?us-ascii?Q?YcF23cNu8bBkxz3mcCJcaipwfa/iqcaNPXMshkcy3YNg2eEIE0ms+oQmB1NX?=
 =?us-ascii?Q?1PKAMd5N4hjCeFjeUSY/1zaiVke5sun0Z0RW3Zg9riXC8en5xw2MydT4W3uP?=
 =?us-ascii?Q?1/7miBucBxbxIwPI69wiDZD1gvf8lGdlEHV+yPT0dJXHFoIZkVyU198mDMU7?=
 =?us-ascii?Q?ymdLKUUu+g1eaPBXxkWFeJgEYd4QgNnoW3GblEog7OQ8Zhfk7NWCxjvr9Rd8?=
 =?us-ascii?Q?ISW69WXoEFIxR4+iXuVmGXIBMh2spXQQReV/Qm5/+2RUFqSCpleBH4azpTmz?=
 =?us-ascii?Q?vv2Yr3s6x75mQk2ZcU1FK/K/XWVguNgaXHNvLHk+Bc9itqgRiQhEY8TsYq7x?=
 =?us-ascii?Q?qMcrIHGruLJkufekpZKvKtnVv+slaeKsV10r+5OiT5KLOqzAu5c2cucO8lmx?=
 =?us-ascii?Q?ABS6gn59ELHR31EiBlYpEr2bxp/6pU1LHLm34H8kC0s+rh/+OVrOMpe2vpAR?=
 =?us-ascii?Q?Li1Skl1thpMS07dLfBQknI9wyYizeuwXbjrrUNOWtnm9Lj154expho1J0Pd7?=
 =?us-ascii?Q?eL8SCfh3bBLGWtWW0cq2lqok0AMluSSAouEj3RbM15Qu9qfkneKsYwjJyn/b?=
 =?us-ascii?Q?6nfniYivIbQsd9PJ1dqc+7QchAEx2swHHC2gznBAECN9r9j6sfApjIQZmyo3?=
 =?us-ascii?Q?Y5ZMCvs5XQH3wbR5SqnIPiN1h+iXCcxLuW9N/E+nRLNlMFqxQlCUnq1J4UbC?=
 =?us-ascii?Q?WvxNQu6+Azh3QjsYB9p47lsMgo3zcMJpQTezHGDnUShs0OW/7sf7SvFcx4Ha?=
 =?us-ascii?Q?M/9dTuY9zeiJtvcNLjXnxbxXN2XyFWVZfRBvga/yipWMc9fri0+Ze84/FiE2?=
 =?us-ascii?Q?uafzhwpokAx94dkzvwZ9TFkD1YDIFDBu5ShtJcUX/48ogO/oAIup8Wb8APmS?=
 =?us-ascii?Q?+GnGs4HhhN8l7SWkoSljVPXj7JoMQrrduiUEAKc/BxZ/Zm6YO+WtuK4eYKff?=
 =?us-ascii?Q?R0Lrr2QPs3N8P9N/+l9840m1WUHAWAkhnr+G6r1fpZ6lU9Af9TV7RSNHg4p6?=
 =?us-ascii?Q?0sCnKn4gpgvD0R5B6mFdKj3TG8+ZAhhXj3iXZ6fnmOC4n133+azMxLCBJqTP?=
 =?us-ascii?Q?XT3DCx/71Z3JerXjwC0TwR3Hxgm5RI5ucZTTj6fv9Jabnnxpf4SEh1NCeCkS?=
 =?us-ascii?Q?lgWLWgfPRumgqnYsDczCsYIOWZDmQPxWdnEOif1Nl+vZmMPuF62dJNfwlw88?=
 =?us-ascii?Q?gqOg7lFh6eQ+dkUFnYFDXONQvh5xY0B2+PJL8ZnDtaXd316pj6Dly9A2cIQ0?=
 =?us-ascii?Q?jPYWNSRmQNO3q6E4X558Xyagh913pycixhuv4uUA/hrWIA31whQA5sHoZfYn?=
 =?us-ascii?Q?WPG3kvxxZHBEWwDbSV+WT3jdf18jqpCZQ9FmyLQZBsKRcdPopxci9l3/00wB?=
 =?us-ascii?Q?5ZYlNmm92uxQfR82K8BXFRxm9TcorNmkMQl4i3vvERvZQrTNu5n1xTd2NTWe?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d06803b-c696-4073-6f10-08dab4072518
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 08:26:40.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kJVnOfVBNIKS+IpTuYiwR0AUE5RhSCTeUoFYdC8mv5msw94sdOxuHZwkZ4qHsLn4LYTDIBMGi0uWQ5jI1dVc8feMfDPe2rx/fTXw143pfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML scheme for the Marvell's NAND controller
to validate it's DT bindings. Old txt file is deleted,
not included the compatibles and properties which were marked as
deprecated.

Also fix node name in cp11x DTSI acording to nand-controller.yaml

v2:
  1) Fixed warning by yamllint with incorrect indentation for compatible list

Vadym Kochan (2):
  dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
  arm64: dts: marvell: cp11x: Fix nand_controller node name according to
    YAML

 .../bindings/mtd/marvell,nand-controller.yaml | 199 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 3 files changed, 200 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

-- 
2.17.1

