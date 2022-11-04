Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F5F619C52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiKDP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiKDP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:58:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E179D2C65A;
        Fri,  4 Nov 2022 08:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biMSFeOZyKAbZ6GmwYDPNF8ewucYiKGHIOBqaftnRraFGvoJIcL+lPAjB2Yo+iVpuucizOyQy2R2Bs0k9j6TgoRrfGla/gQ74dvq3bz7IuNaMtLmYh5OGSgb1dt9uGHb4fXsoYyrRmrEZXFQ4KQEmefsKrfCHnKOuGUOE69139GjESolJa3Lq5RKZ0LKpeDEQkDwPcrJHwg4c0e7aUSEyiJUQdkfao5RpU5yf1oWlJvgCJ4u+obCooGjJzYon+HtYW3E0k9Icvy+HsPzHVB2KYTrTbcfP2UQCWrdyn83qRH5uOH2NJUhm2j/PI9MakqasrYFOnusICJp1PQWP1N7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpvdpe68rZzqxwD157yE3h7xy4tnHlIUuonMUWIB1eY=;
 b=PuMkkEzjcKMfs4NAIwcOuySC3+zdoPsfjAAsPvqu1l6NMgRQU5zL945RD+YNAQQYkoexctH35XrxF5Bu52e0IUh7gAgOwAm+Qc4mdL4jmKxNAvTv2wXd6PcrJxumvCrcvImMnuCTwNmcuZXa6kyiOha/5XkxWHtfpchP8LjUiHut/cljnArhK3lwZkjdcHIAiyGQYenNN98SQfmC5Djpd4I6INjNVeMFEDt26MLQMmVyRZYiBN91xoweMsXB9KANO/FU1vxkQN9GAFjwiSEXNuFM1rDHa/SgW9qo3sPU9C+I92o5/+yYJnGIsO1A4R+a4dlZee3nOL9Wbo3TMWA81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpvdpe68rZzqxwD157yE3h7xy4tnHlIUuonMUWIB1eY=;
 b=k/GCcAb8TNgUqm62rTfsbWa9i+rv8Y2vHG9xxLyhddZADEYOKPa2NRnoTGyo6WHPlzrcsTgOfaERS801khPHaDU4KGBmiHoelntrrknXdYrK047SmC/wNozNR9G0vd2nY9GAS0C60UZ80u0BYYmUNhgt8IqA10g2gA3gMiiFg9s=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 15:58:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Fri, 4 Nov 2022
 15:58:22 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark Gross <markgross@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: RE: [PATCH v1 1/1] platform/x86: p2sb: Don't fail if unknown CPU is
 found
Thread-Topic: [PATCH v1 1/1] platform/x86: p2sb: Don't fail if unknown CPU is
 found
Thread-Index: AQHY8GUEz2cIbCzdKUyTZPStbuO4Xq4u62pg
Date:   Fri, 4 Nov 2022 15:58:22 +0000
Message-ID: <MN0PR12MB6101C1FEA748E52D42CBC734E23B9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221104154916.35231-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221104154916.35231-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-04T15:57:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9a63877c-ff28-4e76-afe1-7fe892343398;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-11-04T15:58:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8107a9be-ad85-45db-ab37-dabafb60ecf6
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY5PR12MB6480:EE_
x-ms-office365-filtering-correlation-id: 6e4324f0-48df-42dc-801a-08dabe7d664d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrq//K2DZo9i6t7i0MBKNoFmYGMIkyW91dkR04lxoXhyEvMkAkczEVI0UDsartnm1g5oYbuP7pyhStTTvOeROjSVCFAROfQ5NSgaolm5gEKbf6eX22aMJ0ZUL32xott4UbeTeP9aYtAD2829cAl0VJv01AzIlurLrUzZ7REBqPmPK/GVBDUKhSgzXVYasyubhJTKcp7+C0KITCU9O88AvTpGyg32rsjBgFUkwtoxPkwoUMI04rICPdy2OCW9mt7POsJTkPUcTNat8h6lTxkWie8H3082RPLM0sZYZ7a25dx2dwzK23pkgcMcLn4UVjaXhbHR9V9GT4gGg18g/anLMIbUZ44INMPQgUXJPP3Cty+TPj7yoqnoa62uw164UsKFs3OqbAU2BZC5f1Xss8xYOTcH1pi4dj2AhECk9XGIdV+3/JdFqP5NCoGr4fZ2gXoPHb6Q8x14I7tJKLrR3gFLThw+xCiLGfk2agiYtVb+Jsq7UkZ/sNjqGGNszGfprZsfqxIcN3Mrc0+ML1p77SiyhMZ/mWB9dod7IoIwjTLrJEgyM8T8aGxOXdLHLH16+BuHLf1EOJ9PK1Z6Kph29+1DKJP+PcAZXYKMTwjhuSd9xEsS4AgYPKoUHHEracqjGjvSSpSQibSRTyvYzi18dYhmHimkmBmJ28pARHnGlzQE9D9HZzbi7Cxzn1dUQYev8rd2Rq09u2uakvfejd64nmgivbiw70YjoWjXs8GzcfTpx4+TC1OoSzxX5UQRHOT3jnBvB3wcWOF2Ec2JWUuk+mvy2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199015)(33656002)(86362001)(122000001)(38100700002)(2906002)(38070700005)(83380400001)(186003)(76116006)(64756008)(26005)(4326008)(8676002)(66946007)(7696005)(66556008)(6506007)(71200400001)(54906003)(478600001)(110136005)(9686003)(66476007)(316002)(53546011)(8936002)(66446008)(5660300002)(55016003)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S8Qsgk4WWzkhRBM0pxdt2U8mthakZlI+XHIVeTBsvaYWmeErWPmUWd2sllq5?=
 =?us-ascii?Q?1B+i37m60cERy2fnqLMp669nPaiR8zD6ZWdqDf8FMo8jqBgo2kti1L2od0fq?=
 =?us-ascii?Q?XbsXLkavu6ctuDwNtD1V7KQe2fIfYsYLb5d2tnMuxtDEiKs3r/bSekspYjVi?=
 =?us-ascii?Q?Zr+vwoMRmyCq0oycOi7wyydFvJMp0GkVlLYLc25uQLH0ps/GqDsIewlznQ3q?=
 =?us-ascii?Q?HnAhkEaPelMMwYX8bk5IC9cNj7kandhYM/FnF5bbNoHWMq2yKxhlAjvf1BYs?=
 =?us-ascii?Q?zetfjs8mrAwHKUSSANlkVzs3Jkfd4WBjJ7nmgruO7T/56zZFpJabL4JqoE5U?=
 =?us-ascii?Q?8VgU+DrWK++nChbT0LR0fPpcY4oJ1AKlXcr7ezaAsUgt5EVRLzJOdUG5lpuH?=
 =?us-ascii?Q?La9XUUQPF6m9R28qL/41W4eeERYwualtrkqV/jN9REdpepIBNER9wgUrAqv+?=
 =?us-ascii?Q?4FdwgoYSd7vleU8qckV3XpR/B67wEXdjkQa0+LkfcOxYTaUM4ZqqvXoScKki?=
 =?us-ascii?Q?m8xc/ZO/TE+wVoIUtQqGwgkefPgcNWbvswSNrDFt5i3lkmgGXxUAqLRgei1B?=
 =?us-ascii?Q?9cC/x+Fkl/fycRX6NlZ8L2j/gn8ZfcGCNkV5GkvfV2vsnYaEqQMLs3sO5q9U?=
 =?us-ascii?Q?oru0Fy4U4507M7HtTFNAOgE0DzkeHIWFxn0jOqfV+20DKafFx61MfVhJxJJi?=
 =?us-ascii?Q?5REtVFf+efkITmory7Z2FIdxtk0sxzyXC7PCXNWwoBreH3qJbRo7LAcDdv1H?=
 =?us-ascii?Q?7oe6uzsF8ij/51mwNPMuo/L3tGrNU+FbedM3hNtNucH1I9tWwbNjYIh8da+T?=
 =?us-ascii?Q?wElSeUapgtt/xb8PerWl1YsULJDq342lWRqQEdD4HU+6SR3+ePls/9oBis6L?=
 =?us-ascii?Q?F+ynSUrqZrBWNyfRxVbT420s+4NTeseNhlXhnjJer6iB371IJWwzcO4sZmrU?=
 =?us-ascii?Q?6zGLkOpGNWa/j+OU/LurDltLSg6azxAXwgoht8tk4ve6upZnENCtFw1BYjxm?=
 =?us-ascii?Q?UN+LXzXkrFxEfQswD8NbTl7i8xHafNkfIoXnAEpmj7dV/r0L8WsPZsCN7npx?=
 =?us-ascii?Q?DSoEgMoAI8X9Y/0nFM1EEA50BHP4uGS56rqV/eqkO2bbTk3eZIayv52Fq+5T?=
 =?us-ascii?Q?vTWItFUTSDadthBLdEfaKSf2n3/HY6ZFGd6RkF/QUrqkNt4inCi0Uc/BcNNG?=
 =?us-ascii?Q?bOh/EHJ3AesT2vLI6HHlw531kQF8xurtAVUX809Q/2H84GwItbjhAGNHtCCS?=
 =?us-ascii?Q?6a3eHw4T9Zc9BGCrgSyG9IX4c+rcYgkvSEN4K702a0JjKq1HAHnd4KhXmPk8?=
 =?us-ascii?Q?rPWrs37ZDEnQv1GotXYklvQnvDDp9oby51Js6HmB7xZzupVOYIJPpqGkBxkN?=
 =?us-ascii?Q?mCcvWH46nSyS8FIeNanQSlJ1B8GyEbJ3L+R8Wk/h24xgDF1ZwQA+X3zA2ta0?=
 =?us-ascii?Q?s1JrT/FvHEQ9ZdlUt8nPvci8MDxCA8zvczYXTSQfvEw2vBm0yT6llC1xfSYM?=
 =?us-ascii?Q?hBSddgT2zS3pqnqKzraOoT0EULcU/qmHB4Wfii9CoENI97CFFP++wygp7BAj?=
 =?us-ascii?Q?SJ6w3Si0oc+L++SVrZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4324f0-48df-42dc-801a-08dabe7d664d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 15:58:22.2266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbFqRqp6gk+YUG4Np9/NBiriUwRkQFSwgBMdPJ6S3sf4RUwACq44jaA5Yc/LrttNfZZ+L51KyIlHoS9OkwEfJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
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
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, November 4, 2022 10:49
> To: Hans de Goede <hdegoede@redhat.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Mark Gross <markgross@kernel.org>; Jarkko Nikula
> <jarkko.nikula@linux.intel.com>
> Subject: [PATCH v1 1/1] platform/x86: p2sb: Don't fail if unknown CPU is
> found
>=20
> We have accessing P2SB from a very few places for quite known hardware.
>=20
> When a new SoC appears in intel-family.h it's not obvious that it needs
> to be added to p2sb.c as well. Instead, provide default BDF and refactor
> p2sb_get_devfn() to always succeed. If in the future we would need to
> exclude something, we may add a list of unsupported IDs.
>=20
> Without this change the iTCO on Intel Commet Lake SoCs became

Isn't it "Comet Lake"?

> unavailable:
>=20
>   i801_smbus 0000:00:1f.4: failed to create iTCO device
>=20
> Fixes: 5c7b9167ddf8 ("i2c: i801: convert to use common P2SB accessor")
> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/p2sb.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
> index 384d0962ae93..1cf2471d54dd 100644
> --- a/drivers/platform/x86/p2sb.c
> +++ b/drivers/platform/x86/p2sb.c
> @@ -19,26 +19,23 @@
>  #define P2SBC			0xe0
>  #define P2SBC_HIDE		BIT(8)
>=20
> +#define P2SB_DEVFN_DEFAULT	PCI_DEVFN(31, 1)
> +
>  static const struct x86_cpu_id p2sb_cpu_ids[] =3D {
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,
> 	PCI_DEVFN(13, 0)),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,
> 	PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,
> 	PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,
> 	PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,
> 	PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,
> 	PCI_DEVFN(31, 1)),
> -	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,
> 	PCI_DEVFN(31, 1)),
>  	{}
>  };
>=20
>  static int p2sb_get_devfn(unsigned int *devfn)
>  {
> +	unsigned int fn =3D P2SB_DEVFN_DEFAULT;
>  	const struct x86_cpu_id *id;
>=20
>  	id =3D x86_match_cpu(p2sb_cpu_ids);
> -	if (!id)
> -		return -ENODEV;
> +	if (id)
> +		fn =3D (unsigned int)id->driver_data;
>=20
> -	*devfn =3D (unsigned int)id->driver_data;
> +	*devfn =3D fn;
>  	return 0;
>  }
>=20
> --
> 2.35.1
