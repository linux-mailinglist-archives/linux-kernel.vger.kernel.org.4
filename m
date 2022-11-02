Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100EE616EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKBUnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiKBUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:43:30 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A97642C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:43:29 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2106.outbound.protection.outlook.com [104.47.22.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-53-MXTgmva-O8umtnCKWfi7dw-1; Wed, 02 Nov 2022 21:43:26 +0100
X-MC-Unique: MXTgmva-O8umtnCKWfi7dw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0064.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20; Wed, 2 Nov 2022 20:43:25 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3c38:efa9:5eff:4caa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3c38:efa9:5eff:4caa%5]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 20:43:25 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "haibo.chen@nxp.com" <haibo.chen@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: mmc: host: sdhci-esdhc-imx: async sdio interrupt and hardware
 auto-tuning
Thread-Topic: mmc: host: sdhci-esdhc-imx: async sdio interrupt and hardware
 auto-tuning
Thread-Index: AQHY7vvBPuBMSDYwj02mBK2khue+6w==
Date:   Wed, 2 Nov 2022 20:43:25 +0000
Message-ID: <a0bc23f0d7c4996b208c46508f9981a5804ab94d.camel@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0064:EE_
x-ms-office365-filtering-correlation-id: 79269e30-2dd3-47ea-14c2-08dabd12e3c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: YWCrUELzsRNJtma0A3rNN3tpjfLhIIa087JKJcg0nCXfxWrqfG34hFMwmy1RZgZYXOl9GOfVPexwafnz5Z6QfY0nWRJucbuF1R13EebuAv0W6bzMd1r2CSNKfklHq6MPUB2gbuxD2DPWSRHvXgDsaEPHiMYPayv6rrMtmT0QdG2jylry55+/kONtdUGSpdwXd/Bx5kE3dxI9n2wjfCKvbTdvcMSPnKKif3mjuGWou2e9MApnzekQjlHYNmETRbHRUfz7Oyb6bEHHXxBW1XdzO8VuwuY2EmD6WiSmbiAjbDFJkwa2nMMunYL6yivMmPF/WubUUE3y2WZTOmwiXAURl59kZpiUjOBspyFQdJhRWkbQdw40ilroSpx09bRNJrKop5pPITnuaXMmDzJdQuH0n8ttSUp3ewtIuGO+SNsNMjjDbhnapMe8OZIxQzeW5G8KzKPR6triCg8bA0W4eFXInbeQJDCTNY8AkV2/Gp/O+GfJIYtQsQw03W1tmmzND4IEmOWjYIH+nqYjEnXlFyApk+QiayGoQaLZzEN2rjdwPmC0Z5zrAc7o5+PsVE043Kz+ogWUk0gHFTcn1armtDvlcv1vJbEGkzxBHw00JYLmYuB0ZmaWjdiHy0egm8hkM/xH2nfDDN/Fa4LO/cfu52hl+si81z9xS+IVV/O+vYGLf9nPk3DiQzKuYhc2Z8qQw3V1wMqsaEjE/tgMIsuWzgELkJDZk72JdQzqFkUPJg8Y6AGr7ggbeRTihm66JULrD9AXWnrytj5SEKfOoUXeux6MrN3o/zQOAV/ZdHodyouLCjI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(451199015)(66556008)(8676002)(64756008)(41300700001)(4326008)(38070700005)(76116006)(8936002)(54906003)(110136005)(66946007)(7416002)(5660300002)(4744005)(316002)(66476007)(66446008)(86362001)(36756003)(122000001)(38100700002)(6486002)(83380400001)(478600001)(6506007)(71200400001)(966005)(6512007)(44832011)(2906002)(2616005)(186003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGRFU0YzK1FoY2xkdFVJOGZMVFIwU285OVk5cGkzZjdEblVPQmE1S0R5REdx?=
 =?utf-8?B?Q2w2TklyMDg0cFQyUHk4Wk5HVVRCL2lkMTBxZll1YmhPb21aUjJKRzNOTnl2?=
 =?utf-8?B?NzRna205MDArdTBzcHlwLzU0eTMwSUJzK05QVktWd1U3WkVrQjBkMkJFbUtQ?=
 =?utf-8?B?cTA2bG1rQXA5TjIrb1QyMmdETUpqOVhGRGZTYllnMEpWcUF4Q256c1pyQmQz?=
 =?utf-8?B?MkhnK3grMG5ZV1ZxbVBlZ3h4aFJYaEdNcTFUK093a1gxOHNkWW9OQUc4SzFW?=
 =?utf-8?B?K0VYRG9qRlhjVWhicjMxU2hxZHBPTjdocmczNGVaWERmUHROL2ZnWSt4U29X?=
 =?utf-8?B?WkRlQ2kzb29ETlJIVVZZbzY1aDRLd01FNkZxZGwyY0FqMHU2NE9SUmRzNm9u?=
 =?utf-8?B?Nk5KUytHYkZha2RGT1dEYmpmZXIybk9KSWxwNDlVOTFnaGpleFhGTlJDdFln?=
 =?utf-8?B?WnRZRnlXWEh6M0dNTFFTeTY4MlhGRndIMmg4eWxqS1lTcXRaWmIyTHdhcUR3?=
 =?utf-8?B?MUNkM2NMTkFtM1h0WWlSZ05ycm1QaWc2cVlLa1YrMWR2dUFTK2M3NVJqalFv?=
 =?utf-8?B?Y0EyaE1vYWs0T0NvcWF4Qm5xaCtlWGFkL0dNY3dYSjNkOHBUWndBb0xwTERK?=
 =?utf-8?B?WVhBQSt3dVpGQ09UN2hJaVd5UVl5cG5aNng2SW5EWXZKcWNqSEEwazQvTWdV?=
 =?utf-8?B?QjV6ZDZUYkhsVzBnbWd3MHpNdDduQ0Y1djZOdThtajhoNGo5U3Zidko3Q1Bi?=
 =?utf-8?B?MjRDdk5wMzU3alk4M1NZbFJRTk5mcm9jOThraklxRDY4TnNNTVZLajdHcFY4?=
 =?utf-8?B?SGxDZnhTZXByTWRIaG1vVkFyeU1BRW1HZ2ZsUEthVVF5SmJDUlh2VVUrL2xi?=
 =?utf-8?B?aElwTytyN2VaNytTMGtlamU4eE1WWGkxa0RpZHY3ZGp1UVpyT3c5S2Nvdmxm?=
 =?utf-8?B?N0E1c3c0ZVF3bTh5MlNQT3dUbG16Ykd0TFFNanJBTkdqRHRYUjZKcCtFaWFH?=
 =?utf-8?B?eS9ab3dlUStIZTRhN2xqNmkxQjhTR2tRTTFnM1dRR1hsVHlndFNJY3J5VXND?=
 =?utf-8?B?VEV4MlBFQVJlbXlPNjAzNVRuUkRpRFJqSmVXMFQvMm9vUmZEOGt5cHdqOHla?=
 =?utf-8?B?aVRwRS83Y3FMcWp3TDRyTnB5Q2pRQjJVMThFaFlQZEpyMjF3UUhnTXRCN0lK?=
 =?utf-8?B?a0ZzUkVvd1lLaTk4ekkrZEJMSGc4bXlKOXVqKytuSE1YTUVhUFBsVGwxamVv?=
 =?utf-8?B?MGd3UGthVExtQkRZbm5obXNWQUplSy9xdXViWTBKUW1CcE5XZGp3OXpOLzhl?=
 =?utf-8?B?ZXo4QklmR0Y0YS9Pd092UzZiNFM2WEdRRlFzeHdzSlE2VElMdTQ0emJVdHds?=
 =?utf-8?B?d29LVE05NnVMK2lTajJXVkRwTUxYb0lrY2luUUZyL0c5RTRzVldPY3V5b1ho?=
 =?utf-8?B?aFlYY3QrbkhIblIyWG92UVlZZUFKTFUrTVBBdkU0OWEyYk90eHlmN0NHdFZn?=
 =?utf-8?B?Zk9HN3JyTzlUQ1U0UUNiUnMvQjluRmwxMEZHS0Rla1ljdzBrSkxCOE8wR0Vn?=
 =?utf-8?B?WDdjRXBWcHIzNnovTjU5MmVIaWtyek9SaTVJRHEvZmRYUmkvSVowQU5YVXJP?=
 =?utf-8?B?MlVzdnZIYmVDS0ozaEJIREprbG5GVnV5Rkg1eElRQmhDam1DdW40N1d6Sy9D?=
 =?utf-8?B?QyszT3N6b2ZES3lwQkhwaDMwNTFBYkNBZE5qRUVsRmRkL3krUFpBWVdxYWRU?=
 =?utf-8?B?SjB0ZkNjLzRBY1I4YTVad284MHYrSXR6cXJjYnlGcE1KcGdmODhlN1liM1VW?=
 =?utf-8?B?WkVBeFVtbVYwYUxsY01yOWJCdWpvNUZDeU1qWGFYN3h3emZYbytwWHhMUlN3?=
 =?utf-8?B?ZitxbkRVdENEUmp0Z1YybjZSbDlUdk5zamVXODFCTjZ0RUxKTmlLcU0vWGFw?=
 =?utf-8?B?ZkFRRkpKMzNKQmd1WW1vTDBpdHRBQ1QvNkN2bFhnN1FCdjNST1lsczloZStU?=
 =?utf-8?B?MEJ2VE9BL0lpeVYyOTVwTVJyZFIrQUZSVGtlVjhpOFJkUlg4eGYvcnBCRlE0?=
 =?utf-8?B?ZXVheDh2WU1Wd1FxZEQ2Qk11dkNpWFVOazFVeDBxM3ZuZ1M4c05JTjY2NHNw?=
 =?utf-8?B?ek9wMHlXRkdyRzUxRTUrVXEvbGd5a2QzVzJIOXNBNDNvaGNsNkNCYmtQd2JC?=
 =?utf-8?B?UXZFQWw4MEhKQkhZb1YvdnJoelBTbzhqN2lsbDBaemZrRmV5MzkwQXY1OHpi?=
 =?utf-8?Q?rKVSZie7iZRY/wUFby9E8U325U0yb365vAliptBSL4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79269e30-2dd3-47ea-14c2-08dabd12e3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 20:43:25.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sApYc+X6YVCyuH62cxF2UZQDPyjXThScvdHZYMypSanaUWFlxQDF+JC8zGBikC3RoW3esMkBsVm2LaAmztAely5/u/VcahNXX3ualxoIfvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0064
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <40EEA47F3E3B744AA9471BB81EF69CDF@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgdGhlcmUNCg0KV2hlbiB3ZSBpbnZlc3RpZ2F0ZWQgYW4gU0RJTyBXaS1GaSBzdGFiaWxpdHkg
aXNzdWUgSSBkaXNjb3ZlcmVkIHRoZQ0KZm9sbG93aW5nIGRvd25zdHJlYW0tb25seSBjb21taXQg
aW4gTlhQJ3MgbGF0ZXN0IGRvd25zdHJlYW0gQlNQDQo1LjE1LjUyXzIuMS4wIFsxXS4gVGhlIGFz
eW5jaHJvbm91cyBTRElPIGludGVycnVwdCBzZWVtcyB0byBhZHZlcnNseQ0KYWZmZWN0IHRoZSBo
YXJkd2FyZSBhdXRvLXR1bmluZy4gQXMgYSB3b3JrYXJvdW5kIHdoYXQgZ290IGltcGxlbWVudGVk
DQppcyBhbiBmc2wtY3VzdG9tIGRldmljZSB0cmVlIHByb3BlcnR5IHRoYXQgbGltaXRzIHRoZSBh
dXRvLXR1bmluZyB0bw0KMSBiaXQgb25seSAoZS5nLiBvbiBEQVRbMF0pIHdoaWxlIHRoZSBTRElP
IGludGVycnVwdCBzdGF5cyBvbiBEQVRbMV0uDQoNCkRvZXMgYW55Ym9keSBrbm93IGFueSBmdXJ0
aGVyIGRldGFpbHMgYWJvdXQgdGhpcz8NCg0KV291bGQgdGhpcyBiZSBhIHJlYXNvbmFibGUgdGhp
bmcgdG8gYWxzbyBpbXBsZW1lbnQgdXBzdHJlYW0/DQoNClVuZm9ydHVuYXRlbHksIHNvIGZhciB3
ZSBoYXZlIG5vdCByZWFsbHkgZG9uZSBhbnkgZXh0ZW5zaXZlIFNESU8NCnZhbGlkYXRpb24gdXNp
bmcgdXBzdHJlYW0gYnV0IEkgcGxhbiB0byBzZXQgc29tZXRoaW5nIGxpa2UgdGhhdCB1cCBzbw0K
d2UgbWF5IHNlZSB3aGV0aGVyIG9yIG5vdCB3ZSBhcmUgYWxzbyBoaXR0aW5nIHN1Y2ggaXNzdWUu
DQoNClRoYW5rcyENCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9ueHAtaW14L2xpbnV4LWlteC9j
b21taXQvODRjNTI5YTE0NzRhOWY2NjE0ZTQ3NWUxNzhjYTVmZTIzYjYxNzdkZQ0KDQpDaGVlcnMN
Cg0KTWFyY2VsDQo=

