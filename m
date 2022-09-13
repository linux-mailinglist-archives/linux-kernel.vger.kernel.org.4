Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D36A5B6BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiIMKkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIMKkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:40:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95CB13D5B;
        Tue, 13 Sep 2022 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663065612; x=1694601612;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7FN1J4G3wjw9DwPl1bruM2WJ71Pb+xURWalFYCAhdFE=;
  b=p2lA9IkkKreuGeDVquzm92UI/zynGraR1pLcWrdJMV9oVMIzWQQcWzSR
   egVZxZ05aYS2FNYrSuTi6svkcwUsgJvgGb+e23bicoNEgUMtEdM8fS85n
   9HLlZNmPTKbsMP/8n/oPE3yedB7aQ6zxP2fBFypaTrXMeqLMHjeDBzuIZ
   bF6XtcjpdvfW9Dwn75IZRs+LOm9CUHbxW3oqpS8xaSsc2ZrQZzRZzxYGS
   BCRrzWtLhvujuyHoN/ffjgsoGo165TnYLd781RJfUMfX3Gvsyrz0ohsWs
   4Xh38kakOGvrqqRIQESdIAYSWcZnXhjI1TO9fJMUYqKpoj/8pk/GYm/3O
   g==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="176894756"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 03:40:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 03:40:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 03:40:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaHIEWkZuv8sshLIxPDz/cONwKrskZS8fB6azlwjbFftyvVBwUdxLSqB5Y5rw22+xuAHtASUngits7kYnpks1YEWMD1DMZhbZDB7Jhti2e38o69jhJRYILvd80u2+4AIxJh1yANlPrLxQe6WRDMydyCUC+OYCiqER7SQTr01gvWrFG6EfyPRwX32Rs1V9GG8MxKZmiO5U1nSYN12JmNpgkp+Ms7kguRQjRXlcelaDxw9RqPzevfTpGveLHRWaUOlsNQ/sr13Gr6BJuTVgR9tj+VaaC2jx0MMpr+xsJYvpp+wQmQ+DcKCtlebFtbfqPzojasIc1vy4LmUrgUuqlb4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaRSvWdeAF8jeiu7XQ0Drd+V8fR6ZA6nJlq7f8SZZ6E=;
 b=Z1IfMMUhmc3sJObJBa6TTXyMem4f7uz2ZumBqy/MASlC55Y8yQiTOS9SNG8/MfCFj4yziQsUF6zbpuWxAFPF92qrmxIdV/2lBkwG58lZcdIRflDdkaJwabkg3AhT4V9t2DZA97XZnOHvD/lopqdM7jbcmJjWnR0LSz3kjAXLoAj43Cbka1pqnrCrdDpRd5cyFGidW0/x0fHusCP1IsQvEA4vPt8z0FgHHX1yJDR/ElWa8y76Q8c/Z8lvZf0dh59ufuD7m4iU0Mhebvb7uuERR68yL4vzUUxm71wFGnU7LiruoSMcfgO+bHi0t/Hht7jzHsVPt6TfY6cLsYsYSlyfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaRSvWdeAF8jeiu7XQ0Drd+V8fR6ZA6nJlq7f8SZZ6E=;
 b=d+SeREL8XsBp2BA9G9N++dCh+BQaJZcZi1gsChB+NMXzZjMWfigqsCJMGgcCR97En83czucmt1Gz51nVc3XTMosKntZMCyxIS7PU/u0L0nWaZvXLhcGyQAaQoD5uGQM0CdgyuyRQuIYYroaxkELbvsE/T5oXdEglpGuazE86yRc=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 10:40:06 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 10:40:06 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <hanyihao@vivo.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: microchip: pci1xxxx: Remove duplicate include
Thread-Topic: [PATCH] misc: microchip: pci1xxxx: Remove duplicate include
Thread-Index: AQHYxx1r8U1+X3sWmkyGD1kTUfN6Zq3dKmgQ
Date:   Tue, 13 Sep 2022 10:40:06 +0000
Message-ID: <BN8PR11MB3668E44A26B283FBEA5E8C6DE9479@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220913030257.22352-1-hanyihao@vivo.com>
In-Reply-To: <20220913030257.22352-1-hanyihao@vivo.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|IA1PR11MB6540:EE_
x-ms-office365-filtering-correlation-id: af279f90-21b1-4a3f-1203-08da957452b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emP7xVKuic2+F+ajXy5sjnWzkBhZPfsli8tGxsoWF2iRX4gPZ9o/qshpjwhpTVF1EbVpiLoUp5RBNW27j0NMRWamWke0YZe/qI+8aT7cr2tDBLE2oO925bYlWDYPkEBOx0JIgW9BIomjrrXEQymKwAOWE2R6wC3qmVyChtWZ9fkwWuObuKXoGZo5OBIsKF9DeKNDLLrqkhN3pGDjeA4p5l/BEnpYPN85gW9dsl3WZ4YFtOLsJCUj7G46uEG0jPLyRF1FCEKbf9DkR8hN1koO6KcqEEAHGipM/zQghm5aIY/0I/WRwGMqKppCOWo7ppT0kYtxqRGZ7MOsACqiGgp3sdl6gxBR4GXtnsfXayihdJ/Nl8Bgaajdo25lW4eCsgrJfltrafv7Q62p4IrMpwx11xfnTnBfEzajutggz+C0HW0+7B3SVl6RazoTWPxhhkuFnL5W8KrlQj+MIeBVhGu34XLPny2SrcFTIR0Rk9Blqx+c1kiY6djpWrFncqXhXb5IoHlbdE4HqtrYsQWTd8/nxn1tdZijTFFXmL48n7Qx6kE6JAKO6MHopRnAhQMm9bj1kQ87db9A65zrRrW9F+KP1eURkCvh3cFwhe9zYPYCv2q67rdTDX0GHzLhpRiuwg1JbEWhsxhCP2mo0sx/f3X8lYBWy+MiSYC2NF1YypImBaq4I6lTIke4BAzfjY7koxNSbxLQWFQeDm1ryY2Qs9i9FpkppMSigWDGRLTX3VhozcK/1+yUC6mAVhL7p34+DP4vxKg4IiXyb69cPhsjr/GgsdG1Q0SMK7Ew6344koXD+5uZaZ3Dd1dPZ2oSFCMDib7pryah0c1l17bJSeDmG3Y203KNwKySaeoyw4foBoaoTPc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(66556008)(316002)(122000001)(110136005)(478600001)(9686003)(186003)(76116006)(66946007)(66476007)(5660300002)(7696005)(38100700002)(41300700001)(8676002)(64756008)(71200400001)(8936002)(83380400001)(38070700005)(33656002)(52536014)(2906002)(6506007)(66446008)(53546011)(86362001)(26005)(55016003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WrJstPIzFh9dKdubUtPxd5t1P90Sn1+tk35lYWzux/6YOZiLOlUt5ewf+ABt?=
 =?us-ascii?Q?/ucQxZmeoNJBh/0XwlXphklROKjDf2dcJgJb2uoVLaCNNyYb0I7tyFBUVIct?=
 =?us-ascii?Q?VETPUbhAY5L9kWWv7ci53aClBDdqxsVwr6Qa9pKPAzR8GjhyE7l1YFxlZ9Ht?=
 =?us-ascii?Q?BeNqzn9eEr2vWDN4ALQ4YR206PD4DTkuLVb1j2gwdy/r18s1mfEl3KTO8YCn?=
 =?us-ascii?Q?n95WW5xez7fIR3bFiylxjp15UBjYB2HhayCB7awQnNC60BNeSbS9I0Bo1iA2?=
 =?us-ascii?Q?xnKP6j7s1evsPlZqmWnbTFxKIZI1B8AsAmINtya0QS3e0eiI6YIlUVqX0+wJ?=
 =?us-ascii?Q?A80hWDUFz74Eo7GPeLmt5gnR51SVvR6t16S7e0SyvQ0IkMJ/qWrkTMiYvwKW?=
 =?us-ascii?Q?LmBTOxJxrYZslYaxq2kj7cmgeSGS9ApzoMw4RyIRMW8hnVSm9yI8EfpOOGsY?=
 =?us-ascii?Q?1mKbImrXuzTQYuYL5MxVHpj81TyIj7uHVId5eAihvCBR77iM5DbJHl+6ZV0J?=
 =?us-ascii?Q?fxrysKNqxuRp1jP20fEcqLdE/rd21LD9OqoBQ2MEHajHGeYrGrsvDUXRy2hw?=
 =?us-ascii?Q?PZ5rHwru3O+5CUm2s2rAgrH47RidjnYjevUviX593QFtOq0N+3Z7Wf31+C5t?=
 =?us-ascii?Q?If+1gWMPomUkhEt09r4ClFGwtSnTs5IuqczkxK1YCCGLuyt+VVFnXN3Bh7gC?=
 =?us-ascii?Q?ouw2x6d87/6NS8rByRk5PZnmQMlFbUya1Oqqhk4Da/Hgrk/f9He99/LktS0h?=
 =?us-ascii?Q?dz2Y2Au/55Zv9KOYg5C4HVMTvbxuck/hOv7bE4b7ZbL5zHqLOKgiiNPhFoSa?=
 =?us-ascii?Q?qJHnFhU1yp138NAGcFdEFSOFAdgpPZAuRAaro2ZwnilaTRJGZa2jAAU3bRex?=
 =?us-ascii?Q?U+wvKIsayn0aS6jhBJcbc52YzkkGTiAKr8uEcWruoS8KCZ5xxMg/QCpA5WpZ?=
 =?us-ascii?Q?63VkdH1aPANlg0Ulr/4hqtbCBCVsT4mZQwUu9eyFTqYlaNUUhNty2Ie6ZmzH?=
 =?us-ascii?Q?devux4KD2VrK6lAGW2oVOhcDIYuACnDFNXBq9jVTH/x8TYKkMWLtQXw4F+Kp?=
 =?us-ascii?Q?KMvyVQnVmGduyc12H1LLWSRrTsJtBMjpRmrxmuorne8jmHX2QyEHtOtMSG97?=
 =?us-ascii?Q?Cx9Vzdj/didtH/hAUn/itAanyNsmpZseQp4MGwYRYsR4FLzQ4ot4XLuM8QZ5?=
 =?us-ascii?Q?qjzZzZJhiE/8R800dVUqTkjftcmssc0081XX6HbjI24p7JRzX2JCeEWiFo5k?=
 =?us-ascii?Q?VJN5K6PTTtTMCRr2daJ0ONYSdWRMv3495YmLTVnGbUCbeb7cm1E026bxalkp?=
 =?us-ascii?Q?E3XHAkLfkevIvdxHmq0CtasPK6ZdOm/uNvC64JwYeB0/bO9rrv8OVyvCK8jv?=
 =?us-ascii?Q?9BD2nkx6oHCwmafC9gKDFMQFnym5bBsCDfO6MG823fkmasos7Wbvazd2pXpa?=
 =?us-ascii?Q?OO2KR8kvOoCpr8bYbbUa8M1UlqicP4o4IhvIt1tAnBjrr4zA6mYoclvcYVWd?=
 =?us-ascii?Q?uRSDuDIKgN5MXfl3PQCnviVW9rer0VJyWUzO6dwfzR6n1NAQ635S3pCoF03a?=
 =?us-ascii?Q?n8Gk+DpHiAO2COyTtYWbhMY1Ji9QW5UT7aWAqjTrLY4JoudrzBmINNS8eLrF?=
 =?us-ascii?Q?ECdS6VYFBqvHtw/lpdUTaZ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af279f90-21b1-4a3f-1203-08da957452b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 10:40:06.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48QCTKe64RNWTGHt1lla9iG5F+zcP/iCpRh12hhYK5RiJ4RAuBVcRgHTdjNcoMmsihmZ7Krv+t01gA3f12vJOuIINAa/lzG7dSR06piwQV/LMX1lPfeBZvM2KTlqLkRV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Yihao Han <hanyihao@vivo.com>
> Sent: Tuesday, September 13, 2022 8:33 AM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-gpio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Yihao Han <hanyihao@vivo.com>
> Subject: [PATCH] misc: microchip: pci1xxxx: Remove duplicate include
>=20
> Remove duplicate include in mchp_pci1xxxx_gpio.c
Thank you for the patch.
>=20
> Signed-off-by: Yihao Han <hanyihao@vivo.com>

Fixes: 7d3e4d807df2 ("misc: microchip: pci1xxxx: load gpio driver for the g=
pio controller auxiliary device enumerated by the auxiliary bus driver.")
Reviewed-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> index 9cc771c604ed..3cda6e679cc7 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> @@ -6,7 +6,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/bio.h>
> -#include <linux/spinlock.h>
>  #include <linux/mutex.h>
>  #include <linux/kthread.h>
>  #include <linux/interrupt.h>
> --
> 2.17.1

