Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255B6C4B41
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCVNFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCVNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:05:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2112.outbound.protection.outlook.com [40.107.21.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CCC2B629
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7++bEnOyVnZUR58AU1izgHUPAPyuruEx+F/M0JND6fRVirRZRAON6a8OEgBeLYcm7abzu+8jh2VXXZesN6gzcY/fRI0jRm7Rm74LSmzK0T3KXkgI9hiSNNWIppUdoFBeyzM1UrhQWsa/GXkOKYbFLkHCnF2uAq8Dqn2Yhw+6cuWsZkM3kSr4TOYqh/SFwUY2iOa1FZnn/GDCLIyxYSUEgkIlQ98FIPbD2Ty12Kl7k/nPaeKDSjUPCan6kwzL2ojgb/ALb6iDdU8CmmKGu7+KrgAqIcwkFDFmxYaMf4H+3nIKWaYrvkO42h4ZxSeKOTxiSHGPi9CcfWr3XC0SPMleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yprjGdPE5ATSI19w2YA9CQnyBTrRYP9LNEkN3EGZsIo=;
 b=ckha8dExjFyQTlqIfL4zNGh4duC9Z1YAKGfaKpodLmXNjRxXg5H7LW/+UM/PgIDm5R/pzF0yl/s7AzECLtKHzV64v7yjwSzzZ/Ujp1StPzrQ0Nofi16n0GGhh3MFkJ0foUzGWpHM3PNzn8kksYioe4CcTMvVtC9MormqxKS6SkwZS7hOBmZqOThOgGsZQljOCYtuIqCQ/J7zB8vUo8Dhg8qngHkinAcIoRjBQyOrlSGuNRynelZW2Q7C2PpCedWpKW2mZ6YJz6uVWtxW9oeRsWxxF6wNcTYyCwAEyy5DvX1R34s27cdcM9c9tkc2TmkDlOZhnC7nXDWV1kKOko0Wyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yprjGdPE5ATSI19w2YA9CQnyBTrRYP9LNEkN3EGZsIo=;
 b=qKFrZQMjuOXTjyxgudO4XDAMkM6J/8+bbzVWhIP7tAMcRIW8Q8dIUvy2MANidbkEcHv4zjWM+70LjHKRRwobiJPfvyELFHzVR1LNcyyq91pfMhbQQ+9vdW7id2jEsE94dyU3I0dfivT+MWLrKe3XTLtwHpfXtbXI9r9UYYwsQm4=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DBAPR03MB6472.eurprd03.prod.outlook.com (2603:10a6:10:19b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 13:05:36 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::8fbf:de56:f9fd:ccba]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::8fbf:de56:f9fd:ccba%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 13:05:36 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency
Thread-Topic: [PATCH] extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency
Thread-Index: AQHZXK/d8z1DWQlCSEio5x3md3BJU68GxJuA
Date:   Wed, 22 Mar 2023 13:05:36 +0000
Message-ID: <20230322130535.zxity55h6u3hak4f@bang-olufsen.dk>
References: <20230322111708.1042312-1-arnd@kernel.org>
In-Reply-To: <20230322111708.1042312-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DBAPR03MB6472:EE_
x-ms-office365-filtering-correlation-id: f0bc19c9-5d30-428d-8def-08db2ad62096
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aza4viL5PVbLiydlHMu++uthycqBFNraczGeGN+/IvbTy/oYLOydHd9z1OWOTQpE/0EfQQfY2+ySzFZ9+7XtfYpAILn65YDZ+N6DD4WPYJZApI01AmLC8tVRwCHrd4WKgY03oSCzdKtHdpWCOpf855Uhsz2rA4KgsVTOKxYyfyjk1qeJCRtK3YFqk9bNzV5PThoV0Nz3EijsQn6nu9nTEtIIw55zwEGXG58bjSCRlWMIv+p5xIwLI2llNxl1rJPAorQeW/lWGzafEIrpLcmA0lyPLLckTBvmci14B7qoeTrobuxzh5ZsVbUQEHmbcuhB7tqVHC0WoR5tzz8ulCbfvS2DYli9cWeI4vO3GJ81VAitlg/HNiHgHxI50znjnwI7qFno/fvIFLQ4Qh8YaU3UDvdZL5IAUDCY6epy8/jiY6et+NFu6MEnWqAcJxUsXYgPVMAUcsAyln/xhC8WRnk6WH8yL8pkBlbgpdq87wBK6ADkSIJBReeUAQOe9IO09Gg0EDnY1/19hXZzgTIT62qGmoX/u4eqU4wpZM6qcaiMqsexD32OOBC9cIxOKDTQXhMlLm8J7107wIVRtvc4Ak9cmN1/69Q7CXlc1dQpgL0am8TIdlyXDYnzw/01qGBPKNqlXErWkDZTI3VmHupZFcsW3adZLe0g2HNhnOFQBF1iyGUT48A1zFRIXBJ+aHVC19dTcRbAcOvV++WMq6qgGDzyHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(451199018)(66574015)(71200400001)(2616005)(26005)(122000001)(1076003)(6506007)(6512007)(54906003)(316002)(478600001)(83380400001)(2906002)(186003)(66446008)(5660300002)(76116006)(66556008)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(64756008)(41300700001)(6486002)(91956017)(8976002)(38070700005)(4744005)(38100700002)(85202003)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STVMc3oySVYraW16MFlmUldjUlFKakZ4OGJ1SzQyVU84UkdQWkdDRnhnS1Va?=
 =?utf-8?B?Y25lbDM0Q2dqMEJmWVlhSWRmbWZrRHo0R2ZXUG1vRnZBSkdKNnRIeksycWFJ?=
 =?utf-8?B?N1FpZFFDaVRqOTE2eXE2SXdUMmFNeWpTcmlkUnVySzlsQ2tQYkpsZmgzRy90?=
 =?utf-8?B?KzNyUDlJQ2VMMGFGekpyUS9GMGlKRVZ5aVAydkFreUJJWXlXckZKWS9Ec05o?=
 =?utf-8?B?ODYvNHNOdVk5Wmtrb1dFdGd2NkpoNkJOOFc1RGtIQXpmQmRsMlNocG0vUDNC?=
 =?utf-8?B?S2tCUDNkVjhBekowaldhNHN4YzR3TE1BL0E5RVJwNmVnZ21nRHBKTU51My9M?=
 =?utf-8?B?a1VKS0U0NGJxUFF1QmRnbjQwQURhNGEvQ282Y1lHZmYrRGc4cVp1bE9meklE?=
 =?utf-8?B?S3lNV1NXRmNzT0xEbEN4V3BvWGd3TGVtZHdZNlZQTCtUZzRuNzIwRzlUVWNu?=
 =?utf-8?B?OUdqcGswakNQVlhtNm5TTzlFck45TVRIN095dXY4S1p4UjFuV29NaFpLbTRl?=
 =?utf-8?B?cTRsbHFYbXRqVmRnT3A4TVRtcnZ6YW5QUW1rVGhURXptYUY5ejQvaENTeG15?=
 =?utf-8?B?ejg0Vk4xT1p3UHFCUnJqVHEwbzVVbFVzbXhxb3JXZHI2VXVoUU9rUldWZDlj?=
 =?utf-8?B?UzhGZE5zVnpuaGVvaGo2Nk1TQ0djT0dxS0RUanUvYTZGZTN2ODZ2ay9JZGo3?=
 =?utf-8?B?NU9UTFYyVDN3YUYzZWpseXJlNC84dzlLR2lzci92Wis5ZC8ydFBDNysrQTJu?=
 =?utf-8?B?akpOcW9KbCtFLzVKRVc5c0hjbVpkeXdSV1F2bXZZQmhtYUZqaXBEV2RZYkFJ?=
 =?utf-8?B?Z3dxdVYvSHI1UjIyaEVrWGVucGtleWpROEFwYTZuT1lSbzI0TjJabXhIa0VI?=
 =?utf-8?B?SWhjcUE4ZS9OMnNwSWhySE5uRWhhdUFCOTI5dU9JZ0Z6L205a1AzNWRPRGdV?=
 =?utf-8?B?d3BCclFxQmhzampkSEdVZEVBU3lsZmJ1cHBMZi9KaGFiVklJNWhHMlUwV2hn?=
 =?utf-8?B?OXFHU0ZOQTNCSTZ4NjF0SmJZTUZxeFZGcDNmNkxkT0h6NmhNSmJlaHk0eGRT?=
 =?utf-8?B?TCt5R1NWTzZWZ29ZRHdwSm92cVd2bjNMakRyVTZQZklWek1PZ0FiYld5Z0s3?=
 =?utf-8?B?Vk5ENlMyS2NkSHVpN3dqNXlaWDZrV3U4Q2xkL1lQbFBJTkhvNnVPZEV6S3dw?=
 =?utf-8?B?VnBOVUoyUzBudmpiWXN6WnBySDNZUHo4Skx3eFkrMGZkams2cUxQUUpIdE9X?=
 =?utf-8?B?NGxCVTczdFR1a1VQczdvODJSYzljdStZMHFrdUF4aEhVcUo3bXh2UHZyLzJJ?=
 =?utf-8?B?Wk9UR0U3RWJVb1VKbWF3TEYvanYraVNIazZueU9tL3hGTkt2WlNaSU1lcTg4?=
 =?utf-8?B?dUdtaUtsVFNOUmx6aTN5QmpRRzN0endqN2s3TDVJcTBsOTUrL0MvMnR2Ylo2?=
 =?utf-8?B?dElOcHplVWlISTdGMGYvVzlsSkwwYjJRWGZBY1crbGxUZTU5b1l1aG96L3JZ?=
 =?utf-8?B?ZmkwYkdZY3Exck5nendxZkxrWExmc3RSeklwek03aXhJTzhQU3JzMzhMbzJD?=
 =?utf-8?B?RnFTUE1jTU1CcjQyT1NZRWtSNjhWQmtoZDRMQkE3MjlPdWlndksrNEdoMFVu?=
 =?utf-8?B?RXBiVlFLVVZqcnZXTWI1aEgrc0thbXlTWTRpYitnNExWNUF1ckwwQ1lRSnh6?=
 =?utf-8?B?aUMrWEJWOXJoN0lFRnFJeWx1WUNFaHYyc2UyK0VYQ1N6L0dWdW5haG5mNDFJ?=
 =?utf-8?B?T3pDNFpCemJHM0VGY2dTZjFqd0ZiYlVxZmZjUVduMjlTREtaTU5Hdnk4VkNt?=
 =?utf-8?B?Q0s3UmRuaHdGbzU2VHRmY0U2WDhYanZwS21mNGhVSVljdVNYNzNQQk0zTlVT?=
 =?utf-8?B?QStiMDRlRzNLMldBcTQ1N0NNY01jRGtib0V0dmo1aFFmOGd5NHAzSkliQTFN?=
 =?utf-8?B?YisvdlpwNkdkMW93S3B3dENoNXVnYXcvTXprc2Y0SHNEbVBRN21uaWsrbTVS?=
 =?utf-8?B?UjBteU50VVl0WTMzdWdyVmUybFFrMHJxNlpWVHNUWmJ6UVZPeTRac2sySjBp?=
 =?utf-8?B?eFV4alI3KzU5Y2pMV2JJOHgzVk9BbjJrMEEvWUNBazNhM1dNdUhTVDFxSkNm?=
 =?utf-8?B?RzgyUkJSZ2JlTU1NaHBvY1VYS3dhb28wVXA3UE1hOWVFNHNnL2lpRGo1ZDN0?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAEF4B5B27BBCF48A027AA32D5E010D7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bc19c9-5d30-428d-8def-08db2ad62096
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 13:05:36.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rfwBalno32D7ZB0pjpEv5fgwijhaFI4Sjkqg49/Y4ezRA43ogAPlvH7fkJqgaaKE7mtv46J6l6A9pJXF9QQzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6472
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMjIsIDIwMjMgYXQgMTI6MTY6NTFQTSArMDEwMCwgQXJuZCBCZXJnbWFubiB3
cm90ZToNCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IFdoZW4g
Q09ORklHX1VTQl9ST0xFX1NXSVRDSD1tLCB0dXNiMzIwIGNhbm5vdCBiZSBidWlsdC1pbjoNCj4g
DQo+IGxkLmxsZDogZXJyb3I6IHVuZGVmaW5lZCBzeW1ib2w6IGZ3bm9kZV91c2Jfcm9sZV9zd2l0
Y2hfZ2V0DQo+ID4+PiByZWZlcmVuY2VkIGJ5IGV4dGNvbi11c2JjLXR1c2IzMjAuYw0KPiA+Pj4g
ICAgICAgICAgICAgICBkcml2ZXJzL2V4dGNvbi9leHRjb24tdXNiYy10dXNiMzIwLm86KHR1c2Iz
MjBfcHJvYmUpIGluIGFyY2hpdmUgdm1saW51eC5hDQo+IGxkLmxsZDogZXJyb3I6IHVuZGVmaW5l
ZCBzeW1ib2w6IHVzYl9yb2xlX3N3aXRjaF9zZXRfcm9sZQ0KPiA+Pj4gcmVmZXJlbmNlZCBieSBl
eHRjb24tdXNiYy10dXNiMzIwLmMNCj4gPj4+ICAgICAgICAgICAgICAgZHJpdmVycy9leHRjb24v
ZXh0Y29uLXVzYmMtdHVzYjMyMC5vOih0dXNiMzIwX3N0YXRlX3VwZGF0ZV9oYW5kbGVyKSBpbiBh
cmNoaXZlIHZtbGludXguYQ0KPiANCj4gQWRkIHRoZSBhcHByb3ByaWF0ZSBLY29uZmlnIGRlcGVu
ZGVuY3kgdG8gcHJldmVudCB0aGlzDQo+IGNvbmZpZ3VyYXRpb24gYnV0IHN0aWxsIGFsbG93IHRo
ZSBkcml2ZXIgdG8gYmUgYnVpbHQtaW4NCj4gd2hlbiBVU0JfUk9MRV9TV0lUQ0ggaXMgZGlzYWJs
ZWQuDQo+IA0KPiBGaXhlczogMTk2ODVhZTQzNDg5ICgiZXh0Y29uOiB1c2JjLXR1c2IzMjA6IGFk
ZCB1c2Jfcm9sZV9zd2l0Y2ggc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21h
bm4gPGFybmRAYXJuZGIuZGU+DQo+IC0tLQ0KDQpJIG92ZXJsb29rZWQgdGhpcyBwb3NzaWJpbGl0
eSwgbXkgYmFkLi4uIFRoYW5rcyBBcm5kIGZvciBmaXhpbmchDQoNClJldmlld2VkLWJ5OiBBbHZp
biDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+
