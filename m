Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199BF6B028D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCHJNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCHJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:13:24 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2097.outbound.protection.outlook.com [40.92.50.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60140193E2;
        Wed,  8 Mar 2023 01:13:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCfwdrM5afUmE94po9kPWGuD2nrfSkBtLHcci2kDt8bOflL/gK2UFAlzHid7ZW9vk0AeXr1IZwBbPivKOs/2JS6LcPCEzPYyuszmTiW9lhLcbxfVcEuw5+7exuwGoggw+9YXcT86y0FcAQnYrgfyW/TclNuOvzwnq+Jnor3XX0WCYKtKqZO/A0OCHtk0LHnaTmEDeDVc9Ugin1tD9TkKatWsROjw2poSRjs1amV/CUyS89MiUp/4mCcWn9/tFFcu0N2//fkT1Xb45ZyT+w274Vc/sQS1W0izhZGPrgnXkSC3JUUlFoms30A4pKDA7ImWN9i/zhbF0w1FW+4TqZ6WwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUDNfyF1o86eYSutECT0RPhKPqklipd94C8puUfMBKQ=;
 b=KuxFgXLQMLcqp1grP6PPmbB5UXHaaNDNNTuYSHKQ62EvH0RoB9yggMsPE8RNKvrGQt16KtvHobznVsXEqkk5FCTf1/sCM9beiDVAfLaNqs5tAzBfrmkGB5aerqWWZ8QmDcleDKlg53ng+hv42/U4wo21bSGCbXKxjDkhZlfYcOKTKMxatlBJ3UF7//Uf0kE/NFy2GVKgDVKsg05ATf9pSR84/hShvJxp5TuKQhbREuRIvWEa8lCf++tkTm6f23BkiGxvb5Rx0vRFMDPwVy9C+L3SJvQtpRUYNOcDzY/9fmHUanNxj7Ix0Dm3D5caINjoDBIiYt/rgyk3vGKEt3Iadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUDNfyF1o86eYSutECT0RPhKPqklipd94C8puUfMBKQ=;
 b=fwN48dLeS3Lb9MeVc+NRVm+5fD4n/Muhz7XOwZq3g8wi9pQ+zh1bA3BFqPX6jaiFw8EHBSiTlynoiwCs+7CdtX74A5cB43OytJC+2YLkveaaZ6Anx+9Le+jYcakPwwOWDB5pIrFAz/oTpOCWx+xMQdmxkMrLmNpBHkrS1KkAOn+fqVI3Ts78thuEtkvSb2SMyS5H4z/weUo1nX/ffz4r5D95VszGt33Aod06dyGJQW3Pz7X1d843AN3k/vo4u1nDLwWenJE/rX6BrRrIdTUyl1qOCfg59SsCLclAU8zat3GWijc0Icybd0qPq8dfc4eX6cFQNIv4Qss3KhCHhg3Zhg==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 VI1P189MB2516.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:1c1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17; Wed, 8 Mar 2023 09:13:04 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::325a:fba5:af4e:4484]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::325a:fba5:af4e:4484%7]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 09:13:04 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     David Miller <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-6.3-rc1/arch/sparc/kernel/pcic.c:768: possible problem with
 shift values ?
Thread-Topic: linux-6.3-rc1/arch/sparc/kernel/pcic.c:768: possible problem
 with shift values ?
Thread-Index: AQHZUZ2fEKKqwQdnhE+2ySMxKKC5fA==
Date:   Wed, 8 Mar 2023 09:13:04 +0000
Message-ID: <DB6P189MB0568F1B76BF4A4683DF2B3229CB49@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [CgrB1Tb/LZy7ZjpnrvTv11ksC2/lDzzF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P189MB0568:EE_|VI1P189MB2516:EE_
x-ms-office365-filtering-correlation-id: 3db3e82f-0e99-47b9-7359-08db1fb55326
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mffMyjVBc3XgQygYUCaZ7+HM9bj7L+LKnvplkvUhvlks+gYl5EeRJLgM3mbFo1mn+qyPNbWpb7pcgCfyyMKhr5Gbx4Ih5TwqMLPD/QNprh6LVtBU0ku6v83iwbhyRWyqtplEBMjnt5tKkKYKbv9mBUWbz6kTP+gMAHxeM7WTi9X7qQmEEa0OlWY01QI7mxySFrGkunf4kWTre3X8PcxCUxpkd2qwdDsyZM7oK/mhHaqV5f67vDs4K+ZefRBTzLqSO+YGcOV49/Lc6zlHOjdb6ldfzVYRF+nKk+YTSgwvlhcOr3YiiP31li2H+ACPV1xy9Tav7ibbDRvFHWuFxsQfEU2dkzdgkwQqLQ35QVhxYxdR3x0Yc9Y20LSYWwy11qLmVLNPmKhFjk5oEU7T1k+9xCWeEWwZLr+PY7AlxF7ubunduyTdZq53ShVHFrna5lEmPJkEKuKhpUyfyRzE3WcG166oyf/vngCxBeDP8aCyyFyTMB9ceJ1RdUkYI47fpk0admZyYHB+rnhw5F/anB+qHItBhBbeO3ib7onEmxVGgWrLzh+jRztUsOe6//BEwnPb3UPtgHdfcKwBlLXCa2ww9g4+ouJabBRtnnSl3GDWAyg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ggUko2psRmn9GJHCN9O3vvuer9WIYQpUvN/QaN6fiHs5P63qyp8aSwtA06?=
 =?iso-8859-1?Q?E6IaV5CncfFWMN6D+0cKAsmAcu5wGO/Ia6hbG4egFNWGL1A5/AyCrU6PmF?=
 =?iso-8859-1?Q?RnQObcr3APkgt919Mt97Z+jlGOFZETbUtnbpX7a0Dyers1DzfqIgX03+ZP?=
 =?iso-8859-1?Q?O6b5ydxpYcHD4ol6qpgS9Bbt5T8sT0yZ7QtuMSInMwO1SLiNHjnxUsyW/c?=
 =?iso-8859-1?Q?vaLdbtTNPzFcyKu4WngIq9jlgGVz6nicCqsu5Dp/MW0PEqRBsctzZ4Bcma?=
 =?iso-8859-1?Q?IMal1Pzz5etSCUVq4cKwooQdPpv1Q6YPhuZpYkMeEZv5E7NV/RiaM0tkkv?=
 =?iso-8859-1?Q?Xy6tNL7QoS7100XH305Pg42Gv+xTfMC9vKTc5MX53dVLY/TqZVUZDI5WME?=
 =?iso-8859-1?Q?EjKw2SSaSZQZnJLMlv34IKMgPjRAPIxUIhdvfrqXeeTCKXKyyz1QwXok+2?=
 =?iso-8859-1?Q?wOkFvitybYdC9JqYBkgLZrAQser1gQHdsi/ao4vNDdZDt2c2e7/YEr9wJv?=
 =?iso-8859-1?Q?JKnPJMfWaxH/RPkGPF9wnoDXocURWBYauXulV9l56KZoEt9b8/G2LdNll9?=
 =?iso-8859-1?Q?lStbItiIMHKZR/fc4sCEg/Pj39/ddGwD3VBu/AbzlpJKymuUvavj70+YtV?=
 =?iso-8859-1?Q?9ftNs8rRGRTMU8CcMyH8AHf2NPbvpcHDlrv4nODz9fLuWmheFN+ZoQoWKh?=
 =?iso-8859-1?Q?92GGQpZ7dz5QR9PjmADBP55cYrHlUYjgTYMQ/WgrHKSjCaXJ1xIS+ar1zb?=
 =?iso-8859-1?Q?ZgyZFqZ82ZhhqjJFBmcvddwwSlru2RBkifYuQJB5peUByEmZw9pn+kA2st?=
 =?iso-8859-1?Q?VavqMaNN1Tp2X2F935ijMA9d14fOHXpXWbqjSVHz+JBNn0wpQCtNya2z+8?=
 =?iso-8859-1?Q?OKos550/HNQ7OXBUnTytwP6ltMFJCZcw9tCBzuK+8WKna2cAtZazlvukw9?=
 =?iso-8859-1?Q?BgyX1yoNqvo/AKMV5Yz7RLq8Z3f/AEK+sWozhL33XMlEWL1Munh5nZm80c?=
 =?iso-8859-1?Q?EBV4eycX8/a9qQYKurA3VJChYwUK4tZe/zo9IU017F2Ewv5HbnGf2SeS84?=
 =?iso-8859-1?Q?ZX7t/hjh+pNzNsUaOWQkyH1bWJGJ2GeIW/zwpx/BjIviFY+umfgL9a2rWc?=
 =?iso-8859-1?Q?vRkcyT+SFTjJ80y6ynVutDy+zuIwrTD07zLsjueq5892BljxKYJe2ZLyiL?=
 =?iso-8859-1?Q?hcmueANo2dQYypDbdNf6AlL3cLQ8c49msuB2uDuNGDn69qDdcvSh5FVuUL?=
 =?iso-8859-1?Q?U+E8dYx7jcQaJiUIPF5TWoOW1c0ds3PLFsGXyBsmYTl+0RZtGmJA4fdFl1?=
 =?iso-8859-1?Q?D+Wi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db3e82f-0e99-47b9-7359-08db1fb55326
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 09:13:04.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P189MB2516
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,=0A=
=0A=
The source code is=0A=
=0A=
static inline unsigned long get_irqmask(int irq_nr) =0A=
{=0A=
=A0 =A0 return 1 << irq_nr;=0A=
}=0A=
=0A=
That's only going to work correctly for irq_nr < 32. =0A=
If irq_nr gets >=3D 32, that will wrap around. =0A=
Perhaps the programmer intended=0A=
=0A=
static inline unsigned long get_irqmask(int irq_nr) =0A=
{=0A=
=A0 =A0 return 1UL << irq_nr;=0A=
}=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
