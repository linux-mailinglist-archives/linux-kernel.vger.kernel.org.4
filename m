Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B1614E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKAPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKAPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:14:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB61EEC4;
        Tue,  1 Nov 2022 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667315396; x=1698851396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5iCoAr6N1jXPn2J/PXbp0EYXHUYkkPsm6N3d0frrs9Q=;
  b=BS1FbI6jNdbcLO2MsWH+U/PPvGfaws+ejPBIRCZjrCsBiPaY0hvbNhxs
   P9zUMSMFte9c2womZAONF4NQu14TX9i/hZOGVNEFAZryrJKeiTOBDlVP4
   ZROzKzCr5L9cvypdfmEpS7bnldD//FJ9Ud3r7nvDXli7rguRVh6Zm4Urk
   yqg+azP+u7KUsklc/reQNom13iogHdCCsvX9+Jv6iunMTCO7MYl6niwwz
   Has1F/srn8kxNrcqJyfLB2aQyNdyIJ0REuBjy70Q6ymKXvOGYVM+ieoWy
   gRp/P1GYw+t0vGbFJcYxnCOQy5ZKT7ZauX/s0vekmFuh1/i0Bh7Ygus+j
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="184847401"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2022 08:09:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 1 Nov 2022 08:09:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 1 Nov 2022 08:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY9PYZrIfNjgTnD8RexokJZzkpkTEzMFBRK0hpOXTRoUiJ3EokoRkOSWLVza+HjXCAy9akkbr3HZ0oRGu63B4O1wrrwIkKLNjycUp1dF5h6yfo9sg8b9JrtDcinVcfvmCLY6Fy/kgpuSGBjGc71yeNUObFS7ApnBappOdkf1mwH+Th3KULmkmnzvDgkiQv60RZcp8elRSZ/eI1JmRoch5Xbxvh5nZMS+mLMSCKr4Qtb+VvIXx74xeQyycTeHkbqhsmFrzEvLozWEV1HNkxHP+BQuIz6xZI9KqVrqoWS2QvuSYEj1TfZek3HxKxwKm7CATRnehxSEs1lVgyH0zcZTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iCoAr6N1jXPn2J/PXbp0EYXHUYkkPsm6N3d0frrs9Q=;
 b=fr6LwsfkSxkRXkjTy4Bz7awwEntkUYBI2p+bizcTR7ncN5g52DD7ZMfeOTpnbpp5MIBTJf2pq8QRgsqLEU3j9Qt6mXwfT3eQGCpO+x+VrCJU1DR2Y36VrL4QbpX6Z1BQusbbz4V+MBPKLwcE2nwgLyV1g4G4/N9ZTrDJwopX23HMG2Cu6trLIDaxiUxqK4m8/fKVOj+IZrbwh7x493lp4eLIygQMdP885kmBqndNf4rs+0B4hu6pcPamuJjgqX+UlRUP8OIz9KTxjXXF5dzi0NMc2gkvB6aHSCoVlvcnES50wWcoUVMe+LXygxDsl8+ppLacSuII1fMM4k66LTwn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iCoAr6N1jXPn2J/PXbp0EYXHUYkkPsm6N3d0frrs9Q=;
 b=CZp6c0GCcLioieXUHYzrL80h0t53+ZQTsT/Zm7NsF/Svzu9WrFAJvl6iDynWCQVS4K/pSGsjbm2408nP4cmPr69cDGJmOGcHG5giGp2oOZYvBMcNtb2JyPZqpiRrtvtqQRriDjz8H82C1NxPW/U8EzQ6r1ZO6r0QX/ENzYXWN0M=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 15:09:20 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 15:09:20 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] ARM: at91: fixes and enhancement
Thread-Topic: [PATCH 00/11] ARM: at91: fixes and enhancement
Thread-Index: AQHY7gPqe29GnzQPHkatXJxAhH+pQg==
Date:   Tue, 1 Nov 2022 15:09:19 +0000
Message-ID: <1177ad12-89b5-8625-9155-d06398b74502@microchip.com>
References: <20221026124114.985876-1-claudiu.beznea@microchip.com>
In-Reply-To: <20221026124114.985876-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA1PR11MB6783:EE_
x-ms-office365-filtering-correlation-id: 77439640-129f-46a5-b81f-08dabc1b0d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: We2sJq8a7OsHv93gGQaZ42j0zm7tJvuZ2hrIhCwFueA/bDKbpBMHvNg1PuB6bunaJchjl7FgcaLtxwkaq+EcCAaRypkcJavN8iq5nkHfi+hkQnfJ9jmoaniMtqRZ9nMejMT8xlrtb5QXnQHedVr1+abIsIQyelf2gr7PvGJSLVPjoPThrzx2oL1m9/6MXhZNflYf9XJ0ujQoO49gs+uDDBtzHOIHdfyomCO8rwZ+M2FWHK3YM6g5fs1pePexKGkas99FnD3/2I3nlqxeUX0h8vWvvI4/Ug2tmztRcivsEGV5Xt2TS7AZUMRoRoAgrcz2TPI81NhMrHDbkdx1cDA8wtlnEFrQzvXjGl+DsCwSGQO3VUZ/sunw3z/pIyxDGHsldcXlcYDk/1iKPCdJtQxdJwFSHdqX9Dtm46onkgQb41nW7tv8Y414auvwgib4fR4k6t8/dg8dvnlcFQVMLEoq9cTgxH8t2b+blZVLHMn2DF/vQa1nf9+lb/npKzoIWktTRYtMAlbvz0Ot26lHn4My7F7VHT+U+gV6O/cRfo38lulJ0Wh/gTerupYc9Wm1tUGJpTY/aZ7quB13xjF1Qi422qb84Vox3PjPcdvssu9lju5FgZfSapaexNMPatIUyJSPkA6j1+etZOpw3UyGvhzeHA1pUp31aykA4vUHG21DL7IlofdRrMwN/tJf0FwOWc5bE6qxmjMgifmJ8dXUbDZTgzCHQpnU+cy4JFlp8hdbOiE86hvLMyryq09X38B0G7uMoKhGotYIZoIK7fCaCMZLIg+0cd4vpUZvhbY7YIktEdbdFOmm8XJ3Pr+devsNF8zkMz60Xh00Qq9Yioy/+DZ7mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(478600001)(71200400001)(6486002)(31686004)(66946007)(53546011)(110136005)(54906003)(316002)(76116006)(4326008)(64756008)(66556008)(66446008)(8676002)(66476007)(6506007)(91956017)(122000001)(41300700001)(26005)(38070700005)(38100700002)(8936002)(5660300002)(2616005)(6512007)(36756003)(2906002)(31696002)(186003)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzdxb2x5Uk5uSFdMc1Y3VE8zQ2plV3pKUFQ4MVFTRFN6RnltcUlpbGpxUlF0?=
 =?utf-8?B?NFh3cjdRa0g2clpWWnMwTUxtbVBrOGNyektHVnlnMUp1a1BxMnZZTDFqY3Rz?=
 =?utf-8?B?U1Z4SlVuQ0hYRmRNd1N5TlhwWkNDRjlXRTNFUTJRbEVDOW5xUTc0U2NrZWVO?=
 =?utf-8?B?eFREaE0rNGNmMlV6UHNNVjVQRmZyYjRLOEtBMjJWS0pQVDJDSktoNTVtTHlr?=
 =?utf-8?B?eXFwRFRtaWFET1U2R1VVMERLVFIwQy9lYWl2ODJNcjlOUDlteHBtRHNFeHJ6?=
 =?utf-8?B?S0R3RDZ5QWJzVElHb3JTdmJjaWt0cWp3c1ptU2RwbFh3NS81ZTBTblU0Zng0?=
 =?utf-8?B?WUFzY09Ubk1Od2hDaktONG1IZ3J3S2M5TFM1azVoRXhBdXY4eUNlT0ZDdU9G?=
 =?utf-8?B?dHVXWHZWcXVqcUdFMHBSWmMvQ1JjdEg4SnJ0Um43ckZPVWROSE9uRlkxRk94?=
 =?utf-8?B?RWZYZUJ5WXdYRXQycEFGeFR2dTYwaFh6MTRVZnBjd0VFL2tWc0JHaE9JQ09M?=
 =?utf-8?B?eVo2azgxZXdsZUlHUlB3NzlYWmtRQmxPbnA0ekVNb1M2ZmUyckZ3M0R6ZWtX?=
 =?utf-8?B?ZUp2Ny9pZW05dVp6Vzk0NHF5UGhqSVF2Vy9PRGpuTTJJM2lWajZmUkJaRk9D?=
 =?utf-8?B?QWFlT2JmNkE3dnpYczBYTXlSMEtOWjR4UGphZm8zeTlzdGQ4K2s0RExyNXZY?=
 =?utf-8?B?K09jeXYyQTd4akc1M3ZkZTUwaXhXek9qNmJTNXhmdVBPT01MOEZNTkhYQTZp?=
 =?utf-8?B?MkM3ai9TWTczeVFSSlc1U1ljeUpSd1g3NDFUamlOZUhrVEdCU3RtbHRVWVBV?=
 =?utf-8?B?N2d5dGFWQ2JXcktWWHhlV2E4WjkvN3ZXVC9zZlh5MHAvNmRPREpYc0srNUNQ?=
 =?utf-8?B?WHNzbU9ISGdaK2ZvOElaNEkxTWZwbGtrWm1RQ1p6OHN4Ry9NRi8vOXRaMnM2?=
 =?utf-8?B?YVpEck9oalM3VytXREFGaDZOdXUyZ2RtZ1VCQUtIbUZGYkx4YS9uS2h0UU10?=
 =?utf-8?B?WFVyTW4wWFdVU3NMdGlYenJJZUJPQU03N0tDOUhmeFdvRGQyN210K2MraVpp?=
 =?utf-8?B?aWlXd2lESFVVdDBZRTY0VXRpYjBuang1Z3B2Unc0VDRtS2puRXY5WGdrQUI2?=
 =?utf-8?B?aDdacm1XWTJCRU9xZlRvTVBGODRSdFdwSUxCVHFGQm1XUnRRTXUvaEFkWVdH?=
 =?utf-8?B?eE05S3BVNXppUnROeU1iMDJlTW1IcTJicmNoSlN4Nm9oOVl0WUovMFcxTXlt?=
 =?utf-8?B?WmhpcWlWWWtwODlYbDRsdmVNcnVDaTU2Vk9YOEtRNityVi92UUpUQXJpSzJH?=
 =?utf-8?B?ck81RDN1Tmx2T084UW8xazZEOGxZVmFLd3dIa3VndDgzbll0NzVmc3JlVklM?=
 =?utf-8?B?TzR4dUVyM0FRSWRmNDJrQ3VuTktTNFNaZEVpRmxlZkVXVE0rNVRnMDlaZUJW?=
 =?utf-8?B?VlVVWnhYUE53ZzNhQVd1T2F5cDU0dk9nMVhpcW1rUXg2Ymw3TGs3RUZSZlRk?=
 =?utf-8?B?aG1xVlBiczJRdVVHb21qc3IwYkdWaUhXOWNENDdoM2NTS3h4QWZTTERlNU5h?=
 =?utf-8?B?ek03OXNmOHkyM0YxOGNVQ2RtOWlndUlQbDAzUVAvOUFXYWk1a01PT1U1aG8x?=
 =?utf-8?B?RHJMOVg0b0oxMko0UEU3Q0xnRVpvVnNPdW52YTVkTHk3aE1GOE4yck9YZ3Fv?=
 =?utf-8?B?QTRER29GUU9MZktZVzBBU2xNQkdXODhaMVR6MmFxOFNIRmdyYWdMVldxK3Zi?=
 =?utf-8?B?cEZtRTNyRWFkM0d2U0pMcEFFQW13SWgxRStFYjFQaXZld2NabHZlampSRDVI?=
 =?utf-8?B?YU5BTjJ5V1QzaTVyM2JuQjVsWnhnZ21GdkFLLzB5eW5qbTlHYXdEWEdGRGZP?=
 =?utf-8?B?R2d4RG9vZUpUbEtORC9LRjg2dzlTYkZWaHM4SjRCYVk0NFZ4bFNQSGxEYVRj?=
 =?utf-8?B?Y08rcnc1Ulo4NlpRWFNRRUZ5a1czV0pSMm5CaG9nN2p2VlVXc0hUSWZ6a3kw?=
 =?utf-8?B?OHBLNkdGTkFzb1hCRXFlMHFzb2l5WHhEeCtnK3Vtc2lCNy91NHJGbnFQZDNS?=
 =?utf-8?B?SE9ubktkcnFXa3VnU3d6RnJMbVdQRzRjMUkwN0h4TkpUNXplUmN1TmhueHM1?=
 =?utf-8?B?NThKZ1dVaXNyUXhCOFVxWlF3RXh1MEl2MDFRcVhPdmdCVWFNcE5HNGJ2VkZO?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00AFF3C1C1D4BA409DBC182E45F38169@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77439640-129f-46a5-b81f-08dabc1b0d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 15:09:19.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Og/GLi5J8bV/XzcAD0OAPPswkLvpJ/z28QhXBJmOggbpiH8n5c8bbbFoazDB6dpaNefJlehTSgCwsfodiM5ETvt5aRcZ1sIH8x4V907fjaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMTAuMjAyMiAxNTo0MSwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEhpLA0KPiANCj4g
VGhlIGZvbGxvd2luZyBzZXJpZXMgYWRkczoNCj4gLSBvbmUgZml4IGZvciBzZWxmLXJlZnJlc2gg
b24gU0FNQTdHNSAocGF0Y2ggMS8xMSkNCj4gLSB0aGVybWFsIG1hbmFnZW1lbnQgc3VwcG9ydCBm
b3IgU0FNQTdHNSAocGF0Y2hlcyAyLzExLTkvMTEpDQo+IC0gMiBjbGVhbnVwIHBhdGNoZXMgKHBh
dGNoZXMgMTAvMTEsIDExLzExKQ0KPiANCj4gVGhhbmsgeW91LA0KPiBDbGF1ZGl1IEJlem5lYQ0K
PiANCj4gQ2xhdWRpdSBCZXpuZWEgKDExKToNCj4gICBBUk06IGF0OTE6IHBtOiBhdm9pZCBzb2Z0
IHJlc2V0dGluZyBBQyBETEwNCg0KQXBwbGllZCB0byBhdDkxLWZpeGVzLg0KDQo+ICAgQVJNOiBk
dHM6IGF0OTE6IHNhbWE3ZzU6IGFkZCBvdHBjIG5vZGUNCg0KQXBwbGlkIHRvIGF0OTEtZHQgYWZ0
ZXIgYWZ0ZXIgcy9vcHRjQC9lZnVzZUAgZm9yIG5vZGUuDQoNCj4gICBBUk06IGR0czogYXQ5MTog
YWRkIGlvLWNoYW5uZWwtY2VsbHMgdG8gYWRjIG5vZGUNCj4gICBBUk06IGR0czogYXQ5MTogc2Ft
YTdnNTogYWRkIGNlbGxzIGZvciB0ZW1wZXJhdHVyZSBjYWxpYnJhdGlvbg0KPiAgIEFSTTogZHRz
OiBhdDkxOiBzYW1hN2c1OiBhZGQgdGVtcGVyYXR1cmUgc2Vuc29yDQo+ICAgQVJNOiBkdHM6IGF0
OTE6IHNhbWE3ZzU6IGFkZCB0aGVybWFsIHpvbmVzIG5vZGUNCg0KQXBwbGllZCB0byBhdDkxLWR0
Lg0KDQo+ICAgQVJNOiBjb25maWdzOiBhdDkxOiBzYW1hNzogdXNlIG1ha2Ugc2F2ZWRlZmNvbmZp
Zw0KPiAgIEFSTTogY29uZmlnczogYXQ5MTogc2FtYTc6IGFkZCBjb25maWcgZm9yIG1pY3JvY2hp
cCBvdHBjDQo+ICAgQVJNOiBjb25maWdzOiBhdDkxOiBzYW1hNzogYWRkIGNvbmZpZyBmb3IgdGhl
cm1hbCBtYW5hZ2VtZW50DQoNCkFwcGxpZWQgdG8gYXQ5MS1kZWZjb25maWcuDQoNCj4gICBBUk06
IGR0czogYXQ5MTogc2FtYTdnNTogdXNlIGdlbmVyaWMgbmFtZSBmb3Igc2VjdXJhbQ0KPiAgIEFS
TTogZHRzOiBhdDkxOiBzYW05eDYwZWs6IHJlbW92ZSBzdGF0dXMgPSAib2theSIgZm9yIHJlZ3Vs
YXRvcnMNCg0KQXBwbGllZCB0byBhdDkxLWR0LCB0aGFua3MhDQoNCj4gDQo+ICBhcmNoL2FybS9i
b290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgfCAgNCAtLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMv
c2FtYTdnNS5kdHNpICAgICAgIHwgNjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAg
YXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcgICAgIHwgIDkgKysrLQ0KPiAgYXJjaC9h
cm0vbWFjaC1hdDkxL3BtX3N1c3BlbmQuUyAgICAgIHwgIDcgKystDQo+ICBpbmNsdWRlL3NvYy9h
dDkxL3NhbWE3LWRkci5oICAgICAgICAgfCAgNSArKy0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgODMg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQoNCg==
