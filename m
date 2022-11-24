Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3F663761C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKXKUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKXKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:20:33 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB60114B9B;
        Thu, 24 Nov 2022 02:20:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpT7Omw8qYqiyji6BOhyjmfJWnxXy7NsBL96WF/ynBwLISHd+nysHm9cp138Rv4H6vqoOocWCwNjXfE1V8/10cIlR4W/xI760y2tcih1CwqSbXjw9qjq26hc/42vIyqAjE6+cD3U9hT1SV3aUWIkxtsxznpnryskNt3e5xYY52ECmXUpc1mEYcnyx9rz0ZGJL6ELJZj7wENlAxIySmo3mP0H8F0Lyy+aa7OdMwezZEsY3byZk/NPwpDVatQODejjLzufL6FKzhHOWjEfe/FlwBDmmn4p1YC8DSPT5EEUfApFLvCyuoC1czMc6L/SgVawXQzMwB004CzM5mi1j7pjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjlHOifstUTT38vilRD6jatYXVAY3hYEPV019QkIZvI=;
 b=UlDfjM3pjyeLhR1T5MSNnm8muWsJnugJV8oT48isxWphkEYsfesijz2olvAftTpVM9FDr6XxVvF6KoBRw+AKTGi+AaEBA8YLAW5ugWttBzVmkwmNSUepvddNLmp3hyjKzFemieNDRHMwxM6UlKirl12HpA/9yPrmMAKYzFBn44/Oymyrgre/mSZYRKIh8uskH2vI8Lk7VxwSsDFJQsr6oPDBaC6JT+JNj88SQ3oFJZ61C5eidwZ2KcScQILmc+6QP4A2V8b5+Dta+0P3bVOPIoOhVV9cYKUXIz/An+nAuMesrMNqxZtNTynk7xyGMM6tj+Bzn70+A3NefdUiiZx0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjlHOifstUTT38vilRD6jatYXVAY3hYEPV019QkIZvI=;
 b=wu37ShAtTqz31OBLWhQ6qvZcyRdsszbaDS+xqS1PVh7Z1LWznFkr6LNymYFjpzDuXnXsJyL5fbzjZl1II3VIBtJkkK80kRou/CrpxkcGc0wBLyoJ8+ksZrz0cFq0X5YH3ijGcAxM+yteYhWi+KYmAfYajRj07LWXdkUWZYduQ5s=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BN6PR05MB2961.namprd05.prod.outlook.com (2603:10b6:404:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 24 Nov
 2022 10:20:30 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::bdb8:4f57:660d:2cf0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::bdb8:4f57:660d:2cf0%7]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 10:20:30 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Leo Yan <leo.yan@linaro.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH] perf symbol: correction while adjusting symbol
Thread-Topic: [PATCH] perf symbol: correction while adjusting symbol
Thread-Index: AQHY/yTycW4kyMOr0kWvaP/KWqc2M65N1g2AgABknYA=
Date:   Thu, 24 Nov 2022 10:20:30 +0000
Message-ID: <ABE08F8E-516E-4FCA-9F8E-3723BC86D98D@vmware.com>
References: <1669198696-50547-1-git-send-email-akaher@vmware.com>
 <Y38+NGjF1tZNHkwr@leoy-yangtze.lan>
In-Reply-To: <Y38+NGjF1tZNHkwr@leoy-yangtze.lan>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.61.22050700
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|BN6PR05MB2961:EE_
x-ms-office365-filtering-correlation-id: b8080515-5f58-4e6a-91ee-08dace058399
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/A4r+e5hesQruxiYFJP2ijgc1KJl1YZ6Y4tQLKRT6nv28TsIIdJhKQ6BkISTz+cw20zuk9JTavTM7DIKO9nsqTH8t4O+odor8nFvaXhmLksQne3s/GpwOaMC++U3MMRHoRdp8LV/pD7jZpaiYiqp1G7erv/vlecqXZbHVnK0lR+/bQ7vXqjXHKns6/3eoIPt6cnqYTlB/CsZKCZyuUY1dCgN9u8tUD3aFkr2XBIxXpJVtLp69fbOqIGL9AqqqzJ6f+tzwU/FUmGoyHrzfKN2ouRu52jqqXiwD88a8Lc7hvawLBzMM5R6iIRoxWjPQ8gI+VAUW0ViMuINP9NsxKBVKbrFuYiDr8prt1TL0nua54WZ4X9ELgCiivKuRkQz6VWuIY9HUipUMTXCg4jLoQQUEzl94hu277TF+BcNQwzJ1kAI9/50uMazb/gVsvTxSZK4q1KWHQ92yzMqHkBfLWSUcJOBEITx2iTzq6nBn6XQ7iaLuYTZGUQlxzYtADyd2zKhrSC7jZl2nIyeb6Q1k8HRLB8JQeCjOdAijcPllhfcJ3FwprSEJMKoxEVqO3Gp9S/7cPrlER8w20qRO6+X94G9T94IwUvQZNRkuXlyGY8/KkfNubnCzZFgFWKQcSfYYCDTNRgQCheOlZXEv2dyBRcG/0JX+PnTnFSq6tEOKegU1NuaKdL2DznfIbLCj0uDeaG8lnPsU9HqCDd/k1o1BKKDeKHK5AVUipOBS30hFp/TivXFZwtSMOAhfYQxgOwNMLw+37gaZhUhoZ/mDXJaCnrRB67IWB+CgOhVmgDC4chvsA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(186003)(6916009)(316002)(71200400001)(54906003)(26005)(107886003)(6512007)(53546011)(6506007)(66476007)(4326008)(76116006)(66556008)(5660300002)(122000001)(64756008)(66446008)(8676002)(66946007)(38100700002)(91956017)(36756003)(478600001)(8936002)(7416002)(86362001)(4744005)(6486002)(33656002)(2906002)(38070700005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVkxaU9ITEVsbHFFY0JlQzVJSXZsYU1zdU1PeHpKeGU0Q3QxUW1tZEtLMUIr?=
 =?utf-8?B?NW51YmMxNEh6aTZhNzZ2UnJGeGJHWW1oSktyUEpJR3BON0NIYmsrQ2tmL2xz?=
 =?utf-8?B?cHN0d0tCL01SY1dwWDZmaTA5cjRhZ01iTnBWOGpMUUZaNDh5S0ZxZk1TMHBJ?=
 =?utf-8?B?dFdXeWFhZURmM2xsZjRGSjNYU3JiYkNaSHdsdmc2c0dLL1FaRXRpckNtR2VD?=
 =?utf-8?B?RWpOVXVaQ3J1Z2NQRFM5Y2lhQy9McFlmbk54bkdZRGlQYWtsVzJHdVlzcUFi?=
 =?utf-8?B?ZXJDQmo3Ky9jaW9JbTFJTTlVeVQybkhFVFBtUVN2RE51QzNmeTU0dElmQ0NJ?=
 =?utf-8?B?c1U3RkJQdUJvai9mRzIyOHprSXNuZkg2d094Zks3UXppYjNZaVlIMjFLU0VH?=
 =?utf-8?B?SmdraWFFNHFwWHdSRkgxbFhSbURCc2phUzBHMHFvbG1jd1h4dG9YS0dPemsr?=
 =?utf-8?B?UFpXY09vbmRiSEFVNHRlWjduR1NTUzFRR25aWVNRajBSbi9TblhzVDNPUTAv?=
 =?utf-8?B?ZDZreGxOditoS3VQbTYyQXNlVFo0bTk4dXp1TFh0S3ZrOWJnUFByYUZYT0Vy?=
 =?utf-8?B?Ym1VdUJId09nVmp5aXJ0eGZVQTZIN0p3dU5IbC9DanFOTGZPSzY5V0xVcUZv?=
 =?utf-8?B?WWtSWGVCOTl1UGpweVNnWXNoemNLRSsxVzVmek9SOWl2V2pncERaak5TdWtM?=
 =?utf-8?B?SGdsN1ZnOGNmeExMSnJvbDF1VzRrYUgrVEYyUSt1K0lFWEZRVWlNdktiaFpu?=
 =?utf-8?B?STBXQXFqblRWc2IxRjZsQ09FZDFHNzVYcndldDQ0QWZ5bWdNZmZ1MlZPenhX?=
 =?utf-8?B?cFp1RzREclgzRkZ0Y2JFQlNoYmdaM3dONzJjOFVCaWJhYWxNNS85KzhKM21P?=
 =?utf-8?B?aitDQmRPUk01T0ppait3bC9DNGFaNnBDOXJjbUZXa0VyNmRMM1E3OVJNU0du?=
 =?utf-8?B?VXVqd2p0UWNqZEtIUjNGbkZrNnpUQWpvM0pVZDhVOXpVVEdScDhQTHBkNzZv?=
 =?utf-8?B?VkRFQ1FOdFd1WDNRRTFkQUkxVW9XK0w5ZVI1ZXFDYjJBQTI5Q0huVFJSM3JI?=
 =?utf-8?B?KzdubkxpU2lnTVBqWU14eENEYkVJYUxrUWp0aUk0c0xvTzd1NStqdktkdC9I?=
 =?utf-8?B?MkRnVGk3ek16MFlzVjVpSUtidXA0RFpoTzNNNHdzaDJaYlJVa3doTHhTMC9s?=
 =?utf-8?B?ZGFpeXB5ZTNHb3JLMGtWRURSeHpJL0QveEViUUxPbE15YWpJTVB4MkkvWmhF?=
 =?utf-8?B?cVlhUU1BcTdoZkF1SlQvRTJlaEJjZEtDZWxISllWcjNGNkNKL0gwejgxV291?=
 =?utf-8?B?TzZVUzJVL0hsMW11QWFZU09LajgxNU9BQWhiUEtodUI3SndjZUxvbmFwdElG?=
 =?utf-8?B?VHpLVkxzWGp6WG11QU5YcE14N1BBZWZ2cHhPTTl5cnBSd3R0SlNRV2FnQlpE?=
 =?utf-8?B?RVd4aGxyVjBScjdnZ3NldWdzMzBVTnFvMHRsYk1IRElNQlpjYnJqVTMyRjh3?=
 =?utf-8?B?akhGa2g1Myt3RmFBYnpCMGdhWThIOWxhZGQxZFlrV3c1TFZadGU0bHVtcnBH?=
 =?utf-8?B?S0M0MHJtUkZzQ2gwNHh6VGlubFdiVWh6UG0yUGlTV3FielR4a2xEdVJlaVBH?=
 =?utf-8?B?Wm9UVmVDazVDQyt2SHFYbHdnd2JHUzhSYURXeXd1NFlMdmMvcHl6SG00UVNn?=
 =?utf-8?B?TU0vVXBkVmczTnBOeWlhSERORlhXV1ZVV0VPOUhMU1NkeFBtRyt4NmdGM0Fi?=
 =?utf-8?B?WTBYSkhIMEM1MHp1U3ZZMDFZQTVCYTBsb2Z3b0hIbEY2YldvUWluNHRiNkdh?=
 =?utf-8?B?bGJvZ0ZWTy9IYVU0YXFTeTJ6Rkg1TXRBc2J0YTM4TlErQjN3NHpHWGM0Y2NM?=
 =?utf-8?B?TjdJZ0V2QnQ2NFkyZi83UENTZURnbVJjWk1WUjMzYUUwUVlYTEI5R3RlL1JL?=
 =?utf-8?B?Yll6L2I1a1NRUUJwL0ErTTNlc25EQjkxUE1mNUs0UHRWVFhXK2ZRWDVRN0dl?=
 =?utf-8?B?WlJjYU5yanRRV2Y4Rk9odzUyVEYyUjY5bEd6RjAxT0hZQUxRM0FJVTJpVHpw?=
 =?utf-8?B?NlVnZ3BRL1YvcGEyVmdxRTRHcVU2eVR6dzBya1BPUEprMVBqb1V0NUhLanN0?=
 =?utf-8?Q?/YaLhu2IqcIE6SOXRv09EdIZN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <910A74EA0D51AF4B950C01C4ACDB4A6B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8080515-5f58-4e6a-91ee-08dace058399
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 10:20:30.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ob2Fg/Hux/zEtGZD0n6iPNrzdxxEb5GH45oCcgzctNHMEfM75HFCZef7xwbOTQpUIIzCa332NknbhizZ1ktcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2961
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQrvu78+IE9uIDI0LzExLzIyLCAzOjIwIFBNLCAiTGVvIFlhbiIgPGxlby55YW5AbGluYXJvLm9y
Zz4gd3JvdGU6DQo+Pg0KPj4gRml4ZXM6IDJkODY2MTJhYWNiNyAoInBlcmYgc3ltYm9sOiBDb3Jy
ZWN0IGFkZHJlc3MgZm9yIGJzcyBzeW1ib2xzIikNCj4+IFNpZ25lZC1vZmYtYnk6IEFqYXkgS2Fo
ZXIgPGFrYWhlckB2bXdhcmUuY29tPg0KPg0KPiBKdXN0IGN1cmlvdXMgaG93IHlvdSBjYW4gcHJv
ZHVjZSB0aGlzIGlzc3VlPyAgSUlVQywgdGhlIHJ1bnRpbWUgc3ltYm9sDQo+IGZpbGVzIGFyZSBj
b3BpZWQgaW50byAuZGVidWcgZm9sZGVyIGFuZCB0aGV5IGNhbiBiZSBmb3VuZCBieSBwZXJmIHRv
b2wNCj4gYnkgbWF0Y2hpbmcgYnVpbGQgSUQuICBTZWVtcyB0byBtZSwgeW91IG1hbnVsbHkgdXNl
DQo+ICJvYmpjb3B5IC0tb25seS1rZWVwLWRlYnVnIiBjb21tYW5kIHRvIHN0cmlwIHJ1bnRpbWUg
aW5mbyBmcm9tIGVsZiBmaWxlcw0KPiB1bmRlciAuZGVidWcgZm9sZGVyLiAgRG8gSSB1bmRlcnN0
YW5kIGNvcnJlY3RseT8NCg0KV2hpbGUgY3JlYXRpbmcgZGVidWdpbmZvIHJwbSB3ZSBjYW4gaGF2
ZSBleHRyYSBzdHJpcHBpbmcuDQoNCj4gVGhvdWdoIEkgaGF2ZSBhYm92ZSBxdWVzdGlvbiwgdGhp
cyBwYXRjaCBpdHNlbGYgbG9va3MgZ29vZCB0byBtZSwNCj4gdGhhbmtzIGZvciB0aGUgZml4aW5n
IQ0KPg0KPiBSZXZpZXdlZC1ieTogTGVvIFlhbiA8bGVvLnlhbkBsaW5hcm8ub3JnPg0KDQpUaGFu
a3MuDQotIEFqYXkNCg0K
