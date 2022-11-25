Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210AD6388DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKYLfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKYLff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:35:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3821D31D;
        Fri, 25 Nov 2022 03:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669376133; x=1700912133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OaTE9lM6uxnNLRQdXtxsNeIuv8nbPBrOeIYgns2DLns=;
  b=qThLyEeNIs7io4mKh8teh7SbeVH7mfXOvLFZc2AsUOM8JsHulPyRAbx+
   IQKC3ON1XDPQnbHq/+KkvcPF9/19toed9tZ/tNAp3DL5585qpv6h6EIGG
   Tp8mEG/XbOurJoAKVDf9tlM6i6FIRn5QIYVG7anVAyvuMfXxKJxSqGoqV
   NgyliQysN31996rU62pwE4MAo9qftRjNJ8oSMiY0vH7qXsSQSBsL0aqKA
   RAlVsJNOryqmIRdgWoB+Itd/3+qa1E3YaVQLOdaH8AsP/i04C/W5VcabB
   fWBNy1yOb1phvoFA0zFsUL65mEQ6seAeVbfd1YiLp+5bMhemX5DUZv2Jm
   A==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="190503612"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 04:35:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 04:35:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 04:35:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS4EIFFPd45qzyNmEEyUzegkjiR474EuKxfQ9/oBydmmjAgdkGbgRq7Rg8Xim5h7aVx1R4tPvK92DaG6sGJqZolXaPnXHK7TUZYNTRpPDCpickK5eHvYO6GacozNbeBInW7G8OoXrSkZTt7VlTHaX3Sf2/U/9n57nHUDYsqhpA38IPEc70KVjs3g6GlhoKt2eCeZfxeERrHn1yFe9PeWNVCh1IeQlG/ysYuybhDKcf9SVrkr0X32alRXTPyCU3tCs/Ae2q9Odw/1OBgaAdFaadLnCn2KgoHpfD3Cz2OV0weaK0KkIq2vZhDiN4lJb05BRFPRyoW7UyjLcGgnU4q7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaTE9lM6uxnNLRQdXtxsNeIuv8nbPBrOeIYgns2DLns=;
 b=dMHMsYuk6NRWNVG6cYwWkSEfrprc6iaPLrngeGH29rfyR3GfBQMFhfEswj4kr97G0ncH5ImSyG7ZxuIiqUno0mDNDALA/MDn75pLzP3BPMRacchRDXmf0rgSjAoSESQYMhTqEMs5JZf4s3DMETZuEn3TCt08r+BiQ+WAAGVihmO+Z3Zi7HqVUD1ha5U7Q/yvTt+yDscjqLDuImiU6PbJzOfqYAspnOqkjET0YMvVwtQXAiM2CTMQDJPecm5wkeQ4Hf0kr23d2qC5XG1SfJiLeaafy7cf2tcg/yndjmC2zxAzKQSHcix4AUd3BuYY/PY/TwHP7W3jGs0QTXK9S1MDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaTE9lM6uxnNLRQdXtxsNeIuv8nbPBrOeIYgns2DLns=;
 b=ossOBQwyHnuh5RoHpHv63uTzvjhTtZjhQhGvXHTIcmpoTm5LlaQkB1WYxhFQ/2reI99ahkyw5ldK4zHVxYkoGrcwLmzrnx5+GszAtUhV2X5Z0UXDFrfreDo/SqBeaDyWg+dwYktJTwfddqAGqCdzkEuNJtcdhXeLx4XC4R7iA3k=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CO6PR11MB5650.namprd11.prod.outlook.com (2603:10b6:5:35a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 11:35:29 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Fri, 25 Nov
 2022 11:35:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Topic: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Index: AQHZAMIFW8SHqTN2y06B6JRUYktOjw==
Date:   Fri, 25 Nov 2022 11:35:29 +0000
Message-ID: <359ad120-c8fd-5c09-1a74-f0b5a4e972a0@microchip.com>
References: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CO6PR11MB5650:EE_
x-ms-office365-filtering-correlation-id: 7f2a1376-1f50-4f48-fa25-08daced927ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KzfaSUtoZ1uhYeZw071K5aJPMgJuNEnnRHTfmY24cop9sh+Dv2qEhxtA3OcxRzqbRo6YeSAGV0DPC3C5DacczU6AH37vEDskq8zfy+XDVwvfSqfrB5IZGsIGXlocGzL9RlfU2Dqtzor5RQxC0YqhDw8CBZsgt0gE2uU0oiIPUMxsvLBAgiPMInr/Y2rePIF/8W1sKyJ2yZ4gLfpblVzgQFD9HKYB3GEjYYtmAgTqMtDtEeMqlcd+EdKxRFRoY2X3OAJsPnNCZeMNZbSIifnh2QhPeSe7IoKFYb18KWNQ0rFtoHV/utUtEwpjAzAEMOhuieA1nesbvPCXAa9eHQvB15RuHStq39fm939K5nEr/3ZTlwvztar7kBsnt13Ay1r5Z95wETNeUVhajGjC6iGTBCAOtEtfEA21P1Vh6I+sMjWkP5X6kYqodhf9yZShUjHdoQVm8nvI9v36ItzWzfn/sYo3RHTJObLkVyyvcztMDX6mdf1Ff4KOY5rbJzjCehdgdwSFG5qwZLiC8lNUGbjjDQgJg6oXtVDMulh3NPleFyG0ziDomIiPsrPkJkvm0NhV4N0dwGTpZd5dbg2/nsIuLwWNtc53hUSUJGwbQExTihJKQZ4NYr0qivTQ414wQ3L9TKjyuK903sOC1G4fe+fszVWPBTBUDnqBiJYos1nvaW03YW9vYMreLyNv+ORi8CjNHCAAlkcH4m2u8JQet/WbOzg2Ax5twWYXr2AToLAMDwJ+KtIMjKP8GxaKAdMvVtrQdzH7Gjn/5J/Hb60BCYN4ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(122000001)(31686004)(4744005)(8936002)(38100700002)(31696002)(5660300002)(76116006)(64756008)(8676002)(66446008)(66476007)(6486002)(54906003)(316002)(110136005)(2906002)(91956017)(36756003)(86362001)(4326008)(66946007)(66556008)(186003)(2616005)(6506007)(107886003)(38070700005)(53546011)(6512007)(41300700001)(478600001)(26005)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHFHc05rZEU4cUxjQjQ1Rm1pWkVNL2ZYMlJNbisyYkh3KzZyUHNsSmQyZ3NM?=
 =?utf-8?B?ejRGOGt4MUtmYi9NdHhDRHFnQTl1cFI0RjFwT3l2SnhDUFRhOFNYRVZkaUli?=
 =?utf-8?B?c3hRMU9OZHJWTTlkdWZhYkpXNDRZRUlXYUlGN1ZXK0k4UGtQZHI3M01talR5?=
 =?utf-8?B?NjdmbmcvY0x1VkNySHpVL0R6Q0M0N2Rua3V2ZDU2ajFUUzNyUkJIakYrclEy?=
 =?utf-8?B?emI4d2N4dXZLdHM5RVBWaTE0MWhkeml6eldibUxTUG40VlFZUlR1K1BBaFpx?=
 =?utf-8?B?ckJTdWF0WFlRc2M5eGRSQ0J2UjJoc2FtQWlkcnZ0cFVJVEZ2a1l6RGV6NlAz?=
 =?utf-8?B?SzVlWmphelZWck9iMnRQR3NIaGhMR3h4U0pYelFkNWFqMkp0dFcrQkpHbGh5?=
 =?utf-8?B?dExIeE1kWUJvV2JCUUFHUHoxQ3Q0VUVMaGErZmZaaDUvNUFkVzlYcGNhZjQ5?=
 =?utf-8?B?MTRzSklFQ3ZTUjVJUnIwWkdvejNKdnNoWmV1VytpL1hCRUcvc0xGQzcraEVj?=
 =?utf-8?B?bVJRS1dtYWJjalVpcElaSDBTdEdxem1HR3RlTkFLZHNkRUlJdXZuVHFZa3lJ?=
 =?utf-8?B?RllyTkRqM0JqZ2lvY3JxdURZY1lFK1U3YVN6RzI0bXY4dWxtd21jZmNnTndX?=
 =?utf-8?B?ZjdTc3N3NElyRGxDcnhFWlJsMVZzcmRycnJPR2FjbzZvWDRHaGFJVkszMVdX?=
 =?utf-8?B?TTVuTVBoMmRIKzFPUG1JTzZtckJTTWNvVDNOMklMcHo4dHJnM2lOc2EwZzBC?=
 =?utf-8?B?OHpXUWRZYlFlc0lwTlp2T3paZGZ4Y0hFNTQyQkZGaVF5U29KYjJVVktOb3hX?=
 =?utf-8?B?WFp4RVVPaURlWS9oOUJMbzNpOVg0dWg1aUVHNDR0TDZUcXR0RXM2bUkzQ2ZF?=
 =?utf-8?B?d0Z0Qk9yS09rZnJ5VGpjejRXWTUzRjhDcnUyMmVsaUZMR0Mra01WN0JXVlFP?=
 =?utf-8?B?SCsxM3paRnNsbjhuZmZlTEdWUktDT3dOYlVBYjRoZ2IxRG5zNTRHNTQ0bmV0?=
 =?utf-8?B?NCthTFdkL2FHbHZuMmdWUTBGYjhkTzllSkJ3WGNObW1OeGVqSy9QWDEvZ1k1?=
 =?utf-8?B?MGt0WXY2cHdEaXNsOVNwYnNBamg5QmZ0cWk5Sm5FZE9xbnRqaHdhUEgrZ1g3?=
 =?utf-8?B?bEs4c0FsWkRkYXJSZ0JKUWZYUVpRMXpxZk9kS0NMQnB0clY5NU1qSGVrSE9w?=
 =?utf-8?B?OXNaMXVMY085Vy82dTRnREJmNkdrZ3hnWnBuZDIyVHRtLzh5UTZGRm1MRzVz?=
 =?utf-8?B?dUlueXoxdmx0RnhPamJqRmtZMUJnMUd2U1hua25BaDdveWhweDl5V0FxQlgy?=
 =?utf-8?B?UFZuTmRBU1ZHbmI0WFh4Y09nRlpUb2FjMlUyZ1J1em9Nb3FqWVhUSmdDWUEz?=
 =?utf-8?B?c1dXRzBvMUZSL3dBZE1KWkh4MTZTVFczdnVwSUxFb1lYMmxxUlNTMWgxL3Zn?=
 =?utf-8?B?UXZQL3dzUE5PRUVNd1pFdWY2TlI0STNKWGVyQ3g3NjJqY1h0czRlVGZRQmx6?=
 =?utf-8?B?eWI1aXVvc2M3R3dQZUdHUVpVSElqQzZ3Mks4dS9OdnVpNmFKK1JvZ1NwOUQ4?=
 =?utf-8?B?M29aelpDTy95QStYWXBFNjduWFd3S2xXSG94a01BZ0xlcXJlaUZZeGlzVEM4?=
 =?utf-8?B?OTVPN3JGY1NCejRHakgxandiWU5LTzA0L2ZZa0lrUzBLWEdmMlE2OGxDYWRr?=
 =?utf-8?B?dmlUdG9pWTJ4K3RDbnhFa3Q3aVJUbVd5cmNEdlhxeEpmRDF1b0dWOEtoUTNu?=
 =?utf-8?B?LytzaGdHdG9LY0oyZDJzVDlacVpkMldKOGRMYlBkeVZvSVArWE9aaFZxRlBU?=
 =?utf-8?B?TllkaGFJMUNLdU9ZajBjdEE0Vm42cmkyL0hDNXlmdzgwRHRjRVRScnByMG9L?=
 =?utf-8?B?YUtNS2pya3hIWThSdmNCMkJSaWExU3l1WXRjU1crdnIrb09KNGEyWEx5VFFx?=
 =?utf-8?B?QWRESWYzeE0rNU1CTEtvcGZVemh3NDdtS3NxUzRPK0N2ZzN6WTlCR01OS0J1?=
 =?utf-8?B?cG5mTnIwa1Z4WmNRd1IwVWU1T25TUit4eDVtakNHa0hadVR1eWNNbVVpTjlw?=
 =?utf-8?B?WEhaY1JSL2ZNaXBrY1BHSExtV3dyaWxvajN0bTRvQnFhZUFBU0NMNDh5UVZr?=
 =?utf-8?B?VStNSGpHTHZmdGQrMEpQbjJJSnc5L3k3RzJFdGk0d1YzaVlCTlVmVW9KYXgr?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10FE33F89BCA2C4B93D54D5EF285912B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2a1376-1f50-4f48-fa25-08daced927ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 11:35:29.4841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5Gd2CX6fydM90TN5xIJhXti/9eMXowVM6cYpnTw2mlu9McimLBYFxrz/ZH8OAbm5UviN2l0JXYnR8LfDnn4abXVe9NWoWrUit1jhK3LmJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5650
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDkuMjAyMiAyMjo0OSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFkZCBPVFAgKG9u
ZSB0aW1lIHByb2dyYW1tYWJsZSkgc3VwcG9ydC4NCj4gVGhlIGJvdGggbGFuOTY2eCBTb2NTIChs
YW45NjYyIGFuZCBsYW45NjY4KSBoYXZlIHRoZSBzYW1lIE9UUCBJUC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEhvcmF0aXUgVnVsdHVyIDxob3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPg0KDQpB
cHBsaWVkIHRvIGF0OTEtZHQsIHRoYW5rcyENCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRz
L2xhbjk2NnguZHRzaSB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kgYi9h
cmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gaW5kZXggMjM2NjVhMDQyOTkwNi4uNzg0
Y2FiYTM2OTQ4NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNp
DQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBAQCAtMTYzLDYgKzE2
MywxMSBAQCBwb3J0NzogcG9ydEA3IHsNCj4gIAkJCX07DQo+ICAJCX07DQo+ICANCj4gKwkJb3Rw
OiBvdHBAZTAwMjEwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbGFuOTY2OC1v
dHBjIiwgIm1pY3JvY2hpcCxsYW45NjYyLW90cGMiOw0KPiArCQkJcmVnID0gPDB4ZTAwMjEwMDAg
MHgzMDA+Ow0KPiArCQl9Ow0KPiArDQo+ICAJCWZseDA6IGZsZXhjb21AZTAwNDAwMDAgew0KPiAg
CQkJY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWZsZXhjb20iOw0KPiAgCQkJcmVnID0gPDB4
ZTAwNDAwMDAgMHgxMDA+Ow0KDQo=
