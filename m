Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659355FB8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJKRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJKRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:08:58 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D95A98CE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nijJhsEfUKHVys3xshZcSzNdQFkKcGm5/kqv/5zsWIVF+pw+sMq+SjL13B23thxoa4jI5xw0ZdZ5L1lT8fi3wF9Prj+SZGh/vM/rmjKu9iOhvVVCj26KwDJWPEUc9Shh2Cd27XGoeY6r98kc1HLtDy0MSJQRGSh2iuVITpHF32XSaISGFvaH3WmxiNHGmS7BYbKxfPa5n3fen/TV3tCt/v0N9DY0yRiDiHyjrx6ugLf8EAqdNChUC70lyjYGUnMlkLx7eY2ZR5WdfZf9J3Au3snO/vTD2shPywggBtgqsyox3Tn0eo4zaYVkSu06q2E0b8sn2XO2UrZrtuqBgvg+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZdYkLz1bisw2vWdxGzgkQwJaeuz3eJ3GcHJezCKJjc=;
 b=IPRrJRiTuuNbHSt8X5XZSKgSOU8nGXODtGTXuZakUrspYp0KCTkABWoABzjzYg5yxuyDLLwvw8PNsDTFv0TipWqtoUfAnku+UaSg/IbnVRN/7FQIgIBKl9pDbacEKc0Ee7Hc6suQ4eLVQHcAWoKfFJFfQbXDeRuPD7rUtCB9jmldL5tjhbu2NyXoeKFkQLBB2Kc0hlu7fKuAqJyCWAas1476rb2rEdjO0vx8SLW+oX+US3DdXoQA3LYlCFWaTw5oKBPi33vhsiZeU7YMXxYHPFSAHC6nUdAq0Jrfjkj5KQoLwoU9BHnR8il7eydNGUyk0Zxg8x4aaseQnkHiKKdnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZdYkLz1bisw2vWdxGzgkQwJaeuz3eJ3GcHJezCKJjc=;
 b=Jv08WsQGaay/01m59NEX7aSEV9lHpQzcMcx+2qOqm+IU6K7JzA6n7Dal/4ceBcXsPsxtZu/yBejvGrVpc+79/MufGN7rcppvK6Ca6dfCDT4WrU2GVTUwhBqs5Aj6glBo7zIlqj1ovpwHfsGjOxrZb/hgZwQk20JSAqcahRhuBTw=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 17:08:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Tue, 11 Oct 2022
 17:08:54 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     linkt <xazrael@hotmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Mark Pearson <mpearson@lenovo.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+
 ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
Thread-Topic: [PATCH -next] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+
 ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
Thread-Index: AQHY3Rx3XmXuvIkdpUquzaol1aqkEa4JbJGg
Date:   Tue, 11 Oct 2022 17:08:54 +0000
Message-ID: <MN0PR12MB61013CCC5DD10347C3FA3EECE2239@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
In-Reply-To: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-11T17:03:34Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e4f15a70-cbd8-4318-a30c-4d092fa20d03;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-11T17:08:53Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a5211871-b8a9-473b-bc8b-68ec539c10e0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB5358:EE_
x-ms-office365-filtering-correlation-id: f59e7904-8406-4119-c07e-08daabab473a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V48hwSVIX/GzBV0k2ZHhGUl03Gz5hrDN+I+9Ejzw7/P/Iwd91jjPPXtWmz9deCk4hRNKTbhNizAt6K1dLQ6Yv4nXgEmVdO7dfo+19R/Xk9DtFu4DPGIh9s6YQFemyn2G+K8uwXiCiUH+df+6dtf5GoSaJyvihpcWm14ZJ/tJhUixzg/aRC0tPT7aPL32hHRB7calVy1LNB1sKsNgRcCypnOw+DWQpU2+iURbRicKDpj8rAt1zdmhf17YJ8Qs7u3R5ivQlwMcuO1DRXjLLnk7qz/hwu2YmsmgVYF0b1LIq/OPAdAA/32ctvHTvFZMZK859g5Gcp0GNkpt6s2gA2jdtFFnrS9hROJnFUhGNkfuxDS7J+Ij4Ju57rJz7b3+ycHUtnDrq/a00qKom91E3qP3W0Zmut3xh5lVzFSreHM5SpYqtSOt0zmjEs6Brmfgzg88UCC4R0N4Kz5Kd6ccOi9sCy70MnJ/h+xqXJ4tZvezR7LS9KdyOECzxUUlRJcNg1xgrm0RBxf+9mGWVtqzGXU3McZoaW2+82eWPdjjkSQ1+4Wk1YyWdbn13LxwkLb4WvMD30JlJIEkZJPL7CspiMxnfiyWKW35gZhJakPzbQTfRSoLus+me8sf9SsoCLTgfHBhDhD3rd/c+tIanicuZl6aBIVNHGuMG8oVoOeVEfSuJMDV8uxkEnyERrzAJJH4GDplykylOLrGWxNFCNnGPCTtJ/82KGcDVLdRK0jZlAMdhEdEOP5xvftkd20xeSayoEKza/8mfJIVirLywSX3/uWvivh9WIkpmeumArC7jSRmypA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(186003)(38070700005)(921005)(83380400001)(122000001)(38100700002)(5660300002)(2906002)(4326008)(8936002)(52536014)(55016003)(110136005)(41300700001)(26005)(9686003)(53546011)(6506007)(7696005)(316002)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(478600001)(71200400001)(6636002)(54906003)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MbZC5TWd1A7fHzFqzE0V2EBseC10I+qywkORWaJtcfXyYb7iM0n+GUIIHQEC?=
 =?us-ascii?Q?5MPBa8TsQV0FaG5U4Z0bI5WK7jNAcfLcRzErUj+yD+SqWBDel5Ol73yE/20H?=
 =?us-ascii?Q?WBTfcOyXneZLdErarLtfK8OAVbkeQDAhCbClXGgxCZul6+l1evmraxDmJMl2?=
 =?us-ascii?Q?PUidn+u+UdZYxwpeEWwVTUVNR2M/jlNWmAgt0bYJI6ld+cJyh4XzxJ1uR9iU?=
 =?us-ascii?Q?+YwFVjg/8b2Dac++ZB0bf0523nzdjko/GrhM23QZ6AarvS/OSLOofNdNJdyT?=
 =?us-ascii?Q?ZDG5xHl5xh+waSOlOVWkrVSRPy0cJGEZkN3MK5X+fBkzEAYmdPlyOtXFFwul?=
 =?us-ascii?Q?4icCuAzwOjNVRJDjgOPvGoI13sXjkihCconcllCEkggMjLYysGeh3UGZcf0b?=
 =?us-ascii?Q?MKG0XJL28srAL3/PrCH3C9CQhRsgSs77SVdwruuLjxwDQwsHUZkIIKM4wGod?=
 =?us-ascii?Q?LBCfwljxj1wfsg3zLSYSPIWj2RbEmGG1fW4n5Um8SBIzm/XAdRqJz+w/Pxew?=
 =?us-ascii?Q?Kr3QO/XQhhxwyw2p3YfOj4oK2L7kLj9BUQg59E7hFkCSWoEtoZuN87SWSDpb?=
 =?us-ascii?Q?osaspXMeXVyTK5o67wzPadCpMIrIL7lLSW3rlpU6G8xgDcaw2reAxApToNTF?=
 =?us-ascii?Q?jpUE3JjCQEG7wsPvpFKZhg0WSauWGLVScuNlFq8xmVzQ2PEUON9pguDlBQdH?=
 =?us-ascii?Q?/j3JYD03kx4EKe/kGgdLuO6qHLh31yRNPN3I/2LLxHp7EhKLcCa9GpyUNPrx?=
 =?us-ascii?Q?76dEA7qco91Fnm7rXLi/qw3tx5EIGmSPWLAqeuFuWtQ4LWB9EUV64zuoIMf3?=
 =?us-ascii?Q?4ON8Z4iUibs8xuXjo1yoN2B3jREfJFXt3CKXKTL4yLfFCljaZQuJJ0RIF0m7?=
 =?us-ascii?Q?fSN8ovYXT1G+v9xg9qeoF1cqQqQePz8oLhkI1nWSHytsze95pAmzdKMxwCzK?=
 =?us-ascii?Q?2QFouqOT34Jt/A56a8LhvdyadkVSSC+rBgf3bkFTMfxhLhgtjlNkXhySi0bz?=
 =?us-ascii?Q?d4C1ZdD7d+oZToiL6QChXjXPvOeGzFkXd9ZOaxLQSQWRrvXLFzw9Nsn6FzZe?=
 =?us-ascii?Q?8xR2jrf5pdE0Hl9Qj6x5iG8EXcbZJ9+JO6j4Px6eIUOhaggnoIP+tqxPNW9i?=
 =?us-ascii?Q?fXvom8egbR3gPOfwNFB7TOFNAYpl0ZufqVn3IX/6hJtYDjP821AkjLFPUCE8?=
 =?us-ascii?Q?tasPl8Gv6Ri4QFcX1mgO8Oi8utvW92jArEgWcaRPsOVNSAmRh8N+6GfZDf7A?=
 =?us-ascii?Q?C7sg/X9AR86q6uQ8bBN7xB1m9DYZOrJjoptsmWQwHkjfgvff6vGKy1KXe/P0?=
 =?us-ascii?Q?UoNNFW5tjHv1cTvykUoKbUVogvGWzVfYpDsI/06gYXaCIICpMLXATSXAftTU?=
 =?us-ascii?Q?uDz3zv82FQRIXTH9U28mk/JhJlDmOkRdsu+wlWIgRxL/HU72iLMplmc+6hi7?=
 =?us-ascii?Q?Jliw9yODSM35qQbqbHWI4RXat+5L6iSopgbjSbunvvp2+evkcM8v4bXoD4a6?=
 =?us-ascii?Q?ca+zwlsYjSq0xHBudX/AqkkvtFeqaoVXBBbIPwF8eDrOPjZL8dYpldt0xAh8?=
 =?us-ascii?Q?9hV/HbCji5jgIdf8ofY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59e7904-8406-4119-c07e-08daabab473a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 17:08:54.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZuEfu0blXtbyi0oOKJo/0PPpeJfyIYPqJFa6sApqlSbz2GiKkuxb0ZpBD/60qqOtVM56hOcmwtCsn97Fz23lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
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

Cc:
Mark Pearson
Vijendar
Syed
Renjith

> -----Original Message-----
> From: linkt <xazrael@hotmail.com>
> Sent: Monday, October 10, 2022 21:52
> To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> tiwai@suse.com; Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; linkt
> <xazrael@hotmail.com>
> Subject: [PATCH -next] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+
> ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
>=20
> Lenovo ThinkBook 14 Gen 4+ ARA and ThinkBook 16 Gen 4+ ARA
> need to be added to the list of quirks for the microphone to work properl=
y.
>=20
> Signed-off-by: linkt <xazrael@hotmail.com>

This patch alone makes sense to me.

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I think it should go in as is, but it prompts another idea to me I want to =
run by
Mark specifically..

Should we just drop this whole file down to a much simpler DMI match prefix=
 like this:

> +	{
> +		.driver_data =3D &acp6x_card,
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21"),
> +		}
> +	},

That would allow it to match all the Lenovo Rembrandt systems presumably an=
d
can stop touching the file.  This only makes sense if every single Lenovo R=
embrandt design=20
uses a DMIC from ACP.  I don't know if that's a valid assumption and I thin=
k we need Mark
to confirm it.

The DMI match "technically" would match some of the Intel systems from this=
 generation
but this driver is only "loaded" on AMD Rembrandt systems, so I don't think=
 it's a problem.

> ---
>  sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-
> mach.c
> index 2cb50d5cf1a9..09a8aceff22f 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -45,6 +45,20 @@ static struct snd_soc_card acp6x_card =3D {
>  };
>=20
>  static const struct dmi_system_id yc_acp_quirk_table[] =3D {
> +	{
> +		.driver_data =3D &acp6x_card,
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D0"),
> +		}
> +	},
> +	{
> +		.driver_data =3D &acp6x_card,
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D1"),
> +		}
> +	},
>  	{
>  		.driver_data =3D &acp6x_card,
>  		.matches =3D {
> --
> 2.37.3
