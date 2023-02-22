Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E269FD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjBVUjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjBVUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:39:12 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2091.outbound.protection.outlook.com [40.107.237.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBE138658;
        Wed, 22 Feb 2023 12:39:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBuxrH1p46+UsUtbPnviY3/tHe1mbxx57caVXUrfIiE9oOLgBeP6zUvoI85dZ/Bz7CtWp5XUhow2xTn9ejTo+tvpqeZg3ZpnozNuGbzLTmG9VlB2iKFR3/XWkbHvyLvdRrcQmll2pNAj1vu+C0xsbyDZMvqXPgWAkjLJbp9hJgq3mTQPxsTb58JXMmUeF2BWdTqv5esqBP40Krjx5WHuP4EncdGOP8nUHYkeRJ9wfC2katUHSU3OU+33u0gf2GTD18N6oTwKRqo4JBd+AvvORqyoKayIemRcvrdO2WnaX183fI7rZNY5aBcXPAFDrHbUtX3NlXg+th/H3iGPCC+Nnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkTx4cHQjuRWhXhLahAxIk5wncsfmsph6laianD1e78=;
 b=Bau8lbOUdarACJdT53ZG78Z1pBlGrWLTLhLiulBwb4F+aIILhzCaUvpYKlzh4hujI4u98h1lvvZX05NGZDyL9gEJG4bgs4JtDpQQ1CoBY7XIcBrqTKt5VX6O3hr9E4Rr+g3wkyVegFam09ioT9M+HoQKRz/AF+p2B8vFWVKZLQw3Y4ORxBlxUHWxNAuEltflnrDdR/luNVtCXcvkLUlx75xVbIPhM7yzci6PTSBm8Acm5KI+hrhLugrH4fU6cZ08mQlPfv6c6RfnR2SD8HCdf/aK2mzy44uIs1q6yoo5rRZg6Pi9DSjav6UyjHBW4zjB5DihZiFJ9HQngoYAvkGTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkTx4cHQjuRWhXhLahAxIk5wncsfmsph6laianD1e78=;
 b=smcxLoceM7njTFfBLlG0MpU9+DlAfUCQTBs1CaUa9tmPfV0CbcklmGNNzkX9mV+2KRjr/u9ywYVz3ihjTxTdRPg0MCFnEqxD9MVBXbF7KuRoJL2vVJNSAte1BOVygP1KSZ8mLu59s/12UGK/BR2B6EpMyAmsrDBADe6eRGSvBSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by PH7PR10MB6033.namprd10.prod.outlook.com
 (2603:10b6:510:1ff::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 20:39:06 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6111.010; Wed, 22 Feb 2023
 20:39:05 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 0/2] add support for Phytec PCM-049 and PCM-959
Date:   Wed, 22 Feb 2023 12:38:45 -0800
Message-Id: <20230222203847.2664903-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|PH7PR10MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e879b0-c7d6-4269-5af7-08db1514d724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++WUTLGlciiI9eh0RctBw6clrzNQXVWPl74d+r/rhNuaz0cA4KiYXdEb2CpvQz3MzlYqNyi5ISrtPBxJPQedhvVNuSZXJaA23d3TKBUo5i4foxLP+aGecwd95B691a7gD++3tEzL+DzPF6r+NW+JD4dskcTi0YJ8WGa3/ceSst3kpvXZQy6doxbzqMy9uaX32FmqnlfuSqU8yBYpck6k++lnpy0jCfCvBXat0W1Cjb9eSSptInUMt/XqXvaNSYoOfi6Bt6GdcOmctJRVJWI2wLwAmWEcM+BeK59bmQEBolc12rJ8QTlXkMIjPR8c53Rf/p7ZCyHhhdole8B+DPUsl24osA4Xf36e2lEHX2itR/WM5yvATEGWIO8V7D09KAsjA1IiS0rEC6K62SApI7lIaLx2eeCi/drk8hdkeJQhQ4pGU9jNN/l4Co0so+o45nQMMpj90iuiV4aa/cZLpFtMGWxLtdKCni4U34Ke6YEp4LNZDBT+qPk1LTA9sEKkkKzPZxsNgMbMefALHW5tis/zyqdyqJYgTcypu3k+E3XpNks9ldB3NF7Z3yS7XdTyt8hAJuTwOlKLkTTQncA/5q0t3xd8q8yohBZhZs55RempNSJJJdrnmsxLrUogmxwvADUdSStqo3y8PLZj+Q5MFBpJNgID2NylSD3SbQsekQQ9zpJx9aUffjV7mBurUK4K+VHj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39830400003)(366004)(376002)(136003)(451199018)(478600001)(38100700002)(38350700002)(86362001)(2906002)(44832011)(316002)(54906003)(41300700001)(36756003)(8936002)(7416002)(4326008)(66556008)(8676002)(66946007)(66476007)(83380400001)(5660300002)(966005)(26005)(66899018)(6486002)(186003)(1076003)(6506007)(6666004)(2616005)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QYV4EATQi1AKM0L8MaGQ9mGKjrZlTbeYcYbM/u+yi5KZqe/Z7iQHUotRDg/m?=
 =?us-ascii?Q?xDasEnfk3p/UaJaw44h0T1WHTCJ3eXZWdB5TpF8qI/bF90PuMok8K75o0Qyi?=
 =?us-ascii?Q?/7yt2DdheVzmtPpMwONLAFZl2ugK5lz88S0VbMNg0laKGNB9hprYPPzmRES8?=
 =?us-ascii?Q?tTS4dCmgluK7vGutAkreSReZYjalSVT5r89bD0JF31kFuMcZfu0Cg0EUHAF+?=
 =?us-ascii?Q?OhuJtvH4chQQEuJbAdBnx5uDzdPDUjWIP+v6aX1SdhZ7W5/VCCYLL79esNpz?=
 =?us-ascii?Q?05nT8TQSBo0FGST2ByNSdLnej6wA2aQDTlcfTA4dPl4Cx/kFO1fVyUiiFWmy?=
 =?us-ascii?Q?Nbz8siq88JMa+/WXC6tboOii5cMTjOjoiwh/mNf/KbV8fxmlGD3Fq2PKliPG?=
 =?us-ascii?Q?Zd+H1DmyMTIOaoZ9fqzjk8D2Oh0QFR0lrARUk8tdRPjU0ZoHypZVUP+jV8R1?=
 =?us-ascii?Q?7hviiB5C4sSMB7O92sKzIZIcp2LG4fhhl81oETlbm4o0sMi3UE37CvTTxhvq?=
 =?us-ascii?Q?pStxLBkqspObu2wDcPySknItz13oP9qKCltFoRlf3/y0/9g2BNjlUbdv803k?=
 =?us-ascii?Q?Z5cg+On2yT+N9Ye16xbhBwhCmRh3N5qp2YdEZxFfESJTSQysdC3/yg1znF2U?=
 =?us-ascii?Q?4UWd3/9gzecOaMH0aOjmFGvx/IdH3dvMSMwSDHo59bVg5cG2wD5aiJn61ZD3?=
 =?us-ascii?Q?U0ZJezX+fBeJEZJF/RO/0i5ttDTQj+S3tXoZS8y9hgxHdS/4nxGxBhyhw7Pk?=
 =?us-ascii?Q?bhV5O9TxZAe1RfmmmMyFKWTvWetjEB+OzgPXjbTe6JYiY398+wOLOnS7k/S3?=
 =?us-ascii?Q?Xxn0tvNRuIbW5RbHbsGRC+qr+UtdopWwNvg2lKeSkheufj+TdIEaMB/WGQwC?=
 =?us-ascii?Q?FRdUNnpu09ZKTxNvKec8z4D4SRn6u6cqk5D3YEFK2F5IdIrzwgzvIm8C0xIW?=
 =?us-ascii?Q?2C/SkNpLR5QN7L8LbwSbGH0IF5KpyE84TuVhgMDL11alqA6WJgx4NZ9lmg4y?=
 =?us-ascii?Q?uGuXR5McZNr7TRKccsZ7VxGDzCK7TyigNYr3GDT7jo1TLeLCfRJlE24Kzy3y?=
 =?us-ascii?Q?okHOgSvuz5kjKzIfv2Wb3x/lAO3jnuAq4ncfAhdr7wEXBvjQjq+H9pBeMu+b?=
 =?us-ascii?Q?G8ThtjYz5HdcGe8o0zliKiFglp1gg9atN/khht18tMkNzE8D+IV23n+ra4u1?=
 =?us-ascii?Q?iRPimUp9zhmfPXC8WS01PHeNuketi7NczEAuS3V52k1NjHGI//DjNeFxPFOL?=
 =?us-ascii?Q?9H8x/gT49CFvq/Obe6PftERodMiacRDhRjyYLQD1nR2oyWTNfA6DZcVDreBH?=
 =?us-ascii?Q?J+MRM/nHG0zhtjn4WYT71nuGwzO1aLAACiMIac2seAzdmnzmzBp61bHmPdlo?=
 =?us-ascii?Q?u9soAWa2JBv7hbxVue339ZR7fak8mRpg9kWGulWNuB6C2e/kcPSuIfLrRt09?=
 =?us-ascii?Q?8dtlccCUy7zf2H5GYdH4W0/vuvalPO7HP8PAbkWc9lZIn/t5OV4o+beQ0+YA?=
 =?us-ascii?Q?hiIVTWdd9SZiv2dGKd3e8LMcmslNL/Z43VCEEqGPIaLboeh+bKOe5pH5LnUe?=
 =?us-ascii?Q?LQqt6gffIXK/Y2Amip+P7xgSOOJ2cM7ZZIZOEqMiZPfvRiL9lHLNeaRdFzUS?=
 =?us-ascii?Q?dIy/ZfnxUhS5PNB6LLtPnjA=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e879b0-c7d6-4269-5af7-08db1514d724
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 20:39:05.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8l0A8PgFiTLLGkFA5XqUHjbmwDHt/why35nCIZpwioNSGt/3us+C1gsB2zklRRQAfgTuQhHZlH357pw/nDzFY5vFyaGCq2eNoPVYdAW9w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6033
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As should be clear for the title and patch title, this is adding initial
support for the OMAP 4460 SOM and dev kit for Phytec's PCM959 evaluation
kit.

The PCM049 is a legacy SOM offered by Phytec:
https://www.phytec.com/legacy-soms/
There was a vendor BSP offered by Phytec, but that never entered the
Device Tree era. This patch is meant to change that.

My development bootloader has moved to U-Boot, but I have verified
Barebox works in the past. When booting from SD card, either bootloader
should work. When booting from Barebox, the NAND OOB layout is
incompatible between the bootloader and the kernel.

I haven't had any OOB / ECC errors in the NAND at all, which was my
main concern. Due to that, I'm submitting this as a patch instead of
an RFC. Hardware ECC correction seems to be fully functional.



v3->v4
    * Add initial .yaml documentation instead of omap.txt
      Thanks to Andrew Davis <afd@ti.com> for posting their WIP patch
      set, which was the basis for patch 1, with Rob's feedback.
    * Removed Rob's "Acked-by" because the patch is completely different
    * Removed unnecessary "omap-4430" from compatible in .dts

v2->v3
    * Acked-by on patch 1
    * Code review changes (see patch 2 for details)
    * Fix intermittent NAND failures (patch 2)

v1->v2
    * Almost everything moved into the SOM (PCM-049) .dtsi. Only the
      LED chip is dev-board specific.
    * Fix pinmux associations (*pmx_core was applying *pmx_wkup
      entries... I'm surprised that didn't cause more issues)
    * Documentation added

    * Updates from review:
    *   Board compatible strings added
    *   Hyphen / underscore changes
    *   Remove unnecessary status="okay" entries
    *   Generic names used (regulator, led-1, etc.)


Colin Foster (2):
  dt-bindings: arm: omap: add phytec pcm-049 som and pcm-959 dev board
  arm: dts: omap4: pcm959: add initial support for phytec pcm959

 .../devicetree/bindings/arm/ti,omap.yaml      |  29 ++
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi   | 400 ++++++++++++++++++
 arch/arm/boot/dts/omap4-phytec-pcm-959.dts    |  48 +++
 4 files changed, 478 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ti,omap.yaml
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-959.dts

-- 
2.25.1

