Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A1740E43
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjF1KIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:08:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37349 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjF1KEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687946645; x=1719482645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0k6ZN067Vl6J9eTBSA3WucNKHXSB4sYJ2yl3qr9XfpM=;
  b=PrzcotjmnZPij2iH8CIBy9RpQRutSugMkhznPaYiTtisohJfx3YkT++T
   TvLvJapjfIPzTrFKd875GPvT5YC3GON9E9LBosHS28LmRdStKuL8Ggj+O
   013FGrEOF/eBnuA9hHwhTdxARVg0rwxZN5QJmH6nAgmfLEdh5O2KzzpND
   UDkjczhZ2No/yuKdMyiz89sh/p9VprCeFrxgsLoac88U5uUAKpJp0MY1f
   fhp8G3LsbMy0dBylHBXoHxoUv6mQDXJuObfcUayAw1HHX3tTxqz718mq7
   XwMDM3YJAEDrLRFyJchEFHthm/uaoVmVPg9ZH9Fzu1kd01wGlNRqxMmIK
   g==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684771200"; 
   d="scan'208";a="235121591"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 18:04:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHb7lZQ9LMEmjD8etH5ZWHu32mIEls9oyHIxPal8mmZ1pkPbpzLwuWFUjHjZnSr+7NXw6nCjrcPAPWEEZlD3litOrSijpuuWRcDf5dLUqp7GAm8ZPGxlQOlDmfyVSYDNOfsfj7f+gVOCobxmwHltAUHSX1aEXle/3pV1eliLk8M2rrhFn+C5ffTEE2xeMN2Z/81ty/PtQGzBwBnPFyd1DLWuvOwfDYcWOLf6py/+sszIi8TJ28WvIGFHFCeKDCOOIOw8B22o72wC4S/o1vwnllJYazJpal6h4L3DvwLN3vIzBPq9z30PNTf3obI+5QEGD4NO64Hk+QKEQS5pMeBz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgskH0X/01Ngt3hD6LaXFoQ9t+/9z5EHjv0s+TYho28=;
 b=Gu0y8bNMRH6feIvadwGLin7uRKFD6Bk5y/JehcOxvPk4HgS+wo32T2pmzwo+2jByOcMCflmiZJG8vOxG2J9BLnRZURTmoss7GkXo8wnvLrro9/9fpuMe30jaX+GEWPU6k7Gy3rfmnmacBtr+OUvfclf86AplpCE24GpJ0+jOoYKL683q3404IDDIgDxrCzbTnm4p06BvPDUU0ycYfa9ZkF/HcYAVl0TGCsvQEmD95Zz7Hv9Dt/91R+cQ4QNsk3n6lN64+onvRoLklUnOJ0+Or0r3s6M0J4WCODTTdEms9sg0qxYGUKwXgO9pl1azvaQsIzbScbt+1TCw3RRTTN04tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgskH0X/01Ngt3hD6LaXFoQ9t+/9z5EHjv0s+TYho28=;
 b=QgfvaqekYW8lVMXOO67WMHt/K3QVwaEDSxSc4wTiJJTTMGMos+Mc5rjWJ8mEQaGrAD2jc0dEXNrCDmN5bzNjX41xJNliI/4IeWnKQi3xB+xy64yCEayUj09LQToS1dUGlLijdy3cb0Dk0k/VJQ7PtOgoOWRAxsDV7cPdAClvuIM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7161.namprd04.prod.outlook.com (2603:10b6:806:e6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 10:04:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 10:04:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Thread-Topic: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Thread-Index: AQHZqOFVgY2Gv0FVkEOFz0D9X2tsfq+fvIyAgABBaQA=
Date:   Wed, 28 Jun 2023 10:04:01 +0000
Message-ID: <c6x53xzjqlmhvxpvrlhkuoclzslcogonznypuqlowcegygemyb@754b3ynn5xfu>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <oyhlgbqq6pjwln5ly47rt5iyjtai4jeepkascfaskn2z7nu3ks@te7yrwbcpsmi>
 <ygfgqglmntpqiopzq44aqegehnlroarteqjtmih7mulan4oukv@jmtupz2jnafv>
In-Reply-To: <ygfgqglmntpqiopzq44aqegehnlroarteqjtmih7mulan4oukv@jmtupz2jnafv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7161:EE_
x-ms-office365-filtering-correlation-id: 3e26fd5c-16b4-4c16-26d0-08db77beffa9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjhUsmL6lmXmDOJq/WjGiygvir7qxxU5tLVlufbFsUcvdLKU0qbRyrnnJ/u07JHhYB6qRWJLlsum9yNyWyVcDFdXO6HanY27y1hAr0p4xgbBtVgjVGxKKFA5KxGdvm2d2UL3WGQm1yXC5iF+blXo2v9Py+jzujfkBLGRRaADiuRqoFX3X7Tul3MNODMaCzxI1g2vBzfVrd4tUSld9W7MrAGvfP+8WrkGBWqLwp3iQaZ+5lAyxPI1+7seKPW1GWSeDsN0Hbf3zJe7BeELtzlOB9Nq9LA/6nYXroYjRGeTyr76EmcXKhbk88Rzz299z7/GKcnmuU32KPh9JYsbX4XWNC1x77aStKOcHbs2GPTAA9zoouE7vJkPbQr9bB8mqmDVGOr22bQlOrY+plN1EQrDnAJew+u0fX9DJjEWRVwdTfwWIvCONVW4UdN40gLEQQbE03jfBvzBuwOFpumSGy30PA8DZGqupybZRuj+3hyRcj9BHyZ1v31onM+VbyeoBcvNc4QyDfQvJbiSNlsQ7EQm1zXj3f2qOtrj4DsConO22HCLSlDjUmy7tejotx2n7YDcw7NJ5KUkW27wB9Tzn64CFDOMH96VDxQLmLufP2vZfcdXWDAJOK5APLrcXzPpA5jZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(478600001)(82960400001)(122000001)(38100700002)(38070700005)(86362001)(9686003)(76116006)(54906003)(6486002)(71200400001)(33716001)(8936002)(64756008)(66946007)(316002)(8676002)(91956017)(66556008)(4326008)(6916009)(26005)(186003)(6512007)(6506007)(66446008)(41300700001)(66476007)(5660300002)(2906002)(44832011)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K6PeacbKQKdaxLQPcIPttSHVZ9j2T16O0iJdK/Nz0/ywngj9XtX8Tz4lA9lu?=
 =?us-ascii?Q?OVxOKYsMRM1f8QoxZBJt25tYu0wtUptfftkeQ2nFGpq1mQPJNS3Ar2Vbc2zC?=
 =?us-ascii?Q?5XHa7hhgweKYR8B0mvYf7NyglMQ1U+MgLLNMlcXqupGc2kmMVCgljKG07iBj?=
 =?us-ascii?Q?PkujBw1SovotwzKsWSsTsXekNdw1srUEBNDD5fq14aCSEQEpbHl6f1qqsgeb?=
 =?us-ascii?Q?ZAuTcA4ppT9tZYj2VxKT0Xzqfqpt5WmyROkPtBCT7Z4AuLGrB7S2O7yuOzWI?=
 =?us-ascii?Q?EvLtbxSf2Rx1I+ufbAec6407DERoBTwj1Oi2UmDLPWG9h3F9CQh6wyJLCUKy?=
 =?us-ascii?Q?bNlz9LWglvVCvmd6kUG5qhGuyz9Xb7HVMWQu0ATt/IUtZXRsAY89PTO1OkaC?=
 =?us-ascii?Q?APkL8RFdU5q9+z5z91um5t+u+f6XsjuwGR1ZyOjnLVv6Ej3mU0d1G/V1UNTw?=
 =?us-ascii?Q?P0PZgLROuVaI6t6wQFXpny3AeuWS/dizaicfHkB/ux50ZJkl2KXbhrePVeL0?=
 =?us-ascii?Q?GATdclwf2WgGcmxnIlBCwUzPA55Eo1Je1L3secBQtsVR+lNO096KOjn9Zhga?=
 =?us-ascii?Q?9kz54DA9juIHSIaZfzci4z4+W1xlC5af6By04i3Ea9IqDbeIQWvIbbzPA9kQ?=
 =?us-ascii?Q?6Q+IWqLu1Guqp3gPgaclIvYnebGT23IW++jINnLmPsbmzOri7JaHL90nJaPq?=
 =?us-ascii?Q?Xnbb4OFs28At06AQtZ+2ymcv6Z12SdYspblEMzThFub+tqiNfi3Zob1bOCKA?=
 =?us-ascii?Q?jvWwEdBTztjhCfJeiUtEGB/mmxWLTuvvXHeXOyXf74KP2Ol2ZmQLJyL6Bofj?=
 =?us-ascii?Q?Pkb83kW1zDRmHN1Jf7PkzstnWDC1jPhSbAxtorOeoQia6m0teDvrbnOrJjQp?=
 =?us-ascii?Q?uJ3F/htElnGmGBdCWex/+86C9kAb56XqM8571uuanBlpJQp4j0KRONO/ZqnB?=
 =?us-ascii?Q?jzFXA9BaVtyfZLNLIzp7l6b0O06s/ziDH1O/iyAF606hZ/J0ZAAESVFywA0o?=
 =?us-ascii?Q?vs3AIUibdfemZ0yxdZtW+p+gOuG2zTUcA5OHmWGFrkhyzUN0xluTDLJCExTP?=
 =?us-ascii?Q?VhszPmWUzzxxrSI0B+p2Xk6/ogE0gbxm1P+FeAh3QUkiR1/+oKSf5HuTUwiK?=
 =?us-ascii?Q?AezOdzXBs0sAoE1XA8Ej43ms/a8gRgVmLlyQIvyDgSmHBmSmjiVkm8JJCF9W?=
 =?us-ascii?Q?l8qsCDAHC7OzFLvyYdOzAhqi0wayUT1u9GJcX+8CI+B30YI42WTVoYQQ5US8?=
 =?us-ascii?Q?yMR8dqJdj3VBC4DSBrRJEQlwKivG2APVxmBLfYnqKS7/AGJb8IWY9aMhmX+z?=
 =?us-ascii?Q?BdnYwUqcP45nQkX3+Hmyzbibt5tWmO/gZHPAzjoMvzn3EyiouCWFtdKXMxU5?=
 =?us-ascii?Q?HAjbr7H+HCQFePhLhd2Y1n9x6/LownDKJjjkLjbMmJZVcA0AeRB5Hsz+mcRm?=
 =?us-ascii?Q?joSoEEg03BHOWtG9NZHim8oylN4QpMJjHMjbvJ9NoiHRBTyMdX90BKL3cMJn?=
 =?us-ascii?Q?j4cmTjwAxixCLUfjwswwsTJaFtShYNIWimoGCf62+UKUiIDNQNmZ4TSeqdXH?=
 =?us-ascii?Q?INZcL9dV6DwGX0TqbiYMaGJy2htBN0vZQBQw/HmopMeYQGxSbDJAo3egA4AD?=
 =?us-ascii?Q?dYjcQc85+rcTyfRat9qzzQE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C0C118883942042AE9BDAACA8583EA8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2yFVYa/FUnAgUejso7iRdSBiWx8m4rLxognZkJvHdMWZqFrL8Wp0YmEh4L27?=
 =?us-ascii?Q?5uU/DPX9DzuDICKt5tQPbfR0vb37IFCkJi7efZxZYYid0tf5k27q/qguod7S?=
 =?us-ascii?Q?coyWbGZJvKYect0Lb5TJcTifsjENLO5t4jTOB83bqswA+zIaiBdnpK6TPcw3?=
 =?us-ascii?Q?u4UnQHexsjCRpyFxIZ+naXiiX/YvOfYFV8UroXrFqWFxniub9lk+pnE189M3?=
 =?us-ascii?Q?B3tHxZBf30W8khEuebuW6zo94lVPe630UuYrMMGiu4/J2iMC14X3YKFiWOI5?=
 =?us-ascii?Q?KoD4ahyHta8SE+vqSsnCCw1uAeXaOjS13Le/kKXSM0t0t7R8GMLrlfdH4HPV?=
 =?us-ascii?Q?tvaHdO5CMQU1W3z9Q2Q2R7TMgb7gOIJIoXHDHguNstA8M4VcDhgtPAXVKPyd?=
 =?us-ascii?Q?eHqBQnlIGMzEqpqiC5M71F4mOkeVg9sZ8YfYMFJsgwwR/2OYTaZP747xuV61?=
 =?us-ascii?Q?XMwihn/gliGdTiXVmwF0UR7v9r0nRjk4PYFUY/e7HBcvOqv9V7qadzKxN8mc?=
 =?us-ascii?Q?4WNJqjGRNpL8PmoyWMqNxxmj7XJmOLgz45Q2/qQ17s1tlXgo5RcSF4pDjtfM?=
 =?us-ascii?Q?w6zZjoavkZ8sgwBquUbG2xZIr/WHzctpS7MCO2UPjqDsaKB1puH1qDiGw5Fb?=
 =?us-ascii?Q?AEvXIBrBU1dkvNkxoBZfJsEHme3NiNlOH+4rFndWhaG/1/VQ7xz0tjuLQPA6?=
 =?us-ascii?Q?Jxu25KSTxreiNkqC+WHB0X3lxg3bPopfYg7wM5hGXS6dBxHGHSCaEi4m+1Wb?=
 =?us-ascii?Q?XLot/d0BWGwU5FARWOhQAPtH1tbsmPMdaYJIX251NvC6qsinyJ45TE8K+HgV?=
 =?us-ascii?Q?vHm3ackg1QgVq1KjyvQxWKsremTtLPwnFiLy/XEyvinjgw1p/5Kkja2eM4qs?=
 =?us-ascii?Q?NG/GtsJwO62R5Aa615kA8FccyRnk2c//K+cfZF8UOek5XP6qdBfnaivBDTJx?=
 =?us-ascii?Q?p8gXZKkXzulVon9cw23jqoAy7/HBxhLud7qKG64dW7IeeLsA/FYzm3i/coyy?=
 =?us-ascii?Q?nYBi?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e26fd5c-16b4-4c16-26d0-08db77beffa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 10:04:01.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hd/b71fWNKzh77Aw024mF4frtOjDqFzUQYeaN+qZqbJoFv0eDTIIrf189ILatCdlOqV8wtGSaRIKZJCjJQRP5j8Uln6S71WHVNK86Eo4yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2023 / 08:09, Daniel Wagner wrote:
> On Tue, Jun 27, 2023 at 10:22:53AM +0000, Shinichiro Kawasaki wrote:
> > On Jun 20, 2023 / 15:27, Daniel Wagner wrote:
> > > When the host has enabled the udev/systemd autoconnect services for t=
he
> > > fc transport it interacts with blktests and make tests break.
> > >=20
> > > nvme-cli learned to ignore connects attemps when using the
> > > --context command line option paired with a volatile configuration. T=
hus
> > > we can mark all the resources created by blktests and avoid any
> > > interaction with the systemd autoconnect scripts.
> >=20
> > This sounds a good idea. Question, is "--context" option of the nvme co=
mmand
> > mandatory to run nvme test with nvme_trtype=3Dfc?
>=20
> If nvme-cli is called without the '--context' option, the command will be
> executed. Though if '--context' is provided as option and there is a
> configuration which matches the connect parameters but doesn't match the =
context
> it will ignore the operation.
>=20
> The blktests tests expects that nothing behind it's back is fiddling on t=
he
> setup while it is running. So far udev didn't trigger for rdma/tcp but wi=
th fc
> it will.
>=20
> Thus, it's mandatory to use either the '--context' parameter or alternati=
vely
> disable the rule with
>=20
>   ln -s /etc/udev/rules.d/70-nvmf-autoconnect.rules /dev/null
>=20
> BTW, when the udev rule is active I observed crashes when running blktest=
s. So
> there is more to fix, though one thing at the time.
>=20
> > Or is it nice-to-have feature
> > depending on the test system OS? If it is mandatory, it's the better to=
 check
> > in _nvme_requires.
>=20
> Well, I didn't want to make this a hard requirement for all tests. I gues=
s we
> could make it for fc only if this is what you had in mind. The question s=
hould
> it only test for nvme-cli supporting --context or should it be really cle=
ver and
> test if the udev rule is also active (no idea how but I assume it is poss=
ible)?

Thanks for the explanations. It looks that the requirement check I suggeste=
d i
_nvme_requires will be will be too much. And I don't have good idea for the=
 udev
rule check either, so let's settle this change without the checks.=
