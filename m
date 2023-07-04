Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF127467E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGDDZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGDDZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:25:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BDE183;
        Mon,  3 Jul 2023 20:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq2gQ0f3DFBO4HDOs1rajXFtGvA7t6zBMh18cXQ05D0HHRidRZPPRYrcgNL+zlkXtmf60rQ6QECxGdWUOmwS7zD/e1nw4OZ6lgpVbJyXCmsNuIGajsK6q0hOFBp4Zb0ieiJmnkwuOQ8p8O+62nTXcu1uLSkzbJHs55/hmcmXM81K3D/CmKJ69L9MVFx02yBtjZa2d/n+pwDDLIlO4LzeDb/oFKrqKTccqIQiaZotLh5VzQpWiTLXZW4+8WTQRfFhLqRA7GdKNCLnfrhnQdJfXw7+OLSM+Qgg2khN8UTvDRC/1Afsu9ktw1LUL0id3VIvGmwAbCKvOTXk1LrFN5OoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEuyFCmtRp4o8Oz3hkV+YpvsLR3KGMFpk63IIbdzDhs=;
 b=AjYfuT6vd65JC1N8IFUXf4EA1kyD8T5aomQLHwIXw8ULr4tvlMsdRxrLely5ABP1Qnj5jrTPiurFJA9fWeRkODsAE975xNRspGLFMqTwhYnAHMI68Yex3hHE4oRh7giTHPTytRfFUdPVgKhodIzuxpk89MuFPbjRSCdc9aiRoVuZ0xBs7agqMHASduM8WSqX9K22ImqQgK2eip0fAoQ4QTxr+0aBsv8oYcc79Os0YIe5SF0HQ0rdA9tn65OuYixkQMGgYzyIc09zThIvlF7M+2L6bj+lvJUx//xapMQpqhrRtFfEpWReN4dSnEYzXPzUwLHzJkdF3IZ+xj7OILZqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEuyFCmtRp4o8Oz3hkV+YpvsLR3KGMFpk63IIbdzDhs=;
 b=DW92YWKa1FyI1+t/2qejq6Pw3SNFQsn9zDwFfjWpyf381ZUR3U/62E6ocSQkUJ3YScWuGyGrDcQrWwr7oCquGlonAT46ml0v0oM5Rl5FRtOOl8ajpTL7/X3gaYMGvIjrCBsI49Yr5jl+t72in+Aznz7RyU29eanwkF+oPrBx2/4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 03:25:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 03:25:23 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mdaenzer@redhat.com" <mdaenzer@redhat.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "jingyuwang_vip@163.com" <jingyuwang_vip@163.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "bellosilicio@gmail.com" <bellosilicio@gmail.com>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "jsg@jsg.id.au" <jsg@jsg.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH V5 1/9] drivers core: Add support for Wifi band RF
 mitigations
Thread-Topic: [PATCH V5 1/9] drivers core: Add support for Wifi band RF
 mitigations
Thread-Index: AQHZqz5nCvlP5HKi7kqHZhT1UyZB3K+jjMqAgACBvoCABOkkMA==
Date:   Tue, 4 Jul 2023 03:25:23 +0000
Message-ID: <DM6PR12MB2619CD9C8583B4A15AE18968E42EA@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230630103240.1557100-1-evan.quan@amd.com>
 <20230630103240.1557100-2-evan.quan@amd.com>
 <3e095621-d7dc-9069-45dc-498c8f3bb4f4@amd.com>
 <0f18f4bf-dc38-49e3-a484-ca2456549f0b@lunn.ch>
In-Reply-To: <0f18f4bf-dc38-49e3-a484-ca2456549f0b@lunn.ch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cdb73bd8-6a25-4fab-8c8f-81e611dcbe1e;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-04T03:24:45Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH3PR12MB7500:EE_
x-ms-office365-filtering-correlation-id: de72d0a9-23a3-4814-c641-08db7c3e4dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bACuQxgddWYrp2Ks2t/Ky/U7xaEqAxXeR6HU9/XFrjptAu0rY8tT4dA8K2C7O5+mVsloinuCd+kSUAW/Er7RDpnQd8a6bX1RJkTbkQPS4OOpRG9OlctSXxARv92mf8p4dtHVoXeNK+jziC2ODkj+hQWf7uu4TWhwg3vRu/uQEo2ch0mw4+EXI47V1PJgO1+qTm3+8f0Boxc0Dsg11+HcFsPtmTS+5mRh33R88thrgKjjANypT8DHJpHnA2FZwCvx7xqw/PWwOWfeEdQmNdhmiM548rpD6fsFy3LNQPsyz4FTDG/+FoZ/pxPu6U//9dcCMIKux9xjmBMIynRVRGixCqJrzqszrM663WMHwBgQJv/1uAcCX4gEz+X+oWm1Z+5n5TVSbSySMaJsn/4JbrlS+8tU0/XyINiXIJ4bAdR/79IHwrJJMCi9VwvCDxne+YM7bCj0DHWDbdh7peroFH5uvJS2gji0tLCQVYZw2K9VeUuA6d2NnZd3BtLPxsFoc3AxAraEqLQS23IjS1U4IjYLHqfohl+zGk6Tbh4W/KWIHVPhe54ckR50gx5XhySTFtGh0IRkb7JK+CicIqu6VGqLv4xVLVsctQqGVYyUl81X53aH2sxERErCnSSiVUbt3uVg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(26005)(478600001)(9686003)(71200400001)(6506007)(86362001)(186003)(38100700002)(54906003)(66476007)(64756008)(6636002)(66556008)(4326008)(66946007)(66446008)(83380400001)(110136005)(7696005)(53546011)(76116006)(316002)(122000001)(5660300002)(8676002)(8936002)(52536014)(7416002)(38070700005)(41300700001)(2906002)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KoRaAp3qhoEL3HTbjsQLPIN9O68bqhpYNEmrCZel0vIj6a/Zil+fvdcYgOG9?=
 =?us-ascii?Q?X8BjcMZKsUmHHv85rkZS8QEo8+QdrcreoYp1VjLxaKHD57aKjWsFZTv3s7F5?=
 =?us-ascii?Q?Yfbs6AcvbnfmdOM2sT9g7F3LAvRZQlqQ+nWCbaPCowV2y0l2cSywcKYsjfvo?=
 =?us-ascii?Q?5+OftBVK32iaHXqKASr6OZXxkKDTaMeQitHuLH6Z93DRok4u/1DM/hCqTdU+?=
 =?us-ascii?Q?+jQ9IsDSp+Lhz5bowyxOXb4morP1utMyYj6l65DujcuAAszBIkVCgkpLeuGi?=
 =?us-ascii?Q?BJxT9Kp3GEv6l+zYcF2v6jJyRz4TIfCPwYCScyTe78jHb6uPo66nwGVm2oUX?=
 =?us-ascii?Q?uG24yHB6Zp/kYlfVsuP6yL4VbeSL7i/KVV3VKRZM4xoWwiwRsCbeHS4gMimi?=
 =?us-ascii?Q?ASJbsnLyE6fJEognVraTt7q7cbB2bl7yvqVECbnzrS9riKFLoe1G6TpaiKqR?=
 =?us-ascii?Q?gKzAu/zq7p6j1GhKqQOMgrD8ujydgZc5BanStMsYDeyXPt72OxCxHx3EG/bF?=
 =?us-ascii?Q?GvbNqIh1bqklytfZr/OJ94n005CHiSrKY0VQVLKB7+6mBRQRVwqJu53omV++?=
 =?us-ascii?Q?BEoXM5oorHp4sKF/EO2HUyNXpfNlLsiiRmF9Cnn5+sCcFBF8zBKsKa1u9U21?=
 =?us-ascii?Q?eVVQMJFvVTYhCgmnDEOOb2KhKt/VJDxyt9PlGrCdIspSbQgFm3/E4FM6D03u?=
 =?us-ascii?Q?K6qDfG7KsCU5esfiZBskuBNF6ks29OOouA7jl89XineG4rFBHbJCMFF1oe4I?=
 =?us-ascii?Q?k8uq0g42btsttEQbabOBDjNbFX2BdFvYqxQJVMgotWG8LOyNSVSGqL4Xs1HF?=
 =?us-ascii?Q?8MyKbT5w7ZlNRISBkbJmS0YCV6zLqwTk0S5Xlh3ty6wvmuXTTscsHYsTQRmp?=
 =?us-ascii?Q?763cP6gHGHJeOB4HzDrEDqaN4GSWxvqsBoGS97bhW/prmtTWkpcw5TT3GsOs?=
 =?us-ascii?Q?HNm/8bReI+LqdCY9Wd06EbB/b221gsLXMJbd3I5emGeU8EyTA/Fad4v6cDM+?=
 =?us-ascii?Q?b3l+aVLtS+DPBcN4YNd+Ercs5xFvBAr1cpsY5Sd3dQLXO/g5qcvToXmuZwwC?=
 =?us-ascii?Q?NfpdyJkvAEZK4tgv2pOciko/2FQ+keBojI8ixTHUKgGHH1w42IM2yy3n/G09?=
 =?us-ascii?Q?ixXExsj6GiN2Qa0GP1x1wsKooiKcOPPhABWY9bwQgU4/eQzvFfmznAJuFi7f?=
 =?us-ascii?Q?v1o/lYefzxQbfkNYZrIGTmni0n7jc/x3cN6DVsIQsHMjUicymxM2qeMakTT6?=
 =?us-ascii?Q?1FpKhMQDzQFiVAEI6Wsw9gxGOAJPYusxCPHjYD0bwVh9GdJJb7Nv0Csn9jk0?=
 =?us-ascii?Q?QXv9WIC1pqq3skn6QZmeaGOheMnBg5crryJ2WM5dvKU60FyZnne/dJRtcmPJ?=
 =?us-ascii?Q?YmivQ08Je3qUe7DbW4PCUOEBRhTeNMpVHN+UX2x2J4hE0+P7BbtxnwzWS4Wf?=
 =?us-ascii?Q?QHOIhaPuYSwb3oRU37i4mzp6jfd+tcfHkwYYld22TvotnhGecLa+E8eze19F?=
 =?us-ascii?Q?wukihKimhWp9luRjSENwNvCckLpuOWhJjhSCjuCAjRQYSXZnCzTVcp7z9N/e?=
 =?us-ascii?Q?bj8ZljMztFqbB3Hc9RY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de72d0a9-23a3-4814-c641-08db7c3e4dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 03:25:23.8076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cE7dSESDAtG7JcTRNxEEV0Z1sbRrTCW9II2+rBZs7EoQRFaKCJ3uTV4xtXMRHSCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
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
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, July 1, 2023 8:25 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Quan, Evan <Evan.Quan@amd.com>; rafael@kernel.org; lenb@kernel.org;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> airlied@gmail.com; daniel@ffwll.ch; johannes@sipsolutions.net;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; mdaenzer@redhat.com;
> maarten.lankhorst@linux.intel.com; tzimmermann@suse.de;
> hdegoede@redhat.com; jingyuwang_vip@163.com; Lazar, Lijo
> <Lijo.Lazar@amd.com>; jim.cromie@gmail.com; bellosilicio@gmail.com;
> andrealmeid@igalia.com; trix@redhat.com; jsg@jsg.id.au; arnd@arndb.de;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; amd-
> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> wireless@vger.kernel.org; netdev@vger.kernel.org
> Subject: Re: [PATCH V5 1/9] drivers core: Add support for Wifi band RF
> mitigations
>
> > Right now there are stubs for non CONFIG_WBRF as well as other patches
> > are using #ifdef CONFIG_WBRF or having their own stubs.  Like mac80211
> > patch looks for #ifdef CONFIG_WBRF.
> >
> > I think we should pick one or the other.
> >
> > Having other subsystems #ifdef CONFIG_WBRF will make the series easier
> > to land through multiple trees; so I have a slight leaning in that dire=
ction.
>
> #ifdef in C files is generally not liked because it makes build testing h=
arder.
> There are more permutations to build. It is better to use
>
> if (IS_ENABLED(CONFIG_WBTR)) {
> }
>
> so that the code is compiled, and them throw away because
> IS_ENABLED(CONFIG_WBTR) evaluates to false.
>
> However, if the stubs are done correctly, the driver should not care. I d=
oubt
> this is used in any sort of hot path where every instruction counts.
OK, will update as suggested.

Evan
>
>       Andrew
