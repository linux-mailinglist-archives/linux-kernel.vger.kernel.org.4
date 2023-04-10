Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB736DC8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjDJPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDJPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:52:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2A63A8F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvY/GQ0QRARvaHJRsPMuuwaBZJyCn4MqYf2sPXNC+qCTwlHDjDIuIpsUbXgxgfjXQdaauPiKsJLc5kVKdcIRqVLFGRmmhpJMtWwfbNBY7ha+5ZkFwTktxC36wGxsZTkgdCdz3Tr09fr0uWoKAROW2WhGvTvDGs5Sez1zbQY7Vcsw3Ro/72veLEreLnpyITeYHq0ZXGGspjUcuSobrlKGtZrULHCgcxj6ExoS3YAa8CKGjueDKjWoLe5PjDVsyxfQjDHHFpUGc1XeYYrlAt270Q0QqsVkrNMu0oxvIO2Tk42SH9yXZZ1j7oh6OHHXbhvhvoWjrqpsNVVJ4fYsW6x5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9fmgPSCCKJoW4Y8vh83hZfZh7aVp6PZFAd/h+TbluY=;
 b=EkzyK7xKjwpFSv5lY8PtLXAcSa9D8SldTtJnlmv/7FW/4gsjWx4WSvH+lV5GC05ECUQ/NcpKyuUDVmP1V/+drgpGtRuPol8lMW63BxD9HG7lN1xpwZeWNjOwfyCXCs0gjtBI/WffCbP3snAApqRZHQ/EnEO1YCIPGm9aZeMXh9DwjGEX0bvCxckOx5fJmZnGvc0sQMFsEStQf+nDWBZ9Z2zixOA/8z0RNbieFtZmzSvTQnIW03xTja83zmfan38Ob018XHZ/AdVsSQCdsK+fYnbSFxj+wBwLO6hmZfF0tnvw/zRsHPilCANZDGR9J42ZzV0R1Lv4E8U0OL8u3Gjo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9fmgPSCCKJoW4Y8vh83hZfZh7aVp6PZFAd/h+TbluY=;
 b=rMm3nfRRbUd2Wizk8g4aIDf9/Jt/VU1gxD13eJBVsqFaAI1nMIU/skRWO74BaiGGDzcWqMaBdh4LrfBxus7/T+UBVM+xCodl9Df1U3o5Nlqjoxy8vYQBvUE+m23bsyX31z6q7VqzN0pKbngLMi1AazPZ+P/zK4erkHyD/sNJT4Y=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 15:52:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 15:52:48 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Cem Kaya <cemkaya.boun@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Add Dell G15 5525 Ryzen Edition to quirks list for acp6x
 so that internal DMIC works.
Thread-Topic: [PATCH] Add Dell G15 5525 Ryzen Edition to quirks list for acp6x
 so that internal DMIC works.
Thread-Index: AQHZa8QtO6b0p6/w+kWH76nwDfNIe68ksOFQ
Date:   Mon, 10 Apr 2023 15:52:47 +0000
Message-ID: <MN0PR12MB61013743530925DDE8AFDB50E2959@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230410154928.171975-1-cemkaya.boun@gmail.com>
In-Reply-To: <20230410154928.171975-1-cemkaya.boun@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-10T15:52:46Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4d9f44cb-df38-4fff-9601-847ec1f67c97;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-10T15:52:46Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4a847205-8278-4a17-80ef-dfb2a5556f2d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SA0PR12MB4591:EE_
x-ms-office365-filtering-correlation-id: 98333c97-b974-4374-3f25-08db39dba1eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2+2roETAkvB7bnq2nEt1a0bp8WSlkEaWgk7xH+rpsP4htx/Bh3Wqu0E01LRDQcuq/sX/NnF2m6qdtrp1y7k8yrXVHvHk43fm3GYRUuUsQtFZOOmZeE1WKYR+AazirOxcLRKbikMjHIyXY2XZ5C798320RuoBKAhdwoQFqR0IjDTchBOzJ9rN9nXGi4cFAGhMgtvnKtvavF7VhJM0f/na38AWLLUqA6ahsjTgWXAe2dmUt5YIrqaKmb+hj8HjAQVob0LAI0KnqjlNqJzWr32c6fftr6iCfWeyHjsApRZSK6jNscuAipzDCw8aBXnXLL1bNreOIV4yU7lblcRXL+0ijPOAK+NPk/ZppwriIKscM2/2gkTUNFFAizhcd8ZsZZFRpZxCPDh82lm5BKl7aKK+FabB4YG3EaBIDm2JLZaRD4MaCbPcXm/PXqdrFdAP2xk1OPyZAss1nFsh6zmtcTJlkXTFoScRmIzd2yZJzC9kGDC7iRVbs9h6T2GMd1IUEno2MJLoqy/CcrCt3UNicRBcplfbxwBfx8SjPuOjHB0GCyJOHCHXKPNoCtd4YzAMNiXrtYv6K7yOaGGdbsL8yTjmOn0l3aTP6gZTRWjt9fEIQNIup212TarleWG7qlCWRnu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(478600001)(7696005)(71200400001)(316002)(110136005)(9686003)(6506007)(26005)(186003)(54906003)(966005)(2906002)(4744005)(76116006)(66946007)(4326008)(64756008)(66446008)(66556008)(8936002)(66476007)(8676002)(52536014)(41300700001)(5660300002)(122000001)(38100700002)(86362001)(55016003)(33656002)(83380400001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SpvqssP2e45jLfA+2xh8yc2It30xkuZk1Hp1AYR5yw6745oWEtQQahVKbwTS?=
 =?us-ascii?Q?rS/+7UiDKusNp7fhXaf0+qSVOUZ30Rp+yBdtdw9A6nDjE3q+C6Y1TXxmUNjn?=
 =?us-ascii?Q?5wLV35C/rUSBUFnaUziCvNfkjulKbWfW4eAsgXDj8ss5fCkIIqyjEC5Uu2EN?=
 =?us-ascii?Q?iQaOVAR674gs8hFQ3Cn77vEeddX32C3+sIz1Pmvzbs7bUu/8fGKxu8jqhL2m?=
 =?us-ascii?Q?/Ff4czylIfKFskNOSrFdJdhFKf1ErrzeWfyBUL+sQMd6kST/+6ceD27t2meF?=
 =?us-ascii?Q?w40u+tfuT4jJIUVjNU+NfEydnInPRy73HJFJEay44kQpjtqNnwwlFChZHEHO?=
 =?us-ascii?Q?VI7Rhf8uR2AFv5M4tkiGgLqkpBvs2SR9U9O0/mz88IvPsxe4RGdmsPFcgpZ6?=
 =?us-ascii?Q?UW3oIlVaBS15SqdgmrNodXvMopZH8yXRGTdQuh+rNxTH+oU8Q8XEEU/tPm98?=
 =?us-ascii?Q?cRq9cC35BCVkXDUGeNqlkragG0bVao6ErGl17x9m9AlOnSR43xNC7NKmgkNK?=
 =?us-ascii?Q?iGtzlfsjbAbgiIQzGPZrswLXyC68yaaSv2S5UddUgilDfujbJBpeb2tcdf2Y?=
 =?us-ascii?Q?8C6B2Ka0P/nNAlNBeBczBFGPQeutU5xmuuSneb70AukGGD5Ox3HSmgjWLk0f?=
 =?us-ascii?Q?c+dlsqHkF45DokaO44FOxYzzA5xurTFyWj3cYIfDZtRr4SGQ7AfL78oC4ET7?=
 =?us-ascii?Q?dhURMw9AqVcAT9AAss2YRkd8nvTmmiJ0c1TSaUY4N4boGj0yTo/Eg5aiVi8t?=
 =?us-ascii?Q?7rmiKpSZmXeVTx2l6ML5zUP78aNseuhjY62MFkGThrJFYmfMzjwgr2tEr2Ak?=
 =?us-ascii?Q?hAaF/qjXs8T/AhxgqxDBeUe9gqbx2ZENNBdWbC0LUIiTRGSyO/7KuFT8FXQK?=
 =?us-ascii?Q?BIV+vFtbcH9sVAaX8fYPu5kqxcsZaBo5AciNIIy8RGitBIhssZQh4JpU2S/U?=
 =?us-ascii?Q?aMCvm42hHCk++MpE7IPP3WK6x6eyiT+I5yAiNyn23kNCsn1EaVqqlUNk10Mz?=
 =?us-ascii?Q?TWVXkbsbeF2raUFHYx/A90wzOVLGqpO7hZgA5eM3DgzNMWNVYndYgO4Fjzjp?=
 =?us-ascii?Q?dCfMhn3+Iq0D4GCv4MYOu+HIzrWANarcYS7O/DEQ88zRq49jHiQJFVyJ3uFH?=
 =?us-ascii?Q?Bsaq/TlFC9v9TIH2M/gclLKaHkYdcJL0vsmeB5zMPhmRbYNkaav9rGB/8dRP?=
 =?us-ascii?Q?TenmUmfv6qtWC/fZcm2KF8QnvLtDFEg1qejKiui1jyQmKAQGc/W+lhGHdJ3J?=
 =?us-ascii?Q?x0LTVa7WxIQg+L07xzhmSWXw4ybH26bvMNxPMAWEHgjNGObPHrAUNZLt+huM?=
 =?us-ascii?Q?UXWSh9RiRYIsyLsQ6Q+hXGCv/DL2Djow4ISb1CGASpFYqrZ4l4g75eP2yYGX?=
 =?us-ascii?Q?Y9o+eukMqI0IaKyfRWXKxytqkA9zNw9KVCM2LmOiUK4L+wXTT/VEcb475nAH?=
 =?us-ascii?Q?3DqsZCRHG+K9INHQRTsqjety0FQcTh0QILl6k+9Iem3vMUGId4uNMKmrDeeO?=
 =?us-ascii?Q?0jnviG04lKXhcYfkh6DhCBVJ3gIOS0IUvFJ+s7ImSK3wVeseY3q6lKps9g0t?=
 =?us-ascii?Q?fW32L4ZayPUfGvdaCos=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98333c97-b974-4374-3f25-08db39dba1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 15:52:47.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZieDl9D90c7k1Y1IizGgor2jJ9T7i6SiSTJmhMbOaMxg7jCrWBmsw45lMpqVSMiHDKmO4j/LT6/W3Onz5jqbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-
> mach.c
> index a428e17f0325..e044d811496e 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card =3D {
>  };
>=20
>  static const struct dmi_system_id yc_acp_quirk_table[] =3D {
> +	{
> +		.driver_data =3D &acp6x_card,
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15
> 5525"),
> +		}
> +	},
>  	{
>  		.driver_data =3D &acp6x_card,
>  		.matches =3D {
> --
> 2.40.0

Hi,

Thanks for sending this up, but you'll need to add a few things:

1) You need to add a commit message explaining the why
2) You're missing a SoB tag (IE Signed-off-by: Foo Bar <foo@bar.com>)
3) As this came from a kernel Bugzilla originally, suggest you to add Link =
tag:

Link: https://foo.bar.com/url

4) When you resubmit, please change PATCH to "PATCH v2"
