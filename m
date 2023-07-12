Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB9750991
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGLN1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGLN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:27:10 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 06:27:07 PDT
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C760199D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1689168017;
        bh=pRb7mD2o0+DY9C1T9i4XGPPv3Jbw0zhrdbNtVgn9fKw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Z84EFlpbA1f06IrQ/H8Nv7YUUdnAzXfywBMcIBwrdQ/L32YKKyyuuJq5gqdhPju3H
         pY8xP2S1IW0cKih9Zq+gWd+V0xkSmaN8fGcP7bfdSp7RKHV5iT/ysVwMMLMkXV/auc
         Iu1yX5qOqVY0K+sKWMkLy6CN0Qa0oCgRDks3XvQfBt/50QR7GSqTc2VuhHKdC1oSwA
         H+PFb0Cz9sM34fa6tjwIRzxI2Pif0qVrYdDhP+defD7zdtv4TAGIRqKhi2l0gu2mUb
         LM7h1PmsDRrWC9fa70ho4Wh3XuyDgodNcWxGeHVdv81VX3Z3AZRIgEi4RcNNmXIGUJ
         5qOWZfAv/AOfg==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Marek Vasut <marex@denx.de>,
        DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHZUmi9/xwYP1tNtkugFXddhctvjq8xtZQAgA1wIoCAEI6VgIACLo2AgAAF3oCAZPYrkA==
Date:   Wed, 12 Jul 2023 13:19:58 +0000
Message-ID: <ef0f6ca48d9d492c996d9533281ed704@dh-electronics.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
 <20230309092254.56279-3-cniedermaier@dh-electronics.com>
 <bb6f5cf8afd54836959ebfb0455b81dc@dh-electronics.com>
 <TYCPR01MB847111D756F520761D720716C26A9@TYCPR01MB8471.jpnprd01.prod.outlook.com>
 <02349503-4542-cbfd-2a2f-379fe8284cca@denx.de>
 <OS3PR01MB8460C4A6047EE4590D4F791FC2769@OS3PR01MB8460.jpnprd01.prod.outlook.com>
 <e7e4f933-5098-5fea-7a1d-254609c93cbd@denx.de>
In-Reply-To: <e7e4f933-5098-5fea-7a1d-254609c93cbd@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJlayBWYXN1dCBbbWFpbHRvOm1hcmV4QGRlbnguZGVdDQo+IFNlbnQ6IFR1ZXNk
YXksIE1heSA5LCAyMDIzIDExOjIxIEFNDQo+IFRvOiBETEcgQWRhbSBXYXJkIDxETEctQWRhbS5X
YXJkLm9wZW5zb3VyY2VAZG0ucmVuZXNhcy5jb20+OyBDaHJpc3RvcGggTmllZGVybWFpZXINCj4g
PGNuaWVkZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gQ2M6IFN1cHBvcnQgT3BlbnNvdXJjZSA8c3VwcG9ydC5vcGVuc291
cmNlQGRpYXNlbWkuY29tPjsgTGlhbSBHaXJkd29vZA0KPiA8bGdpcmR3b29kQGdtYWlsLmNvbT47
IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IGtlcm5lbCA8a2VybmVsQGRoLQ0KPiBl
bGVjdHJvbmljcy5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggVjQgMy8zXSByZWd1bGF0b3I6IGRhOTA2MjogTWFrZSB0aGUgdXNlIG9mIElS
USBvcHRpb25hbA0KPiANCj4gQUNIVFVORzogRGllc2UgRS1NYWlsIHd1cmRlIHZvbiBFeHRlcm4g
YW4gRGljaCBnZXNlbmRldC4gQml0dGUga2xpY2tlIGRlc2hhbGIgbmljaHQgYXVmDQo+IExpbmtz
IGluIGRlciBFLU1haWwhIEZhbGxzIGRhcyDDlmZmbmVuIGVyZm9yZGVybGljaCBpc3QsIGJpdHRl
IExpbmtzIHp1dm9yIGF1Zg0KPiBBdXRoZW50aXppdMOkdCDDvGJlcnByw7xmZW4g4oCTIGltIFp3
ZWlmZWxzZmFsbCBiaXR0ZSB6dWVyc3QgYmVpIGRlciBJVCBuYWNoZnJhZ2VuIQ0KPiANCj4gT24g
NS85LzIzIDEwOjU5LCBETEcgQWRhbSBXYXJkIHdyb3RlOg0KPiA+IE9uIDA4IE1heSAyMDIzIDAw
OjQxLCBNYXJlayBWYXN1dCB3cm90ZToNCj4gPg0KPiA+Pj4gSXQgbG9va3MgZmluZSBub3c7IHNv
cnJ5IEkgZGlkbid0IG5vdGljZSBiZWZvcmUuDQo+ID4+DQo+ID4+IEkgdGhpbmsgYSBmb3JtYWwg
UmV2aWV3ZWQtYnkgLyBBY2tlZC1ieSB3b3VsZCBiZSBuaWNlLg0KPiA+DQo+ID4gSXQncyBhbHJl
YWR5IHRoZXJlIGluIHRoZSBwYXRjaCAtIG9ibGlxdWVseSByZWZlcnJlZCB0byBieSAiYmVmb3Jl
IiwgdGhlIGFwb2xvZ3kgYmVjYXVzZQ0KPiBJJ2QgbWlzc2VkIHRoYXQgd2hpY2ggdGhlIHJvYm90
IHBpY2tlZCB1cCBvbiBhZnRlciBJJ2QgbG9va2VkIGF0IGl0Lg0KPiANCj4gQWhoLCBpbiB0aGF0
IGNhc2UsIHNvcnJ5IGZvciB0aGUgbm9pc2UgYW5kIHRoYW5rcyBmb3IgdGhlIFJCIC4NCj4gDQo+
IEFuZCBmb3IgYWxsIGl0cyB3b3J0aCwgcGF0Y2ggaXMgYWxzbzoNCj4gDQo+IFJldmlld2VkLWJ5
OiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCg0KSSB3YXMgd29uZGVyaW5nIGhvdyB0byBj
b250aW51ZSB3aXRoIHRoaXMgcGF0Y2guIElzIHRoZXJlIGFueXRoaW5nIGFnYWluc3QNCnBpY2tp
bmcgdGhpcyBwYXRjaCBvciBkaWQgSSBtaXNzIGl0Pw0KDQoNClRoYW5rcyBhbmQgcmVnYXJkcw0K
Q2hyaXN0b3BoDQo=
