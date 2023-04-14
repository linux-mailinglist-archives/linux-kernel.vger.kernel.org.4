Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AAD6E1C30
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNGFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDNGFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:05:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3BF3C11;
        Thu, 13 Apr 2023 23:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1AvjyNvfFfSBO2J4RMqjRSWec0JjRPSigFn9VYnMD1cLR+HWbnWW1bSNcHb8ISUGSQUR1X6D/8CivI6pQxHctzV7jPfichd8mEDgFBramAHjr2gsr2aAbW5BBSLzQQFHHB4k0oImi79JlA1KPikfPIqy3m77audUlh/pJj/wj9JOiJ2rP6U5uraze4KZB1Ps3eBM42cawFVpcVhvTvCAiiZfGlIt149VBn0jEybVJrEfBlaZwSNqkEBTEQWO2t30rETLZXP8S3tWSIijZt7hvAcet1WFrUGcZNb+QTw2R/3eRDkM3yRFnCA6HTK8BLlR4IudqgUneNnxod2IWgxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raI5BXQKZKwlxz86ffBC575gbJHoNrs9bY9Kvr7CCxc=;
 b=Vk44rheOhV22X4RKVWH71itzmzJE0zf8qhQ/N2QKpu2ov2m2t8y+Jb5bQTOazYLwBcgJZf1H0cr4FWnTXVZnAr2IdY+BBodz5Is1ygSOiLwDJkG7chXj1JO9p4hXdetQDbuA0M/s4w/Pm/e8lQINBHBJmSQ0b1JQ1WftIytWOYj0l8qN6ixNeKo9f1UofNVw0xmvkiBWA2tRXFJe8PZRdOl9XOlpT2R9d9EtFnFrL1gS3snmO5uLQaiqlMaI/QckrerzZ0NpXxGWe/X2eg8m+csLaHxsVX1He8fHHtpKv73AUKvm6+HiVuJkvKhYcyrBjug3zRfWKXsqSsdrByhkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raI5BXQKZKwlxz86ffBC575gbJHoNrs9bY9Kvr7CCxc=;
 b=VjjJjg5iR2JcQ7oYvpBGS8MPtNSMl692mzAeyrZQZcDZ9JWzVw1utEaWWUP1K80g/nEeJeXah4NZntE0B140K0WZoRGfYaliMpxthV1Ue3oDM5BjkCk/9ROn/554KMajaqORv9MUxUPSrGQVAUglIzSXGma2njgAuhI6jBj0qXo=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 06:05:15 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::99ba:7f8f:7595:73e9]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::99ba:7f8f:7595:73e9%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 06:05:15 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
Subject: RE: [PATCH 0/2] spi: cadence-quadspi: Fix random issues with Xilinx
 Versal DMA read
Thread-Topic: [PATCH 0/2] spi: cadence-quadspi: Fix random issues with Xilinx
 Versal DMA read
Thread-Index: AQHZWxM2HYB0zugnmUSUtTuM77veuq8qd2Bg
Date:   Fri, 14 Apr 2023 06:05:15 +0000
Message-ID: <BY5PR12MB425810A4B57D1C12AE170927DB999@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|CH0PR12MB5025:EE_
x-ms-office365-filtering-correlation-id: b0af19ec-9f87-40d0-4672-08db3cae376f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nk/j/8E4swlmipb6QxVmYO2EVP9RFB99hin/5xA6tZM2KvBDOEyB3FVV0K+rfO9HNL1ROBviV5FSUSBU6dTNhocB5nhGqMdNm30On2Ggt6u4iriYWVr6hC9OaZKuPTu6Dn2lO12MURxYf9EKqCqklE0dlFY0WxQUUirVoXBhjFSVMnyTV0OuL4DbwSzgvf/S4XS/tALoSbCq3HrOvMSlKeZKj83hawmOCMYjlr82do5wpizls6uamxFtFR4Ef+x4qgNR3+2+NSVEN5TnZy6Y3Jnvl9lVePyAnpgOkC6ZIIFfxbgjFl7PiouJAUkckf9Z9bRhoDt1RqcPmXRE/Xut32016EdZTtwX5vYr2i1ls0DtzQk4Xz8I71G+G3v7JoAqaECEi4H/XYvkAziuhh2cffPnvlmaqKXBKx/Qaizs/VCdo6PDyRSj8NErCNM3S/q7jcBdvGYc5afx2Emp+0Z7h6TFbIPHc7bedeNBwOKhpnWiuxFFvv6TKPg+QNnI2KzMR61ZywfhjRMvcCWnAJdxfIUQErGhVSx4tijaQyu/uGkyMUpVSbGB1MQj/+t5rZftKsX/dXE2JCSpHOXqcv6BqyiQDOa3IyMo54wlp/kcZUjRehLoe4OcN3KgZ8TuGfPC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(9686003)(53546011)(26005)(6506007)(54906003)(55016003)(186003)(83380400001)(71200400001)(7696005)(5660300002)(33656002)(52536014)(41300700001)(316002)(8676002)(8936002)(86362001)(38100700002)(38070700005)(122000001)(478600001)(66446008)(64756008)(4326008)(66946007)(76116006)(66476007)(66556008)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rSOO+gKohXSJPvOgyxtzy49GfCJDi+skCyTpc5GBQ47T5s7//iuxEg3XD9/s?=
 =?us-ascii?Q?thwMooks+eDup4+qRpSLfRJ/rTI0iPo/RjoN3XMfilRB7JPM4F6wQ77bCpXg?=
 =?us-ascii?Q?HYFw6b5OafSDL9McDyIOk4itozAWWLxlvpOuzBlUHZo0kWapJq8WohqtJXlT?=
 =?us-ascii?Q?flDXh4sCIVcas8NQHAvg54x3z3YheqXWHJfUyuAovcc2y0E7aO5kDHx/hPK1?=
 =?us-ascii?Q?HLIRJOP6XFdN5ZmbX29odAvQHppmYaDPg+vgA/8RftesRPgOdcIERPpDEOq6?=
 =?us-ascii?Q?PdBU31M7oEcCaxTNxdce8ySniIVqY4KqToIoXmcuL+TZ39oOJu6YL3nMlnpF?=
 =?us-ascii?Q?tTYo9llXFmVtP4Hog2/rY07MYbx0b4ggbgiszDneyUZzO6ZAXcthfe1UX9I0?=
 =?us-ascii?Q?9HffcHbYuZKbn3Wp89oVREGIPXFYKZNlZwVfLH9Dbiy7QP8TMqClNYmeoACE?=
 =?us-ascii?Q?/qYPoHUs85mM4jAOVVm09y8i33QVpk7ilmnj3U3Fp57fR2iJPnEcoa/acGII?=
 =?us-ascii?Q?XO6qbKdvoB6glaYSgMwUfjQ+2ZK7QRXc/RXBIvOR14gzD3S/Y1lNCW5CazLI?=
 =?us-ascii?Q?teJ1/T/9X6MLQyVcWWxfs1GaLv66b7Fys8yQITPdGX5uReyiVORSEel/6RTC?=
 =?us-ascii?Q?wFfHsO8TvNzlHtjRKZd/ApFHJ93XJIVN9MJOOAQ1vNBJSDDcCwx4Q4Q4/wj8?=
 =?us-ascii?Q?wW/a+3s9GfbtzgXZv/+eteYNFx0hNdi6RRGBWilSOcNSt//vVr34Bilfz44J?=
 =?us-ascii?Q?Y9YpcAEKIZLKUj198g2oORsArshDprCfNpHNqLf4JMdATYAi2HJTw54AQgEQ?=
 =?us-ascii?Q?2jBrbrsgN3GVzeFxeMZHyjzxtgOMRNBWNLes1zafLoDrT7Y/TkiJQmn/2Rjk?=
 =?us-ascii?Q?mjgX/YdCB68Zpn1/Jf6wFNf0kg4qe2XQ7geA5DeRWL9Wi7T8atZRYJn6wH9P?=
 =?us-ascii?Q?eaGlkFk7RXQRed/4oQzsUrJ1jshFy78NdzIgX9TXTAyQeSXqH5n1YjXv9loX?=
 =?us-ascii?Q?UAmF8xyZa+87mVN/m++7nVkn9w5MoevpnGXvjnt0Zt3z0K2d3WoXs9NCrAOg?=
 =?us-ascii?Q?CmI73Bdd98F1mEzBsiCv1VKzl7HCYCmTNxpbX0usTzfxbE2czLSq4hHN2Ipr?=
 =?us-ascii?Q?3o6skMZKC182CROXqDOIVnKl1GZrdI1lHdPtgx8lAKBeWpIGLfoNr/ei5mEb?=
 =?us-ascii?Q?MYeUgaEsHMuV1refO8bhl/c/jmHWiNqL5a1xpgMjzmAyebZLP7JrKzLuiUQA?=
 =?us-ascii?Q?2F+YxUCdrBL/6en4o03dneMxvRYZx6ercOdhb8O5wJ2XyIYJ/ld3H3DR11WO?=
 =?us-ascii?Q?41Lfi7BLz+Sj6CTenTQTaOYRFrKJDap78/3tCbjKc2WScuVIY8++4AJvowOw?=
 =?us-ascii?Q?GPRG4xFzRqG5gacyPbN9+rC6B/HwLA2D9m4WIUSTbZlF3ZNxoeu1BZlsMa9F?=
 =?us-ascii?Q?+T08st01oRsSGH80TFRxVzoQ15tZ3h4lIKCExzj62ZtXIJpa2EzWHJQ0167t?=
 =?us-ascii?Q?Rulydkkn63DmbfYSNEcPoCCvwClV8SKN/bVNxGmyO31naT1pt/CqshvIyQrr?=
 =?us-ascii?Q?f6FTXqaHKiZXA+9tmBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0af19ec-9f87-40d0-4672-08db3cae376f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 06:05:15.4679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s49SPgBj+1CO6xONL+0B9A/iBMcA/qhA70a5BOuefCMSnEqeABaXwNxcJNAMUbdd/FcoBOBbVwUEJ9zhjK1CKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Sent: Monday, March 20, 2023 3:29 PM
> To: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; git (AMD-Xil=
inx)
> <git@amd.com>; saikrishna12468@gmail.com; Potthuri, Sai Krishna
> <sai.krishna.potthuri@amd.com>
> Subject: [PATCH 0/2] spi: cadence-quadspi: Fix random issues with Xilinx =
Versal
> DMA read
>=20
> Update Xilinx Versal external DMA read logic to fix random issues
> - Instead of having the fixed timeout, update the read timeout based on t=
he
> length of the transfer to avoid timeout for larger data size.
> - While switching between external DMA read and indirect read, disable th=
e SPI
> before configuration and enable it after configuration as recommended by =
Octal-
> SPI Flash Controller specification.
>=20
> Sai Krishna Potthuri (2):
>   spi: cadence-quadspi: Update the read timeout based on the length
>   spi: cadence-quadspi: Disable the SPI before reconfiguring
>=20
>  drivers/spi/spi-cadence-quadspi.c | 40 ++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>=20
> --
Mark: Do you have any comments on this series?

Regards
Sai Krishna
