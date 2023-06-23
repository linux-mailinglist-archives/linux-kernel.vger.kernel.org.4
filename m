Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2973B95E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFWOHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjFWOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:07:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB642689
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVb9lGaCghKXtawxEJiL/EfkbVQg0Nw9eceYHTYOk6NIg7PdtrhQpn5FwVG+KEXTb8InrrfeqcJijG7Ewp1xuD/fdVrxNN63ewLiW68tAE0FAvEYR9SItQu1v0RDeh2IY0tzYC/7Mo5RVwICVR76/mx+3HJ4oPtW8FKytsVeRTrGbuBAtHyqvubcuzdSJWcLZ+Nw0LCNsgTdrqJ97dT96113XVeF4ZAH9wVABUvz0muHyNkcbdl29aOpRJ4BSCgcP6/+Gythd5MtQ29FgpASw9SeRVTWRLzyZOvA9DYJVv/9Y1kfTvd40Z97MD2kn9f3UoikqKMdUNMKmnboBRLDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lD7xioIc5AAKpXlqUUQBViLejhjgnfwSm9bZJAFXVs=;
 b=giUY9x1O/BAO1tJkjcZXE2zT6dkMLpxtCgaiI8jIUCK8sIcBQLeJR8+IGVuF19tJIicQjohoxZBaNpVQeo8vqHY07fe4vBeoeQGUhx2yeSjsQ3wVYF4fh61ul87UyvwVPXTnoN9vzb0dYAF3+lGHz60/A4W3b93dTV/MnqyagSE6tVB5/AO64W1JMhz/9Bw8S3iBCtywjjvh3r+0l1Aez/FrWvI/qLvv2ZGV79IElaipP3rY2W/76/4cFOyeZ4OFP1BLLah9Jr/PQiGrZkvFTwBmnPEAF9qlPFyessFPg+7s0SaVoV0CTcm8lij/qxNduJmc0twMhsTSjNYGWQT6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lD7xioIc5AAKpXlqUUQBViLejhjgnfwSm9bZJAFXVs=;
 b=aqYlXnZ/TKaza4gaWyBuzf0pURTO6m1V4yEzXi1Kjme5iqzCF40OoIJA0OTv5dbhjgcLgBUwPigNAoVJBYi8nd/ebSQbFr4CGHXeGfTJGHuxQzZw0ikG7hXsbaOahuf/8qhtxEJpOuJGqLyeMI4j8nuPD3xkNUlGa3CgzdjM5ug=
Received: from DM6PR12MB3659.namprd12.prod.outlook.com (2603:10b6:5:14a::31)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 14:07:38 +0000
Received: from DM6PR12MB3659.namprd12.prod.outlook.com
 ([fe80::5796:4c5a:5c00:d70a]) by DM6PR12MB3659.namprd12.prod.outlook.com
 ([fe80::5796:4c5a:5c00:d70a%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 14:07:38 +0000
From:   "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Reddy, V sujith kumar" <Vsujithkumar.Reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/12] ASoC: amd: acp: add acp i2s master clock generation
 for rembrandt platform
Thread-Topic: [PATCH 04/12] ASoC: amd: acp: add acp i2s master clock
 generation for rembrandt platform
Thread-Index: AQHZpR3Us3wpdIPEi0SRN+wgAoGU16+XaC0AgAEFXEA=
Date:   Fri, 23 Jun 2023 14:07:37 +0000
Message-ID: <DM6PR12MB3659B8BEB69A531050FF3CD0FC23A@DM6PR12MB3659.namprd12.prod.outlook.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
 <20230622152406.3709231-7-Syed.SabaKareem@amd.com>
 <ZJTLnhlCFhW/s4Vd@finisterre.sirena.org.uk>
In-Reply-To: <ZJTLnhlCFhW/s4Vd@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=74bac782-8d41-4f3a-93a6-92aca9b29b24;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-23T14:06:20Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3659:EE_|DS7PR12MB6165:EE_
x-ms-office365-filtering-correlation-id: 464d897d-132e-4194-1fe5-08db73f33377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YekV/sKubkEql4W+tHhpBLZKHVJTZi1is9Z9qTe0j3sIGm22XP7qfDn0OcTWu8gLRJqUbkYGovY4Biv3eBWF9U5epxVzeSJZ9L6iIkSpmp73GZ1PUoFyqIKFZM+Va1+S158OTACrnsOVmamYEuoCwUTCnITu/6XAvvijvQgtgY1n/e7Dbz/uB+8KU99UVlyoZaMixMONiU9+GwxI5BzsbAsKGBaDcG+vCSR51w9vuB6hqHkKVxLKz3+uS/NiPCwNgFPE1BnBGVr505V6bd3z5ZSicWm78N3SNq0xPsPEPpHqzZm4uLIcq4Yfmg4mm3xDbRJoE3oiDj7DD6cGk9O++EmZZYM8NfMdLuvfkKPwCQNB6YpHHx2pRw4hKrz4NzXRbdNlPfxw+dKP+Xzp1kuJbx28q7Kw+FZzT93XMsD5/3b7gaxWMPRGldznFNa+ung2Pz8vIb5ELyvOkA3oNu23VUPPkitzuRElI7NY+isVAb6D6sEL3/GPGiTQnTNhg3/j+yjuqkU8qhfu/J7clNNwYRlFyGr/4ZBiJZj+lWYmWTO4LfL5IgsTxJm5OVB19xoNk8/eXdsVlqcraLv7gpKlUaoNQ8m6Hfh9VPylze5T2Q7o957wC6MWppxJWNJWgo7y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(5660300002)(8676002)(52536014)(26005)(41300700001)(4744005)(2906002)(6916009)(4326008)(316002)(8936002)(54906003)(478600001)(7696005)(71200400001)(6506007)(9686003)(53546011)(186003)(66946007)(64756008)(66446008)(66556008)(76116006)(66476007)(83380400001)(55016003)(33656002)(122000001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?59dZ02Q+7UxHzMuYwaioCLFouKLzHj9wrOK6VsSmwWHbwil44r6LJlrmfp?=
 =?iso-8859-1?Q?KuTFRQIpyUOspi7Fg/wQ0vwMif9i2BvSugYjHhccKoePapdVlDIoKp+mNC?=
 =?iso-8859-1?Q?6h0fG+P9b97qkYAEyfxNzbPBnYgn04jSw/oMjN49UuFOGMIC8WL/OzCD1S?=
 =?iso-8859-1?Q?xYSItDcoMTnWUWghRiiOqu7jeATeGQ41wKWA9TZUlJnkZDLTULhXwmg6sr?=
 =?iso-8859-1?Q?w4AZ+VO1W1/5pNk1QoKyNwrwSAtLpvvO3LWWmVk3Ff4/SGEzO4KEF1oxJ8?=
 =?iso-8859-1?Q?fZGNzXb+fpKTHcJ2pRcdJ//AZriY5GGdbjUoGN/ogUZSvBrEZdZMJuKXVN?=
 =?iso-8859-1?Q?ABPW29t4z1Xxs7CyaPibqmQMWZSaH9tOoz0XyEnTM8jUmx5F7iYU/A4Kiq?=
 =?iso-8859-1?Q?6/ouz9eB1hsrEyEmi7/wQJjjEXjlIWGcbbnE3g+VF2HsDKGsqY2SbUNo0R?=
 =?iso-8859-1?Q?Xl2PZ2PuiZvsbYamV4R4JU+FfcJ/LNBjmczEJcg2C78zRRsLzx1dwV8FsU?=
 =?iso-8859-1?Q?i2To9vAZnlYWIPD8OT+EYvemNeoNB0IBeV0DldfarzAs5siwsIdnjF3kuF?=
 =?iso-8859-1?Q?gBKgbA24QGFF6swWzPuZIMXuMt8Hp6NRHLGr/uc5v7qKxc/eA3JvVfPPsv?=
 =?iso-8859-1?Q?uk/cSH2Xlh0qBU2miVFIWrEXQhx8Oj55p/hNijylvTfeVxzY8GCI6Ckd6h?=
 =?iso-8859-1?Q?+4cdhC8WlGOJGXU77ZCodtD5xt2CcK5ySSV4yKcfo1Bs5R6ykKiiHQOL4e?=
 =?iso-8859-1?Q?Eb5OUgEhyNJLpw676k6Hpv/4r8/pr/YEOrUHLYHyYWfiL3uM5KwZTypYRi?=
 =?iso-8859-1?Q?+IPBEyr9b3Zd2n6X553i8mpN15AEG0FJEh9cXO6OVJ/VoEJQemAqYTlITg?=
 =?iso-8859-1?Q?LBobqugI4ux12EVDzIar1zrqA7okBpgHTtzA2F027mkcQQWYVB0Xfirdqa?=
 =?iso-8859-1?Q?sd51n+FdTqAhW6L4ueYIPOkvy47/YOT09zLvfbgmB3ml3no5/28jKohNcP?=
 =?iso-8859-1?Q?OewcynrNoCAheJ5dR75LsblynGmufBuTN10/1wtsZeiLhZTB4i6ayc2RMS?=
 =?iso-8859-1?Q?mAkHyHtJSiZdlV4Kase8t3NMmlP5zulcPR6QcITsg/AAcQt5zx1fqXSmFN?=
 =?iso-8859-1?Q?/1+r5IP1NH4CkuQ12qwHi0rosyVv0MvlAaOYirj4d5PSstaT16g31sptG9?=
 =?iso-8859-1?Q?3EObTw37jNoXRmYw3Qx4i4yT+uEs2xar9nUY8TyiZptZZwvKN3PzysgdsA?=
 =?iso-8859-1?Q?tXO0ASgeOOM8EBU9Ymx2F9NqW7tYHvOOEuzuhgtSLIEN67f2GccO5RvXVQ?=
 =?iso-8859-1?Q?khYQ5rPGRTDtoy/Q8E7Tet8IisYkOJQQiQb315CAUDdGvegITjSkAi5KvP?=
 =?iso-8859-1?Q?uotgunOWKKgFEdo043Qz6wW0Yqg9YR7xAhoI2oPhjSpkFQuLU/Phv+BxF7?=
 =?iso-8859-1?Q?AEoaWmI0hzynh1hDS1Imenzp4lXdvG1CeUoLQc1fQ7N/y1NYt+GpqanLpq?=
 =?iso-8859-1?Q?1uy/x5VVqBax6NWu6vLqgILRIS8QlJaOJ1caovWMqC6iSrF3efjAeMfKo1?=
 =?iso-8859-1?Q?sFitfpap9zouQimfHwyig3V7whMUj8DRBgkMkYJsIOQ4phch5FwiC5muPN?=
 =?iso-8859-1?Q?1RjV7JHk9Ayyc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464d897d-132e-4194-1fe5-08db73f33377
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 14:07:38.0402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pE/lFQYU67N1/flO3PXuxarNNpGY0+oeyEmNL2Fx675FefVkNTgcD8w7VF6KVnU36utb6jyw3sy7GImMm6n6Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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

We found few warnings, will fix, and will resend the patch series.

Thanks,
Syed Saba Kareem

-----Original Message-----
From: Mark Brown <broonie@kernel.org>
Sent: Friday, June 23, 2023 4:01 AM
To: Saba Kareem, Syed <Syed.SabaKareem@amd.com>
Cc: alsa-devel@alsa-project.org; Mukunda, Vijendar <Vijendar.Mukunda@amd.co=
m>; Hiregoudar, Basavaraj <Basavaraj.Hiregoudar@amd.com>; Dommati, Sunil-ku=
mar <Sunil-kumar.Dommati@amd.com>; Reddy, V sujith kumar <Vsujithkumar.Redd=
y@amd.com>; Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela <perex@per=
ex.cz>; Takashi Iwai <tiwai@suse.com>; Nicolas Ferre <nicolas.ferre@microch=
ip.com>; Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; Prasad, Prasa=
d <venkataprasad.potturu@amd.com>; Ajit Kumar Pandey <AjitKumar.Pandey@amd.=
com>; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] ASoC: amd: acp: add acp i2s master clock generat=
ion for rembrandt platform

On Thu, Jun 22, 2023 at 08:53:44PM +0530, Syed Saba Kareem wrote:
> Add acp i2s master clock generation logic for rembrandt platform.

This doesn't apply against current code, please check and resend.
