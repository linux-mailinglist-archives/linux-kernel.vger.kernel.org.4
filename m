Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02211662A47
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjAIPl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbjAIPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:40:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0478E167DF;
        Mon,  9 Jan 2023 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673278747; x=1704814747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lFMUlKisNgNQV5E2/Sbvv1yILss75ehmFZpeCuDg6fM=;
  b=vHNrYipEQqbKF3eESLbeag1OKlwbzTciqsc1+Ov42rkVG+MdW7a50C1I
   XZHyoZhgr7d+GQY5/L/cs7DT9u4+iMpD3x2xzIaOP+4hnF+k69XRL07BD
   +iQSqFDkUce6/9qWWG36KGhvhHoFw8e1rZgTBmVtm51chSj+MVEOtFaju
   zb6sDTNciZJvzcnLGSFqtDWURtTmS1ogbaNSvjdXiBXanIcg75a7vQcNX
   cOgz7/M1wReegbbHN2QG41IzYJkuKAw/YHqHxt6QY7owLeIWV/D+vA7Zk
   3aM1IhniZHnGiutXhueZl2Ym7FXPhsXg1sEZ/r2FCEoHQ9u79KoOwhDao
   w==;
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="195888136"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jan 2023 08:39:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 08:39:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 9 Jan 2023 08:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyJp+oj01DHqv2cftzO/HfaeN1UUd5MfYCTNF+o23vXP33ECNy9M4UAAq8TL6JPwmDvHOqP0oMa8ezYfW8kOMtRnsaNulDbQytZRD+77/DlhRo6LqsZVwgQLkgBiNC9BSowOInwGXSWAbHhPY/Djjg9ntfWCOalYVaXidD9sav5S5K6kMuw5Uqe0h8dw0Sltpo14lTVV4KZXpPBGOoFz1xeK2hOTBhjCh3b4J+115WBtgBsvgpIqlx/rSNp3J4lkHipVflIzyhLo09XhK/ZovgqTycSosytDHpCItJvrF6mYwAsLYAtC6dc9y6B5cwgwLastihlLwisI1UcFV5JU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFMUlKisNgNQV5E2/Sbvv1yILss75ehmFZpeCuDg6fM=;
 b=Wn68iySul7TX6eEzZFfh0zniow8qurXAMKoEZsGRRMSvbOb+rRn2Xsqyqu2EKm9bmR2wbqyIlJK56m5hiU4jiF0RtjKJa/MDoEuxvnGYkhE2dhfq6hzIqqo/KlpDaI9WRM1+ICo9fsIPTojwe/wFjejdn0sgCEUW+CEI6CuHB9NUfDe5Om02AiJbxEOMyF7sU2jH9GqarlfJP5wMGA/GPIT9zLWXKkoFpu1wBLEyqiJyNiF46SejQZI6UJ6fr4mrdW8upyfFY8Ee9cajImeTy0b/+UiewD73U61ZDWjmDXX+ccJUvdRmnlG+0ichQVx8CqBve+7kRbHlsTZ5TSquuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFMUlKisNgNQV5E2/Sbvv1yILss75ehmFZpeCuDg6fM=;
 b=Yy4VR3FBjbuHMtk5ulQUCO/RAPu5ZBhFSP+ZF0Z1/9dFcUPnfNVUtCmoWEtgKmhYIDfO9nbVTS956bk9PwGqyTflVnTAf/R8nC4LseAifiOzYfiPAXevwmvENmv5vhZ8V77F9nrCxCswyIuhBHw4ffM4VmF8QhuiNAqtl3Is5SE=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by DS0PR11MB7359.namprd11.prod.outlook.com (2603:10b6:8:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 15:39:04 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 15:39:03 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <jacopo.mondi@ideasonboard.com>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sakari.ailus@iki.fi>
Subject: RE: [PATCH v8 4/4] media: i2c: imx334: update pixel and link
 frequency
Thread-Topic: [PATCH v8 4/4] media: i2c: imx334: update pixel and link
 frequency
Thread-Index: AQHZIaC7QJROuHH6MU+8jl/H2lbDca6ROiaAgAUCz1A=
Date:   Mon, 9 Jan 2023 15:39:03 +0000
Message-ID: <PH0PR11MB5611F6586356C7CB9FEE941481FE9@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230106072931.2317597-1-shravan.chippa@microchip.com>
 <20230106072931.2317597-5-shravan.chippa@microchip.com>
 <20230106110453.woy7libfwlpgbpeq@uno.localdomain>
In-Reply-To: <20230106110453.woy7libfwlpgbpeq@uno.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|DS0PR11MB7359:EE_
x-ms-office365-filtering-correlation-id: e86d6a03-77b3-426f-71a5-08daf257a2cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FHmXvz8+W58hhPxT6TeCiyGrgCYZQdM3VnSv2mJkxKf3O1Cvx/M0+TUPJVajsnymS5Rkyf2uXlpyhZ8cFh1THCfNzVjA0sh8YB9I9b5C1MeQ7oYW6QdqvtlLwZHtL0bD6noYtzKZ+E8ogc9eEODLK4cNsBZeg1tXJDDeqa3S/uqRcBglqgqcJ2gA3jwNtEFcjDD3Itg0efvO6nWOmhf13URYdbKgtH1hosQwggMD1Ipo134CBAATPpY0GUlIkr3jSXykesq+B8nL/YOo8/19jNPEW2GO17q8t7722sHXgmS9Xv7XBJSds13UyW/LWAWbV5JB8p5Yib4magM6F1ktROe3FjJyZaZ+EEr2fGWVbQWD7vUADt/aqPULx6yhsZVX4cRPRs4fC37QQjrA1qIGgPj7XGxT43o3CAfIv7vFY8RjwN2ctvM+ae2GwZp6spdDc21TADnBmte3nxBXUd7bxQJKWvDEKfOoBZ1RUb2XhkN+lntDWjcnOZ2GW4RuxnSwqYL7OapHuSncroj2AEbLVsheWc+mqrEn6ftP6F2xED0QHKBiemrxawXaKsFFEQYwv8HfxvXxxvjQjzuSHL5UdqdB/qtYC0XkABchydzUW852cT53sxgykCX7Kd7TcfOix7yfkod5FNrDIWgfrz5OYxUVRdIPgV69fLP4/hjpleMCplb9TM0RYqrk9HzC4I1bpEjmyV6PWkXgKAW/zKiP8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(52536014)(54906003)(55236004)(26005)(71200400001)(64756008)(186003)(66446008)(66556008)(66476007)(76116006)(966005)(9686003)(478600001)(8676002)(5660300002)(83380400001)(41300700001)(2906002)(4326008)(316002)(15650500001)(8936002)(33656002)(66946007)(38070700005)(122000001)(7696005)(38100700002)(6916009)(53546011)(55016003)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3U2ZGE1V0NIYnppZUNmS2VjTDl4ZjVNdTB0QXk2U2tjSHYwYlU1WTh4NytU?=
 =?utf-8?B?U0g4QlVWQi9zejdMT1haQ3hVVzk0d2tVcnJBSnpRblZlNVVzdEFyUWFZZysy?=
 =?utf-8?B?aDBaZmhaTEF6K1A3MVQxMktFcnVjWmk1MVpMcDdnN3hDVVRJdGg2c2FGRldJ?=
 =?utf-8?B?MlVzM3g4emtqMC8rWDBnaVk0OXBpb3JVYkw2UDR6amUrMWpsZHg3TjgvQUtO?=
 =?utf-8?B?RHVTSEFRR3NiamNuR2RhY1pXVGFpTkxCY3hnb25tVHBUWE5UcVhNNDVac0NV?=
 =?utf-8?B?WGN1RGFzNEt3Y3dobSttNGt1a3lPMUhlaTJVVWdTVGROMFVFYmN2djNPVkxR?=
 =?utf-8?B?eWZjTkx0MlJWUkpoTWE4K3VPTkRCOEhHNC9yRXdoQ1ZHLzZvd1JPaDJ2L296?=
 =?utf-8?B?WFVqcWI5WkNWOUhuVTVER1BuQ3dBRCtVcGdxVWlvWEYrdlFUdWE2Ukxpb2pk?=
 =?utf-8?B?aWFUbG1vZnkxWm1JNklhZ3U0d3NjSGhHYUxITU9xUGhVVXMzVTJSMnAwclBU?=
 =?utf-8?B?N3NXY0V5OEVYcWdJb0J6aG1nRkRKVHVkWlFjRGdYS3lXdVhyTUFObENNTjRX?=
 =?utf-8?B?bTF2L20wYTVQM2pYOEZ3ay9vTHRINmF3SXZCcHNzWEJzZVRsZ2tiK3dxNm5Q?=
 =?utf-8?B?MDV1ZDNpdG92Q0MrcWxsWm1WZEJGb0xOd2wzWjB6czVXYURMM1Y2dmFobEw2?=
 =?utf-8?B?cnoxM3FWOUVhK3NXdjJwU0JuUlpjR2Q5akFiL0RpQ1dCc3FOMnZtV1pxRzZX?=
 =?utf-8?B?VDlpdlpWZ0pNOUlQV09vcEo0ZkUva0Jna05EQzZvNytuSDNRb3NpVDJlY0Nz?=
 =?utf-8?B?eER2d21mSC92aDR5U3lCOGRZekxpSjZRV3M3VTZ4V2JlQzFTNlF2RVFqaVJB?=
 =?utf-8?B?cElwOEt0OHFzZStHMlJOVU0zVTJzVEdPemlzbk1EaFhMRVFGaGZXTEU2WW9x?=
 =?utf-8?B?akhTZnNFT2NSNFJQVCtJNytOV3N6eEJNTWRxL0dLaU1pTEVham9VMkFucjkz?=
 =?utf-8?B?TnNvK1RtdEl1ekwrZFB3aWRMMHVMUFFIZllzeU1WUlhEOUp0VHFYOEVuOUZV?=
 =?utf-8?B?aWZROVFKWjc3TDhLUEs4RytZTkpQVUNBRy8zSXFGNmE5MFVDTFV3VVZJK2Vw?=
 =?utf-8?B?Vkp0cFgxQnliWEN5U2lMQkdlWms2RjJKejJxV1NSN0dKaG92QUtBSlZRMnpz?=
 =?utf-8?B?Yk1TWTZiOTUrSm9Xc2F0NHlZRllYUm43eWZOMjN3aVhDNGFHWWZFd1ZoRTRG?=
 =?utf-8?B?RWdQWVNqaGpXaDJBL0ZyWC9tSGlPUUxyK1lMTE9NdUl0eVZ5R0VJaDFuYnY3?=
 =?utf-8?B?a05OYUV0Y01nZ1BtTmtpYnI1UEtWOVBUQ2J0ZUg5MTJpUDR2REtmNjMrcFJR?=
 =?utf-8?B?TmJKaEE0WEtOT01NK3VyYkFTM0FXcVRNR2liMFVZWnNBQU5iSmxmRFpQdW45?=
 =?utf-8?B?MnVLanRyeVFLRFYwdlY0RTBPQzN5MnA0TTh2bWR1MDVndEZoY0ljQ0RtSHVR?=
 =?utf-8?B?b0ZCa0tRWkVPYmlFWWpmd3JZMlFkMGFOZVdpTkxqVHN3SEtiQWJ0dnpDYUxj?=
 =?utf-8?B?b1hGMEY0WmpwcGlPcUVMMkd0VE1oN3F0SFBGc1hnbUowWXRqQ1JBWVhIRTJt?=
 =?utf-8?B?VFdNbFBpeG1nMnV2ZVFYN2lGakZiQ3NYZmlUU3VjcVlUK2dBOU9UWnNrUmZ6?=
 =?utf-8?B?VVBGdmdCVEY1UUpicE0waFJUcVdTYS9UR1ZWYUpGdjZCTkYzN3hLV0xKQXI0?=
 =?utf-8?B?NDhmekxUSGtqbmRlZ3BvVTdHLzcwYkpxN2c2b1FzenpxTkdnc1RQbG1YRXpl?=
 =?utf-8?B?MXc5NUZlaEVBZTdBcEpUaXVkaFZIYVJBS0Q0NW9tSVJROTJjM0xGdzJtTE5G?=
 =?utf-8?B?bkpHMDhsRk1OeWJKdGtVY2RYYjZSTHZPcW9YbGFEMGJHTlBMNTZUQWJweFBk?=
 =?utf-8?B?K3BpZ3FwN3gvQlRWclNtWkJJVzVQT2F5MWZhZXh4MDZneDR1c0ZqOTlQWjVW?=
 =?utf-8?B?cXNCbFFrQWc3dmJrNm4zZEhSd3J0ZURpamJqS1Bod1F3ODd5ZS8rVEF2Q0hM?=
 =?utf-8?B?S3o5NUhPRFA1eVBqNUZDZ0xQWE1GNE56dWdXZ0FRNElCaGQyb2hGNmNHZlRM?=
 =?utf-8?B?UXAyM3YwbWVjQmtGL0FIbnRIdS9UampmVUU0NnFRcXJoTWMrWjdkTjBCUUtp?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86d6a03-77b3-426f-71a5-08daf257a2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 15:39:03.3508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z60JZ62Om2QLKKHsD9WiyJfTcOrcixPWHf0smbSUyW8gbpZaImv3u71zgMtJ6L/CMRA/p04CQfyFLvrxLe34PXLnzwD6Bnma6leCSKtu6CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7359
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb3BvIE1vbmRpIDxq
YWNvcG8ubW9uZGlAaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDogMDYgSmFudWFyeSAyMDIzIDA0
OjM1IFBNDQo+IFRvOiBzaHJhdmFuIENoaXBwYSAtIEkzNTA4OCA8U2hyYXZhbi5DaGlwcGFAbWlj
cm9jaGlwLmNvbT4NCj4gQ2M6IHBhdWwuai5tdXJwaHlAaW50ZWwuY29tOyBkYW5pZWxlLmFsZXNz
YW5kcmVsbGlAaW50ZWwuY29tOw0KPiBtY2hlaGFiQGtlcm5lbC5vcmc7IGxpbnV4LW1lZGlhQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNha2FyaSBB
aWx1cyA8c2FrYXJpLmFpbHVzQGlraS5maT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCA0LzRd
IG1lZGlhOiBpMmM6IGlteDMzNDogdXBkYXRlIHBpeGVsIGFuZCBsaW5rIGZyZXF1ZW5jeQ0KPiAN
Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBqYWNvcG8ubW9uZGlAaWRlYXNvbmJv
YXJkLmNvbS4gTGVhcm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFNocmF2YW4NCj4gDQo+IE9uIEZyaSwgSmFu
IDA2LCAyMDIzIGF0IDEyOjU5OjMxUE0gKzA1MzAsIHNocmF2YW4ga3VtYXIgd3JvdGU6DQo+ID4g
RnJvbTogU2hyYXZhbiBDaGlwcGEgPHNocmF2YW4uY2hpcHBhQG1pY3JvY2hpcC5jb20+DQo+ID4N
Cj4gPiBVcGRhdGUgcGl4ZWxfcmF0ZSBhbmQgbGluayBmcmVxdWVuY3kgZm9yIDE5MjB4MTA4MEAz
MCB3aGlsZSBjaGFuZ2luZw0KPiA+IG1vZGUuDQo+ID4NCj4gPiBBZGQgZHVtbXkgY3RybCBjYXNl
cyBmb3IgcGl4ZWxfcmF0ZSBhbmQgbGluayBmcmVxdWVuY3kgdG8gYXZvaWQgZXJyb3INCj4gPiB3
aGlsZSBjaGFuZ2luZyB0aGUgbW9kZXMgZHluYW1pY2FsbHkNCj4gPg0KPiA+IFN1Z2dlc3RlZC1i
eTogU2FrYXJpIEFpbHVzIDxzYWthcmkuYWlsdXNAaWtpLmZpPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL21lZGlhL2kyYy9pbXgzMzQuYyB8IDExICsrKysrKysrKystDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9pMmMvaW14MzM0LmMgYi9kcml2ZXJzL21lZGlhL2ky
Yy9pbXgzMzQuYw0KPiA+IGluZGV4IDAzMTVlMWM5NTQxZC4uOGMzYmE2NjBhYmFlIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvaTJjL2lteDMzNC5jDQo+ID4gKysrIGIvZHJpdmVycy9t
ZWRpYS9pMmMvaW14MzM0LmMNCj4gPiBAQCAtNTAsNiArNTAsNyBAQA0KPiA+DQo+ID4gIC8qIENT
STIgSFcgY29uZmlndXJhdGlvbiAqLw0KPiA+ICAjZGVmaW5lIElNWDMzNF9MSU5LX0ZSRVEgICAg
IDg5MTAwMDAwMA0KPiANCj4gSSBndWVzcyB5b3Ugd2FudCB0byByZW5hbWUgdGhpcyBvbmUgdG8g
IElNWDMzNF9MSU5LX0ZSRVFfODkxTQ0KPiANCj4gR2l2ZSBvdXIgcHJldmlvdXMgZGlzY3Vzc2lv
biB0aGlzIHNlZW1zIGNvcnJlY3QgZm9yIHRoZSBmb2xsb3dpbmcgbW9kZQ0KPiANCj4gICAgICAg
ICB7DQo+ICAgICAgICAgICAgICAgICAud2lkdGggPSAzODQwLA0KPiAgICAgICAgICAgICAgICAg
LmhlaWdodCA9IDIxNjAsDQo+ICAgICAgICAgICAgICAgICAuaGJsYW5rID0gNTYwLA0KPiAgICAg
ICAgICAgICAgICAgLnZibGFuayA9IDIzNDAsDQo+ICAgICAgICAgICAgICAgICAudmJsYW5rX21p
biA9IDkwLA0KPiAgICAgICAgICAgICAgICAgLnZibGFua19tYXggPSAxMzI4NDAsDQo+ICAgICAg
ICAgICAgICAgICAucGNsayA9IDU5NDAwMDAwMCwNCj4gICAgICAgICAgICAgICAgIC5saW5rX2Zy
ZXFfaWR4ID0gMCwNCj4gICAgICAgICAgICAgICAgIC5yZWdfbGlzdCA9IHsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgLm51bV9vZl9yZWdzID0gQVJSQVlfU0laRShtb2RlXzM4NDB4MjE2MF9y
ZWdzKSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgLnJlZ3MgPSBtb2RlXzM4NDB4MjE2MF9y
ZWdzLA0KPiAgICAgICAgICAgICAgICAgfSwNCj4gICAgICAgICB9LCB7DQo+IA0KPiAgICAgICAg
IGR1cmF0aW9uOiAoMzg0MCs1NjApICogKDIxNjArMjM0MCkgIC8gNTk0MDAwMDAwID0gMzNzZWMg
PSAzMEZQUw0KPiAgICAgICAgIGxpbmtfZnJlcSAoMzg0MCs1NjApICogKDIxNjArMjM0MCkgICog
MzAgKiAxMiAvIDggPSA4OTEwMDAwMDANCj4gDQo+IFdoaWNoIHdvcmtzIHdlbGwgaWYgd2UgdXNl
IG1pbl92YmxhbmsgPSA5MCBmb3IgNjBGUFMNCj4gDQo+ICAgICAgICAgZHVyYXRpb246ICgzODQw
KzU2MCkgKiAoMjE2MCs5MCkgIC8gNTk0MDAwMDAwID0gMC4xNiA9IDYwIEZQUw0KPiAgICAgICAg
IGxpbmtfZnJlcSAoMzg0MCs1NjApICogKDIxNjArOTApICAqIDYwICogMTIgLyA4ID0gODkxMDAw
MDAwDQo+IA0KPiANCj4gPiArI2RlZmluZSBJTVgzMzRfTElOS19GUkVRXzQ0NU0gICAgICAgIDQ0
NTUwMDAwMA0KPiANCj4gQnV0IHRoaXMgZG9lc24ndCB3b3JrIHdlbGwgZm9yIG1lDQo+IA0KPiAg
ICAgICAgIHsNCj4gICAgICAgICAgICAgICAgIC53aWR0aCA9IDE5MjAsDQo+ICAgICAgICAgICAg
ICAgICAuaGVpZ2h0ID0gMTA4MCwNCj4gICAgICAgICAgICAgICAgIC5oYmxhbmsgPSAyODAsDQo+
ICAgICAgICAgICAgICAgICAudmJsYW5rID0gMTE3MCwNCj4gICAgICAgICAgICAgICAgIC52Ymxh
bmtfbWluID0gOTAsDQo+ICAgICAgICAgICAgICAgICAudmJsYW5rX21heCA9IDEzMjg0MCwNCj4g
ICAgICAgICAgICAgICAgIC5wY2xrID0gNzQyNTAwMDAsDQo+ICAgICAgICAgICAgICAgICAubGlu
a19mcmVxX2lkeCA9IDEsDQo+ICAgICAgICAgICAgICAgICAucmVnX2xpc3QgPSB7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIC5udW1fb2ZfcmVncyA9IEFSUkFZX1NJWkUobW9kZV8xOTIweDEw
ODBfcmVncyksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIC5yZWdzID0gbW9kZV8xOTIweDEw
ODBfcmVncywNCj4gICAgICAgICAgICAgICAgIH0sDQo+ICAgICAgICAgfSwNCj4gDQo+ICAgICAg
ICAgZHVyYXRpb246ICgxOTIwKzI4MCkgKiAoMTA4MCsxMTcwKSAvIDc0MjUwMDAwID0gNjZtc2Vj
ID0gMTZGUFMNCj4gICAgICAgICBsaW5rX2ZyZXEgPSAoMTkyMCsyODApICogKDEwODArMTE3MCkg
KiA2MCAqIDEwIC8gOCA9IDM3MTI1MDAwMA0KPiANCj4gRG8geW91IGFncmVlIHdpdGggdGhlIGFi
b3ZlIG9yIGhhdmUgSSBtaXNzZWQgc29tZXRoaW5nID8NCj4gDQo+IEkgdW5kZXJzdGFuZCB5b3Ug
Z2V0IDMwIEZQUyB3aXRoIHRoZSAxOTIwKjEwODAgbW9kZSBzbyBjb3VsZCB5b3UgcGxlYXNlDQo+
IGNoZWNrIGluIHRoZSBuZXdseSBpbnRyb2R1Y2UgbW9kZSByZWdpc3RlciB0YWJsZSB3aGF0IGFy
ZSB0aGUgYWN0dWFsIHZhbHVlcyBmb3INCj4gdGhlIGJsYW5raW5ncyBhbmQgY29tcHV0ZSB0aGUg
cGl4ZWxfcmF0ZSBhbmQgbGlua19mcmVxIGFjY29yZGluZ2x5ID8NCg0KSSB3aWxsIHRyeSB0byBj
b3JyZWN0IHRoZSBoYmxhbmsgYW5kIHZibGFua19taW4uDQoNClRoYW5rcywNClNocmF2YW4NCg0K
PiANCj4gPiAgI2RlZmluZSBJTVgzMzRfTlVNX0RBVEFfTEFORVMgICAgICAgIDQNCj4gPg0KPiA+
ICAjZGVmaW5lIElNWDMzNF9SRUdfTUlOICAgICAgICAgICAgICAgMHgwMA0KPiA+IEBAIC0xNDUs
NiArMTQ2LDcgQEAgc3RydWN0IGlteDMzNCB7DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHM2NCBs
aW5rX2ZyZXFbXSA9IHsNCj4gPiAgICAgICBJTVgzMzRfTElOS19GUkVRLA0KPiA+ICsgICAgIElN
WDMzNF9MSU5LX0ZSRVFfNDQ1TSwNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKiBTZW5zb3IgbW9kZSBy
ZWdpc3RlcnMgKi8NCj4gPiBAQCAtNDY4LDcgKzQ3MCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
aW14MzM0X21vZGUgc3VwcG9ydGVkX21vZGVzW10NCj4gPSB7DQo+ID4gICAgICAgICAgICAgICAu
dmJsYW5rX21pbiA9IDkwLA0KPiA+ICAgICAgICAgICAgICAgLnZibGFua19tYXggPSAxMzI4NDAs
DQo+ID4gICAgICAgICAgICAgICAucGNsayA9IDc0MjUwMDAwLA0KPiA+IC0gICAgICAgICAgICAg
LmxpbmtfZnJlcV9pZHggPSAwLA0KPiA+ICsgICAgICAgICAgICAgLmxpbmtfZnJlcV9pZHggPSAx
LA0KPiA+ICAgICAgICAgICAgICAgLnJlZ19saXN0ID0gew0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAubnVtX29mX3JlZ3MgPSBBUlJBWV9TSVpFKG1vZGVfMTkyMHgxMDgwX3JlZ3MpLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAucmVncyA9IG1vZGVfMTkyMHgxMDgwX3JlZ3MsIEBAIC01
OTgsNiArNjAwLDExDQo+ID4gQEAgc3RhdGljIGludCBpbXgzMzRfdXBkYXRlX2NvbnRyb2xzKHN0
cnVjdCBpbXgzMzQgKmlteDMzNCwNCj4gPiAgICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+ICsgICAgIHJldCA9IF9fdjRsMl9jdHJsX21vZGlmeV9y
YW5nZShpbXgzMzQtPnBjbGtfY3RybCwgbW9kZS0+cGNsaywNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbW9kZS0+cGNsaywgMSwgbW9kZS0+cGNsayk7DQo+ID4gKyAg
ICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICAg
ICAgIHJldCA9IF9fdjRsMl9jdHJsX21vZGlmeV9yYW5nZShpbXgzMzQtPmhibGFua19jdHJsLCBt
b2RlLT5oYmxhbmssDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1v
ZGUtPmhibGFuaywgMSwgbW9kZS0+aGJsYW5rKTsNCj4gPiAgICAgICBpZiAocmV0KQ0KPiA+IEBA
IC02OTgsNiArNzA1LDggQEAgc3RhdGljIGludCBpbXgzMzRfc2V0X2N0cmwoc3RydWN0IHY0bDJf
Y3RybCAqY3RybCkNCj4gPiAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0KGlteDMzNC0+ZGV2
KTsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgY2FzZSBWNEwyX0NJ
RF9QSVhFTF9SQVRFOg0KPiA+ICsgICAgIGNhc2UgVjRMMl9DSURfTElOS19GUkVROg0KPiA+ICAg
ICAgIGNhc2UgVjRMMl9DSURfSEJMQU5LOg0KPiANCj4gU2FtZSBxdWVzdGlvbiBhcyBmb3IgcGF0
Y2ggMS80OiBEbyB3ZSBuZWVkIHRoZXNlIHNhZmV0eSBjaGVja3MgZm9yIHJlYWQtb25seQ0KPiBj
b250cm9scyA/DQo+IA0KPiBUaGFua3MNCj4gICBqDQo+IA0KPiA+ICAgICAgICAgICAgICAgcmV0
ID0gMDsNCj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4N
Cg==
