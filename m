Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2814679369
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjAXIqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjAXIqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:46:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8910A36FCA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674550005; x=1706086005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+UbAnZXFoZE5TQ8F4AdGXw9U+0My9LLCfeRV8vFQrRg=;
  b=p2I09vCBzHDXUVUQabQybyBTy9q/CSIgxjfjCr3/Y7PzHSl7os5eqqBk
   30iX0kveSALtY5ZuOvxbD7BEp/aH2pAzunc8VdLkZmXAsqjnwsn98nkoj
   ThZPaZZZB7uxw++tNWMyRqOtt4a4oR/iL4z9l+weG6YQ4LK7fwAsUbKnF
   9Af1urbUevmjTqqG9ilfH87YKjAugzjYa5i/q8DcASDrFx/3a4rO1R7hM
   iRTMmyX53ZyHjvOxtX/USRrw4XzFUGPo8bYsnLpXnBj1Ire8FtLGPMvDu
   i1CFPWsi4QWlCZ+ovNuBHcKGcq+oa+BZgw4QZZoY2JjfkTEWTuzBJ4lnM
   g==;
X-IronPort-AV: E=Sophos;i="5.97,241,1669100400"; 
   d="scan'208";a="133729962"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2023 01:46:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 01:46:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 01:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLGLOjgtMl12Bohf+qL0QH0/cnIPORRZJ0fNy7vqsDR7CckUE0pru1JTwna6BOCNXPE7hOraqYmieeQuvmyd3qPZru0pPFTd+f1ZJ79atOFHG79/wT5uCUSYbmMcSshqfewaoz06ec/6YYXhKmdjEBhNPYO8oNzTBKY3REDUkWBAziYHLqk/au5+PKo3d4G3a/PPvCoDC2W5StnDUW4+6UrW3cMcOcJGWQW8KTmSkY6YTCg2cMvmw1WlwGTdY4xS/p9PsHPSGgxD1HenhkUpuVNE+qI9l/pz2sZRI7MOvr0wZv7laN6tQ8zFvzCwMq39mQdmUXTN6O+JsSL6tkz7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UbAnZXFoZE5TQ8F4AdGXw9U+0My9LLCfeRV8vFQrRg=;
 b=kMcKDqlO7y+pEmO0g5gQ9mGLdSuZPor8DeVgsAClNLo0L4//Kof9sF5l7CxLCUaQSxp4qvoRbgujnfXdsiHgzqn5YkNiccbKJhMc4oSj90oTRrFOHga5wqX+CGI9hLSvq2uhThwuydnJqwyspQi9ENXxlE0NoaqDG+jK6Fe1KSEgba0vnp3lnV2saNAfIpNLuRVINGXttV1MF+bhEA5PwUXFmEB8QzzYmbCa+t23xZRcrjvpW09u7D+NAAmngB13vMXgPg88HYgfRsp1+YjQpqFcTuwIAu6MmxWz8o6jzz5MRqcCjb9I0gD3oktNZeWxOhSYO0MOCQXVpQOIMjFM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UbAnZXFoZE5TQ8F4AdGXw9U+0My9LLCfeRV8vFQrRg=;
 b=YO0ihx1LNqspZSFFwBlh9oI55TM68dPCzrum52//mtOVJFs+1nwpWEvAEvnvjLVEgYB75i56CkjurHP/YXw4CXPFd6UEnaF4Msa77NiyNSLMNz8Fjs7nMal8WA6YLzOuSPFV/2ovMdNrkwxFHJ4EUw3tNLLnje0ZcKCTQh2wsec=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 08:46:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::3758:fd2d:5bd1:9758]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::3758:fd2d:5bd1:9758%7]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 08:46:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <me@linux.beauty>
CC:     <lchen@ambarella.com>, <arnd@arndb.de>, <heiko@sntech.de>,
        <lkundrak@v3.sk>, <robert.jarzmik@free.fr>, <sven@svenpeter.dev>,
        <zhuyinbo@loongson.cn>, <briannorris@chromium.org>,
        <hasegawa-hitomi@fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/15] soc: add Ambarella driver
Thread-Topic: [PATCH 06/15] soc: add Ambarella driver
Thread-Index: AQHZLv3IyzxhA+fjH0GH7s70/n+1xK6r4zOAgAFaRoCAAAUzgA==
Date:   Tue, 24 Jan 2023 08:46:41 +0000
Message-ID: <578e034a-d75f-3b50-76dd-8eb90a127258@microchip.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-7-lchen@ambarella.com>
 <bc50c6c2-bdfb-0b6c-0f89-dc8cfe845202@microchip.com>
 <87zga8gww0.wl-me@linux.beauty>
In-Reply-To: <87zga8gww0.wl-me@linux.beauty>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CY5PR11MB6138:EE_
x-ms-office365-filtering-correlation-id: d1d2f0ce-0542-49c5-8f5e-08dafde78377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: un81zBfH1nSabfjfQZHFCNKwpn5YHwQQsP3zNXnIQC7rVPGh01itBM6yuSnPCsyN8MgsQcMo6xgdph6mD4d+5J01P0nqizuMusDGVxsSMmQhm/sEdemOipwOKB/Wn56odI541WtWsdSq1NcjYJwwkAoIJBGKaFwWJEWD7v2WCAmbbHyucJVSoA3Lm2YY6abK3t5tONIqoCXWdYj8YeW16z82mnk7PQRE2YB4XPo8z+9AHxjOakSFIdo67Hy3jy5K/uzmVJlNjA5WFVvnTl59XZwyV9qvJwH673afBpUeh0PWzLWledwmsupYtXz59VCwzGuWUWnYrajCRaJKC6o2/Lp7PRP3eE+mjqis4AgBEB/42SqgLAVECrj1dJYClqIgrC/+ILaIzeC0euVW97W4P9OrgQFHrhdw4NvF7t+dB7j5UOJooMadCpAUSXkY6z5hqfliGBrAgj+2/gIFnQVM+mik7a/C3G+2eSBpIuCFVY7m8L8hwig2TEcljNQo5t0wl/FbB/n1jGw3Bcu2zeMgR1w/HyqC3+sgtB9AU45566xXfRrdPZpjrFrpFZsB8/rqsL+Afknm1hDLWIiiZX5T1WPvDktdzHIYAoZ2SOElt5oXgL3i0CmNuh418LJxqOdAaMQmh7+ATN8HqXXRNFupcJOJ2fx0cLTGMCFXbVbw0cdaqdmhx6kU7FhjH6OxUcNVoThWECKlCyrLiW02Cw6vHFQpUI8LzHpcjtBvDLdKB8xgKUDhs4I74GSFqm/i07YCVcnYVPYbNfdB2nHM9HHw7tmWPSURLrAOU3n1Ss1Fe8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(36756003)(41300700001)(91956017)(86362001)(76116006)(6506007)(4326008)(71200400001)(7416002)(66446008)(66946007)(66556008)(64756008)(6916009)(66476007)(4744005)(38070700005)(38100700002)(122000001)(8936002)(6486002)(5660300002)(478600001)(2906002)(54906003)(31686004)(186003)(316002)(26005)(2616005)(6512007)(8676002)(31696002)(43740500002)(45980500001)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUprQkJZU0pnK09MbmlULzRzL2pKYUpFZHFXK2YveHpvcHdXQjFkY3FQUlNH?=
 =?utf-8?B?TnNIdm15YWxwaDNldGNGYUF5dWl0QUlsbEc5SUhHeTZFV1hZYlVEeUVoZ2Vk?=
 =?utf-8?B?cms0S1Budmx0R2M2UU94RlN2Mm5FNWJ5eEp1b3ovK0N6WS8zOUVMVkVQSUFC?=
 =?utf-8?B?MG9TSnZ0SU5zcG5rdUsrclVhQ25kUWhaZXYwdzFDSTlJVUR1ZlVNM0N2MktJ?=
 =?utf-8?B?MXc4WTE5YkMwckNNaC9jdkk0YWE2U0c1TlRTQTdXZVdEQTM1ck5hbWtqbjlj?=
 =?utf-8?B?eVdraDcxbHNTQUxmRnFCa0wvQzFwNG44a1lCQTF1UVk1WTdDbWVIL29DOFB0?=
 =?utf-8?B?VjREVDBKVHcxUFZLT0lTRTdBRkxvOStPcm1mNE16VU84aWxEOWZPeGhKcmli?=
 =?utf-8?B?UVpQaFZJNjdWRnF1MUQxbmtrVytSaThsdEsvK1dRTnB2RGJIWWIvbTROWEZn?=
 =?utf-8?B?eUt3bFVsMkphUTc0WWRNa2dQcHZLQWdkak9Tejc0TVhta1VyNmtHUDdVWEZM?=
 =?utf-8?B?ditydmdOdjJlOW1IRU5PWEZhdU5uRnRDUmhwVitkRjJLTnRQS2p5eGQ2MTRE?=
 =?utf-8?B?SDVCd1hpdEg1dGxmMytpSWNyQ21UMjNVTVZOT0pnb01lYi9lQ0pIZm9uQU9G?=
 =?utf-8?B?aVBjSDg2dU1sZHRwWGpBODRYQVdvRXVLeUdVbEx6dFRjQ0FnWUxjaVEyNFNT?=
 =?utf-8?B?V3BDOGVwMTh1dWh1NWVVd1ZMSzVYQkRxRXRJTW9jQkN3L3N6OVpMaXVDL2JF?=
 =?utf-8?B?TllWVmJldnJiODRNcHpUZ2VCUVV4SW9UN3RRblpsOFJFYVgzRXpacEdXWktp?=
 =?utf-8?B?SnlTaGNFQWMyaEpqR2dHMy9nYmNlNHpFUHpWMkl1YmFJL0o2cXZoZllCTTh6?=
 =?utf-8?B?YktxWGFOQzZsK2U5RXMrQ0paZk1Ua081Z3R0K1hnSjhJQm54ODNtbXhoWG1B?=
 =?utf-8?B?NW1JbWFPdDdjK0N3Rm5weFM4d3VQdXAvb0hJZ0xPTnVDMEZnekI3MTUwMVU3?=
 =?utf-8?B?N3Q3bzRYNXh4QXVmWmROMTdoYlNOeDkvYUNoYVZVTDgxS2JvS3FxTHVKZklv?=
 =?utf-8?B?bis2T1BuK1lRdkRLSjlGV01tMU0vck8wQ2V5bkVLMzdrak55Ti9TV1ZyaEVP?=
 =?utf-8?B?ZkVOVEh0Uk5KYldCNnVPRDl1MWJuRktPVE1lL0FyRlAxclVlTGNZSEk2T1NH?=
 =?utf-8?B?TjRHSzZKQ28wMHhuUXY0WGxJMElBREg3cXJyMDlIa3VMc3lyOXRTR2pPbXcr?=
 =?utf-8?B?M2s5OUZPNVRNQjdpRzdDRkNBSHBzVTNFN0lpOGZjcE14eG9Yd09URDZjTnRH?=
 =?utf-8?B?RkdiS1dqYWo3THdGQVZ2ZEhuUXhPemtpaEphM1g0bHFxN0NlcWpPUGRWMmVU?=
 =?utf-8?B?Q21rUmQ3Znk3Mzd6WFVUalkydE4vcTVrUkJBaGVDQzhUYnI3ZTllQ0N2eUxs?=
 =?utf-8?B?d1lwYlVBK3JvekcvTEozNEM3NU8vNUhzYzlFdWhpek9CSEp3NldPTzNLdDlx?=
 =?utf-8?B?a3NaUWdWVWpid1BOL1RFWXRCNC9qdzJqSTFNeFJ4NXV4WWIxdGkxVTFabGFz?=
 =?utf-8?B?OGNrRkVab2tHRk1ueTlRdGl6VERkbVIxOTd6RzN2Y0x5aDVCdFFTelAvVDVo?=
 =?utf-8?B?T0FnUDFLcTJTa1BFN1N2YUJBNWxibjNObm5YdWpRaXEyTGV4U1pVeDVLcld4?=
 =?utf-8?B?VEEvbllHUUZBRDIxcVN3Tm9WaGQrWlh3YkRubjRvUFB1ZjlLTGlRQ3FRTnpC?=
 =?utf-8?B?WklYdU4yaXd1c1RvcTY3TmE4ZzJqTVVWZHhRNXFaU1NCMXNrZTcwZnhjY2s5?=
 =?utf-8?B?Uk5zdjc2aFFTMU5Rbk4wVUNuOE1uUXhHSEdFUEZuTnRkdFZxaTc0cEVld2FX?=
 =?utf-8?B?eWhTS3F5VEpWbFdWUkJldVVhM1Y1WXVCazFTcEd5Y2paR1YyRVg2MnNCS3dG?=
 =?utf-8?B?Qy9LYmV0RW5aYlZXa1NuK0xFUThoZ09PK1BJbWpScjQ1TGtsTnkwTnZYWTZu?=
 =?utf-8?B?U09CRTZBaENXUGx1OVBhYXVRQ3V3Vyt4VGpLYTJuTUp0UndlUGh5VHRaYWhB?=
 =?utf-8?B?UVNDQmg2MlYvakpWTUJEQlBLVVFBMDB2WnpDTStqa1ZIUFNLK01FaHVKNmJm?=
 =?utf-8?Q?sTHqLmcnGRbW3zly2pso5s1Aj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CF9EBEE6FCA4D4793D2013DDBE020BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d2f0ce-0542-49c5-8f5e-08dafde78377
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 08:46:41.0645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIXp0ZRBS9aRZdUAtvBuKxpRTsYVml6Gp9P6ij0rBs5NZwsHSfHWWrrFjAuYBbxrhKQYbsabvle9kWtOsfIvnBMz8T8YlEhhMnjCRuyGLO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5LA0KDQo+Pj4gKysrIGIvZHJpdmVycy9zb2MvYW1iYXJlbGxhL01ha2VmaWxlDQo+Pj4gQEAg
LTAsMCArMSwzIEBADQo+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25s
eQ0KPj4+ICsNCj4+PiArb2JqLSQoQ09ORklHX0FSQ0hfQU1CQVJFTExBKSArPSBzb2Mubw0KPj4N
Cj4+IFRoZSBzdWJkaXJlY3RvcnkgaXMgYWxyZWFkeSBnYXRlZCBieSB0aGlzIHN5bWJvbCwgc28g
aXMgdGhlcmUgbXVjaCBwb2ludA0KPj4gZ2F0aW5nIGl0IG9uIHRoZSBzYW1lIG9uZSBhZ2Fpbj8N
Cj4gDQo+IFllYWgsIGl0IGxvb2tncyBraW5kIG9mIHJlZHVuZGFudCBub3csIGJ1dCBJIHdpbGwg
dXBzdHJlYW0gb3RoZXIgZHJpdmVycyBhZnRlcg0KPiB0aGlzIHNlcmllcyBnZXQgbWVyZ2VkLCB3
aGljaCBhcmUgbm90IGdhdGVkIGJ5IHRoaXMgc3ltYm9sLg0KDQpZb3UgY291bGQgbWFrZSB0aGUg
ZGlyZWN0b3J5IGJ5IG9iai15LCBhbmQgdGhlcmVmb3JlIGFsd2F5cyBpbmNsdWRlZCwNCmFuZCBo
YXZlIHZhcmlvdXMgZHJpdmVycyBjb250cm9sbGVkIGJ5IHRoZWlyIG93biBLY29uZmlnIHN5bWJv
bHMuDQoNCk9yIGVsc2UsIHlvdSBjb3VsZCBsZWF2ZSB0aGUgZGlyZWN0b3J5IGNvbnRyb2xsZWQg
YnkgQVJDSF9BTUJBUkVMTEENCmFuZCBtYWtlIHRoZSBhYm92ZSBgb2JqLXkgKz0gc29jLm9gIGlu
c3RlYWQsIHNpbmNlIGl0J3MgYWx3YXlzDQpnb2luZyB0byBiZSBidWlsdCBpZiB0aGUgZGlyZWN0
b3J5IGlzIGluY2x1ZGVkLg0KDQpUaGFua3MsDQpDb25vci4NCg0KDQo=
