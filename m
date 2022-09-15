Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2035B9415
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIOGFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:05:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F66580E9B;
        Wed, 14 Sep 2022 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663221918; x=1694757918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b07O5ZnEvM3CKJMAYNHcDmUr8GppajapqqtQqK5dqlI=;
  b=N6VifAv1u15DDaGPReqdX0UynBK1otALPSNjEvXK0WUYBEVeATfTeaFg
   CsrytX94d7A/u5eg1HqC2HHN0zXjEwipcH0aXCgG+hNbLpQFtokfhgH5V
   5Lidm46c6j4YBPHf4cuSIs55d0fhPXrZM0YGabkSkMZZEFCqeoUB32lrL
   FSplhq/ALxF37k2wlV8CxtfGE8uF1AEXrQlVriIWqRBSbcd62PL58Z2dP
   KR0H5Be5wbM2Gv4oZvCZpD4LpiSnXoz3stwYPHIBa8gISoujuW/HMHsjs
   8XpIQ67MdSQnwarASmb4cpueojLAUWO2qwjs7ToR4b6HJoEnR3Vs9PjoK
   g==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="177246402"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2022 23:05:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 14 Sep 2022 23:05:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 14 Sep 2022 23:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVO9poAx5n0vXbpSZuNCZzc075uBeBFq6jBjTRj8L/OgbEg4+LYyiRom2J3bt1mMuudJYeBJC8ZYZMHsij04m6Er3CVOCL3rNC7cEbaFjMk+oopllnGI3F3Sv36MpjYk2wmFZmVXNyACkB8fJISWfdaBKYBZVC2WmxdCAPrYEB9oRuFXaCGrlVEX3fHLsyQ4P5W1szi/SphlPlV8o4h/CyNeyU6WFE0CTWAM0wVo6CsmW9VuAeVcJTBV8IZ9mEDzt7b7dqEVtnlnqeax014QXjEkJInXCNApYgrX/4zXwNIzQPo57bXO2JkhcZSdO3S8HhRW08DfKHLPWl4JN4NFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b07O5ZnEvM3CKJMAYNHcDmUr8GppajapqqtQqK5dqlI=;
 b=I8ytmo2EY7nxSzHtLoJdoemGEDhpaOWQgPZAI9uQ8anI5cqkXH2HIkFyfXg6zw6czJIKDfue98MrHz5rbr/rImloCUlCquKIiypaLxHwO7aEbhjCF/e9ho98sJLA3QZWAYXyoXHcOp3R8iL4rzeJcSpg83Np/zZsWcFLDreELr7k7Y220pkE4Mu0s01ULCGLxebmIzw3+UIpxIYOzhfFeApRDeEcnakgsjoPcDx4uLZvOQOAYQq/vDXuoiYDceRUAUBGvHzCmU0meZDFaUxOZdhoIggi+kwci+8hTQeQ6U5+HaJ4gO91L7KKJasn8cLnN1EB/b2wQaDUikf7qonRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b07O5ZnEvM3CKJMAYNHcDmUr8GppajapqqtQqK5dqlI=;
 b=fryNHrnhipCngivb9sKMGqQwJhW5EuePCyrMoroJHrZyIlx46qn/Iac87+B1yULgsYlOeT5hXhmYQtoN67OAiRsgyCfox6raVSdQ8umTMCgOOz5uVKIJq7HsvWDCgS0UbcnX1m7QQiSAwRvfEI326LGOjcWau636iemmXy66tgE=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 06:05:10 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 06:05:09 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <renzhijie2@huawei.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sudipm.mukherjee@gmail.com>
Subject: RE: [PATCH -next] misc: microchip: pci1xxxx: Fix build error
 unused-function
Thread-Topic: [PATCH -next] misc: microchip: pci1xxxx: Fix build error
 unused-function
Thread-Index: AQHYyLIVXgvSM3vHT0yNPOd8TEVc/63f/8Sg
Date:   Thu, 15 Sep 2022 06:05:09 +0000
Message-ID: <BN8PR11MB3668C521DFE3ED67E101F150E9499@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220915031605.86214-1-renzhijie2@huawei.com>
In-Reply-To: <20220915031605.86214-1-renzhijie2@huawei.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|DM4PR11MB5996:EE_
x-ms-office365-filtering-correlation-id: ff70ff29-7ca6-44d4-4c2e-08da96e03ed6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkVjY5X7isXHVF/kxJNkBimXLORlmgM521uCgt92dEW20v1ssGdAhLLck62IzB93tiqhkLUbCSCPruQ1q3NNsaiouE8SEQ2sJRI+fc0sU74BBJUOxq78RqEJygSsrEaM8fTCDLrZMRwuamF1vYPq1dFi+83OB7iiyDI2ALvhd7z30R7K1Nv2n8MOqxpjLB/SluDFtTgvjGbvcEMK2iM/K39ftq87ymmDr1HuWLbZh11hy3zAmJs8xB9Q3PbdkJVhrW6dhBEYk2rS4zUzU/QFEtP1RIWgRwJzFZMtWtPdtbLHZA191OTsXAqhhHq8vab5nMU8Z4cpRoDpeBW6fyEP7eR5Kb1ChyyuYiteWjfYnKu5OIww4kHDopMVvS6fPb7a/vM/8+K8euWQBtg1j/CPCocNCKqF5b3h23OmEtkT7v7U3lVupkjOD3URdn2KWxd4ZiLWvBxROThdToWtPFAvGK74f6VCAhS/OIReMXohvcCZXccHaugK/OP4n8RYk+lHHjZ09hyk51vxXFTXnOFwPXQPOcWmSs5HY84sKtfSSJx4BlDbYKBdVZN8YvYOqcKhYeMETq98Rijlx7CSRSNagM+RZJNVmLS6kBfTBuJZK4nHCN3XghA+cLesRzpZ6AfA3c1RrjqLsaqnAu7oNrkIpF53ARvDGaVUsVXw767zRvwF/ipSeYfE7QK1Pfq1MQB8peIMyhYofWwkn++0cl3cUcBOYlX3JbdL0/A76o7N272lcdRHWO79+t/swo0AQS3yXBY3niMy3Kr1v0WCnhwLLUxua+9CxJLsIyTYRi/d4Q/7F03okvnBNRXXceh4hpWIZfZRbGIWRVvUCj/8nLcnoEHJCUo67fdqDeT6mP5DrYAAG9oUUm10h0psnP936Cti
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(38100700002)(122000001)(38070700005)(71200400001)(4326008)(76116006)(66556008)(33656002)(66446008)(66946007)(64756008)(8936002)(110136005)(316002)(54906003)(55016003)(2906002)(66476007)(52536014)(5660300002)(83380400001)(478600001)(186003)(7696005)(53546011)(6506007)(26005)(41300700001)(966005)(86362001)(9686003)(8676002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTNSM0RYRGptYlVtdmJ6eXRXSTh5NEREbzdQZzZTYXdZbnN2emVQTytYYjI1?=
 =?utf-8?B?RkFGUnVhd1E0QTI5NmV3TFZPQm1EbEU2Z2lsY2t3aVJyTmJ3Z3JsMnVDdjlO?=
 =?utf-8?B?UmRxTDFTZjZPTnd0aXFBWi9ySWNvaElzT2JOZ2FhT21UWllxdGxidXJLZ0lV?=
 =?utf-8?B?amdnSTNSWG5kUEo3ZE5lNHUvNFQxZnNEMldZbjNRK2c5MWNxZWZsZ1ZLOGFT?=
 =?utf-8?B?QlROc05ZYVd5K0FWSjcyaTlkUGhDOWI1T2EweUFuR1ZrSlhCUmtHUVBHc1Ri?=
 =?utf-8?B?T3dBMTNWMzE4RmNYTnI1NllUb0FRL3piM1IyeE5IamtpOWphenVVN2lBZkVQ?=
 =?utf-8?B?U1MweThORkxnczhEUkhKdDV6YjVZSDhVZU9BNGN5RTNGanVEbmRrU3U2TnNn?=
 =?utf-8?B?M05heFhFaXEzM1d1TXZqRG9FWDVHWFJqcnp6cDRVTldabTc1MHpaeWxQVjFU?=
 =?utf-8?B?Q21kbU9WUkRmQ0NycVUrelpOK3VrNmVsUm9rajhGdklrS3c1dytPRW9zUmlV?=
 =?utf-8?B?TDJndjNQU2FBVmFlOVhVc1RMK2lrQXdoTlNPazBTL0I0RTIxWGsvaHNvcG04?=
 =?utf-8?B?MU1TUU8yL3VmaENrMElmcDhOZFFZRzNWbW9lUlRETjNLV0pxNVRTSE5XamlJ?=
 =?utf-8?B?Qmh6Y3VyZFphWVNxNmVaQmRmbUwxV29zY2NZektxenNaWXhkazJySVBxSTNF?=
 =?utf-8?B?UXhwcjZNL0FoOElSRkg5U3FDY0VlL3MyYk55TUdLTkNXZldxTDNiMGgzM1c0?=
 =?utf-8?B?b3RCR1hHaFJNTEczSnZ2TlF0Y1o4S2xoTWhxaFdsR282Q1VoU1JuZTdwbXAx?=
 =?utf-8?B?OWJRL1dSRTJrMWlUSEJkdVJTaHcvRjlzNTJROFE5UiswMlk4Q20rb2c2ZEM5?=
 =?utf-8?B?cEV1eFYwbWhCR2Y1V0NSSzcvSXlYZDg2SnhLeFlxS0pqclhTRlgyb2Z5c0xx?=
 =?utf-8?B?elhLM1pwTFh1RE1sTXZKaGh1aUtmMkQ3c0Y2K2tlQms3VzNDK2prZUh4enZL?=
 =?utf-8?B?WUpoZFNXQm9vSktVNmhFREhMNXd4QVZPazRnOUFmeW83VUZjY0gxNnh0VU1O?=
 =?utf-8?B?cUtSdzc1b1o3OUdNdWswcjc5ejREcmVtSmEyTFl3OGJVMkoxYXNjRFVKQjI3?=
 =?utf-8?B?bTJlaVUralRUdmdCaG9GWUtLWlFBWGpzRFp5Wm9EaDRPUVlUVFlXRmp5ZWdM?=
 =?utf-8?B?S0F0M3pZaHF1NktFcStIRFJEVkNteStQaWMweVZEUFVQUGJ0U3lGSGV0Vkpr?=
 =?utf-8?B?S1NmT3NxTmRFb2d2UUdiUnFJajUvc2d1NytQN3lCb0ZCYmwwQ1lKUzJSZWZF?=
 =?utf-8?B?bnJCcVFWbjE4TGNMU2tHK3hvVXBhQm5aZFFFamNyTXcwYkpKMUpYNFlqZk1B?=
 =?utf-8?B?Z1hTcDg0NHBDajlwbmlsc0UydUxPdVQ5alJiSEtvN3R5UWpaZFlvazQ4UVNv?=
 =?utf-8?B?aEdQV05RZmJMRTBLM1BTZmFRa1I2cjk3WUZ5WWVPc3JtWTl1WjNXZkFlV3Nn?=
 =?utf-8?B?eFpvaTl3K3lSVUdPM1VBRHJET001Umt6SEY3U3hRdkRZS0xScVdsT1FiTXF3?=
 =?utf-8?B?eEhla0RvWlFab1U1NFlxaFdldmVBcnNiM2RnTzc0QVdjRk1GR0c4UjJLNERZ?=
 =?utf-8?B?aFc0WG5YRHNnMEFMSVptdHNmcmR0cHNWU1I2d1NDVXVFY0Y1SU9oV3RNZ0FZ?=
 =?utf-8?B?VXdncmwwZGljMXYyRFFwa0MveHpiZXh0Y0JuWEhCZDVwOFYwTHQrVnJZcnYw?=
 =?utf-8?B?dUhxa2xud2QxOW5BeTFHcTc0NFMvdDd0MEFmaTBFOVpLU2dtdWl4Q2hvNVlY?=
 =?utf-8?B?WXY4RFBMSFd4Zk1qdmV1YXJrVnVENVUvZUlrOFlnMzlzcXBkdEo5ZENIalM4?=
 =?utf-8?B?Um9NVkZBenpQUjRzd2M5WTdoaElKQjRranpsSFBoOEUxUUt0elNRbGVrVzQr?=
 =?utf-8?B?T1k2cFpCK1JXVW9ub2h3TzFQSHVoZ2JlSU01V1lQSXM3Szl2UWd1Y1UxRlRu?=
 =?utf-8?B?eE5GLzBxL1hiUFExR3ltcFN6YUZLQ05uNWtERmRodnlsL2h6V0Y4b3YxRTMy?=
 =?utf-8?B?REppTFVnb3FTTUd2VVVBdmNEWXdoQ1pNS1Awb1J4a2w1eW95WGZ2WTFPUnlx?=
 =?utf-8?B?UHVPQmFNbS84TzdSajNleHo4aW9ScnkrbysvREI5WjBlT2luaEpwWHRTTDZO?=
 =?utf-8?Q?U0xaLq1dYQc6tsyvMY3d1Ew=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff70ff29-7ca6-44d4-4c2e-08da96e03ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 06:05:09.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6Sp5U5eYNLZxPMQFBNcWX1M2jSkW6G08Tr5Uk/7Dmf+nGOJcTPz/UMEPedNfQ2/wR0vlL5GJ8e0RiGXEQPzL9hSov02nGIrBOfAoxAvdb6FcPIr+Tj8REVJmZu8gdP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSZW4gWmhpamllIDxyZW56aGlq
aWUyQGh1YXdlaS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjIgODo0
NiBBTQ0KPiBUbzogS3VtYXJhdmVsIFRoaWFnYXJhamFuIC0gSTIxNDE3DQo+IDxLdW1hcmF2ZWwu
VGhpYWdhcmFqYW5AbWljcm9jaGlwLmNvbT47IGFybmRAYXJuZGIuZGU7DQo+IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnDQo+IENjOiBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgUmVuIFpoaWppZQ0KPiA8cmVuemhpamllMkBodWF3ZWku
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggLW5leHRdIG1pc2M6IG1pY3JvY2hpcDogcGNpMXh4eHg6
IEZpeCBidWlsZCBlcnJvciB1bnVzZWQtDQo+IGZ1bmN0aW9uDQo+IA0KPiBJZiBDT05GSUdfUE1f
U0xFRVAgaXMgbm90IHNldCwNCj4gbWFrZSBBUkNIPXg4Nl82NCwgd2lsbCBiZSBmYWlsZWQsIGxp
a2UgdGhpczoNCj4gDQo+IGRyaXZlcnMvbWlzYy9tY2hwX3BjaTF4eHh4L21jaHBfcGNpMXh4eHhf
Z3Bpby5jOjMxMToxMjogZXJyb3I6DQo+IOKAmHBjaTF4eHh4X2dwaW9fcmVzdW1l4oCZIGRlZmlu
ZWQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1mdW5jdGlvbl0NCj4gc3RhdGljIGludCBw
Y2kxeHh4eF9ncGlvX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMvbWlzYy9tY2hwX3BjaTF4eHh4L21jaHBfcGNp
MXh4eHhfZ3Bpby5jOjI5NToxMjogZXJyb3I6DQo+IOKAmHBjaTF4eHh4X2dwaW9fc3VzcGVuZOKA
mSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rpb25dDQo+IHN0YXRp
YyBpbnQgcGNpMXh4eHhfZ3Bpb19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRy
ZWF0ZWQgYXMgZXJyb3JzDQo+IA0KPiBjb21taXQgMWEzYzdiYjA4ODI2ICgiUE06IGNvcmU6IEFk
ZCBuZXcgKl9QTV9PUFMgbWFjcm9zLCBkZXByZWNhdGUNCj4gb2xkIG9uZXMiKSwgYWRkIG5ldyBt
YXJjbyBERUZJTkVfU0lNUExFX0RFVl9QTV9PUFMgdG8gZml4IHRoaXMNCj4gdW51c2VkLWZ1bmN0
aW9uIHByb2JsZW0uDQo+IA0KPiBGaXhlczogNGVjN2FjOTBmZjM5ICgibWlzYzogbWljcm9jaGlw
OiBwY2kxeHh4eDogQWRkIHBvd2VyIG1hbmFnZW1lbnQNCj4gZnVuY3Rpb25zIC0gc3VzcGVuZCAm
IHJlc3VtZSBoYW5kbGVycy4iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBSZW4gWmhpamllIDxyZW56aGlq
aWUyQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9taXNjL21jaHBfcGNpMXh4eHgvbWNo
cF9wY2kxeHh4eF9ncGlvLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWNocF9w
Y2kxeHh4eC9tY2hwX3BjaTF4eHh4X2dwaW8uYw0KPiBiL2RyaXZlcnMvbWlzYy9tY2hwX3BjaTF4
eHh4L21jaHBfcGNpMXh4eHhfZ3Bpby5jDQo+IGluZGV4IDljYzc3MWM2MDRlZC4uNGNkNTQxMTY2
YjBjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MvbWNocF9wY2kxeHh4eC9tY2hwX3BjaTF4
eHh4X2dwaW8uYw0KPiArKysgYi9kcml2ZXJzL21pc2MvbWNocF9wY2kxeHh4eC9tY2hwX3BjaTF4
eHh4X2dwaW8uYw0KPiBAQCAtNDA1LDcgKzQwNSw3IEBAIHN0YXRpYyBpbnQgcGNpMXh4eHhfZ3Bp
b19wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZQ0KPiAqYXV4X2RldiwNCj4gICAgICAgICBy
ZXR1cm4gZGV2bV9ncGlvY2hpcF9hZGRfZGF0YSgmYXV4X2Rldi0+ZGV2LCAmcHJpdi0+Z3Bpbywg
cHJpdik7ICB9DQo+IA0KPiAtc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKHBjaTF4eHh4X2dwaW9f
cG1fb3BzLA0KPiBwY2kxeHh4eF9ncGlvX3N1c3BlbmQsIHBjaTF4eHh4X2dwaW9fcmVzdW1lKTsN
Cj4gK3N0YXRpYyBERUZJTkVfU0lNUExFX0RFVl9QTV9PUFMocGNpMXh4eHhfZ3Bpb19wbV9vcHMs
DQo+ICtwY2kxeHh4eF9ncGlvX3N1c3BlbmQsIHBjaTF4eHh4X2dwaW9fcmVzdW1lKTsNCj4gDQo+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IGF1eGlsaWFyeV9kZXZpY2VfaWQgcGNpMXh4eHhfZ3Bpb19h
dXhpbGlhcnlfaWRfdGFibGVbXSA9IHsNCj4gICAgICAgICB7Lm5hbWUgPSAibWNocF9wY2kxeHh4
eF9ncC5ncF9ncGlvIn0sDQo+IC0tDQo+IDIuMTcuMQ0KVGhpcyBpc3N1ZSB3YXMgYWxyZWFkeSBy
ZXBvcnRlZCBieSBTdWRpcCA8c3VkaXBtLm11a2hlcmplZUBnbWFpbC5jb20+IGFuZCBhbHJlYWR5
IGEgcGF0Y2ggaXMgcXVldWVkIGFuZA0KaW4gcmV2aWV3IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFi
cy5vcmcvcHJvamVjdC9saW51eC1ncGlvL3BhdGNoLzIwMjIwOTEyMTEzNjM0LjE2NzgyMC0xLWt1
bWFyYXZlbC50aGlhZ2FyYWphbkBtaWNyb2NoaXAuY29tLw0KDQpUaGFuayBZb3UuDQoNClJlZ2Fy
ZHMsDQpLdW1hcmF2ZWwNCg==
