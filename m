Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A935168ECE5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjBHKb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjBHKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:31:11 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F346D4E;
        Wed,  8 Feb 2023 02:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675852241; x=1707388241;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=RmfMhSfWef9VqoxwGCub8/5YJ47EgWlcvP1luPlcqc8=;
  b=tqks2ntZJ13UHGOZHgcFr/cpRp0TW7U2V5OtT4q1DC6L3kJzjsFRbBPU
   mRS8B505hN0E1IDRJWViNtaGCeuNK3hUVyiVYY7Uuy58+XawjgwfmgiZk
   DBHHi1ximUUgn6FyQS+RMX03mFslGS6BX49waQW5770VUq4wxzX0O5Sz0
   k2//Jl901OYX1Yxh3e6u9rHjnteEHKVpeH9Hdt6xqEMq1KrhDAuImoQvK
   lyKHGm8diC64tyFg4FAGxPJ9yq53RlSiyWq0ka3nVaG+17Sz0W379kGNf
   PkPFWQ8+waXqgdr2YlzzyyoncveKYat/r9TUdo/2GYuVCtsaK0GMJ2KeB
   g==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669100400"; 
   d="scan'208";a="199477787"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2023 03:30:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 03:30:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 8 Feb 2023 03:30:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw/CKMB3Fai1J4hbG39myPYYDYend7uU9i3KUHF1hUtet/vXc1J8B9ZqQcs1p5FXLCSJQdO3TgLGB/2at9nmZ3R3F3g03X1u/3qRVC49SCrjHITpK7I5TBdxFA7Ou0nSrDGuDI0GIJWuiSMvsAcyMbSzwmv/TIPByChfhykvIkmuZbrnhLaC4HvVtKuSxwAxiyG1YiEJpmZTBuGC6Cf+b7lV1yfEaU8wbp/yJkQmmiRtTaAaNL95e/SaovIy7nvE/BYfnD3juSIlyQDe4wyJw6sQVVHKgbl7Rub1CtLZBScwBnaZk80KFP5g44vxrgYaQpc/suMvsqxJpmv0vQdr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmfMhSfWef9VqoxwGCub8/5YJ47EgWlcvP1luPlcqc8=;
 b=OsomkJ3gDCWRhEGXR7HmVOeiTKnTLSVDmks+4MtkaXMwpxqvE6cV3C5X1li2FisScVvUBbH+k0KCYCvLN0Yo64cn3UJNXKPsFFclU/LyIsqajKlzpnviM+ypfQgoXdyQPYcehTAiYaGZ1flPlFybxEIYdIxTLUSDZhsigS9JEM+ioBOkmerTZOEehO9Iu87/flWiKRqvYcn5OCd/BZvcUpgyYorowBcvyLP49/MpKp+g9iWX9zhj+KioHvfClQAERPj856WCidv3HmVToKJxo3yCBz9Emb+7MpJLVlZbP/dfevWGZorTkAS2uVa8cmacRCXvoHeQP9Yg8/jWp4XemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmfMhSfWef9VqoxwGCub8/5YJ47EgWlcvP1luPlcqc8=;
 b=NH1lCLNnHy5AZvA1YT/bAPGidLLQgMYY2fwas6LzKIAuBAZBAIqP79hcruDvMotUWlQ0YTfaPyl9SrIWlPqHEZ/Lslts5vrLbf3pKg4SJlCmESFgyeQnY3Dk8P2hMiprIBnuA95+V3CXiQuuoqn1zPIJtlLAw1xB6yzq/6QzbnQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Wed, 8 Feb
 2023 10:30:38 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 10:30:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Balakrishnan.S@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v6 0/8] Add support for sam9x60 curiosity board
Thread-Topic: [PATCH v6 0/8] Add support for sam9x60 curiosity board
Thread-Index: AQHZO6hiD+FURHMo00KlkM31s+Zz1Q==
Date:   Wed, 8 Feb 2023 10:30:37 +0000
Message-ID: <5e8d8b30-1919-7f39-f8b1-52d3452edf43@microchip.com>
References: <20230207110651.197268-1-durai.manickamkr@microchip.com>
In-Reply-To: <20230207110651.197268-1-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA0PR11MB4751:EE_
x-ms-office365-filtering-correlation-id: a4ee6cb4-fd8d-4b6b-3c04-08db09bf84dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKR4qUCVauCCwBqPIsa9X6mvlZWyA1cuROsGDd/BCrwVXhRQpuOLcfudW4PAuTCgktX1G0ZsWH0CN5NWzKlDUVhFNCapm08aJ/Jek+vMdH+dTMtCOBVpzUq+EVL/DgYUV42eOq0QLp8K7X2TSQGlUp7hwirL+bg6RsEgUD9cuRdt1RMezMJSF2x4DmEKglfUl7QmSriDGxNKwbrmUaHipb4ynJN0T1Xh3Cka515YFNSrGtLz+LUJyZEY2HMPduZ7+zU03ACbOJ+JZOmMBmEFLtvO3zZW/jJ3ss3KR3JbIC3/ugKf5SHVjl+wNy/EW8lXN7e3j0DkHlx/Cva9Ti7dgbeokAI+IPFoD4z+rUlA0ps2xouTHkwfOUsDyuHiov6AzHd2eJ9/uONnWzcXIshyvHxkHS9mc0RH+MJQCsm9Yjn87gmBkpMxrM9xpYqiVXQsSsITRIhaRn8Id30VJeNaaI9vyvX4EifSqKCWdHxAHSGNjikzeWEOeMXFRih5RmOX7X0CV2FRLTPD92IdFz02Yst/Ukp7fPphT5d8/nDvq3QIRrg2lPJBLyqDnfa/RtJUge3nknov+sU1vpbryYFrBhYki8yvuOYKTfdy9jNx9KIDUJZ+k1w3ESXnSwMGqSrT5K7388FFucc/RSNgb62A4Es7sebE4blN4eu+T0bzHcwhuYqWb/nsDA/B9SuMSfNYqyTHRZL4JUjq3J2l3X3z5xH5qiFt8iAt8ndfm7putFHaYQfuLVf6AMyGHANHOodqaKGfYGLoAoqft9C4RU4P7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199018)(91956017)(66476007)(66946007)(76116006)(8676002)(38100700002)(316002)(31696002)(122000001)(66556008)(83380400001)(110136005)(6636002)(86362001)(5660300002)(7416002)(6486002)(478600001)(31686004)(6506007)(53546011)(38070700005)(921005)(26005)(6512007)(186003)(36756003)(2906002)(71200400001)(64756008)(66446008)(41300700001)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZhKytnTEZCK29Wc2E4dDFzcEtteXF6UWlRKzV6NDdxVGxYQVFJcWU0OVVh?=
 =?utf-8?B?cUYzVmxZUEQ1SWJ6dklsMHladXFlM3g5bDRtWFdyaUVZZDE4ZFR0cm1XbUs4?=
 =?utf-8?B?WmRhOEIxeUNqNitWU2Nsb3pMMldJR2lCZi9iNTRORTlFQTgwUnlnUHFBVTVx?=
 =?utf-8?B?a3RqMzNoRjR5NTNYZjJLbUFxektWV0tvZFNCSE91OGtXQ3YwVHdlcW5wa2o1?=
 =?utf-8?B?T09BSHR2L3RPU2NtczBpelREVnJYS1FDblVhMzlETmNzS3Bnc3J6TDd0UXpu?=
 =?utf-8?B?a095eXVxdDhkc2ZZMmsxK1FqRFdkVHF3Z1BwR1lZRG54VW1UMzdaWkFYUjVr?=
 =?utf-8?B?ZmRtNjBaU0k3Qms0V09xMURsa1MrRGMveGtUSVNMc2dUM1ZUMWk2aHpMT1Nu?=
 =?utf-8?B?Ti80NW9mcTFBS3pZdDYvOSs3M3ROdjJrVSs3aU9YZ1JOb0J3VHlBVXBkTDJR?=
 =?utf-8?B?dmRhNi9SaUpJOElRVmhPNXZuZGtVZXlFNzNFZzVUYTJlNGg3ZzhuY0lnRmNo?=
 =?utf-8?B?blB5Wk1lZ01zZjVBSSswUDNLdm92MGtGNGpVeTU3QnJxOWdFYmJRSUhMeXNN?=
 =?utf-8?B?NDJtakIrNW1YQzdlekFzSWlmOGQ3VDF0ajFCcEVCSFVxVVFKcC9TeHRqaFlw?=
 =?utf-8?B?OFM5Q2FDREpMM1dwOHZRYmdlWXM1OERJT3RXWjAvVHRPbDgzSUdUU2RhQmV4?=
 =?utf-8?B?QWo5dDBCSXBxWm1PY0g5c3VUUkRsZGJaQW9GQUNYcUZQRDgzMEJFN29FNFZY?=
 =?utf-8?B?NndGTGxZbFRvdjYxWmluT2Z0dng5OXVSVlFVVE5zQXBMcGNxT0tXSG9TUzlW?=
 =?utf-8?B?NW1kQVpWMWJXSDFKSFkwemFNY3hFSTIxRmRuOXI4MEMxZ1hINjh1UVJRN2hy?=
 =?utf-8?B?NlNQcTBad1ZHalBNVnRWeUt2bkFIQSt1bytQSkVvNUozZlRiNmFDaWlDK1hE?=
 =?utf-8?B?aG5sQ05NSFlwbVpQYnQzY2l4OXU4Vk16ZCtoVy96dmRQRjZGdDg2eHRsN1B1?=
 =?utf-8?B?L3BHWks5UGRPYzU3YUk4WE9seWlLK3g4cW1NdjZvZnFBN2hsa1N3MmNib1NL?=
 =?utf-8?B?SWthd2ovb2dLL3hzT0ZhZ0tqSHVyWDVPb3BFQ0kvSERoWFp5TjJuYmVrN1Er?=
 =?utf-8?B?bVk3UEhpTWhWWk05cHFoZ0VkMVl4dzVpVHJVa0tUSWxEemZLRE8rTFlIemV5?=
 =?utf-8?B?cExiSWp2Ykl6U2h4R2szbUFXOWtreU5MK3E2Y2k4anZhNE9aMEtQalIwSkhm?=
 =?utf-8?B?TnBJRjFYVjhHeituQ0hzQklNWkIwRmNUM3oydHVrbmpjbVljNjRRcVE2RnVy?=
 =?utf-8?B?Ri95QzdZdDZCVXV0Y25Yc0tmZDBHYUVlVXNJNm1vK0ZTeC8vOGp3SUJzK2hO?=
 =?utf-8?B?ZnNPQjFjRDV2cHR0cW5zaXNld1hDbE90RjhDaklaU3c4OHpYb01QbVhlMnhk?=
 =?utf-8?B?QnRleW1lb29LTFNTQXF1UUpuZjdaMkN0Q1ExY1JQNGR1OXJQL0N1UzM3YVVk?=
 =?utf-8?B?Y0lidTdUMDZUYkszSzcybGJxNHdpK1owSVBBaWE3VmppbGtnSVRiSVVvZ2lD?=
 =?utf-8?B?NHVzLzVGK2UyK2IxbU81SlVXTWgyQ2ZsejliZGxHZGQwalRudk12SmJ3RTZK?=
 =?utf-8?B?VWppYkdhYVlGK2JqM2FaSzVGa0IzVldvMkpQS2E0VE1QcDk0bU11bnBNVnlL?=
 =?utf-8?B?VGROL2Fjc29EbkZqY0VRZTFqdVlPeGZhTE5abEdFcTkwNkg2RGErNDlhRUZn?=
 =?utf-8?B?aFNVR0h6d1hPTlhQMkhHbnF3M3JKUHRkZWwyNDRGaE5PUndGeGlNMHNHM01j?=
 =?utf-8?B?NlIrOENxVnZ3YWQrSVhvanpUY3RqTUhlbXFFWVVzMTRKdHM0bzJ6L0xNa3ZX?=
 =?utf-8?B?Zzg4dk8yRWs1NjBNeVNLNThuUWhzU2NuNEY3VG8xUXVKQU4xd2R3RmNOdEsr?=
 =?utf-8?B?aFRFbXkwVGc3Sm9EaTBQSUk1Y09PSGYwQ2RmQUVPb0l0ekNCelJvNU9RdkNX?=
 =?utf-8?B?NGZySmthd0N5YXF3L1JHV21sTjRrSU1td2xGcWJSLzg4ZmZKQkxhZjVZT2lE?=
 =?utf-8?B?UFBxcktkV1Q2TFpjQUtQSXh0aEcrZmwzL2VYWkl3Qms0TEhkeTNvM21tNjZk?=
 =?utf-8?B?cGFoT3B1ZWFVRUM2NW9Uc0hRK2d2VFcyMEpSellDdkk0MG1GcTdqS2NZR1RN?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39DDE52BB07DEE489EB77DF442FF1441@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ee6cb4-fd8d-4b6b-3c04-08db09bf84dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 10:30:37.5083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WEesD1SDRczl4JXBgchuNJODPK3Y2TIpWBrnwkijy1cR8P8m/u96b3Q6JZ28BkTbWbp+qaOPc7i+kP3T/vBsLRrQfnfumSy2qLNdFugd5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDIuMjAyMyAxMzowNiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IFRoaXMgc2Vy
aWVzIG9mIHBhdGNoZXMgaXMgbWVhbnQgdG8gYWRkcmVzcyB0aGUgZm9sbG93aW5nOg0KPiAtIE1v
dmluZyBvZiBmbGV4Y29tIGRlZmluaXRpb25zIGZyb20gYm9hcmQgZmlsZSB0byBTb0MgZmlsZSBh
bmQNCj4gICAgc29tZSBtaW5vciBjaGFuZ2VzIHRvIGl0cyBwcm9wZXJ0aWVzLg0KPiAtIEFkZCBz
dXBwb3J0IGZvciB0aGUgbmV3IHNhbTl4NjAgY3VyaW9zaXR5IGJvYXJkIGJhc2VkIG9uIHRoZQ0K
PiAgICBleGlzdGluZyBzYW05eDYwIFNvQy4NCj4gDQoNClsgLi4uIF0NCg0KPiANCj4gRHVyYWkg
TWFuaWNrYW0gS1IgKDMpOg0KPiAgIEFSTTogZHRzOiBhdDkxOiBzYW05eDYwOiBmaXggc3BpNCBu
b2RlDQo+ICAgZHQtYmluZGluZ3M6IGFybTogYXQ5MTogQWRkIGluZm8gb24gc2FtOXg2MCBjdXJp
b3NpdHkNCj4gICBBUk06IGR0czogYXQ5MTogc2FtOXg2MF9jdXJpb3NpdHk6IEFkZCBkZXZpY2Ug
dHJlZSBmb3Igc2FtOXg2MA0KPiAgICAgY3VyaW9zaXR5IGJvYXJkDQo+IA0KPiBNYW5pa2FuZGFu
IE11cmFsaWRoYXJhbiAoNSk6DQo+ICAgQVJNOiBkdHM6IGF0OTE6IHNhbTl4NjA6IEZpeCB0aGUg
bGFiZWwgbnVtYmVyaW5nIGZvciB0aGUgZmxleGNvbQ0KPiAgICAgZnVuY3Rpb25zDQo+ICAgQVJN
OiBkdHM6IGF0OTE6IHNhbTl4NjA6IG1vdmUgZmxleGNvbSBkZWZpbml0aW9ucw0KPiAgIEFSTTog
ZHRzOiBhdDkxOiBzYW05eDYwOiBTcGVjaWZ5IHRoZSBGSUZPIHNpemUgZm9yIHRoZSBGbGV4Y29t
IFVBUlQNCj4gICBBUk06IGR0czogYXQ5MTogc2FtOXg2MDogQWRkIERNQSBiaW5kaW5ncyBmb3Ig
dGhlIGZsZXhjb20gbm9kZXMNCj4gICBBUk06IGR0czogYXQ5MTogc2FtOXg2MDogQWRkIG1pc3Np
bmcgZmxleGNvbSBkZWZpbml0aW9ucw0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9hdG1lbC1hdDkxLnlhbWwgICB8ICAgNiArLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEt
c2FtOXg2MF9jdXJpb3NpdHkuZHRzICB8IDUwMyArKysrKysrKysrKysrKw0KPiAgYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzICAgICAgICAgIHwgIDUwICstDQo+ICBhcmNoL2Fy
bS9ib290L2R0cy9zYW05eDYwLmR0c2kgICAgICAgICAgICAgICAgfCA2MjIgKysrKysrKysrKysr
KysrKysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDExNDAgaW5zZXJ0aW9ucygrKSwgNDIgZGVsZXRp
b25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05
eDYwX2N1cmlvc2l0eS5kdHMNCj4gDQoNCkFwcGxpZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo=
