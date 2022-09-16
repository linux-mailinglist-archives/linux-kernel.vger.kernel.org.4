Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260415BA71F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIPG6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIPG6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:58:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418176F257
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663311491; x=1694847491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=02A+/BZYDIdPL/8ttLEuEgRktQJJFSoIkt9e9ynDCNM=;
  b=j582i3d4+dABpe3FPrwtGxWtd+Yks6zhgaBhXtpw2XpAy3AkWTzdg6PE
   Tem7cXFNDApSU5ub4/XDgzXkmGtlnbpH1Bf9w3AIPy9UtgyBtcGULR8Tp
   GuKG3+yRroIcLA01u7fbkZ2wiM/LsVhKwWtpaRobpq6jTXy1Rfjz76AgY
   X6PLzfzurCiX9iZ5w1DI0SsWvpJxgjR2FrkvOqx98sXDRoCTXfRnZlUfp
   pAZ/NajCr4bSJM6E0tV8KqVDQnn7KagYSi6blHo8F4dCAzIbjgGes5p6W
   +BIqTkZhgEMXEDb0iB4GqsHExAmi0poqbDl/uA8eOwALg6p73Ggqx/Dax
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="180765105"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 23:58:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 23:58:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 23:58:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDFK9ntIfbvaeQEZwzYzmJ1QNrQmPCSaKf0r/SF2kMLti8FNl19QSasmq95mUXsnGxdnwELiPnKvsJXFzciJoUFdfSq+ejfaAxIVNH5iFHJwZ2HjDf8lSRlU+M6W4hYGEQmIloZ0sOozrI7+ZDb5NURe9sPzvC77eB0RohKt+1q/QnsUapJ1OZDLs9thZutVkZA2JirdfkiuxfihmhDLFS2RMdljwTG//rqm6fQigaAXrU+h5mu/TJAV8INsIX1hGGbbt1JIU9CgJRFTQo/8Zm1xbq26nNco+7cb3cjU4WXjQTh0xzvUhPO+dc23kd4pu4CZ5KQIqlpy1EYO+yxRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02A+/BZYDIdPL/8ttLEuEgRktQJJFSoIkt9e9ynDCNM=;
 b=Y5lLKNX6GJwWlNHZejNGUfrwSORsNeta++GVHsWt5Sp2D6pIyFa05G28uWqxrXhulCVRa5ef0COnAmZ3O50UzoOIaYZSybQtN/sfCwfGnu9NF8xMy/VTimFepoqHcihB+sNG4dytEGYIFc7pxQeyptzaOWM8zydgKl7O4SIihqfXNBkLAHIuwGdSP+faE4HC2nDHthpNg8QRdiYnbloXGv73vS1Zs5TLyOdNmFIV0Pt22/pbq6bILjkELxacs5e/u+f9wWcYp+owEIVonyn/ygxYKlFbEcMxUYgaka80Ec1r6n+W+QNMN4urTo/Rrh2R2+oU/sxz8ucpg7xE2Y9X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02A+/BZYDIdPL/8ttLEuEgRktQJJFSoIkt9e9ynDCNM=;
 b=PNzgAcmeYpvQ+d4KAFaU33yjUtYNOJZOqwfdnZYli5vKkrRxqg7HxYm82j8wFenq72OisdEyUryf4myTgejTDDItO7RrmbDEWvBYPxFL0QlIEqkVy5FooK/OVIwo9lRUkQKjh/v4JHiswEk4Od+azHt3icMiZ7taTT/gaA7C5cw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB5960.namprd11.prod.outlook.com (2603:10b6:510:1e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 06:58:05 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 06:58:05 +0000
From:   <Conor.Dooley@microchip.com>
To:     <vineetg@rivosinc.com>, <linux-riscv@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <palmer@rivosinc.com>,
        <cmuellner@ventanamicro.com>, <linux@rivosinc.com>
Subject: Re: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
Thread-Topic: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
Thread-Index: AQHYyYQq7AHa3Cms0USowTkeq57IPq3hmaYAgAAGkoA=
Date:   Fri, 16 Sep 2022 06:58:05 +0000
Message-ID: <9b9ff287-75e5-3ee5-e6c5-1daca6c562dc@microchip.com>
References: <20220916030552.1396820-1-vineetg@rivosinc.com>
 <20220916042331.1398823-1-vineetg@rivosinc.com>
 <67a3aba3-68bb-5e8b-4e4e-869c8e99e879@microchip.com>
In-Reply-To: <67a3aba3-68bb-5e8b-4e4e-869c8e99e879@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH7PR11MB5960:EE_
x-ms-office365-filtering-correlation-id: e4147afa-d034-499d-a6d3-08da97b0cdfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qR0n44pS9/HxWDmu0TT9aQbLHe0X8uVibUR7+lUK4aiX1WwTGKeFw7WwBesjSvMbFEUrewjL8hjWOlmmhgfRV/GNVV7pXMv13LKXjtSCttL4Pe7IRFMBXofZ7HD0sYMb13xhvC7cCr7RwkedI9tuFQUg+AvDQFxuooepj1bQfvdH8PGWIVm/SvBLPOKp2y9C32WtGh/fdILQwFyeBQ5tKyTk12ksN4Ce6OXNS70xYWHF63ak7j0AFYzSHXMWx5QWKd7GLZOAo3ZCJ8irVWUDFyCsF/RBPdXwy4EluXE1S1lvVZzmwr2eAhw3l8DfTuDPzsxe+QzQAH9XqQnBnuz9XRvlkK+elAymRoJ2tnhqwYJZZoN40rBoZ0FAbGnM0EwPKjks6gIniaHDhw46gDA5++3dCCBw98U223Rxmg5i4oc34AiUNRwdQyyr4BxNT9Oq78iZH0Y7+oyrNFf1PuzqW/CJzzEU3SmZn1Xp32MQPRPvi4QY65dQqQaGwhRx83jNS0sTTSJwKm9qpGosePWPw26R+c4jx/s8fDRYvW5lA0yQZnSQPiBQ0HiN2TQgRMGgwH1QSsFmR5XZJ4Aga0UMZJIGL6vqZUDZwpU26s5eoKKIgt7TP/I2RFKwpjYuH9TiSEiXjK3u3+0Nw7a7Pk/BhwkXVVOPyLLaet+zYPvl/UJFx0pETebo5Y5Z5YKpegcdIWI/jF0pArzgc1aDjaT3jPzItOJgWUIjNJAUXlyFaQ4mm/gdKT/QPJ+CFkEdTgwsomPcPsVHnCxzl8ZKYCQ/cR1hq+kZRYBbxiNMtugkJZj5tPyXooP4Fgk6p5ODZlKfWQRk85mBFK0qRGp22IxQ1CcSKh7u582PWyillVI+3DiZXB6zJuFNuuoj0LAWpfq6YG9dsLLxsCjjdmZtmGUHzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(86362001)(36756003)(38100700002)(31696002)(122000001)(38070700005)(31686004)(53546011)(2906002)(6506007)(966005)(186003)(5660300002)(41300700001)(8676002)(71200400001)(6512007)(26005)(83380400001)(2616005)(478600001)(4326008)(66946007)(91956017)(76116006)(6486002)(110136005)(66476007)(316002)(66556008)(8936002)(64756008)(66446008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0Y4S3dJM3pNeVhQOU1FRWJ2UHpaKy9kY3JDMDdEMlBTQ1BQUTYzYnRhRjF1?=
 =?utf-8?B?bThQVjVnUHVmUlNEQ2xXaWZaNGVpVlN3djZJcW4xc3NhWUIrTmJxZXdkM2ZC?=
 =?utf-8?B?VjVMNkh6ZnJjaUdFamtqTFBWQXdISGxpY3lVOC9paXErNkNvQjFvUGJHMjFM?=
 =?utf-8?B?MnVNd0VnTjRIMTdOQXlURlEzYUUwR3VLSUlESitlVDdHUmVOQ0JyNWFnUVk3?=
 =?utf-8?B?TnVJRGlrUFZkejN3cG9zbURRRVlxb1M4emFhbFdtRmRnZWlBZVpPeTN4VmhW?=
 =?utf-8?B?MktsajJUVWdWUU5JbW9qa0lEYS9OdmVFaEhLRmsveDlKZzc4WjVzcFJBczVU?=
 =?utf-8?B?ZTY0Yjg2S1dkR1VEaDZFV2lpUUpybEFhdWE2TXpCd1kvcGxpV2hBL1FHQ2l6?=
 =?utf-8?B?dThDWDlUdWhtNkpHYk9uY3hIQTlpVmp5eGVDUFBjNGlrNGJobzh3ajVRVEpK?=
 =?utf-8?B?SHNhOEFYRjhOT3NMQldrdkRzU3V5RnhQNmkwMG1TUEYyTjVHcW5VdTE0VDlV?=
 =?utf-8?B?NXg0bGtKNEY2SnZORXJkRndUZmlnMGVxZTVULzlGUDFkWGJnSUgyczJ6dkx6?=
 =?utf-8?B?bUZCejJiMG5qck5pOTNqbURPRzJycDNRelN6MllXUGpGc095WmhSeWhxV0J2?=
 =?utf-8?B?UkZXSitNY2t1eGlIdkZaVWd4QmNwWnh0WEQvRnpVSWw4R01ISHRSM1MrZFZl?=
 =?utf-8?B?QzNNNTlXT1orcFo0Z3N0MkdsWUhmK2U2STc4OG1tY1RnRzR1VnpuQ1Z4M1I4?=
 =?utf-8?B?bmJpNGxSMUZxeG9DRVRkZEUyMnh1RktVcFdxTldJcWJRSHI0ZXFrWWdlb01N?=
 =?utf-8?B?VWliNkdoanR4L2h6MzYybUJDekI2RHBoSWZOVVFGa2ZnV0pYNjRPRFRjbHpH?=
 =?utf-8?B?M0xBdU1YRkRuNVZhbGlDVFRScnJPUko4Zk9zeTkwL1BIN3BYS0NPMlRkaDNQ?=
 =?utf-8?B?M1pQU0MzS05PaS9ibzRJa3BINkxLeFhVYzJhVTg0T1hWM2UxbTNKd2lITy9C?=
 =?utf-8?B?QmN3UFl6MWpicDhaajl4OHRyZ2V3V3dPRTRlZ2JjME51aEs5dC90SmdTd2hX?=
 =?utf-8?B?Q0ltdG9CbnlaL0oralRjZURWZTdVOXgrOGd1eVFvTlQ4VFpBaXVYMWd4Zzd6?=
 =?utf-8?B?ZGZyamYrNGtDNTJ3UXRzM3dNTTRpQ01lVUdlQnYxeC9Zbzk3YmE4ZjB2bStV?=
 =?utf-8?B?ZURscG5XbkJOK0RYd1N0eXU4azlpU2laSndxaWFsbXEydVNrVmlweE1LdFQz?=
 =?utf-8?B?NnA0TDB4L294WHJPVDhRN3QraGZ6WlNnNVEvTnM4d2NpMldoMXZIME9Kekl5?=
 =?utf-8?B?TDlFa29zY0NCaDRNQ1BDUmdBY04yQ0tEcEwyNmMrODZ4c1pEeGNtWkZZWU9k?=
 =?utf-8?B?VmQvd1VwTFppKzQyMVErWVduaXkzY1JNQXVXNVNISjZoV29nRko0QS9oZHU0?=
 =?utf-8?B?RHo0MkpGdFJ5VVF4TUtQK0ZBRDU4ZlZTRGZ0TGl6L2ErMDlVeGlyczdkdjRP?=
 =?utf-8?B?ZE1KaWxkNUVoY1lWdzkrQkhDVUpwWWg3WG05VWZqbUxVSTVGMCs2K1NWSklL?=
 =?utf-8?B?ZkExdmpLZ0JyWC95amVYKytPQTNya24rMnJwRFpTdUt5eGZVaUMxOUNrKzJM?=
 =?utf-8?B?eW1JZjRKRDBPYXZJMmVoSU1qUnBzTGZ5UGtBRFZLNldib1pJN3A1eHlyVTVt?=
 =?utf-8?B?cDY4OU5MNVZ5S3NLMDBJK0pIakkrcVkrSDVKSDdvS2xWSnY2MVhWblhRMEhE?=
 =?utf-8?B?cnlDN2dqU09yT1lpLzJUUVRjeGtEVFBKbUlIc3FNMGxoRVJ2eWgxSnNFWjJK?=
 =?utf-8?B?U1lKZnBIWmZVbUVnUDVmemd0M0JQVCtDWWVhelg2VityRHdDYzFjN29iMEZS?=
 =?utf-8?B?NWZXaEpuRHlTVDk1MmlBQjBIL1B6OXNBYTFEQVRrSm5QTFZGNTM4Q0hWYkZh?=
 =?utf-8?B?YXpiOW1rRTF4NWcxVCticGVOdm5xdk5qWDVmK1I2dnNCVnJnTUUxZzNGVldi?=
 =?utf-8?B?TVBPNXpUUzhFZlBsS1lGa1YyMTVoazlXMTNDWDNVZnBGZ0ZvTm5vTGZWYWFN?=
 =?utf-8?B?cE43bHpjSDVndjM0SFgwenB5QUxaVnNqMXVGSXZBNXJOMjF5OWllcXpvaGI0?=
 =?utf-8?Q?vhD3C55yy+Bd/bjOzNJXhoSTq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC0C53D4B260240B2AAC3EC205A759E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4147afa-d034-499d-a6d3-08da97b0cdfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 06:58:05.1828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMk060z+MASsmvXzVuVX8DKCq/J7hesNkGmIlwGxcAWOT/m/clfOzBXu/Ag/YrslJV76Pu7gF172EUnKhOTtE00NcOFWHlWpQyNn52PA4Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5960
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDkvMjAyMiAwNzozNCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiAxNi8wOS8yMDIy
IDA1OjIzLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+PiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFp
bCBmcm9tIHZpbmVldGdAcml2b3NpbmMuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQg
YXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4+DQo+
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+DQo+PiBBcyBvZiBub3cgdGhl
IHNvZnR3YXJlIHN0YWNrIG5lZWRzIHdvcmsgdG8gc3VwcG9ydCB6dHNvLiBVbnRpbCB0aGF0IHdv
cmsNCj4+IGlzIGZpbmlzaGVkLCBkaXNhbGxvdyBiaW5hcmllcyBuZWVkaW5nIFRTTy4NCj4+DQo+
PiBUaGlzIHBhdGNoIGlzIG5lZWRlZCB0byBoZWxwIHp0c28gcmF0aWZpY2F0aW9uIGFuZCBwcm9s
aWZpcmF0aW9uIG9mIHRzbw0KPj4gYml0cyBpbiB0b29saW5nLg0KPiANCj4gSSBoYXZlIHRvIGFk
bWl0IHRvIGJlaW5nIGEgbGl0dGxlIGNvbmZ1c2VkIGhlcmUsIGlmIFp0c28gaXMgbm90IHJhdGlm
aWVkDQo+IHdoeSBkbyB3ZSBuZWVkIHRvIHByb3RlY3Qgb3Vyc2VsdmVzIGZyb20gaXQ/DQoNCkFs
c28sIHNpbmNlIHRoaXMgaXMgbm90IG1hcmtlZCBhcyBhIGZpeCwgd2h5IHdvdWxkIHdlIG5vdCBq
dXN0IGFwcGx5IHRoZQ0KcGF0Y2hzZXQgZnJvbSBQYWxtZXIgdGhhdCBsb29rcyBsaWtlIGEgbW9y
ZSBjb21wbGV0ZSB2ZXJzaW9uIG9mIHRoaXMNCnBhdGNoOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtcmlzY3YvMjAyMjA5MDIwMzQzNTIuODgyNS0xLXBhbG1lckByaXZvc2luYy5jb20v
DQoNCk1heWJlIHlvdSBjb3VsZCBvZmZlciBhbiBSLWIgb3Igc29tZSBjb21tZW50cyBvbiB0aGF0
IHBhdGNoIGluc3RlYWQ/DQoNClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IFZpbmVldCBHdXB0YSA8dmluZWV0Z0ByaXZvc2luYy5jb20+DQo+PiAtLS0NCj4+IENo
YW5nZXMgc2luY2UgdjENCj4+IMKgwqAgLSBCdWlsZCBlcnJvciAoYW5kIGJvb3QgdGVzdGVkIG9u
IHFlbXUpDQo+PiDCoMKgIC0gSW1wcm92ZWQgdGhlIGNvbW1lbnRzIGEgYml0DQo+PiAtLS0NCj4+
IMKgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vZWxmLmjCoMKgwqDCoMKgIHwgMTEgKysrKysrKysr
Ky0NCj4+IMKgIGFyY2gvcmlzY3YvaW5jbHVkZS91YXBpL2FzbS9lbGYuaCB8wqAgMiArKw0KPj4g
wqAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vZWxmLmggYi9hcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL2VsZi5oDQo+PiBpbmRleCBmNTNjNDAwMjZjN2EuLmI2YjQ1NDJiMzAzOSAx
MDA2NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vZWxmLmgNCj4+ICsrKyBiL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vZWxmLmgNCj4+IEBAIC0yNiwxMCArMjYsMTkgQEANCj4+DQo+
PiDCoCAjZGVmaW5lIEVMRl9EQVRBwqDCoMKgwqDCoMKgIEVMRkRBVEEyTFNCDQo+Pg0KPj4gKy8q
DQo+PiArICogTWFrZSBzdXJlIHRoZSBlbGYgYmVpbmcgbG9hZGVkIGlzIGNvbXBhdGlibGUgd2l0
aCBleHRlbnNpb25zLg0KPj4gKyAqDQo+PiArICogSW4gdGhlIGZpbmFsIGluY2FybmF0aW9uIHRo
aXMgd2lsbCBnZXQgdGhlIGV4dGVuc2lvbiBsaXN0IGZyb20gRFQgYW5kDQo+PiArICogbWFrZSBz
dXJlIGVsZiBjYW4gcnVuIG9uIGdpdmVuIGhhcmR3YXJlK2tlcm5lbC4NCj4+ICsgKiBGb3Igbm93
IGRpc2FsbG93IFRTTyBidWlsdCBiaW5hcmllcy4NCj4+ICsgKi8NCj4+ICsjZGVmaW5lIHJ2X2V4
dF9vayh4KcKgwqAgKCEoKHgpLT5lX2ZsYWdzICYgRUZfUklTQ1ZfVFNPKSkNCj4+ICsNCj4+IMKg
IC8qDQo+PiDCoMKgICogVGhpcyBpcyB1c2VkIHRvIGVuc3VyZSB3ZSBkb24ndCBsb2FkIHNvbWV0
aGluZyBmb3IgdGhlIHdyb25nIGFyY2hpdGVjdHVyZS4NCj4+IMKgwqAgKi8NCj4+IC0jZGVmaW5l
IGVsZl9jaGVja19hcmNoKHgpICgoeCktPmVfbWFjaGluZSA9PSBFTV9SSVNDVikNCj4+ICsjZGVm
aW5lIGVsZl9jaGVja19hcmNoKHgpICgoeCktPmVfbWFjaGluZSA9PSBFTV9SSVNDViAmJiBydl9l
eHRfb2soeCkpDQo+Pg0KPj4gwqAgI2RlZmluZSBDT1JFX0RVTVBfVVNFX1JFR1NFVA0KPj4gwqAg
I2RlZmluZSBFTEZfRVhFQ19QQUdFU0laRcKgwqDCoMKgwqAgKFBBR0VfU0laRSkNCj4+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvdWFwaS9hc20vZWxmLmggYi9hcmNoL3Jpc2N2L2lu
Y2x1ZGUvdWFwaS9hc20vZWxmLmgNCj4+IGluZGV4IGQ2OTZkNjYxMDIzMS4uZmE5ZTRjNTJjN2Fj
IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL3VhcGkvYXNtL2VsZi5oDQo+PiAr
KysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvdWFwaS9hc20vZWxmLmgNCj4+IEBAIC0zMiw2ICszMiw4
IEBAIHR5cGVkZWYgdW5pb24gX19yaXNjdl9mcF9zdGF0ZSBlbGZfZnByZWdzZXRfdDsNCj4+IMKg
ICNkZWZpbmUgRUxGX1JJU0NWX1JfVFlQRShyX2luZm8pwqDCoMKgwqDCoMKgIEVMRjMyX1JfVFlQ
RShyX2luZm8pDQo+PiDCoCAjZW5kaWYNCj4+DQo+PiArI2RlZmluZSBFRl9SSVNDVl9UU0/CoMKg
wqDCoMKgwqDCoMKgwqDCoCAoMSA8PCAzKQ0KPiANCj4gcy9FRi9FTEYgPw0KPiANCj4gVGhhbmtz
LA0KPiBDb25vci4NCj4gDQo+PiArDQo+PiDCoCAvKg0KPj4gwqDCoCAqIFJJU0MtViByZWxvY2F0
aW9uIHR5cGVzDQo+PiDCoMKgICovDQo+PiAtLSANCj4+IDIuMzQuMQ0KPj4NCj4+DQo+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4gbGludXgtcmlz
Y3YgbWFpbGluZyBsaXN0DQo+PiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+PiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2DQo+
IA0KDQo=
