Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64C6B9879
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCNPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCNPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:01:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F669009F;
        Tue, 14 Mar 2023 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678806120; x=1710342120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2VemP/wU1KePQDHuzIhNJqrDtPwrPh3VVX8fNn4P5QQ=;
  b=ULX94V/kc7J/Z94CjtdpfWkDka9S0j3QeIvdhNRP0+woE9PFhQ2KZ34D
   X1iNlHnXR5odv8mUIuNF1wTKYGfZwOJx+Ro7C5w+E6unuovb2hGqA5pMr
   w9yLAWl5MVcb/o0ss6lhdac45V9nPJBWspQAj/k/JIO2r2G8xHwL8W5TJ
   heGOosDuhPNYg/pAI41+9qSLmcCdLxf6qRBFv+1482rgCrWyHkQyDieTm
   hK8v8X/jiQgliJVDQtJZ7AomlCvxMYnRZ1nIuG9iZyLHAA7iKSN/a3kZv
   loWp/Dxx+m8K/TjDpeen+D23ktbL8RQEVo0xDUQUOAWEEWhvuyKI787W3
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,260,1673938800"; 
   d="scan'208";a="205068953"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Mar 2023 08:01:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 08:01:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 14 Mar 2023 08:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta+HIbgWLzBV0FZX01fKccmtxymCCbgFIkn007Vb6Z94qBw5LmrV6/l7fx86MHpxgmYJYUvFrNeHo+6jrWGZYVVqsstlIugQm1MlRBehsoeEjyPIngViuHxgQNb/+4WMQCh3ve8XgchTUDYAU/1cCuwKppFQvC9C35bJJsbksI578yE8QAXP307VZWxojCxk60cTTBf7fK+8PcvYJWvWM5yicZQHVETdQewGXmFtPRGMnUtLlBNKlmataeH1d7CfYaixDRPYDts8C8XyDIPdsxF2WPEcuHjpeGJbQXLXAKbuDVVLSsQwEvAbyaDc3Fvb9s0SdJdLVG59slDX7GeiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VemP/wU1KePQDHuzIhNJqrDtPwrPh3VVX8fNn4P5QQ=;
 b=denZOfMN+nJUlvyk99zRg2wTyBpGe/YEidWsqaE1X5i/iL93rRlw7gpVn/6L8oIdKKpwmJvT6CojDZ00SvySvlUidRp4AMSJNVcVBiPe2nBaiQh0VYRW5g1hD0NSWV+ASUVtRLAEU+Uuz45eb3H9xJj2pJGV7kfqXlFM6nsZHPVaISQ0stfcKiY+ma1GTpO+VpX0/N3IqAvFuQd4ph6eNaZFEWSdApHlJdbIu03IjeBVOHScqpjnzEXL+vSXWHey9DZYINzeLv7O6JdsjcSdiykzkVCebjc36NSkjKCfmybNc3Ng6bIATs0jjRjdgxN25oVXJJR243/tuUyYu0AATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VemP/wU1KePQDHuzIhNJqrDtPwrPh3VVX8fNn4P5QQ=;
 b=qURQ+JdOsT9C8NP5AZKKWeBNopHW/6qbcxqZUDpCgjTsv09ZhW8wkeHETNhlEVaWAeYkK9Hnk8eesvtGtVtQWWzCF/GOf5qm++xswhXcuQ3/NLxgBkRBLbXjGlusYgf30qgCBBSvfpaQaXVT1iEWB3SEXaihwL9vQ2dR6yRcC/k=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 15:01:56 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 15:01:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <yang.lee@linux.alibaba.com>, <mchehab@kernel.org>
CC:     <eugen.hristev@collabora.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
        <linux-media@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] media: atmel: atmel-isc: Use
 devm_platform_ioremap_resource()
Thread-Topic: [PATCH -next] media: atmel: atmel-isc: Use
 devm_platform_ioremap_resource()
Thread-Index: AQHZVoXrR2ZNdVebOk63w8E2SYJsMw==
Date:   Tue, 14 Mar 2023 15:01:56 +0000
Message-ID: <5fbd369d-03f0-8d48-d944-1e1953454dde@microchip.com>
References: <20230314055826.103682-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230314055826.103682-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM4PR11MB8092:EE_
x-ms-office365-filtering-correlation-id: 335e1661-440a-41c9-5fa1-08db249d0dbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYE32PY9X4zjd5AVWk2woHWtshubPg7c3rKK3DtsOR1Pxl6cJBBV4maEpbxyX0i5rH/U3CRtBb0nY3d66WLurPLEQDXFdIgfFWH3/9LAMSXe+dhFNgIkgLgk13z9RLsCqqBwIAhT/THE5Am+8qJqXsvWabA59feXQwq0gFlJnOZ/a1wyci5349CIZ/wspn307LBkHdcvwnTxARK/b5PZH0aybz9he26HdQolHxFlV2N5vak+wekM/1X+DMHgj4ZOKd45Y+K2m249BIVqaII3TA17WdBm72Mn4TLlbIwbyrFG72wGnEAs7ZvpYKLWq0Fq9u9+ItbhrAw7djEmL3HoC0R8ly0ISVs0HirJjq+QNG17UUH+8Oz7OeOaNsj4ivQynDERRBotrySGY8MFMPbRQrjukJhzm/jhuL6C0lyu6OwEimAIewh1GHCtJqZFGOihzZj+jr2V+Rl/mSe5PbwNjaLdMtndxFd7YziudvfnKmf24+Pb9jAAAaYBI4LzFxl2Mm9sLfAirUv9BWHpnHqHGP0OX1hDuTRU/KxuLdwu31dslREiek3rdypCsup6onmgaSmxwlTRtuCh0oPCbd0zh18t8hkrjZtZTlL2tFVV70Lps68QpL82gUFdwyuG3Uckg6mpwUwUoxFUuJ8E20JErm2CVykv2SFqZNYmtO4w+4/1S6urzM3gG0gISGlcUjCFHEksuPFANF7wDvrb2Bfq0oDFHtePGWD0x16RIWuURUvgrPSXDmrnO6vpteG20LGF9WwA3uS3BsKJRu6NHRStgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199018)(86362001)(31696002)(38070700005)(36756003)(38100700002)(122000001)(2906002)(41300700001)(5660300002)(8936002)(4326008)(2616005)(6512007)(6506007)(53546011)(186003)(26005)(83380400001)(54906003)(316002)(110136005)(66556008)(66476007)(64756008)(8676002)(91956017)(66446008)(66946007)(6486002)(71200400001)(478600001)(76116006)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFZlTjVhUXVUQ1pSRVpydi8vaWRycUhqRUNUS2xVOTlRbjZkOFZ0Y2gyd0FQ?=
 =?utf-8?B?WGpjZU9EMkRaUnRGcmY5eHBrVnVsN2FUN2hsTGV3bU83VFMwQ09tY0tORTU4?=
 =?utf-8?B?NTVRamw0TVZUelYzZ2pmNGk2aWdySkNwNWNNOVVud3d1Y2dYWFNYazdqYlU5?=
 =?utf-8?B?U295bXd6ZlJKWmVWSDhWb0IvSEg1MmdLbzE1NTBOZWs0RnpNaXdVRnJOWTFH?=
 =?utf-8?B?cVBmV3JuUVFoaGFrUEQ2eHJzVGZ0TlhERUZPZDN0UHZpeUY3SDhoNkJnRDlw?=
 =?utf-8?B?VzJsbUw0UWhSM1NqbHhidXlxVEdTMXhHdmZIT05oNmdIQ1ZqSDh5TGNFeWFs?=
 =?utf-8?B?andoVU85aGpHdnpzQVF5TWl0RFlVS3I5T0xFM3c0THFEZy9RbzRzWW8zMkVX?=
 =?utf-8?B?QkpkZVBQbHgrZlpZcDg0ZEVON2RIc0Exd2EyVGtYeDZGdEIrWE1sSXoxR3V2?=
 =?utf-8?B?cFJOUXExeGlPeGtoZElYTEo3YmVsVHlqemRMOWdwTzFyVHUzMnZieG43MjUr?=
 =?utf-8?B?OEIzVjlyZENGbGpuc1hUZTBIQVRxUk1QN2M4ZWx3ejdtdUdYL1J6dm5VaGRo?=
 =?utf-8?B?Z0d5cWJHUjc0N2xJem5sU3dxS0doNzNjRmFYWVkyM0FUT3FoWmN5VVpKQWF5?=
 =?utf-8?B?a0dvSEkvREJBeUQ3djI1OUpZWVgyaVBNMnF5cTN0bW9rbGhteUh0ZTVtVFhM?=
 =?utf-8?B?MlM4MHdTcDBJQnI1MmV4ZkhVcWtvbEhDdDR5a1kwQzNaSlNJZTJod0lValdK?=
 =?utf-8?B?ZmlIU05LbU5RYjBOVEdGaUtmeVN0MWxpcjF1NnBjOUwreHhLR2lkUzJaQzVI?=
 =?utf-8?B?bGJjL3RxUi9Hd25IQlBaQjVPS2pOelBJZ3FPSCtydEFOVEJXT3ZxRnUwelNz?=
 =?utf-8?B?N2J2MGJjMzg3MDdGRFZGZXJadkVwUUxXR0IzcWQzWmRCL05RQ2tzcUQraE92?=
 =?utf-8?B?Vi9kbEQyTUxuZjMrLytNbTJOQTBzZ25XN2pZUHVTZnE5Z2JxWmt3cFBzMmFl?=
 =?utf-8?B?N0dMSlgzQ0xYcVpBSzhPRHJnSmRxWWRvRnpwdVRFZ2prZ3pYN1Q2WXFmRDM5?=
 =?utf-8?B?MG10SXNyRzZhZEQ1OWdsZXBmR2l0M2lOd0FkTGVWOE5aUEYxSGgrMXphMWdo?=
 =?utf-8?B?VVRlbktkU3hqaTNDOVFOK1dMVTFsTXN5NGcrNWJLME9nYjlHOEo3SlY4ZExm?=
 =?utf-8?B?aVBneVMrQmxRZHhpYlZVN3dWQnN2N3FDVHJZUW91ejFKZ09KTVlOMi95WUhz?=
 =?utf-8?B?dHp0SGZHTlpHN05MOFJCWXFzcTRXOHpZRjFYTUFUWVE2dmZqaFBETTJSNDZj?=
 =?utf-8?B?a2NkM254VW1nSm43b04ramhrY2xYQXJ6alVxUjViUDVnMnBiWWVjVi9YeDA0?=
 =?utf-8?B?UXY2bFJyQkcyTzdKSXdoZ2F0WkNOZ1VHblM2TXA1eWhWNzNuV0R3czF0WXlV?=
 =?utf-8?B?VXR6TUg3Nmt4anNteWgwVEpMeGRheHFmanJRNkJpQ1ZZSlVXWlhOK1YzZzh3?=
 =?utf-8?B?QVBkN0ZwQUVQQXF5QzdZckRzcTlVS095aU5wMmE3enduWDdvaHVDVENwdC9y?=
 =?utf-8?B?OG9YalgvWTJIYWcraXphSjlSbmt4Z2hKUDhwOFVTbE1BMXNQTXlPampiR1ZO?=
 =?utf-8?B?bWNlam93eDhDV2hlUE50LzlFUSt1OGNrSENTZ09qRHV3L3d5QUtqVEkrSkcx?=
 =?utf-8?B?K3ZoSDMvMnI1T1Z2ZGVzMEtTZUtLbW03MnBMcWlKL0pvRHZPTUpYMWk0OUdO?=
 =?utf-8?B?UjAvVmpxWmk3WUR1UUZVQkJRSHZmYk1KbGFpbWVRa2ZTb2EvYjUzcjlkOHo3?=
 =?utf-8?B?eHlrY0d2NEUzU01Wa1FWbitybklPZWtOemx4ZWZReWpXQk81VUt0YXdOKzRV?=
 =?utf-8?B?ak9SekhBZmxEN1hrWWN5eDZVd2Nwc1JtVjhXaHNqaWxaUzVoc2tWYTlXbFBX?=
 =?utf-8?B?WnR1bjlGWkYzSmgrMHFhMytuTEFjMnpmdzVJWmpLalYzUUg2d1hud2VGcldH?=
 =?utf-8?B?dEhxOTZjaHo2UE5BNUttWGxDZnoxNmhqZzd4Q29MSC9Vd3h6Ymk1Zk9QUDZ5?=
 =?utf-8?B?cGtsbVFvOEJkSC9PTGd5WG53bjd6YWhnZHdiZG9VeVJjbmhiUEkyWjZYdmIz?=
 =?utf-8?B?Umk1SXpCV3VQN1IrcUw4V2NUSWx0TXJiQWo5L3YzZllXRlFRZzQxL2ZFRW02?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6795A0A45BD2AD4A9EC7D845F42A6067@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335e1661-440a-41c9-5fa1-08db249d0dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 15:01:56.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhuPubTxtE0s+VTHhhBOaC6XNTbR5hVaALE9ri8aJvjaYQosgXERm3+fO1BZAnaFImkQWJGORhUPvFEvNfu22L/TiElIe29+1s8OL1FzZlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMDMuMjAyMyAwNzo1OCwgWWFuZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBBY2NvcmRpbmcgdG8gY29tbWl0IDc5NDVmOTI5ZjFhNyAo
ImRyaXZlcnM6IHByb3ZpZGUNCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkiKSwg
Y29udmVydCBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSwNCj4gZGV2bV9pb3JlbWFwX3Jlc291cmNl
KCkgdG8gYSBzaW5nbGUgY2FsbCB0byBVc2UNCg0Kcy9Vc2UvdXNlDQoNCndpdGggdGhpczoNCg0K
UmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KDQo+IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpLCBhcyB0aGlzIGlzIGV4YWN0
bHkgd2hhdCB0aGlzIGZ1bmN0aW9uDQo+IGRvZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5n
IExpIDx5YW5nLmxlZUBsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3N0YWdp
bmcvbWVkaWEvZGVwcmVjYXRlZC9hdG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jIHwgNCArLS0tDQo+
ICBkcml2ZXJzL3N0YWdpbmcvbWVkaWEvZGVwcmVjYXRlZC9hdG1lbC9hdG1lbC1zYW1hN2c1LWlz
Yy5jIHwgNCArLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvZGVwcmVj
YXRlZC9hdG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jIGIvZHJpdmVycy9zdGFnaW5nL21lZGlhL2Rl
cHJlY2F0ZWQvYXRtZWwvYXRtZWwtc2FtYTVkMi1pc2MuYw0KPiBpbmRleCBiYTA2MTRmOTgxYTIu
LmVlYmIzMzZlZmNlNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL21lZGlhL2RlcHJl
Y2F0ZWQvYXRtZWwvYXRtZWwtc2FtYTVkMi1pc2MuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcv
bWVkaWEvZGVwcmVjYXRlZC9hdG1lbC9hdG1lbC1zYW1hNWQyLWlzYy5jDQo+IEBAIC0zODksNyAr
Mzg5LDYgQEAgc3RhdGljIGludCBhdG1lbF9pc2NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2
Ow0KPiAgICAgICAgIHN0cnVjdCBpc2NfZGV2aWNlICppc2M7DQo+IC0gICAgICAgc3RydWN0IHJl
c291cmNlICpyZXM7DQo+ICAgICAgICAgdm9pZCBfX2lvbWVtICppb19iYXNlOw0KPiAgICAgICAg
IHN0cnVjdCBpc2Nfc3ViZGV2X2VudGl0eSAqc3ViZGV2X2VudGl0eTsNCj4gICAgICAgICBpbnQg
aXJxOw0KPiBAQCAtNDAzLDggKzQwMiw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfaXNjX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgcGxhdGZvcm1fc2V0X2RydmRh
dGEocGRldiwgaXNjKTsNCj4gICAgICAgICBpc2MtPmRldiA9IGRldjsNCj4gDQo+IC0gICAgICAg
cmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4g
LSAgICAgICBpb19iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gKyAg
ICAgICBpb19iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0K
PiAgICAgICAgIGlmIChJU19FUlIoaW9fYmFzZSkpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
UFRSX0VSUihpb19iYXNlKTsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvbWVk
aWEvZGVwcmVjYXRlZC9hdG1lbC9hdG1lbC1zYW1hN2c1LWlzYy5jIGIvZHJpdmVycy9zdGFnaW5n
L21lZGlhL2RlcHJlY2F0ZWQvYXRtZWwvYXRtZWwtc2FtYTdnNS1pc2MuYw0KPiBpbmRleCAwMWFi
YWJkZmNiZDkuLmJlZWQ0MGZlM2Y5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL21l
ZGlhL2RlcHJlY2F0ZWQvYXRtZWwvYXRtZWwtc2FtYTdnNS1pc2MuYw0KPiArKysgYi9kcml2ZXJz
L3N0YWdpbmcvbWVkaWEvZGVwcmVjYXRlZC9hdG1lbC9hdG1lbC1zYW1hN2c1LWlzYy5jDQo+IEBA
IC0zNzgsNyArMzc4LDYgQEAgc3RhdGljIGludCBtaWNyb2NoaXBfeGlzY19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRl
diA9ICZwZGV2LT5kZXY7DQo+ICAgICAgICAgc3RydWN0IGlzY19kZXZpY2UgKmlzYzsNCj4gLSAg
ICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gICAgICAgICB2b2lkIF9faW9tZW0gKmlvX2Jh
c2U7DQo+ICAgICAgICAgc3RydWN0IGlzY19zdWJkZXZfZW50aXR5ICpzdWJkZXZfZW50aXR5Ow0K
PiAgICAgICAgIGludCBpcnE7DQo+IEBAIC0zOTIsOCArMzkxLDcgQEAgc3RhdGljIGludCBtaWNy
b2NoaXBfeGlzY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAg
IHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGlzYyk7DQo+ICAgICAgICAgaXNjLT5kZXYgPSBk
ZXY7DQo+IA0KPiAtICAgICAgIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JF
U09VUkNFX01FTSwgMCk7DQo+IC0gICAgICAgaW9fYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJj
ZShkZXYsIHJlcyk7DQo+ICsgICAgICAgaW9fYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9y
ZXNvdXJjZShwZGV2LCAwKTsNCj4gICAgICAgICBpZiAoSVNfRVJSKGlvX2Jhc2UpKQ0KPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaW9fYmFzZSk7DQo+IA0KPiAtLQ0KPiAyLjIwLjEu
Ny5nMTUzMTQ0Yw0KPiANCg0K
