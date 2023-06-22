Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025D27395E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjFVDtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjFVDtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:49:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD141BCB;
        Wed, 21 Jun 2023 20:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687405782; x=1718941782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RqVNdLFYmIZPD1bsi8+ca4m6WzChRDAXTcAFJ+t/AtU=;
  b=dzfFgR03Aq+dsp3jtggBdKLN8KbPJz57nLpcVwooA1V81WjNRC6XoitK
   Asr602T/46tJVb533CoU9sId9Vu+pGSo9suSD+7pquAQccN2AIbzXKQDB
   fBELaIWlvBHSgrMqv/2sn/fA/JgTgjtSdwn32r2bR75bYsGFeaOvkDqKv
   46yU1C35nUddsR0kcgJi3YkKUxrSJiHcBbW/nwbnMyPGpOVeH8iPBncZS
   PTH5YSSSyJpvbQVEHYQ/3y/3fLRhmLYyNhKlOOlmBiQGmNCDq4RKT+wpk
   nDJdAnozBSJOKEx2PkKN7RPC8IiLMQxVT267fuJRSJAWii+a1v+w7Wroh
   w==;
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="217118346"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 20:49:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 20:49:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 21 Jun 2023 20:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz1TqsyZz7rKaoQ6qCKEM4FK75lyjrgZ1zYgjL75n9xI0L2+71YQ7kWO5Yjg8ZAZiLoS6mvsMpm1N0hxn5Fv1fy9tIFTb0zPZesndqhu+3gRrQ95TOKZP+rZb2NuU9pPkWvpsYTLx0OgAd0OzxdSXrYITVa0Pz4ogmp6+QUXRCeG3fegCu4GSmKuPUmH83JTntsFhRql/sM5nEwqYvPxy+98m/O0EjlYrc6mLRwrGGJvfJwo7Bgc1q3STa/V3IYQ9MRiqbHSd/fRAimfcwjEyVd/LPleHHAdvB7yNshal5Luub6ObSET2ZWY8tSZJudlSjojwL6QrZp3AJoC9yLO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqVNdLFYmIZPD1bsi8+ca4m6WzChRDAXTcAFJ+t/AtU=;
 b=GGHs0rVacMbcW05nAMtLpdrEg0XuVHHD89DxBsVLCUd8j5ezQ6ju+08+NP4GRV4lxx3jrd09UzCS6puECQX2ChOJKNrzz43JMPl04arGAGKB9o1aeGNeErUKLKF/oXun0EiOxkDsejzOeD7KPmio0eGiHRXDV33VkwYKy9t/P2B1UQlM4LGJ6k+83ja4DECKS2NSCumbIObSu89w/nyUNH1iOw8Ga78s9k0Mq1Ssz0OqydJ+FrAiSD22RHXa4rbVt9N80Ch+ftanldQbNgJol+64GKH1TK4qfg52ptQuF6ApiMPrzTOpMa0dyP18/9AdSW/7rsM9AjT0iQ8ReBb1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqVNdLFYmIZPD1bsi8+ca4m6WzChRDAXTcAFJ+t/AtU=;
 b=LhHQ57+zV203QWrAJMZLZklXcYNCeHXG8KuXKrr1jti+SiLsFDGL4BcbR0h8fCymSMkGByL+jD/cguzAESH8jDhN2UgwA5GB7VWF4VoXgVeGtX057l6xh+PtcTMdyVFrsYhU5ahMsBBR8mhnJ0PEfbZ7fMbaeiXLyyV7XxDp1YA=
Received: from DM5PR11MB0076.namprd11.prod.outlook.com (2603:10b6:4:6b::28) by
 CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 03:49:34 +0000
Received: from DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::3e10:f478:aa80:b431]) by DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::3e10:f478:aa80:b431%3]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 03:49:34 +0000
From:   <Arun.Ramadoss@microchip.com>
To:     <olteanv@gmail.com>, <UNGLinuxDriver@microchip.com>,
        <andrew@lunn.ch>, <linux@rasmusvillemoes.dk>,
        <f.fainelli@gmail.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <Woojung.Huh@microchip.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: dsa: microchip: add ksz_prmw32() helper
Thread-Topic: [PATCH net-next 2/3] net: dsa: microchip: add ksz_prmw32()
 helper
Thread-Index: AQHZo2ws8kJasYj5zUuuVQFI9FFRf6+WMnqA
Date:   Thu, 22 Jun 2023 03:49:33 +0000
Message-ID: <83442367a3d92a05f3ea2a136e1e47985eddf795.camel@microchip.com>
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
         <20230620113855.733526-3-linux@rasmusvillemoes.dk>
In-Reply-To: <20230620113855.733526-3-linux@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0076:EE_|CH3PR11MB7771:EE_
x-ms-office365-filtering-correlation-id: c14c4417-c139-41cd-06fb-08db72d3b12f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ph2HMed0iUZRH+ML3tfiU+Oau9O4UYdJ9UfxmM22vyJVrulkAdXM25gd6ARMcC7q0FYAmKRq9VSrK4BDcB1ZYGEJhTz+x4N2+7f0vue5UnRXzCfTtUsBHRxQR6CAhhKxvZ7LvLms2thVru6XTUlJjY4hy9AvDbAKDCKe21c/4TStZGlDHYHiF1W/YJP3IADqL0TUHwxq0ujXNTr1vHlNrVAGs64O8LllDkPOIhrkyTSK6JA/HJw8FSqInrAYDWrIZnbzws/VTNkTowSk/zcwOG3bO/vJS+jePoAAIf8TgyL84EEWfzpwQSpFlyh/mi2XBECnVmcuMso3zFd2Qro4SiKYrFvhJSQfUtb0qyMp56r6r8//yIZ5Io1BGL3JdqISTdX5XImXee+FbGraHrruJgeJoV6Lc0prmb8YUq8LPiTBQEtBgNVaVJ0TvRqtHBc0/juZ9AH6rCA7GBMJVRkAP0vUhvqILTikol0Q4iIQ5H9jlGIz7lMxBxrxSGrS2V5e7naoj7OVOsQK6MvksYg9aDowwQG4qhOLa/fXDe2E2O1FI77EwmFuZUMRqGJ/Mh9tqknwMcVsx6C+2vxnWIHp9etdbv622gSOEH6SagsNX+E9uBiLQOQTWt+iYRAD5flWwDoO4a84Dznu33MnNrd0+5jmIVEiPFLW8E1bZUs/o7A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(4326008)(66446008)(6486002)(38070700005)(66946007)(76116006)(64756008)(66556008)(478600001)(66476007)(36756003)(71200400001)(91956017)(316002)(54906003)(110136005)(86362001)(83380400001)(26005)(6512007)(6506007)(186003)(2616005)(38100700002)(966005)(921005)(5660300002)(122000001)(2906002)(41300700001)(4744005)(8676002)(8936002)(7416002)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REZpcUlERU1ZQ1ZJZHZZZW53RGxwWEljRFdSMjFUSlBjeHlTamRXdjBSbjhN?=
 =?utf-8?B?M3B3ZkZtemFKMFlpNVBML2ZEWnhCaDUzbW5SaVdiQXJjV2pXZ2tMNEFwbVBa?=
 =?utf-8?B?MVF3UG82MUZJSzA1bE9Wc1pISWxmbjNXR0QzZmhBV0h5S2tDVGpBZ3NEL09L?=
 =?utf-8?B?RVN2VW1vMVhPN0pJYm85bS9Fa1pVWUdXNFVibG0rdFV4d3lxVzdBdi91N2pq?=
 =?utf-8?B?anFXQy80MDlWdWRJeEJmbW5uWUYvYnJDbVhYSEhQcGZQbkNHU1RadFp4WXVG?=
 =?utf-8?B?Rkx1MEpSMktTVDhycHU0ZGFtMDEzK21zOFZWQ3YyNmtKN2ZkR1JzdllMTWJ3?=
 =?utf-8?B?WDNqMml1VWJ0M05qU0RzWk40bUcwQmVDV0VTd2MydExCRFRhSi9OTWVwVEdi?=
 =?utf-8?B?eDNwUGIxck8xVFZPbTRNZWw0L1ByTDE1RzNnRmxVWlVselFmTW5NNXQ0YTBK?=
 =?utf-8?B?bE1lUFNTS2RidEUvTXF0R2k0ODN4amRYaVJtTGZ0dW9qbGFISWRBcnYzY0pm?=
 =?utf-8?B?SDBTYXZRaFd2ckZIM01sdmdkZ0VhVEkvTFVacWw5K0krUXhyMThNUWcvZFBq?=
 =?utf-8?B?ZGZiUTM3S2pVb1k4N3V6TCtNdU5nNlgzQStyd1lub2hnTk1TaGYyYW5uZ0hG?=
 =?utf-8?B?KzBHY2pTQjIzWTNsZ0pTUWtEN0ljcGc2WGNnakp2NFYwcXRWLzBxcG5uMGNQ?=
 =?utf-8?B?KytERFBoRWNlTVk4c2pqcG4wY0J5TjdjclBCSTk2aEptSjVjNlduSE81V1c4?=
 =?utf-8?B?bmk0N1U4RVczS2JDUy9aZUFiVXRjclJub1ZEZnhnMkFpczRQRVREak4xSlpo?=
 =?utf-8?B?ZFhJT3FjTXY3Z2lsQlVqRnZVeDFoVmxrYmtTQ0F6TFNoN1MrQ0txenMzeVlm?=
 =?utf-8?B?QTNJdElJTnd2clR3cEx0aVVXdTJ6cnlqcTdpdXRNYjRqTkRNOGZuR243cnRU?=
 =?utf-8?B?NHRBdGR2SkVhT0k2NVVYZ25CT2NOVFEvZ0ZiR1RIUDJvZ1Irb3QxWDhSR08y?=
 =?utf-8?B?UEYrcVBhR0VZeTBBUUNtSEFsN29vVG0wQmtiMUdWZVk5R0pxSW1GYTNiZVVx?=
 =?utf-8?B?OGJRWWx2aFpPbSt6cGpIbWVoUzdLdnJBZCtLOGx4TVp2TUNxc2pYdGJxcVVJ?=
 =?utf-8?B?c2RJRjcyTDJjZ2xOV0ZXYitKNGQ3eTB1dG5nMXVYbDVkRUlGdXFPS3NOU2Z3?=
 =?utf-8?B?aEw3SmJqeWYxYzc2bm9UaHUxMjlBQWFpNHpGYzBZY2t6R2RGQUlUV2J2QlF2?=
 =?utf-8?B?eU1JNjdBc01XRDFnMFJLNFRHZ2MwaDhVTGVVdVVsZVVkMWhoQnVkY2hhN2d5?=
 =?utf-8?B?ZTFnSmc3RlR3Ykt2NHVTY3dBZkRLNDc0MW1IQTlqNXJ5R04xemZOdDNEdjR0?=
 =?utf-8?B?QThBQ3AzdUgvcTRUdXQ5dEUvMktsMmhOblJxYVZpMlJIZThPanFxSUpiOVlk?=
 =?utf-8?B?NWhDNE1JK2l1U25Fd3MrNmEwNWNzeG9iQUFEYmVEUUlnTmxheGlDSng0R3BO?=
 =?utf-8?B?dlFpcTJ6RG00UjV0N1BCdFFnL1VjYnc5LzIzZHNnbEdyMlBhbXNKT21nMEJp?=
 =?utf-8?B?SSsvRmpyU2tWWGFmQnZiK0Jvc3RIY04yandUa0F2SXBxTi9JeXJUVURPRDJh?=
 =?utf-8?B?Q1FhU1R2eldkRkxhenB0eXA1dkFueGg3blhDWXZCOTMzOCt5aW1oSzF1WGhi?=
 =?utf-8?B?NVhUTTdmY0l5eVF2dU5DNjlCOU1xdml3bWlMSjg4T1V5a3o1ckhBa0pOejJB?=
 =?utf-8?B?SmJJR1VmSEdMY01abEtGY2lnWlNOWVFHQ3ZERVZ0SFVmUE9Uc3lma1dzMlcy?=
 =?utf-8?B?OWRBQ0pkc2tMM0dtdmRwVVFZT2hJWm11M2NHaGpTVUxucEtHaWZ1VU4zRERP?=
 =?utf-8?B?ZHQvVUpoczJPNU4yVGxYWU9tTzE5VldHd2lZRGZqWHh2Q3lMVjRCdU54OVN0?=
 =?utf-8?B?dWlveHB2SDVkc2ducVVZS2x1cDBETkVvdDlnTzc0dHJxbVdmNTk2cDJzK0RR?=
 =?utf-8?B?TFB5NVU4MUxxYXBzQms4K0g5NTN3U3VzcmFGb1M1TVFVSE9iZXV3dFJyQzBi?=
 =?utf-8?B?Y28zMjY4SlZrT3ZEZWxia1JnWWtUUGtvMzFlR3N1VmZncXRnK3U1TGlJb0RU?=
 =?utf-8?B?RWQrL0s2MGdQQjRwVWtjUW1Wa0MxNGxPa1JSMWhDcTZJR0RjcEFyUVdvY3ls?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <764365D01FE6A245B081FC73B54CC3C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14c4417-c139-41cd-06fb-08db72d3b12f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 03:49:33.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5p3hVd17KvR1sgK1NEOWq0meSIOEEcYtA2JGV416+GJ118znHUJ4G2DzwMoc7rmBQhg/AyRqxDyCnL8ZQPkPEbkyXVooj6ejiy4pVO2qhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDEzOjM4ICswMjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3Rl
Og0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbQ0KPiBsaW51eEByYXNtdXN2aWxsZW1vZXMuZGsuIExlYXJuIHdoeSB0aGlz
IGlzIGltcG9ydGFudCBhdCANCj4gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
PiANCj4gVGhpcyB3aWxsIGJlIHVzZWQgaW4gYSBzdWJzZXF1ZW50IHBhdGNoIGZpeGluZyBhbiBl
cnJhdGEgZm9yIHdyaXRlcw0KPiB0bw0KPiBjZXJ0YWluIFBIWSByZWdpc3RlcnMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBSYXNtdXMgVmlsbGVtb2VzIDxsaW51eEByYXNtdXN2aWxsZW1vZXMuZGs+
DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+
DQoNCg0K
