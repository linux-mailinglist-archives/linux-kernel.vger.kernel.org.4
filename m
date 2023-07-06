Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CF749553
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjGFGHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjGFGHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:07:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8F1FEE;
        Wed,  5 Jul 2023 23:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joIxnWyiylr3m6hMml5QY9Jbwqjebghof9AYlMch9xb9H68iRpmEVpSpGz43dYINuhbN7W52f2Oda5Ir5Rnxl6WnZIkVHGKVRYNx6TAxU7mXlVYiM3yYBD/wQ2gM0VYk87D9Fo1eo4BVOhrNYhX3M4MMvmmAazMgyvwLEdW2x1no465R3MmkFOi2wc9Rz/y0UlFf0DQax5H1w78EcNuXSe7J2zfUcmySRdDLN7aBuX9PCKmv92HGq/Zl064DvpseLTLr90PEQeRm20aH9IDj2kiqQ9g/X0TfWojzpLxDH82h/YQTlt//+GnegMqCRKNJ+zJrBWN0pUzyGdkjICl7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7TETx20q5w7NMbmlNEb9bZ7BC4mSt7rqQo0ZjgcQCM=;
 b=AcjysJuH+mhhA3rqX4gFaYcowe2dPtxdTEMIZgSk4iETsS5I38GDnN9FTHxgdkTmZUyQOGEOhnMstLMs5sY/7zPaHL5H78Fweq1kmifIiF6cIwebBDasIho2+CBGW2VW2L5WbD6w062HWVT/5K9/Yai1ZDbrMaeY7w9pq1rKGK3WmUrMmODdrmpE1ZziGVFaDuuJujBIgo4V/LdZe5iYwgvHYXDnbvPPbgk6iPw8ksXRoC6bS/PbmsY2gHSDJiCYrRT2PzBqacFjW2xFz4QpjD5fcVpGuTULd9oyuVXejU0abr/pwTeg/uKYnO5vUKkcrEhaC9UtY1/JekNb9cP+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7TETx20q5w7NMbmlNEb9bZ7BC4mSt7rqQo0ZjgcQCM=;
 b=QuS011z96C/jqKPufFbDrVqb95UYGRMpyJWi5GA3COifHw0VjgUrEn2vys+9Xg5rK6tKMFpt/L1oYUa9ou1yRnwR/T2LVrQ1ejUDWrkke6SlQ26wulfdosTzwXsGzbTDb9ClxH9u5WK9l6TwaI14Nr9T5X2+gEL4emAud8X53E0=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Thu, 6 Jul 2023 06:06:31 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::1b7a:fa96:2fb7:ca29]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::1b7a:fa96:2fb7:ca29%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 06:06:31 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Yangtao Li <frank.li@vivo.com>, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] spi: spi-nxp-fspi: Convert to
 devm_platform_ioremap_resource() and devm_platform_ioremap_resource_byname()
Thread-Topic: [PATCH 4/7] spi: spi-nxp-fspi: Convert to
 devm_platform_ioremap_resource() and devm_platform_ioremap_resource_byname()
Thread-Index: AQHZr7nWHhSb4qzRhk+ZvmYo4G+8w6+sP7eg
Date:   Thu, 6 Jul 2023 06:06:31 +0000
Message-ID: <DB7PR04MB4010A8EB832C46B31C2D9C99902CA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230706032727.9180-1-frank.li@vivo.com>
 <20230706032727.9180-4-frank.li@vivo.com>
In-Reply-To: <20230706032727.9180-4-frank.li@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DU2PR04MB8981:EE_
x-ms-office365-filtering-correlation-id: 5f3dbbc6-6bdf-4a44-10e1-08db7de724fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qK7SkOu5RvIguQuitKSlmGBzqKdTQ2nDk19CHpczYpiz2HZslTMDpdornbPYV84iGDqCvAjyegaffB6LFRw4zZRzkAa/kjmpJadlmaJjkpIG23/KsaEjhXgefUf49EKOttzKmI+cAzPhCGd71nwrZ2d53Nf+2iga2FaX5XOtl1Ek9nz7o7KOHVhIdhbtm0BYpQ7ow0yKfoVFP9e7PHgsxWrT4iK8KhofVHV0qWOsucwfASRK2C5blY3soS8t8ig8ALhyIuRhB2cZ1urwvtBApWEDbfWrFuc4MVzcx0wIDYc0vlZ+8NFxI0JapgR8NmBm7xbcfdo3OiH+ciyzFmykctqWvzEPvcj8aGNi6gFc9HU/g20tE1HLHp1YBfztfFDGvGn++paQgQLyE9OpyVPNdO7FFHH2dZLKcVd4V682HjI1aFdaEu5ClkxyZDD4GA8mjInUnZ6gpkq7NR2gtvTzbaO3tnt1kEpNZjPizX0ey+owrE0BtjVhbwoS5YCaySq0IfS3uc93Xq0HIVhnWwiL2fq2iTyhVj731D01Il4tA9hi/LL3x/iGSHAtgJwsAbV9EiKZKfD/uTufl4PYWJkp4akU89N//F0ovXfJSuWB9Wim1BZQEid7BcxKQC3BPlVR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199021)(66446008)(33656002)(66556008)(66946007)(66476007)(76116006)(478600001)(64756008)(8936002)(8676002)(4326008)(52536014)(2906002)(5660300002)(316002)(26005)(41300700001)(9686003)(54906003)(38070700005)(86362001)(110136005)(38100700002)(55016003)(7696005)(186003)(53546011)(6506007)(71200400001)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MHZZVjY5UGc4d2h4ZjZETm9UK0swNWl2aTFZTVN4MEpsck9JOFd3NEVwQmwx?=
 =?gb2312?B?aitvR3VJZEdTbDQ3MXBna1pPUTlTRGR6U1Y0R2JXYTYrbmlYckFIaWlndHZH?=
 =?gb2312?B?VUZSdlNyWkEvQXpTTTJDYm1KaG9ielFmbStaSjVLNHhjdHNiN21OTWc5K2Vq?=
 =?gb2312?B?ekM4S3Nmb2xHR2VHRzZRZUZUSnYxWFZyeEx5MzVGNUZSZGlEZTBscFpFc1gz?=
 =?gb2312?B?NERjNE9MWElNY2Q4MnlGT2pBMTIyeDJINFZhVmQydEJWTHFmN1RKZnFyUWcv?=
 =?gb2312?B?WFdyVnRhRjdGeTdQTDlrZmVXNUc3ZEJZWTVmZXZ5SmV4MkNCZXp1WmZJRDlk?=
 =?gb2312?B?MU8xK0R2NnBlUW1HanBrenRubUpjOVZoM3JaeUpod2FKOE12dzFYUkpwWkFa?=
 =?gb2312?B?RG9lc3laR2xKbEdVVjhTTUlxRGcyUzlxcUU3TmMzalhBR2I5Q0xkL2VYOU1j?=
 =?gb2312?B?ME1lWThvcEVPbTRqUTBrRzFaQ1AvTm8xZkNmeHFBTHFpNjhXVHMwRTNJbkFa?=
 =?gb2312?B?RzU3dXJKdUNYWlRKTHFFcjlOcGZXOWdlNzY3b0RUS2h6K24ramZUMnVvbGZW?=
 =?gb2312?B?ZDhhWU4yckZoVnU1Q1lQcHZteTBwUFg0QzBhV0RvUTlvRjB0SXVBQjlEU2sz?=
 =?gb2312?B?STBKNXFpbUViT3ZQSkk5enFMYUlyYk52eWRuV0RNK2hyQzhNSlBXZEd4MWxv?=
 =?gb2312?B?d2pkSGFKL1p3akN1R0FpZCtBc2JaYXpHOXB5UTdCK3pFSWF2Uy9DRTljeTha?=
 =?gb2312?B?dXNTZXkxUTJhbVI1TWRiNmVwR282Z2ZsbHd6cUwyK2crZEZ6MStUdXp6K0Rz?=
 =?gb2312?B?VTlpZFhXY1ZrYVVkWFIyQ29wYUZYcHFyVUxEY1REWHlBOFN0QVROc1E4bWVk?=
 =?gb2312?B?R0JTT1NqY1o1NWNScmtkbnh0bkFyalJ1RnZzSlZiK3pBTCtSZXFHVnduQjRy?=
 =?gb2312?B?QXpxYlFlQmkyYU5JK09rZGFVN2d6VHhVTlh4SHNyekw0MGdKVzFGL0R6Ty9m?=
 =?gb2312?B?R1lvdndRTG5DbzhsNTQvNlgzZ09OTnJrYkdVT2FvOE9pbGlqV0kwdHVvb2gv?=
 =?gb2312?B?dVp4SnoySGxOOUpZUXFlT3JFT1FJbWdIQzBNaXpnSHFUQUNtNFRoS3Nhd2lS?=
 =?gb2312?B?aUQxODVkbGlVMzRsaG9qc293ZnhWNWxTbnpHaGwzZEJrWGRoZnVhSlhub2hx?=
 =?gb2312?B?TU9xM0JmYnlrSWNjR2ExSlk0cDUxSURmSkFkblFGRTJkM3cwTm4yVVlyM1cv?=
 =?gb2312?B?OHhEa3pDMnd0Tk13OFRTUjUvaERyOGIwamdZUnRlNFpUM1owTnlHRzQvZGdi?=
 =?gb2312?B?aUZDSnFYMVYvdXFVRi93TlVLYTFUeVkwa082TndnWW9leHVFZ2JWWks3UkdM?=
 =?gb2312?B?emJIc3dFc0FMTkRCZHBFSDFXdEdJa2xjdk96ZDM3NVhudnl0clIvdHB4OEhS?=
 =?gb2312?B?VmE2UWtqV09LZElBb2xTNnhjU1dsbWdjS25WNlAyalZPS3dLc3BYSG96aHFk?=
 =?gb2312?B?SUpKOVZVeGovWEJ5NHp4S0g0d2NQanBBelgxZ2pjNmVlQ29TYnFFZE83LzFM?=
 =?gb2312?B?a3JvL0tuOEdkY1FEdm0xdWJsTnZ2MmZ4ZzBPZ2I0OFhsRkg4ejU3Yy90NkRJ?=
 =?gb2312?B?a1VITnlQeE56eDE4dEtETDlWU3pWRXdndjRsSnd4NzJoeVdkR0Y3T0JoM0lw?=
 =?gb2312?B?V293WjBGOFFUMUQ3aFZFcVorcFBtTHZWUEJUQ0J1Sk9ndFVvczNNc29ObXJi?=
 =?gb2312?B?Mk9HRmVEcERhOWRGeEFENytjajNrRVRiUmoxMSt0SHZYUFhmY1ZJZ0F0UXJE?=
 =?gb2312?B?VHI3UXNQYlgyUWQxMXBLRGtJd1JnTk5jSExCQWoxUzhDTkdxNE44SEVidGg2?=
 =?gb2312?B?UHVJVzVaUTU2ZEU0QmVQSmlETm9aYzhxenBFcFdybmRGclNPUGZTOWptMlRj?=
 =?gb2312?B?SVE2cE5KcUdJaTZIaGVVYjlIeithSGN5RVVpZ0tkdXBHVDV6K1pTdFZ5L2NW?=
 =?gb2312?B?WXJ1K210TGRpZkp5WlR0TjJ0SFhHQ0ZBVkx5VjFBV0t4WmxkckZJQktGaXpk?=
 =?gb2312?B?RWloTGFvRWpzN3RjS0RwYjhUdnJXN0cyVkg3ckh5QkZwcnBUbUdqM3hCZTI1?=
 =?gb2312?Q?G8QU=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3dbbc6-6bdf-4a44-10e1-08db7de724fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 06:06:31.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3q5hyv1+ELPQ9KPxftyBM/LSnz2WCxqPJMdJCENtYbOmnlS1ybBgKN6Uf21n7Jb2CSa1yFX0d14kfVW5CT4iDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZYW5ndGFvIExpIDxmcmFuay5s
aUB2aXZvLmNvbT4NCj4gU2VudDogMjAyM8TqN9TCNsjVIDExOjI3DQo+IFRvOiBIYW4gWHUgPGhh
bi54dUBueHAuY29tPjsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgWW9nZXNoDQo+
IEdhdXIgPHlvZ2VzaGdhdXIuODNAZ21haWwuY29tPjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJu
ZWwub3JnPg0KPiBDYzogWWFuZ3RhbyBMaSA8ZnJhbmsubGlAdml2by5jb20+OyBsaW51eC1zcGlA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtQQVRDSCA0LzddIHNwaTogc3BpLW54cC1mc3BpOiBDb252ZXJ0IHRvDQo+IGRldm1fcGxh
dGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpIGFuZA0KPiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz
b3VyY2VfYnluYW1lKCkNCj4gDQo+IFVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2Uo
KSBhbmQNCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZSgpIHRvIHNpbXBs
aWZ5IGNvZGUuDQoNClRoYW5rcyENCg0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNo
ZW5AbnhwLmNvbT4NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQoNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFlhbmd0YW8gTGkgPGZyYW5rLmxpQHZpdm8uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
c3BpL3NwaS1ueHAtZnNwaS5jIHwgNiArKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkv
c3BpLW54cC1mc3BpLmMgYi9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyBpbmRleA0KPiA1NDQw
MTc2NTU3ODcuLjRjZjliM2JmN2I1NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLW54
cC1mc3BpLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMNCj4gQEAgLTExNTcs
MTIgKzExNTcsMTAgQEAgc3RhdGljIGludCBueHBfZnNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlDQo+ICpwZGV2KQ0KPiANCj4gIAkvKiBmaW5kIHRoZSByZXNvdXJjZXMgLSBjb25maWd1
cmF0aW9uIHJlZ2lzdGVyIGFkZHJlc3Mgc3BhY2UgKi8NCj4gIAlpZiAoaXNfYWNwaV9ub2RlKGRl
dl9md25vZGUoZi0+ZGV2KSkpDQo+IC0JCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ICsJCWYtPmlvYmFzZSA9IGRldm1fcGxhdGZvcm1faW9y
ZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gIAllbHNlDQo+IC0JCXJlcyA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZV9ieW5hbWUocGRldiwNCj4gLQkJCQlJT1JFU09VUkNFX01FTSwgImZzcGlfYmFz
ZSIpOw0KPiArCQlmLT5pb2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnlu
YW1lKHBkZXYsDQo+ICJmc3BpX2Jhc2UiKTsNCj4gDQo+IC0JZi0+aW9iYXNlID0gZGV2bV9pb3Jl
bWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gIAlpZiAoSVNfRVJSKGYtPmlvYmFzZSkpIHsNCj4g
IAkJcmV0ID0gUFRSX0VSUihmLT5pb2Jhc2UpOw0KPiAgCQlnb3RvIGVycl9wdXRfY3RybDsNCj4g
LS0NCj4gMi4zOS4wDQoNCg==
