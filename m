Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84105EEC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiI2Dqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI2Dqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:46:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77E11CB05;
        Wed, 28 Sep 2022 20:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz1GCl6RYmRAmGx0cpdZGOF8+j2CjJW/yE4rYJY2waDkjHt8eUm5JXnjVi1l++xVvmMP+7aoBMiRQ5Q1z2SF+U8i51r6+LbMF0mF5JIZXrSoaANd60kTXpHdWMH/rrZfZ7eKC52Ab43fGDgTYTm3zlsDUUvpPxavsi76GOxVo/UGCJsdr/KkHZSQjXhX/gyi7xax5IWr2zHIuKACnwMZUtWR4Y6UZq7o29ZhHMJ8lhX4I2kcRPtJ7RNC9PVf0nJ0tNe4/Hqw2f4w7Z1Wf/+DZJ/8bPdH14/WsRinJwOmiSA9Sfn+RPFvn8nB12NFX61TsmtKnzCRWCrMzd7gZUuSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnqQaUrcD9HmYzgTYj2bwiKnRM6wPYdtXyN64eyz3X8=;
 b=MoF7RM+Axr9wwdMaJaKpGeJdOy+iAUM+9L9RuMCOPs2bpp1v41OYqJ0eOnzUeuVGpg/BvD3lVX0Bk44oROybGo8amXM/bLeoUgzzZjo6ECPm3jMQwph8fBrjPxnhfMSSjZsgsgNJDeEH5swsoCuzb5VZ5PiB2N2D4lnWvrGC1j2G/wq+WSEcLWOmC1v2xdwvoTdc/2IQN5yUhiI/oKNOZNksz8IiiZ0yHTv34gWSV7epjc+1DufeYBo+S69XB8sWZgL/7LuFb9E6karNb6vNUXk/N+/JY6sMGl7xJ8hhYx//gT2u/JPSi/c4aET4h19TuM98KUhJDUofuG/QWpdJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnqQaUrcD9HmYzgTYj2bwiKnRM6wPYdtXyN64eyz3X8=;
 b=CVU4dwiZCLpTI1vaxfW9fGdNsZ8iO2M0zudAo+oNivnBOOlCAKhpDfgEKyiMd34/s/gy8g/Mwq+zh4SEOKahzQNocqmbBww3PN3qylfwN13Ms8ibDOXPh1gdC1/k31+2N5Vig4UZHspCCkp9c3KjcOdpFOdlL4ds3/nXHO0Fw/lctB+xX1fh0H6o+Q/qrUWAzjNWPPTEKLEVZ5/5jhDSasghkuCabI7jZgzSHbekhU2HT1R8Cz+4AaLZcZdHa9AE/nKsVxvHQNbtv2erVtKNetYpmKEmIbYH1NoKE+g0LkJ+kf5kYZbIbOJlQF4ACIgPu5ZYP7m07/zu5Op6/ua9RQ==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 03:46:41 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb%8]) with mapi id 15.20.5676.018; Thu, 29 Sep 2022
 03:46:41 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     Sing-Han Chen <singhanc@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: gadget: tegra-xudc: Add Tegra234 SOC support
Thread-Topic: [PATCH 1/1] usb: gadget: tegra-xudc: Add Tegra234 SOC support
Thread-Index: AQHY00H+9TYmCRLY+UOYcWsbtNAXmw==
Date:   Thu, 29 Sep 2022 03:46:41 +0000
Message-ID: <PH0PR12MB55006EF3D20D3A85062FAF85AF579@PH0PR12MB5500.namprd12.prod.outlook.com>
References: <20220928135502.3458833-1-waynec@nvidia.com>
 <6648ece7-0a8e-2217-0c5a-5d58dd5a012c@nvidia.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5500:EE_|SN7PR12MB6689:EE_
x-ms-office365-filtering-correlation-id: b147112f-2f9d-4c23-dcd0-08daa1cd38b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wz9OzyFlNR0R9g8OValVNFKQlsGrdNh4EIxhyDbgdwy7nNIyfUVs59c60bMX7rlB2A7ZW7m3YB/d7NHrpSjWt8cBV5eVcZd9x15ODYkCLRSaNxObujvZO04xo/ebWZrHZcAPjBcsNF1TOk5Cdb4nWUaxxdxI9IMK1IhXSzhfEOgnTTGWdIdhEEiSOVPh7+g3FOBF2mBJzdi5j8BTcqOlz0W06uaMZ1aTXyBXQZO3g5wl+44D0v4tGhY64yFqVbD2lMH7cO/0a0AGgCW4nYSOwmJ9bCHHQfn+Zb6eIQ28KtVRDWalRb/0LDdheWtUFStSw95JKEKo95c/xmEy7JxRToTkvYS2I3lgxp8xefD7bgUt5+4jKOHnbUpr/+EQgGJ9KYYUKREdcpnQ8jT7jgY3WMLOF8Wml5uNX42V02D5gXMhmoT0OJzq2shk5uXob4ms+IVrihU9i8+13xV9mobW6sBTCFEIvPE4mm7se2jKrgB682Djz/+uxK2so4IVgnqL2l+CJycX0jeBcR4GkGxEsVG6O8qYW4y5fgRmj/1QkSteupPih3hP2ej6yDfkDxSvQOcnvoyA0wSUMzoKage8hEjcmD4yg8GolyTgSaUGYwgYZHN/gfdzDbxKWMulj+NKdoBBQOWON2b7OLpifdSX/4+pR5CMXhkKfbzxQoHSzLEsqDMs+QEc0ZuT/UGt3YQHjmRdMmltKil4mjWI5cQyr8MXrVSwREMSP2zI+fD3Tgej0u6Tghpo2NzRF1rx/E9mIqzzVAC2DjDnSTQAgGNKOL43ToVq+oq53fkLu+ILhgRfEGA7jISkqvn6yG0O38vktx5V0R4IvePyXDYPrnm+qpcsQCLIwDePQq8eg2lt3xE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(66556008)(5660300002)(66446008)(8936002)(4326008)(76116006)(71200400001)(478600001)(966005)(52536014)(41300700001)(110136005)(64756008)(66476007)(91956017)(8676002)(55016003)(316002)(54906003)(66946007)(186003)(33656002)(83380400001)(7696005)(6506007)(9686003)(26005)(2906002)(53546011)(86362001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lZ6MlyAGLB/XlbDeaUOJhvx2GfbB3ZWqfI5loDoKGbhH9OwdOzH6neCMVkUL?=
 =?us-ascii?Q?tNqt1pt9LTRMGib3JYVRycqkPEgY2oN6BXpFaJqzzWlkJdRaa/5Tt9EWbDSG?=
 =?us-ascii?Q?lxsfqHBnYnsSf0a1vpme+dmXiPyN5zq0K9JmLg4cr9+ml5HmSsx2QEXAgZKE?=
 =?us-ascii?Q?Vg73Jz0PpWKE3fmfqCrEwmDXWtDVsJ21oYKZ5OSMWtgOEg2p6w2DybTavGT3?=
 =?us-ascii?Q?rhWq/JtOXsWXJQywdhrKCKmUjVEvwFWTlLcHTV+v6RIL9Vpd4jAQC2AWIvk+?=
 =?us-ascii?Q?+JSLSD4BAC9GFhXZ6o9oSk3qhkQdLLtgQ183G0ie1eliicCAZZw6CMrjxH6g?=
 =?us-ascii?Q?i5vD5iy8eQ1QAwyAHa1v6rispif3gJ1/opQXlgNKQLiSKwHSXAfH4/AQwIM7?=
 =?us-ascii?Q?WNUqjZoUxEmfkWXTot1pMUFTrL1u/a+QvdNA5k0xTp0+3/Opl3Fhn57A8zEO?=
 =?us-ascii?Q?Zt+MbVzxzlPx4e79NcQkDVrsml0NUIVL8KhqTAigH+irx56tRLW6OB1RybkU?=
 =?us-ascii?Q?ZSXPomTebj7ybakC0KBGmHRTHf6aAfNvqC8+H6rXff1EVdXVhetIJYgEcw8i?=
 =?us-ascii?Q?h6I9KE82l1bXPOkLkihn79Vrwg1ctah9Oh6es6CjnG7jFc2hQYrH0GM0xCno?=
 =?us-ascii?Q?gDSvj4rdRbt2cAWEiCH1pKjcFRaD+/ICGPFgG6Dj3dgy0/47v0lhF1d1yE6d?=
 =?us-ascii?Q?2uctxD5IJGvb0YQKTVf0OaXs4Y+6wygWQy/ghV9qbtGCXHGolMtMQ8Q+X9mX?=
 =?us-ascii?Q?b83n5C5lOTOxGkPt/oGVFhS73m0PMCU1W/WhYioUDaodUuvS9NS8EzA/lRbE?=
 =?us-ascii?Q?fMWROMiUH5+HjWWYs12x/JUL5oxU8tZ5Xal485PohwsRmiTxa1oq70y6jG1I?=
 =?us-ascii?Q?F31Ag6jzNGXWY9vvLRDSefK3kEuVXBg4LtlSrptlvuCZRTgQaVQ3zWCXj+th?=
 =?us-ascii?Q?ZzgsJq3lMXsnueHBxtizkntn2ACwr6LMbC9t3IetfGlhB+O4aujExAHV1Qkd?=
 =?us-ascii?Q?KSwXW8XItQgSZYXdP9rXd+mixoP4k7OCznao3pqoAHtEr9dJfFvptDxolWnZ?=
 =?us-ascii?Q?w3jd+MwDERx56gYJSfy1cpHD5nVocyctP2hGI8IGZDvdyebSycUM60bBv+uI?=
 =?us-ascii?Q?e1MCoocOrNc4W8l2BuOnmmcDI/EIcM0rd2V9vU8FLRVZ1uGxH4XbXYtOD6yf?=
 =?us-ascii?Q?MFBej8EI2dnktdF3C6eEWql5YDTLGreoRRu6CNN5vVvStOuFZNHK0NK3yQhw?=
 =?us-ascii?Q?heWnQEqg/2FPZnNumUDp4jbbEpWYJF3VYHwiS4+iqzbvnKp8r0O8M/gKHugO?=
 =?us-ascii?Q?Q6IE9rAZU+SqfDZ/aQHDofhXEGXtPZb/sC3e5r0iSO0tXjMtdtC96CPq9mdS?=
 =?us-ascii?Q?JPdc3tcrI2P+euIpY9Pp1YDp1d5HxYqL/Q0BbxLs2dQspBlPzgdQDSkCBQ98?=
 =?us-ascii?Q?ys9y4y2tKMRGzo1cU26jfi8fdqLnaec2pd6mnGllRwH8iPb10xhgv3ClzmIl?=
 =?us-ascii?Q?ja7nLWVkTTnCNBAOmUBG0G/jU3l+lx56js1mxkYCEa6x2HgYaFX3fschRo2G?=
 =?us-ascii?Q?F1+PzWe0bJzmej5ZpQlv5NIWzLxs9JiPY/3x6KGs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b147112f-2f9d-4c23-dcd0-08daa1cd38b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 03:46:41.7688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UANfzB34zW6UgXyI7Z9jg0U+rhl521YaffM+R7xzb3syOo17AAL4f8b+VIF7V3N3qGZ6U/caHU+XtPacynWaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,=0A=
=0A=
Thanks for the review.=0A=
=0A=
On 9/29/22 03:04, Jonathan Hunter wrote:=0A=
> =0A=
> On 28/09/2022 14:55, Wayne Chang wrote:=0A=
>> From: Sing-Han Chen <singhanc@nvidia.com>=0A=
>>=0A=
>> This commit adds XUSB device mode controller support on Tegra234 SoC.=0A=
>> Tegra234 XUDC is very similar to the existing Tegra194 XUDC.=0A=
>>=0A=
>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>=0A=
>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>> ---=0A=
>>    drivers/usb/gadget/udc/tegra-xudc.c | 17 +++++++++++++++++=0A=
>>    1 file changed, 17 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/ud=
c/tegra-xudc.c=0A=
>> index 3c37effdfa64..53277aa5a270 100644=0A=
>> --- a/drivers/usb/gadget/udc/tegra-xudc.c=0A=
>> +++ b/drivers/usb/gadget/udc/tegra-xudc.c=0A=
>> @@ -3656,6 +3656,19 @@ static struct tegra_xudc_soc tegra194_xudc_soc_da=
ta =3D {=0A=
>>    	.has_ipfs =3D false,=0A=
>>    };=0A=
>>    =0A=
>> +static struct tegra_xudc_soc tegra234_xudc_soc_data =3D {=0A=
>> +	.clock_names =3D tegra186_xudc_clock_names,=0A=
>> +	.num_clks =3D ARRAY_SIZE(tegra186_xudc_clock_names),=0A=
>> +	.num_phys =3D 4,=0A=
>> +	.u1_enable =3D true,=0A=
>> +	.u2_enable =3D true,=0A=
>> +	.lpm_enable =3D true,=0A=
>> +	.invalid_seq_num =3D false,=0A=
>> +	.pls_quirk =3D false,=0A=
>> +	.port_reset_quirk =3D false,=0A=
>> +	.has_ipfs =3D false,=0A=
>> +};=0A=
>> +=0A=
>>    static const struct of_device_id tegra_xudc_of_match[] =3D {=0A=
>>    	{=0A=
>>    		.compatible =3D "nvidia,tegra210-xudc",=0A=
>> @@ -3669,6 +3682,10 @@ static const struct of_device_id tegra_xudc_of_ma=
tch[] =3D {=0A=
>>    		.compatible =3D "nvidia,tegra194-xudc",=0A=
>>    		.data =3D &tegra194_xudc_soc_data=0A=
>>    	},=0A=
>> +	{=0A=
>> +		.compatible =3D "nvidia,tegra234-xudc",=0A=
>> +		.data =3D &tegra234_xudc_soc_data=0A=
>> +	},=0A=
> =0A=
> =0A=
> The device-tree binding documentation is missing for this compatible=0A=
> string. Please send a patch to add this compatible string to the=0A=
> appropriate binding doc.=0A=
Thanks. Sent out the change to add the compatible string to xudc binding =
=0A=
doc.=0A=
=0A=
https://lore.kernel.org/all/20220929034221.3817058-1-waynec@nvidia.com/T/#u=
=0A=
=0A=
> =0A=
> Thanks!=0A=
> Jon=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
