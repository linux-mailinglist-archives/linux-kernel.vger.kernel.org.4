Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9F65B936
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbjACCBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbjACCBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:01:02 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF56212;
        Mon,  2 Jan 2023 18:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwyadS+l+YaoFLI11lcKr7ry7sbLvx8bUCqtMLzjWCZoWLur+N/xcZZ7kw0/wZNflHvLRQeZbIW+1uosiyfXmCsSGGU6k4p8pC/VxVOflZl7jSm0sAaM+Gp54t4l9uPiKlyMRraKgf7FS1OV6WS6hXq2Dx4k0GijExnTyXsPfzp3iTV/8QrffrRKwvIgxWIDRfr+MApGqxE47cnBrvT9ijuBp+2H0WyCLzYaDCBGSkRQqZXgYfgRaGF72llnBbrqpyg+21SsTALDXRrsBNQwuTPdSXF2AYO3lLPxC0vpOZMdP0Ljv+FJtdu3uk6dr2H4cOp6ZFF9F7pLseOwthIx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcbrMnyVh4MK6AuDcXEoXbl3mvYqbUpi0ZjFK/5ET50=;
 b=hCKsocTBfzdyW6sFC1q5FxK/g/Rrrl0eh6P4/BuG90VAfuTcz/5d6dOd2jAN/j3mkFbQOb6obGPnN4UarGPDS9N/AXiW8QYtaaoQdl6ep0bMs5ktiyZ889aSNwhvRwpWHtRFfLniCxJWDpejt8DtIl3CccfrIr26KFopDPuFIl9dUn+hakPE6E/r7Tfa3awJcGzm7QWje8KcTOiem9zHZMROOVfw1U+5+LwqK1aR+kFB2lXEcIyMtwmcjQQXHbF/deeC9aSVT5sLiFCGyA5PqmOpFDDdOHbmsIWDDd6Vb0kdx7B/iOIqg8rfIyHI0xAYi8gZZxXxc1b9mnz4J4UZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcbrMnyVh4MK6AuDcXEoXbl3mvYqbUpi0ZjFK/5ET50=;
 b=hClEk7P1UbPsF0zjkXerqGBT+LpYeQ9+oAdHFZFp65RflXc9rSupmHLbs+mA8eHnUb2mRd+VWN/ioyeCm56ENVkTmUVzO7LGlyaNYbkFbGS0oXbpNBb/qGsE7Hw79cr/u+v2ElqwVgR8XLXeIqNEXS7vwRJRha5yvu0BsJKxj9c=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 02:00:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 02:00:56 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86/amd: Fix refcount leak in amd_pmc_probe
Thread-Topic: [PATCH] platform/x86/amd: Fix refcount leak in amd_pmc_probe
Thread-Index: AQHZG1bEns5n/dfa3U6ufv70LWoPWK6L95rg
Date:   Tue, 3 Jan 2023 02:00:56 +0000
Message-ID: <MN0PR12MB6101BA766F292E56092FC7A9E2F49@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221229072534.1381432-1-linmq006@gmail.com>
In-Reply-To: <20221229072534.1381432-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-03T02:00:45Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b78c861f-c8db-48f2-8e72-08995e2ec7fe;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-03T02:00:55Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e344d259-edbc-4929-9d28-546af8cee5d6
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB8569:EE_
x-ms-office365-filtering-correlation-id: ef9e31ee-010b-4e35-1f6b-08daed2e5a87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yw9IMbYbteh53ARwCJbTeCQiFzakU/SgS2tH7NffykbVMxp0nrPPrQyZbc0yqzY8sRtqp9RvoKsGCWCiaH4Ez0xn2B0CyYjcw49XkQY29YFnVNW3+zowk4caoLgeuZSDCeO1l469sJWRxUBA0ZjhEiZ6jJriKpUwgk+4cGGcf7ucAE4rFsQU0j8lS6m4AweeM9nJyYzYYI9kJ/6JLgmvBeMVJb2phSGxsmzU7jPg/7oAlpSO/JBkuqgzE8R17VZ6aov6cC1fiTppVcNCz8iaot/0JrJvwesxlnvNKLkYL8dm5rsJonLaCTjOyZIrGff66fJHpbXQK2bGIlfZT5+FebkPtKtXm7V2x6k2iCUvEXdSSVXBIHzmayUG08hV+2+wfJtjO7kjD9WuC1q8evP0HD+6lK4GWGbRpzIFPloOtJBU13DdyOj+lIpv94XHfj4/dR5+rhGC8IR3MWFeCBNsIdl3iIxFnkpfFx5DoiMIv38XES9uB3fK3WIi6092r8ZSV3hkjlO2fNRDYMwMHHEZBcJo1YpN/Eqy6Lcsh6Mb/I5dR7B9avMykpPWB24PhlYNPLtifqT6mRQD39lSBJo5DZm9D3D0U8kPY1vrO4T++wBTVByGIGjKKPvKiH3xqeBn/ow1xO3iJ8iAoH7B3b+tfRLvo4nDuy48un9FGTuhhdr8K125KjQz4J1zCKTfSsJN11Pk8gbsBHXrBuLi/HxfMMCsOQ9R3YJZrrWBOHjvqSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(8676002)(66556008)(66446008)(64756008)(66476007)(66946007)(8936002)(5660300002)(52536014)(2906002)(110136005)(76116006)(316002)(6506007)(71200400001)(7696005)(478600001)(41300700001)(53546011)(186003)(9686003)(83380400001)(33656002)(38100700002)(122000001)(38070700005)(86362001)(55016003)(22166006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Iv3qrRVLx4dk1z5jf8GRUzII6JkB74+DI7nzX13CgfwbOlQXVsut6jQgkk3?=
 =?us-ascii?Q?9nH1jum3p670uqWCPmcwFCJcVMCIwvRVNtupPsHSYsjxSiROZja+yHUmhCCW?=
 =?us-ascii?Q?T4sJLYE4OivxKstG8DjV1h5K97mTfk9dYJGOzoS0Uww6Ox/XpJ9iBN7oEsX5?=
 =?us-ascii?Q?rn8WtWxRC9tozn8z4E5iN9N/EfHKA0s9o+bVmClaaUbtB7b2ZkNXLDiPFrGl?=
 =?us-ascii?Q?BZ7AVns4V4Zr3zH6qga+ewZJ7jStDXUV31PV7LA1w5nrmHEfMKPqrSb0+sIc?=
 =?us-ascii?Q?waX1JOOqvZG8r1IDzDF+Rs68Qh5KaLBBXZkB4allktF5O5tbjIRM6yCl54WM?=
 =?us-ascii?Q?Ea16wJ5EIi4t8tGHIqFE/PbwxK3Mo3dOB+4wT6UA0IvhQzuTeaVG75lfOLwW?=
 =?us-ascii?Q?VV4Oz2UFZcfvO8Lkr9pRjscDDE6T+UOmKva31LCEwfQL64y69GQNaqj/IWQi?=
 =?us-ascii?Q?gCawd2i1d7/r+jSlXRJ08h/Dor8OV3WaUml4DErF66flbx/jfdECZ8ioDOjw?=
 =?us-ascii?Q?Qvq+qvfGgCoyyzXdYMO3DmHhSmqyyOzO2bQrOG+oV5vnUxX7FUl8ewOMaJnz?=
 =?us-ascii?Q?zXHXyRoiikRKR00x5PCCG9PruDvYzZZBvYt3XZVssKwEKS+Wqsc96TzZIgn4?=
 =?us-ascii?Q?QphmTO9QV2DnvgsjQjm99xyZ1acCF5PYMo28oSLXn4YO+Qzg1csuYLBOuDbI?=
 =?us-ascii?Q?6vll8FCYm2OhJMUasLmsDRPzuO1pHSU/YWpj1weg4XKSzyaPPxfwvHfSK1nj?=
 =?us-ascii?Q?XxoRujY7FxwRQA+YTWZG2PvOxM6DFKEwwE79Ql5Uc23ZdfbZOisR2DgOijO1?=
 =?us-ascii?Q?GjOKG1GzaaJIUZwBnqQ3Uw/i9pXBS0J/nb1E3r0Kg6mLJXGF7aaR5gf9VF0c?=
 =?us-ascii?Q?goUwLlE9SAF+JcrjUq7dIxmWtZFal9W4t9J6/FnxIthLfQ2aRHPBS2IaJzDh?=
 =?us-ascii?Q?4SYvRfktuyMP2C6hPX1FFgWqqSw2ZKYh4pBQu+FXq8NyGMX/rsvzVqdNONAv?=
 =?us-ascii?Q?k7Tf2SpaPappOmTv32UZGa8WREPy6lT4JQTOYLDSZlsrL750XYXMkJevixbD?=
 =?us-ascii?Q?iTHm0S+GBBw8YiFb0s78UTtjF5XynRp79zSnKgaJPWwTf2qb0qJqQ17Xc0oB?=
 =?us-ascii?Q?luINXEFgl3qlNKQEv0RIcwPVMXqkj6FDr5O+ejvq1FcJ6IiFg71ISoRT/pYl?=
 =?us-ascii?Q?IDt08nM/S5J1tSXH3QgyJgu08DYY+1XI/HZsDiqfc+xGQkfcG9eaXRxsjkw9?=
 =?us-ascii?Q?71XISyQaLrL3+USuE3XXAKYT7KERGCkBsldfWoHBLCa21nX6534wi9bTS5RN?=
 =?us-ascii?Q?mw04YDyutsi2HekC23LYX/LVuTb5vFa1fyB5tYR4vcrWVJlT1RZoBtd9R3lX?=
 =?us-ascii?Q?zxPzeVMZXdBwaCimSTX/wcqjUZmK3GiUoYCOIVvJpjYu3gPOkGAthUhRx1xU?=
 =?us-ascii?Q?X/YnyGUnUTprSDzVDc/rgBXvL72QSI5ygWJAh14IGAyA2BHBVoI19e8mM2mo?=
 =?us-ascii?Q?024hDIL4rwYfd4E9k1bf0FF8s7bGcqChLT5UMNyewGlE6XMoRVlQRsyF2Lrd?=
 =?us-ascii?Q?MnulXNVaOYmGtbuP5+TZIrC/pt0u/AOa5yc7deu5co1OZOcQt9qKlzHSI4vA?=
 =?us-ascii?Q?CW6ug5C4XZbsE5oPJv+K2k4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9e31ee-010b-4e35-1f6b-08daed2e5a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 02:00:56.8805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxXlI4f00xhOAHLvR9+KvQpnfplGMbYIkK36wF5pLkv1Cc9S+/OE70uE8uU4iNQDHdGF+SuD6k3mup6wlL8D5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Miaoqian Lin <linmq006@gmail.com>
> Sent: Thursday, December 29, 2022 01:26
> To: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Hans de Goede
> <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Goswami,
> Sanket <Sanket.Goswami@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: linmq006@gmail.com
> Subject: [PATCH] platform/x86/amd: Fix refcount leak in amd_pmc_probe
>=20
> pci_get_domain_bus_and_slot() takes reference, the caller should release
> the reference by calling pci_dev_put() after use. Call pci_dev_put() in
> the error path to fix this.
>=20
> Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to
> DRAM STB feature")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Makes sense to me, thanks!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  drivers/platform/x86/amd/pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/amd/pmc.c
> b/drivers/platform/x86/amd/pmc.c
> index 439d282aafd1..8d924986381b 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -932,7 +932,7 @@ static int amd_pmc_probe(struct platform_device
> *pdev)
>  	if (enable_stb && (dev->cpu_id =3D=3D AMD_CPU_ID_YC || dev->cpu_id
> =3D=3D AMD_CPU_ID_CB)) {
>  		err =3D amd_pmc_s2d_init(dev);
>  		if (err)
> -			return err;
> +			goto err_pci_dev_put;
>  	}
>=20
>  	platform_set_drvdata(pdev, dev);
> --
> 2.25.1
