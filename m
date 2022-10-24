Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53B609C50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJXITg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJXITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:19:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0628.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A1D65576;
        Mon, 24 Oct 2022 01:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKrpr9Nb+WaRBdibrprEKS9GSm0hfBRhRy0UZbNXI4pq15H6lX9dlUluAfwD+w6KR/x5L5Ve0xr9s4qlDnnhKtXxqgD6m2X7csClcIvlx8lv9THkMas4E5lpExG7tsu4fZHj1F8Gh6LGuoUKeKy3iCnuRM8aBtLr8a4x613LDL2ubC4EJ6/Ra9AqfTcVWV6EYTnCEY6YjNAN+gMlrZKnN7IoxTRDupE6ROw4AiV9IeSfIkGb5mbLlz4WfclC1zPZapcmb50nsmc+dCcztj5vVAiYk3it7TndF8skuZbLf3fOpiTbPOtqeVtF6gyxauLVRQq0l0jzku4KDXvLVQNaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEt3qHn4R/IPAZSeuUyrE8Gas76oui26V0qZB0Uw118=;
 b=Gc7xTc7Ro9YZskagQ0JowY0vqn6Jy4OuTkhDcJEA6Xk8sRNoSdcZVFUzYxeZgCtgxxCpbe+DBHyT87MeX3zz2FLeDdfwRnPj7l8qrbcNHTO9yyXBm60osVgzeNXyN91oacyKkGcb1LdFzyMHR+drBxdQu8UiInsMkSy8DoXV+zB6y8YtQpd7lK3RYykAQBgoc4KBGsvbsl7gg8Q8UfsPzzBX8qLF1eaYjajsURRfUl7xmCP7LQrk7GTOrddZXEXjzxo6Uqt5xLamGobzuYS1d7BldEEIAteIvTO2QRdK2R0n7k6MZc+kynygPrI73FHnHCzAYlGmMKAVm01cUsPXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEt3qHn4R/IPAZSeuUyrE8Gas76oui26V0qZB0Uw118=;
 b=gkZys93lDZgme0j+Wa66cyXqJdgpwUARhXxvjKjWQtNzVG2QzinbKPbilGai75vKZjKuBxYaTJOxYvAricr9LS7mgvxpHyDlvazdETmY3D2LTVDwZ92lnPxjDWuSZOrsD6iRalMtutaoaYgBNFQnBz+h36WTsKKmK+/0hvhBBPE=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM8PR04MB8049.eurprd04.prod.outlook.com (2603:10a6:20b:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 08:16:14 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5746.025; Mon, 24 Oct 2022
 08:16:14 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Topic: [PATCH V3] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Index: AQHY5IbQ3hIYOvXI3k67RmfImiIWqa4dHQMAgAAbLOA=
Date:   Mon, 24 Oct 2022 08:16:13 +0000
Message-ID: <AS8PR04MB84047AF62740857F042A3B72922E9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221020131938.32454-1-sherry.sun@nxp.com>
 <0ac3dc40-080a-f843-f616-7a9fdd78afaf@kernel.org>
In-Reply-To: <0ac3dc40-080a-f843-f616-7a9fdd78afaf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AM8PR04MB8049:EE_
x-ms-office365-filtering-correlation-id: 21326b03-2fe4-484d-7254-08dab59804b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNXNkaUWqzApYO7YXhC8TC4FdJTmcBGEoelx5NuO2wpmcBQaBYW05JM2021UjufEJNmbQNME7fvwEK9ntAk6A8eKHM48Rf/ukPWs6Ac2H3b+aKYAjgQjUeeW7yh9tiQc76SrHI8O0bGnCuwrdGR0ZMUell/18PdHk2e1zJ16YJFroe4NUynGLKaHOvUvBJDAfoQbtrxWvmE5296daFQjziYgLkT1fdUYZ0qhX11MGlSjoi8KrhoJjwhRxMkdQJNUcFZNloBTnj6fLIuiBj37Xpf/4/OqqRgf7zyE58jAGOnBMeaL46ktogLQilgs2JdFPVeNp0Zm7/0rbsTyZzERbkhZ0zO90I909/1N1XzFORarVnj168OkesAvMxkwM3fh7MPqfRcM8xJPinchIaw6bmbomNsHTNVqzfxrkUEnTD2x5EOm3t5AZ9wq6bT1KknMe2reXVd3LJmkKI6Z00l9ZKITW9XUmoc0vdcutD2ePYJODi+DDgfiJtOUqOaGrFICMuISnLQBhdaiJDiedoSwuQLACxBRkEJQI+Xa9ausI8dzFWP4CHMsWLsKl6oayMixmuuLIM5W1TqSK5WwY3Zz35lshWL278wDnhKA5kwA3/Hd5dgGYHmfGK35maeKzZxV1BwojjyQH2zQaUiROSkcrGrN5y5phjFXa81VMmb7I5KtIQ27owbvb/J+fQcP65ToGlixR03fT2sVsIdCLKGhrQCfWRXOrhoi08JceBOYTenVqBvEU+kU3TRZIFBzCNvTm5HYghZkljmP797c/1PvzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(41300700001)(8936002)(9686003)(38070700005)(26005)(54906003)(110136005)(86362001)(122000001)(83380400001)(55016003)(316002)(2906002)(52536014)(38100700002)(186003)(53546011)(44832011)(33656002)(76116006)(6506007)(66946007)(7696005)(8676002)(66556008)(4326008)(66446008)(66476007)(64756008)(478600001)(5660300002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnBFazMxeU9KOHZ5d21KbEtPeEZNQTdJSG9JQlFXODQ0bTAwWDFNWXN0T1kr?=
 =?utf-8?B?Tm5iRDVtaG55WUhSaWN6a0JObmZmK3pVTURQZkhLTG5kY2JQcVdDRDdRNEZi?=
 =?utf-8?B?MjJXTnRVVUVsc0VCQ3BYWnZPdWliWFJScm9FNTZHUUR1aUNzampVbFFLb1Zy?=
 =?utf-8?B?MkFySVBSaENSbi8wbWdGRHphVGxPS1NwMEVMYi9pM3I3TzcxMFBXWXFaOFQy?=
 =?utf-8?B?T3ZqYndmNU54a1BlMWMxbm40TnIrL0ZjUUhrZFhFSTQxTmhETS9YTzE1VzZD?=
 =?utf-8?B?Y1dqdjlWK3pkZzZKbndLMmJualVVQXNDT0JMR2NMQnJFQXZQZHhxQnBVaWJq?=
 =?utf-8?B?S1Y4cjg5cWM1ZUh5ditJWWJubkJJZ2ZWYTROOE9MVkhKMWEvc3B1elBIS2VI?=
 =?utf-8?B?SVVoUTlNL2ZhL1RiQXVSU1hicGFybHFlb1VsaE1PbFhtUVJZV2J0OUFCSHB6?=
 =?utf-8?B?VVV1VVkyRUVpRDdlOHhNOGFHVGgwSXoveSsxU0JIdTJCMXllZlk2VXA1ME0x?=
 =?utf-8?B?bk9yeG5PQ0Y4bHA2UTdTSDlQa2kweWs5SGRmVDh2WGs3cEJ5aVVjZWtmejQx?=
 =?utf-8?B?Y3B5NVpKeDBRb1lYaXMxMnNGZ3Z5a1dlZUt6di9GTFp6ejQzRnRBeTMrZHFC?=
 =?utf-8?B?UHI1Q3VTcHFqb2k5OEFLd3lyT3pMSjZzM3p3RldpWlpOMTRsbjVzUk81MXdy?=
 =?utf-8?B?WHVpcHZYYlJSMlZUeVVxbHRySWphT0svSVdzNTNRQVY3NjdLWHFJSnJCalIx?=
 =?utf-8?B?SW5aZkdXakF2NjdjWC9IcW0rTUluUG01V1V5djdiYU1idkRXbHJhQ2w3aGE1?=
 =?utf-8?B?ZXJNWnFRR251OGQybk9jRENvSnJsdFNVODVFVmRBclVxMFJ2UVVFY1o5bXM2?=
 =?utf-8?B?MUNaQjZhMVdGL3JHMEcvbEg2L0U1MjNJSkswSGE4QUhOdENYcy82eDRqUlVh?=
 =?utf-8?B?dGZqM2paUlJ1VFFmd1hUSFNjTG9ua1Z6bldQQmZmMWx6dUpkcFVpMFM4bmR4?=
 =?utf-8?B?aGpQeE5FSTFJRlIzR3prZlk2SkllbmR1Q2N3cmtsT1lXOHZRSTluU0dubkMr?=
 =?utf-8?B?TzJZdzMyVU9xK3BEejBDYTlUajg3cXdCVTlPMk1iWVRncTJpaHlyVnhSUmdF?=
 =?utf-8?B?Qkpmc0JzeVdrekRvWm5qb3Z0MGJzWVhZYW5UMFFtWm9tUE5iaWFKMDlaQzhk?=
 =?utf-8?B?U0RKd05VWkdTa05DOWZyMVQ3b2JSckxLZjhrc0ZHeHF1WU45SCtuNFdmc095?=
 =?utf-8?B?bXRTQjVEbEE5N2dqTEtWak9RaGRpcTlXcnRBeWl6Mlg5VHZDZWxrVGcyUmdB?=
 =?utf-8?B?SVV1WUQydG4vTFZLd0k3bVg0MGZ6MitQSFNLc1ozcE9BQ2JVUVplOC8rNTRZ?=
 =?utf-8?B?a1NEOHZqU3l3VDVNSjVsSmt5Q0ZpK3FQenlTTy9VeitmdEExNlBoZTR1bFo4?=
 =?utf-8?B?MStORnVaYi9GS3Y4YndpdFcrRFY5TDVVYVFQU1U3M3JTditvNms5amxqR2xl?=
 =?utf-8?B?NGtoTUZ1eWIzUUtUSU84Q3BNY0dBZVBTRWV0eGVLRnh6M0o1TFFRVDgya3FB?=
 =?utf-8?B?RVdick9CdWNPTlB0ekttbnlYZnQwcGg3YTh0ZWNIWlJJWXh1NDJwWmRWTHlL?=
 =?utf-8?B?WXhZTXd5WVZkTkVYRHM1Rm1GaDU0ZVpEU2xjNFN5bCtYS3ExREFxZDRlK1Jv?=
 =?utf-8?B?R1VXeE50N2dqU0h5VmRjUVI0dGx5M2xKdWhlU3FPR2RVWmtxQ3V6dHRHek02?=
 =?utf-8?B?WUFhdWpPSWFuR3VVTHdUZmZFVjRQNm82NUE4M00wSU1sRVptZWFXRWd4SGt0?=
 =?utf-8?B?cEQ3YmNnWEF1eTMvM2ZXelZFMDZPQW1kSDBJS2RDR1NNR2V6eGxGQ1psZVl3?=
 =?utf-8?B?b2dUUURPSEd0TGIzaGlDY2RYNnB1VjFMTjRmQ3BZWW9HblFja3VUTzRBbmdX?=
 =?utf-8?B?dEVJNy9XUWRTU2trYTNMR3MrODI5UUwvVUYrMmFuY3dKTFZUUDZ0UGQyZU5F?=
 =?utf-8?B?RTlrZVVhSEVXcjg3dEVkQWtwUGs5elBNQ0hXTlBsdmtxbDJKQ0NMRVBtMG9M?=
 =?utf-8?B?UVdzNmNIUHcyNkFXYTFqUHpEUHMvN08zZ2dQRzZadlh3VmJPNkxqTnV6SWxW?=
 =?utf-8?Q?LzQc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21326b03-2fe4-484d-7254-08dab59804b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 08:16:14.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzfpzJEoXxvnu6ac/Xj8iAkqjjQBqrZ9NqAbDzpV1UROs0vhyKsknDzWM2UN0FYIFP01V9RdROfpLmh13b2YLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8049
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amly
aXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLlubQxMOaciDI05pelIDE0OjM3DQo+IFRv
OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZzsNCj4gbHVrYXNAd3VubmVyLmRlOyBpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbQ0K
PiBDYzogbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCBWM10gdHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGRvbid0IGJyZWFrIHRoZSBv
bi1nb2luZw0KPiB0cmFuc2ZlciB3aGVuIGdsb2JhbCByZXNldA0KPiANCj4gT24gMjAuIDEwLiAy
MiwgMTU6MTksIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gQEAgLTI2MzYsNiArMjYxMCw1NCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHNlcmlhbF9yczQ4NQ0KPiBscHVhcnRfcnM0ODVfc3VwcG9ydGVk
ID0gew0KPiA+ICAgCS8qIGRlbGF5X3J0c18qIGFuZCBSWF9EVVJJTkdfVFggYXJlIG5vdCBzdXBw
b3J0ZWQgKi8NCj4gPiAgIH07DQo+ID4NCj4gPiArc3RhdGljIGludCBscHVhcnRfZ2xvYmFsX3Jl
c2V0KHN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQpIHsNCj4gPiArCXN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQgPSAmc3BvcnQtPnBvcnQ7DQo+ID4gKwl2b2lkIF9faW9tZW0gKmdsb2JhbF9hZGRyOw0K
PiA+ICsJdW5zaWduZWQgbG9uZyBjdHJsLCBiZDsNCj4gPiArCXVuc2lnbmVkIGludCB2YWwgPSAw
Ow0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUo
c3BvcnQtPmlwZ19jbGspOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoc3BvcnQt
PnBvcnQuZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB1YXJ0IGlwZyBjbGs6ICVkXG4iLA0KPiByZXQp
Ow0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKGlzX2lteDd1
bHBfbHB1YXJ0KHNwb3J0KSB8fCBpc19pbXg4cXhwX2xwdWFydChzcG9ydCkpIHsNCj4gPiArCQkv
Kg0KPiA+ICsJCSAqIElmIHRoZSB0cmFuc21pdHRlciBpcyB1c2VkIGJ5IGVhcmx5Y29uLCB3YWl0
IGZvciB0cmFuc21pdA0KPiBlbmdpbmUgdG8NCj4gPiArCQkgKiBjb21wbGV0ZSBhbmQgdGhlbiBy
ZXNldC4NCj4gPiArCQkgKi8NCj4gPiArCQljdHJsID0gbHB1YXJ0MzJfcmVhZChwb3J0LCBVQVJU
Q1RSTCk7DQo+ID4gKwkJaWYgKGN0cmwgJiBVQVJUQ1RSTF9URSkgew0KPiA+ICsJCQliZCA9IGxw
dWFydDMyX3JlYWQoJnNwb3J0LT5wb3J0LCBVQVJUQkFVRCk7DQo+ID4gKwkJCWlmIChyZWFkX3Bv
bGxfdGltZW91dF9hdG9taWMobHB1YXJ0MzJfdHhfZW1wdHksIHZhbCwNCj4gdmFsLCAxLCAxMDAw
MDAsDQo+ID4gKwkJCQkJCSAgICAgZmFsc2UsIHBvcnQpKSB7DQo+IA0KPiBBaCwgdGhpcyBpcyBu
b3QgYXRvbWljIGNvbnRleHQgKGNsa19wcmVwYXJlX2VuYWJsZSgpIGFib3ZlIGFuZA0KPiB1c2xl
ZXBfcmFuZ2UoKSBiZWxvdyksIHNvIG5vIG5lZWQgZm9yIF9hdG9taWMgaGVyZSB0b28uDQo+IA0K
DQpIaSBKaXJpLA0KWW91IGFyZSByaWdodCwgdGhhbmtzIGZvciB0aGUgY29ycmVjdGlvbiwgd2ls
bCBmaXggaXQgaW4gVjQuDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQo=
