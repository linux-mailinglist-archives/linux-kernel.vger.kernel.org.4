Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596A602576
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJRHTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJRHTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:19:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D84A926C;
        Tue, 18 Oct 2022 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666077555; x=1697613555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Gd+0oqMAWFwq6bCWMssGU4bQYeSKs8zhp6cfNsFrKU=;
  b=VQblxVpvQYBbCBYTf6CXySVnyW2Ybp0xONt49k3pjt1ZkPrZdJKslF7U
   y+AlvGPyjnWDiIBBwnihiqp51dnbLQsUOmWl0sDi2h7c+bG1HX9JHogk5
   mSYUl1Y6zlHV0jrSMlEPLx0Ql8G8fD6C1aYS0TwJQA3s/U3BZmwvatp7I
   V9WaElLvfA0GE4MiYKdmzN0so3G8qSJwL/xS7lL+/xygQwwGFsJTGr85b
   FpBW0Xo/nuAGLnj2YYqBlcezk7bU/7sqiOK/So+wQNdft/9VnsGry/bmg
   pwUlNsYcDzsrh/seZXiXg0HNRbtPaOiMAH5P/x1x4sOMdSTOwp2zbD4Gl
   w==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="179290668"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2022 00:19:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 18 Oct 2022 00:19:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 18 Oct 2022 00:19:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwQvcbeMyYhpdhbE8gSeyMV0GpiUmuzelitfiXjE/n6FCw1sbqeeFsrrTefSUR7xLMD0l5Q38TUJGT0AIab1E9fMIHNk0Smn4JetAVEYlXYIAdLpQ0hAyCCj9C8rc2vytmf/l8ldlFVEc1ImkwC/WfogsKNavGjRx4IM1InjqLh6+WY+LcEnRStWr8W0bUHhezyMZj1sRt2ea6j+7NhP5dkbD0DArVJSCKodUbTvx787qIygyLr+gradTQ3fRTxp7GFt/Zxchvi9vZhq1PPBs6joZybHFYZ+igAovIizMFHrPs7Puaalmc3XYGOADQBhDeBBNHxsN4FhZYvaVaaUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Gd+0oqMAWFwq6bCWMssGU4bQYeSKs8zhp6cfNsFrKU=;
 b=fXK2p9U/760MZsstGKoVV6UF13fFbX1QhvBDNITg+JS9qpVNMwofm1eV/rxB68d9EUcSCWLI5RkIfyeyb5hcEAZJsRDq0uMIbuIJ/+O/IksidJgoSeJGrltR2HrBGJFtpP1pspupdZHwLs0PG8UttziDVV6HNtnyyG4XRHmZWbpy7dlgIFCSV5y6DAhVvJfKpp29VpcWIBtWOa3lXBQzIcybdJAjQWcTcJ34+uhMgBfyUuasHLuOncwmhnsUuBi/RPnEyZRYz/pADoRjZPmp4g65q5irm5shmWLSopTqE5ohA/nCZaT7sTE1oqDU0lKdgWttfefoNbtkuM0SgKVo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gd+0oqMAWFwq6bCWMssGU4bQYeSKs8zhp6cfNsFrKU=;
 b=P+whvi/zlHcnzATm/HXxUrBcj6b0lgI+UEEVHU73/6je3VHCwI7GxB+uYn75a2tyKSCuujjuuQZR4rfu4WNaiij/h/H0XEquSQDtffJZTmiZyq33TUpFUp/X//21QJh1axmwFqElflBUPE7A1V5jaEjIlUCu+XU39kS6K8xGGR4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 07:19:05 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::1304:e061:45a4:23e1]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::1304:e061:45a4:23e1%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 07:19:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <xianting.tian@linux.alibaba.com>, <conor@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>, <heiko@sntech.de>,
        <guoren@kernel.org>, <mick@ics.forth.gr>,
        <alexandre.ghiti@canonical.com>, <bhe@redhat.com>,
        <vgoyal@redhat.com>, <dyoung@redhat.com>, <corbet@lwn.net>,
        <bagasdotme@gmail.com>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <crash-utility@redhat.com>,
        <heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
        <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V2 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Thread-Topic: [PATCH V2 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Thread-Index: AQHY39LZ3v20FpsNvE6RxX9dtMEWx64TBOOAgABuIgCAAFELAA==
Date:   Tue, 18 Oct 2022 07:19:04 +0000
Message-ID: <642e0529-1df1-86e9-f7de-a6252ba9fd12@microchip.com>
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-2-xianting.tian@linux.alibaba.com>
 <Y02y9eN1TNJteTw6@spud>
 <78420277-215f-55d0-67b8-fbf9208b3d22@linux.alibaba.com>
In-Reply-To: <78420277-215f-55d0-67b8-fbf9208b3d22@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: 7cfcd0e5-b276-4447-2faf-08dab0d909f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUj3BfBAlViRJSVYSe56iFWu12Ya5fiTH9fRTrxc3+GP7gh20/i8i00z+th0878RSDQLqsREt6j2T8MKbNmPmEW6rG6rf5blKgaZ2OcZdtaqrGVh4Qo6A8Ip7RGzMUfh8v0lt5emG99W3pFCGDtj6fJfOP0/qoL6grxQA0gpvPCFzGZQfsH3pg6P73szhbvIik73orIo7+6hOVOQ8qwWKT60QQCpm9V8116SWA40Ujb1hhmNL2Da0ZPEksBZR6b3Jm6dXIrDW33L75OsGQgD5Q0RN6IwA3gcaDazbPg9ReP5m2J5Oxp2sXiaYX/xE1z4GtPJYhrIwKvYLozAPtnH26CB72FtP4djunuBRACATBOn+4F6UJjeSr9FwzlHEBmjicCzjfZYefUkc8Gk7Ri9D6cK88mIYeOBXv5VLGvVIL0HVDQ+ytA3aHrEleFnvDqUoccCqI1HbE00B7xQ1GRQ5cyiWhAo3FlUArEjPiW5zTBPv6rhrhEVLrFtWerY+9j3b58Zs5YIoJgl/OzCWx1zJCzvG6uLwGJHU5L9L0FE9BPZdcu5ZvurzSpAukUfg0E55IHF8AZ7cqFg4qDlsh0PSxKBHcTd9U5Em3OTGicLkvICck9GLclxKxIxh8Kfrq8Zo6Yz3c0UOE3NHxzGR0/5a9b1BIF+gIhWz454iy8DattVgIcTvXPtgW9YEAbIs3ZCJLgwR4K/8iEQjuIz9oq8da2aBwVYlhr/icfiaxNUeUz1SVsY8Jk1qArxy0kvbskuVm7UeqiaShW+ZYhm93yCCt2QCKnBZfsBiwqcw7iJcX7Fechn9+hDG+1wmnNeLZ4aUSmYo5HHJvwVLsk61oqAnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(83380400001)(38070700005)(36756003)(86362001)(31696002)(122000001)(38100700002)(91956017)(76116006)(66946007)(66556008)(316002)(54906003)(110136005)(31686004)(7416002)(5660300002)(71200400001)(8936002)(186003)(66476007)(6486002)(2906002)(2616005)(478600001)(6506007)(64756008)(6512007)(26005)(66446008)(41300700001)(4326008)(53546011)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VThoK0wyeTRCQ0dRbUFMZTQ0dWRjbUZiTnd5RHFRbm1uVVp3clpadllCTHVV?=
 =?utf-8?B?SWlzbU9YdUZJSlRFZzI3ejBJd2tmek45TnBkVk1jNHNjY0Z3TW5oNkE1b2cz?=
 =?utf-8?B?M1JMVGFiQ0hTeDBVOTFoWTJ5Q0ZWSzVUVzY3N1B3aEU1WHV6TWlicjNxMXgv?=
 =?utf-8?B?Nm5hbXZwS2pRanYvREtPWTBWclRiMlNnd2tDdVVnNFc2cHNLcUNEd2gwQWRy?=
 =?utf-8?B?WEdWeTkrWGs4WmlMbkZqNnJJWjR1dU9jdWtYdXBVWUsxOVVjTjhzVmRRNUtV?=
 =?utf-8?B?eS9RNmFQa2hSbjh4SDVBc1VOTVY3YUlvenpDa08vUkxXMUtRckp3MUMzZGpS?=
 =?utf-8?B?WkV6REh4N0RwcTcwdEpBVmkvckN1RldKb2E0VTFYUlc1b05kZVdra0NnLzZz?=
 =?utf-8?B?ZWhRcWtMSWY2c3JJNjlseTFuWkg5REM0dnhYcHVGN3VSYW9SYmhuOCt4SEQx?=
 =?utf-8?B?b092UUU0Q1BmandDdmk1ZDFIODZKOEhvVlJKdWNYL3ljZ3ZXdS8vd0QrVUw1?=
 =?utf-8?B?OERCL2J3d3JLZzMwZFYvNUo2VHVqVFU3U0RkRmR1WFR2YUw0K3VsYWhYS3NO?=
 =?utf-8?B?MGRwT0F0Y2l4ckE2TFBWQlU0YWlETzlRMkFvTldQWUl3a2JMN1dPZXdVcFpF?=
 =?utf-8?B?TXZVRDIzanFJRldYOFdTMHJsaFYySFBaNEtmQlYxTDFjWFJMKzBhYzcrOEFh?=
 =?utf-8?B?YzdWWml5dzFZbG5JeU5KZkh4dzBzRlU0OTVveGpDdmp2cnlEdXBqbXh5MGtv?=
 =?utf-8?B?U3J3L1VDR0dkU1crc3lZT2V1eEpyU3paRzVwc25jV2NYNTRBVmNNSmNNV3A0?=
 =?utf-8?B?Vm56KzAwemNuR2V5aXlER0M0NFJGQnhnc3VKMWZvRExZNUE4WWVoV1VVWjJN?=
 =?utf-8?B?NWc0L2orbGZRaGFUeXlDRDN1cHJuSjVRRU5LSGcyV1Ruci9tMEF2dUM1TWtx?=
 =?utf-8?B?dFg5ZUtDeTFpTk9GaXQrTmQ2MkR5QXZYUy9keE8zc3RPMGxFUFdkQ0xjZGZq?=
 =?utf-8?B?UjZNczlvT29uV1hkMFhFaG16V1RaZTUxc1dPSDdIaUFxSWVuU09FcjI1QnBC?=
 =?utf-8?B?b0xCUGFSWUU0MkRjWE9FWFlBNlR0ejM0SHZzeDBNdUp1MHk3RXdPQ3JUTmk4?=
 =?utf-8?B?ZHlFQ0lDYVZGMDdWZzg3d3lEZnhyTGFFOW5ZS2xGeWZleDUrWm9KUnJ5Z0E5?=
 =?utf-8?B?VnhVNk1IV1pHM0VWdEJVUElrQjhQbTZwcSt3dTRiL1l2djFnWDVYcUdjUk5o?=
 =?utf-8?B?ekY0TXhIQndLZ2FOUTgwR0V1SVFRVEcvaFYxbUVCd0lGeWtDOUd3OTF0dFk1?=
 =?utf-8?B?MS9iTUZQWk9MMVliMUFOekpHcTU5dzh0RHRxVlNURTNJcHVSdTJ1N1ZLV2pt?=
 =?utf-8?B?Y2tGaDNPcVlwa0hGSXNEeFdvT0k1dUlGN1Y0UEE0SVAycEVEWERMMmNrZHRZ?=
 =?utf-8?B?S0YvUzhsaWJ5aHNLdk9DOVhacmZUbTIzcW1zcVByODRZczV1RFFta2h5eG1B?=
 =?utf-8?B?WUxjNEtWbjhBSWZCQmFCaTJjUU9XTUZEOWZTemFjbWZIaTJsWFdrTnRudjBw?=
 =?utf-8?B?UElQeWgvSWtDVGtpeEkrY0I2dHN5SmY1UVprTUlERUxZV1o3VnBjbmM4SDFS?=
 =?utf-8?B?SGJhclpEYXpmdDF6TFhGSlpERU9ML3dNbVVVak1JdHlFeEJBTHV5QVhmelUv?=
 =?utf-8?B?MFVXVnAzZDMxcXlpMWlRUGZSZFEyb0duWmxvakdzY3k1NGJ2bldlcU9Ebnpo?=
 =?utf-8?B?azZNVk5NdURYa1JKd09ydlRJblJWdmtPL3NGM2dqekdFK1pUMi9sMWNpVTRX?=
 =?utf-8?B?QUZpMjVkT1luU2RGb1hFbVhwNmVvaGkycDV2Y081Y0E4OXQrQmFSNHNnSXhI?=
 =?utf-8?B?RG1aUGVCUkdkdWNiNGtncFZhaEt3Sm83dnp2Z1FjWEtBWjJaV1VjU0VxMTl4?=
 =?utf-8?B?N1hwQVltNFlWS09BeFpwOFBMYXBNcnVBRENKc05zbTBxNG8zRG9BTmI4R2pk?=
 =?utf-8?B?dktuTk1EM29oaGhWNWkxVmZuQ1RhZFpZazQ5YWxkWHp2T29hVk5mTWV3WlhN?=
 =?utf-8?B?T2NZc04vV2UxcTlaUmlVY3k5SFMwVjc1L1N6UUxtT0JSWmdOMENHY2N5bHVI?=
 =?utf-8?Q?aTGxK9DLa9uLySPYEaVJWqoUX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B02405F864F49E46978B9A71220345D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfcd0e5-b276-4447-2faf-08dab0d909f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 07:19:04.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZhYIRkM4najIgbSzJdqA7QTItg9IXBYhPebZ0oz6FAXkM40QBIYSpTZMDqBF7ASh28kyk+KcwszWGKNlqY6K6EYEJ9ewLKYtvlgxpBkF3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMTAvMjAyMiAwMzoyOCwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiDlnKggMjAyMi8xMC8xOCDkuIrljYgzOjU0LCBD
b25vciBEb29sZXkg5YaZ6YGTOg0KPiANCj4+IE9uIEZyaSwgT2N0IDE0LCAyMDIyIGF0IDA5OjQx
OjM4UE0gKzA4MDAsIFhpYW50aW5nIFRpYW4gd3JvdGU6DQoNCj4+PiAgICogTGludXggS2VybmVs
IDUuMTggfg0KPj4+ICAgKiAgICAgIFBHVEFCTEVfTEVWRUxTID0gNQ0KPj4+ICAgKiAgICAgIFBB
R0VfT0ZGU0VUID0gMHhmZjYwMDAwMDAwMDAwMDAwDQo+Pj4gICAqIExpbnV4IEtlcm5lbCA1LjE3
IH4NCj4+PiAgICogICAgICBQR1RBQkxFX0xFVkVMUyA9IDQNCj4+PiAgICogICAgICBQQUdFX09G
RlNFVCA9IDB4ZmZmZmFmODAwMDAwMDAwMA0KPj4+ICAgKiBMaW51eCBLZXJuZWwgNC4xOSB+DQo+
Pj4gICAqICAgICAgUEdUQUJMRV9MRVZFTFMgPSAzDQo+Pj4gICAqICAgICAgUEFHRV9PRkZTRVQg
PSAweGZmZmZmZmUwMDAwMDAwMDANCj4+Pg0KPj4+IFNpbmNlIHRoZXNlIGNvbmZpZ3VyYXRpb25z
IGNoYW5nZSBmcm9tIHRpbWUgdG8gdGltZSBhbmQgdmVyc2lvbiB0byB2ZXJzaW9uLA0KPj4+IGl0
IGlzIHByZWZlcmFibGUgdG8gZXhwb3J0IHRoZW0gdmlhIHZtY29yZWluZm8gdGhhbiB0byBjaGFu
Z2UgdGhlIGNyYXNoJ3MNCj4+PiBjb2RlIGZyZXF1ZW50bHksIGl0IGNhbiBzaW1wbGlmeSB0aGUg
ZGV2ZWxvcG1lbnQgb2YgY3Jhc2ggdG9vbC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFhpYW50
aW5nIFRpYW48eGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbT4NCj4+PiAtLS0NCj4+PiAg
IGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlICAgICB8ICAxICsNCj4+PiAgIGFyY2gvcmlzY3Yv
a2VybmVsL2NyYXNoX2NvcmUuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4+PiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMNCj4+Pg0KPj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSBiL2FyY2gvcmlzY3Yva2VybmVsL01ha2Vm
aWxlDQo+Pj4gaW5kZXggZGI2ZTRiMTI5NGJhLi40Y2YzMDNhNzc5YWIgMTAwNjQ0DQo+Pj4gLS0t
IGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUNCj4+PiArKysgYi9hcmNoL3Jpc2N2L2tlcm5l
bC9NYWtlZmlsZQ0KPj4+IEBAIC04MSw2ICs4MSw3IEBAIG9iai0kKENPTkZJR19LR0RCKQkJKz0g
a2dkYi5vDQo+Pj4gICBvYmotJChDT05GSUdfS0VYRUNfQ09SRSkJKz0ga2V4ZWNfcmVsb2NhdGUu
byBjcmFzaF9zYXZlX3JlZ3MubyBtYWNoaW5lX2tleGVjLm8NCj4+PiAgIG9iai0kKENPTkZJR19L
RVhFQ19GSUxFKQkrPSBlbGZfa2V4ZWMubyBtYWNoaW5lX2tleGVjX2ZpbGUubw0KPj4+ICAgb2Jq
LSQoQ09ORklHX0NSQVNIX0RVTVApCSs9IGNyYXNoX2R1bXAubw0KPj4+ICtvYmotJChDT05GSUdf
Q1JBU0hfQ09SRSkJKz0gY3Jhc2hfY29yZS5vDQo+Pj4gICANCj4+PiAgIG9iai0kKENPTkZJR19K
VU1QX0xBQkVMKQkrPSBqdW1wX2xhYmVsLm8NCj4+PiAgIA0KPj4+IGRpZmYgLS1naXQgYS9hcmNo
L3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3Jl
LmMNCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uOGQ3
ZjVmZjEwOGRhDQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVs
L2NyYXNoX2NvcmUuYw0KPj4+IEBAIC0wLDAgKzEsMjkgQEANCj4+PiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPj4+ICsNCj4+PiArI2luY2x1ZGUgPGxpbnV4L2Ny
YXNoX2NvcmUuaD4NCj4+PiArI2luY2x1ZGUgPGxpbnV4L3BhZ2VtYXAuaD4NCj4+PiArDQo+Pj4g
K3ZvaWQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8odm9pZCkNCj4+PiArew0KPj4+ICsJVk1D
T1JFSU5GT19OVU1CRVIoVkFfQklUUyk7DQo+Pj4gKwlWTUNPUkVJTkZPX05VTUJFUihwaHlzX3Jh
bV9iYXNlKTsNCj4+PiArDQo+Pj4gKwl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihQQUdF
X09GRlNFVCk9MHglbHhcbiIsIFBBR0VfT0ZGU0VUKTsNCj4+PiArCXZtY29yZWluZm9fYXBwZW5k
X3N0cigiTlVNQkVSKFZNQUxMT0NfU1RBUlQpPTB4JWx4XG4iLCBWTUFMTE9DX1NUQVJUKTsNCj4+
PiArCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNQUxMT0NfRU5EKT0weCVseFxuIiwg
Vk1BTExPQ19FTkQpOw0KPj4+ICsJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1FTU1B
UF9TVEFSVCk9MHglbHhcbiIsIFZNRU1NQVBfU1RBUlQpOw0KPj4+ICsJdm1jb3JlaW5mb19hcHBl
bmRfc3RyKCJOVU1CRVIoVk1FTU1BUF9FTkQpPTB4JWx4XG4iLCBWTUVNTUFQX0VORCk7DQo+Pj4g
KyNpZmRlZiBDT05GSUdfNjRCSVQNCj4+PiArCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVS
KE1PRFVMRVNfVkFERFIpPTB4JWx4XG4iLCBNT0RVTEVTX1ZBRERSKTsNCj4+PiArCXZtY29yZWlu
Zm9fYXBwZW5kX3N0cigiTlVNQkVSKE1PRFVMRVNfRU5EKT0weCVseFxuIiwgTU9EVUxFU19FTkQp
Ow0KPj4+ICsjZW5kaWYNCj4+PiArDQo+Pj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfNjRCSVQp
KSB7DQo+PiBZb3UndmUgYWxyZWFkeSBnb3QgYSAjaWZkZWYgQ09ORklHXzY0QklUIGFib3ZlLCBp
cyB0aGVyZSBhIHJlYXNvbiB3aHkNCj4+IHlvdSdkIHVzZSB0aGUgSVNfRU5BQkxFRCBoZXJlIHJh
dGhlciB0aGFuIG1lcmdlIHRoaXMgd2l0aCB0aGUgYWJvdmUNCj4+IHNlY3Rpb24/IEknbSBhIGJp
ZyBmYW4gb2YgSVNfRU5BQkxFRCBidXQgSSdtIG5vdCBzdXJlIHdoYXQgaXQgYWRkcyBoZXJlLA0K
Pj4gbWF5YmUgeW91IGNhbiBzaG93IG1lIHRoZSBsaWdodCA6KQ0KPiBUaGUgSVNfRU5BQkxFRCgp
IGNoZWNrIHByZXZlbnRzIHRoZSBsaW5lIGZyb20gZ2V0dGluZyBleGVjdXRlZCwgYnV0DQo+IHVu
bGlrZSBhbiAjaWZkZWYgaXQgcmVsaWVzIG9uIGl0IHRvIGJlIHBhcnNhYmxlLg0KDQpIZXkgWGlh
bnRpbmcsDQpGaXJzdGx5LCBuZWl0aGVyIHRoaXMgbm9yIHRoZSBvdGhlciB2ZXJzaW9uIG9mIHRo
aXMgbWVzc2FnZSBtYWRlIGl0IHRvDQp0aGUgbWFpbGluZyBsaXN0IC0gYW5kIHNpbmNlIEkgdXN1
YWxseSB1c2UgbGVpIHRvIGdldCBteSBtYWlscyB0aGF0IGlzDQphIGJpdCBvZiBhIHByb2JsZW0g
OigNCg0KWWVhaCwgSSBrbm93IHRoYXQgdGhhdCBpcyB3aGF0IElTX0VOQUJMRUQoKSBkb2VzLCBp
dCdzIGp1c3QgaW4gdGhpcw0Kc2l0dWF0aW9uIGl0IGRvZXMgbm90IGxvb2sgdmVyeSBpbnRlbnRp
b25hbCAmIG1vcmUgbGlrZSBkaXNqb2ludCBiaXRzDQpvZiBjb3B5LXBhc3RlLiBJdCdzIGZpbmUg
dGhvdWdoLCBsZWF2ZSBpdCBhcyBpdCBpcy4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+IEkg
d3JvdGUgdGhpcyBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbygpIGZ1bmMgd2l0aCByZWZlcmVu
Y2UgdG8gdGhpczogc3RhdGljIHZvaWQgX19pbml0IHByaW50X3ZtX2xheW91dCh2b2lkKSAvLyBh
cmNoL3Jpc2N2L21tL2luaXQuYw0KPiB7DQo+ICAgICAgICAgIHByX25vdGljZSgiVmlydHVhbCBr
ZXJuZWwgbWVtb3J5IGxheW91dDpcbiIpOw0KPiAgICAgICAgICBwcmludF9tbCgiZml4bWFwIiwg
KHVuc2lnbmVkIGxvbmcpRklYQUREUl9TVEFSVCwNCj4gICAgICAgICAgICAgICAgICAodW5zaWdu
ZWQgbG9uZylGSVhBRERSX1RPUCk7DQo+ICAgICAgICAgIHByaW50X21sKCJwY2kgaW8iLCAodW5z
aWduZWQgbG9uZylQQ0lfSU9fU1RBUlQsDQo+ICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxv
bmcpUENJX0lPX0VORCk7DQo+ICAgICAgICAgIHByaW50X21sKCJ2bWVtbWFwIiwgKHVuc2lnbmVk
IGxvbmcpVk1FTU1BUF9TVEFSVCwNCj4gICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZylW
TUVNTUFQX0VORCk7DQo+ICAgICAgICAgIHByaW50X21sKCJ2bWFsbG9jIiwgKHVuc2lnbmVkIGxv
bmcpVk1BTExPQ19TVEFSVCwNCj4gICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZylWTUFM
TE9DX0VORCk7DQo+ICNpZmRlZiBDT05GSUdfNjRCSVQNCj4gICAgICAgICAgcHJpbnRfbWwoIm1v
ZHVsZXMiLCAodW5zaWduZWQgbG9uZylNT0RVTEVTX1ZBRERSLA0KPiAgICAgICAgICAgICAgICAg
ICh1bnNpZ25lZCBsb25nKU1PRFVMRVNfRU5EKTsNCj4gI2VuZGlmDQo+ICAgICAgICAgIHByaW50
X21sKCJsb3dtZW0iLCAodW5zaWduZWQgbG9uZylQQUdFX09GRlNFVCwNCj4gICAgICAgICAgICAg
ICAgICAodW5zaWduZWQgbG9uZyloaWdoX21lbW9yeSk7DQo+ICAgICAgICAgIGlmIChJU19FTkFC
TEVEKENPTkZJR182NEJJVCkpIHsNCj4gI2lmZGVmIENPTkZJR19LQVNBTg0KPiAgICAgICAgICAg
ICAgICAgIHByaW50X21sKCJrYXNhbiIsIEtBU0FOX1NIQURPV19TVEFSVCwgS0FTQU5fU0hBRE9X
X0VORCk7DQo+ICNlbmRpZg0KPiANCj4gICAgICAgICAgICAgICAgICBwcmludF9tbCgia2VybmVs
IiwgKHVuc2lnbmVkIGxvbmcpS0VSTkVMX0xJTktfQUREUiwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAodW5zaWduZWQgbG9uZylBRERSRVNTX1NQQUNFX0VORCk7DQo+ICAgICAgICAgIH0N
Cj4gfQ0KPiANCj4+IFRoYW5rcywNCj4+IENvbm9yLg0KPj4NCj4+DQo+Pj4gKyNpZmRlZiBDT05G
SUdfS0FTQU4NCj4+PiArCQl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihLQVNBTl9TSEFE
T1dfU1RBUlQpPTB4JWx4XG4iLCBLQVNBTl9TSEFET1dfU1RBUlQpOw0KPj4+ICsJCXZtY29yZWlu
Zm9fYXBwZW5kX3N0cigiTlVNQkVSKEtBU0FOX1NIQURPV19FTkQpPTB4JWx4XG4iLCBLQVNBTl9T
SEFET1dfRU5EKTsNCj4+PiArI2VuZGlmDQo+Pj4gKwkJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJO
VU1CRVIoS0VSTkVMX0xJTktfQUREUik9MHglbHhcbiIsIEtFUk5FTF9MSU5LX0FERFIpOw0KPj4+
ICsJCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKEFERFJFU1NfU1BBQ0VfRU5EKT0weCVs
eFxuIiwgQUREUkVTU19TUEFDRV9FTkQpOw0KPj4+ICsJfQ0KPj4+ICt9DQo+Pj4gLS0gDQo+Pj4g
Mi4xNy4xDQo+Pj4NCj4+Pg0KDQo=
