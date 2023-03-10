Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53416B3844
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCJINd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCJINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:13:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62B109748;
        Fri, 10 Mar 2023 00:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678435951; x=1709971951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VJoLpZRxE3ii21vsUeQG6BugnfA5dw4+k+G6DhOfnAs=;
  b=FT5jY6Y2kaDCUppRhOXd4yTTM2w9PSmQuIIA2SBwjMPMwZtLEtXp//wr
   4wgitlD97po0zzfiNCSahOPv3fWn2MKJ2AcnBn7W5LPcc0GTLmMp/KF3/
   Wsy4Hd3wyu3/9l0s5y5MmhziGs1g5RvYdrN2vnqEl9wwIiTwZTVw0LKsW
   sQkGbXiVQsOqX3WltNhqAx9Mv21VbWW42d/hDWHXWUJ1Sz80W7kAtaGkw
   FLbMpeMbFSYFbievfVvV94/ieW+sVgT2XV76JMEr3MPgdL/UEBu/LyonU
   UqxZXZFP7P4U/owrw8wJlIa+wGc5/ifek6GLpq/ea3ZJ4LzOpYNUlmRYG
   w==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673938800"; 
   d="scan'208";a="204155999"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2023 01:12:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Mar 2023 01:12:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Mar 2023 01:12:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW0mgX0V2xqrSXJD6+5Ik92lwU2likXoCdEVXxKiYbdttX2zLlpVX9MUH0Os1oAW4tTCZ2BFgXyBnlAiBiKge2UG7p9xN3Mk8J64Tl3hjJbagxDHayf4welwWBGOIHtMHaXp51zZS4O7mP6xTJo7kywVT2J9kZi9QOPBAP1xOnIK9rXZ7yv84pxQbRnzOG9IPX0785k0xM822ItwXcxMkAy11kLQPcELMi2TSDDP3Q5wcoCgCksAbmpnuBHqz+h3ryOeV2VwJVZ2SSqsoZy19gxIL7NNNrgWhEWpDTMDkxAsgZdnwR9wPnuew9lU/O0BGHT3mExhcv6Sbk77MCKlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJoLpZRxE3ii21vsUeQG6BugnfA5dw4+k+G6DhOfnAs=;
 b=LI7Hd3/sujwmqvFncb61sUfnwynm6M1XOMc9EW2yTFK8eJS2uSVWS78LVP5N378ZGeTISdDX22iADvlJJkxy2C38xJsfCrwNpkSnFRAZTIPHLp5Wu5O/X+afZwpVNSVA2hZewOMybNWKoyHXlKT3xxjkFgF8ZX0s56nw7m6cjdKzcUSKs8KH1x41ve4itnM8f+YBxlsxSG+fDXKxXb+wQY/ZsAhh9rSXOBLohPmit7A53sbqp8bDrWRYj3BrkkOBy0EIKczrArUipwPGIZ6WGWrEcAveD6m0gyIO9HrcD376potzDILHB1triQ9suHC7019FrYCEiAtLb4qW0S8oAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJoLpZRxE3ii21vsUeQG6BugnfA5dw4+k+G6DhOfnAs=;
 b=HV3hlk8zAkbb7mmr6/Nv+IPbQxoZ+ddUydWThA9YE2eB2c/ZDS3BbOFMcyZlgPKm8hzXiGryHvQCqAaY3NuvTVxVcu09t9LvNJtDwkvNExwEQ146++GiXZElyozCt5TvpTCRDnwSS62rITftz2L8rQt3I7/lwS5WRrPBFvHqH9w=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 08:12:16 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 08:12:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <oder_chiou@realtek.com>, <shengjiu.wang@gmail.com>,
        <Xiubo.Lee@gmail.com>, <festevam@gmail.com>,
        <nicoleotsuka@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>, <cezary.rojewski@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <matthias.bgg@gmail.com>,
        <bgoswami@quicinc.com>, <vkoul@kernel.org>,
        <daniel.baluta@nxp.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <jarkko.nikula@bitmer.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] ASoC: do not include pm_runtime.h if not used
Thread-Topic: [PATCH] ASoC: do not include pm_runtime.h if not used
Thread-Index: AQHZUygGVLfOxlJWNkGfkCPeNGy38Q==
Date:   Fri, 10 Mar 2023 08:12:16 +0000
Message-ID: <d9435b39-8549-5bd4-0be7-40c1b12f27c2@microchip.com>
References: <20230307103022.1007420-1-claudiu.beznea@microchip.com>
 <ef92dcac-cadd-b85e-d6ea-512684266e81@linaro.org>
In-Reply-To: <ef92dcac-cadd-b85e-d6ea-512684266e81@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|IA0PR11MB7861:EE_
x-ms-office365-filtering-correlation-id: cab0c7f6-5322-49ff-03f5-08db213f293c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjsNUs0KRmfIlU2IoSnumFqzFZ0CL/Siuinjg7TnHXeuK7EMoHzdyO5VmZWIVXUUCLijcdtHLvWco//5LT5CRYC7tZbveIZQYyJiDSwi0zZjjQzda313R+6ObOJIzxkLbuKSdxaqT1PSU9/k1hvD8E5BoAXo4eL866b2yWJPGWI42fuMAsmbkHQh9fE7gDyyjO9LLs2czmWB09nhYBxrGXcw2GMs9MSfKosVs0/bx3/wyubtYRPk1E2ytdAKDxfBLzWwQzFybAn25Pr/P0bWOyjaYul6n93pK+yUkPfLCHXNfrr9bMAaHK7v2yUYPhoXP2HjTlzp1u/Aj4ftCA9V53O3Mu8+3u4/upprd5JeGDcdwfie9f3dct2m/qiB1yPXF6AplgdUEi4dH4JEQarGYy4RWCWxQl7Nf82YMlUcrL88NhAVhmBNj2EHzj6Ga6iiTQ5S52fneezBEkrRjHDC2XZ5CPuEBC/KrKvFSCXCbpxvnPRJZKc5ph5ilycz2YVtjv2UMWIgGaxVv27pkf8/6deXxFoeKzpZE/57syvW+wtcBA6K7BKHOCtZKQMpTOuQUPvs4iVswnA63spMbkAgKBD3tllm3BGXqxulWdNxjRsHbvGFgmWHeiqUD8Txbc07bb0d6GPanoLfM8Cw8V80GmgfQawIOuzSszZJI+KVZkyoWhk9E9GnW5bSGr3FhDbw/CFy2iIWBo9JFRexGM9ZvB1qdMwLIN8Kpi4JPMK+su8A1QDLjWqb+yIpuTEC9THq0WX7tWd+ud5JAtq5b2JSuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199018)(31696002)(38070700005)(36756003)(921005)(86362001)(122000001)(38100700002)(8936002)(478600001)(110136005)(71200400001)(6486002)(2906002)(5660300002)(7416002)(7406005)(4326008)(91956017)(8676002)(66446008)(64756008)(76116006)(66556008)(66476007)(316002)(54906003)(66946007)(31686004)(41300700001)(186003)(2616005)(53546011)(6506007)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlhTM1FvNUFoSE9YeFhBWGxxYWJjRnNSemFLQkVHWUhRZVZwZGU1RDZrSUpE?=
 =?utf-8?B?UkRRdTJhSzR3OU8vYzQzTFlLdWxSZTFJVlFuVThrK1BsMmdKZmNTU0pOUGRt?=
 =?utf-8?B?K2UrN25HZDFaUmN6M3ZPaGU4ZWo1dWJjZVY1RUlNb2pGc0VpbzU2czVyOUNI?=
 =?utf-8?B?ODlsKzRZdXpxUWNxTFduKzkvaDMwdUhTdmJta3hkSjlpcWdpK1NRemtldXRr?=
 =?utf-8?B?Smp6dE9IRmd0QnA0YzA4SnBnOTRiZUYzdm5rdXNsMUJHeTEwN093THo3L1lR?=
 =?utf-8?B?L01JQStWSzBTL2RtN1Y5RkQwSzgzVFdZOTVvWkFzZm9NYW5XRS9ZZXI0WDBh?=
 =?utf-8?B?aS82RkQrOFBrdTdsakdjMjJnMWY2b2dVVGhDRWdpb2g5ZmREeXlvZ3YxMVVl?=
 =?utf-8?B?b2tUakJYUzdsVDNWWHJFSjNjQ2dFbGpwVWlpclBuQnd6eGRZMUVxSWgzWDVI?=
 =?utf-8?B?cGpSRlNQdlpyT1NEZ055akhPT01nTEhQQkVGRHJXUERJWlJ1a0E5d0JMSndp?=
 =?utf-8?B?WjR6K1JPSVJNcWZlNEpvTFVEaVhqWTVQUk42K0JrWlMvNkpEY1gzdWI5V2M3?=
 =?utf-8?B?ZVEzcTZlRzRXZkpjMHJVclhuM0xTQm5DQ3lCRnFOaUYvM0Z4MjBHNnppRWI5?=
 =?utf-8?B?UXNBbDI3TmF4UDNOaUphYll4VkxPSUhNU2h1ZUxxYThUTjBHcDJvcFE5dlcz?=
 =?utf-8?B?aHBRck9WOFdGNno1VzJ4NGE5ZlQxK0lmSVhpTnZTTjNrdGplTno5SnozUC9a?=
 =?utf-8?B?NVJmSHdzMVV2YmltQzVWamtoTUZ4Rkt2N1dQU1NLK0s5bnoydXBKV0s0Zjlv?=
 =?utf-8?B?M2dxWC9RbnZaZTM4b25KczVHaGFSVFQ5VW5GMzYxbHplc3poYVNCcU1QeGkw?=
 =?utf-8?B?K3NGNHRLM0dhYW1Qanh2MmZzdnRtY1BxOXQxWXE4REdYRWtCTE1QL3ZzazZ6?=
 =?utf-8?B?V2FaRktSTUhlNUJuZDBJWXA2Wmh2OFA3RHExSjlrcFVGYlZzYXRpRTBpMSsz?=
 =?utf-8?B?TENHVnExR1pNM1R4RGtUNmI0T2ZNMC8xL0twOXdkNEpMbHdzRDR0NjZaR2VH?=
 =?utf-8?B?c1ZwZy9SVm90VWtPanY5RHRRTTZISEp6YVZYN0Zqam5xMFJzMTdBMGZBYjl0?=
 =?utf-8?B?bzBiWHdqY1NrckEydGRJYjZJeTd4M05teU9ZT2prYWlZWUpYQWZJNERUdEw3?=
 =?utf-8?B?Wi95TVhFYTNCMldOTWFSak0wWTVWcWVpbkpRa3RNTjNJQW8xci82RUVlSXRQ?=
 =?utf-8?B?MzUzbjVqejJkazBRUTdOZHBYcjVodHlqc3FTRlZkaCtvUWE3RTVCVFQvR2JK?=
 =?utf-8?B?VGxpV0pTc0txQUZPMHo4LzZsU3R4ZGMwejJoZnBBek10WWVlTyt2dWNZRXlu?=
 =?utf-8?B?aWdadUVHb05NeUtQTERpQkN3dzMxWVdDZkdEWXNkK3k3SEVMOTRZSXowbERK?=
 =?utf-8?B?VGJTKzhyMW5qMlJRZERHKzJENUtPMGpWM0l5U3JtNm83MktiS2d5dWtoYitw?=
 =?utf-8?B?RDhRNWl0Y0NiSmVLbjZNOXRVQTBsc2FsU0VwNTNENE9VencvUHZYWkgwT2d3?=
 =?utf-8?B?bnVlRXAwZ09nNER4ZEhuRFlPOFVyaVY2R2FjbzdFOC9MSjBMYmxJS0dtdFkr?=
 =?utf-8?B?V0QxRWYvbzNlU2JicWVBTzlqaXRhK21KMzhtODd2Y0RncjlMUG9pWVo0NnpH?=
 =?utf-8?B?VmN3Nm5PbHJadkJJSUNWRmRnR1YyMDd6bnhGaC9hbUhTTUZTV09UUVNTOW5O?=
 =?utf-8?B?NW42d2cvWVd2VnhIWGZ1SU82blF3UVBKVXZ5OC9vVmw5UmtKT3kzK2NBdmtF?=
 =?utf-8?B?WG5PYU1kRlE5MmVjaWs2eXlMU29MeDNDZWZKd1BCVlJtSndTaXY2TWxvUUFs?=
 =?utf-8?B?MEx4RHVXOHRMR1AxRzJRY1NLMGkxQ0NlRmVyZFRPYXZldnhaTjQ3akQzN1Zo?=
 =?utf-8?B?U3hKcXNhMFVxZnBNQ2x4RVFScW04aU9qOWRhaTdEVzhrbEptUUJGTVVZUWRF?=
 =?utf-8?B?ZFo2U2t0NHVReklZQ2xCdTFXUVlTSno5NW15WEdZOGxIR01ETUFPdUYvWWlS?=
 =?utf-8?B?L1ZHOWQzTDRrN3A4SERxRWRmTlVCOXI2YzVwVjFBbG54NGpUbXVoVzRiZXBN?=
 =?utf-8?B?Sm9ZTjBwR21RRXgxRnZVa3c3VHhRNUhRTDJaeHFwdWVYYTVWblFhcVY4VUxk?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE392B5B3B04DA44AE9F39C1ED55E40E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab0c7f6-5322-49ff-03f5-08db213f293c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 08:12:16.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9r14hhOJbHGEs5Cbtou73uW7dqJdjnvrW/4MesCcEgR8uwd1EFfb91dOWNRDXL2amqmrqmLVCMopTYtlM0rdRu/Jw6i/0OvvNolb1iclgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDMuMjAyMyAwOToyOSwgU3Jpbml2YXMgS2FuZGFnYXRsYSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNy8wMy8yMDIzIDEwOjMw
LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvcWNvbS9s
cGFzcy1zYzcxODAuYyBiL3NvdW5kL3NvYy9xY29tL2xwYXNzLXNjNzE4MC5jDQo+PiBpbmRleCA0
MWRiNjYxN2UyZWQuLmRjODkyZmFjNGJhYSAxMDA2NDQNCj4+IC0tLSBhL3NvdW5kL3NvYy9xY29t
L2xwYXNzLXNjNzE4MC5jDQo+PiArKysgYi9zb3VuZC9zb2MvcWNvbS9scGFzcy1zYzcxODAuYw0K
Pj4gQEAgLTEyLDcgKzEyLDYgQEANCj4+IMKgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4+
IMKgICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPj4gwqAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPg0KPj4gLSNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+PiDCoCAjaW5j
bHVkZSA8ZHQtYmluZGluZ3Mvc291bmQvc2M3MTgwLWxwYXNzLmg+DQo+PiDCoCAjaW5jbHVkZSA8
c291bmQvcGNtLmg+DQo+PiDCoCAjaW5jbHVkZSA8c291bmQvc29jLmg+DQo+PiBkaWZmIC0tZ2l0
IGEvc291bmQvc29jL3Fjb20vbHBhc3Mtc2M3MjgwLmMgYi9zb3VuZC9zb2MvcWNvbS9scGFzcy1z
YzcyODAuYw0KPj4gaW5kZXggZDQzZjQ4MGNiYWUzLi5lZTRhNGI1NTNlNzQgMTAwNjQ0DQo+PiAt
LS0gYS9zb3VuZC9zb2MvcWNvbS9scGFzcy1zYzcyODAuYw0KPj4gKysrIGIvc291bmQvc29jL3Fj
b20vbHBhc3Mtc2M3MjgwLmMNCj4+IEBAIC04LDcgKzgsNiBAQA0KPj4gwqAgI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KPj4gwqAgI2luY2x1ZGUgPHNvdW5kL3BjbS5oPg0KPj4gwqAgI2luY2x1
ZGUgPHNvdW5kL3NvYy5oPg0KPj4gLSNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+Pg0K
Pj4gwqAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3NvdW5kL3NjNzE4MC1scGFzcy5oPg0KPiANCj4g
SGFzIHRoZXNlIGJlZW4gY29tcGlsZSB0ZXN0ZWQ/IHRoZSByZWFzb24gSSBhc2sgaXMgYmVjYXVz
ZSBib3RoIHRoZXNlDQo+IGRyaXZlcnMgbmVlZCBTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyBtYWNy
byBmcm9tIHBtLmggd2hpY2ggd2FzIGdldHRpbmcNCj4gaW5jbHVkZWQgZnJvbSBwbV9ydW50aW1l
LmgsIG5vdyB0aGF0IGlzIHJlbW92ZWQsIGFtIGd1ZXNzaW5nIGl0IHdpbGwNCj4gY2F1c2UgYSBj
b21waWxlIGVycm9ycy4NCg0KSSByZW1lbWJlciBJIGNvbXBpbGVkIHRoZW0gYWxsLiBCdXQgSSB3
aWxsIGRvdWJsZSBjaGVjayBpdC4NCg0KPiANCj4gY2FuIHlvdSBhdGxlYXN0IHJlcGxhY2UgdGhp
cyB3aXRoIHBtLmggaW5zdGVhZCBvZiByZW1vdmluZyBpdCB0b3RhbGx5Pw0KDQpTdXJlISBUaGFu
a3MgZm9yIHBvaW50aW5nIGl0Lg0KDQo+IA0KPiAtLXNyaW5pDQoNCg==
