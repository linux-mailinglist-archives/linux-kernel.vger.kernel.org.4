Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B216A4ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjB0Wm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjB0WmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:42:14 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066C2B61B;
        Mon, 27 Feb 2023 14:40:42 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RKLWRt015174;
        Mon, 27 Feb 2023 17:38:01 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3p10jyhdvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 17:38:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOEDcTLcTLW5G+RGW0hOUt/aXJ8lCb/az3no2rYDAMn+ynz8tAdQsZvPQgc+mGeWucVgpvfftjg2FnQAhWS9w/d//5/nCF1Z6A3ypNHAeqm1/5652BKkaXCrqw9FBDalFEVF2xXfek6oD0KgC3w7waHz91o2vJLVU1CN1qgKledzR403cqVWk209baGD5WX0AmIoJf8oJRVhGc+ty1crO7ZjMy6dy46OaqCtsEPyytxJhXIGxCfJJ4zwFL47kfYpATWBt7sA+y9OAVIPPLGmj9OVIEMjOijxchdPrfEqfWiiJzs0wKQnUhqwhKQ0tyPIvYFNgn3/n+/sC9cJz9tN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KhPhmSSn6aqGGygSlHcIkzBgPD8K5TtD96aMcaatsg=;
 b=cnGhybRw4gszbUc1VBNdGVNJaCJW6kewjsltXZJ3BwDuoGT4AuJKo1ln1dy6ahCMWqM038UhLVVGGAycHWsYw5evvPt5aPvj0PRPzxFqNInqbs0hzd/v1vu8OgvRxQNA0l0voqPwytsizXd+vriR1lBsrtvqji1LTBMeFsjhOnR8HhypMHX3/jpGbpmCe5cj9/f+t45LpsnqtvzjBqRkNPEUox+mIeQvcUuKvA/R/hXt5xP3uMi/gv5rbqycxFLBdj7gMKs4hbvKFd2l+MpqtFf/HfpdWTTKkeWYvqqSlTLA1Z96ZQLGjHMLvtBXYmtCemsFO1lompCygCu8fGjtGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KhPhmSSn6aqGGygSlHcIkzBgPD8K5TtD96aMcaatsg=;
 b=9y5RntNiDL5XlxoXv/Ua8nysCm0kiGsOPxA1bUSjqUDYRPSG4BOxz7dVUw9Dbvv0go7qbOkFCkP+eyZwzduuXSUofkiHxCEw6DY1iMqVtYNk6JDYeeXpbDFvyl6NVIHNzj8uo1w0PGfAyJQkPX+ZYTup7oGHqLPEY9C2EfOao5o=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by PH0PR03MB5800.namprd03.prod.outlook.com (2603:10b6:510:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 22:37:58 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::1fda:19e9:6dcd:3899]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::1fda:19e9:6dcd:3899%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 22:37:58 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     =?Windows-1252?Q?=93Ryan?= <ryan.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>,
        "wangweidong.a@awinic.com" <wangweidong.a@awinic.com>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
Thread-Topic: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
Thread-Index: AQHZR+yFEci7+1f3Mki1DtKfFrzJwq7i7XCAgAApzQCAAAjpgIAABxAAgAA0YWA=
Date:   Mon, 27 Feb 2023 22:37:58 +0000
Message-ID: <SJ0PR03MB66814E588528C771D7BEAB3D8AAF9@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
 <0fb47fe7-719b-0773-fc14-3d62d7d33619@linux.intel.com>
 <Y/zsqjOWFKrpDtl8@sirena.org.uk>
 <d95d15f3-34c3-32df-1a50-0ebce35bf81f@linux.intel.com>
 <Y/z6EB+0beX2Ji2h@sirena.org.uk>
In-Reply-To: <Y/z6EB+0beX2Ji2h@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?Windows-1252?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccmxlZTEz?=
 =?Windows-1252?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02?=
 =?Windows-1252?Q?Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNjEyMTU4ODMtYjZlZi0xMWVkLWJh?=
 =?Windows-1252?Q?YWYtNzAxYWI4MDdlZGI5XGFtZS10ZXN0XDYxMjE1ODg0LWI2ZWYtMTFl?=
 =?Windows-1252?Q?ZC1iYWFmLTcwMWFiODA3ZWRiOWJvZHkudHh0IiBzej0iNDA3NiIgdD0i?=
 =?Windows-1252?Q?MTMzMjIwMTEwNzcyOTI0NjEzIiBoPSJuNzJpRzREaHBQdHpmUSs3L0Rs?=
 =?Windows-1252?Q?bkZzZW15djQ9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVS?=
 =?Windows-1252?Q?SFUxUlNSVUZOQ2dVQUFFb0NBQURGOEk0ai9FclpBY1VXNnI5Zmd3TTZ4?=
 =?Windows-1252?Q?UmJxdjErREF6b0RBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFE?=
 =?Windows-1252?Q?YUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQVFkaWs1?=
 =?Windows-1252?Q?UUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhV?=
 =?Windows-1252?Q?QWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fj?=
 =?Windows-1252?Q?d0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?Windows-1252?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?Windows-1252?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFC?=
 =?Windows-1252?Q?eUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?UUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdC?=
 =?Windows-1252?Q?MUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxB?=
 =?Windows-1252?Q?SElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?Windows-1252?Q?QkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6681:EE_|PH0PR03MB5800:EE_
x-ms-office365-filtering-correlation-id: cf768539-7d11-4891-0f9c-08db191346da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5hv2g6hLh4B6P6qeogugpsqFu96mgMojlOUS8j2FZCrtkXtS2tgIh7p8Lp1bBiKN+bnPeu77YVj2zQPGpLPMXKIxlu7NftZFVCLv8RjsklAd3aoLAh2Ps4D97TotdWPf62Y8q1WpSPEIq3BtgJhNulE8TZLCWdTHqm+qIAxatlTwdXd8HHb7QsmGL3jXxke7Mmsosbp3Ez3w4CK5qLf8hCu7r5P09A1sDPiqaQ9PpSzRAg8yEDg+CF2iuSOVpPFy1PyrrIsF4h0FofgXAaJ7d8b8nzVj+1EMfISTHfrkV25mXkCkNUkTAFQoW0XDkNNxgAGX9t5ktnWrvD/PbAPndNp2vkCxiqWJ4iZafUlt/eq94p9wQz9bX7jB9QZwEsUuPwht/HPL1HS7MKREnAKBlXOQnldxcRPZ2iJvGM5gzSliyo2tg+92Wno1xuAqarHg3hquerkzm/DdHPQDWS1ukwgdHsUzm78g/ldH+t0V9hWGcxq8N0nitUZNsh/ymkKbqN2KCQsoqd3xRCrD5A6kQJ0bw5n2LPsssgCj9P2TMavOhvMoIiMkXEQjMWT4vZ0Pag0UmTfhjcfCsfcuB/RZi/DaKHIPPC+4GbMWO/xOgedK10zl0rUNiy8imyjYG1JOoWGRRPQwL9bE1gEh/l9wIL0a5a95UIELXFSZt9r7eq5jLM0QH3VCkjlfNlgaSEPGKAX2gGriPlgQsqFcigciQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(86362001)(66899018)(54906003)(33656002)(110136005)(316002)(9686003)(186003)(7416002)(4326008)(5660300002)(76116006)(66476007)(66556008)(66446008)(41300700001)(2906002)(66946007)(8676002)(8936002)(6506007)(478600001)(53546011)(71200400001)(26005)(64756008)(55016003)(7696005)(38100700002)(38070700005)(52536014)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?TJLg3+7asCnJHW5zexTzIivQ7q+Xrc5sJ+Dv9yR2dZYaANILiDc0PN8a?=
 =?Windows-1252?Q?wUnSzxiHdktjKUTkKmZ9ZTJoAHefjPFcCfil5ErQfhKClw67XNvRPoQO?=
 =?Windows-1252?Q?a6Bqq+YD9UB6avMux14Fp+Q7y1jDxnL3vKsBTHS0hJSiVHCR03QVvgSp?=
 =?Windows-1252?Q?KyUkc4nf/DUI5i7iT/l1hD5I6iRVmbj04AvEW03yLWSc1m2RujJwwYpr?=
 =?Windows-1252?Q?gglPQlb9U0TiQJx1wwR6AnVJ2Vs8F6eLbbH3+gUUnahCgPQUUdHEKQAz?=
 =?Windows-1252?Q?KfK59tCIbD5D1vjqF4ehMtt+QoeA0MyXhJBm806EzobA4pfhxnhSZvL5?=
 =?Windows-1252?Q?Wh2xO1anfu5irMQqKuevcVJLLoPCvNqPQgZUCsZIYg3eVKzZFJ0bYXML?=
 =?Windows-1252?Q?IkNLb8xkFiJHaD+OEurie6/80bPG84H8UoqKELdn2785ZqEzHwftDsVc?=
 =?Windows-1252?Q?9pbQ1S4450ptDVNUJjtwUQEhauyuPtAq5STS9MQXarvAAa8PRlGF1oLL?=
 =?Windows-1252?Q?qLf8AUWdZYLPiEVETAiVtZriZpMk5hgLbh4I8eXSK2f7gaMxlzailK0G?=
 =?Windows-1252?Q?ZdbivbtSiGadrzxxeYt2Tf2Bbcv1m5mVRjIR+gDM/vms3Z7ajQvRue6A?=
 =?Windows-1252?Q?qv6LYEhizYCYhSOKKKAix2AizRP+ssECZrPsVyt37OROR+rYUpebSe60?=
 =?Windows-1252?Q?xUzWB2HShGP1omVdeYeob/QCOVe5P+NnQ+EmxpOUD9xyG35nh6HBKtVs?=
 =?Windows-1252?Q?gzB978D+a4BkW86uch8hOqP0eBk9WLRvcacJ6bX5D/siLQ46qpPplDyr?=
 =?Windows-1252?Q?jOkRCuy5SXYhdE8P3+z8Wp+BhfZOjVzyv9WNWQMm2ECmnFkftSTdBKkH?=
 =?Windows-1252?Q?6QArQ80IdEm6jvmAEzmd1iV/y62qIvDJkuFyn28ARvmi3ooha1C8FT1f?=
 =?Windows-1252?Q?/MFCCdIXYExrSsm44kBaZGsXPK1p2BAth9i01ed0Q2pCMp3XAUkYfOf/?=
 =?Windows-1252?Q?/JsIXjNeayfYijU1vX9Pu8Zz3USQ2wBK7I/SYIUoK7TLOMUGQyyi1Q/q?=
 =?Windows-1252?Q?D8ZqSjpZcj+s1vuDbVJYo0HT6sV24yQ16nnn0jLHxKs/0OKPky+dB90B?=
 =?Windows-1252?Q?AxCH/a2m0glDeBAHUDZfIFP0fimAaGVAC/WygtctPObCSCIsbH+0SGXH?=
 =?Windows-1252?Q?+gfjc9FpF4YDuqb7A9VP6v10oHBEFaFKrvkc6iQI2+PIDTPorgxuUmTO?=
 =?Windows-1252?Q?PNHXaECmrgmNFwkPmrFSYcKhui8CeEpYi1ArBU7PInrVkb7AB0MSbVJw?=
 =?Windows-1252?Q?YHmPLEmXPAGvXN/lTp8C43Tk8KVVZD+oAPMPl3p9Lp1+EE4HK0l0AVes?=
 =?Windows-1252?Q?OLnpKG0tPwf97gZ8Ue4RD8bUnG8j/LGh9lobFW8SimMkakaFSVonUduM?=
 =?Windows-1252?Q?4sXYvByZ/34QhM8erTRuetnjTtfuWjeVTEh6YNylrb/o6DCkV9+nfYJN?=
 =?Windows-1252?Q?EFhl9p07EQobNOAisPx7szbJoxSLSlUAE0p6tEPl+MuCpATamj/VEIH/?=
 =?Windows-1252?Q?aV1Hy9zQ9XE0USbgSA53GS96Z0LYlnm5H3QzOzNevlrVtErEvvGahBK3?=
 =?Windows-1252?Q?rVsiCGB6KriI+DXaX1kPyw3VSaMvXXovFfUhyfue46ZfwlB8dagIjUke?=
 =?Windows-1252?Q?EoYod7LK4883zsDtZo2E2LAoJyodMvzN?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf768539-7d11-4891-0f9c-08db191346da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 22:37:58.6513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fk5mFMK8y5ymC16jXoBf5AKrC5OnDfs8lqaqtDKTQNRqCI9dSSf8/xVaweSGJXK1NPquarSaaFaHO2MMspxQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5800
X-Proofpoint-GUID: dessRphjn5KuRUyO37LmSeNE7pxkGt2S
X-Proofpoint-ORIG-GUID: dessRphjn5KuRUyO37LmSeNE7pxkGt2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxlogscore=773 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, February 27, 2023 10:45 AM
> To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: =93Ryan <ryan.lee.analog@gmail.com>; lgirdwood@gmail.com;
> perex@perex.cz; tiwai@suse.com; krzysztof.kozlowski@linaro.org;
> rf@opensource.cirrus.com; ckeepax@opensource.cirrus.com;
> herve.codina@bootlin.com; wangweidong.a@awinic.com;
> james.schulman@cirrus.com; ajye_huang@compal.corp-partner.google.com;
> shumingf@realtek.com; povik+lin@cutebit.org; flatmax@flatmax.com; linux-
> kernel@vger.kernel.org; alsa-devel@alsa-project.org; robh+dt@kernel.org;
> devicetree@vger.kernel.org; Lee, RyanS <RyanS.Lee@analog.com>
> Subject: Re: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
>=20
> [External]
>=20
> On Mon, Feb 27, 2023 at 01:19:15PM -0500, Pierre-Louis Bossart wrote:
> > On 2/27/23 12:47, Mark Brown wrote:
> > > On Mon, Feb 27, 2023 at 10:17:45AM -0500, Pierre-Louis Bossart wrote:
>=20
> > >> That seems wrong, why would you declare standard registers that are
> > >> known to the bus and required to be implemented?
>=20
> > > This is the register defaults table, it gets used to initialise the
> > > register cache and optimise resync after suspend - all this does is
> > > supply defaults for the cache.  That said...
>=20
> > > I would suggest it's better to not supply defaults for ID registers
> > > and read them back from the device otherwise things might get confuse=
d.
>=20
> > The 'device_id' register is the good counter example: it includes a
> > 'unique_id' field to deal with cases where there are identical devices
> > on the same link. The unique_id is usually set with board-specific
> > pin-strapping, so there's no good default value here. In previous
> > Maxim
> > 98373 amplifier configurations the unique IDs were 3 and 7 IIRC. The
> > codec driver should not, rather shall not, assume any specific value he=
re.
>=20
> Yes, as I said above ID registers in particular are often better off hand=
led as
> volatile even ignoring any potential for them to show variable configurat=
ion
> information.
>=20
> > > ...if there's an issue with the SoundWire core modifying the
> > > registers directly then the driver would need to mark all the core
> > > registers as volatile so that they're not cached otherwise there will=
 be
> collisions.
> > > Or is it the case that we always need to go via the SoundWire core
> > > for the generic registers, so they should just never be written at al=
l?
>=20
> > It's really that the SoundWire core will 'own' or take care of all
> > 'standard' programming registers. There is no good reason for a codec
> > driver to interfere with standard port programming or clock stop. The
> > bus provides a set of callbacks that can be used for vendor-specific
> > registers and sequences.
>=20
> > Put differently, SoundWire codec drivers should only deal with
> > non-standard vendor-specific registers.
>=20
> OK, it'd be good to be clear about what the issue is when reviewing thing=
s.
> The registers *are* in the device's register map but the driver shouldn't=
 be
> referencing them at all and should instead be going via the SoundWire cor=
e
> for anything in there.

Thanks for the comment.
The only reason I added standard SoundWire registers to the amp driver is
to check the values for the debugging purpose because these registers value=
s are
important to understand the device status, but it is not visible from the r=
egmap
debugfs if those registers are not included on the regmap table of the driv=
er.
The driver never controls the standard SoundWire registers by itself.
Do you recommend removing the standard SoundWire registers from the driver
or keeping it non-volatile?
(The reg_default values in the table are all amp reset values and those reg=
isters
are treated as volatile. I shall clear 'unique ID' field because it is dete=
rmined by
the hardware pin connection.)


