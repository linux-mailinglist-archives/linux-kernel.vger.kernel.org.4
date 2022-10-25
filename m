Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7419C60CBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJYM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiJYMZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:25:56 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864511A970;
        Tue, 25 Oct 2022 05:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auF/mkL3v5FN86iQM8HSN792esMdSySLtLiNLTF5I/k3+XEIL4f1GfH63PUKt4H1FEt/QgrE5msWb0qevdMSSjPaFd3y8ZbjZBT0MOTOit5l0XMgeWB+zPzl2oK+x0NCJkEcCOOMMAMQ0vLvABHIwLxsm4W6p5VkqXivRGPcMDq3sq7fFBESz9em4kpK3KM0mnOMH84NCFgwlk6wRKZ4N7KQFBambDQxxasw0Ts/q3Ml2I+qFhVMwxwATa7AYESJcgZ2uv+n7E/vGiJdJAJanlaZdT05jD8pKsz2T2rs6PlSL5ZmRQTlHzchr2IWfMIqyUpFUlcT8J7BWiMuhCuYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1Exri8626Pj8LsJlSxvHM6rFbL7FPBS3VqVBLSfDA0=;
 b=PgIGLaQQ2JfmiCddXaxssFIxE5GJVCb+PZAgr5usULneH9Gzwkt0WxgLX8T+WYK+rTia6gKOJpeNMXOYRX18WpJb9fSW6fYzQ1gxW07lVXfGzzfP7XL3o6CSav+DAJPD4KuKpfTHaOTuKCH153rCSu2IKMAuRFPKAkUPlzBf82KB3PXZyxK/4Ysl6j1uaqBApkNVafVPgOcIDGzk2QnAWOTl4DlvHDcZ29Bi2lmNJw6MAQr8RsUnRvp2+zndVLBmkeEG+2zHAMYfz4Q46VG7c1pF/qc3SWjUS42wgk4577Kfg+o3gR4HXkyyLZZppUWLwQWcuAKcDMkSQ589EINVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1Exri8626Pj8LsJlSxvHM6rFbL7FPBS3VqVBLSfDA0=;
 b=qzUq3beZqdB3lWTvp0w4NX4s/6Rgs1g/0Z5eFlsztEemA5DHjAFtj0WR00olpPIUNDUUX7uBT+5cCLArM8KMJTYAFxL4qzN6VkOEqYoBXIRcH+lJ9ccDtAvyHsKOPFzjBp4vkERZgRDfxUdnNb6LpTVSdGDD1g6wMcZEojiEiapFxOsd708NI8LqmlF6TPy4tRk3Jijvv6DZ6yZPAlpTguIzqTyRDIx7uxXVfV1vWsY7zpM5+V6tiqBdSzz6kGa/SIlUbg1NTgw2tcBbBW4IlPespONl97MD3fLU75hHrfAkN1Pd0Vt26qVzdsQ+QsRI5cNbXvwof3Cimu4ru6Ur/g==
Received: from GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:58::7)
 by DB9PR10MB5596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 12:25:53 +0000
Received: from GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b8f8:a9de:ae69:21b2]) by GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b8f8:a9de:ae69:21b2%9]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 12:25:52 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
Thread-Topic: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
Thread-Index: AQHY6GI/fI/RQHsoj0KTBIsRrsLIca4e9ZyAgAAJggCAAAn0EA==
Date:   Tue, 25 Oct 2022 12:25:52 +0000
Message-ID: <GV1PR10MB5892C01AF7683B0E781C88D3E0319@GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM>
References: <20221024130114.2070-1-daniel.starke@siemens.com>
 <20221024130114.2070-3-daniel.starke@siemens.com>
 <403445fd-fc99-290-2a5d-cd7c18fb715c@linux.intel.com>
 <GV1PR10MB5892040CAC0FED4857BB771AE0319@GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM>
 <d253f864-5585-ce29-b9b4-92a0e2bc374@linux.intel.com>
In-Reply-To: <d253f864-5585-ce29-b9b4-92a0e2bc374@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-10-25T12:25:51Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4b64333b-24b4-4c1d-89c5-1073b81a50ce;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR10MB5892:EE_|DB9PR10MB5596:EE_
x-ms-office365-filtering-correlation-id: 0b5b746d-585b-4143-ed96-08dab6840ef3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZ9nJALDsN+7NnxUgwzlcnXZVask1VkAi87BCpvI2hk7NtmatVT0SbEUq60mAJN4g34DADWlO8Ab1Rrw+A8jnhkJytsU9rRIlLXpJgmAszohAdwCIlXyyTQvoRFmXT6zRlu8gs9CvmQjlyu8iDbbLb8kPi7cwAzg7x31ggic2T/Z2gYFaxXYukvqHCAHVz6W16/9g3tcYsibIcLKYue2lXrC4TMp8oHez1sEUhKvN8nfsvKt5EVtdmT7uUbbZtCChL1CWZUnnkUeRWy7/I1SzLq6qHCqoJu2VttPSebXYsinLNBxdHJEnWaK//G0uH7GOp0cUH5fxAYY2R4PBk9BT/84maEHwILez464Pac4Vm794Y84GOrc6LHrBHnjYRw/xjyWoFxT7ljdIVksuI0HfGNob+J0In43KA/KQA1gTe9dvBcrnZR+1+2tHSoEZCxu9RQIXrEkH9j0TIbLxf9LVchOeUSqXG6zssO0bXM9mASUscAldDcNVNMNzKG8trswTSpOh2vN0ooQyB94sRHtexzQUAwYPve6zM3+gSvwfApSJdYK7lb/pS68ZN5AlwkxhcYfdU1+E2Yj7P1qdmRgQurn28KzDJTS6hUNpuUpasEBy1b0bWPC0OUuKG6RriN2Dw8+8lXeVtmflHPmU6OxIPvP24ffbTHxqVj3vA1eB5cGKqSX7ubnvs1D4BDPVJNYYKNFwr5T+Ke6j9IsYPBT3bIMw0tmoUlW4eKrnLAReADRVbFyadAGXZM2vlLxn5k3yvhWCF/nUG5wWkoUMchLvsNdmgbQvJISzFWLboyhCwDpwoxVohaWAJC2FMayHWkg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(122000001)(66446008)(316002)(8676002)(54906003)(38070700005)(6916009)(6506007)(4326008)(7696005)(2906002)(66476007)(66556008)(66946007)(52536014)(64756008)(9686003)(41300700001)(26005)(186003)(8936002)(55016003)(5660300002)(33656002)(86362001)(76116006)(71200400001)(83380400001)(38100700002)(82960400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nl3GwdcobJ+JrnJ7+GBM8DbrE7OKOG0zlAldBZHK/uSM5RcWXoPBr6Xgli?=
 =?iso-8859-1?Q?GnapO429FCcjPbj+6OtALplWmWBw3NN3IeY1Y9MwKIaxLfAqOFSk1/ZmTO?=
 =?iso-8859-1?Q?w9o5Aryr8PXtK+Q4X0KjqJT0NrSI0W38X7LMryGX1cDpxiWkjnCIl7j3ba?=
 =?iso-8859-1?Q?n08z56TgDNBLKRGzcV56kD+JsBMXLYlEuegADg2cqF2hmAy+YT9S+sbggb?=
 =?iso-8859-1?Q?w2MwurBQ3yQ/NGMPdPMG3sQHXoP1NVEUKYEYB0FOmSKMcADYLvb0fE5KIi?=
 =?iso-8859-1?Q?Wl1QBioHu+FSigAkz9ILMDXDXntkx+r9hG4iwTuob2DjReqGVEcntQeJ2L?=
 =?iso-8859-1?Q?NmyiqPgsM/U0vcRejdO4GOKY98Ri/XOqVI9AZEX6g02Dn3tvkpvGkquzJ1?=
 =?iso-8859-1?Q?E+KSLtTxRNu45ma6S5lxKE7vhbG6pmYH8Sn3qm6pqyZONlBpF3SNI9c0Aa?=
 =?iso-8859-1?Q?QhWz0i9fJNovwixCKL5Arha4+TP8kfJO97DfbLUWF0XuNjZhaQ+3p4tHuv?=
 =?iso-8859-1?Q?QLwQHHsnQVYge1uvR+nQvkss5XcujAALOObDi5TdhXoZKTCz6XaA9HTLfv?=
 =?iso-8859-1?Q?of+wl+d8YgxEBHIxNzVD/bgeq5/groXbxP+6h645hsalzuA35bYoZ2ow9k?=
 =?iso-8859-1?Q?u5smTWonQNFG04X9a4OZIEKKJD+DMySPGog3ciHaHj2JBA8ZzVHwbeTF0S?=
 =?iso-8859-1?Q?sNU0TjV+YyWO+dIwIrWQs+i+owlfy1+AbCwmTeGcnI/4FUn5aeaa9wBOpf?=
 =?iso-8859-1?Q?IAgRdAa7J3ShU9Kjd+B8POwpbobIGKqCUM+C+i56VJSJ+YB0E3gszzVuFH?=
 =?iso-8859-1?Q?uBeAQ4dCVmPwSj3L02fmB2nt316zby8sJo58raxOm7vGOt3IINBicmy5hv?=
 =?iso-8859-1?Q?YuAl09kNo/InyihNDP2Sito296V4VdGdx3xSf55BrCruBJfqeaJL4dEeko?=
 =?iso-8859-1?Q?mlj1rkMG3EKOY7fW0h9fCuoRdeyXSUAkEc56vskC0xDBUI7lA3cEcPvhAJ?=
 =?iso-8859-1?Q?po6ckta2Act3QajA0/XmwbqgrfB7KK4iUxZHssYhmu421eh8kpubdRBuct?=
 =?iso-8859-1?Q?JZ6ovCDY933/3Kde9TI5cB0wDTwvgLSFPPdyaSCZFsETr8uzkpboYmgvDF?=
 =?iso-8859-1?Q?tx/1/v+t1V30ouPccmRw5t72vopbrHmbWXSp81Y8yb+SzjINppsXNthq2S?=
 =?iso-8859-1?Q?VGBYLNLvIvGQfrc1K/lRYAhXMEnhye4pJ2YnGetP6sCijvIf8qrrqI5YE7?=
 =?iso-8859-1?Q?JhLszhvlgVrANgrcF77NemF9keC+/NoTiom9Pb1lAPqvKBsYwVLb/paKP1?=
 =?iso-8859-1?Q?yVjLJ8oQyJ6ORqCgz8zDYfZMaBaCQmUSuMqCWyn0pKcxaRnnHvk18g2nqT?=
 =?iso-8859-1?Q?O5pV92b78FvmSntHKeM6QQJQDz20v6jJF41qqVpXtl92Ff5UjJDB7N7Nj1?=
 =?iso-8859-1?Q?YB7IBkkMtAmqS0iF1zc8wWnTTbvgKSxFwBKNZxgEP4Zxe9dyO1HnC6erWf?=
 =?iso-8859-1?Q?Le3E4TPjs9d9G7JfM3OsCufo1dPxjnG6fvPMQXkfC7wXxLIeMQclpw1iP+?=
 =?iso-8859-1?Q?TycyoE7bpH3tw1f+Cep26BB1Kt2XY4MkO0O2FsXl4XLfFf0l2pEjaaHWva?=
 =?iso-8859-1?Q?y5TGSDx7M/kILwNp90VFzrD7SFnlhHyCEKuITIHc/FOwXfL1BHrs8Gvg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB5892.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5b746d-585b-4143-ed96-08dab6840ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 12:25:52.8683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z50z4cMBhSfZMRb54ehuKocudbfLpJjhQFNknn91mTimhmxVKiuPW3sKMqUakzgnqZGhDVCs4SyFAtbz9volXIP0Xc1fG9OGE9ZLrAwl0rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5596
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > +	n1 =3D FIELD_GET(PN_N_FIELD_N1, le16_to_cpu(params->n_bits));
> > >=20
> > > Should this be using get_unaligned...()?
> >=20
> > Is this really necessary if the structure is already __packed? I did no=
t
> > receive any warning by the compiler.
>=20
> It would be arch dependent to begin with. But honestly, I'm not entirely=
=20
> certain here myself.

I have checked the code in include/asm-generic/unaligned.h.
An extract:

#define __get_unaligned_t(type, ptr) ({						\
	const struct { type x; } __packed *__pptr =3D (typeof(__pptr))(ptr);	\
	__pptr->x;								\
})

#define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))

static inline u16 get_unaligned_le16(const void *p)
{
	return le16_to_cpu(__get_unaligned_t(__le16, p));
}

Looking at this I would assume that the use of get_unaligned_le16() makes
no difference compared to the current implementation. My assumption is
that the compiler makes sure the 16-bit value is accessed at the correct
address and le16_to_cpu() converts the intermediate value correctly.

> static_assert(sizeof(struct gsm_dlci_param_bits) =3D=3D 8);
>=20
> If lkp builds all its current archs fine with that static_assert(), I'd b=
e=20
> pretty sure the struct that the unpacked struct is ok on all archs. Would=
=20
> it ever stop being true on any arch/compiler setting, the assert would=20
> catch it right away.

That is an uncertainty I would like to avoid. And what should be the
solution if the assertion fails? Nevertheless, I do not mind implementing
it in this way to move forward.

Best regards,
Daniel Starke
