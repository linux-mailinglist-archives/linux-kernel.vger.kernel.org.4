Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50345BA017
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIOQ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiIOQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:56:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B709910AA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663261001; x=1694797001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BThzje0XGv3cfJC3lq/eOosE7rHgQeW7GuI2s30mkaU=;
  b=cpHk3nxMlSMzNWeBr0izscBQevXtGaPZ0GWiE1ibxXw4cTXMwco+l8bq
   4tjYVJ7oR5GbYx/oVmLawdZVyecCpf9zVW4h+V+GmTwoDHQgteFc9P914
   JG+XdF9zrB8+hd5rT+4xfsbwdARspOpNsK/2OrBPBrALjqF5I0K6ptl0v
   bp9tO+6z8jpTbS3GBrGHBesdzuBLLU5c1FNu1fMZvjMfbB0503/ls7T44
   6XNXUQehUJAeGm2b60o1oimiwkjAtJgpAPR77CLdiXgmicLf2u9Ahb9Mq
   AbHfgwBcilTSyBj60GfY2uZ8ReJb4QZslq0ppDu17aR0EngX3p8xXD6Sa
   g==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="177351035"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 09:56:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 09:56:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 09:56:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3N+NUkBwghVdbb3EDZZ2L0sj6PKEOtQIqMRIAxPKvL+Nj6P8W8Q1uLNNClDpp9pKGGdWV4oErVhFy8ggxwkLy7ymtZcuYk4F+uWlOQ7NNeTVm6SXgJjOodVQUD3EpWBJGEiM0CYLIq+A0l2L/K0/QXYPUyj0h2e0Eyb5+f8HgnP7FzfnVDMfkyWD5Y9ei06CdHiF0g/vj1H1+YcFKUWV5sCrylA5LTSn6mMhuw0X0eRvIY9+BgS0q8mcdXsYeaEWbOoehvYGTIVLE+KMRUluuE6zrmpFXA43+3pdijQj/sZyVP2HkQrlUKzrd8HYFRHAngfqKTzRvLHkjZombh9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BThzje0XGv3cfJC3lq/eOosE7rHgQeW7GuI2s30mkaU=;
 b=lS0ZRbWimmRPMK4kG9gdO1BfMtu8/2P9H8B34EkAsAxIzMXyBWZx8qwkAXuJUjKRFiE8O5SZAIoBAfiiCZjBk8EImbIRDvJcHozQ7kAoJt9NIFehMNeVWeq1baciOkkUBXSwFMeWHNKlLp15lDT8Qoi5Chjcb7GJp+DnR7B8+C1OxhiMEx3EUeFpFOEFZnm662uCri/q749SXA1CVrato78u4PKLJhMr3IdOymZvxWZuhdk2i0U87JoQWU2sDdcFw2dDBvQS8c1HFX4qR7gNz7QiQe2j5O14TTKUU07BBoOOrDwxGDzu4l32N/eTll+jza4hBmJi+iIgf35kxZHfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BThzje0XGv3cfJC3lq/eOosE7rHgQeW7GuI2s30mkaU=;
 b=cFRTp8SBQDDaZX7uNntoPTrK7L1Kp6TuJLMEw+FtNpg/FlP7wZ7ujywfTIM9GgvgdRUA1MZ3ZgbP8ZXcf50vnSeTJdpbh/YGKpgDahvBFWwOpcvOUlXwyrArqbqpZ3QlIGjM0kod2axcvaZ8BgJ1Hw4oOyKIJiw3AmYFMkw8q2E=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5280.namprd11.prod.outlook.com (2603:10b6:5:38b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 16:56:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 16:56:36 +0000
From:   <Conor.Dooley@microchip.com>
To:     <abrestic@rivosinc.com>, <palmer@dabbelt.com>
CC:     <paul.walmsley@sifive.com>, <coelacanthus@outlook.com>,
        <dramforever@live.com>, <c141028@gmail.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <atishp@rivosinc.com>
Subject: Re: [PATCH v3 2/2] riscv: Allow PROT_WRITE-only mmap()
Thread-Topic: [PATCH v3 2/2] riscv: Allow PROT_WRITE-only mmap()
Thread-Index: AQHYxJMWnJEOeg8890KCWf/MA/STJq3gvxUA
Date:   Thu, 15 Sep 2022 16:56:36 +0000
Message-ID: <d46d6340-b985-49b2-babb-0082f1759c7b@microchip.com>
References: <20220909212731.1373355-1-abrestic@rivosinc.com>
 <20220909212731.1373355-2-abrestic@rivosinc.com>
In-Reply-To: <20220909212731.1373355-2-abrestic@rivosinc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|DM4PR11MB5280:EE_
x-ms-office365-filtering-correlation-id: 2f53d54c-1b11-45fe-57a6-08da973b4067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELf2VC9KyjnFjDFPZ5NHhDgScLVIjs92qK+ub28e20o1KSUB91dg10i44o00HR8j/BLtWwE+K0QLXQCLKb57qu2QisFvjqF+Ck7StiaEb+vZ7t1rDiROZFlGvMV1oQF8iivNDm+7MKatRjcsBn/tDS0zhgdqd694vhkfQ0wNFiYevAH9mnd0ObFbkpz1e+2noy4S25jZaoPQUR6Eab08OMRm1JO3gtNz277n36r81RPhy1Fkgekkj34t0Vofn043jgRP1THvoQ/ImqTEGxZyOtc/2qKPgx5f2akVCbZtzwtDsf70WtA0lbVlohcZZiCUWWc6L0e0e5ziyVgSLVZFHdPhCneFURYn1RPpleEdzDd8fWOxlDA0NDhjFUbpJbYwyPqP6nwAy7UfLYgLZtpnioTk2C05tq1r2Fk2B2B6V80qErNlDG0IE2upcEPwb0L16+IBE+PtP1iKHCddhb++y+dTMMpeuw+bPVY5eXSbwCe0RXiCs1C3JuG2tq3fCEMAJBAQ01OGRo4Y6ugeRsAU7ALzVodyAAaw3BWyvfTI6bE+NdFwXY0Lu39jtDDbns2xytU/lETOolLqPKgfmwVMlbFGLJmQ8jYC6zVExFeIqTQbjYztGwxmkLEXaHk0mDgwWuXla4GqS3nsXq9878/xCjgNJEg9mTFGqkqSHHU4xmWxfrtUH92Q1+zHIMiV6q51mwbBp1FhXa+f9CFewuLhg0coBsjV2iQbGSWsjKMctkMzsmk4Q2MkNrXgLbnbC2NwYaeftpKCdVIL/LoMdrIAcOyHjctuucZ8ISn+8STdEvhWjHmT6rzNYhJ6E2HwcUgr0Ys4K9o1ugAUlZjO3MZefWMfLppu4X7jy3+gUvXOUi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(86362001)(41300700001)(8676002)(2616005)(5660300002)(6512007)(76116006)(91956017)(4326008)(8936002)(66446008)(66556008)(66946007)(66476007)(26005)(54906003)(316002)(110136005)(64756008)(31696002)(83380400001)(53546011)(36756003)(186003)(2906002)(6506007)(38070700005)(6486002)(122000001)(966005)(38100700002)(478600001)(31686004)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OCtUclhKUzltQlNZRWdYbFhoN0ZQZzZvWlVvMEVwcjc3akR0VERoRDcyaURD?=
 =?utf-8?B?ZWZnZ20wKzJZM2szS25ZeHpEZFRyckVITEdqZDRHRDJBZ1hDM1ZZZ0hMLy9v?=
 =?utf-8?B?bWhuUTIvd2JzSlVhOFAxcm1RZmlFUHdjZWYyOEdYcWdpZlVVQzB6ZlhCaE5z?=
 =?utf-8?B?OWRpd0RKak1ybXF3RmhRSnVZdHR0azRUREdRS2FBbVhSSElJRzI0TlBlRnhB?=
 =?utf-8?B?c1ZBbzNjdUJidktDT281WUNscG1rNWtqVjQrd0o0ekM3RnZncmR1VTRyTmJJ?=
 =?utf-8?B?WWJrU1luMitRZVlIbE0xVEtXMzI4bjhIRVQzdWltT3QyaXo5RE83emMzZ2Js?=
 =?utf-8?B?TzFqLzZKL1NEanVQenJwSEhqV0RWbHpSWlRBaERjOWltcW9jZ2dtUVgwY1VR?=
 =?utf-8?B?NW83RkhmRmtUaFRiTGd5ZDFBSFNmczB0SlZHQWJ1VlNjQnFHOXo1dGJGWjNm?=
 =?utf-8?B?SDJGZTdwd3ZyaXNpR3E1cmZvTGVtU1duTzByb2RCYjlqSWVtVVhnbzJPdW1n?=
 =?utf-8?B?S0RWRXJKOUpyZDBtNzZyVlg5Y0RkM3FLbm9rT0FIdWIya3hxZjlQVkRmSnpX?=
 =?utf-8?B?OWtaS1o2ZWZqdVRDa0N1aVF6UlJmY0JKQlZQNXVMZWluNHBQbmUvNmhTRDRi?=
 =?utf-8?B?aUZOYVVLWWFObElqK0NhVktPL0ZOaFVzUnpJQmV1bmsySzRLTmxQcFZWSFNO?=
 =?utf-8?B?Nmhmdk1ic2hENm91ajB1VmZRenNuTG5kY0MvQkVmaEY5STRlbzl6VHlaekkx?=
 =?utf-8?B?Z1B4VGs1K0NoYnRiKzhQSmlBVVNBNmtGNW0rN1pSaGJlSjZCV3hLOVIxT0d4?=
 =?utf-8?B?UEprTXkya081L3lrRm1EeTVVQVVVV2xHYjdLeGhITnAwNkxNb3NrbEU2aGhX?=
 =?utf-8?B?dFZWQVRYQytqRW1lWEVqQWZsY2N3QkMzVFlVM2pMOFBWT29nbktoMWtQTis1?=
 =?utf-8?B?MkQ0UDZydE1KY1lCZXZiaDlrL1Y5ODBGSjNqODdPNTNMaHJ0STc0MGRvYXdT?=
 =?utf-8?B?cFNTaE55TklmSFlTYmNHMTNhWG1nM1Q2MXdpOFMzS2labTV1U3NnZktpcVIr?=
 =?utf-8?B?OUl3aEo0K3huaytlTy92a0tJNlp2TEkyRzJwV1NlWjAwK1YwZ3pGQVBCZ2pH?=
 =?utf-8?B?cnR1aXloeHB5NVdJZjVBalRkVndFMmR5NkU5amxZVXRiSXMrKytIZXBVVkxD?=
 =?utf-8?B?RXpza0dkaVZCRFRCNGN2YlV6WWt1TTM3UVdQRGRXS0l0QjQzdkY0RG5oSGNu?=
 =?utf-8?B?QXZkOHR0RzA0bjNCSXg4KyszcFdPbERzbzdBbFdTUkx3eFlSU2ovTFNFVVBZ?=
 =?utf-8?B?VG96WTdPcS80MkRsTXZwNklpTytvM3FZMHk3azZ0ekI0OHRCS3R4b2tEbFdz?=
 =?utf-8?B?U0wrTHExUlRCdWVjeXY3UU9sVjhDUlNNRHVWRzdGSFNpeVFnRE9xdG5HbXZh?=
 =?utf-8?B?Vk45RkxHcVRCcm9kMXBkMFN1QmhxWU82WEJDZ1BBekRuQ01CdkxTbkh6OFpu?=
 =?utf-8?B?cmdiSG03U3RoSVRmQk95eWc0OXNiNWZYREM5WG9ScVUzUEFYM2hFSWNRVGpz?=
 =?utf-8?B?YTg5bng5UmVjdnQ0ZExVK1BGRDBvd3hOMTdrVTh2dTZGWmxITTRrMjRXM0J1?=
 =?utf-8?B?RVY0RnVHeHZGSUZFdXVxdTZobnJZdFNJMlkwcWVXVHdvVmhwclJqS0VzQUpr?=
 =?utf-8?B?THQ1VmJDK1ZvSWF6TUFaRmRLaURnQi9lamlsMGpCZzlyYjdBMFhoYUdJM2p2?=
 =?utf-8?B?T05IQ24vWUc1dUpLdExvK0pkc3JRbmYrQkZSYUluZTlwUjl2MVB0YmVCekZw?=
 =?utf-8?B?ZzNsMFhzNHZ6RWdqaTNsUVJUMWZRRS9iV09BdnN5NW03MnF3ZFhwSnpjY1BI?=
 =?utf-8?B?RzRlVG9rc2FzTTQ0cVFiSkQ2Vi9vUGtrZk1zMXBQcEhodWozTVU4RjdmSi9y?=
 =?utf-8?B?NmdYTVIxalVHanFOSGpucUZibFNkMGdKRG5VdUVVNXlXOU1SRWxpbC9WU25m?=
 =?utf-8?B?MStxQ3BuUy9VRnhycnppRFlFVjF2eGN1QUV4ak05eGhZLzdiVXdFT2hJSnFX?=
 =?utf-8?B?YithR0FvQno1aDlSRGg5NDhEQ0RsN1pDZ2d3d01WZ1RnRXNHN0pWeDJ2YjNZ?=
 =?utf-8?B?NElYWnBvbzh4ZVlndDNNcG4vZnlEcm9JVWZ0TEMyd0QvZ0tZTXpteXN0MFlK?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <361874E3E0DFFE48A10D7132A1C40ED5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f53d54c-1b11-45fe-57a6-08da973b4067
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 16:56:36.5100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6X9qgLrxKc1FMJm8+9NBINzhXf5J3W+C0zWDEn0KTfGQRpkdASCxsEPxUXNfbno6CyEqvpgUmE5beTAZ1tWUgigc3kQcfDyQx0qw8bazHL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5280
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDkvMjAyMiAyMjoyNywgQW5kcmV3IEJyZXN0aWNrZXIgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQ29tbWl0IDIxMzk2MTliY2FkNyAoInJp
c2N2OiBtbWFwIHdpdGggUFJPVF9XUklURSBidXQgbm8gUFJPVF9SRUFEIGlzDQo+IGludmFsaWQi
KSBtYWRlIG1tYXAoKSByZXR1cm4gRUlOVkFMIGlmIFBST1RfV1JJVEUgd2FzIHNldCB3aWh0b3V0
DQo+IFBST1RfUkVBRCB3aXRoIHRoZSBqdXN0aWZpY2F0aW9uIHRoYXQgYSB3cml0ZS1vbmx5IFBU
RSBpcyBjb25zaWRlcmVkIGENCj4gcmVzZXJ2ZWQgUFRFIHBlcm1pc3Npb24gYml0IHBhdHRlcm4g
aW4gdGhlIHByaXZpbGVnZWQgc3BlYy4gVGhpcyBjaGVjaw0KPiBpcyB1bm5lY2Vzc2FyeSBzaW5j
ZSB3ZSBsZXQgVk1fV1JJVEUgaW1wbHkgVk1fUkVBRCBvbiBSSVNDLVYsIGFuZCBpdCBpcw0KPiBp
bmNvbnNpc3RlbnQgd2l0aCBvdGhlciBhcmNoaXRlY3R1cmVzIHRoYXQgZG9uJ3Qgc3VwcG9ydCB3
cml0ZS1vbmx5IFBURXMsDQo+IGNyZWF0aW5nIGEgcG90ZW50aWFsIHNvZnR3YXJlIHBvcnRhYmls
aXR5IGlzc3VlLiBKdXN0IHJlbW92ZSB0aGUgY2hlY2sNCj4gYWx0b2dldGhlciBhbmQgbGV0IFBS
T1RfV1JJVEUgaW1wbHkgUFJPVF9SRUFEIGFzIGlzIHRoZSBjYXNlIG9uIG90aGVyDQo+IGFyY2hp
dGVjdHVyZXMuDQo+IA0KPiBOb3RlIHRoYXQgdGhpcyBhbHNvIGFsbG93cyBQUk9UX1dSSVRFfFBS
T1RfRVhFQyBtYXBwaW5ncyB3aGljaCB3ZXJlDQo+IGRpc2FsbG93ZWQgcHJpb3IgdG8gdGhlIGFm
b3JlbWVudGlvbmVkIGNvbW1pdDsgUFJPVF9SRUFEIGlzIGltcGxpZWQgaW4NCj4gc3VjaCBtYXBw
aW5ncyBhcyB3ZWxsLg0KPiANCj4gRml4ZXM6IDIxMzk2MTliY2FkNyAoInJpc2N2OiBtbWFwIHdp
dGggUFJPVF9XUklURSBidXQgbm8gUFJPVF9SRUFEIGlzIGludmFsaWQiKQ0KDQpGb3IgdGhlIG5h
aXZlIG1lbWJlcnMgb2YgdGhlIGF1ZGllbmNlIHN1Y2ggYXMgbXlzZWxmLCB0aGlzIHBhdGNoDQpj
YW1lIGFmdGVyIGEgbm9uLWZpeGVzIHBhdGNoIGluIHRoZSBzZXJpZXMuIFdoYXQgaXMgdGhlIGRl
cGVuZGVuY2UNCm9mIHRoaXMgcGF0Y2ggb24gdGhlIG90aGVyIG9uZSAoaWYgYW55KT8NClRoYW5r
cywNCkNvbm9yLg0KDQo+IFJldmlld2VkLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2hwQHJpdm9zaW5j
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IEJyZXN0aWNrZXIgPGFicmVzdGljQHJpdm9z
aW5jLmNvbT4NCj4gLS0tDQo+IHYxIC0+IHYyOiBVcGRhdGUgYWNjZXNzX2Vycm9yKCkgdG8gYWNj
b3VudCBmb3Igd3JpdGUtaW1wbGllcy1yZWFkDQo+IHYyIC0+IHYzOiBTZXBhcmF0ZSBpbnRvIHR3
byBjb21taXRzDQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvc3lzX3Jpc2N2LmMgfCAzIC0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9rZXJuZWwvc3lzX3Jpc2N2LmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9zeXNfcmlz
Y3YuYw0KPiBpbmRleCA1NzE1NTZiYjkyNjEuLjVkM2YyZmJlYjMzYyAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9yaXNjdi9rZXJuZWwvc3lzX3Jpc2N2LmMNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwv
c3lzX3Jpc2N2LmMNCj4gQEAgLTE4LDkgKzE4LDYgQEAgc3RhdGljIGxvbmcgcmlzY3Zfc3lzX21t
YXAodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGxlbiwNCj4gICAgICAgICBpZiAo
dW5saWtlbHkob2Zmc2V0ICYgKH5QQUdFX01BU0sgPj4gcGFnZV9zaGlmdF9vZmZzZXQpKSkNCj4g
ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiANCj4gLSAgICAgICBpZiAodW5saWtl
bHkoKHByb3QgJiBQUk9UX1dSSVRFKSAmJiAhKHByb3QgJiBQUk9UX1JFQUQpKSkNCj4gLSAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAtDQo+ICAgICAgICAgcmV0dXJuIGtzeXNfbW1h
cF9wZ29mZihhZGRyLCBsZW4sIHByb3QsIGZsYWdzLCBmZCwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG9mZnNldCA+PiAoUEFHRV9TSElGVCAtIHBhZ2Vfc2hpZnRfb2Zmc2V0KSk7
DQo+ICB9DQo+IC0tDQo+IDIuMjUuMQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBs
aW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0K
