Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A2636E71
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiKWXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiKWXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:32:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DB2A44F;
        Wed, 23 Nov 2022 15:32:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J87FSUulNn5aGk9sSW7aB/qEjvxUord0FM608s/vLzWUT20CiU7iEhXtdijNbEuZThult1EecDaqP1+ruRdomJ54q3aNYy1kZ0mhLzf/98YXXvmI7Bzr5ve1UFryVpbluu0EwvwPPhTTJeQVRQb3uyxhckcNqSewPbihU81R6KvARAZkMYq2CuvaElBoNnhAu9sXs0Yja1y+QzsOXjLB05rHRTnY0JymDbbzwka+l2Ktvhvg2V8kIer5wXTDNGKt6IbQ0a/+nsaDS5GxmnC7Uz1V6VRT0x3BdHBdeXubKK+hhF8AnKOEGDAoiI6S5W1bWppVFoaitYLwLanncN7aLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yauLbyPHi6yHHqtV7VG0yfwhmsPqfj48qc+vaWsvCCw=;
 b=loA/16w7lmlv0ztnYwvH4lrl/zCHUcueNv3oQO8WqonBYQ3ZdYumpCFSOWhIZZqQ2IkKdWap5kfJGziUc3G6BoeocvUkRlM4rqAIN72iXWlPcQb2hcXiDn3cZToV/YtYxKJ283yoMVvX90ElzTqDs80S+i2MIhmAkc7KBA31theV/xTec6A8uiSfrce7F9S8Wflt5+UxH/9RwWMufBMY4IaIRDnDw7ypt3MWk3Pnun6ufKvcQYDJb3jy48VdRiFPnB/QwrQIE97y1Bu/xtdHRxnzHkgK4NhQ8Bhepo3drGi5NFmMpSoZ+zud6Kg5YlLPgTzMYh9ZFluZJdfS/8HX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yauLbyPHi6yHHqtV7VG0yfwhmsPqfj48qc+vaWsvCCw=;
 b=b0OzIVwShSuiKBGHbthXsEh2asuBIdZwH5QBq40rsa8LAFDA897GV/sTWXwcuc0Lv8guHheoM1QyA+uV7IP4SMya69b5OMKCtJOdfjqc9YqI0Ai+7APWHxiaXFOB41ooiUxrWkxjRyvgmQF1xi6dDNLwCNOKxOcjxrAJsSbelqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CH0PR10MB4873.namprd10.prod.outlook.com
 (2603:10b6:610:c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 23:32:27 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 23:32:27 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: omap: add phytec pcm-049 som and pcm-959 dev board
Date:   Wed, 23 Nov 2022 15:32:08 -0800
Message-Id: <20221123233209.1854806-2-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123233209.1854806-1-colin.foster@in-advantage.com>
References: <20221123233209.1854806-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: e048a9de-e10a-4991-3c14-08dacdaafaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxkpPYDl0NnZxLbvcuu2Z+VKbDZEz5f1D0Urs049bauujWsJ4A/Pwp+kNy0FRwuEA2uoI6WaxN+yNJ8qbHRcl3rvgliFZNil93NCZ6ucr6BR3WOLco3bf+x0Ds0ol7E2GmpfK2aC4/q8iDPUhJdYbY+vO9JK+9Iyu+TrAoMDjhLIC/qX6GeV+noWll+X2oMr5mFnb8wJU+vTPmnGNHo2U9nMefYOFywesQesjGvQA4HGIvansH4HbLJwWhuTPnZw95c/MnbjR4XSxtLzAgwaGJl7bi/2NCAt87VwAb2duutPjJKDAuG8MQ5Tfz9ec343OEOW/OfrvVs1+5KNqJ8jZE3MVYpEas25dgIm3bZIbsrR4AtRygnC5ulNzPwX+O9eqS2sKoS37ud2hPUkt9f0jX3BxfenofTe4NQj+8CWOEo6Vh5QgzZH/KvyjWN3zJVYGOoqUL1fCsKKaulpwTiij/PuhmYtkw5NZ3+hkKMghTjzxcqfOiobqK2fbFD/5Eyfv2C3js1cDZ91GtpocHqBd/MAJHDVsn5dF9vQEaYZvy/3BVmW7uv/gWA/D2UHK5uM7UnX5VwyJ27G8dJ7a2VDyZJMjyHoTLishYWuaUpaT37w4cEUg6MpwXogYMgkmHoFysFcrDMWIEkcGUjOBAANfCkzizaO7MHjLez2WiC9EZFtnIa0o1Abl8ZrXCAtsqY5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39840400004)(376002)(346002)(136003)(451199015)(6666004)(41300700001)(478600001)(6486002)(66476007)(8676002)(316002)(1076003)(8936002)(26005)(66556008)(66946007)(4326008)(7416002)(186003)(5660300002)(36756003)(54906003)(44832011)(52116002)(6506007)(2616005)(2906002)(86362001)(6512007)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leP8tLmJYsIK6+ECV93SMfQpT4x/bSPKUABw+nuW9ilU60o1cozLBOBy8y9a?=
 =?us-ascii?Q?GCAjWEy/Iaby15srwV1QKHwTVqZjH3JFj8d+/nVm7QNNDkmvce1zgfWLsLeR?=
 =?us-ascii?Q?wH6rSUXNXLTCA0p3RQVofqiieXGmMrIkfD79kve2+pZKnEOmdj/OlJM3GSY2?=
 =?us-ascii?Q?o6jiXQcUnGEfba5j+sjPycx6pY1y1XlL0lXHA2eTKq3aJmvMAZjF/8M9OXJz?=
 =?us-ascii?Q?Dg2kD+DLSEXKWW9x3mw6vTQExnhI47kq1e049kUYR2XT35dwai16TJvAkFU7?=
 =?us-ascii?Q?7iwayxJeoG4g1BJy69DPHJ+M5M/gJyeJIW8MLDsBxbHmdoOYPF+sGk4NC1MT?=
 =?us-ascii?Q?8GUMgRc85TMjzjtmVPsiQ5MbmrNStqF7D0PnMEMVBydK1sIFztJnNp6epmfW?=
 =?us-ascii?Q?0mlVboMM/PDPbKUbdZaal5CvkHlhAl8V6KLSAbt8r2fqqx9r/dfoD15n5rxJ?=
 =?us-ascii?Q?7MVUr7ln/fUCXu4paGQHUo6rkHm7GsjgTLlhRHGYhSm0wKH8deX9hbfTj44u?=
 =?us-ascii?Q?1lF1RjggCmdAuexL0zZSsiD5jFoKPI5nB+ochWuFcQUR/4yg1s1I8TKo8hKv?=
 =?us-ascii?Q?dpLHYou+wplkcnW6H9bZccJwb4JUhvPz0hq5wJ9LvWfIoeA6ysUQ23YRtfhr?=
 =?us-ascii?Q?Z69hk1FgOqnjL3V4l6UpEuMzLCbinSsataYiRUAaY3Ix7QZN9lROPeROd/P5?=
 =?us-ascii?Q?NGMYhbyi+BEDYUPRbVvJzS67E7yj1MhF8pF0ZVRf2rSQuJdPBacmQew3eVhd?=
 =?us-ascii?Q?iHZAfGvbzgYRrwuEOQfCQ1zgnbpudvdL6Wliqn/Ki/r8O2dK911Lhtnu37fy?=
 =?us-ascii?Q?TOC4bVddJgz9ttnGzR1d9DXjgx+cVstRjBXRFzDIWgQe6WUnb/r9VS9oA1ww?=
 =?us-ascii?Q?8dePSlgXR2sq2nMn7vIZ4rJKTjmUTaKlLEbqoYTZhjAD7H96q03FVL8VEdZh?=
 =?us-ascii?Q?RZYE0qYEHRXiU/up9RNl4ZeB3DZ8gmZRjoOaYQYwD2q5/hh0lYTp/nTRZs8J?=
 =?us-ascii?Q?xsBBZql/ROsEEPYvshT+MDW3owfeXJRr1y4+Wgwuq1JyVLU+uZf/xn+rT2ND?=
 =?us-ascii?Q?WzT7N+XQhxsjWxDLjmctWuO751FWdtYTFP7b18Po9l8N4WFUaFshOoW4xk++?=
 =?us-ascii?Q?fcOPxDYhtEIIdONSbnnLc9GAgSkSRwEJmDcLLKeq7TDCyum721Jh8kiUq5aZ?=
 =?us-ascii?Q?0/a4B53XQxYREkYC0Pf9FJNHKGb/Cxuk/PIJg34G22vRjY4vRYlhjjarLGmE?=
 =?us-ascii?Q?6UrzRGvOYtPDLxRYyffIzZcR3f/M+LW4QBlQ5FiMenYG3OjXKkR/7IG3nS0f?=
 =?us-ascii?Q?ZbNebUlJYBqBhrWEVXq3Lpg3oN5eFal+y85mbkugcbdfKsE7wLXYMiu3JBWH?=
 =?us-ascii?Q?NNMqhjeN0uSHZWdy7VWM359V793dhgX/3rIx6EinhFgr3vZkMzmViFsmPCvC?=
 =?us-ascii?Q?HIO3ZOaJif5F6ph2uJEJf5kem2fB2GBv1veG9wvJIXbuJ/33nWHjCDNSeSCG?=
 =?us-ascii?Q?82J7elVoZ9QUyoarfnYp3tAZE9bZvvDEoqqLebvFXOAM6wPwiXwxmRXxYz89?=
 =?us-ascii?Q?TiZGRhJnxLQeTtB5YfbAm1wS8edtjw16LJQ8a6Pby8LCg6lBgcCpfoWPn8fA?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e048a9de-e10a-4991-3c14-08dacdaafaf7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 23:32:27.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVxJmbVfKdNA+S6KKLTCX1gKYxaasb/UgzNcTgwBGibGtibz6K7mRiexwbsCocheNpNGcM2r14z+oWqY13ddPjZoxIgJ+bRTzibvEchxC3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for additional OMAP SOMs and development platforms,
provided by Phytec as the PCM-049 SOM and the PCM-959 development kit.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---

v1->v2
    * New patch

---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index fa8b31660cad..0a28215dfa12 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -131,6 +131,9 @@ Boards (incomplete list of examples):
 - OMAP4 PandaBoard : Low cost community board
   compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4"
 
+- OMAP4 PCM-959 : Commercial dev kit with PCM-049 SOM
+  compatible = "phytec,pcm959", "phytec,pcm049", "ti,omap4460", "ti,omap4430", "ti,omap4";
+
 - OMAP4 DuoVero with Parlor : Commercial expansion board with daughter board
   compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
 
-- 
2.25.1

