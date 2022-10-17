Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4897600C23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJQKQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiJQKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:16:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FE846D88;
        Mon, 17 Oct 2022 03:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666001764; x=1697537764;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=T1yV5Wa/60lkxzki/9US5u4L6YoOZfe5PqLdhwEHxZk=;
  b=xg4rEddj/8XllGB521H6dRHN90VQqj0WsqabZgdApWYHkwRO0DLsEGXF
   r+CnwoT3JxvGRmqHWpZsTWcCcPFFIl+nJXJP3Ampf2GzPTCE/q2RKyP38
   xUdZIGw8ytoSSbiE1Carg4CurL2HiDSUIGTrqqdr9QcZLXJqPy1KW103Q
   Qy8Ja7Uq+ytcEee3mC2EWZwb3MJLw8X3TTUqlMy5q7VoNpOqQiy7WhoPu
   24MMH7puwntw2XzfsblvW8SJgWCB/1qusf3bYrzdcogpDy034JAXw+Yuj
   pUFdcN5tnHNyVBSDq+KNyk79b6jaQfkq9tuntbsXbT7XP70JHayJr0ms1
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="182488828"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Oct 2022 03:16:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 17 Oct 2022 03:15:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 17 Oct 2022 03:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idf17ch4DeJ4l6+pyRHHnbF8GWAOMJzuw+cE2TlYefXrZEkKn5aWOAWod/VWIOYip6SJTUSBNoBsoTHmmsyHRCoJ/Cp2md/f1sx1j3EzvO5svP04Xn9dNBolh9pm2WzVzoTKpEza4PAUizSuZf4abhgYTV6PlmbJToW83ODk1tUSTdcrZWz31Gm1pLb0MjJ83zJWy0EZVYk6CS0TvKdby5UTCFqL43av7qiZhOcfw7nFn/sAb8xZ1F/9ADYzTWhLMEYROtTyAVYDappbg1M5N5GeI8A0NuD9Vbp+OfV8Qiupc8xW/RnyEvTSXSpvoNkg2E5+IIrKm0Eom7UOCWIzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1yV5Wa/60lkxzki/9US5u4L6YoOZfe5PqLdhwEHxZk=;
 b=PjRAC5KlqVoBe2RQ1ix1rK7NjPgbNwIiJymlPcgfumOQSpXxJCv1XffyBqIToMWn6Z8u5zos9Ir6a86ySRKiGFESDI+R0WVPFsfQWS5Lclh/C8IyTI677VGNyVarcmqWUm4lT1t7YoQrpuQegUNVSWrhqfZHjJHLT+Uy/yeKm0qjHYG4Q7ZnWitZinPO9Rqew6XEAU7N82dvTQMF9BmxHxJ399qKAUff0bvhtH/RH2Ze1I6aq4/+a2BNzbEmxqd0G++Wl02tBSutCjAuDRna8v3r2tO6eDOfHTHP8pg5wVreQPdC1YiLC8IYo/lJ3qnfpYaBpMEJFfxW4aN8DffRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1yV5Wa/60lkxzki/9US5u4L6YoOZfe5PqLdhwEHxZk=;
 b=FdlMh/OnukC1MXp8grsbFJRhOw7JZJiHwyUt7NevUsy5CM4gVsE+MPiRqFTj1/9XwMBRZG3jnZSw1wq2IKy3Sd9UMtEDdJPfnGstrAqcxGGvKCkmwTCTz6LwKm+fWJNbSwPXbnc1HPxTkZdMY5GQcffJ/c6VzNspc/BV0srUZus=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Mon, 17 Oct 2022 10:15:55 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::cf13:1785:f79d:9eb9]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::cf13:1785:f79d:9eb9%7]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 10:15:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Mihai.Sain@microchip.com>, <robh+dt@kernel.org>,
        <Eugen.Hristev@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: fix signal name of pin PB2
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5: fix signal name of pin PB2
Thread-Index: AQHY4hFxZ6EBeZdWQ0Cywu5hGH+yEQ==
Date:   Mon, 17 Oct 2022 10:15:54 +0000
Message-ID: <b79fb530-f3ba-cc09-1838-cc84ad37175f@microchip.com>
References: <20221017083119.1643-1-mihai.sain@microchip.com>
In-Reply-To: <20221017083119.1643-1-mihai.sain@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|MW5PR11MB5882:EE_
x-ms-office365-filtering-correlation-id: 43781eee-0c7d-4949-95a5-08dab0289398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mzu9NeNjQVsPJTYp+zeJFFFtqCrKupDLeE3szn9IdN08B7kZCf+NQ3W4+3HnWaSpwLf2eJC1mNxKSMDQwyCvd9wZQqmBlqeOWe38BX149I5y6bLmaH737kaTo9GOeJTFeUhdRDByi+JDj4mrpIuzJZa6NwzccGfMKlZVB5DzAW4wLk9gOcqWIR0bYG7jYWQM6UkTYcjw2qI8/Dyzvq+6nJsmHOY0/TDZk19g2RnuRB1mk2DOiCUS0WiV1oeYugTma3ncWa1frx9/rpBraTBmtaYm/annpU4b0SoTt4b/Lz1hMVWDN2G4xF1/y+7v4pfldpU86RoeJzKjnvAqFI5ci+gl1ImJQRvY/MjSgudMHOyfr/aV2VOVlux3PHyOeAVvermOAIAZYZ9aFgYaqkVPCKEfltwc19vS5Rzkm+11bbg5wh/S6Zd9zt0iY+32gJh0QpueJsuApqP5BAYT7JHbhAECrw9uG1yaL4qSk1EJ3o+JFjL8MHoRzBU3i4x/osn4DigTBdolMjP6v+M7su7kyuimVOLKbyWxAZiHx04+rc1LmIPvV1wT0bFTf+i8/yqZEggxoZVMfL923wam3LG6tPSk5RZ0NwgKQPQ/fRntGarqPEE8ykWiFobrOCEcV7sCYW1L1bC5eitRcQ/KSol6F9/DgoZo4zjp4Cmw7Ewz79LG9JXCMuyx61SFCdlnvy3x/5yGHsPswo+lTfi8JnYWry/mfnIl7CXLwVunsZCZt7vCmv+rTkbG9yFBADX2gI5na/z9U+N6oyeFE9R5xYRoCOcL0p1huy9vrujqBswfeWIX5h4+pmhUyALWGMD+8ib+QLY3XTGslxPKCswXC8i3rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(31686004)(66556008)(66446008)(8676002)(66476007)(76116006)(110136005)(64756008)(316002)(6512007)(478600001)(6506007)(41300700001)(26005)(53546011)(186003)(71200400001)(2906002)(6486002)(5660300002)(2616005)(8936002)(36756003)(38070700005)(83380400001)(38100700002)(66946007)(91956017)(31696002)(122000001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUNWODMyS3h3SzR5U3YzTU5zWVpCSzVDSHJnd24yZFQrRldCTWE3VmV2N2dI?=
 =?utf-8?B?QitWeDdtWWQ1SEs4L1FrMmtEVGtrdnBaRlVEYjlEaVFlOGlRbHdZK1FPN2lN?=
 =?utf-8?B?eTB4WHBHZHQ0eGJHcnlFWTVURTVKUnVGTFQyVGhsbEthdmdBajB3c2pRd3Yz?=
 =?utf-8?B?dXR6eXQ3YlJwRCtNYUtMZTVMNXZOYU0rZEJ4NmVXaTFaQzhiYkxkQzRMV1Vt?=
 =?utf-8?B?WTRCVVB4dURGMnJqM1c0UzVkKzJpUUhnUmYrd2t4QWlySkNVYVlBditjVTVr?=
 =?utf-8?B?UUpOSG8rbWhIVFRGSFlCK1hEaWswbHJuMnEwS3lSY2kwdEliWFpzOVV5WEVp?=
 =?utf-8?B?ZlAzUmdSQW1OMjg3RWdpZWt1d01SVUpaZnJTaUhTZVE1MmpCY2tiQ3N1eUgr?=
 =?utf-8?B?ZGU0S3g2UVVVZWtmaURwYUU1cFBmWUJYOVoxNnZrNldqQk9iLzNwSHBEeXh1?=
 =?utf-8?B?eUdaeS8zNmp5am56ZzArOXV3TDFUalJZMGhhR3dkRlhDVEhnODFlUEV3YWlv?=
 =?utf-8?B?VjlyRWUwbzZNVHByaDR1R05qK012Zzc2ZWo3Rm9FRnFmVVNzQVYrd0xRNUhM?=
 =?utf-8?B?OFFRak85bWZ5Mk9aREhORGlrY1NYNmpycy9TbWNuMGdXWHh2Z01MQ1hhUWhF?=
 =?utf-8?B?Y1Axb3p3SUlpSGQxRUczWnpGN0QwR2RmamNCVEtQUTNtdDNTQ2x1QTltaUdB?=
 =?utf-8?B?ZWVSYk9KNE95bUNENnlOamdWMVlXVXBhVVNxWndOZUJtL2tDV3E4WUNnU0Fr?=
 =?utf-8?B?T293eTdwajBHRFRjekZ1NWYwZFgvWUkvdFAyazFTcmFrblpCY2tBZFBNUEhE?=
 =?utf-8?B?S0lEbFBuRDFWSzZVLzZ5aWVHOGh6RzdoWDBDQlFzWCtON0JzLzNwa29YRlNo?=
 =?utf-8?B?dmxDQWZOSW1FL01sUVFUNUd6dDRaLy85dFcxZmw5bVQ2MU9VMW44KzUzOXRo?=
 =?utf-8?B?Qkp5SUlQTm5oUC8vTVVNaStGcUVWUjRCMjFDS0Nqa3ZkRjYvbTFTZmlIOW1L?=
 =?utf-8?B?bEZteUpaYzhWaVNycjZkQlphTlg4RG10QUkzWmhVd1h4NGdvakVISHR4WGs2?=
 =?utf-8?B?YWFyZUNkYW9NclNjT1pXdG91a1U2UUQxUmxIZXMzLzNzdEhvS0U5dmIrVUFh?=
 =?utf-8?B?akx0T3JBbzNpZ20vdHdMM0w2Q2pwZElTWVN5SUdCUGw4REFvV3o5NDJESHFW?=
 =?utf-8?B?eXIzSFV2QXpMYk1RNnpBNDVaMFU5UGsxbXpGa3RSRXhzc2k0bGJweEtUbVpm?=
 =?utf-8?B?aVBRTDBJbkJRTzlDcTF5N2JaS2J5c0Z2MGJRemk3a0RPNi9PSnpnQm82ZCty?=
 =?utf-8?B?cXBTTkJ3Qnd5OUJ3U054VE9CVXJUWTJtOUwxdHZ1blNtZWs4eW1EY0FLdXZ1?=
 =?utf-8?B?NWg3Z1E4NjUrZVN6aHp0NTJVUlpscmt0OVF2TTRGdVNJWkYwbGJGalZyMjg1?=
 =?utf-8?B?RFNBYitQSFEzS2dYZCtTZWR1QXdlQXoyMHh1MXlqQnhaRmhGU2ZSdVRlUFR5?=
 =?utf-8?B?ZXZ6L2NWdFpEejlzNG8rSDV3TjVyeWZEZ0hkcXZoN3V6ZHFLZHhaQVlFWXds?=
 =?utf-8?B?SmR4RjltTEhneThraVpKWk9kS21TQjVMeWxQMkxIRENFa2Q3RUpQV0UwYk1N?=
 =?utf-8?B?NjRFZmFnVTNRbDgzWEtlQmJWS0lsTnlOWHNOMkk2cGUxdDZIR1JWL3pxM21K?=
 =?utf-8?B?NUdDUm5mc2l0cEJsZS9HTTREM1RJM3lYdC9DUnErcG5UQlI4eHh5M0pUd2M5?=
 =?utf-8?B?cGZqTnpxRmpOelhKdWpna0xYNjhHbFp1Rk93cW5FcllHWERHMlBQZFc2TkFu?=
 =?utf-8?B?ZnRHL0JySDFpcGpjTEo2cFpCZkhWV3htTmQ3L20rdDZpeXpibW9KRHBlWXdj?=
 =?utf-8?B?cW1GS0VwSE9uS3RSYTYvUXUyZ05BaHpHY2RCVW05T0JoSXA4N2FsSUVhd1Jv?=
 =?utf-8?B?Z0tzR213SFBwM1pYUytWVldZcm4rQzFRVTROZmptbkVVOVhteDFrenNEYWZP?=
 =?utf-8?B?ZTV1d1JySnpRUnErazhodGFPa21Dc3BYamVkS1BkVm5GZjNqNVk5eWp0N2Jw?=
 =?utf-8?B?bGw2TmR6UDRzR1Z6RDh6Zmx4dElZK3dKc2lZT1ZpK2Zhb1VDTE5vZVZkWGlt?=
 =?utf-8?B?WVRjS1l0clNVVHQ2U0ZnblJNemdEMnNEYithRUxCeHFleDF5S3VrVFFCM1RI?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A0E13BE87042D4890C46AF30FFD2F95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43781eee-0c7d-4949-95a5-08dab0289398
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 10:15:54.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nf0tEGuvtAZYlN0AA1l0P0FPq7ZRs5TDaTj++7RHcLO2klpGrzF/6gEwdCJY68pnBRHMN0UL4CQMDFRshkv0VBmr3LOTj4ruxPUVKbIePtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTcvMjIgMTE6MzEsIE1paGFpIFNhaW4gd3JvdGU6DQo+IFRoZSBzaWduYWwgbmFtZSBv
ZiBwaW4gUEIyIHdpdGggZnVuY3Rpb24gRiBpcyBGTEVYQ09NMTFfSU8xDQo+IGFzIGl0IGlzIGRl
ZmluZWQgaW4gdGhlIGRhdGFzaGVldC4NCj4gDQo+IEZpeGVzOiA3NTQwNjI5ZTJmYzcgKCJBUk06
IGR0czogYXQ5MTogYWRkIHNhbWE3ZzUgU29DIERUIGFuZCBzYW1hN2c1LWVrIikNCj4gU2lnbmVk
LW9mZi1ieTogTWloYWkgU2FpbiA8bWloYWkuc2FpbkBtaWNyb2NoaXAuY29tPg0KPiBBY2tlZC1i
eTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdl
ZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0t
LQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS1waW5mdW5jLmggfCAyICstDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LXBpbmZ1bmMuaCBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3NhbWE3ZzUtcGluZnVuYy5oDQo+IGluZGV4IDRlYjMwNDQ1ZDIwNS4uNmU4N2YwZDRiOGZj
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LXBpbmZ1bmMuaA0KPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LXBpbmZ1bmMuaA0KPiBAQCAtMjYxLDcgKzI2
MSw3IEBADQo+ICAjZGVmaW5lIFBJTl9QQjJfX0ZMRVhDT002X0lPMAkJUElOTVVYX1BJTihQSU5f
UEIyLCAyLCAxKQ0KPiAgI2RlZmluZSBQSU5fUEIyX19BRFRSRwkJCVBJTk1VWF9QSU4oUElOX1BC
MiwgMywgMSkNCj4gICNkZWZpbmUgUElOX1BCMl9fQTIwCQkJUElOTVVYX1BJTihQSU5fUEIyLCA0
LCAxKQ0KPiAtI2RlZmluZSBQSU5fUEIyX19GTEVYQ09NMTFfSU8wCQlQSU5NVVhfUElOKFBJTl9Q
QjIsIDYsIDMpDQo+ICsjZGVmaW5lIFBJTl9QQjJfX0ZMRVhDT00xMV9JTzEJCVBJTk1VWF9QSU4o
UElOX1BCMiwgNiwgMykNCj4gICNkZWZpbmUgUElOX1BCMwkJCQkzNQ0KPiAgI2RlZmluZSBQSU5f
UEIzX19HUElPCQkJUElOTVVYX1BJTihQSU5fUEIzLCAwLCAwKQ0KPiAgI2RlZmluZSBQSU5fUEIz
X19SRjEJCQlQSU5NVVhfUElOKFBJTl9QQjMsIDEsIDEpDQo+IA0KDQotLSANCkNoZWVycywNCnRh
DQoNCg==
