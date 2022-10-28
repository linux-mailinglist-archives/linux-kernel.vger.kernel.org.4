Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD89361172B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ1QMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJ1QMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:12:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A11F22E0ED;
        Fri, 28 Oct 2022 09:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcrJoeGs3RDtnkgEFNk/2/l/W+5KhUEc+U+M7CWxRx4x9qFRjB+t42Ef3LSYgbP/uh6rGZIB/OndM38DCs2ID1l9jmw+VpiB9m0bUO8Fq08v5fpZTZErZCUcLTwLEiCDPL/uKEnYaQZmn9tqvVuRcNx4UKsmgqZCxoZXMw6LJcJ2GmO1PGpf90dcvVAwmxd/c0At0l8Ra52EDNTPJ2hKWF9lDUoACpICFFepkgZKKjk7Jg6g3aPD0aWmiryoe13v6xHCanh7vn0BgpseS+lD8T1CyPF3DfrPoxI169w8EPcutc4l/cHdYKQzTIsXUKoqaIAjBVyc8lkuyPuQGWibwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhWQlrZjQbG05SXmD1/O2/pdNW7R9kwROvQaXzXuTyU=;
 b=YkxuENB3w56wqIrLnwxMkfWQQhKN5O38kgRfLtPXDYlUS9a40DXeYiNca7eCaHk8pF+t0G02H/1TiPD9gn+7E/Zp3Y+qJJIBv2ogvbKxzKgrjkKkhadI4kmScrDn7IVNwXy/T/PCjYnyUY3/VJSdlYQpCWlUvDxeVt7ji7So+zRx3la2hVmy4Jh/zWEDPYIq0PfT8K9fM1n58JreDPZ/HVO7OcWQXBu6q+6JqvLhfWRtXAiLrZMdZOgwx9x1loiouCeAJojVN+FqA0qgOJJDOD++0KQjzdR/C/vsh+56RmL0hS+BL2phcqJ76S+hYnnqCm7X7dlls0r5VNyC9Aa7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhWQlrZjQbG05SXmD1/O2/pdNW7R9kwROvQaXzXuTyU=;
 b=GqKQO9Q5enloUMIR4h5Xybfm3A0iOjlxJZ7GStWr30lMnSi12FeAP5ZwFHe8vLgzWHUem/MwqiBCaZ5pPXNofsOGdyEj2H0m6VoNCxz3pxITF8TDg4wCp/o8nM5OgaBJu7HxhEBy4oRPOHJpouNv/8RVwQ9+bt8CeN6h5eMxIMU=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Fri, 28 Oct 2022 16:08:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:08:53 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "balalic.enver@gmail.com" <balalic.enver@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "markgross@kernel.org" <markgross@kernel.org>,
        "Tsao, Anson" <anson.tsao@amd.com>
Subject: RE: [PATCH v1] hp_wmi causing rfkill soft blocked wifi
Thread-Topic: [PATCH v1] hp_wmi causing rfkill soft blocked wifi
Thread-Index: AQHY6uW3bhP0DQqAC0+bP3NnlhkPDq4j+AZQ
Date:   Fri, 28 Oct 2022 16:08:53 +0000
Message-ID: <MN0PR12MB6101426E91BB9B6D1A4F03F6E2329@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221028155527.7724-1-jorge.lopez2@hp.com>
In-Reply-To: <20221028155527.7724-1-jorge.lopez2@hp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-28T16:04:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=41030fc8-02f4-4d17-a1f4-6ffb2032f245;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-28T16:08:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a3c71c0c-0f38-43cf-bfeb-67821cb2fde3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS7PR12MB6336:EE_
x-ms-office365-filtering-correlation-id: 056abb38-9921-4728-8afe-08dab8feb58a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aRzWtDSG8f3cQCfUgalXLaDSV4XVg5VabW9wDANn/D76p2kX0qDOuQuAh/EZZBsX149wUNF5D/ImFq6FfmaHca8KTALV/qFy0q69vEJ7hGpQlfcp7vf3/LWL8Yznk0yjOl1ZkobGiL5JrP/9elQKhEwMxPOOMf2LN5U/A/07M3VvtWB98C/qlUHss5OAQT2D1ILwfyUpkvmPfAPkNBIpiq4diJwe8scSf86IfH0oXWcPwW4KlHF2CV0FvJjDcUGoIuhpCqhlXNU27w7qi+Jt2zUY0ipNJRUTWOyo3mGZ+5JHzuFimIFLmSyLt9hrFcVliSiQSTSoMuuFk10exI51CA4CweiIcO3RP+spJFWYOuHsLmmBUeLb2wtjazIi8ciFDjmM83xeq9UcCg5Ao0VXZ/cw95O9ZDTbLftRCuB8VkU3UnckStZgdqaf2mjJjJCX2tlg6P/AT6pacWq+zjUCeQ34xAx7NQEpjAzgK8tiMvDjiCC6I1XdbQ/fcA+WTghfgNHMTF3Uj1ktTm3vJUOuapUrVKThVU7pXqwM5jY2qivZxM37mrrbdkJuHHeiVWzORpWrfERa1rYdPCMuJYCm53jfNxk2wG6zFjYGr8l7JdneuHcgt41n+ucppiAK8P82wBnxujA+qe8UdaR+9eYQB+ifiOwjGzbH9Wfz1x3znb18/c62eW/1PhmpWrzwGGNtuUDWfySsLGbn1dGjtWFAf5P+dguldgFogyYZlHrVSo3z3O3kDoTV60N29oreWovyHlRf+v7pl+Fqyqa/AShrZcfcs/zeKsLWiC4eXTGKck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(84970400001)(186003)(15650500001)(55016003)(478600001)(2906002)(122000001)(8936002)(966005)(53546011)(86362001)(26005)(5660300002)(33656002)(110136005)(66476007)(9686003)(54906003)(316002)(71200400001)(8676002)(41300700001)(83380400001)(64756008)(7696005)(52536014)(38100700002)(76116006)(66946007)(66556008)(66446008)(38070700005)(4326008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7JeCCFS68eKPEaNQahmArHN0QOp8G5YGFfgOvXC5vqzhgdhZCGvb89WuMnBc?=
 =?us-ascii?Q?tqp6w4T5rJs//yhzn/yF2eW3ETMNpEYNptF21cbnSEpAAoy0kYvmIeNgO7qm?=
 =?us-ascii?Q?6+pm3Zjxcrzqq1bsQM21QeYtoRg00GHzJh23HCJy7AHFBazKVGh7MEkqQEWM?=
 =?us-ascii?Q?dxLK2b7gnTHsbH6PNZkNEIOO+hbvYMn0tE/f0VO6ERW7dlfgkouzGV8QJSFB?=
 =?us-ascii?Q?b2gkbjMjJv8M+ac/nFEggvzQ7/UeigyXEZjKXiaSjduBRX+mWXBE9bScMSFP?=
 =?us-ascii?Q?W923ihRywJiR8EUvS/ITiuH6GixJsf6q5mx5ljEnuOoVGRRjy2GFThIyGafO?=
 =?us-ascii?Q?uf9ai+5peXChInS90/YvGhI+3E/+3xw2gjzyuYuk7qBtIKC0/moDpQTRbkJ/?=
 =?us-ascii?Q?xdWPenoJfEWScIW93hLYMQx0PvbSqI+euRdxSOli19jqB0RDiAQBdcWtfJfP?=
 =?us-ascii?Q?w/bFOirrEI13WxL9sXdBtwJMcCMNAq0yzRZmj9k5sp84bvrcF6eJvVUGvCEH?=
 =?us-ascii?Q?hQku9j7c++ULLS3ThmYX46742uDXTU3DvEpEe7bZqNhqLVt0cMa72i0MQ1o0?=
 =?us-ascii?Q?9QuO+oRWFBAUp2eJUmALc5IdnDMl/NM5+Q1IjCZ1lm/2ZIcl2O5eiVVRuB0t?=
 =?us-ascii?Q?N998ZHfKDohlBE6boYzsGmXvf/t2gfxx1jnW41U1CLciXOVlKecXh17X1oCO?=
 =?us-ascii?Q?SYmwgmzt47I1AOATnGcCJjSlVA3PejRiNM0JdOQ2boIHD4DFavHXq6O9c7Hp?=
 =?us-ascii?Q?M5BgSDWx0sF1u4l0p6k+YaX7vDxY5QkWwgX6Sakgt95CTpv/+DqkFS6F9nVp?=
 =?us-ascii?Q?kcbqUwA4dIvXRLiuopqQ/202580vbtVnix75f1A/QL0jg5LapzAB+QbUubLb?=
 =?us-ascii?Q?dBo9CdzdcgVZuB/dblEcVxF1MjTAbSKNSKv1f+C+q/ky7dH83mRWYYNiJRLS?=
 =?us-ascii?Q?9tmSB1xBECuEN7CPtSaqz7WodaJXFjo0Q8p803z31pQP779P7uu3eN8gxZRf?=
 =?us-ascii?Q?aJgCF/88Q14etcnlKepzw/lhQw9j1saWyyiMubqAcmhQPHQw3yCEzWM3/F/T?=
 =?us-ascii?Q?H7qZt3kvxC7oioaEUpkt3nTAsr/9u286zJQh1wSt9EL3+DrIQCaEL0AU04kT?=
 =?us-ascii?Q?eXUsYD63vrJ5xoRNTv7/e+8fqReJiIlmPG1BEcmbea9Esvsy4VWVaXxt5EeI?=
 =?us-ascii?Q?LK7g+rSpS3bSA6K0ir3iB5r8JSwYi8AXXJtjacEDGn8qNX8KX7JgqKXZwgnw?=
 =?us-ascii?Q?5W93xUYfjUBWTsc/TscUk9pGoH7UGf1TuEn9X/Y+pIUgaplGaUeEfp5OR0jv?=
 =?us-ascii?Q?WBnYCcR/Gaskv0fWDMBJVFEI3KGE6WkFIW/8F5Ig6s281Tq3P1tdSEtXj9Eh?=
 =?us-ascii?Q?iZ+D8gZYXRnK3QI7AT4gaag6iarSG7xNYsFIECtCzRZ1hXkNicjoRc1rDX7O?=
 =?us-ascii?Q?YZUyB+qrxTCFMJjf6EEpOQm818lYcEfnUFH6z2f8VWKOkEgojgPuPuQeYRc3?=
 =?us-ascii?Q?YKnjIsWuvqnpDyPMSNAjO65/HlT07RUvS6wEComa9Vdi2gQlf1gtxCA42lAd?=
 =?us-ascii?Q?6puo9j0XzLCjmDzbJDY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056abb38-9921-4728-8afe-08dab8feb58a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 16:08:53.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRcPXfTLE0WlWYHSgsXK4Q+cA5SH+xjC0pxS/dP0CmIdj54cVkmcPrpSrw07H1hdcSLNvJuQe5sgWlGFMyocFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
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

+Anson

> -----Original Message-----
> From: Jorge Lopez <jorgealtxwork@gmail.com>
> Sent: Friday, October 28, 2022 10:55
> To: hdegoede@redhat.com; balalic.enver@gmail.com; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: markgross@kernel.org
> Subject: [PATCH v1] hp_wmi causing rfkill soft blocked wifi
>=20
> After upgrading BIOS to U82 01.02.01 Rev.A, the console is flooded
> strange char "^@" which printed out every second and makes login
> nearly impossible. Also the below messages were shown both in console
> and journal/dmesg every second:
>=20
> usb 1-3: Device not responding to setup address.
> usb 1-3: device not accepting address 4, error -71
> usb 1-3: device descriptor read/all, error -71
> usb usb1-port3: unable to enumerate USB device
>=20
> Wifi is soft blocked by checking rfkill. When unblocked manually,
> after few seconds it would be soft blocked again. So I was suspecting
> something triggered rfkill to soft block wifi.  At the end it was
> fixed by removing hp_wmi module.
>=20
> The root cause is the way hp-wmi driver handles command 1B on
> post-2009 BIOS.  In pre-2009 BIOS, command 1Bh return 0x4 to indicate
> that BIOS no longer controls the power for the wireless devices.
>=20
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216468
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Hans,

Since this is effectively essentially removing the broken BIOS RFKILL inter=
face
for numerous machines I think this should probably go to stable too, if you=
 agree.

>=20
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  drivers/platform/x86/hp-wmi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.=
c
> index 627a6d0eaf83..29cd4e437d97 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -1300,8 +1300,15 @@ static int __init hp_wmi_bios_setup(struct
> platform_device *device)
>  	wwan_rfkill =3D NULL;
>  	rfkill2_count =3D 0;
>=20
> -	if (hp_wmi_rfkill_setup(device))
> -		hp_wmi_rfkill2_setup(device);
> +	/*
> +	 * In pre-2009 BIOS, command 1Bh return 0x4 to indicate that
> +	 * BIOS no longer controls the power for the wireless
> +	 * devices. All features supported by this command will no
> +	 * longer be supported.
> +	 */
> +	if (!hp_wmi_bios_2009_later())
> +		if (hp_wmi_rfkill_setup(device))
> +			hp_wmi_rfkill2_setup(device);
>=20
>  	err =3D hp_wmi_hwmon_init();
>=20
> --
> 2.34.1
