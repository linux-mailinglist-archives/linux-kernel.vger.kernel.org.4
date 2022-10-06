Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215AA5F664D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJFMop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJFMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:44:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4522B877
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665060279; x=1696596279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YtAPYqdbe6KFpGivhQyA3QsdfT8W8JjbxK/fO7ywXps=;
  b=DTgrEWjcE2gXJQvp6YsidWEYsjG9qiqw+mkUyj2BtqxiYn9XwFI9xJE/
   YpsDGw84i/XZDEfppaqm91SsWehanm9NO+JTfZGEeipW/HZ+Kj7nbRJuU
   jA8t0af547SjJ9MA82LsEanbBNvKvoSwGQ0loR6NKHYCtvbwTyD3DDXBh
   ZhtVnfkJ6LveA53n53OLAuUBx6K5F5W6n9twJT8u+DNaGMljEtY2qeW5L
   n360I/efxg0v1KwK9jdkA7d+bOnAGImdWF2eKOaJTs7ohmXdcLaB7zR67
   DALvSdKjT1yLzZU0bH8+2oyt9c9HWnF0jyeG8/hmr4hD2AuPW30NEub5H
   w==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="183458492"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2022 05:44:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 6 Oct 2022 05:44:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 6 Oct 2022 05:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU6Fu7rHDPG1pWM571GLS0odAhEh13oS84UGnKTeaxIzrMQS1cx0hhMCt7DH4Zr/GteNjN+uC96NUeizO45FN9KIzM9EskjYN/Giyd4b32Nhtn7iKU5ci7kN8nOi07qLFyuUBSVSTxPqiqV4atLpcHIgtPcAm8+srIdKG4naSlww7QNBlk+mbbkQ1gHbECnEAegnJkner5GNmszIoAWeczL0ZIrXspZnQPNHZpeVhf2wHeKprRx6qBXGxpXIocO206T6IOm+52EQEBjAJjqthdFDxM3hqMLy42e/5Pq3Cn3oJKJ1xxcKhe7x3jEyoNzpLFS9tsg9wRZPR0oJiAdsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtAPYqdbe6KFpGivhQyA3QsdfT8W8JjbxK/fO7ywXps=;
 b=JXaknLpWPVky+IvuvQCV/4+d6JcSWeNkuhQKEsxn4Vt8XsNw3TBPK/BGs7s8WRKqzP4E5c6FOPHbSD90b8h2GY4BmfryXtHVV1M+cXG7n81aaHx96NtEQCnJcQ9BqncLXQ4u+0RJ6YFtZvtaQZ0RUo5WauKWXA2+fbxWy+61fBP/9Xp5NtFWqyXOFPhpySyoXKMY2x2Uko78IOP4PlmrWwccl13we2bl2zDGNv66ThNCgK2h4XrlWdI9SJnX1AlnQCQi/ImCxHMDerg4ACLa9wM+tJHo1IXFb3HlBBceyYsgLLar6Da2B2io9R6uC8YgXdzY28K2KDObNGUOudqnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtAPYqdbe6KFpGivhQyA3QsdfT8W8JjbxK/fO7ywXps=;
 b=Q5xR4wu/OdeJ0livQ7F3f625IY6C+Ha1Tfs9tq/Q5AK08a6i+nphHkT0/5moyeAtU63deXh3BxqRUiiJkQnf3oVa/M68X69TmdwcwVDvesP4mPk/7uBivlroRRrG+u/fEzkqNAV7zlRIuegADxqDSb36dBm/HpMozK2goN4NtYc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DS7PR11MB6293.namprd11.prod.outlook.com (2603:10b6:8:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 12:44:32 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::68c0:270e:246d:618a]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::68c0:270e:246d:618a%3]) with mapi id 15.20.5676.033; Thu, 6 Oct 2022
 12:44:32 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jszhang@kernel.org>
CC:     <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
        <rostedt@goodmis.org>, <ajones@ventanamicro.com>,
        <ardb@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <trix@redhat.com>,
        <samuel@sholland.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH] riscv: jump_label: mark arguments as const to satisfy asm
 constraints
Thread-Topic: [PATCH] riscv: jump_label: mark arguments as const to satisfy
 asm constraints
Thread-Index: AQHY2VAAtGkNzk3lJEyGSzgFFGtvJ64BT1sAgAAAsAA=
Date:   Thu, 6 Oct 2022 12:44:32 +0000
Message-ID: <4c8fa16a-8463-ee32-7307-0383fa94403c@microchip.com>
References: <20221006064028.548-1-jszhang@kernel.org>
 <20221006124144.abaz74g7nxrb5hxj@kamzik>
In-Reply-To: <20221006124144.abaz74g7nxrb5hxj@kamzik>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|DS7PR11MB6293:EE_
x-ms-office365-filtering-correlation-id: ca57509b-ff0b-40d1-d115-08daa798848e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: is2g3FrY98qRV9NBf22igTtgkfUpsY67q4ttqikXr/MI+8EHZ7n3Cpcm/9I4lxL2fzTj3X0eYoxFB58PyEyGlMBY5221flarKYFrITH+zZl/g/4VZ056e19xIqIR/TbZx1n93C8fCUR+JcFlKylCtXva7wqObqNs4PVi0cI2MvJYnGTQSdk2wbrLAf9EX21oGIsB5Q3glkOdsvtUm6Do9RGE92drngR/qQ9l8qCeGY2/OnR12etIhbXxC649lzRYFmmw+DkiQtHPahjjGwJ1WBtx0UBZUuQHrc3ZlewGspe1MBo/+gWSJ83lJOSlw82D/EwyL1VNq4XOcMkd6/FKWfyFOBXfNw+l+RviXNba+mVeffPBQ/tXWFJUm/gLqBcxsLGgL0f8YQZvE6EycqJJrqJ7Aa1Rj1Mznj8dV3kYudEcmo9Taw1NaXU1+3EKv5t+FAtaIZISNZOdcKZzZ/2MetIzcfmLRvLXeCt4OScUWa3tA8QPqQdwyL2uV3x2g3tzUWO2d5LBT2q/biQLnBx7hqsj3ZiiSuD6Xjcv0TrhGmOddX3Q8HZbreUxHginTHTvdcs8xXHzHxvYB6XsRKIx+TcqbN7YbTT+fga0mIpUDIEJK2vpsCmoeC3Exgkiur38lV7RNxV4iOn8UH0m2TtocPF3d69wqqyqep3CQMbqNtX1vRMzQZBNVzyAsDlcnThZ7yZEWMr3lh2HmqhLutRt/Ac3y0XkNhgm5XcUzONy/t5kXEgyDl4wCmMABQWQO2wIq5aIee24T4kBaXXDxqgZ3yK+pGB0WxB/urCrkAQ5nfeRiAfreaOokey6gemFcajlz6y860GrePMXwLY3s0Kt4mFclLwbTEyLRNyK9Ow+jfpgD5pR2aXVOlBUfjeEvLFW+YAUNrPvMFoA9DxXaB+fJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(2616005)(2906002)(41300700001)(7416002)(8936002)(66556008)(64756008)(66446008)(66476007)(38070700005)(66946007)(31686004)(91956017)(31696002)(71200400001)(4326008)(8676002)(86362001)(54906003)(76116006)(6916009)(316002)(966005)(6506007)(53546011)(122000001)(38100700002)(6486002)(478600001)(186003)(5660300002)(83380400001)(6512007)(26005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkdHUWl0SVFUd29oampFU2F3b0pXQ2ZHZXR0Tml6dG1QUTRMQzY2bTBqUnQv?=
 =?utf-8?B?dXVTTGhPdU5ITDl5ZVA2TVdvTVdDT3RUM0NPNEErOTZZNEVabzZGRWxIV3Z2?=
 =?utf-8?B?UlJuanBGWWZuQ3pxZXovSU4wNHlsTmxxVmg0VVprZkUvUEk2SXZJdXhvL1ln?=
 =?utf-8?B?Z1RTKy92SFJkUE1TN3B5T3ptY1E0dVR1UDZDTnA1Z1ZQTFBqano2WFlmNGdZ?=
 =?utf-8?B?UHIxemhWRmFWQ24wWUhTZGpRQTg5T3B4WTNadEs5TWp6UE1vS0VwVldVRUFw?=
 =?utf-8?B?UlI1ZUtWY1VOalpmUUdMWS9KaXhzRkRuZFJIcm41eWNNTjZrODg2MCswWk5J?=
 =?utf-8?B?ZHVHZmRaVGJreTFPT1Bua2JERm5mTXZ5aytvZmZicE50WTBrS3d3anFQbVlH?=
 =?utf-8?B?cHZVejlXMWI5UHU5L2FNUkQrUnB0ak1OTTZOaWY4ZmZVR2VsaElXT1hFMy9C?=
 =?utf-8?B?Q0tyb0tCUlBVUmFxQUc0MUFldUJNMjBYZkV2Nzd2MFU1V1lwbUVhYXhjS1RT?=
 =?utf-8?B?YjVjNVpCb1Q2R2tqamtFME1pV1dYTHd1anFiMCtacHRtbUdVRzBaaXFmbis5?=
 =?utf-8?B?VEs5Y092ZnBONXRwZnhnV09STVhyZktzeDYvVGRaYzZzN013MUNWS24zR1hi?=
 =?utf-8?B?bUtBOFo2YTJVNWlJUkhSVGtFMDd4NjhLaDBIRDRSTzQwekVWWHArMVpwOHRC?=
 =?utf-8?B?QzN0QzdaT0xMbVY2THlWbkxXYzNidFBmWHdCMFgvQTY4TkR1UHJGT2VQNm9P?=
 =?utf-8?B?ZDM0blR5eVhUeHhJZGZjUWZTUC9KVkVraE4zRDVBUTVONmxtUjVkR2dtVVlX?=
 =?utf-8?B?U3pDSmFGc0hRcHJtcVdRZUpnbDJ6NzhGT2hzY0V0YytEZXp2STBLMmtza2JF?=
 =?utf-8?B?QWpueEtNQmRFdThicEZKQjc5d2VhMHBFTmxJWlptbmtwVUdZRHRNYnNBbGxC?=
 =?utf-8?B?eUo3Sm11d2Z2ZUwwUEwvbnFud0RCQzEyR3p4MGYxTEU0bUtKZCtYaVVCb09W?=
 =?utf-8?B?MDc0ajhSQnhYdE1yMlVnQ1NtSzlSa29QdGZjOC80SDVyTmx5OFhEOENHaGN0?=
 =?utf-8?B?Mm83YWszWngwbEFqQ3cyQm1Ydk10YTg1L0lzNTJ0QkFCU1ZnUFhNOUlDYm9O?=
 =?utf-8?B?TWhobVczQ0tUWitRTXNrS3V2TjVlVWF3ZU5oNThCZkw4K3hFdis3YWhIcmRZ?=
 =?utf-8?B?aUcvckRUeU4zZkljakJoamNnWTJtajE2alI4SnoreTlneWloQyt3cjA1YytF?=
 =?utf-8?B?YW51TGFDYllubFRtNWMrVFAyUnhEdnA0R0gvcUpmT043SGJRdFo2YUlPRFc2?=
 =?utf-8?B?bEdENi9RRitjdVpSelovbWlLSTg5aTU0TFpzR3pCSndOZk1DZktBeThZb1ky?=
 =?utf-8?B?T2kxbFlrOUQ0U1MvdlAvUFBwb2c4amJSVXczTXZodmdhOW5lMzZpVVpaVy9v?=
 =?utf-8?B?MWlmaXVPU3NvNWNLWlo1b2QxcWZEU1NwalBNWWtHbnNQMmxsSFBPZWZMNGNT?=
 =?utf-8?B?TVU3QVlKaE5pNmpEQzhST2VyckdvYVZmU0VJVFh1bGVkWHU5dTdkMkRsKzA3?=
 =?utf-8?B?Uit6NU01dU14SVdYVFRYaHBlWHpWRTVQb0xjRnFvdXc0MTNGUUcxRmhCR21W?=
 =?utf-8?B?N0ZXRDVSWjBBbEZVa3RJclBRc3E3VktScHJuWHZ5cUpzVS81MlVXM04xNVND?=
 =?utf-8?B?S1pJZVJRSHVJYUZ6VEVWRE1ERHNBK0xwK3cyWjJuRzFHMXZTV1R2dUdkVjdk?=
 =?utf-8?B?MHRyZ3FoQ2hQQ1RnSllZWTMzYW1TT1RsQjEzOTJTMHg3MlY1NVhaZUIrWSts?=
 =?utf-8?B?d09FUVh4RGVCV3lxSFlReDJZSW9ENWJRRnVBR1lqNzBEcXZXaEh2QTRtWFZZ?=
 =?utf-8?B?Y0tXV3VqYTFKVTFLRWs2SDVzaVBUaHgyRXNWMElrVEsxU1VqeWZjSERZTDla?=
 =?utf-8?B?MWxCMmVWRHhjS25vUHpqdVkwSHo4eHJPZXZYSzkzNnVJaDhJcUdoZHYwU2lU?=
 =?utf-8?B?RmlrWGhBZ2VyTHRLUithMlE5S1NpSWFZTG5lTk1PcnJIa3VlSzdiNm1ZY1l0?=
 =?utf-8?B?bGIrUEUyN3lvNGEyMStLRVNxeTVZZGFvUGY0QnRUK3F2bHlQSlIzTHhyZmRr?=
 =?utf-8?Q?xVZFLG0DtzHRaUqQmk3qrFJey?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10AD530EF786764EADAC39DBEA46ED11@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca57509b-ff0b-40d1-d115-08daa798848e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 12:44:32.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luSvYgPcqREs4RV4tt3J1Uitr/za/u66RprWw078L6lG1pN/5UU09yl8bad9LP5WvBhGBiuoB+4vbYWNt82M/k6OmOjm1VKMbHuVe8oDGpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMTAvMjAyMiAxMzo0MSwgQW5kcmV3IEpvbmVzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgT2N0IDA2LCAyMDIyIGF0IDAyOjQw
OjI4UE0gKzA4MDAsIEppc2hlbmcgWmhhbmcgd3JvdGU6DQo+PiBTYW11ZWwgcmVwb3J0ZWQgdGhh
dCB0aGUgc3RhdGljIGJyYW5jaCB1c2FnZSBpbiBjcHVfcmVsYXgoKSBicmVha3MNCj4+IGJ1aWxk
aW5nIHdpdGggQ09ORklHX0NDX09QVElNSVpFX0ZPUl9TSVpFWzFdOg0KPj4NCj4+IEluIGZpbGUg
aW5jbHVkZWQgZnJvbSA8Y29tbWFuZC1saW5lPjoNCj4+IC4vYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9qdW1wX2xhYmVsLmg6IEluIGZ1bmN0aW9uICdjcHVfcmVsYXgnOg0KPj4gLi8uL2luY2x1ZGUv
bGludXgvY29tcGlsZXJfdHlwZXMuaDoyODU6MzM6IHdhcm5pbmc6ICdhc20nIG9wZXJhbmQgMA0K
Pj4gcHJvYmFibHkgZG9lcyBub3QgbWF0Y2ggY29uc3RyYWludHMNCj4+ICAgIDI4NSB8ICNkZWZp
bmUgYXNtX3ZvbGF0aWxlX2dvdG8oeC4uLikgYXNtIGdvdG8oeCkNCj4+ICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+DQo+PiAuL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vanVtcF9sYWJlbC5oOjQxOjk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybw0KPj4gJ2Fz
bV92b2xhdGlsZV9nb3RvJw0KPj4gICAgIDQxIHwgICAgICAgICBhc21fdm9sYXRpbGVfZ290bygN
Cj4+ICAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn4NCj4+IC4vLi9pbmNsdWRlL2xp
bnV4L2NvbXBpbGVyX3R5cGVzLmg6Mjg1OjMzOiBlcnJvcjogaW1wb3NzaWJsZSBjb25zdHJhaW50
DQo+PiBpbiAnYXNtJw0KPj4gICAgMjg1IHwgI2RlZmluZSBhc21fdm9sYXRpbGVfZ290byh4Li4u
KSBhc20gZ290byh4KQ0KPj4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn4NCj4+IC4vYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9qdW1wX2xhYmVsLmg6NDE6OTogbm90
ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvDQo+PiAnYXNtX3ZvbGF0aWxlX2dvdG8nDQo+PiAgICAg
NDEgfCAgICAgICAgIGFzbV92b2xhdGlsZV9nb3RvKA0KPj4gICAgICAgIHwgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fg0KPj4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0
OToNCj4+IGFyY2gvcmlzY3Yva2VybmVsL3Zkc28vdmdldHRpbWVvZmRheS5vXSBFcnJvciAxDQo+
PiBtYWtlOiAqKiogW2FyY2gvcmlzY3YvTWFrZWZpbGU6MTI4OiB2ZHNvX3ByZXBhcmVdIEVycm9y
IDINCj4+DQo+PiBNYXliZSAiLU9zIiBwcmV2ZW50cyBHQ0MgZnJvbSBkZXRlY3RpbmcgdGhhdCB0
aGUga2V5L2JyYW5jaCBhcmd1bWVudHMNCj4+IGNhbiBiZSB0cmVhdGVkIGFzIGNvbnN0YW50cyBh
bmQgdXNlZCBhcyBpbW1lZGlhdGUgb3BlcmFuZHMuIEluc3BpcmVkDQo+PiBieSB4ODYncyBjb21t
aXQgODY0YjQzNTUxNGIyKCJ4ODYvanVtcF9sYWJlbDogTWFyayBhcmd1bWVudHMgYXMgY29uc3Qg
dG8NCj4+IHNhdGlzZnkgYXNtIGNvbnN0cmFpbnRzIiksIGFuZCBhcyBwb2ludGVkIG91dCBieSBT
dGV2ZW4gaW4gWzJdICJUaGUgImkiDQo+PiBjb25zdHJhaW50IG5lZWRzIHRvIGJlIGEgY29uc3Rh
bnQuIiwgbGV0J3MgZG8gc2ltaWxhciBtb2RpZmljYXRpb25zIHRvDQo+PiByaXNjdi4NCj4+DQo+
PiBUZXN0ZWQgYnkgQ0NfT1BUSU1JWkVfRk9SX1NJWkUgKyBnY2MgYW5kIENDX09QVElNSVpFX0ZP
Ul9TSVpFICsgY2xhbmcuDQo+Pg0KPj4gWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
cmlzY3YvMjAyMjA5MjIwNjA5NTguNDQyMDMtMS1zYW11ZWxAc2hvbGxhbmQub3JnLw0KPj4gWzJd
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjEwMjEyMDk0MDU5LjVmOGQwNWU4QGdhbmRh
bGYubG9jYWwuaG9tZS8NCg0KSGV5IEppc2hlbmcsDQoNCkNvdWxkIHlvdSBwbGVhc2UgbWFrZSB0
aGVzZSBub3JtYWwgbGluayB0YWdzLj8NCkFsc28gY291bGQgeW91IHBsZWFzZSBhZGQgdGhlIHJl
cG9ydGVkLWJ5IGZyb20gc2FtdWVsICYgYSBmaXhlcyB0YWc/DQoNClRoYW5rcywNCkNvbm9yLg0K
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaXNoZW5nIFpoYW5nIDxqc3poYW5nQGtlcm5lbC5vcmc+DQo+
PiAtLS0NCj4+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9qdW1wX2xhYmVsLmggfCA4ICsrKyst
LS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vanVtcF9sYWJlbC5o
IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9qdW1wX2xhYmVsLmgNCj4+IGluZGV4IDM4YWYyZWM3
YjliZi4uNmQ1OGJiYjVkYTQ2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9qdW1wX2xhYmVsLmgNCj4+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vanVtcF9sYWJl
bC5oDQo+PiBAQCAtMTQsOCArMTQsOCBAQA0KPj4NCj4+ICAgI2RlZmluZSBKVU1QX0xBQkVMX05P
UF9TSVpFIDQNCj4+DQo+PiAtc3RhdGljIF9fYWx3YXlzX2lubGluZSBib29sIGFyY2hfc3RhdGlj
X2JyYW5jaChzdHJ1Y3Qgc3RhdGljX2tleSAqa2V5LA0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBicmFuY2gpDQo+PiArc3RhdGljIF9fYWx3YXlz
X2lubGluZSBib29sIGFyY2hfc3RhdGljX2JyYW5jaChzdHJ1Y3Qgc3RhdGljX2tleSAqIGNvbnN0
IGtleSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnN0IGJvb2wgYnJhbmNoKQ0KPj4gICB7DQo+PiAgICAgICAgYXNtX3ZvbGF0aWxlX2dvdG8oDQo+
PiAgICAgICAgICAgICAgICAiICAgICAgIC5vcHRpb24gcHVzaCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcblx0Ig0KPj4gQEAgLTM1LDggKzM1LDggQEAgc3RhdGljIF9fYWx3YXlzX2lubGlu
ZSBib29sIGFyY2hfc3RhdGljX2JyYW5jaChzdHJ1Y3Qgc3RhdGljX2tleSAqa2V5LA0KPj4gICAg
ICAgIHJldHVybiB0cnVlOw0KPj4gICB9DQo+Pg0KPj4gLXN0YXRpYyBfX2Fsd2F5c19pbmxpbmUg
Ym9vbCBhcmNoX3N0YXRpY19icmFuY2hfanVtcChzdHJ1Y3Qgc3RhdGljX2tleSAqa2V5LA0KPj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGJy
YW5jaCkNCj4+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgYXJjaF9zdGF0aWNfYnJhbmNo
X2p1bXAoc3RydWN0IHN0YXRpY19rZXkgKiBjb25zdCBrZXksDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGJvb2wgYnJhbmNoKQ0KPj4g
ICB7DQo+PiAgICAgICAgYXNtX3ZvbGF0aWxlX2dvdG8oDQo+PiAgICAgICAgICAgICAgICAiICAg
ICAgIC5vcHRpb24gcHVzaCAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblx0Ig0KPj4gLS0N
Cj4+IDIuMzcuMg0KPj4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbmRyZXcgSm9uZXMgPGFqb25lc0B2
ZW50YW5hbWljcm8uY29tPg0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1yaXNjdg0KDQo=
