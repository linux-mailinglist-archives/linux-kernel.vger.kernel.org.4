Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E864616999
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiKBQrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiKBQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:46:54 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEC02019F;
        Wed,  2 Nov 2022 09:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwbBEKvqVem4bocjjAPLT+v5roZxXu5Ktiw0hWsyx/c45mcaWrYr5rzuKB3CZAP0hPfuC6uEsthhaBsXY8nj+WYYaTbYhBEt60X1rmBbbj4qUjCtwGOzQtWjt7pTOqZHtgIy0EucbYwStTwIag5A2ME5BTwVZBMYRppu4d/NbSsjgggd8kSpf5stlq6eFUPkwkOLvO/tqZo5gSzhhosaXHOIX4vZZInjyU8NTdEiR1r0wcf1WljFaoGjsufT9RoqTV41gUobzkasAif5ANWP7AFYuzQ8j1z/NoCuy/sv5jcUXg6tByQ4c4i53Dm1KcoovP16sAlm7fVokywufIo0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4uV1CnOdSdbUmvSymAdh60fzr6NuDlKylPnHqRl9Ag=;
 b=RvBnGjILcqZMxzNYV94ibXAVLuTHPbe4sTjRRg4ORCqzGSAiWqpJuU9FXnrFG8s7pILg7PltBsx6RZh7rqx+t30iHwwcVvfMJVddKxgXu4mYY9lQ4jtR+b6gzpAUFvLutrXDg65tgLGB1e25lS6gwDrTZ9+YUE7OtQjqyso5BK7ricuTFo1Yv2QwNb8vz2wG2B4l7ur8vKtRPGw4gPGC/G1JJJhnUAIi9qLZtE4wIF3dPqH3wmdjsILbaDLfU6WPKdvBA/vWpp29EDUWXwvL1BiCCpsqI/WY4uOeK6bopbUNGwKHiqWY3Ou4e2pmTML8SdF/Prmoyk/Diggkffhxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4uV1CnOdSdbUmvSymAdh60fzr6NuDlKylPnHqRl9Ag=;
 b=Sehs1dq1zH0KZKqQSv4D4D2d+WwOOZDzLJTYl7c32hKPN1/Fg+3biAZuTtlfbqS+Z6oPrcGv2jEQ/K2dmf3UrTj2NmYrwiSvih7bbulITTJfa3fvA79CjU8NRI1U4x1JD79TwNG78hnp5vuD4KfPHBVLzd801BfJ+1Fu5Z0DB6g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8596.jpnprd01.prod.outlook.com (2603:1096:604:182::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 16:43:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 16:43:28 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] pwm: Add Apple PWM controller
Thread-Topic: [PATCH v2 2/4] pwm: Add Apple PWM controller
Thread-Index: AQHY7scaJddHyAtwqkGPO5YDCJjX564rwPswgAAJOYCAAABF0IAAB4MAgAAAYqCAAAPUgIAAAD6Q
Date:   Wed, 2 Nov 2022 16:43:28 +0000
Message-ID: <OS0PR01MB592280D795F3F6E1B4BBAA9786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102141513.49289-1-fnkl.kernel@gmail.com>
 <20221102141513.49289-3-fnkl.kernel@gmail.com>
 <OS0PR01MB59227A9E7B8A471E4D6B665786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTT1ptFymwDdOe=OXYzKfOPHdQbAfpx_9LBYn+C9NFhddg@mail.gmail.com>
 <OS0PR01MB592217539BCA46FD8F523C2386399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTQLJZsDSOtcQqV8e_j0XKfjNm+dVjeo7ocMjcYOPLAPvA@mail.gmail.com>
 <OS0PR01MB5922EC4F1AF0D8501D7CB1BF86399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTT+Z=K7BNq=KWGxaT=x9BOfdDecsZ6E7eGhjN5OHRjy=w@mail.gmail.com>
In-Reply-To: <CAMT+MTT+Z=K7BNq=KWGxaT=x9BOfdDecsZ6E7eGhjN5OHRjy=w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8596:EE_
x-ms-office365-filtering-correlation-id: 8d4a28d7-461c-4915-b739-08dabcf15e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: adYgHThFPz8f58uysT0Apb0VIiAN78Rmroy2ydsuDCpCOzYfHQ4J30l4sCssPund2kPD65Q4Ak+oeQjq/eMWtTN/5YbRzRXbgLCuB3CWZ0LsyQ8jegf9Dwc6n7QySj4hpHnonriepU3nKFhrcWCr9ShpWY3s6MOKyvTKajMi6ynQ5qv7SsNxG0Uy3uD1EsaZDIRyAWynUD/uSjNzEbxcLdMF7AIOPqSptpcyGj9ETG0uvZ7oVwxLDlwhIrHq1ekUfZCeV+ingXpKXAmT6jOWc0PlZ7TUc7WcuA1aeVMqtdhnwpLUgUkPNwKtGfPzGXL8iyUFHBleNxBS77FH2qXnId4scX80G0ohKgLQnlIwPPOQ4QVCvGKTx1pN1+eBymbn0/y84ivJ5yezJFYFoen7ddMkLijD+G8dBYyr4nTGaOytr5Mcb+33pYiSQIIJndrTA5NtmQKI/Y/dwK4ECA5nNnNuDYMmHC7d0FEdl0qx9nYduazddldaMbFWxO1BCB+o1MvbBWN34MBfBVVda/K7EpIw/JqizBlsGsBCoWVS0WQ+a6O6rrNa08TT7SyD2RRZS7USpUaqHp99n1wUWPlSGyON6zeqeYOmNzQupsxjIWxfTYWpes8axiGa4xXsRW0jhIkVPVKanDLrEV2woxW7FIZky+9FpkFkmrFQtXZSCNPsz1JR6Q7TiS3kugB24Hkl6mR3uxG8nocqFdQpwxiCktcULjxV4S2ZI0VPPYe68viWXRjyEIKID1gJoQdd2k0CeNoVgGkhYQw9gT5L3DMXegxwiiWJweSC5cObHR91UTo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(47660400002)(451199015)(7416002)(66946007)(6916009)(2906002)(33656002)(38070700005)(5660300002)(71200400001)(55016003)(54906003)(83380400001)(66556008)(478600001)(4326008)(64756008)(41300700001)(66446008)(316002)(66476007)(8936002)(52536014)(8676002)(76116006)(186003)(4744005)(9686003)(122000001)(38100700002)(86362001)(26005)(7696005)(6506007)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REtnMGQwUFdocDlITEZ1OWZ6VHAyNld4VXVPS1A0eUdZa1E4cFkzRjlWMXFU?=
 =?utf-8?B?Yk9NOVZqc2R4SGc0WUVLZFpBQzFmRyszOHNCVDZvcVVOK2doSnRZSnhyUGpZ?=
 =?utf-8?B?YS8vNnFlUEJJVHVGTUpmREJRb2lNaC9xZVI3WXZpTTIyeHdiTFd4dWhteUdu?=
 =?utf-8?B?NGFRTkhBOTIwZjlNbnc1anVDdjZFTjRwNmpucktEaXVOQTVEcXpqcnJ6b2pa?=
 =?utf-8?B?aXJqL2k5L2R2UTg4ekJtTjVTZHhmYnRhcjV4NVFuV29KWlJFTDRHcEZtWlhO?=
 =?utf-8?B?K1lZQkRLNC9iaWxRdkxyUXNNMGxkV3VsWHQ4a3p0L3hWZnIwMDVKUVFydncw?=
 =?utf-8?B?Y3Azd1JxaER1NVRFS2lHUzhuTXAwWllQcUR3Zkw0OXUxMkJ5SGVDNTZSZmlw?=
 =?utf-8?B?VUZBQzVTa1Q5dGxmTmNCS0hCVHRVSmU4WUl6N2g2NjEwelN0ckdWbXdmTnZv?=
 =?utf-8?B?T0xySWUza2t2enlocWNxeDRVWG5nNDdibEEyRFF0SGRGNE82TEo4SDMwVHUy?=
 =?utf-8?B?VWtQZ3hzTXpHakZGTUF6cUt3M2xNRmUrbWQ5bEt1V0JmNkppNmxlMEtJMDZx?=
 =?utf-8?B?cTVvTnNOb2tRdUwxREhxSWN4YjM4bGorR01NbUFuZGIzdXdKNWxtRlN5OG00?=
 =?utf-8?B?cXlPOVZpa0loWG41eWUrZEdZK0NYMGpMY2FaSVd3ejlGZGNPVDRZa0h6aCtQ?=
 =?utf-8?B?dTJjekhQZDBINTRaLzFYWVFwUlcwVDFKN0dPcXZSU1YyZ1c2QUFhZEczUHRC?=
 =?utf-8?B?ODJJdnlLVmdjcmR3QzJkVTZISFNsdnJvR09QWFpuWVBhMDUrZnIxci8zaHcr?=
 =?utf-8?B?bWdmYkxHZjJySmNvR0MyUVZrU1dpWGFuUVVDR1Y4TFQrVk1yc3JKeUlhTlov?=
 =?utf-8?B?aHNTUC9iZ2lSUjRLaTlxbEp5UWIrTkpjRHYxaUhnL0pYSWY3UDM5azV3N3Bq?=
 =?utf-8?B?a2NNQk1td1NXUnUwTXE0d0xSb1FPMXJyOVJWcm9vQlBWRzBkR2FLZEdhbzJG?=
 =?utf-8?B?Y1RQbXBKRStrUDJuaVkyMDM3SldWb0dFY1N2blVkNFBEU2tLVGRCVFRlckgx?=
 =?utf-8?B?TFl4dGFqb3BNdjhMZDhyVUgrand2ZUxSSnNRdGE5bkh3aGlhS3h4bkcyZldK?=
 =?utf-8?B?NmdHcG5pbW1LcXBTN2dUY1lOVFA2ei95T0NxSFV3d2JBWG5yTlhDeUVGSkJy?=
 =?utf-8?B?dDRHdmlzcndKS0txeW9rK1R6UURFVHYwYmVLdlZqeW1WWkVnMUFUNEhxMitO?=
 =?utf-8?B?Z2wvSnJ6UDh3bndMR0ZpVVA0U0VlSG00bEwxZS9NcW5MN0lNejJhTTNzUXlR?=
 =?utf-8?B?Y3ZiY3dCTHdVeGlzbmZDdk9TeHZwZTlQR0VxTHkwM0hhYkh2ZEsxM09BZmQ1?=
 =?utf-8?B?ZTEzWFZnOWxWSWlreVB1cDVaSHErdFN1ZktqM3pTYkNueFZqODNIR0xEU1Rp?=
 =?utf-8?B?Vkw1cXQ1WTIrUjRtV3VsbjkzR3FhTk9hMzk1VWxIK1M4bEFBdlpOWWJVZU01?=
 =?utf-8?B?YXR6OWcwcGNXeGJrYSs3elZOZCtibEZPRk1NYmI0ZEJuT1BUUHNkdGJ6VVdn?=
 =?utf-8?B?L2VZNEFia0JQM2RReEVaWklHY3ViTXl0dHZZbk14UXI5bCtwSmZXd1hNV0ht?=
 =?utf-8?B?YUNvU1Y2VVBMbm1TNFFpNDljWXlWL05xeWRlWWdiTWw5eS9ub29ISlF2TVBp?=
 =?utf-8?B?cEtRUFByTnlEbEdZS3h3eWp6NjAva3pDWmdNcmg4TjVtK205cGRJVmlCNWQx?=
 =?utf-8?B?QmJncHhhdDFLSS9QSGZiQlhlek9hdG9nVUJDZGcyREhKdXF6SGk3U0RtYVM3?=
 =?utf-8?B?QWFZL0dyRUxWOHlBZENxK05KNEVVK2dlRFJpa0VrYXlqVkg0WVUxenlRdExa?=
 =?utf-8?B?dHZHd2d2S0laMCs1YmxzSUpOUmJZNXZCK09SeFpyUjEwemxQVWNFUmM4azkr?=
 =?utf-8?B?OGYycjJsUGxCczErOGhReW82cTE2RkRnc2g5aEF5MDJMQ3pEOGhHT1lzLzdh?=
 =?utf-8?B?RGJUbUlwOGhxUVNjZ0d6TU1VbGlPTndpVzhlUHZpMTZreXhEU0U2Z1FRUDFz?=
 =?utf-8?B?cjU0cmpmbWxveHljUm1EOUNHbDZwVEJpcm1JdTVTanNBVnNZK2pnUVpSeVB1?=
 =?utf-8?B?L3RtVmxCTWlGTkUwOVY2ZURnS0Rydk00MXMyUVo2cFVNYi9ZeUx4WmpTVUNG?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4a28d7-461c-4915-b739-08dabcf15e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 16:43:28.2258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUafikOzr53P7h5KMs87pB/oSnMffMK4p40f3TdqddeXet28tlDHifS9857qLcjCRc5l8YeHJYZfstCaWghUJcqtHBASCyRnCVxsuox1Uhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8596
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvNF0gcHdtOiBBZGQgQXBwbGUgUFdNIGNvbnRyb2xs
ZXINCj4gDQo+IE9uIFdlZCwgMiBOb3YgMjAyMiBhdCAxOToyOSwgQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRoZW4gZW5hYmxlIHRoZSBj
bGsgd2hlbmV2ZXIgcHdtIGlzIGVuYWJsZWQgQW5kIGRpc2FibGUgdGhlIGNsaw0KPiA+IHdoZW5l
dmVyIHB3bSBpcyBkaXNhYmxlZC4NCj4gSSBjYW4gZG8gdGhhdCwgYnV0IEkgZG8gbm90IHNlZSB0
aGUgcG9pbnQgaW4gZG9pbmcgdGhhdC4gVGhpcyBjbG9jayBpcw0KPiBhY3RpdmUgd2hlbmV2ZXIg
dGhlIHN5c3RlbSBpcyB0dXJuZWQgb24sIGFsbCB0aGlzIHdpbGwgcmVzdWx0IGluIGlzDQo+IHNv
bWUgdW5uZWNlc3NhcnkgY2xvY2sgcmVmY291bnQgaW5jcmVtZW50cy9kZWNyZW1lbnRzLg0KDQpP
SyBmb3IgbWUsIGFzIEkgZG8gbm90IGtub3cgYWJvdXQgeW91ciBzeXN0ZW0uIEkganVzdCBwb2lu
dGVkIG91dCANCnlvdSBhcmUgdW5uZWNlc3NhcmlseSB0dXJuaW5nIG9uIHRoZSBjbG9jayBkdXJp
bmcgcHJvYmUNCmV2ZW4gaWYgdGhlIHB3bSBpcyBub3QgdXNlZC4NCg0KQ2hlZXJzLA0KQmlqdQ0K
