Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC465B5CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiILPLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiILPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:11:22 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E69B2E68A;
        Mon, 12 Sep 2022 08:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeTarOorA82dxbOea1dPeKoRk4qWnfXwB4owP0ZJPcEbABWwscG8YfVuuUtt2LHywKC9c4DrINQ6Hmwepx762oIUqb08I5VxKYRsbVHcGQNxZ/cRrdVjKf+Z0U5IcuHXNRWiEnQppkwOJ+Q2oU/vW89jUssQDmL2/8iMW7T+6EcxVZGcXBipn2O4xCu6TrMqPgvV0uiH782bx7Ok08NvLAnSJyldZUo7Knthwrw3xi1uU3IzvJlOjOhr1A92kP8CURCmBHZojge5kacq4eWG52NI0aka6D1cm8phAvCRC3n3NGGuZzBwKR5GpWc9NrgHoRFeIroduXMgO3aOCAqdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9Oxpvl4ACegwiFCTle5XskbpFcoaOYPtv5TuwmtfQ4=;
 b=Ks3CQ8hbY+H8crk6iH/v8n4KZmY0eKDuPuXr6rwYFm8r60ZhATRMMwBB6iQiGOJpbLSmzWA+FTp7lx9aPSWfmBea9ys6YlPc3S6l/wChA6YAjLxnMdmLjqVquMt2H/dEOwd1/1eiCR7OJ9RNvcGNEZioqRc6CfelBNoY4MeAI608WZ6ld2ki1ZsZaimP7S2/avmmNQwMrkPQFSzWPybVhFGZqA7kWm95IQ+azJJjukErwevGFvqO1+QsWVPRTtFSZQIcAzcn/I26Nl5EgR31890NDsC3e7PToLKlccisfiXqFjVPYJSCVs5PqS0lv5m8tJYSYlNsXmuReVoayuvyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Oxpvl4ACegwiFCTle5XskbpFcoaOYPtv5TuwmtfQ4=;
 b=tlmoUyIR9lC9KESoRskFgT6lUsDCzTIOfzmk/HSyQRbJRx2n3W/aIsxfsxE+xLgeix0kaHmqC+fhxsY43xw2Yb/YsDb+Y9icc9J4ko9LJTcO31I7X18H9qkrmDHU/THqSIx+OaG65VdCxOxXIkIkAAB492eI8L7VQJ8eQul5lYU=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 15:11:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c%7]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:11:19 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Philipp Zabel <philipp.zabel@gmail.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "catalin@antebit.com" <catalin@antebit.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Thread-Topic: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Thread-Index: AQHYxHa9Vv+M6MQ4hU+iFAXLUHOdra3b5t0AgAAAInCAAAKJgIAAATPw
Date:   Mon, 12 Sep 2022 15:11:19 +0000
Message-ID: <MN0PR12MB6101D955454630458F0D0F25E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220909180509.638-1-mario.limonciello@amd.com>
 <Yx9ItlBjl6bxxu2H@rog>
 <MN0PR12MB610147F4362BB95B7B5397B4E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Yx9K88pXilS6qqL9@rog>
In-Reply-To: <Yx9K88pXilS6qqL9@rog>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-12T15:11:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=390260e8-cf8c-47d4-ab2f-4fa8b804ee72;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-12T15:11:17Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3661c446-7677-4130-81bd-c9b5a7d37c25
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM6PR12MB4944:EE_
x-ms-office365-filtering-correlation-id: ff360fe3-d116-46a0-4f27-08da94d10ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MgCmg1w3R3umQW/wCYChecYY+PSyf8Q2HIjMwhtGgPlBkLI7hODLf48h/t7EaCGag5SI0+X8uUYv5a4tWd4nMZsyIs86VwRXKx7pL9PJoKKo3dcBEvuOF0wD/5/uIh8sHcc/Cjn3Oq9aN78Ydi6fOQtJjO/1+q0PoQvsPd479e0H6l+6FmwJheQm+GWs/O8VjqnkTTYz509xebTN6I/IYGD3CL3HAncJpjwz6Kp6j/XMJjoq5VfjvFhDqXaSpGppN6bF0PTKPEknLsu59P4hyoXWwKZtX42vU4sm8nSNBVJLj9LJceHx+m5BBu1UfhQipnjHCI9QVL2n+Vrsbhv2Bd4Hz2q+3xGn+UZdkKAxFsSDnFG/cjgpJSreg5EGGFRvWmNIagQbGMbVrN309SZI6FYqMxdsnZWFogw0V3nQpyGfKOzkTG9fIxMwi/X38OHgmIExp8lJeiRC7uoB/W+zU2bXP4YDd0nxrF44MV+bF4nyA8fnJFuLdFb/PjtTDI2AOpWMD0p2oHmPw2uM7BZ8CiRJllTCwxyQUcuoecpHE3fcGzKj3Mk2dRQzB1ffbUHkvF6+ocR0/Z1RE5p9LnjPT5rSWYQPjt49BD/WHFmX1mntJI/cDGEFyhn13p+zJDtqQHkV3uIZViPil0xtgbfdHljxvFuYEFkfA5v8R3WZGIhgoFyiKuD5xz7zU5/Ya8WHsjlEn5z3ZAjNU/RAdayFTYLjjOeeHkQKIjL/H+pc119s1TkP82wVwoG2W8BNzUG2QfTbAjwJb4FjpjjuX6xpyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(71200400001)(38070700005)(478600001)(41300700001)(55016003)(86362001)(316002)(6916009)(54906003)(45080400002)(26005)(186003)(9686003)(53546011)(6506007)(122000001)(83380400001)(38100700002)(64756008)(66556008)(66446008)(4326008)(7696005)(52536014)(8676002)(66476007)(8936002)(66946007)(76116006)(2906002)(33656002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cx3pKhoa62LiZltZggSDk906Bl4pBWUdwz5ABMYOTBHpS+oNYbI7RJuCjrWX?=
 =?us-ascii?Q?TglMcYXydAn/52kvaSnfFza6TWdRX1J5Jcx6PPI+d34LReMQCW/JkDf5uRC4?=
 =?us-ascii?Q?FtXXmq58QaGMnXIrXOnW52c9ntUvvsBOgushMVsZzj7T7w9tAwrKjVHGnBHj?=
 =?us-ascii?Q?/dgq19pxQ4uksvhQarRvqwBKZWv59LpF7yNixXR9eBSZ0UcM8+8VqUcFSOoi?=
 =?us-ascii?Q?tBXilTPE1Gl/wvX8K6juO3BadkZJJfGJSfltoE0Vzcou10jwSwd9LzK/+SmB?=
 =?us-ascii?Q?b0kvHk9ySalhMl+axwsMelAM7lk0V+ecTiaXeXHLZ4uFkne/wF1XflgZCMFT?=
 =?us-ascii?Q?TKqplo3uT8QCC9qAj96809eunIVk3bJ5Sed/8H5JM5ccEmQAoc5ap4zCeS+F?=
 =?us-ascii?Q?B6pkKaGdVFc0A3NeNdV8n3/5rRUyWO03MhZQqv+Sf44bNPyEM57r4BWqYBCu?=
 =?us-ascii?Q?Ve6DtDfDaFcgzMRsb1UH/4XAAooFAOfH8L7ENs23WKt2jAvmul3fn4RbHOXz?=
 =?us-ascii?Q?Ewev7DhPj1g6/zHsD5pWyXhyqAKrMqBWYgL9KddEmrXAHQzo0PL3awzwTTLL?=
 =?us-ascii?Q?91oSo7nPDLSr5cK5MJk0kJQK/C4AVxvHVcPLGIc5jJeAtoJ+1rDPekrSIGp4?=
 =?us-ascii?Q?GUEXSCa/y2ga6/nhUI8w1BM+oe/WVc8jfl4tkFqTYytMJsQaDL5GhW9luiwj?=
 =?us-ascii?Q?R1u+qQQ7UKmFyBEDFaz8/tMamVSyv+vpGu1AsS+rohBZGOH4UR+OI99PZYRB?=
 =?us-ascii?Q?hoCP37HsKNdwzu8gEbKYpMITKy5VXu9LB/GWHkmjIjqcglDCwnztICbwqB5B?=
 =?us-ascii?Q?lSIA4UZWJxPJ5ubeMvwnlnz+LWp70xqQ/Jt2axZvTPO+ifPJs7RMhZS+TuUC?=
 =?us-ascii?Q?MM3QUFm0AQ5AnbplAXYTBBUlCQe8LNEt4Ds9Vfc4dQ+Me73GQHskxUNCYQEu?=
 =?us-ascii?Q?Yb3A5BmlVsxzHiMGFJjJDt6dE9vmBskwG2WcNUd+YmNmXKflmkMt6Eep5ueg?=
 =?us-ascii?Q?QrW/dBrOIJn6mckJtir5hWcpuxmHuVOMjDsCU0oZq1d4v+lnusrcR5ntO4dc?=
 =?us-ascii?Q?HuyUB8BriBqsKZZv5B/Kn2C8A9g0pTjlzbb8aarEVutGw+l635BMml/VnlXd?=
 =?us-ascii?Q?YyprkE8ii9kFuP8q27BBwkzOLbAVSFChCUZzpWmBiXbMGFKFOyrI0oS8WPes?=
 =?us-ascii?Q?sBk3IZye6ELi1Kz40VToh+xf0Ktl/kUAOitBMqHOgXq/OcokTkJyuw92muPa?=
 =?us-ascii?Q?YjGqPBhNIMAT50s7v0El+omLVoTnlMznwkP84CoNaXvpdY1fLJT58L0uAR6/?=
 =?us-ascii?Q?64pCBU4AkPqdroRnGoCkx1k/hzuYhL+3PHsA5pp7ef4mT7S05Hi/ZQQNw8kt?=
 =?us-ascii?Q?tDiDax49F+CRK0TOfvYRh4rTqjsnrZ1Ypgplwii4rPDkgaX/oGp+Gqw43+cX?=
 =?us-ascii?Q?dODi2Rwgt+892kHL4ue5PwbnvXvpU6sAKPJeJnLgdAgn7EYO4OIFjjk3M7TR?=
 =?us-ascii?Q?nO23mKsiI7tlxQbdow6e0lRl+m9FiEZSISFF4hwK0hxAG7+/CycfbiuNtLwr?=
 =?us-ascii?Q?gHfPU8XCuFZthgQesPc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff360fe3-d116-46a0-4f27-08da94d10ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 15:11:19.0583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a22IPWFAwCuMjguqV33BtQzDe82hrLVT983nIzqKnJL/KrbLCC/V+Ys29EJVa5fnudg4jH11UBqKp093eCv1Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Philipp Zabel <philipp.zabel@gmail.com>
> Sent: Monday, September 12, 2022 10:06
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: rafael@kernel.org; catalin@antebit.com; S-k, Shyam-sundar <Shyam-
> sundar.S-k@amd.com>; Len Brown <lenb@kernel.org>; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
>=20
> Am Mon, Sep 12, 2022 at 02:58:51PM +0000 schrieb Limonciello, Mario:
> > [AMD Official Use Only - General]
> >
> >
> >
> > > -----Original Message-----
> > > From: Philipp Zabel <philipp.zabel@gmail.com>
> > > Sent: Monday, September 12, 2022 09:57
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: rafael@kernel.org; catalin@antebit.com; S-k, Shyam-sundar <Shyam-
> > > sundar.S-k@amd.com>; Len Brown <lenb@kernel.org>; linux-
> > > acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
> > >
> > > Hi Mario,
> > >
> > > Am Fri, Sep 09, 2022 at 01:05:05PM -0500 schrieb Mario Limonciello:
> > > > It was reported that an ASUS Rembrandt laptop has problems with
> > > seemingly
> > > > unrelated ACPI events after resuming from s2idle. Debugging the iss=
ue
> > > > proved it's because ASUS has ASL that is only called when using the
> > > > Microsoft GUID, not the AMD GUID.
> > > >
> > > > This is a bug from ASUS firmware but this series reworks the s2idle
> > > > handling for AMD to allow accounting for this in a quirk.
> > > >
> > > > Additionally as this is a problem that may pop up again on other mo=
dels
> > > > add a module parameter that can be used to try the Microsoft GUID o=
n
> a
> > > > given system.
> > >
> > > thank you, these also helped on an ASUS ROG Zephyrus G14 (2022) with
> > > BIOS version GA402RJ.313. Patches 1-3
> > >
> > > Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
> >
> > Did you use acpi.prefer_microsoft_guid=3D1 for your system then too?
> >
> > If so, I should re-spin this series to add your system's quirk to patch=
 4.
>=20
> Yes. I also tested with the following diff applied instead of the module
> parameter:
>=20
> ----------8<----------
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 6a2c94fdbeae..a247560e31de 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -420,6 +420,14 @@ static const struct dmi_system_id s2idle_dmi_table[]
> __initconst =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF
> Gaming A17"),
>  		},
>  	},
> +	{
> +		/* ASUS ROG Zephyrus G14 (2022) */
> +		.callback =3D lps0_prefer_microsoft,
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK
> COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ROG
> Zephyrus G14 GA402"),
> +		},
> +	},
>  	{}
>  };
>=20
> ---------->8----------
>=20
> The full DMI Product Name is "ROG Zephyrus G14 GA402RJ_GA402RJ", but
> there is also a near-identical higher spec model GA402RK.
>=20

Thanks so much!  I'll roll it into a v2 after I fix your other comment.
