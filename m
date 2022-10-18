Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0A60219C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJRDGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJRDGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:10 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20057.outbound.protection.outlook.com [40.107.2.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6672ECB;
        Mon, 17 Oct 2022 20:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv8cw6j0rycoFx2gAzq3XOmChCCEtw00QMebK0fnkkz6dgqJlKiKGDv/iKZrSVIMuj9Zrijjg/ytXs8Zk3RALbcfA//IBIBKn3IOA/+dDfKPZ+hqIoOOf6uJ7XBs5PqNyOtzB5Vlp83nt0OkBsyn649rJnMizTfzTZ2eJ4DU3WuvSC7aXRKC5MSIccZjvXoD4azsSzWVOoT3JfcWHIHxM3Rhi/nilIgi2MGSKPJfLo+vfRrr5x6mvBKKpHWrJvj2TAKTReIP2EDgWZZV5FhHDVPGGHJSwqLuHmxiTo1pdPou0kdl95gmwrhDb6uGD+h0iijG2YwAl3wB5gIzdGkoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYRyjhAD8JNZkL2avXsaphIdoI4pSlE1KIMWgkFjEsY=;
 b=R4epV4rU7BrCRBuwB1k3lA4xjckTerORoSwavbVSQMQ2fQFRcp6g/SVhKW6XUAtLwF/CKHQPsvgoZ5XQoZSXnxbE9WmgzPBK2egVFXfqFx3n/frUdSUP+9F2tRr9NbEUA6vOdf7mZkT2mVe008A6QyTS4hiv/d0NHYWTQRtKPRaLiG1rkC/VlfXDvYrouZPMY+cSIQ5+GX6af2ypgsPH0LkW7BaGEKDg327GuGl6txg514OEyMb2LwZb7ao1k+7RtJdLoa8fhzbeCRuHEFw+L/fh6yRSMGaQvp5vRW5hqFdoUeWj3DtBOoRq0q3A6lN/5IXHfr60pBtpjVZt5m3aQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYRyjhAD8JNZkL2avXsaphIdoI4pSlE1KIMWgkFjEsY=;
 b=QVYmcH3znhlkne5RvEIUjsHzKJvQUI8qxL6JG4ers2jfWQ+GrphP/5B7MceQwxGGbLY0Uax+bewO9+0putDou4KyF2D5D+Uzz0H11mcBfbCvb7TrIlppD8Gl1TolcDeW5J1nC7NGqQ71g8hq+PD4uC1ejjI2+tSrb/soyi63dsQ=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Tue, 18 Oct 2022 03:06:05 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 03:06:05 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 3/5] mmc: sdhci-esdhc-imx: improve imxrt1050 data
Thread-Topic: [PATCH 3/5] mmc: sdhci-esdhc-imx: improve imxrt1050 data
Thread-Index: AQHY4oQG3bWDh2euqUiqcnYuGP5Tya4Td/TQ
Date:   Tue, 18 Oct 2022 03:06:05 +0000
Message-ID: <DB7PR04MB40102975089D9C11157F3E8190289@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
 <20221017235602.86250-3-giulio.benetti@benettiengineering.com>
In-Reply-To: <20221017235602.86250-3-giulio.benetti@benettiengineering.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DB8PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: b84de24a-7463-4e37-d57f-08dab0b5b26c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQfeu8m8JN5ehv4410Y5dmjy+VAGK9wijLYZACxBde+1YCTk5rbdkFKnyGB7AfzYyQklYswEKbMRg6vv3jRnOe1L3P4otEkv1Mq9mP3W9TeOgiNx2RHppemq9UR0U9fCEIV6IuaJpV2vpiR4aUlnf6df0/uxLl8e49Nl0U2Qzd6Y3CDBgeMSf6ZsyK7JSvYfXf4IL+XKwBiWDIKjKNflUPsP0uiO/yFhDWsM24iMGSd5Fy7A52I+mii91sQmJhInVc8JnO/k/CtdZnh7MM23ZKYWfekOt2KMFTyHFF8TzUU6xpUJC3ILgXAV6RwYLWThk2mrPvoe8q1kFyQvP88ekQwm1xC4B4JDDgBzm2IIl0AC6aBH54iUMfLjopmlw1xj1klt1og3/vY9qo9XRYfMcC5cZpp8LYZAiyR+ddRxfJcTN6VwEo8eIeq8OJyS2M1m9Y00EZvtWuhHzDyLicZ17NlBkEWgYyJMAS2vDPCWRxMEfZqfPS29dbj4gAlJlkdBgOEzoZPwy7ckEtbiaUg/PfNthJU6fBXba84Jl+uNYtYH3E/ylV8BMYhYhbvp1wmUT3pXGeUdzPbOXWFfi+INjCGkpjgJIzSkPDpQ8TGoo2N9bA8Wzyu1GKirON/GKmzQf0bUyjgdx2GZUgqvwArlTr4I9/bLX2TbVKsaiamLdwrlzMOwJ5KYS77z+gyrgRqdW7JQxftkMygtIXbc7eL8CoXAVV0lR5mvMXDp8Rg4PJrhgSuvaZd98BLOyy0viH3cQ10lYYMVXRzlwypTUJyUgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(26005)(9686003)(186003)(41300700001)(478600001)(38070700005)(2906002)(6506007)(33656002)(4326008)(52536014)(5660300002)(8936002)(86362001)(53546011)(38100700002)(7696005)(110136005)(122000001)(54906003)(316002)(71200400001)(8676002)(66946007)(66446008)(64756008)(83380400001)(76116006)(66556008)(66476007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eGtGVHh4Nkp0T0laRFZwQVlERjZtMWIrc0h3MW0zdHVCV0xwSGtJYW1GL1Va?=
 =?gb2312?B?dStQWTFQNDMraDZxK0VuL3ltRWpta1h1ZEYrcEM0Z2hlTVErbEcwVkk2enhY?=
 =?gb2312?B?WFA2SUdUOUR1OXdnMkpHUHRsdzl0NGRNOGgzRDUxdDJNUHlKTFh5ZkRaTklS?=
 =?gb2312?B?S0pSL25Ramd4ZmMzZzJrRkV5NWx6ekNiaXVHd0FtRmJKVkJwYWlKcWsvbFgv?=
 =?gb2312?B?MmRXYnQ3NUd1UFRrUlEzTDJJSkgzTWRZLzFOa09DcGFzeXRsQVpuMkswZ1pv?=
 =?gb2312?B?UDJMc3Rnb0VIUzhrWkhRTkxLNkY0TmpzaDlDSm5WZUJocmRKS2taZzZXR3pm?=
 =?gb2312?B?OU5mRnc3TVlKMlRRRkl2V0MrTmc3V2U5ZTZpS0p0OWdpTjhXeG85RzFsWlFo?=
 =?gb2312?B?b3BuazZka1NCZDlITzRpNHYxYXJIYmp4a25xQ0ZoQWo1UGlJRkdPUmZ0SUNE?=
 =?gb2312?B?TWV2QWtZYW11b1JuU3JMMmk0dzhNaGhQdU5KK05Eem5TL0pTUEQ5SGQrVWNk?=
 =?gb2312?B?RG9CNjl3WXdSNGVhTWR1NDAzMmNsQ2hZKzFRREpVbC9nTkg0QWRKU0NDQVV1?=
 =?gb2312?B?UFlKaFU1TWNPRFpucmNGWlNVQ2tzSDBjajRsT2hxM1c1S0R5WXBHUVJyb3Ny?=
 =?gb2312?B?VHBBMzhrcG9jRk1Wc0lrcXhYQkpUME1EdmRYcDJ0SHcvTDVLSlVBS0lCYm5P?=
 =?gb2312?B?YTdySUZhSitsemlldE42MlZnVldvMzA1R0xVQkUrWjMvKzI1dnBxQTRaQkw5?=
 =?gb2312?B?dGRaSDR4Zis5MmRZakpjOHZMR3JtVFZOTzErNklTOWlaMytqVVZETU01UHFV?=
 =?gb2312?B?SHJvK2pmTk9DeTRJWnE5OFcvd25Gb1c1OHYwUCtXdGJPNm9pVllFNUlrK29q?=
 =?gb2312?B?ZjV3V05KY2IrSk8zWm52c3gyc1FvendvbU5kV1dGYkg1Y1BGWWNFdFVyL3Fr?=
 =?gb2312?B?Q2xScCtuN0xDWWJhL3FmV1lzWCs5ajhydFB0d0twRzBrQVFMWS84dVZCMllI?=
 =?gb2312?B?RHVHczBqNDhLUzM1VElaenk1OGpCTjRsYnRGMGJWc0d5ei83S0JDWjFtVFBw?=
 =?gb2312?B?SnR6SDhMY29qeDB1QWNyUG9KWjdlV2FjMXhLem13WFlobmdnVlVqK2VZR2Nj?=
 =?gb2312?B?T29acUNUZ2FXSDRDSzAzMWpCejFQMExTejlFWWJ0eU5YQnhKSkxObkZqNHNm?=
 =?gb2312?B?RDY4T25qOUl0a0d6QmRyYmhUQnlrazNINFpyeDJTRnA3ZmxyeGwwN0NVRWZn?=
 =?gb2312?B?K0RnUGRJTGJXeFlCZXp5U3B6d3plejVoYUxmOU9QZ01vNzh1b0lUa281alRz?=
 =?gb2312?B?aCsyY0ZRVjVwcVUydHZ6V0hKY2EyTmhMTUZsaG9mR3VBQVBHYURBc1JWTW90?=
 =?gb2312?B?ei9SVUc4QThLdHZpVmRMUDNBUE5XcXg2SFFGTUdmZ3hNalQzMVZyQUl0SjRS?=
 =?gb2312?B?UE52RWhsaE9aYlVKdG1BMHhNMGN2enNwREY3SkZ5L2NoaG9aU2VkU2psTDIv?=
 =?gb2312?B?anl4ZlQrRFdNSkJjTmZZaVpVeGkwaG1FYXYvbmZKOUZibCt2UjhPOVkzcVV2?=
 =?gb2312?B?Zzl6akh6N3R4bXUyWEMzOTN3enNMUVVEOXhSd1ZNMGJ3SU5XcXhZb1ZuQzNN?=
 =?gb2312?B?UW10L3p4dklDVW1UYy9BSTZ5d1d0MEdYQVFZR3Q4K29wZVpBR2xZQThMQXFx?=
 =?gb2312?B?Ui9rZE9FMU5XTWR6ZnV2cG5CWmF6OXA5NjdvSDExOXlVVXVwUWo5dHpDblpu?=
 =?gb2312?B?ZS9aMDBjVE92RXlsOTkyeVFUMHlSYyt4ci9oSlI5bm9oZ1NaMFZ1RnI5Z2ZR?=
 =?gb2312?B?a2d6R0kxNThkTkYvcnJibTNEV0JvT2h2QlJuN2hYZjk0bG4za0xETCt0VjJO?=
 =?gb2312?B?YVNoV0JzY1lLbkM5c1F1Z1U0eXprY0ZJNDdwQTlJcEFlWjhjZ0k5QmIyWE1H?=
 =?gb2312?B?SDlkT1lWUUJvY0Jac1A0ajc1cHpFM2w5czBTclNiMDJSV0VHRTJGdHNHaXhN?=
 =?gb2312?B?ejdiSE9ERlFsVmtEalgzYms4QXlyN2FYODFVbmN1WmFXR0lVZm9ybjZjdXEr?=
 =?gb2312?B?M1oxR1FjYnZ6ajVUSUh1dGdCTzdpNThqaXhSRFc2UWRsYk5raFFyalowcFEz?=
 =?gb2312?Q?koEVtn5SJeoBMGzsj8dNbUMbM?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84de24a-7463-4e37-d57f-08dab0b5b26c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 03:06:05.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beCnX7QgVL2eBxQ8ryG1P1PHvmfawTOItbToq6gxi/PM0eYjcFBgL21OApzR6FyNkOIIPTJZ7le9C0X+ZB9kIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHaXVsaW8gQmVuZXR0aSA8Z2l1
bGlvLmJlbmV0dGlAYmVuZXR0aWVuZ2luZWVyaW5nLmNvbT4NCj4gU2VudDogMjAyMsTqMTDUwjE4
yNUgNzo1Ng0KPiBUbzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0K
PiBDYzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgQm91Z2ggQ2hlbiA8aGFpYm8u
Y2hlbkBueHAuY29tPjsNCj4gQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBVbGYgSGFuc3Nvbg0KPiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IEdpdWxpbyBCZW5ldHRp
DQo+IDxnaXVsaW8uYmVuZXR0aUBiZW5ldHRpZW5naW5lZXJpbmcuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggMy81XSBtbWM6IHNkaGNpLWVzZGhjLWlteDogaW1wcm92ZSBpbXhydDEwNTAgZGF0YQ0K
PiANCj4gaS5NWFJUMTA1MCB1c2RoYyBpcyBub3QgYWZmZWN0ZWQgYnkgRVNESENfRkxBR19FUlIw
MDQ1MzYgc28gbGV0J3MgcmVtb3ZlIGl0Lg0KPiBJdCBzdXBwb3J0cyBFU0RIQ19GTEFHX1NURF9U
VU5JTkcgYW5kIEVTREhDX0ZMQUdfSEFWRV9DQVAxIHNvIGxldCdzDQo+IGFkZCB0aGVtLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogR2l1bGlvIEJlbmV0dGkgPGdpdWxpby5iZW5ldHRpQGJlbmV0dGll
bmdpbmVlcmluZy5jb20+DQoNClJldmlld2VkLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54
cC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwg
MyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBpbmRleCA1NTk4MWIwZjBi
MTAuLjRiYzBhMjkxNGE5NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy1pbXguYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+
IEBAIC0zMDYsNyArMzA2LDggQEAgc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19p
bXg3dWxwX2RhdGEgPSB7DQo+ICAJCQl8IEVTREhDX0ZMQUdfU1RBVEVfTE9TVF9JTl9MUE1PREUs
DQo+ICB9Ow0KPiAgc3RhdGljIHN0cnVjdCBlc2RoY19zb2NfZGF0YSB1c2RoY19pbXhydDEwNTBf
ZGF0YSA9IHsNCj4gLQkuZmxhZ3MgPSBFU0RIQ19GTEFHX1VTREhDIHwgRVNESENfRkxBR19IUzIw
MCB8DQo+IEVTREhDX0ZMQUdfRVJSMDA0NTM2LA0KPiArCS5mbGFncyA9IEVTREhDX0ZMQUdfVVNE
SEMgfCBFU0RIQ19GTEFHX1NURF9UVU5JTkcNCj4gKwkJCXwgRVNESENfRkxBR19IQVZFX0NBUDEg
fCBFU0RIQ19GTEFHX0hTMjAwLA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgc3RydWN0IGVzZGhjX3Nv
Y19kYXRhIHVzZGhjX2lteDhxeHBfZGF0YSA9IHsNCj4gLS0NCj4gMi4zNC4xDQoNCg==
