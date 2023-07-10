Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEE274CC65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGJFvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGJFvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:51:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B20EDE;
        Sun,  9 Jul 2023 22:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPYFY/4wMC30jy4kWrYByGHKMJDyyahS1/1LpvHgpQf7K5ifENa9IybumVBMQgf3wfDLx5Ar4v6GKoZjKrg42B7wFXbxI1QiQ+0ViV0KseYEjUxgD8k2tp8Qdr5QKL2+k0Va3BiGL2CpitYfzyL/HfGFRFJedIGbOhfEBco+4UEu5Fg1OngImRpWBsFG5+l8bkol0H9M/A4fCzgUtWRCsj1qo6TlIKlkJW/4fAth1wrjkAkHXA6KiQFt0QaVWLDp9AN+gI3zdzZSUjhsRTRAttlCB9oVUKfmbHRmEdCuDwq1zecBYJ/GLYGwsVFuGqxrXR1WhYELFo/0Vr2nq5Sa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2sDvBCoewpMSkzBMvPo3Uy0FgeZZ7R0yDglPcZiEcw=;
 b=Lohx1PXMm68u/LsvGelMOqeBr9KAVygbBSHH/oq9ItmmcAM9yopKaodB7xCGFXN451FQI8Zx7ZwHBpPetnS0PmycQX19mA9n6Ld0PHX2yoCQJxPS/sVVr9pX8B23B01xZjdSRDU4p7gpxr+aIMDawFK33h8UXn8TJFibEukoGXK/xtIWfGczhWTNiLQnFiK79VCE1Bfi0P9oSg3ANjiIQSfTwA//EENjXc2XtzaiOQMPjPyicR9ufrpMQgFqJ8ncnkU2ULZphZFXH1v3U1+CTBQC9MZ/31hPHmb8kz26DzWjwtv8haG9JzbeVotFQblMDH+D7RBn2wXotNldERBJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2sDvBCoewpMSkzBMvPo3Uy0FgeZZ7R0yDglPcZiEcw=;
 b=ULq7S0rnKxlsAxgoHkacQJNpinWeHpR0ulUc8hAikpsEJBaihH56Q2q9ScPm0g/ITkOsvGMSA/kHfms35uJYTn3uCZuvY+jLaWJ5aI0I1YRVy8MgTffkwFCiUGrNDPOx/Zngt6LYutShCAA1EhOePIss6COxtw63qo9LnkVMvC4=
Received: from BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 05:51:06 +0000
Received: from BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::dd8c:65dc:5934:7ecc]) by BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::dd8c:65dc:5934:7ecc%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 05:51:06 +0000
From:   "Katakam, Harini" <harini.katakam@amd.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonas Suhr Christensen <jsc@umbraculum.org>
CC:     Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Haoyue Xu <xuhaoyue1@hisilicon.com>,
        huangjunxian <huangjunxian6@hisilicon.com>,
        Wang Qing <wangqing@vivo.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Esben Haabendal <esben@geanix.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neeli, Srinivas" <srinivas.neeli@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: RE: [PATCH net v2 1/2] net: ll_temac: Fix DMA resources leak
Thread-Topic: RE: [PATCH net v2 1/2] net: ll_temac: Fix DMA resources leak
Thread-Index: AQHZOZ4bIaLXD56kTU6BDUgiXUw8vK7DWxGAgAACc4CAAHb+AIA1bdoAgAADVwCAAK4eMIC21ZQAgAKjbYA=
Date:   Mon, 10 Jul 2023 05:51:06 +0000
Message-ID: <BYAPR12MB4773DCF723E65BCBFAF3AEF29E30A@BYAPR12MB4773.namprd12.prod.outlook.com>
References: <20230205201130.11303-1-jsc@umbraculum.org>
 <20230205201130.11303-2-jsc@umbraculum.org>
 <5314e0ba3a728787299ca46a60b0a2da5e8ab23a.camel@redhat.com>
 <135b671b1b76978fb147d5fee1e1b922e2c61f26.camel@redhat.com>
 <20230207104204.200da48a@kernel.org>
 <bd639016-8a9c-4479-83b4-32306ad734ac@app.fastmail.com>
 <20230313114858.54828dda@kernel.org>
 <BYAPR12MB47736214A6B4AAF524752A8B9EBE9@BYAPR12MB4773.namprd12.prod.outlook.com>
 <19369234-8785-575b-ff24-9a21a9e82f0e@wanadoo.fr>
In-Reply-To: <19369234-8785-575b-ff24-9a21a9e82f0e@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4773:EE_|LV3PR12MB9143:EE_
x-ms-office365-filtering-correlation-id: bbbc0d46-3204-4212-55e6-08db8109a748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DktwlMdWqlZux/q+h84HDOQJPcrYqS6oyl8fEdjGh0toenB1ftvoF/zMYyUdEUSkLWxRBFulvgAi0mceduhjeq1tY8BRKBee15x9SVpbzrLQBAU3JULOpNWNAHVY2U3egQiEhi0FmHUUPoU16BUJNruRToJwwDx4F67mGoGMJv+w2SJytV/XQEI5pkSFl10zFTI8rM2QAx9yu+f89IKnhOTpmAcWgBIvKBNXkb8m+0qYGYMFi3ugO5Ipm6YQdDr1YpFR16xdGrg/wbWQIuFJKjHbWbZbHvJDRCDWbylKFqO3f6sFcDTiIsuIfcrK3UGsl0ccYWc8inTKhBC3lSp2QMEId4IjoJ8ietMBfIazYPo8VBhZY4QX771+0H7jy0M67OLlT/hhjFv3E/YFntdlZbFXfeIxjlOwTJm2A+pVuaKgq0xUzPOhPfaDNnPvB6DzJ/AGpNCluzI4C7FndX22QMKTC7WDuUQmPBPKP2fpBwuHR7nL2d1XAto208gVty+prIg4fngoUysXYn2v2Uk+MM6WEK5HrEpfo8QdddeqDkpxMzSU9y55q1zgxX/y2UY0QTQV+j45m1yu3GBrGJeXEgYyTZ4P+8lxKf5heA3iMKiTxDEOCAkaLkWW0+LceZAy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(186003)(26005)(6506007)(9686003)(53546011)(66574015)(83380400001)(41300700001)(4326008)(64756008)(66446008)(2906002)(66556008)(316002)(52536014)(7416002)(5660300002)(8676002)(8936002)(66476007)(66946007)(478600001)(7696005)(71200400001)(76116006)(110136005)(54906003)(55016003)(33656002)(122000001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJseG11UVpkbGJ4aGthbjdEVy9PemY1RjVpdjlSMEVRWnBxWjdaMW12bDlq?=
 =?utf-8?B?WnU4ZStQYjJlU2NsK205QWw3SmJyc1FNenplQWovNk9UMXdlVWRLcml0QUZw?=
 =?utf-8?B?TVRMSlM1ZC9EWUNpcnQrWG14RmtvOERSbzJFOXU1VEliQ09LcDZJaXJyTjFw?=
 =?utf-8?B?UXdzOHRZd2x5eTZrb25QQUovUlF2djBpOFNPN3psVDJQSzZSM0RvbjFiczVL?=
 =?utf-8?B?c0h2bmFjd3Zxbmo2NWswU29rWFJtMS9aV21RRmZyck9LNmY5WTl2ZUt4WVN6?=
 =?utf-8?B?TFJwSDhVbTk2TWNUS1JHM0ZSYk83aTc1RUQ2eWtiQ3U1eWFRUklwOGtOemVD?=
 =?utf-8?B?aDA0cDdvSjRRSUVveDRXUnUxekRDT1VibUlQbjRuZ3ZKWnhMSldGWUJxMHZZ?=
 =?utf-8?B?bzRVdzVaZmcrUkVyVjhOSUcwWC9xZVVhR05xWURrOW9UU0Y2dkFDVmVPc2x3?=
 =?utf-8?B?ZUEzSU5yUFlva0xrWmlWZzZ1WFdOSUdVZ216dm9MK2dYY1F2dmFraVZxd09o?=
 =?utf-8?B?NCtTVWNRbVZLNnZLOEF1bDZTYVJmbmpJeVlZNSt5RE93VWozSzdyQmVGcEgr?=
 =?utf-8?B?ZWpkQkxKSndJTXNRSHpTVnE2bE9lN3Nld0pGRmtSUUlmVm5id3Z6T2RWbER6?=
 =?utf-8?B?Q3JEOGR1YzNmUEkwdEM5ZlJTdUNsbkZ1ME1Gc3U5TmhFR2VsNHNPWWlsaU9S?=
 =?utf-8?B?cTF1MW5ER29tRE5uM3I2UUF3K1Q3SzZBYXlqR1MwNHB3bWJKS1gweFIrS25N?=
 =?utf-8?B?bEVXMFZCRFFhVTBxa3NWL0ZhSHJFczRSdFQvakNkcVMvVVVqUUl5RnZxcHgv?=
 =?utf-8?B?eTA2TnhxNnBCSENQSGhmNDVxTFlKdDc2SHhZQjJnNEcxSWNTbjRnZzJsbDdV?=
 =?utf-8?B?Q1VKT0FSNmM5RDErQzAvb3M5TldHY0F4WkswY1granRsNU1DTmRLSHRUMHVV?=
 =?utf-8?B?R0cvR0JDNlJjQlBqWUo0V1VEbld5TDZvL2NtK0hrRC83TU55ZXc2L3JVZksz?=
 =?utf-8?B?V3hkV01WYytUU2s2MjZzeWtNcGMvRjRYcVRyVXJzSmxLc3ppMy84R2NMSzZr?=
 =?utf-8?B?UUZreTZmV3NiWWluMTFGSEZ5bHFZNUN2UzZOR2ZtR3NOZVliUVl3cE1BOUp0?=
 =?utf-8?B?OHdsbndEQWJhMExzaDJsTFgrTWtqR2RHSlhxRFZaVkNab04rMHBPTWdmblQ2?=
 =?utf-8?B?WDFGc1FXSnJueUJMaEpkTVZVOFZQQzF5ZC9obUE5OGNlWTVoSVVNdWRWN0xu?=
 =?utf-8?B?aE05RkFrdlRVVWVleXVBMmt2SHJWaU8vR3NWbzQ2UXFscGZ4TE41WGF6YUpt?=
 =?utf-8?B?eFdLUDlwNEhoeGs0SU1KUCt6Z0ZDbUJUTTFrK1cwZURlMHd6TEFBU1laNGpr?=
 =?utf-8?B?M1pJUTl2UnIwNGwzcTlIMEwyeU56RFpCUExXcHhOWFZ4N3dCQUVPcHRBR05F?=
 =?utf-8?B?eWJVMkdwOTYxbm5PdHVNczNCSnlZSjlST1BUZHdrcGw4Y29ZdFlEOE1BYnB0?=
 =?utf-8?B?d3ZhMGlrNGh5a3J2VGpJYjRUcEJ5QzcreWtZL3dhRkphQmc2bk04MFhWc3ht?=
 =?utf-8?B?V1Qzd0VCRzF4amZVakRtQTFQdGVDZjByTGlzNjRvZGZMdkpGSzVBRSt1a1NU?=
 =?utf-8?B?NVVHU09LNElzc1lpWnBNUk1IdzA2UDRaTEd4Vks3VWtqSUN2bnQxdTRKSGJD?=
 =?utf-8?B?T0FEOWdiWXFFUG5UUlo5ODFnT3BoaE96R2kwdmg5dDlvczJ5ZzVtTmdabUpi?=
 =?utf-8?B?ckdLdU5XeE9GZzdZL29yN1o2ZXJXK3hSNVYrV2FHVlozR0Z5eDhIcTN6NExV?=
 =?utf-8?B?RXpac0JoYWJLT1RBT3pIZ1luR0ZIV202OGJFN1FnUFFGbmpiMHZkZXhrYm9k?=
 =?utf-8?B?Z2lZK1RicXBsMEVxM2VadElpRjd3cEdKRTJ3UnJxSGpzMVV6Ry90ZHQ3TzNY?=
 =?utf-8?B?alVlT1pyNHIxeWd2TEYyQkUxYWNwZk5NMlRSRUdabTNlL0dPMEt2U2c0bFVx?=
 =?utf-8?B?NnVpU1lyVnNTL2FyTDR1NU42WUtYZFF6Y1cwa1IwMVpwMEsyalNpcGRWeUw1?=
 =?utf-8?B?S29qeTB3eEdNNjBOYjJOeUp5Znk3a3E3Yzk5TlV5TjlsZDJUbDduYVJvTlJi?=
 =?utf-8?Q?kHGw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbc0d46-3204-4212-55e6-08db8109a748
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 05:51:06.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: begoFhb1Dw1uDeBnRQfHbjBt5IvWx/lhsgfSdlq7oilYqkj19L9SIbXFakIw7f5p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoZSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBD
aHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiBTZW50
OiBTYXR1cmRheSwgSnVseSA4LCAyMDIzIDY6NDYgUE0NCj4gVG86IEthdGFrYW0sIEhhcmluaSA8
aGFyaW5pLmthdGFrYW1AYW1kLmNvbT47IEpha3ViIEtpY2luc2tpDQo+IDxrdWJhQGtlcm5lbC5v
cmc+OyBKb25hcyBTdWhyIENocmlzdGVuc2VuIDxqc2NAdW1icmFjdWx1bS5vcmc+DQo+IENjOiBQ
YW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBE
YXZpZCBTLg0KPiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVk
dW1hemV0QGdvb2dsZS5jb20+Ow0KPiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbngu
Y29tPjsgSGFveXVlIFh1DQo+IDx4dWhhb3l1ZTFAaGlzaWxpY29uLmNvbT47IGh1YW5nanVueGlh
biA8aHVhbmdqdW54aWFuNkBoaXNpbGljb24uY29tPjsNCj4gV2FuZyBRaW5nIDx3YW5ncWluZ0B2
aXZvLmNvbT47IFlhbmcgWWluZ2xpYW5nDQo+IDx5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+OyBF
c2JlbiBIYWFiZW5kYWwgPGVzYmVuQGdlYW5peC5jb20+OyBsaW51eC0NCj4gYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBOZWVsaSwg
U3Jpbml2YXMNCj4gPHNyaW5pdmFzLm5lZWxpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBSRTog
W1BBVENIIG5ldCB2MiAxLzJdIG5ldDogbGxfdGVtYWM6IEZpeCBETUEgcmVzb3VyY2VzIGxlYWsN
Cj4gDQo+IExlIDE0LzAzLzIwMjMgw6AgMDY6MTUsIEthdGFrYW0sIEhhcmluaSBhIMOpY3JpdMKg
Og0KPiA+IEhpIEpha3ViLCBKb25hcywNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiA+PiBT
ZW50OiBUdWVzZGF5LCBNYXJjaCAxNCwgMjAyMyAxMjoxOSBBTQ0KPiA+PiBUbzogSm9uYXMgU3Vo
ciBDaHJpc3RlbnNlbiA8anNjQHVtYnJhY3VsdW0ub3JnPjsgS2F0YWthbSwgSGFyaW5pDQo+ID4+
IDxoYXJpbmkua2F0YWthbUBhbWQuY29tPg0KPiA+PiBDYzogUGFvbG8gQWJlbmkgPHBhYmVuaUBy
ZWRoYXQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgRGF2aWQgUy4NCj4gPj4gTWlsbGVy
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29t
PjsNCj4gPj4gTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IEhhb3l1ZSBY
dQ0KPiA+PiA8eHVoYW95dWUxQGhpc2lsaWNvbi5jb20+OyBodWFuZ2p1bnhpYW4NCj4gPj4gPGh1
YW5nanVueGlhbjZAaGlzaWxpY29uLmNvbT47IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+
OyBZYW5nDQo+ID4+IFlpbmdsaWFuZyA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPjsgRXNiZW4g
SGFhYmVuZGFsDQo+ID4+IDxlc2JlbkBnZWFuaXguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHYyIDEvMl0gbmV0OiBsbF90ZW1hYzogRml4IERNQSBy
ZXNvdXJjZXMgbGVhaw0KPiA+Pg0KPiA+PiBPbiBNb24sIDEzIE1hciAyMDIzIDE5OjM3OjAwICsw
MTAwIEpvbmFzIFN1aHIgQ2hyaXN0ZW5zZW4gd3JvdGU6DQo+ID4+PiBPbiBUdWUsIEZlYiA3LCAy
MDIzLCBhdCAxOTo0MiwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+ID4+Pj4gT24gVHVlLCAwNyBG
ZWIgMjAyMyAxMjozNjoxMSArMDEwMCBQYW9sbyBBYmVuaSB3cm90ZToNCj4gPj4+Pj4gWW91IGNh
biBlaXRoZXIgdHJ5IGNoYW5nZSB0byBwaHlzIHR5cGUgdG8gX19iZTMyIChsaWtlbHkgbm90DQo+
ID4+Pj4+IHN1aXRhYmxlIGZvciAtbmV0IGFuZCBwb3NzaWJseSBjYW4gaW50cm9kdWNlIGV2ZW4g
bW9yZSB3YXJuaW5ncw0KPiA+Pj4+PiBlbHNld2hlcmUpDQo+ID4+Pj4NCj4gPj4+PiBGV0lXIHRo
YXQgc2VlbXMgbGlrZSB0aGUgYmVzdCBvcHRpb24gdG8gbWUgYXMgd2VsbC4gTGV0J3MgaWdub3Jl
DQo+ID4+Pj4gdGhlIHNwYXJzZSB3YXJuaW5nIGZvciB2MyBhbmQgdHJ5IHRvIHN3aXRjaCBwaHlz
IHRvIF9fYmUzMiBpbiBhDQo+ID4+Pj4gc2VwYXJhdGUgcGF0Y2ggZm9yIG5ldC1uZXh0LiBObyBw
b2ludCBhZGRpbmcgZm9yY2UgY2FzdHMganVzdCB0bw0KPiA+Pj4+IGhhdmUgdG8gcmVtb3ZlIHRo
ZW0gYSB3ZWVrIGxhdGVyLCBnaXZlbiBob3cgcHJldmFsZW50IHRoZSBwcm9ibGVtIGlzLg0KPiA+
Pj4+DQo+ID4+Pj4+IG9yIGV4cGxpY2l0bHkgY2FzdCB0aGUgYXJndW1lbnQuDQo+ID4+Pg0KPiA+
Pj4gSSBubyBsb25nZXIgaGF2ZSBhY2Nlc3MgdG8gdGhlIGhhcmR3YXJlLCBzbyBJJ20gbm90IHJl
d3JpdGluZyB0aGUNCj4gPj4+IGJhdGNoLiBGZWVsIGZyZWUgdG8gdGFrZSBvd25lcnNoaXAgb2Yg
aXQgYW5kIGZpeCB3aGF0J3MgbmVlZGVkLg0KPiA+Pg0KPiA+PiBBY2suDQo+ID4+DQo+ID4+IEhh
cmluaSwgYXJlIHlvdSB0aGUgZGVzaWduYXRlZCBtYWludGFpbmVyIGZvciB0aGlzIGRyaXZlcj8g
Q291bGQgeW91DQo+ID4+IGFkZCBhIE1BSU5UQUlORVJTIGVudHJ5IGZvciBpdD8gSSBkb24ndCBz
ZWUgb25lIHJpZ2h0IG5vdy4NCj4gPj4gQW5kIHBvc3NpYmx5IHBpY2sgdXAgdGhlc2UgcGF0Y2hl
cyAvIGZpeCB0aGUgcHJvYmxlbSwgaWYgeW91IGhhdmUgdGhlIGN5Y2xlcz8NCj4gPg0KPiA+IFN1
cmUsIFNyaW5pdmFzIChjY2VkKSB3aWxsIHBpY2sgdXAgdGhpcyBzZXJpZXMgYW5kIHNlbmQgYSB2
My4NCj4gPiBJJ2xsIGdldCBiYWNrIG9uIHRoZSBzdGF0ZSBvZiB0aGlzIElQL2RyaXZlciBmb3Ig
dGhlIG1haW50YWluZXJzIGxpc3QuDQo+ID4gV2lsbCBpbmNsdWRlIHRoYXQgcGF0Y2ggaW4gdGhl
IGJlZ2lubmluZyBvZiB0aGUgc2VyaWVzIGFzIHdlbGwuDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+
IEhhcmluaQ0KPiA+DQo+IA0KPiBIaSwNCj4gDQo+IHRoaXMgcGF0Y2gsIG9yIGFuIHVwZGF0ZWQg
dmVyc2lvbiwgaGFzIG5vdCByZWFjaGVkIC1uZXh0IHlldC4NCj4gDQo+IERvZXMgc29tZW9uZSBz
dGlsbCB3b3JraW5nIG9uIGl0LCBvciBkaWQgaXQgZ290IGxvc3Q/DQoNCkFwb2xvZ2llcywgd2Ug
ZGludCBnZXQgYSBjaGFuY2UgdG8gY2xvc2Ugb24gdGhpcy4gV2UnbGwgZml4IGFuZCByZS1zcGlu
IG5leHQgbW9udGguDQpUaGlzIElQIGFuZCBkcml2ZXIgYXJlIGluIG1pbmltYWwgc3VwcG9ydCBt
b2RlIHJpZ2h0IG5vdy4NCldlJ2xsIHVwZGF0ZSB0aGUgbWFpbnRhaW5lcnMgZW50cnkuDQoNClJl
Z2FyZHMsDQpIYXJpbmkNCg==
