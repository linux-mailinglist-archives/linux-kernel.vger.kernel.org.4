Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92705FE9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJNH5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJNH5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:57:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFDB12FF9A;
        Fri, 14 Oct 2022 00:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP8eVKNe87CpuGPzaa/NCAhr70r+fiLpYOSWkSINNLOGgdUOxOIIP8caGaxa4kk66Rdh7UXrBnT94hLa+V86sPIYQaeIHyIrrHDOGYcluGwmlm63Y4ehfcJj9huj05dhtUPy8q/+BxZXUbqeaUvd5mpkkl7UzWqgDbSh3qTI7JvXBebOTs8FOwLsXQoOPLdwm4XGyhZ1/9+BKcq9RksqCnHBvXcqFsIS+Dp/gTKSG3lzHOr5MJgjxV/rGdzudi5fMMQxsi0j6FefVBDD1a/WF7NtGQAmTqOvJ07jLq2g6XDLNcdUYMyi8nIvZ8UvqaG6oFKKYk7MDHJIy3J4vFotrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wh7vVJauM0ovvRWGiJt/fxw1pFbfIsVAmVfyGrnflg=;
 b=UFl+QEd5WovZ4o9JIFbiXYM9q1XG/ZEpL5N8uAM9L7QIBbbhVD7ySWoKMOhyGOfUQhb3ir9sLsyhFZuKh+RsWcjfFLvCGJkfr8OBPjmscdnu59CEhxr6iBE0toKa+qtKFyuI4rjQk0NT6MDRsaVO3BL9pLXSe7a2ABX2QMKNSrD/X9R6u/gBRRHzQsoX2SEh7K3cNQLtaIS5kgqERGBM6amZQN4W2M3/st4/QlTV07CbYrIoZQY9/bLsFEFseY4vjhoHV47cpBrb/tHqHD9xYuc/jeWfGY9me5Nh4STLTHg7hpvZ7zjNAlExGeZOxXxx+KWqJT9uDF3i4aAVvhBDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wh7vVJauM0ovvRWGiJt/fxw1pFbfIsVAmVfyGrnflg=;
 b=b7w6ziYtuaB132XkczdavdOC+oQqX7Xfd8T7ho8q0lGIhJAavlJdHCvDBnA0WVnB76O2LbLQ/7R7ZAM5QPYrcuvA+vnUyxdlOQDRiFiyEafmiHft7TZak2Cnl/QO7o6a43PjDT08tWT7K/KFWq9MRUN0FaGM/MEnJEaUa3qce+M=
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by PAXPR04MB8143.eurprd04.prod.outlook.com (2603:10a6:102:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 07:56:58 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::4454:3de:fe7:adcb]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::4454:3de:fe7:adcb%3]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 07:56:57 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] thermal: imx8mm_thermal: validate temperature range
Thread-Topic: [PATCH v3] thermal: imx8mm_thermal: validate temperature range
Thread-Index: AQHY35+DXFzehBY2pEWehFGWplGBLK4Ngj3w
Date:   Fri, 14 Oct 2022 07:56:57 +0000
Message-ID: <DB9PR04MB841225D488CF97177B5A083C87249@DB9PR04MB8412.eurprd04.prod.outlook.com>
References: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
In-Reply-To: <20221014073507.1594844-1-marcus.folkesson@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8412:EE_|PAXPR04MB8143:EE_
x-ms-office365-filtering-correlation-id: 328074ed-4add-449c-3fc3-08daadb9aad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ueMPrypIm3Ht4luxX9GPfSWBuvxc1IrXzJ1gGgjLBhB4hc+wUs2XsUOqrNlOiCjZqRPykQyl7HYql2deahE7B/U2fN7YpSMNN49C+nkvQmH6OKmJQIK3+pauRDs4ll3kQyNKnm2KEUGO3bg189/r/w1fq2lQUIIyVR5WKpaf/JFhIfMu5trMmgJaZELVkaHYu8A/Wba/mWaIcXDtjHc/utDSddC+oP01vr94lRnNK955SI60IIVqUV43pQ9fpL8/SvtliPGmV58nFHBx0xja2xGg1d/vbFivhalkSLss+eHJsUMageFVmLrk+OGW/OVSgQ5DPYmlEUuwCnwQI5xLaY7U26fqvMZFBHaLCttQnbixJAtWS64rGDeiiGWuwrLpmv9GmGtCFf7rTDJio6bb/e2u8or/NFrbS2p2y0UNbDas2x7gMIzuC5ng0aDE14tvPU1BMrxRXthQNK3xK6mZq+L4Axd/XWXyPQa5j3zx3XpKItGdOvUhCTs9B8kQwt/qEhiVvMi+srLmc/9UyVNqhZbrMLbd9xnOTI4/L+MrmMF3BQTwwJIsesUprBbXmDKV7U6DCsJ820TvxSgCnP7BGzAEgHBjgdPXZ/QQkuhY8+zE9q5OjvEzZW3dZCIk41LEKDNVSRWeMuAainYbn5KdOrmGNC71cRdsARzK5WUAm4MJ9xvlwRmnEqAe3/DbrdTh+ZWdiRjE31UDOAa+rDuxvXCCohMfSfU7Fi9dece3a3hPWyHR/zQwguzNYIS5RWPD4hvMHNxW/7l2Kq9dp1wetVo23Mnzp0kqbtpGOkvQ7aI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(38100700002)(921005)(478600001)(38070700005)(110136005)(15650500001)(26005)(55016003)(2906002)(54906003)(7696005)(6636002)(6506007)(86362001)(8936002)(186003)(52536014)(99936003)(8676002)(122000001)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(33656002)(316002)(66946007)(41300700001)(71200400001)(83380400001)(7416002)(5660300002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?15wG+lHZo/OJXo3+NGJxubCBYM6DduH8gx2YixOSJe2YJ32PUk+bfkLZIux7?=
 =?us-ascii?Q?6Q8scmd8VYBtISL9JLWqtUhc/fbKGvMCelBkA67WA2kmNtWvsgLzDxJJV52D?=
 =?us-ascii?Q?4PiPQLcZQCjaZykZFb94Q+XwD44wA2LA4bblV2OjGF1GaWpofCLc2aExCgCp?=
 =?us-ascii?Q?pj5KP0yC9pqntIzI09/dZ42O7QECxr3kgjWtT/h2wBGcciXKU+LpN11Hn7Iv?=
 =?us-ascii?Q?EwId2tZI7M7XhGSQztjzxUG3xYOoI+AoMdcka+EZXiKjfoB78qix1OEPMsJH?=
 =?us-ascii?Q?6OVFJ/hoJpL4b/H4zlWFCJWrrQJIv9Bwkl1ZkNAi54xJor5bEJOnwVFLZCFd?=
 =?us-ascii?Q?vhJGjAfATI6e/w06kTCCdfCoZDu48mhUsm3CCLhtlxFaNjDU2R2Tha6Qfxm9?=
 =?us-ascii?Q?uvgZNgNr/WDBjf2BP9XUewytmDqtCZYDsYzuMwhQoOU3KK0A5XndP5MVwgqw?=
 =?us-ascii?Q?JWd7hEWtqdN+KClWde58HqKSMohmHWh9gA344qEEkNSUZvg3stqk1ic5O0p+?=
 =?us-ascii?Q?FnMob0RVbfughJdrBT3wdFZ2ErgxcAywL/z9Vqtp429/YrFwDTup0+9Ln9aI?=
 =?us-ascii?Q?jpBQSZpc+lBJrVXU0EqU+DkBZJ07+H6HEeB9LKUMZgWyIMx+8OLWu43p1Pd5?=
 =?us-ascii?Q?qZlwIjSrTEPYEFLoGxeBbmERBS0T76kw50XxFzOOA9lITgdN3AqIXzQOeupE?=
 =?us-ascii?Q?jE/n7h0/DtIeKc/sYH/cIh2YvI5Ypgh3s+6UJYcgT/L7QiWWpdgxgDfm0B4J?=
 =?us-ascii?Q?jADGAcA3ql0REZM2YJK6AN12B/2GRaK99lM3Y8Viwooa91CB2vP4OEiBnNRp?=
 =?us-ascii?Q?JryLKVPB6/US+v0jiAYA2LmSVnBs5vbcwHK2xGEGxWFAuU8GKSNLHPo1rUAI?=
 =?us-ascii?Q?hvqs8DMFodJB9EbvI2jXGJPxbXtZYCjrpVa4rtGMQUIB0rUz6hOFYbb7S5/l?=
 =?us-ascii?Q?vQORTPyxSAtUiz5PKKyeCw83rlc7TXr64FtsfA7fdPu+mEo5sdzrjirk1MXb?=
 =?us-ascii?Q?19zNNLJ+q3crm8ezokYXxOh0Yw8wLByRW7dK+JynyMH6glt9izS5rUrAH1Ba?=
 =?us-ascii?Q?xk30cwCOgq8fC139qkUwo6Zn9qGit9AEr/qYQb5SXkBb54Sxl+yAUx0D8QfC?=
 =?us-ascii?Q?LBDyGOlUTbxCuMJTQ+zHXsyiIDsR5BfEIzxQFuKeMXnvBK+DHlWH/lBdIYW4?=
 =?us-ascii?Q?Ctn0Dhp3bvpqyxEqsZhRhqWOTQwp89rYkIRL4qFyaQ1oO+6ArwEN9tXolNDI?=
 =?us-ascii?Q?vowcbgK3BvQEjXMoYSuelSr1GCmhpNx5kkKki9NA4HiQEi+m4+cvYVc7pdm2?=
 =?us-ascii?Q?mKyF8PHdt8HT17cwikuyW23Kyy2OCJAL12qB+dEr64yKfLStF2Pit/VKj6ey?=
 =?us-ascii?Q?YOpYx+NY8/nVWWbqXM1eoW4wrqjvY2+pWdpoEGePjTbcE7hgChRa9s0CFVLm?=
 =?us-ascii?Q?sI2UzWSddKbqglh3Erh1q0ddbXjKHBC9SyQilxJAOIKHxczPKrIpCHSvwxpq?=
 =?us-ascii?Q?sFLwM7pRyiUUg4fgZxO/EhTNFPEpSATkRIhCrtih58XQcVMfKGGd8nEerbce?=
 =?us-ascii?Q?3Yt0iUhlTR3tme7zRxE=3D?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_0206_01D8DFE5.943ED440"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328074ed-4add-449c-3fc3-08daadb9aad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 07:56:57.3044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6HCG/hwuB8NPaF72YuLwhCpNQG9PHr9CQE2OAA+S6cuxsh7bUJcrhT+k2rK1hfmludvrMpd/X7c3WaTZqoMRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0206_01D8DFE5.943ED440
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: [PATCH v3] thermal: imx8mm_thermal: validate temperature range
> 
> Check against the upper temperature limit (125 degrees C) before consider
> the temperature valid.
> 
> Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal
> monitoring unit")
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> Notes:
>     v2: Also invalidate if temperature > max (125 degrees C)
>     v3: Only check temperature range as the valid bit is invalid.
> 
>  drivers/thermal/imx8mm_thermal.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c
> b/drivers/thermal/imx8mm_thermal.c
> index af666bd9e8d4..c5cd873c6e01 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -65,8 +65,14 @@ static int imx8mm_tmu_get_temp(void *data, int
> *temp)
>  	u32 val;
> 
>  	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_TEMP0_VAL_MASK;
> +
> +	/*
> +	 * Do not validate against the V bit (bit 31) due to errata
> +	 * ERR051272: TMU: Bit 31 of registers
> TMU_TSCR/TMU_TRITSR/TMU_TRATSR invalid
> +	 */
> +
>  	*temp = val * 1000;
> -	if (*temp < VER1_TEMP_LOW_LIMIT)
> +	if (*temp < VER1_TEMP_LOW_LIMIT || *temp >
> VER2_TEMP_HIGH_LIMIT)

Don't remember the reason why I only add low limit check before. Should be
ok to check the high limit.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>

BR
>  		return -EAGAIN;
> 
>  	return 0;
> --
> 2.37.1


------=_NextPart_000_0206_01D8DFE5.943ED440
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNv
bT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0
aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Js
hi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsG
AQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2Ul
MjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29i
amVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDA9BgNVHREENjA0oCAGCisG
AQQBgjcUAgOgEgwQcGluZy5iYWlAbnhwLmNvbYEQcGluZy5iYWlAbnhwLmNvbTANBgkqhkiG9w0B
AQsFAAOCAQEAkIoVu8Z7nAqHdZlesSa/ZKQsoGVN/KXyw5UDkWZc8QH5EUPRhmwPk4j2IO+7zGl5
X+G5pRc1FmjT5MiJx7HJqWjYauI2HmGU0UtwSTqT+s9286vF5h1AEOLUBSUzB3E/O/cWvpDL3IEe
+stzIGhRpwg6OxDOSb9iHElZoDTqpRvLISF6Wy4ktrom24/n6ePTPb5FlWB1y6OPMAiI25YSb9zW
fWumZL+I1EMZHtie+S5axIcNlXke5UxtPzCF8dxKoviZiTOvR2n3XAQd+qDDPHRsev2Bv30I+T7J
W0qNC2rInm5LczdALMKrDUU//+Uy/XT5IyabR0eufpNuTyD7lTCCCDowggcioAMCAQICEy0ACHtC
5W6zRq9c0YAAAAAIe0IwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMjA5MTUwMTA2
NDNaFw0yNDA0MDgwOTE1MDRaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
OTAxMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANNFIocz15YTXOTeRm2hof07RVzy
FI/qsJNt0XyGB/wK/65x2QtQ0HDcdvQj1pEewRA3RgcBAWge8vRYfQd2PCICKlfVXfabIwJfbfU+
p4WdW2cvGzGt4/XwXniyYeZwnL96Z5M+FZ/h/GlIT72K7/woP+zA0wzTw6ga9jLJ1S74Kyfbh+9i
eZ6kjokCEZFKwu1AkryMMpkSsWN96z1IghrCwv2D33WjffHy+g8BG0NQ92zvuLShwVU15VBMed2Z
I30PEta+A20b/ygJ1Yb+631JDoPC8bewk2vPi1u3fjB5T1QDNYKxjts9PSzUsdFapd6hSSAk+Z9N
mqnHts9s6iUCAwEAAaOCBFkwggRVMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/heaKboS14X4CAWQCATowEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFIQg+lXF6qukHLDnGFCWIGXQ
7e6oMB8GA1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50HMIIBRgYDVR0fBIIBPTCCATkwggE1
oIIBMaCCAS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049TkxBTVNQ
S0kwMDA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1D
b25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxp
c3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIYvaHR0cDovL253dy5wa2ku
bnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0dHA6Ly93d3cucGtpLm54cC5jb20v
Y3JsL05YUEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcw
AoaBrmxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNSxDTj1BSUEsQ049UHVibGlj
JTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9
bnhwLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1
dGhvcml0eTA/BggrBgEFBQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50
ZXJwcmlzZS1DQTUuY3J0MD0GA1UdEQQ2MDSgIAYKKwYBBAGCNxQCA6ASDBBwaW5nLmJhaUBueHAu
Y29tgRBwaW5nLmJhaUBueHAuY29tMFEGCSsGAQQBgjcZAgREMEKgQAYKKwYBBAGCNxkCAaAyBDBT
LTEtNS0yMS0xOTE1MjA3MDEzLTI2MTUwNDAzNjgtMzA3NjkyOTQ1OC02Mjg5ODUwDQYJKoZIhvcN
AQELBQADggEBADQRSIt6fqoWHqVz8Cp9E9E/O/wJhHJyaY7bNTVWSVpVptyvbVm1rFmj6xTPxQy2
kZGnpCkDQrQIAhY0P/PQGecdI7HmBUkFqlXrhugCHG9vtbeG+kVjDCecvtlWMPsYqER3ZCzACSFc
HJKvWOZdnEc2yfI3LGkDqVMZWzfc4urLk+1H7sYi4psI8Z6EDbEweuSznBtthG8+jomjtqxGhOy6
Uxvh93xFu7X2efPBxxsno44HnWsLrwkzisI8oItaHPqfcIt2W0nyVjvW6rAI0LduoAhJwLsD9RB4
FYZwB4ain11hWJYlP9P19PmMPdoiKQBqQQvnXcujc/rq2sKm/3sxggTDMIIEvwIBATCBzjCBtjEc
MBoGA1UEAwwTTlhQIEVudGVycHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBC
LlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJ
k/IsZAEZFgN3YmkxEzARBgoJkiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJ
BgNVBAYTAk5MAhMtAAfU7dCrf7iXk2FuAAAAB9TtMA0GCWCGSAFlAwQCAQUAoIICxTAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjEwMTQwNzU2NTNaMC8GCSqGSIb3
DQEJBDEiBCAXOnThbQMA0Dm+hp8r5s/F5S9HZAglpCepc57TDZhrSTCBkwYJKoZIhvcNAQkPMYGF
MIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsG
CWCGSAFlAwQCAjAHBgUrDgMCGjCB3wYJKwYBBAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNOWFAg
RW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcM
CUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTET
MBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0A
CHtC5W6zRq9c0YAAAAAIe0IwgeEGCyqGSIb3DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNOWFAg
RW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcM
CUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTET
MBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0A
CHtC5W6zRq9c0YAAAAAIe0IwDQYJKoZIhvcNAQEBBQAEggEAhDrDG/YfaGFQBLGvAs5A/nxBc8GC
zQL74AHTYKfzCwL/BU+FqPfPjG87JYBXDg3Zq4XGRyLvhfcP9QFMQu1unGQU/21QgE7/tSeldkD8
3cm01t5xFCozjLLy9eUDxp5iwxwh5x/lX39OFVcklJ0qxlM/SMvMpGIM/aw39OmClVKcpTW4+YPa
U9E2b0xbj7kVbmIa4FXfKpxGSsvg0TEl/J87xpFbNmGTAyP7oAyyZdk5/0/+Kvc0ktIOg8aFmmtk
e/7gjzBa8Cevqspbz/EJ0h2wN8GdHBaKJit4dppdkrbgBaXL1EYrymYTThz2RconiN81LmmXDdvL
SDMVZzoI5QAAAAAAAA==

------=_NextPart_000_0206_01D8DFE5.943ED440--
