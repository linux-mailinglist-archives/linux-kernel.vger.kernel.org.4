Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163C764ED92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiLPPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiLPPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:09:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3115B65B6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:09:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBJ+SRYG8RacWw5itkgT7dszdeUQzz560hIluyHT6Kk3bxrDJAFqOFMA7WnGvaZQtggHUTGJqWaILuABHGIoQ8xKYvJqIznq5DrDeENpfzB7/1PW8fw6kUg2hFoNNZ0l0SynjXERTEE0z+ZSsi8EJbZX5k15EvSzkuy4n77W1uRjG/7y6nsafq1ROgQdF8WUilXnnqkdTqYnAbxkYahIRJXQqnn+vVnGV9vW0smDnM5xnb1WB24w8RSad9OScD/bxx5FxLwv/nfLI+98f1Qs35MgI2eyADiH/Wobux3cyIpJjAG5W5bHd1b/xe2Q+xVteRC0et6l0/3l3cqCVA4n8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CfbGHNqiR2yXbLK7V3iAvtfN4StOFEbHf6LdZVyD/E=;
 b=fGzk44Np8mr97RZc5NG1t1CWLssN2KuVsW9Y8lELlnqJyBz23ehPhAtNammbUsd4k5sz2Jdbc4l78cprgSDhUV5C8+G3jPf/dWs37d5e5CYUJiVGq8G6PN70dwPAJki2fBgYZ3filBHBS5d92ajnG5eMluZNvg4Um61QOY7QyPIdkV/aDHqEPwexgYUN8p6cZqxUrwAI7QtT0mn4gJKAoKymMQsj6SJLz5IUqgQMhgFpno0RjFTDGvRc/G74nHzK+a8YId8ngR1CQJfvwm4btqsx4b03ZJS1iKGouleQKPC6kvKE/DBd6cQ3TG1b7bywLp/dbunMfmjqXzPOkvJL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CfbGHNqiR2yXbLK7V3iAvtfN4StOFEbHf6LdZVyD/E=;
 b=eh/7vbCyyOH3uqYL0dzkAjFOV0ptFkJyX1sRJU2h6Qwo0qUIwR3o7Z1mBAzq+FmoCuviHCjomp9OhXxrfD2CDjszZbb52fev9ur7n+f5AfmeGj6Sp6yYaFH1t7jhmLRnF4fpjhmdjavWytsHXwtzz4DyuR65z+KstaNIOfyIcy4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 15:09:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 15:09:08 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Wim Van Boven <wimvanboven@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        Leohearts <leohearts@leohearts.com>,
        Brent Mendelsohn <mendiebm@gmail.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        linkt <xazrael@hotmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: amd: yc: Add Razer Blade 14 2022 into DMI table
Thread-Topic: [PATCH] ASoC: amd: yc: Add Razer Blade 14 2022 into DMI table
Thread-Index: AQHZEScEEVPxC+tuU0iVk7OQYtNJra5wndUQ
Date:   Fri, 16 Dec 2022 15:09:08 +0000
Message-ID: <MN0PR12MB6101AB123DF2718E7A452C71E2E69@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221216081828.12382-1-wimvanboven@gmail.com>
In-Reply-To: <20221216081828.12382-1-wimvanboven@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-12-16T15:07:12Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7795d5dd-9493-42d6-b84a-bcdf211e2a6b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-12-16T15:09:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c0d40f49-94d8-464d-b0f8-e3adfa22cd78
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB6691:EE_
x-ms-office365-filtering-correlation-id: 0bbdca55-d8d4-4062-6d7d-08dadf777b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xo9MR5g0oTCm0MUvzQ72at6+++TkuTdevLqtZH1bWaCEFl3eb1dPHYx5YkX3ASGbQTdIJGkwlwjyqlqUhS9HPkN/7oc2JdaLqZyJl5uNMjQjlDo4s/BwvFWZzXlyvRImfHc+AjJvg3wKKfUDB7JMuOov52wWCKIyOUugMrA+fPPGdvSGfV9je8hwE/8gwzd1jHXdXRh6BROppGyn+mzO8gRV6JT5QIyK1b/rayQxPYttJoog33rrX6yhJwB6lV4galHA2fLWebHE9aKmjZkaqJ2xI7MrCgxTUMcAX5RieQMzvM2OmO/WDaVFeD1mxbU5tpa3bzK7ntAp+O2dkxsaJi3zKoK4d8CRDBUfeCw4eojaif9fLNpv4xEVqbcInH6p2rf7DGjtr04X17gZPvlfvfxw0naB5gP2fh7YP9Xs6wzfsdO/aRt2XEtHI1qkI2bmiM+uq5XrHBy1+4/H5n2OEooPWirYX2j85vbYUZTMh2neZQ0mk0g6zFpmUSR+ucvRJNRBr3jsneYmwS4edwcJ7TB4qVtB/S13wGt2wTedWxiX4KlFIJ5ZV6HHAQPhPxl4NAIM4+5x6lYFTZ9RKg3t59ctbPntnrHeOSmwE9GrHf2MkdL8lziujlJtkLe1iGv1Hxg6lJHXy564qO7cXr6p2ipriQtHi+u5tt1xdO/iOgRuKU8BYe7wgzV62Zc7S0wVKFVln5T514bjOCNrxGPLp5L+ZEM4/BVWY70t2fSNQFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(41300700001)(52536014)(64756008)(76116006)(66476007)(5660300002)(86362001)(66946007)(66556008)(66446008)(38070700005)(7416002)(8676002)(4326008)(316002)(2906002)(54906003)(6916009)(186003)(122000001)(38100700002)(6506007)(9686003)(26005)(7696005)(71200400001)(55016003)(83380400001)(8936002)(33656002)(966005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E+xe8PeSzOKwWxKkqRq4MFru27921li3KmrltYHVQSSrO0T3eYoHcIYmQruc?=
 =?us-ascii?Q?nfFACmJuoax1uLjhFyBTPG6eLl2VDiejZC9sS7OayWebanRhmTqEuY2c7oaZ?=
 =?us-ascii?Q?r/jYejW9qgjhN/Lmfws0/rsRrkh37ZUeVkcjFFgWprRiarBcyFnpcwuGF6ji?=
 =?us-ascii?Q?OFbUri6ueGVNYeaq45VAeVM21Q2wkZ7bPAwt0AUwGyp4eybiFAWJjc2mWWjE?=
 =?us-ascii?Q?vrFL6hOKm09jVn6vEyE9y4qZx/S4sh48dVmlEYdMD8GYlf5E6Gy/dRNyFe6K?=
 =?us-ascii?Q?rh8mE0YomUcO9YE4KcIj45WSlsuX2EdZQbjf+mYD6Srto7rqyRr+W2EvrObv?=
 =?us-ascii?Q?IqHcKrXX6kVYB4+v8TwCrnoDV8NKcqCBsz8w8Nx2hK05sdU0znHvda8PkAuf?=
 =?us-ascii?Q?pkhZDmMb+DFKiiYogsJO3076XRHr2gr2+CiZHnCRC+/2ouy5rNZlkxWnz//g?=
 =?us-ascii?Q?6K3bAelGbybp+W2YyqzCqKYH7r1yuJAEjGK/vIH23hmDLKFspjvFXueer3/C?=
 =?us-ascii?Q?qErBy8iPJcun6uaTtkRbcSsatxumnZ4Mqnkrg7jjPMj9bpwyKsnHL/aoZRht?=
 =?us-ascii?Q?34OWVJ0JXg0tXQG9uWOl0Sj4BkJ2KJ4oBzZ+sI3h5H/tSCpnJQKD/Yz9qqog?=
 =?us-ascii?Q?DuCrgQgUDQ1iuxtcooJegcIOamskhkVJ3ZUufvO5MsJJp+lyeBCGb9rsz8Tw?=
 =?us-ascii?Q?q8rTAQtCR0qAHpQCNq+KpyKFl9lHhh4IOzxaARVxs7ZmbS+caimfgoFFIQW9?=
 =?us-ascii?Q?zfKYRDlIuDSFkPm330xx78OTMAdsvX0+/iR0FziJh4wj9KgFglcEB5rFuDGN?=
 =?us-ascii?Q?eQM/RYvRMOj0HbQeSJ2EwM5IKA+jV78dxN6sohI5bRBqwkuIImva1b4nnEFD?=
 =?us-ascii?Q?jOEkJ871btNhOpGeWHFurTL5ZzXdawsY74/b/cQwNKNJF2lVaTDQJk0pnKlU?=
 =?us-ascii?Q?3hAE6pQQzhxrH+KLGiQFBTlcnpja+h72iVgZAwMSOJe+jMoFPt2r2PASrUxm?=
 =?us-ascii?Q?RlXss7xq+3CoAEHNi/NCyGzjkfn+Repctkp0ZPGnBQ9Hu2sou4bPWZEKvv6t?=
 =?us-ascii?Q?qdkrJ1Ow6YlXXw37dt1oVsGZ79sUXhmCqEe7B4Kk2GJmamjSIuICAkGE7Hh/?=
 =?us-ascii?Q?Qm6o+B6UivnJcUr6i5L3b9BE6FNtQ8FtjjW1ouZsKXd3KOXgew+FgjKnpvGA?=
 =?us-ascii?Q?XhQZeJO5QYu+SBQHHkaXQ9zq0hK8qrPsVoVGZn8LmiyZXoCgv2qZDjX3XLqZ?=
 =?us-ascii?Q?4gdoMSe4dRKFuoFxkXbleNf1gmCVCCWxAlRr0HkwJIsBKfWgOgFKlbnnondK?=
 =?us-ascii?Q?PRGOBCjDZLmDscX07e98aqBMxT6yZAtMR5iAGXz1EuxGZv7bBQbTgrcPrG+T?=
 =?us-ascii?Q?iixpFbPjGKrYRbmghoJQq07ZJel/WY2Lf4xj1IkNTL7BEtmOhEO10DuGZ0GC?=
 =?us-ascii?Q?S5S5XkPYUJqJX9eQx7TFeqBeZMpM3uBy/wPnlMDV9NiUlNBrNPQoX8vsAO2e?=
 =?us-ascii?Q?961jFiG3WeTZEfNvEpl78l8amEGaNhJob4J1yPZUlyt0YXw51inAb2FSGxUl?=
 =?us-ascii?Q?xBFFauWaOM1D9sNm+RM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbdca55-d8d4-4062-6d7d-08dadf777b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 15:09:08.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mS41kwusHgHgPXUjQAL6Ygol92oEhJkPEPZN46hD65+qgvYT2PTWPss2qYQWyzY0WS5YcVENy+J8aygKUj9TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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
> From: Wim Van Boven <wimvanboven@gmail.com>
> Sent: Friday, December 16, 2022 02:18
> Cc: wimvanboven@gmail.com; Liam Girdwood <lgirdwood@gmail.com>;
> Mark Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>;
> Takashi Iwai <tiwai@suse.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Saba Kareem, Syed
> <Syed.SabaKareem@amd.com>; Leohearts <leohearts@leohearts.com>;
> Brent Mendelsohn <mendiebm@gmail.com>; Xiaoyan Li
> <lxy.lixiaoyan@gmail.com>; linkt <xazrael@hotmail.com>; alsa-devel@alsa-
> project.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] ASoC: amd: yc: Add Razer Blade 14 2022 into DMI table
>=20
> Razer Blade 14 (2022) - RZ09-0427 needs the quirk to enable the built in
> microphone
>=20
> Signed-off-by: Wim Van Boven <wimvanboven@gmail.com>

Thanks!

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216801
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-
> mach.c
> index 1f0b5527c594..469c5e79e0ea 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -220,6 +220,13 @@ static const struct dmi_system_id
> yc_acp_quirk_table[] =3D {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi Book
> Pro 14 2022"),
>  		}
>  	},
> +	{
> +		.driver_data =3D &acp6x_card,
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Razer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Blade 14
> (2022) - RZ09-0427"),
> +		}
> +	},
>  	{}
>  };
>=20
> --
> 2.38.1
