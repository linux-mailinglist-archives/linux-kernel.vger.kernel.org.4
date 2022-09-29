Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF65EF22B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiI2Jfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiI2JfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:35:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127A130727;
        Thu, 29 Sep 2022 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664444055; x=1695980055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c/GB20LCpa97nStw/UNWXxR8WRURXRIyl6fMNgF78vY=;
  b=cG+h/h9JescgDRoTArKP3phY2lVQ3nWTuGnyX6GsQVHhARxUnIaf0NY7
   +AcA0fgt8q1dsdUuLTHgCltO0hlfpDdhk4mNl7ut4QvvzYwbe0tm926EE
   9GdnhHfkz/X+XZML2gnvYf3nO+SGx1+cP9P5UNsO9e6ex0Vix4CfOodHY
   ss7zjyyQC/yXEazv3JiPTwSl2YdnfZzQSUEMLggjW4A6tneaagyXfWbKd
   N2+J0Vw4aCIJ+aQBtT8L2Dx2otPDAKUP+9ovYvn8S0tyXKft+bJ5phuGF
   JwHazZgaG7FhAA0ik8enNq4sykCk1Lx3dXb6mfjgBUM2kUU5AyiO6oV8p
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="193008648"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2022 02:34:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 29 Sep 2022 02:34:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 29 Sep 2022 02:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbCdyveVHk/Tz/aB9PjPTA72P+8p8shZ2rafUWGk5J5bbr+DdoP0uGtf4wrp/mCZCWeGYxcrB/8hxwFKBbFoeM558JVXb4LCJCbjNzRGsVZ8kdAZ4yfs6qzzj7lig5y883wZgTOyEXWKAUB6X+eAZ+ph3uKj7VJtaXdzkQxV4MWj21gfXW+837UQ67yeOX+hV3iMF28XR74SS/pi2n+kP/qAKRdU15z8BE7RpwDt0n8R70psMw4MrZYzpjdmhArRdZtgl4px/MjzyYlpGaFkwOXwExd/cYuxc0D0rNUeYIBc3m/fhDWAiW0nJXSJywlqiq2l5r90s918bkpVj5jZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/GB20LCpa97nStw/UNWXxR8WRURXRIyl6fMNgF78vY=;
 b=JTE1B9oD13PepDylDruCqowNcTrCz+e4CnlGA7h4NjfA6MXZVARr6TShc3YvKk362lE+yTbceOPVHOPTiC0H9U7yin24a5iBF42wvDGm18HoyDG7tg4Kq8DywS+7r6noWr7xZ7ERtbDdsPf8tovELbVOCvpGxPybSgHBie5OAFJc1iiiC9HwNknst6kI20EpEPnFoNavrJOEa6nqIBhYNnSp97NrEBJCYHnCdq1g38kd392cKAKIjufPL+qqDvjii7vAur1z+GAYYdN1Sudtqv07h+nEHwK/28J+cpYi7Of4qNFeLYdpm14VpC6L4RLywM1m2Jg4BEPpM9Aavqn54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/GB20LCpa97nStw/UNWXxR8WRURXRIyl6fMNgF78vY=;
 b=JglsLfb1U2Y62WEXxly7in6svWUg7jM8ggEfwrM/QKeP8W2yZvZmJ655i+DBnhW6I2i8HwZnS1AiXsY+2ErqPhBYHLpH7hIWYQBK4DHaqjSWE5EDzV6EGr1PCfobb1w96jHcM+LZlsTlWux7if90UeNBtEW8QNtJTH6Kc1n1ruA=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 09:34:08 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::38d0:523a:a044:eb27]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::38d0:523a:a044:eb27%6]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 09:34:08 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <andy.shevchenko@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's quad-uart driver.
Thread-Topic: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's quad-uart driver.
Thread-Index: AQHYvKqy1aZL4V02wEeXUUfPvF3Js63KmQcwgCu2x0A=
Date:   Thu, 29 Sep 2022 09:34:08 +0000
Message-ID: <BN8PR11MB366815C906C8A14359C4C5C1E9579@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
 <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
 <CAHp75Vc=D4GVmQ+ohk21iXPGvXMex3WLcRGtquy57D-e4fx-7Q@mail.gmail.com>
 <BN8PR11MB3668B198D4BB4E86FC3519C0E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
In-Reply-To: <BN8PR11MB3668B198D4BB4E86FC3519C0E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: 1d459f2d-e275-4fce-9c89-08daa1fdc264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LD6/jDhuJleEL2MVJ/35pr4bJ5MkXA8P1xQH0zPgS14ER+TeN5yYFBZUjNE8Y08aBYf72Sd1uw6mTFSjaupCWJvj0SC0y8J5isfUKq1S+AHu2EVuZ1/OZbiCuAY+QJgTuqHkEcoyKvG3ZnROHa72yH07ob48GfvQ3sQfkrcP6JWszCtQxHvAeKieN70RoeVU5kFQ2owwGv8OCrxxZUQjLEd+SzUkYllM01bcYBKsospNnq/P0mzjjqTEe3K81UNXIs7qTCx8DeWN+usz6+fJ9hyLdubQLWvoDq0DxqAmYiqBJK51rEG53Oi1MOZdG22q/Y7d6Rrmu6pqNpKgpu0pYeGuOWursD34TSWQNMphPQmJUQ/JcWaZ9VYuaXhEwox5p9lJGf+xXQlJPBXWOq7Ea7pt2vrcxUTr6LsEFk8Gx5MU+BBPWDkEDxK/Y4upQVh10SJbWa+gasXb69tDjUm68e6ibT/WdYQShykHp0Z6CC2sg4Vr4jZHklYA2YsUhTyLvRG6g8NdG+ojLlS79wqXW4k8m5KLhKaPdDw3XZBO7EqoEs11tU7fIg8NgLhI+AYTMkG5m0iaZMIKTzzMfCIHj3YK0IXKtEHn2wdT/jKbOS18m9YT+R3xSkBJzYazWkhyOvaPvljpJjVLoCFQ5jRTLmbIPYNzU7rvKiaKK6CvkvrmJhsFjc41vjkZ3LSsV3A47m9J1h4CTsaak32sqnao97xlNW3jWb9zQHpWWcyn/5XwYsMeA56QHb5/hr5OpcqXF9Em/neZlTT2HBtt0DR5Ms65z8H5pddvCUb8zqG6Bvc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(376002)(39840400004)(451199015)(7416002)(5660300002)(38100700002)(86362001)(2906002)(6506007)(26005)(107886003)(38070700005)(7696005)(41300700001)(9686003)(122000001)(53546011)(55016003)(6916009)(54906003)(76116006)(8676002)(478600001)(71200400001)(4326008)(66446008)(33656002)(66946007)(186003)(64756008)(66476007)(66556008)(316002)(83380400001)(8936002)(52536014)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UklpdmEwWlAxQ21uYTdIU0owVS9PNG96OWVVY1NLUmZDbnVGcnM0cU1ENElx?=
 =?utf-8?B?VWxMRWE1Vm5RTzZBUTRQK2Fjb213MlJqT0FjTkxBSUp1bnU3NEZ1UFZjYXZC?=
 =?utf-8?B?QVlQOWdLTFhyTmtGcGtCR2Zrem1ZdWhxS0t1YTkybndaclFoU1FCckFUd21q?=
 =?utf-8?B?cDMvZDg4NzZqSnl6c0tzSWxvbVFEYWRqZWY1eFVFMmJJRUg0aGw0Vm4yZlRv?=
 =?utf-8?B?MStJanQ2L3YwM1h2QzRrNGJVL0tibzltMjh2U0pVVnNuNEhBdkRDdXZUZldl?=
 =?utf-8?B?MzFPaE9ON3VHSXdJckcwbnlndUN2UUdVWUpzaUw1eGRBZUJEMmhJb0tkN0xP?=
 =?utf-8?B?T21xakpNY3kzaEFEZkQrUnl2VjVmazlKdjlWUjlsak5WWGRJdWN5VXJmQ1pn?=
 =?utf-8?B?cW9NY2F3N3BpR2htbGhBK0EwdHM2WWJjdXUyeVRwZnpQbHN6T205N09VNXV1?=
 =?utf-8?B?MnhxOHR0VjNHWHFDOHJuSk1Qb3h1SDNuR0Zjai9rSzY5SHl3RHFWS09rZjcr?=
 =?utf-8?B?cVplR2JDVzZhcThDZmZES0ZYc2I5RXNNMWozUWFhQkwwa3BTWTN3S1BOYWZE?=
 =?utf-8?B?SVQwRk9TaVZZb3paTXA1SjNrKzhaYllNazRUZ09leEFDaGFpN21zWEFBVVZF?=
 =?utf-8?B?d1pwYStOKy9ieVdSVGtWNVBYUDRjZU9HcFRoR1h4WUQrQlFFaXJmd0huTWo2?=
 =?utf-8?B?VTRRblNESkR5UUh2YnlEcit0c2NpN1JZaXlTSWwzcnZCMGc0THZiSmJqMEJU?=
 =?utf-8?B?WmhVN2ppK1lDbmoyWHF5SS8xZjEyb2hyY3VNOVY4cms1V3dsUG5jWHIxSUlM?=
 =?utf-8?B?dlhRa1Vhdm1sdGQvdjE0UTRRdVJYdDV4OVA1YTZmSnZzUEc0dXdUZ0ZOZ3g4?=
 =?utf-8?B?RFpyOFVFWFcrUnRXYnFJZCtPL0plbDFGanZxM2Z0aTFwSFdxdHMrWFJ1Y0lI?=
 =?utf-8?B?Q1UwYTEzbFZ3VnlaS05mR1lydEozRjFEUUdLeTVuemZ1OFpaakR2NkVxbW8v?=
 =?utf-8?B?VHJDUXROTUpCckVuVndPaGhQQkdTREJJbUJ0bVJaZmlQTEFqRjd6ekNWY01O?=
 =?utf-8?B?c1JGZ1FxVHVwWHllV3pCbm5Nb2VKOUJqeE1leVVrcUR4eFNxMldIQjFLVFdR?=
 =?utf-8?B?LzJXcVc5VmpsYUFVQ0NZanBWOUlyaFJJRUFENy85Z2dhK3Q4dUdTSXoyNVVI?=
 =?utf-8?B?ZWlkODRzNGEraGcrZVpsNlY1SW9Tamh4VW55aUYzUzNFRWJPNXNSM1ppY1E2?=
 =?utf-8?B?TkN2N3E2eDRmc21BWlBaT1dtSklrbUorNTVpTWd1NnZZaEVSNWkybEl0c0w4?=
 =?utf-8?B?bENsWWIvU3VvYzhwQmRBcU96WG5iSUp6VU5oK3V6NWhxRWpMdXk3YjFMdXF3?=
 =?utf-8?B?WkE3UUZYZVk0WVN2NFpuWmhqdXlmZ3kyVnpGb3ptdzgxTStMT3J1N1pjTVdq?=
 =?utf-8?B?ZXlIQVdGRkRGWnc2YWtmVGhiNWVrUXJTQmF4MTJzeVVKdGtYY3pGSWg3Yzlz?=
 =?utf-8?B?blBjd0xhZkxGUW5uQ3g5bnZZdU1DY29QUGRoWFV3Z2dtMzE4SUpucnFtbWRw?=
 =?utf-8?B?R0t1aFJKQy82V1V2S2dWQkNUTWNaOGNDdlJ1dG9YelY4UVB1T05HVkZBekZR?=
 =?utf-8?B?SWlHTGdpeHAyL0xoRHMwcVMra0pNaG1EaHEzeU1BYllQbks0aVhyMmErTWNq?=
 =?utf-8?B?dTVCZG5LQU9ZUzdob0x2dTRNc3Y4M2NxZitJSm56aHR4VDNuMHpMdTlNZWxT?=
 =?utf-8?B?OFMxOTZkb3Ixb3pYOGFtME15UDRXWERjOXdBZ1RmN1JtcGJKTzNETURBbUti?=
 =?utf-8?B?UTlnNVFLZG1oa2FBWHNIR3ZPeUVwRmVHYXYrMjU0bXNwUUkwTlQzdmQrM3JP?=
 =?utf-8?B?QWNmNUlBbXdPNkh2UkVhS1BmSVBmUzdJd1NsQ2dieE1MYndXQmtSOTN6ODho?=
 =?utf-8?B?a3RtRS9TelVZNHV0VmxISUdPeEgrQjdDOTVLRVlmeWc5R2VtOWdLOGlicmlN?=
 =?utf-8?B?NFEzS2NXRlBpR3JRakJQNzRuRVFWVGp6QUZjWFNjSHh5SWJTRGNNK3ZRNjN4?=
 =?utf-8?B?cWlGK0d3UlByODA5ZFpoZGVndi9tVDBpS2MzeWJVVnpzR3ZMOHpnV3QwWlVL?=
 =?utf-8?B?K1dsTlVIaEFOTGVWbjJwL0psYjU5WWpNcVZ6YUVIQjNaZkM1aG56MzlyTE9E?=
 =?utf-8?Q?3b2LhygzO+4EhvQQo2+xzVw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d459f2d-e275-4fce-9c89-08daa1fdc264
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 09:34:08.6049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iaPcbRqwIrCNPBCyNKVRZNGZhl7S3bWAYtLWOwJ+N6FWX91jTXeOM+dHNih+UjawGlEx7EWqiewJgegc8damr/pMcUplo+50X9aDRFHS6IrvB4LhtS4bgwWmQVrS4WW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdW1hcmF2ZWwgVGhpYWdhcmFq
YW4gLSBJMjE0MTcNCj4gPEt1bWFyYXZlbC5UaGlhZ2FyYWphbkBtaWNyb2NoaXAuY29tPg0KPiBT
ZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDEsIDIwMjIgNzoxOSBQTQ0KPiBUbzogQW5keSBTaGV2
Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiANCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtv
QGdtYWlsLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAzMSwgMjAyMiAxOjI2IEFN
DQo+ID4gVG86IEt1bWFyYXZlbCBUaGlhZ2FyYWphbiAtIEkyMTQxNw0KPiA+IDxLdW1hcmF2ZWwu
VGhpYWdhcmFqYW5AbWljcm9jaGlwLmNvbT4NCj4gPg0KPiA+DQo+ID4gT24gVHVlLCBBdWcgMzAs
IDIwMjIgYXQgOTowMSBQTSBLdW1hcmF2ZWwgVGhpYWdhcmFqYW4NCj4gPiA8a3VtYXJhdmVsLnRo
aWFnYXJhamFuQG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IHBjaTF4eHh4J3Mg
cXVhZC11YXJ0IGZ1bmN0aW9uIGhhcyB0aGUgY2FwYWJpbGl0eSB0byB3YWtlIHVwIHRoZSBob3N0
DQo+ID4gPiBmcm9tIHN1c3BlbmQgc3RhdGUuIEVuYWJsZSB3YWtldXAgYmVmb3JlIGVudGVyaW5n
IGludG8gc3VzcGVuZCBhbmQNCj4gPiA+IGRpc2FibGUgd2FrZXVwIHVwb24gcmVzdW1lLg0KPiA+
DQo+ID4gb24gcmVzdW1lDQo+IE9rLiBJIHdpbGwgbW9kaWZ5IHRoaXMuDQo+IA0KPiA+DQo+ID4g
Li4uDQo+ID4NCj4gPiBGaXJzdCBvZiBhbGwsIHdlIGhhdmUgcG1fcHRyKCkgYW5kIHBtX3NsZWVw
X3B0cigpIHdpdGggY29ycmVzcG9uZGluZw0KPiA+IG90aGVyIG1hY3JvcyBpbiBwbS5oLiBVc2Ug
dGhlbS4NCj4gPiBTZWNvbmQsIGlmIHlvdSBuZWVkIHRvIGR1cGxpY2F0ZSBhIGxvdCBvZiBjb2Rl
IGZyb20gODI1MF9wY2ksIHNwbGl0DQo+ID4gdGhhdCBjb2RlIHRvIDgyNTBfcGNpbGliLmMgYW5k
IHVzZSBpdCBpbiB0aGUgZHJpdmVyLg0KPiBPay4gSSB3aWxsIHJldmlldyBhbmQgZ2V0IGJhY2sg
dG8geW91Lg0KQW5keSwgSSB3YXMgYWJsZSB0byBzdGFydCBvbiB0aGUgdjIgZm9yIHRoZSBwYXRj
aCBvbmx5IGEgZmV3IGRheXMgYWdvIGFuZCBhYm91dCB0byBjb21wbGV0ZSBpdCBub3cuDQpJIGhh
dmUgYWJzb3JiZWQgbW9zdCBvZiB0aGUgY2hhbmdlcyBzdWdnZXN0ZWQgd2hlcmVhcyBmb3IgdGhl
IGFib3ZlIGNoYW5nZSBJIGZlbHQgaXQgbWF5IG5vdCBiZQ0KcmVxdWlyZWQgdG8gc3BsaXQgODI1
MF9wY2kuYyBhdCBsZWFzdCBub3cgYXMgdGhlcmUgaXMgb25seSBvbmUgZnVuY3Rpb24gc2V0dXBf
cG9ydCB3aGljaCBJIGhhdmUNCmR1cGxpY2F0ZWQgaW4gODI1MF9wY2kxeHh4eC5jLiBQbGVhc2Ug
bGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCkkgd2lsbCBzdWJtaXQgdGhlIHYyIHBhdGNoIGZv
ciByZXZpZXcgc29vbi4NCg0KVGhhbmsgWW91Lg0KDQpSZWdhcmRzLA0KS3VtYXINCg==
