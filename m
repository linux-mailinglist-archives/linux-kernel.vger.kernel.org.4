Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438266AFEA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCHF5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCHF46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:56:58 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7129CBD2;
        Tue,  7 Mar 2023 21:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678255017; x=1709791017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WALLWyGKlHd02gYoPzD2/9KzLDSrSmx53rVtEaJGbGY=;
  b=UmFi2vstiKbdpIh0a+HkjsKyp4F8Ic8jMLfr6Mq6MppM/Tjmjr/fJDM0
   zPNpnf6SczrCdhl4e8f2sv5XKTDe5HR31S4ymGQzNNlZPWuLn1AoCQna1
   1a04CG+mF3eOrtqwSuT1jgDWPRdgirq0IEEoFzqn2Iq8T971SNU8qMjGF
   7Cxi5rYaScWMX2hSmUig9nJYOnLoStZJ1fzTccXqC4U2monhDsTEjgcO0
   4sj7iFCafrMyg+LAIKmnQX52hp2zpe2aeeriqS7xiiJSf6du1T9q6Xrkn
   VXAeD3ryrN45fzgeFA4sGK8AkLNOPebcqnA6QcpIo0yMkJTJ8QEbdCfBq
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="337074354"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 13:56:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuUblSP55GLTCzA6/nxDdjEJbJoqUzFHgXYcU0cNHPQ70W7dai8lTRWNuVRpGcqpewJjZOo3qCQJShe0mIb9QSYndjmQUPm7iG7tqWbH5v9PX3Oqey+YKRq5VxEGpkYSZLfcw3nvpyG4SvhWwUWx58dVw/ZHaSSLc+Zm7+OD8+G8ALk8Abq8R+SvdvEKdnrNUUf4JI6ekx+uaP6rj/GRwASWiKDXIoCzXrnbA/mELt0ORsQfB7NMZFu46bnFZsGdo+rRSYI85W0VYovzrvq8pAscVvWYAiiPMN50LZqIvveINfNzF0zpWA9tXXf5WAwiY+0Ri61lh7E48OGZbaW7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU7luRI2KbtRlGN03XpEXPGffl/RhAQLbgL1nCek2wM=;
 b=lp3KD+THMX3k7Kgppz7iA2hKhZUNxrC/L9BuB0wtuFed3q7A5o3GCN5eeJ9tgMURLyb3zgCG4stGWyJEpAlhZ0AWDZ1lXcS9XaYteL2wEOOLe66MJrp14v3cd1+PCh6Uh+eBvFnNVqRYRek0+Wbcz0TeuQRuRGsYthacvAyVt0PyUiCJCidp+dQr4te2X0sTo1FY+7o6Oj8HawbNMbJrn5hMCSp9OsU2SXAyZ1LH3laqhiRSlNn4XyezOPKy9MlPYzO4Apln0q2cwpNR8FPcJ5C2opzKBzZRO2jMLKp9DO7MBPcRpcLCpNSy6JeKq6f0WwQJKFwNCmiAeLYeWr3wvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU7luRI2KbtRlGN03XpEXPGffl/RhAQLbgL1nCek2wM=;
 b=jkOMLACPquEP+14ku/MWerK06l1Whww25euS+mWeAOLQSD8FwuNRo1MZ7KLgQr6mT/yAOTF5BYdTuBPy5fLYn0iFZyyJCGRYDYGWh/HDEzFiIDhdQin/LU4ArYeuo/yE87lFuh+I11E5lWY+tr5Og49xMIkm7MISguQj7XVL06A=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5657.namprd04.prod.outlook.com (2603:10b6:5:16b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Wed, 8 Mar 2023 05:56:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%9]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 05:56:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     "jack@suse.cz" <jack@suse.cz>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "glusvardi@posteo.net" <glusvardi@posteo.net>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "felicigb@gmail.com" <felicigb@gmail.com>,
        "inbox@emilianomaccaferri.com" <inbox@emilianomaccaferri.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH] block, bfq: fix uaf for 'stable_merge_bfqq'
Thread-Topic: [PATCH] block, bfq: fix uaf for 'stable_merge_bfqq'
Thread-Index: AQHZUWL5J4Loq78SFkKpVSpg5Wk4Qq7wYskA
Date:   Wed, 8 Mar 2023 05:56:52 +0000
Message-ID: <20230308055652.l3redb6gbb3pz3xp@shindev>
References: <4e6e1606-1d9e-9903-8a44-ccac58a1fe06@kernel.dk>
 <20230308023208.379465-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230308023208.379465-1-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB5657:EE_
x-ms-office365-filtering-correlation-id: c7c9eeb0-d306-477f-e765-08db1f99eaa2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnqtOYuC5Z+0ErZkkmFfcEon8WmmsC6yzCNWk9ld4kbAy/YB8HDtpp4HksdrY22bzU8BecFz6hRPr+kW4WAoBUfSb90rbfqnp5DneqcD6gNFpWfJZAp4pZ0gbmUlQsGhetxYtnsmRm9udV2GQJnXCqtBordP4DBc4a68aZwpBiDMYDpNuS38Rw69QAir8mrCt6u+hnYq4EKJ7X/h18svVsbDbxMDvKIJw/QbFAF6umB22Ori9qO/Xo+M3dt49NKajqIRT+JBW2JtC1KL9Z5cWcC3N8L9a0lyr21S8/ak1C1+dE76IGGAYTHiJllB6a34jt65kQqDt7DV10Ao+SttguaxDjlTQ/lWzufjMEBjh2Qc4THVnOX/CYLpJam1cJrfoF18SrMu5w1wNHmBv2ThhuXLQ5C9NejQhZpJvPDRFsE7rij7e0oiI10YG0QR6+b8cxYoRtiiLuJQIfVvt389tvLI8Q5reRQQxxq6R3OMvz4Kmi9lQnrftKbMMdu1biy4CUtGCJBf0HpFf6zUXoSYHqdcVmQa/5kwCQ7rKuMaU22xggoURakgG9+MHwYpudEVKHIjXVD5R5PrlqDf9ddE4I/5vS45ueanNQPbB5OtsHiaoYz870Z8SU3e6vdoDqjlhZ4Fw6Oi+mwcgymWnSe72VY2w90M6hY+QyfqUTlmMHY/fDVwHgJHyxkLmdDEorz0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(82960400001)(38070700005)(38100700002)(122000001)(44832011)(86362001)(7416002)(8936002)(2906002)(8676002)(4326008)(6916009)(5660300002)(64756008)(41300700001)(6506007)(66446008)(186003)(1076003)(6512007)(83380400001)(9686003)(91956017)(26005)(54906003)(316002)(66946007)(66476007)(76116006)(33716001)(71200400001)(966005)(6486002)(66556008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s5zb+pX2MLnqmK9M4LUmKEkVHg/68+6AHv/Ol7aRZdubXDfthSv4ysngH9IJ?=
 =?us-ascii?Q?qUNMTmsalt8Lk4A7V9OW7TLJCJC0r2sutl4FOzIuAcgu4EY8wpSg/Ti2ygPz?=
 =?us-ascii?Q?YYKijrcwFyutbyumK5xkB8sPbuJ9m6ONz52fZPUZ9XIx2OiHpjnO9yynQDvJ?=
 =?us-ascii?Q?UlnGAjtaavEN0bw/RMuZRb0W55kkpCtZ6Gtk0JUau/XXHFXw8nWpTdgHffqS?=
 =?us-ascii?Q?MnvOOzOaRho1LIKTNaJ7hdZ176ka4OhstnZ92wr0FfkNmuWn/Fy4dUJeu6Dx?=
 =?us-ascii?Q?2MgG0OQl627GzmvahSL1MFp0bPnrzB6lAmYsyk3acLuMtjhN6WJIyj9+wjFV?=
 =?us-ascii?Q?qfWEG4s7sCuP5U5Wg03fmwUE/DL92Nynp/9m6/T4Xycr6XltYLdlcr2eeg6n?=
 =?us-ascii?Q?oT6vZhPr2eojsaCpQ1oGINXELQzQlrGd2QcuaRJbd4JbCID98aINKHLocnFm?=
 =?us-ascii?Q?8qPWUas8GPLIj7ES+rF6DCOv50D4ZsskCb8hcc/FXcksqpQ2sWtHLihlSRpN?=
 =?us-ascii?Q?bM5nybNPvIETcDdV7v9749aMfh+Dufm3ajfMqJ8djC7c7NSAlfM8kb2nB6EJ?=
 =?us-ascii?Q?o8PFw1HPTy7EmUVrzC7VhsZb4qu9MkzvMZVfhpw7ma7zs2ZwGl4QPn/bqn33?=
 =?us-ascii?Q?bC6hmen4x1LB4T8B/nc4RhA2KWbtUb42Kf8I66lpk2l9qwTX/WCBXsgCpKDZ?=
 =?us-ascii?Q?fcAGYbQnjUo9trLOmYaQJKSh43Nyx1YU3Nux1JS1mEs+b1idL2xgDUghys1t?=
 =?us-ascii?Q?jh011CmFumA7+ZifFE/ehwMdV9y+IrsbhJjriwVOckBb598nzmxkRV3YeZM/?=
 =?us-ascii?Q?NOcZ/NUJo+E9zpLJjP2dim3VJ/jiNz5GZfuGuC7O8DyqrxzInu6C1TOYkb38?=
 =?us-ascii?Q?ZlAD/07yB1OjaqNjOrjs/nQwV23tSwtxeF0GT2PyYzRKs8boteuMVRPI0/X9?=
 =?us-ascii?Q?lJUQNSCViiiXj0ipR92P51ByM/sFfRSzYo6ZiCA9HiVe6E2mT5gTMWuycDug?=
 =?us-ascii?Q?+fSDlp38JL7ddSUHlIetiXqkelGTOByiaFt/V7res5msz+NfBNQrz2niC4BT?=
 =?us-ascii?Q?qN00mv8nFnpLY5CJ0bndOrs6rzC0yX6FUDL5mhc5zJFcUxxYeDhPWE0WGzf6?=
 =?us-ascii?Q?5MKMyB+Iu/9eZlc3Pd2WDlbGftU1g5k0GVJrV50CzAd1GbcpxNgFP2zd0pL3?=
 =?us-ascii?Q?b9yB36OD9GgoYPvaxcfraiwBcI9kb/xRex8YJQZ+EbFruyyd4GK4eUHoPmPf?=
 =?us-ascii?Q?ZTkdDyoyKn4dcHU0NIfGmSCdPoQccrlkzRwN7/Zm4slgRTDHV0qrq2Jkmd7V?=
 =?us-ascii?Q?+Xc+Q38JSOCIc66SGGVYWnBkFNe8Ivc6s1g2AXDBrPrXvFiLJg8YfUrv2214?=
 =?us-ascii?Q?MAwh65OgWpyT4E5UOUCTTpOC2cW2E7I5xVNKegHHehFRLTgUbETy+zsukF7A?=
 =?us-ascii?Q?78F7L9qF0DylaAlb9egiSIGIJHWw93T0gDsA9nKZ1kvKpY/3L/oA18stckRE?=
 =?us-ascii?Q?Xo4fA4Ur9JK099Rkivt1+skbngsdwrpjc4f6TbLP2KZzPmvPAcIRfCmPuiki?=
 =?us-ascii?Q?bvlN2oQRRTtDapxdI9191+Fn38aQVhzToks83UA/nHws9aFrMemycyBnoJAg?=
 =?us-ascii?Q?k1MZSce/G3k+0tnk3AR3jlw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEDAB37102D54B47921CFF76923A3D18@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?L6iPAFX7tlHFzNmc40cN8bb9TObFAsVWv7sVNeWVTp2UuOl7T3JpVrkPSyEB?=
 =?us-ascii?Q?LHNniFTdQac6E8qZ43e3EbXHbFE1nGJMZgZ9hwmAwovxOGrTHZxFtGt+JpMa?=
 =?us-ascii?Q?Bly8W+6DfmeESb8sGLGYD2ZYaf7xja6OpcGpJnaEJQdLZEYuj/5CKIGpgd3B?=
 =?us-ascii?Q?f7S8uOPctoBoRHGsXWfSQgxlApaVt0pRQno+Spl6xp9G9igTAnQujUiwC0C0?=
 =?us-ascii?Q?3DX8pe/00zghcwNNs5j+hWFpDDAo4BqszUZQ1NdHbb14x3iKb/D7Iml1L6bl?=
 =?us-ascii?Q?9sK/HnmRQfUPyhC5hrLbjT+iWvqhKHGg+e8+dKNao53P94B2RrMXzYl6l2/l?=
 =?us-ascii?Q?UaA7tmJukhHBXshAkoUlNpNTuY2lUHeTkplejbhpQbTN0GbOCOoDjIdRazDl?=
 =?us-ascii?Q?bTnYJkgALfInzrVPzyOYcUec9fbCiQXDPVwyOtHtY7VXWyw+XCNQO9Xf1WOU?=
 =?us-ascii?Q?cpDQlxePCtU2V45BZUoaCjarDaGioyv9mn8eiYsmNcqiN1UFZisQkuC3fRAg?=
 =?us-ascii?Q?CibRIfdtG7NGh2kEtMdzyS80ilGcorQg7qrUKiLcxZSYmrpdcW+VOAfuLWZM?=
 =?us-ascii?Q?SbG+PlbE9n7+lznK9+bQgFI9IzVswABhDoHkK6C/BETwrOfuLWv/l4k+dFG+?=
 =?us-ascii?Q?hTI7hY1D86lj1tOxtbpuH9n3Ey2XzfsMdyRXt8Xr51IUu0FaeSZ7qcqinBkG?=
 =?us-ascii?Q?qNuJw6LB6WCc/4htx6eVO/BY6xjfcvUqL0lRfM4bsF/SUyCk1AGBdGd/28mY?=
 =?us-ascii?Q?cPhMqVXjpFFBX3+ulnwTfUyH/+l2plTQLqcZFakd7mpyWGHSOjQS2134Fl/T?=
 =?us-ascii?Q?RVtC3ea0Zb/TBsYYZvvqFUg9e/8juQrlY8C6TLvRtDuLLp5meqqnf2qwbX6+?=
 =?us-ascii?Q?xe+dObwqfK4ZSYPJpexcqZpYwuNe2H82Rhc4/1dKdXbAcOqy+n1XKM0l7J/I?=
 =?us-ascii?Q?hZG+pbNi66RD4ww0CmYgzy43Ogis8hLSUV0axxChIqV/h/gqKpPaCmhy3+mQ?=
 =?us-ascii?Q?5Hv/jbgBJzJR89uE+Fla7LgnNLcCJedc7e/JaABowDMgOBw=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c9eeb0-d306-477f-e765-08db1f99eaa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 05:56:52.9591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGWMyLng6boAQqqpGuEV6Iwy4nxxQ6F1fCRv/kLuLp0sEtbJbJcq24lxFUAi/1p2W1YaqtAsSnJl5kpnUg/JWhovLak0r71OCdaSx1VGYE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5657
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 08, 2023 / 10:32, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> Before commit fd571df0ac5b ("block, bfq: turn bfqq_data into an array
> in bfq_io_cq"), process reference is read before bfq_put_stable_ref(),
> and it's safe if bfq_put_stable_ref() put the last reference, because
> process reference will be 0 and 'stable_merge_bfqq' won't be accessed
> in this case. However, the commit changed the order and  will cause
> uaf for 'stable_merge_bfqq'.
>=20
> In order to emphasize that bfq_put_stable_ref() can drop the last
> reference, fix the problem by moving bfq_put_stable_ref() to the end of
> bfq_setup_stable_merge().
>=20
> Fixes: fd571df0ac5b ("block, bfq: turn bfqq_data into an array in bfq_io_=
cq")
> Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Link: https://lore.kernel.org/linux-block/20230307071448.rzihxbm4jhbf5krj=
@shindev/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-iosched.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 8a8d4441519c..d9ed3108c17a 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2854,11 +2854,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, str=
uct bfq_queue *bfqq,
>  {
>  	int proc_ref =3D min(bfqq_process_refs(bfqq),
>  			   bfqq_process_refs(stable_merge_bfqq));
> -	struct bfq_queue *new_bfqq;
> +	struct bfq_queue *new_bfqq =3D NULL;
> =20
> -	if (idling_boosts_thr_without_issues(bfqd, bfqq) ||
> -	    proc_ref =3D=3D 0)
> -		return NULL;
> +	bfqq_data->stable_merge_bfqq =3D NULL;
> +	if (idling_boosts_thr_without_issues(bfqd, bfqq) || proc_ref =3D=3D 0)
> +		goto out;
> =20
>  	/* next function will take at least one ref */
>  	new_bfqq =3D bfq_setup_merge(bfqq, stable_merge_bfqq);
> @@ -2873,6 +2873,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, stru=
ct bfq_queue *bfqq,
>  			new_bfqq_data->stably_merged =3D true;
>  		}
>  	}
> +
> +out:
> +	/* deschedule stable merge, because done or aborted here */
> +	bfq_put_stable_ref(stable_merge_bfqq);
> +
>  	return new_bfqq;
>  }
> =20
> @@ -2933,11 +2938,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct=
 bfq_queue *bfqq,
>  			struct bfq_queue *stable_merge_bfqq =3D
>  				bfqq_data->stable_merge_bfqq;

Nit: I suggest to remove the local variable above. The two references to it
below are removed, and the argument of bfq_setup_stable_merge() can be repl=
aced
with bfqq_data->stable_merge_bfqq.

> =20
> -			/* deschedule stable merge, because done or aborted here */
> -			bfq_put_stable_ref(stable_merge_bfqq);
> -
> -			bfqq_data->stable_merge_bfqq =3D NULL;
> -
>  			return bfq_setup_stable_merge(bfqd, bfqq,
>  						      stable_merge_bfqq,
>  						      bfqq_data);
> --=20
> 2.31.1
>=20

--=20
Shin'ichiro Kawasaki=
