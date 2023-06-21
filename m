Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FFB737A17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjFUEXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUEXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:23:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13E1712;
        Tue, 20 Jun 2023 21:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONOaETFpAOlyZh8L6ENonLwH6Dt3/I4+IV5bCxLbOBD9nWacfludKATiZUVx+1UciO4JfXyBjcoVgpXxofuPIeUGr/rVy43PcWWo/VvmyvJq3TNxGJrNhvZU+gWdMucEUhqNPHtGLeJYkpbWyMOeXu4QRmXlcNvgJ+EzEmeEds2kMXInhLXUBJhMnTwT/79KCzaZyf7dc5jvgPjtgDl/RYGWQjkbre/MgpKRlperW/jCkfSpGNfJlo2FmLL3B7apmr1fuFLXsx4bv4/0Vdpx49ufX5+ezEw/OHMUP2J9aGBnA70z1S9N6N3fHJYupbkCP/cfujhwgDhjWvBXd6sBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeRGk0iQyzfDgwupM09sAO+q7ArW/vvNz1cPkJU5hbE=;
 b=holnrVPNf/mV9Lj2M/4Lt75TMBNenTzXAutrx8sEcGuyUk1/uNb0wTcUKx9D1NEsHRwR/9uXYAqliMOriZf0lIeqMAbKGAdKL4LKS8IlxvTcZ+S8RdAsPTug2Hp7xHZ47fmPU9N4/6F9MmocpPvKiLiYtFUtJVeqgy4cZLPnahW1edjcQDyQTDzPKnfeBRsTMV6EwvJs+N+0UsAkvzfPFEgqfYfbZ5I/AK78J7O2SVKzXXZHDBYPZWlCYev4lH0f6EJ3bcET8TU1QLNCZgaMZDiEPW8wURjVLBvOukUroTAPUyPyHJbTM/kRX2FFWM3XrTKKwDjvLPtoDGRRZdCvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeRGk0iQyzfDgwupM09sAO+q7ArW/vvNz1cPkJU5hbE=;
 b=Ebozf2Zv4n1pi/tyT0mALG2ejlmbD3+bfroXm1xWvgyFWSIpeAiDx2QZJtJeCHdRGPJ2C2chbAu2VEIe7dCIQGauPQZd5CRuQwO5YRdZ3XpFQ/GTOcBR2MtpEyIJgpslPGsS0JHZqzx9I88bCr2SCzqUNu2lW2bnXlttWFq2ovw=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 04:23:45 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 04:23:45 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Len Brown <lenb@kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH v3 1/3] ACPI: CPPC: Add definition for undefined FADT
 preferred PM profile value
Thread-Topic: [PATCH v3 1/3] ACPI: CPPC: Add definition for undefined FADT
 preferred PM profile value
Thread-Index: AQHZo5yBPFval+X6jUycxVppZosNdq+Up1WA
Date:   Wed, 21 Jun 2023 04:23:45 +0000
Message-ID: <CYYPR12MB865516C72B97B871E15467E79C5DA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230620172433.21325-1-mario.limonciello@amd.com>
 <20230620172433.21325-2-mario.limonciello@amd.com>
In-Reply-To: <20230620172433.21325-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=01887500-cdf0-4149-85e1-0c5b66714bfe;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-21T04:17:22Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA0PR12MB7530:EE_
x-ms-office365-filtering-correlation-id: 391ab2f3-851b-45a3-84ec-08db720f4d93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XW+qXXov1ja0akMHUlEoKdSkJAXtxZX3YpBqoCja+2i/ASlwk6QGzDW4PTQG/s6M5S6JUVaz8Gv/oxWkdB+yMI41l+/HOf5Z4i/MM7jcAGzZcrdhth7kJSoLnYhmVJHb1N5NF35fxKiH0OV+vf2e6mdJV2CWgjMTA71XN4Wl7hBxzA7jxQ6la6OR/8pKSl3HHq8HqiYvy4l+u6Oc6Nm9laU4Ddan35F6ag16nxkJfUYLp4jRbeXBeblkUIxBYzXpnfo7yltF6xiRL2V3r7zUu1WSSPd6IiYeIjqvSTPhlfnirOBJlny4DNo5z2oLHTmfF0vAyY65MOq23Ltb+ZleF3gJrYK3E1Reqn/QxJbN7FMnOz3jghHkTWG5CKwZoytN59d8WVxMewoVYsaYsA9etr+ZvZce/c3gGxXXH/bcM76CIgrVfjI8cOxWLFZjg3l+99r/PF7YxdG0ZOL5fHMU4vFtK6a1esMjksckUKkYbRIybEuQbjK4eT+pIBjU1F/+wW2QgKnnoJZaGRk5uQsJqROevDpswvVi7IgNg4jPXIHUmWtuieh2kkiQVyrOLwP3k3Nj7+V4VPuQWVslK93nXkHsv2Voftn5ToHg0A+ftA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(71200400001)(7696005)(4326008)(478600001)(110136005)(54906003)(76116006)(26005)(6506007)(53546011)(9686003)(186003)(966005)(55016003)(2906002)(8936002)(8676002)(41300700001)(38070700005)(66946007)(64756008)(66556008)(66476007)(66446008)(316002)(5660300002)(83380400001)(122000001)(86362001)(33656002)(38100700002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CNS0HCizqI6nnNLaAu7C//P521Zz0et3SCZ6N1n/MoexB69VZ2JMV7/8dKhm?=
 =?us-ascii?Q?JiemBZZaxCBsIIl/yx35D5/+2xZTsy04r0EOwSekKHLQuHUqKj46Z31LKknN?=
 =?us-ascii?Q?JL1HfNSxDNEPb+izMI2GVy8Ap0AlcKbwuytOEJmUesyVfGLxzhUL+p3vrNJj?=
 =?us-ascii?Q?KczX10Fi6DLAYgMWvn0U0MiW5QpGiH71UfF+X5hT7poQsZMTY1xs9PHlmco+?=
 =?us-ascii?Q?WV/V/enawHQr64hej0TSD5u63jmik+isuSzKjsQgDrKYx3QnRhMk+JTCaC8Y?=
 =?us-ascii?Q?bOy3NCVW7Cht9tcmAaRD/tc2f39xG3Kf+Svzi1yvg28xEdtzbgzEhxz+gew0?=
 =?us-ascii?Q?fNc/4XGR2UXq2+JU+nEKFl59IUujhVuBpnKu7QUBqBSqgKpUls0sfNqnM0cm?=
 =?us-ascii?Q?wCQx0RPbEB2G8hPYS0Z76LFjq3ai+a3QsgqNGt6iup5va0UrN2YszlXnSwKP?=
 =?us-ascii?Q?zaoBqi6tUwN6D38iisVGJ1r4L2/NW7cnztsjzGYruyRfAL0vlGqfco58bo97?=
 =?us-ascii?Q?ok9V14ZQJvaRpDOyzxMeYKdurtcAI60zW57vspFjb8Gvjw0mxip2+Ehw9BOA?=
 =?us-ascii?Q?C/HkuIb0LSUb1J3wcYKR4Xly7X8wZPR3M4DRIqmpRgLPGngGCic+jqhuQqss?=
 =?us-ascii?Q?kvmV07h9NG1A8JHron71zdivsX7OiFSTooq4+bdkcW1lK9UNpo7POiGDqQBk?=
 =?us-ascii?Q?jvFrnA8eNKN0y1hdD2cROYCK2KbSxqjde/l1Edrqgqo7ZQ1zbHNSUCu+aW3V?=
 =?us-ascii?Q?dBYwHn6kbxcLZ4gB1uhH04SOBezABzejIJI5w0KPwCVjH+ar3oN3XLmFALs5?=
 =?us-ascii?Q?Kc1eAvMx29WxeSM+wPYEZW3xurDbET2ylmLJEx5LvcDz73/rklYEPJ3Ca185?=
 =?us-ascii?Q?8FiCOcpITX7Pee2rKyi3+GPenU+WDlxG4zNCP6u/cblZ7RZwtqs7M/MWXf25?=
 =?us-ascii?Q?pV/9SoVvouYDTvju7ivkv/LglM8n/GzjBTflZnFqz72zgHvhNxnjulqP7A1Z?=
 =?us-ascii?Q?kNnF6IKXWI6cOGaRngG70gm/RY4H2c0A0KxiVG8I0GkCl92HeVC3CrlfpXuu?=
 =?us-ascii?Q?wz9bvhQTkcbnYKT2AuUrRv58VUxXVmXm+gduIZNV/RN/S3dzIl5emXSkzb4E?=
 =?us-ascii?Q?C4HYueQhdVpBc5IIjCeGSHU7G78YtLZHCNnXrfMrS+9dBmVt3+h1q4pB0oOS?=
 =?us-ascii?Q?FSGBA+UV+CtMyGrigPLsDzag2ALKKnsW8EAuSmglncckMPgXUUNwZt1rF9cf?=
 =?us-ascii?Q?IDGtQYMO1wQjtRhO+FHJthcqwL4z2pGq6ywd+u20QfO2Pbxzk2MlMavRpVFh?=
 =?us-ascii?Q?RUvqOfP/d2Vt2NF8jSkCK/PcNJNIGDX5Fl+z82REo0TbXQRoxo4BGWWb/4YW?=
 =?us-ascii?Q?x4F7UFZmbYyMq2x2k6HDUn5+pqt6YuUx879CfQlcCD1kmvSr8q1EwWPFQAcg?=
 =?us-ascii?Q?5MjhoaIT2JR57taqYkmgPH72ccJcx64aFTT5D/lIjCdogW4/H9PYJ7lRgjqL?=
 =?us-ascii?Q?/DQgKY31p4IsD/1sVUi00wjh0Ci2HMHZSgDZe+kFdI1lectfRjHw8NP6wHYk?=
 =?us-ascii?Q?8NwAALqMTbaAbt1vMgk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391ab2f3-851b-45a3-84ec-08db720f4d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 04:23:45.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGxfq7V3FFsgfYsGE9XtvsenDcbn+aGfK/PG9pM18dP1TFTCZ7M7hU8xfCrR86rIr3dlTFzQhOXBFSrRtDJuDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, June 21, 2023 1:25 AM
> To: Rafael J . Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>; Huang, Ray <Ray.Huang@amd.com>;
> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pm@vger.kernel.org; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> Yuan, Perry <Perry.Yuan@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v3 1/3] ACPI: CPPC: Add definition for undefined FADT
> preferred PM profile value
>
> In the event a new preferred PM profile value is introduced it's best for=
 code
> to be able to defensively guard against it so that the wrong settings don=
't get
> applied on a new system that uses this profile but ancient kernels.
>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
> Link:
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Progr
> amming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-
> description-table-fadt
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Drop new symbols (they fold into patch 2)
>  * Update commit message
>  * Add Ray's tag
> ---
>  include/acpi/actbl.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h index
> e5dfb6f4de52..451f6276da49 100644
> --- a/include/acpi/actbl.h
> +++ b/include/acpi/actbl.h
> @@ -307,7 +307,8 @@ enum acpi_preferred_pm_profiles {
>       PM_SOHO_SERVER =3D 5,
>       PM_APPLIANCE_PC =3D 6,
>       PM_PERFORMANCE_SERVER =3D 7,
> -     PM_TABLET =3D 8
> +     PM_TABLET =3D 8,
> +     NR_PM_PROFILES =3D 9
>  };
>
>  /* Values for sleep_status and sleep_control registers (V5+ FADT) */
> --
> 2.34.1

LGTM,
Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
