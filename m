Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32C61337E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJaKVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiJaKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:20:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE3DFD3;
        Mon, 31 Oct 2022 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667211638; x=1698747638;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=i3AWJ0eZF6ybOZf8fyJV5SmgKAY5wU37VwGoz8327VY=;
  b=V4mMv91y5NttUx+8mOIYW7SJrOt1YeHmy8GevZgp8Sn7ahS3/ZHA1n+V
   ltCTa2bMgUJBJtX8LSVjo4NazEDBPVEHigwtTrtG7Ec9cyLrInHhOfCKt
   zCX9ONJWah0f7/toyj2WinZjuwLGCKDYIA5bsJ0FpNlvqylfO0vq1eQ1o
   ZdHHyeCvSZFflBNN/85OPLMygkoGEd8UoGUxhbQ9A8QYjlTNfhGDA8VQl
   Cgu0ZqVNpQQFJnjXcWZo5BeATPnE2HxLD3lK/PT6JsvBqJwTyL6JoQZQA
   83k6/uvj9y6uNc/oyT72R4bWGMtrT/eR0LqubBQEnP50Y/GfthSFbQnqx
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="181208554"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2022 03:20:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 31 Oct 2022 03:20:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 31 Oct 2022 03:20:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek3SIXlfq2Akm7/ZERuIH9N+O21q4PgBaVYxbq7MJyUQJycbEQdPwvcxCyNHj95LTwNOf3f9gMG2gLqptTpilQkyh2nwvGSPGWZGbUAg8v/u18ucx7VR30VpTMrsTvySmVqpEZi26FijYtgvxPh4IrbYRNMjERHlFL9qcdrm6Y3+KiXboNBVVaujNveZkrw850JS9Q1zi4U3oyRFi2U4ANeqq1NlpbqojAd5a+2XJWLiXyfPybIjSBbX54j9bYzWS8R8haHGHsnEMbR2mgLSFiM8ajiE1EMtedqPvUKC79/oqEY+MUnwdD2AE6n0HIkGWtu81RwwdECCTOmLFYNX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3AWJ0eZF6ybOZf8fyJV5SmgKAY5wU37VwGoz8327VY=;
 b=FK0cr7lokJBm38X0vhT4HYKjgxr819xUz0IbzCUHSH6D4vi2lV24+Pb9moBkm/ve2GIaodSVskFoz2ZVxzoNbim5vlyWyOH4ETUXnkzrMUMTqrupiyP8rDLDZrJxDMm901MliO+VxqQYR97a76lutBMEe3zqTOBpvuZqLeSAy6SOj8MTu0oLikiehXcAb0ItlMTC7B++l4Gxz4ywaznYYNhPa8zJpUM+gCcXvr0+82HH+2kHjSGkqBCepGHHLvHtBJJWifQhJ2/8hDGl68BOS3nl11C+DpkZ97M4vVoIq/BFVyi3HEhr53Jqv8tD2Zu98HUIkt3LCK/Kg2Mc78XHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3AWJ0eZF6ybOZf8fyJV5SmgKAY5wU37VwGoz8327VY=;
 b=iEqdtzMK9J40hIVlLchxOPe53j16wimEoOZvamQygBaURr0l5tEBTsoPAC2KZO23L4wg1iagsqkY3yBRYYvr7hHTDClQ6HKyJRlscjSvxRMO6cFlrVQiu4fewLevLMFdzgvlJHQI9leridzTQB+rCGpU6fIm2Kcgs5BQsfoyJT0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 10:20:30 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:20:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Manikandan.M@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCHv1 0/8] Add support for sam9x60 curiosity board
Thread-Topic: [PATCHv1 0/8] Add support for sam9x60 curiosity board
Thread-Index: AQHY7RJmT9OT40S3tUyTEDurBbRvXw==
Date:   Mon, 31 Oct 2022 10:20:29 +0000
Message-ID: <2902eb0e-815a-9147-49e4-182376df378d@microchip.com>
References: <20221031033653.43269-1-durai.manickamkr@microchip.com>
In-Reply-To: <20221031033653.43269-1-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BL1PR11MB5270:EE_
x-ms-office365-filtering-correlation-id: 9c391303-1ff4-4c03-000c-08dabb29894c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SBl9aFgpehLEUujlh6JIEgGWYp6q+CSYnBGp70uri4/FcFhM6k8K4KxgW3aHRmk9JsLqRHqE+3muUZYRzkZqWd+vURKcGJ83xIbV0I2/hVq8AURNeAdlgyCJT6sqHpZPrRNEjQkuuz5skSbh+TKjdVxytem/7TvwnPAlUt7owNrOZjfdqkFt5K4A/hhpxjNcxHUIYB20J5iz6zG4mzAeOBO3VHklSM7yOtJSdxluFrosdzI2odeNO28TIE8gw4voG7tCJgjuyRv/txdhjKu1ApDx322jcttxN8b6SvUvLoRfVQj5JIk4GWeNojoMSQLw8QVlf1D2TNr4jx9TvwyhOHlta3WpgVqzEMqsj0fh+2HHgwxoE+YqcRM+mlFKz47UZYLqVMNZLJgXSGZfnd5k9xedaVDm87JxXart6JVu9y2iT8YtL/zg7om6hjZ6JiZuCBPLq0WPOags0pai8tVateS1OvmQvv8oqGyYOXk8fcXPLhRVPVnZ0CDukC0fWqi8s7VDMKqQD3Qd2k3HUulySgEyjNwk4RfjZJ/S4V9dDC0bhvkOhwJQx6QWEIxzj9xhGqpE5Pk6YCE4E4Znc9WL76baMxbkt+nVYGk0+0LNnWo7EtMsljcMYbaLadDDdVHhKKZoeueJtjvCVh3O3srd6H3/J3k5XU7D+QLRo1e2wpyO6b0V6tr+C2uvi8maAzWdwWGYGTvnabNWnDx2iRSH3KNOhuXJmLNqpb6egwCSHXTweWyf/8oz4AhwdtopcLTU5fS6O5ZXcOopjsQnh4Bw2yzR0GaB1iu3JexS3GVzp8zMP2jgQGQplwGshiSw0JV1X9x0eofBHZPpa+tE6t5SHUZbBJv+D+xaNDdi6CZQAPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(5660300002)(6636002)(86362001)(2616005)(26005)(53546011)(6506007)(31696002)(478600001)(6512007)(71200400001)(36756003)(2906002)(6486002)(186003)(83380400001)(31686004)(76116006)(66556008)(38100700002)(66476007)(66446008)(122000001)(64756008)(66946007)(91956017)(38070700005)(921005)(8676002)(316002)(8936002)(110136005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmR2cnpYL2pCZXYwZTQrU0xIdWU5M1hSbTA1ZTMzbDNTblllN3d6WjllQllz?=
 =?utf-8?B?UVNCZE42Mm1JdmlHNG4vajh6OXUzb01OdlFWV2xXYzBuR2F6azQzYlI0NUF0?=
 =?utf-8?B?ZGo5d0JJc2tRUFkycjBEOFFRY3BLcWkrTEozTmRhZXBtTnNtT3ZoZ1V1MGNC?=
 =?utf-8?B?OWluMEYwTnNxWFJNRjBsdXlGRThjSzJJSGhZeTJzS3pyNnpqZG5HbU1teWU2?=
 =?utf-8?B?WkJKSytKb2tETG8xREc4VUREVnVKbG9Vc1hkV3NGU3lSN2NlbGkrYVM0S2s1?=
 =?utf-8?B?eFIvOXZlTVJLRzBUa1d5Z0lSZXkrRks0cythZnhEeS9vL3YweXBCRUJlbTY2?=
 =?utf-8?B?OGl2YjBPanQzVWVBTHV2bTV2cWhjSU9aeXdPc2JBVVh3eVhaN2F4cDhKRkcz?=
 =?utf-8?B?OFlvOWNtR2hwN1pYejJuRkRZRERUTWtSd1YxR0dZQXgrWDNJKzRXL2d5TVRy?=
 =?utf-8?B?cURWUzlDWUhHUEdyNUZXaEh6RVY0Q09jRFRac3pnK2RKOWlnZ1FVZlJyL1Ni?=
 =?utf-8?B?bms1bUNIRGp2M0tFNEpFRy9FNUo2VHlLcTV3MHlvTHQybkQ0Vk0wa0dMUHlu?=
 =?utf-8?B?SWlaTC9pMkZDeWtBemE0L09qNHNNQmsyZFpSc0ZydlhGWFNkOEtnSC90eHIw?=
 =?utf-8?B?K0hBS1lsUjlWYm9seENYV0tBVndxTjlHT2JrSE1oY0tWUU1VZlA2YWJ1V254?=
 =?utf-8?B?ZlhCam1IRGV3eUlMbFZGd2VoVjd6ME11TlhYOXhid1hGUTJMWFhqbUhmNXdz?=
 =?utf-8?B?Z0NvVExLZFpYOEVkZzNCM1hxaEFqSTJvUWpieGVYWUc2R1ZBTEIwNGRFYU9Z?=
 =?utf-8?B?SHQrUGVjRDkvL1cvZFZnZU81d3FVdzhaSVV6NmN2bE8yc090T3BKNGxFSlc4?=
 =?utf-8?B?TDFaSUlnWEhHWFVSdWsyeVBPdW5EQldpOWRrVFlnN2ZEWlJNT1hDNkR1OVBp?=
 =?utf-8?B?azlzWGpiMDJRMTk1b09iQ2xVbXNyZGR0aExBckE0ZnhqcVBHVWNmTENvK2ls?=
 =?utf-8?B?N20wZ3AxY2pESzlrSVQ4VGY5VGF1MkdrYTdmWm9XdzBac2JURFdqTWRQZy9z?=
 =?utf-8?B?UmU3ZTJFU1VGQTFLRnF6b2ttR3ZZaGh6aGdEdlFDT05ZUGQ3WlRKMm5FY2x6?=
 =?utf-8?B?YXNvREZqNkF0ZHFldUhYSHZISGljVFZsaTBzak1kQWZPR1B4aGNweEZvNzlG?=
 =?utf-8?B?OEYvdUY4RHdDZnU4a3hGVVkvQzVIcld5clZXaTNJemVqSFV4MkRIaWU3Y3Yx?=
 =?utf-8?B?djU3eFNVOTBxVGJrckVlLy9VemNaZU9Fc2Z3THVTcnJxSVN5dC85KzhzbzdP?=
 =?utf-8?B?Um4yTUdnUUliS3l0dFFNY3JWYU9YSHNsaGIyaGhqbW5kODdpT3BiNUZWRDhB?=
 =?utf-8?B?c3F0NjhrdUZuSUFpdGl6N1JNSzlqd0dVZThnbnJ2YkZabTlXdTFIdWRXSkRk?=
 =?utf-8?B?SHlONGZWSHpDeUpXeUlsSlJ1QVY1WlN5ZzRIcjhibk5Mcys4Q3c5QWw2UVd5?=
 =?utf-8?B?Y3h5dENheTZSL1Myc21lQUhxQ09kSDJ5Z0ZpZmFKUm5OZ2FLOGVyUHhramE0?=
 =?utf-8?B?VjN1ak9tUVhGWVZjUUVoL21XTy9Uenk0SGlUOEoyQ0k1ajFrb2pZWjg0MkVu?=
 =?utf-8?B?RUZaQVRQRmN2UmNZL2JkK2NacG9BUmVqRk5JUHozdzAydlJlN3JDVWU5UGJt?=
 =?utf-8?B?V3FtaWRHS2ZPdkpYSE1RdDA3N3dYY2FRWmxKdGx4QmdleU5ydWJwZzlCK1Z6?=
 =?utf-8?B?VkprRnpPYndsOFRhMng2TzZPYnk5UmttdW5Nc1IweTd2NWR1c2JySlJpUFhB?=
 =?utf-8?B?UFVVcGhiblBoNFpNNGZGb1lGVzlOS1VoSE9taDBtaC9MY1hqdnF1WkpYc2w4?=
 =?utf-8?B?S0g2bytUaWlaODRhWFRST0tkSmtjK1pqVEE5ZU1FbVhCcy9oVk1TM2NtZWJJ?=
 =?utf-8?B?T2hPYzZYRE9vcmtjV3g3TzhWTFh1Um1qcTRyalZITGlVdGFIK00vM3g0WHF1?=
 =?utf-8?B?MWY3enIvQVdmOW1ma0pDTU5yMkFSdUtqbDdzZTU3WXFqT0tsbGtZeCtic2lq?=
 =?utf-8?B?YUNJTXMxQjJJQU8wVjB4UEV5YnJHaUdzUm4xWFFsQkR4WEdnMFVIOE9SdTBi?=
 =?utf-8?B?d1N3TFdtemRqQUZheXZMVTErSzArTjBvV3hBM1dSbk1sTEZkQUI4QXBPSHVh?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0540C2A88E867449D2E58F3AE88BB97@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c391303-1ff4-4c03-000c-08dabb29894c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 10:20:29.7234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pv0glVnYXaxs5mug3s3qJ2eYL+p1YktBRTw/eE/jYQGkrJPFH58QCX1FRgTTdj9tYmoVQFVTSWpVOBlG4Qgb3IOtpLdjJ1G1NG+v3JmaVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMTAuMjAyMiAwNTozNiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IFRoaXMgcGF0
Y2ggc2VyaWVzIGFkZHJlc3NlcyB0aGUgZm9sbG93aW5nOg0KPiAtIE1vdmluZyBvZiBmbGV4Y29t
IGRlZmluaXRpb25zIGZyb20gYm9hcmQgZmlsZSB0byBTb0MgZmlsZSBhbmQNCj4gICBzb21lIG1p
bm9yIGNoYW5nZXMgdG8gaXRzIHByb3BlcnRpZXMuDQo+IC0gQWRkIHN1cHBvcnQgZm9yIHRoZSBu
ZXcgc2FtOXg2MCBjdXJpb3NpdHkgYm9hcmQgYmFzZWQgb24gdGhlDQo+ICAgZXhpc3Rpbmcgc2Ft
OXg2MCBTb0MuDQo+IA0KPiBDaGFuZ2VzIGluIHYxOg0KDQpUaGlzIHNlcmllcyBpcyBhY3R1YWxs
eSB2Mi4gQWxzbyBJIGNhbm5vdCBsb2NhdGUgeW91ciBwYXRjaGVzIG9uDQpsb3JlLmtlcm5lbC5v
cmcgZG9uJ3Qga25vdyB3aHkuLi4NCg0KPiAtLS0tLS0tLS0tLS0tLQ0KPiAtIEFkZGVkIGdlbmVy
aWMgbmFtZXMgZm9yIHJlZ3VsYXRvciBub2RlLg0KPiAtIFJlbW92ZWQgdGhlICNhZGRyZWRkLWNl
bGxzIGFuZCAjc2l6ZS1jZWxscyBwcm9wZXJ0eSB3aGljaCBzaG93cw0KPiAgIGNvbXBpbGF0aW9u
IHdhcm5pbmcuDQo+IC0gUmVtb3ZlZCB0aGUgcHJvcGVydHkgInN0YXR1cz1va2F5IiBhcyB0aGlz
IGlzIGRlZmF1bHQuDQo+IC0gTm8gdW5kZXJzY29yZXMgdXNlZCBmb3IgdGhlIHBpbmN0cmwgZGVm
aW5pdGlvbnMgYW5kIG5vZGUgbmFtZXMuDQo+IC0gT3JnYW5pc2VkIHRoZSBwYXRjaGVzIGluIHRo
ZSBsb2dpY2FsIHdheS4NCj4gLSBCaW5kaW5ncyBhcmUgbWFkZSBzZXBhcmF0ZSBwYWN0aC4NCj4g
DQo+IER1cmFpIE1hbmlja2FtIEtSICg1KToNCj4gICBBUk06IGR0czogYXQ5MTogc2FtOXg2MDog
cmVtb3ZlIGZsZXhjb20gZGVmaW5pdGlvbnMNCj4gICBBUk06IGR0czogYXQ5MTogc2FtOXg2MDog
QWRkIGZsZXhjb20gZGVmaW5pdGlvbnMNCj4gICBBUk06IGR0czogYXQ5MTogc2FtOXg2MDogQWRk
IG1pc3NpbmcgZmxleGNvbSBkZWZpbml0aW9ucw0KPiAgIGR0LWJpbmRpbmdzOiBhcm06IGF0OTE6
IEFkZCBpbmZvIG9uIFNBTTlYNjAtQ1VSSU9TSVRZDQo+ICAgQVJNOiBkdHM6IGF0OTE6IHNhbTl4
NjBfY3VyaW9zaXR5OiBBZGQgZGV2aWNlIHRyZWUgZm9yDQo+ICAgICBzYW05eDYwX2N1cmlvc2l0
eSBib2FyZA0KPiANCj4gSGFyaSBQcmFzYXRoICgxKToNCj4gICBBUk06IGR0czogYXQ5MTogc2Ft
OXg2MDogQWRkIERNQSBiaW5kaWdzIGZvciB0aGUgZmxleGNvbSBub2Rlcw0KPiANCj4gTWFuaWth
bmRhbiBNICgyKToNCj4gICBBUk06IGR0czogYXQ5MTogc2FtOXg2MDogRml4IHRoZSBsYWJlbCBu
dW1iZXJpbmcgZm9yIHRoZSBmbGV4Y29tDQo+ICAgICBmdW5jdGlvbnMNCj4gICBBUk06IGR0czog
YXQ5MTogc2FtOXg2MDogU3BlY2lmeSB0aGUgRklGTyBzaXplIGZvciB0aGUgRmxleGNvbSBVQVJU
DQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbCAgIHwg
ICA2ICsNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBfY3VyaW9zaXR5LmR0cyAg
fCA1MTkgKysrKysrKysrKysrKysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBl
ay5kdHMgICAgICAgICAgfCAgNTAgKy0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRz
aSAgICAgICAgICAgICAgICB8IDYyMyArKysrKysrKysrKysrKysrKysNCj4gIDUgZmlsZXMgY2hh
bmdlZCwgMTE1OSBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBfY3VyaW9zaXR5LmR0cw0KPiAN
Cg0K
