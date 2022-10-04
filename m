Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A085F4A98
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJDVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJDVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:02:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417F6A497;
        Tue,  4 Oct 2022 14:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybr8KhAp4+MjjdgWKoOvmML3I/OKhgeRLlNgMlKFnekbPWnx8vr/ffEOwfs4CbgcVKHT+OJF/pt9GADZZzhpqJe31Gu8E9Rxpqe1mawMHfm2qxzcoImq6kFCW6tpHIOkoarn80hOgjWuyvLoCMnLvCT/lXx0a7JRGS3lXMHFmdnicP7au/RfMYGtkxc4F08G1gpGY41QUenV569ER+hXY3yw77N5Mxjf80gsererzeKPx1or9MiHPyI63UlIWM73RFjJ2yQWkFG8RLGmb2JFS6RSRdtSJiXtA/ipON39G/li/g0hR9BtbA46yoVCRlvoNZPD/65hEEtzyDOlblJUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut6j0C/coKZJak6pMQgAx4in6SVLBBLNKQuAdK9cuu4=;
 b=ajKrzso5XnFGtgyW9lSr8YRLi0k+sNY2vy0ZR4cqymxbLbU9f8IVZ1gDn9vCACv2OW1LUDRA6cEvUlBJSGpDIxnzeyMiXHCs5C9/eMuuU3zhQRmF19kTg6tOskU/dh4fFE0lYiKCiliiAVRuV24yYuFxEPRPc+HFLsiNb9cVOTR9x3pftW4faVEWVZgOey20daBhXmNtJ7pmE1toRWL49fFc6vA2Gca/QZLUQCBogcHcrkxj/YRQM5yWa2hPQap5weBLRp4v7xLsWXmtzaSzT1ynRO40hKBYhhENtoz6jBKSrWlGhrucNMlqje2S57UD0juOKvuhPfYaILk7MsWf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut6j0C/coKZJak6pMQgAx4in6SVLBBLNKQuAdK9cuu4=;
 b=aBFNtc9Zz58oK/imxCKVuW/y5kDbwctY9VLF169nTFucf+H8yzuQxC1puLGqQz3SwY/zaN+YNjxML82PzEO7wGPbIWzBNDvkhtRxuDQGzCPt4WEtXPqXBhGN9cVsPJq0HN0M/e9hW3fn0YVVIAKnztubLfDwPja64N2IfDS/YqQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 21:02:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Tue, 4 Oct 2022
 21:02:11 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Fridrich Strba <fstrba@suse.com>
Subject: RE: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO IdeaPad
Thread-Topic: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO IdeaPad
Thread-Index: AQHY19zK9aCnRiLTCEuUjrBkMq19Y63+uELg
Date:   Tue, 4 Oct 2022 21:02:11 +0000
Message-ID: <MN0PR12MB610136EC41E0D00F0BA7280FE25A9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221004103341.12646-1-jirislaby@kernel.org>
In-Reply-To: <20221004103341.12646-1-jirislaby@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-04T20:58:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ca86e46e-f16c-4782-a0aa-af451ef818fd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-04T21:02:10Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 57c69500-d485-4690-97d2-5157b9a7acc9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY5PR12MB6298:EE_
x-ms-office365-filtering-correlation-id: f6962fef-0eee-459e-3b62-08daa64bb51d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NF/X0EwzXeVTvOdbbvchCV/+Qbjm3L448dGraMlvGzY9YXtdOgA7lSGr32p5P/mpZa6mERfVVdC94HBNLAzRPYSTkpCGI1ZjSntH3KxTWS2LFAJkRxhMfoIw2/Eu1DeotJLUjS29KQGNFQuuS8l8DtGCDYWW5RBCrzR5/sT3lW++wrWwUCx/AsuTsrGsPn65dpSQcY3eEfWDE97R6lOAPXJEIxruOxfWzvPzLB6wJ5AapXWqKc3gyJbQ3As1zQVLEdCiFnty+k08om5UNILkYanC3mWryI+jWOqhxbCM2Rla893VnVzk1WnC2Dm+08TNw59MjYx/dgbWxrKsZqTJdubombu7B6PlrJDAYNR9opInTxdb3nkKeMD/3t3A+m1gEcODC6LZJGY75D7bh2/y6M0ImYBKdvhAebHtJgLYU3fWy+tkafiIEJ8BO5A/NvJRuY3dJZdfv/PPLbtAnHvU8WZ4kKmQnZhmKRbJoibSSh6607dLCvNNnUDHWgq0tc0ZzD5yTynOx+LXSBaYH704hUtI2gh+fLl0JusN4FnBFF12jfa6KuGTrG7ykc+jRt9qVks8J4Lduk6XRVLMHFZDlST9OgMFnEf/bDfUSLc6bgqJ8p6MLO0Odq/T7rcaSsjRcxsbv3z9kIWtQ0osttCZG1kanwZFYUivzznQPLKPCs5qUuPRPIMeaSK5w4NvLX/WC7HmG+npsySk3EfbUi6PDd4QXLd+7y74H4avxUe9L38wTLQiW3sIGEZLOS37zld4PL/+cq9HSWF61G8wpeTN0gR469pu+9iKYE4JPxYjWhOGR03kB0XsMVv3AN2uJHm8HL9z2uLZGHT1GWisRhgy0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(2906002)(122000001)(64756008)(38100700002)(66446008)(66556008)(66476007)(76116006)(45080400002)(316002)(54906003)(4326008)(8676002)(33656002)(110136005)(41300700001)(186003)(66946007)(83380400001)(8936002)(52536014)(71200400001)(86362001)(6506007)(9686003)(5660300002)(26005)(966005)(53546011)(7696005)(38070700005)(55016003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bQr7dj43AxuUud8wLEr8G2EhUdKdyRYgQIf86injsnqCQvVdVEtPj9CHZ0g1?=
 =?us-ascii?Q?IpMYQf4Sg3Sm1IpTuRaDZnFsIp2hHGgEXcoAQTq7rrn93XnjZy1Ge2s949oZ?=
 =?us-ascii?Q?+8u/Y9aoE9nJ6u/Vym9XQW9mqyES1SRxnUMkSjmV9G8otwDBkV2H8DsGQsEs?=
 =?us-ascii?Q?EluT+e14p28G+p3n27u5TKzgOTnwSflURVQSKm7G6sqw6SPYovPNJbb49yt5?=
 =?us-ascii?Q?8l7+WTciflWdMkS8/FuaWF8zMF86xNHT7OcgajBifvEDTcVwK1iMiBF+di6a?=
 =?us-ascii?Q?14q/6pMWG7lJ35LlytIw+Rau+mma3fsPTHXcsTdYOhyWYzxCKFk2NY/H6nHq?=
 =?us-ascii?Q?WKKfS5y8xju7GNnDvmOC1fgt089Nz5DG0EPBEU6OXP1PcmwtMaDbd6LdXiXY?=
 =?us-ascii?Q?+D7v/9e4YaPmFu3hLw6cJygn8LmNjjBafOiogxt4KKlgaQ0ajODBv7hjrFhx?=
 =?us-ascii?Q?+yXpTcC+hyi35UczVZWbweYXdhfnDMi8tyn1MAg09FpVNLnR/Akc6DK0o78F?=
 =?us-ascii?Q?aP1tSGZsKq4uoZ0JZA4zCEt9Jk+PecctA722bpN7GRai9jdPEd/rRjujZKHt?=
 =?us-ascii?Q?wvUh6gz4DQKlUuq/FjSbnZyPh/dUebbB7jsl2O5yYcs8ImuSP+JfMpfonFuk?=
 =?us-ascii?Q?npGejTeTRHhwasKmSpQhqxmsfO773ZwAbmC+RfakN690WJOiq86BZfSD5EKJ?=
 =?us-ascii?Q?ZEVCjwJ5vXtOU91/RU76srX8B2tFss+z2VvyveB9dN+thDImk44bp2OAfbgA?=
 =?us-ascii?Q?lXwt/q6CH8XErjeHftjolhiWiwvxLjjZA7NDndjNxsnHmiwpWkWKmGmqcQDV?=
 =?us-ascii?Q?Y6oBDPZOyTYsQ9RwNJJ3kGu/YwTiIfj48tXTgZbxZ65FonPYoDAxvzF7eAwo?=
 =?us-ascii?Q?qGV8q9YsYcWTfaB/cK7ceRHk8dfn8VDMNiOfik5bGnRvy7Pooorye6R1xRG4?=
 =?us-ascii?Q?y22MTVhUsH5pGY7WaBQYQTmAiQV3FLgZ770gn76pKdD2+uCkf5za9teQU2yV?=
 =?us-ascii?Q?XXgkx2jiGejY5BJRTlL+lO2/c6R89ubah5ydp8Z8a825sHGiIWDmd/BE9dRx?=
 =?us-ascii?Q?ZxNbDc2nytkmPM3IfZzdWMOY+ZrirbBaBR29j5L1jCD1ZR6hUWUjzcraO7ni?=
 =?us-ascii?Q?gowPLGMjrQnrTnnp4CoeWYAxZxlTsDmX8sv2yxradjCZ785gn0tiv3raIIuO?=
 =?us-ascii?Q?iTMHdUkKcLwT41KnfhVNDTMdFjqyvGjBw8xuVOEksdYHrP/BdsjJmrgB9bo2?=
 =?us-ascii?Q?vOK2IpbjBtdSE+dWf/VBsqqQqDmCKFEZEChn89ijMkrxeLr7Yee0s7UMqd7Z?=
 =?us-ascii?Q?4LZABIHTypr1wrJpxL82ZQqk12wCsfVVtt58+HMXav60Vh+xT4sVb/6wdHF3?=
 =?us-ascii?Q?UBtVRKsQLlZIC1SQ21K+l7ArrPxf3QQj/hsYfyg9pwtlJ8GzdNhXwq2mklh6?=
 =?us-ascii?Q?T9e9EcRVvHEFg59b2l7ybR8Vij3KD+ZskDaG4mdKXyUrquAhmB0j99dt3YpH?=
 =?us-ascii?Q?KPMWGHsruLYypFRu6cViJpDM3Kc92ranxpnxRIbby2B1EkDHcGpofbdWbEvz?=
 =?us-ascii?Q?7+UTInLCTqJl+c8uSrs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6962fef-0eee-459e-3b62-08daa64bb51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 21:02:11.7383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4GdIE9E56Vprw0roobwKscAI6f5dV7THLrYXkHEhOJqIXTAxG12mUvjLgbg2m5BwigFZ4ZdUs0xxK3VrAWgCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
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
> From: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Sent: Tuesday, October 4, 2022 05:34
> To: rafael.j.wysocki@intel.com
> Cc: linux-kernel@vger.kernel.org; Jiri Slaby (SUSE) <jirislaby@kernel.org=
>; Rafael
> J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> acpi@vger.kernel.org; Chuanhong Guo <gch981213@gmail.com>; Tighe
> Donnelly <tighe.donnelly@protonmail.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fridrich Strba <fstrba@suse.com>
> Subject: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO IdeaPad
>=20
> LENOVO IdeaPad Flex 5 is ryzen-5 based and the commit below removed IRQ
> overriding for those. This broke touchscreen and trackpad:
>  i2c_designware AMDI0010:00: controller timed out
>  i2c_designware AMDI0010:03: controller timed out
>  i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
>  i2c_designware AMDI0010:03: controller timed out
>  ...
>  i2c_hid_acpi i2c-MSFT0001:00: can't add hid device: -61
>  i2c_hid_acpi: probe of i2c-MSFT0001:00 failed with error -61
>=20
> White-list this specific model in the override_table.
>=20
> For this to work, the ZEN test needs to be put below the table walk.

Unfortunately this is the second case that popped up very recently.
Another one is listed here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D216552

I don't think we have a good solution to cover the intersection of these bu=
gs.  The
existing heuristic to look at legacy syntax and the IOAPIC doesn't work pro=
perly
on all the Lenovo and ASUS Ryzen 6000 systems, but it does on these other t=
wo.

We're going to be adding more to this table either way.  I /suspect/ the be=
tter solution
is to revert 37c81d9f1d1b and add to the table all those that are broken.

If there is an agreement I'll try to gather a list of the ones I knew about=
 and we can
build that table.

To make that list not grow very large, we also need to get the IBVs to move=
 to the modern
extended IRQ descriptor syntax for future systems though.  I can certainly =
have that
conversation with the people who talk to them, but it's not going to be eff=
ective for
a generation or two if they agree.

>=20
> Fixes: 37c81d9f1d1b (ACPI: resource: skip IRQ override on AMD Zen platfor=
ms)
> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugzi=
lla.
> suse.com%2Fshow_bug.cgi%3Fid%3D1203794&amp;data=3D05%7C01%7Cmario.li
> monciello%40amd.com%7Cdcaa6ca41a97434ebb7308daa5f3ebe1%7C3dd8961f
> e4884e608e11a82d994e183d%7C0%7C0%7C638004764302852606%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DS2udkzf131LnGABs9huj
> %2Fw%2BwyHp9PT0bPaUyaH4rIDY%3D&amp;reserved=3D0
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Cc: Tighe Donnelly <tighe.donnelly@protonmail.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Fridrich Strba <fstrba@suse.com>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/acpi/resource.c | 42 +++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 514d89656dde..8d13e94bb921 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -424,17 +424,31 @@ static const struct dmi_system_id asus_laptop[] =3D=
 {
>  	{ }
>  };
>=20
> +static const struct dmi_system_id lenovo_82ra[] =3D {
> +	{
> +		.ident =3D "LENOVO IdeaPad Flex 5 16ALC7",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
> +		},
> +	},
> +	{ }
> +};
> +
>  struct irq_override_cmp {
>  	const struct dmi_system_id *system;
>  	unsigned char irq;
>  	unsigned char triggering;
>  	unsigned char polarity;
>  	unsigned char shareable;
> +	bool override;
>  };
>=20
> -static const struct irq_override_cmp skip_override_table[] =3D {
> -	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
> -	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
> +static const struct irq_override_cmp override_table[] =3D {
> +	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0,
> false },
> +	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +	{ lenovo_82ra, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> +	{ lenovo_82ra, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true
> },
>  };
>=20
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> @@ -442,6 +456,17 @@ static bool acpi_dev_irq_override(u32 gsi, u8
> triggering, u8 polarity,
>  {
>  	int i;
>=20
> +	for (i =3D 0; i < ARRAY_SIZE(override_table); i++) {
> +		const struct irq_override_cmp *entry =3D &override_table[i];
> +
> +		if (dmi_check_system(entry->system) &&
> +		    entry->irq =3D=3D gsi &&
> +		    entry->triggering =3D=3D triggering &&
> +		    entry->polarity =3D=3D polarity &&
> +		    entry->shareable =3D=3D shareable)
> +			return entry->override;
> +	}
> +
>  #ifdef CONFIG_X86
>  	/*
>  	 * IRQ override isn't needed on modern AMD Zen systems and
> @@ -452,17 +477,6 @@ static bool acpi_dev_irq_override(u32 gsi, u8
> triggering, u8 polarity,
>  		return false;
>  #endif
>=20
> -	for (i =3D 0; i < ARRAY_SIZE(skip_override_table); i++) {
> -		const struct irq_override_cmp *entry =3D &skip_override_table[i];
> -
> -		if (dmi_check_system(entry->system) &&
> -		    entry->irq =3D=3D gsi &&
> -		    entry->triggering =3D=3D triggering &&
> -		    entry->polarity =3D=3D polarity &&
> -		    entry->shareable =3D=3D shareable)
> -			return false;
> -	}
> -
>  	return true;
>  }
>=20
> --
> 2.37.3
