Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A296F3395
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjEAQhl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 May 2023 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:37:39 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2043.outbound.protection.outlook.com [40.107.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224FEE58;
        Mon,  1 May 2023 09:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm9oo+p6SRSiYzLDDsp5y2Mo4R8zvLi8A/dwMYsh5WbuBlb964s12oktSYBOoUqeuuSEFUsYm585X6gslPXhPkooKpv4+VKO10j6duxyA6Cclat7618UJOVksoWrBKH/LT3DA8FNqkWvW6MgdtmnhB/7T4XZCQF5VmhItoftMU+hRLyeYs3koQW2UmEg7hfnB2WCpernOh4kjCPHwZMsA6W7jdPn781FW353jp2XmmKeha1SCXozHCZ3F/V2BdMRAwjdluNlSRbNycNfXtDo+Iir0Hz/toq+Ubu7SNk5Xqwwi/aO4IFEJNnCURVWfl84VuMk2TIJokSjlDQMf4gt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhSEgsUIf4SdtwF+0bJmCJcqUWimLpSYOtwNgd/IM1I=;
 b=Ln/Xh1hGKvaGfWZqnlxmfC7yi3dH8i9rJ67zNn4MtqkfVZgVeXuY7jiuxkI80x68DJm1T9+4sdQGEcCXT7jpRGmRroI4POVWTYB8ch99JMixbgqA1NBRYwuh3o07t7fzIKYzSyjVNvBh+MHxsCyZZQEH4IhRGVPOsT9WKvse0z2IsSecYkIAtyWiaYZbOli3OMjbKbEFdR3LvkwqtmPmMU9EKWgJbKuR6lk0zPwSF6NcA56LSCQdn+JTTVokUybB+PPY+/hNNjloSqxiWNPt//svsOM8KeMNjmK4Q1PvW1R88UdVFznNPcY14o9x0ZTNyx2scIvP9l5kYtIRBdMLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNYPR01MB8335.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 16:37:33 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 16:37:33 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "festevam@denx.de" <festevam@denx.de>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "max.krummenacher@toradex.com" <max.krummenacher@toradex.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "matthias.schiffer@tq-group.com" <matthias.schiffer@tq-group.com>,
        "denys.drozdov@toradex.com" <denys.drozdov@toradex.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 ] bindings: arm64: Add an entry in imx8mm boards for Emtop
 SOM-IMX8MM
Thread-Topic: [PATCH V2 ] bindings: arm64: Add an entry in imx8mm boards for
 Emtop SOM-IMX8MM
Thread-Index: AQHZfErvypPEwl8qjkWFEEc+VQ614w==
Date:   Mon, 1 May 2023 16:37:33 +0000
Message-ID: <BM1PR01MB4899F56FF3D6A2C0F3C3C3449A6E9@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB4899:EE_|PNYPR01MB8335:EE_
x-ms-office365-filtering-correlation-id: 31bca901-b2e5-4f34-8ca6-08db4a625d1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: giRWFvuOq7BxUhPrq67uQ1gGjVV6H2e1X929Hll31AueqAR1TsPExzBucZcJoCD5XpTV5n8WJtR0//ttXfxtuEfYgNPGpoEoUJh7GJ3SYBFgSfxQ4lj/lcAtZF6ZBTvWigs8UXhPuuYm0/k4znTT5MpYfa848JHT+/kJnsYriWw5BLG1gZ32k8zPVtI7nL+YkptLcQwT+ReunoXTt8giSCV44PVcIPaSHXzeXkNaTWM//yH3IGe2OPvN2THkpH9DV+v7VCtL4o17lrxHjELNAlHZ95rNUiy3Bc+JpQofP/Gi2FgLykwmFNaoHgZfOCsedYGELRybrocdWzxrdr9JHeNbql2bh13xJak7IqZES++zdYcJqi69OEnMJKcsFTH75pB6xD3431GmQWoTdBeIk1Kea4HIDE5aLQJAFPl4BGlg25FYlw8sNhBv8vMEQM3UJJKoY732ap1ZyQhTgfVZRjhoai51cr2/JpdK7ih6B9lqq/owSDtPiBJ6WohW4ZcNn4SqO0HdJDOtT5mWWW4lPXwLeMsYXRz/bZGSknSMiqw3voLWAEwUYPh7pzyuaD/S8O0eKGMj16EjeosUb41Hb+YiyIapXkVlyBmqC4n7TjD4EYMme3pf9NSqD6GtW2yVWJ9MpRJ+OAxxpblSJb+Tyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39830400003)(451199021)(55016003)(316002)(4326008)(9686003)(6506007)(53546011)(186003)(41300700001)(83380400001)(66946007)(478600001)(54906003)(26005)(110136005)(71200400001)(4744005)(7696005)(66446008)(66556008)(64756008)(66476007)(38100700002)(76116006)(2906002)(122000001)(86362001)(33656002)(38070700005)(7416002)(8936002)(44832011)(8676002)(52536014)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gYuRECkbxJfg6cFBf9Jw9gJ+O5XefjkUtfPsEBIB9fUiTsZ2J5RmLszUXX?=
 =?iso-8859-1?Q?M3V/6gvGflbPFfgOXjM/+Ro+OO8ammFgdBCU/qw/rQcdxamqQaYZmKXM3v?=
 =?iso-8859-1?Q?R7KoMtlPDHkzpe6Gpwmo1GqZVguTWPrg15vrgybWb7IFOmv4dhfHPWtTab?=
 =?iso-8859-1?Q?o89T+CFpQbEYxo14ogdblKyKpIDUtlWc1alQJYr9YL2CpKUfJjYC/vZt6T?=
 =?iso-8859-1?Q?Zy84zk2lllVbOc0mWChPM4b6fts+uWY/IaUJRCGWosUpNzAvqIBs6TNd6+?=
 =?iso-8859-1?Q?sYcv/c6zvtC/apBoYDtjezZ6WKzy+/q20oA3KAUhjPwoAN29tZLkPP/fr1?=
 =?iso-8859-1?Q?ok3mNSyEGuZmkmIaqr6yFEcqka8+s4+8RAx4KM5wMta1eXN3AsMpKr/b+O?=
 =?iso-8859-1?Q?CLsfXFlHm7jkwz90TJyPmH+2AJ/VVnZFVDv/YptnwdTA/lF6+c8hpLI+Vx?=
 =?iso-8859-1?Q?ydfV6S542PInN+REz3eNPtv6oh7NziBKdQigtsUBg19IBSvVaDs7/tNfDp?=
 =?iso-8859-1?Q?+AjkoRpJ7Fca3BBjUKtDm0M4YSeacrBzu5dLEKpzhwzSmttIyM9joOh3Si?=
 =?iso-8859-1?Q?zkh4BxcbmU0XdXSsp8+wCsx6d9khnQEwpiyyn/X+d1MY01ApCvI8Gqj27u?=
 =?iso-8859-1?Q?u73v7PqXn7rJUfp5s/9StK89e1ihPDCfC0MvBYTKXYD0BpZXsL/n3MzHRp?=
 =?iso-8859-1?Q?PvT9eoZDvY1CxWKz94URGY/vZF0lcgTRNJcsOyULKgmDEEYWCaZGQY46v5?=
 =?iso-8859-1?Q?fBQ6lDYnJUezs8K3mcEmBHKLp9XEEN6bmmptMxXkIHk+y6+vzXolPO7vhc?=
 =?iso-8859-1?Q?i4uFE2wZVgxtbEOc8IL7IlFlyn6BupA6dXV6LXIK0DNN8g3kg5102GWfxv?=
 =?iso-8859-1?Q?6WGj63UnJjO3L/eykIKdO2v/1LmvSfsh653VF62+sktyHdsZmOCCoBNoGf?=
 =?iso-8859-1?Q?UNLVZHf6hJ8FRlWl8PV9x0JDf31RQEySiZSeZh/po/SjGapeRDw97XPTNQ?=
 =?iso-8859-1?Q?LFtkgNxuZhXxCTJAxf/YpPmJVz9R8+PE8u2tww8kSpHe1zSBe2ZUagDVjC?=
 =?iso-8859-1?Q?Wx2Bwj7+7vtM4wY95dKxBk0cdkkOl7hVkWEo3u5HAyDuVszlIJUG+hJvfb?=
 =?iso-8859-1?Q?okBrHroqAjLkcJqI85cdPaDc0v3E4hU0O2Q8qiHqgqNNMReAxLpWfWQqWv?=
 =?iso-8859-1?Q?yyukX90cqyYRiWmXJTKAf8hahxoWU3UIbYnnLFartpJAsi4j+jpnDuSDAB?=
 =?iso-8859-1?Q?gSaUztO8CB5I32C7NF7oFJYSAjyAOcaWhn1P0VK+F1lHBZpACdPDaIgyDy?=
 =?iso-8859-1?Q?nJwEGF79QRz95m7pQIPFGyVv61tKAMdT+7G9uZa3fTFdV5j92eH+/pYNPx?=
 =?iso-8859-1?Q?EtxDsfoseppzpRlZrvF2G5iBjE/Do2RTAGw2nhENKMI3Jqy3K5r+QNY+Ic?=
 =?iso-8859-1?Q?Ht3WiIGGlXRHAU8NGGWJD4kY3F8PtPfobSSZz4s3x8Rsn5amnMl38cpleB?=
 =?iso-8859-1?Q?yCGPu3HNlzZfBAAK+NsmQuCjCT3EJBOs+jCp5+wjJpZMmv5JhVKIhlTSoG?=
 =?iso-8859-1?Q?s5WCfdHZT7ML4DGlZp3ykvmL1HZI6rJO0QDuhxffQbWvzfEHWkdZ5UASYt?=
 =?iso-8859-1?Q?d14XD+04XwYRTo4YBBPtMSrRtSKJbB6LO0g/m0buHvw/a8zlJ06Ij/GQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bca901-b2e5-4f34-8ca6-08db4a625d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 16:37:33.2369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bn57TP9Yz5XcK3lUXHg6aoNbJtFdsWvwZ2kof3brMdeXRSqrU8x5Wfb1BJS4TFbVoYKEZ5waU9aOJ/PsOu2Lxr8pcmwPn5d2lQ+XB9W+y3oTrgf7yBq2bltiTohMDpq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8335
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 8b789f3a997c1fbe253e9b5c5f5c370b262f7efd Mon Sep 17 00:00:00 2001
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Date: Mon, 1 May 2023 21:59:47 +0530
Subject: [PATCH] Add an entry in imx8mm boards for Emtop SOM-IMX8MM

Change in v2:
	- Update vendor name
	- Add board name

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..06eb2c790f90 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -884,6 +884,7 @@ properties:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
               - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
+              - emtop,imx8mm-emtop          # i.MX8MM Emtop SoM
               - emtrion,emcon-mx8mm-avari # emCON-MX8MM SoM on Avari Base
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
-- 
2.25.1
