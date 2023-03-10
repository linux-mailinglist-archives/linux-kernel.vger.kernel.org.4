Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2F6B3F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCJMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCJMXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:23:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545218B20;
        Fri, 10 Mar 2023 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678450983; x=1709986983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xHEN0zyiUrxBJL5iUPoCzanuNxEczQR9+Ug6FHSiWL0=;
  b=e+IKutbe9k1cPP2DQQXwkw6Wiz/7b0uIoApGWkrsXDm6G/7rU/LZh7gi
   ZlQYaBvABUvuSKvZPyuPg2SIaaoxVYULBiY73STUTHlDq3lyNOq4IhUzC
   PbEPYbGJk74FYcB0wDiIeLcF0ZPZL5juPIY9KYOp0LcbA8fWmWCHi9IJ8
   l0P8ZvCIMv985i69qxQW/+HVUNOxZO9eMd8XXrx4KslMyRFmvsW1YtSau
   M7cQujqYEwuqUknrSoKlSlIKuvHw99gwkiiJMSl9ZRWD7PzeTOjrz5S7F
   ZfRhVsbpfN00OIfu5Ezzmt7ekiYlUWdS2K16q1Ip9frovUWugGw2dRaYK
   w==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673938800"; 
   d="scan'208";a="204731699"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2023 05:23:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Mar 2023 05:22:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 10 Mar 2023 05:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyleJifxAd8hRwh4r8h8f9zbk3CdE12mWCLFHfjr90g7nyFp0VmsGkJVoGfMb1k7F8Ch4cE686otKY2Guro+XB5M2VKm4cNvl665UtupPzekQGP6Y/TyGT7k1Gg2o/Wj/qm8F5xd2zivIyJCw7m+IQCTEV5Gkjn3bSJ5YMFfrLzbuSWJq8nPKlzqCmhKXfSAE2Qr3RyAUj/SpdT5mfkAI+xtt6AEXcXW61HaY3AF6M2coUcgtPkm0X0GMNbZ5oh4kWQsOvVVqTaPXe+oP2naYGZBLZfQ3+PgWr4h/hEfSiT20tHMKPrViHW7tUsTFbpRkDbWA+xhLr8FsCuQn8hSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHEN0zyiUrxBJL5iUPoCzanuNxEczQR9+Ug6FHSiWL0=;
 b=FI49Ahkt4qWPM6K4u25lxG7ixW9JubbN6F1YBZUI6rLXmBbm+kCvePBAMNE0d4c+dy4/fKo10lxvNu6akcNXFLNONo6AW7Jxt2KQT3yW48PuB9GpC2sRNINUpGcSSaj/RqJ16wR+riuwWbRNMEjkryVYLFpxj+WNHqYldw04lCO77Vy3D5iMaVgG6nSLecF+Fgrngpqiwq/0/wuvd4bMogrvISLzjUT8EcTGlOiaaOZsfaG71i+dIiCVY+aZYBIo3Jfisu1o49nXowBIqtMsMGVtwkA2yTXkg/HfCxKxlGAfRwSHvXm6xXUtcUl5EI5WiqVpd07vNf6YgNrs+Eydpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHEN0zyiUrxBJL5iUPoCzanuNxEczQR9+Ug6FHSiWL0=;
 b=c3hVlObBhap7PDc3b/FM98epJ7izlvGYsm/zXB8PUuv+FeWuZKk1tkeRLEPuoDdrUY8k68hbHn06y+nQPaxbeNl7Y4KW7xSWDIzM8KgyXsD4F15dCU0lYaF2YFCvg9RNdVcj/22Zh8V/SSHtz1f2fsUX96mnWK591a2FDcWP+AQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 12:22:52 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 12:22:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <quic_wcheng@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <mathias.nyman@intel.com>, <perex@perex.cz>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
Subject: Re: [PATCH v3 08/28] ASoC: qcom: Add USB backend ASoC driver for Q6
Thread-Topic: [PATCH v3 08/28] ASoC: qcom: Add USB backend ASoC driver for Q6
Thread-Index: AQHZU0sI+aBRyUrT8kSLc+7asN1g0g==
Date:   Fri, 10 Mar 2023 12:22:52 +0000
Message-ID: <675ea322-4ad3-6f4d-47c8-b5706117c1bd@microchip.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-9-quic_wcheng@quicinc.com>
In-Reply-To: <20230308235751.495-9-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH7PR11MB6978:EE_
x-ms-office365-filtering-correlation-id: a92f7549-cd01-4655-6ed3-08db21622b62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdIbFgM7LCfpIcfRg35cr0SHDDLdqfmRfvBNtk23z5e9jtItAVKjhj4sss3YyjftHIeKbA43/ek1oDeHVPzamlaMNGNzLyieWlBKh8z8uqmYmL8xRv3EYqcfJGhOWXL2nFI0diAtEXYbh0uLH6e3DMPj2A4w43pleYXRT3tkMgG/oq7v3/LU4BAL0H6/lPoubrE2i4Kv0KiA9LNzEb3KaAnugFFVszq0ItYgsdzAtyg/gaEooRrdLn9pMS70a1GJ5y+f5ZFdvyb0ZedMnVQJA/Iz6+8FCDF+bCEcrQ1ZFZpYrqPAm2VSIkHmqv8Zcpww+yttwMD1Th4WduycUcyz4M2wzRMkAuHce8O++dFlYVEuCzydzyPeHwY0YitVpewoRjitNPvXtm0KzKt5+d/q/sRE98TDfknC6xj6hanP9eTulbPG15VXfzO/Pr8TtPEyp1ZNWkAsky0ma5se0FWac6TxgFDvcRbPSFmRmWvdDOApCBdIEwq76r5+NhvaymiKhK5WYEGAwESj0VSMDcYhHvRT4GYnggnWSdnYWzsXANqVyfv8MJ5wly2z5pPTlPf8bXGGi3+L6KJN5ZavUouEDIlm4XlkLPuZie3lVHzUh3Q6Fqqc670fvwKQOISX0uUn8eI5HiGYXt1WaI4Ao6IMg8fFSbiGedDSIAI2dp8w0o2XjqDT3/AelpWXEYFCE09nDJQFYH4IQEz7DoTg+XICKjasHGzjblQZpL87G49CZivsyhcZ5DG40B339wnGd/ligX9MtLac3lKidv8WtBSjjm8Yh7og2suVbASpzCjJss0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(31686004)(186003)(110136005)(54906003)(36756003)(38070700005)(38100700002)(86362001)(31696002)(26005)(122000001)(6506007)(6512007)(53546011)(83380400001)(478600001)(2616005)(316002)(7416002)(5660300002)(2906002)(6486002)(71200400001)(4326008)(921005)(64756008)(8936002)(41300700001)(91956017)(66476007)(66446008)(66556008)(76116006)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkFOODdMbmoxWS9ocDIvNkxNRVdlZ2tsT2lrWmRsa0gzWWIySm5XaDBjQThl?=
 =?utf-8?B?dVlQOWU5dFpuUjZ1YjFBTVE5N0htdU1KSWxtdk03TDlTMWtTTHdKWWlIQk9u?=
 =?utf-8?B?S0owcjdHQjJ3YytYQ3c4UzBwZTd1WjFCWUtBRE5DNDVZclVnUHB0dCtFME0r?=
 =?utf-8?B?Y0tmalJjcndwYWh3UisxZ3pndWEwcjNvOUpleXE2YU5WTllVYmEzOFRlU2p0?=
 =?utf-8?B?OUVvSlBIdTJMSWFWMm5VcmV5VGVyQU91NFhYWkd3VnV5d21xZURYMXcwZmtt?=
 =?utf-8?B?L2o3OEQ2TXpKWENiYytEZStzWWdabXdCN1FicGJlWVhoa1YrUmdjdDJVbTdW?=
 =?utf-8?B?OEU1Zm9yRDlYUVdrQmhST2VsUUVHb1J5akZCVlN3NnpBendNdEVRTXNtVDk3?=
 =?utf-8?B?MUJXUmN3TGZWdlZ1a0Flckp4b0RFRXBvR2JDN3lRSERHTTJsOXU4NkQ2Ky9C?=
 =?utf-8?B?WkxybTRoelVCWnZwdEF4dHRTODJKOVo2OHBpQWg4dTBvQ01hZGZ2VjdpU2RM?=
 =?utf-8?B?YUdBUkZXSkxtazdSVDRiT3I1NEZuTTBObWFRbzNMMlFMd1ZMaG5qeW9QUS9N?=
 =?utf-8?B?OUcrWnlBbUNtbFUzaGlCV0Q1bUVjQnR6OHZmT2xVV043K2xNWjk2cjlzN3BO?=
 =?utf-8?B?aVRpV21pZTV0Mk95MkJ3eTA0bDU5eldIQ3EzeHlpckJjV3NMUmg4bTR5c2dL?=
 =?utf-8?B?RnNJS0dLV01iUXVMU09lZGVkU1hVZlNuVFF2cFplUlhzN1ljcVkwaVBzNmF4?=
 =?utf-8?B?WG1zR2szaXhZQWZWQmFmeWVoMEN1UVVTVXpQc1Q4OFVlOC9sTmdhMjR0M0Fn?=
 =?utf-8?B?TlQ3VFg4Tm5wNU1meU40Uk5TOVg2aVFBclpDemEvU1NwaVVTQzV6bUFma21q?=
 =?utf-8?B?UFgrVWdQb3cxbGMveDA3dFV1YkhQWGpTanIvRHRuOC8wVFQ0Y1J1VW8yMkFZ?=
 =?utf-8?B?ckQvSFhkekxsWjhudnFiMnM2aTF6c01rdko3a1ZLTE5HRkwvU2JIeFFnME9u?=
 =?utf-8?B?TVpITklKMEpTTjlGSDBTeCs4ZUoxUGZmbFJvK2JpV0k0K3I3Q3VFTTBzSDVt?=
 =?utf-8?B?U3VBRWVrL2hMcVRHWVhmb0lWL2tOekI1MElnV04wd2VLOWJvR1YwVk9rSlh0?=
 =?utf-8?B?QzlPa0JqVWlmamdxVzFxS3lLaUd2R0NUKzljaHpwMjQ5MklBYmhuMW50OXc1?=
 =?utf-8?B?blBqMCtxdW1mYUpCb2hPek9zMVFHZDdJeXRNaExwbHFxdldIeEcwOXYyL1RP?=
 =?utf-8?B?RkN5V2UxeVlxQnFOcHVtbndYZGMvQ2hZNWpkTWMwT251K29FOFBncktlTktS?=
 =?utf-8?B?Y0ZFeTIzOGRCa2ZRKzlPZlBudHI1MVd5NXNpZmFBR3k4Mm5iVjd0NFU1c1li?=
 =?utf-8?B?QW9XaE9HbHN0U3drd25BZkd6aGxOMmZRbEcwL1BUTXdreUhzVXR4bjdRSFJ0?=
 =?utf-8?B?WXhkeXNKTlBwNWFPQnhQd014RlBvd0NpRVFhTUJibFJxWkR3STFWdlVoQTQv?=
 =?utf-8?B?NE9uMnRaNFYvOVBhSGVuV0M3R25BWWxkZWh5SXdJTFlSSmlxcHZQU2FzWVAy?=
 =?utf-8?B?cXFUWEl6b2c2L3h4cUFvbjlMRld1MXlrZkYyZkVtQUJSQTVYbFVEZ01QcGd1?=
 =?utf-8?B?T25XaUdUYi8vZW93Q3gxZjB6RUpzWW5pRFc4OFl6amU2TEVoQnBzU0pjR1Vi?=
 =?utf-8?B?N0R6WGRGQnNONVBhcW1GeEM4SXVaOHAzOU1EVkxaMlIwOTZCbnFEa0NxMm9v?=
 =?utf-8?B?YjdvQjRQSEVaTy9QNHdaOW80ODRPOFMzVnFhQWMrRGNMNmEvU1VqMjA2bFRm?=
 =?utf-8?B?RjdhdE9BdnZKc0JaekROMXIyVDRqOThGYzcyWXQ2ZnhIR09JUm1CQy8rSGZN?=
 =?utf-8?B?WFozTXYvQUZQQnk0M2V3Zk9EaUdQQ0RqdjVzeXFha1BDNU1wOE96THkyYzkx?=
 =?utf-8?B?VVN3dXF3TzJYeGlQT29MQzhpZ2pPekRvWjhaeUQyUVVBKzhzS2VHMTRJbTNr?=
 =?utf-8?B?ZnI2MVlXYVF0TVVBanVtVkgwZTRtWU5FVFB2RnloTGJWQlB4cWwwYWl5ejY3?=
 =?utf-8?B?YVpURmhwUE9SekdYVnYrN3NNQUJ3bzlpUEZhUlZqUlB0Z0duZkE1d1dnVkZF?=
 =?utf-8?B?ZmdTMlRzaEJ1ajJHNm5qTWM4Z1ZxV2hwMmN5b08zV2k5ZWZzRzF4TURiaGlV?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A061F493AD3D041A173B8426A5DE7D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92f7549-cd01-4655-6ed3-08db21622b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 12:22:52.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfrdfcI/FPxQjO9vc5tWCexR1YSYDv9eAqDvnEhSQqxrjtExbPYVqo9QSaO9kmVCEsrzO4IOQmyz4gZiLhdGxMhjGM0g5MXrNdBbpQkE6Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6978
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDMuMjAyMyAwMTo1NywgV2VzbGV5IENoZW5nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IENyZWF0ZSBhIFVTQiBCRSBjb21wb25lbnQgdGhh
dCB3aWxsIHJlZ2lzdGVyIGEgbmV3IFVTQiBwb3J0IHRvIHRoZSBBU29DIFVTQg0KPiBmcmFtZXdv
cmsuICBUaGlzIHdpbGwgaGFuZGxlIGRldGVybWluYXRpb24gb24gaWYgdGhlIHJlcXVlc3RlZCBh
dWRpbw0KPiBwcm9maWxlIGlzIHN1cHBvcnRlZCBieSB0aGUgVVNCIGRldmljZSBjdXJyZW50bHkg
c2VsZWN0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5n
QHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvc291bmQvcTZ1c2JvZmZsb2FkLmggIHwg
IDIwICsrKysNCj4gIHNvdW5kL3NvYy9xY29tL0tjb25maWcgICAgICAgIHwgICA0ICsNCj4gIHNv
dW5kL3NvYy9xY29tL3Fkc3A2L01ha2VmaWxlIHwgICAxICsNCj4gIHNvdW5kL3NvYy9xY29tL3Fk
c3A2L3E2dXNiLmMgIHwgMjA4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IDQgZmlsZXMgY2hhbmdlZCwgMjMzIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBpbmNsdWRlL3NvdW5kL3E2dXNib2ZmbG9hZC5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgc291
bmQvc29jL3Fjb20vcWRzcDYvcTZ1c2IuYw0KPiANCg0KWyAuLi4gXQ0KDQo+ICtzdGF0aWMgaW50
IHE2dXNiX2F1ZGlvX3BvcnRzX29mX3hsYXRlX2RhaV9uYW1lKHN0cnVjdCBzbmRfc29jX2NvbXBv
bmVudCAqY29tcG9uZW50LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3Qgc3RydWN0IG9mX3BoYW5kbGVfYXJncyAqYXJncywNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKipkYWlfbmFtZSkNCj4gK3sNCj4g
KyAgICAgICBpbnQgaWQgPSBhcmdzLT5hcmdzWzBdOw0KPiArICAgICAgIGludCByZXQgPSAtRUlO
VkFMOw0KPiArICAgICAgIGludCBpOw0KPiArDQo+ICsgICAgICAgZm9yIChpID0gMDsgaSAgPCBB
UlJBWV9TSVpFKHE2dXNiX2JlX2RhaXMpOyBpKyspIHsNCg0KT25lIGV4dHJhIHNwYWNlIGhlcmUg
ICBeDQoNClsgLi4uIF0NCg==
