Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C435FF191
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJNPma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJNPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:42:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED932AE05
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665762143; x=1697298143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xPdo0QBNNMMCd1GleAme8sxdj7sIQqoDNzeQyam0kw0=;
  b=LwHR501uBwGPUdqFA0/uPNjlIjkkDreOel/NhRzj5+UcWznFGvOu3aQn
   mjH2B+WulEUuN6DuElbVWsmbzbe26xvR9b2BdeSax+rUxQq8/A8EwSwOX
   HJRz1RbWbiH2h94GgsQWaUY4Cod7rI1s5skFhtgqPvoUF7QVy4Oz5r3oi
   oH95jMjpfxg2k32h3eZaCdHj18iBCymSSMk8F+4xmZmXAF754XV+xLdGv
   9tPE9zsKkIGLoB32HkZeXFMyNZJCnMK1XRbLsEviKB6WKpU3cVzsyanXr
   f3p4IbZXC+RdDvvqY5RIdVko6UyvPFbjQ+YWj7kfnmnlKMzL9/jvSigpq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="285130774"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="285130774"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 08:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="627609401"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="627609401"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 14 Oct 2022 08:42:23 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 08:42:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 08:42:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 08:42:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 08:42:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAbDvfpvvXF02jh5Z1Bk82pLdd794/XNGMItOERUapwt8t76Ko3YXMzSsC6uOao9GuWA75v1SlhaN/BDrAONYVy1uD37EJCeW4/Q7vFElo06CfhbSlyFaiZJSjv64N0OVsHsY+1caGb8Bo2SdervEwSnrvGMOyu15wX8PbpF4JLpfLs+q92sd+cEZw/jLZykGNBrypyRfScggQsc2P41w8GoKZaEknMrRVJRtNtCB1wxMdDLVPdJ9zpX/PYWGOEmb9SS4BDifD15/JWbESsk/hnYR/6TTJ3K7F7Pak69jHzIS77aIKzaTBT7L8GR3RK9KjFxBt99CiTMDBNaMQqt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPdo0QBNNMMCd1GleAme8sxdj7sIQqoDNzeQyam0kw0=;
 b=ZqxU3iD0VBN+/Oi6YsYKfeQy40RyPt7+RQq31QXHTHrqHxIBE07yovmE3fPlfT8hvuoUHKA0k1Y7xaFmSAtanTrDouCiErM8cOvPOwNjXtMq6dGl9XzOP4LShZgAAo5MYGXF6whyId6B+1VdXUNSbqH+rRwF7VH3sTg4YcjcE7oAayb7WK0wlcEXPNfVyvQPZYVG9IHN87/DiaFFkq1qqWxseS/keuaWn5WohK/2ildD7bGJS1FheClcTsHv2UXGA/9cWf2ktiF+mnaEL8F/92J6tVI19LAUtNfyqkPlya287EpwCkJdnXSQbbKxI4tcXz59JBiCkaE3jJSbSUPBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Fri, 14 Oct
 2022 15:42:19 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 15:42:19 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [RFC v2 3/4] modules, x86: use vmalloc_exec for module core
Thread-Topic: [RFC v2 3/4] modules, x86: use vmalloc_exec for module core
Thread-Index: AQHY2qcCivppoe8db0mS/SkQ0x4Q364OEceA
Date:   Fri, 14 Oct 2022 15:42:19 +0000
Message-ID: <fb7a38faa52ce0f35061473c9c8b56394a726e59.camel@intel.com>
References: <20221007234315.2877365-1-song@kernel.org>
         <20221007234315.2877365-4-song@kernel.org>
In-Reply-To: <20221007234315.2877365-4-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB6401:EE_
x-ms-office365-filtering-correlation-id: c7873ba6-281b-40fc-0925-08daadfaadcd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22L/xAEvQ5QFicaRPFN46WxBaiRicavXAzd5GY3++A09Ke+xg3t+Hg9JY3fVhCJhB/pDJyEi8r2Tu5Nfc84g82fhfI3XjFX4w2mfCQZOifKLF4BOK31rl6OTA4nslmsRgV8cVEL2z6z+4y6xM+krHr59Sk3dXVtFBK0yVJ0agM3XwjaFOzLElAup2ds7KwNIwOy1NXhUZPg1a85GDF7zEKHAkAHqLTI+nYm4zvQc8zro+cmXRQ704iFwIDeYdClPJOVw3RuM0I1fPqT5Fv/kFJu9dWyYUISGt3WhKdKg97YKt1GwwQWY9zox51bYjXVYP+WtaU64x4y/wVuBfmYLs4JwmAgkOEzFnLrMuZAxYr6aeO5q7ZJTgLrBVP8PwwYdwvdhc06pL1E5i85qcMsS14IoZEaD1zT9ZNTLrxlVCzSXWytslhn4SRbi5UxcbyMtgnnQJvhY+qwaO7tABiPuvOu6T/U/rTMyr2tfn/h0EeWaNX0Q88xJI4geAea140uckKvJezzxl3RMjT7z0ENwT6bbvBR7d6pvCxaQNQV0mXMurt0TVxZRRLFb/p6ofSu4bKIGeo9BVSmq7MRxg7VPpnREh3Yup4kbllYQ5WnaHvLAi+KV4ATK2zyXfp84swlMGtnTwV1DpBXJLXHTuKAX1NyZXmEMwqg5Ta+Qur2W84gzZzs5aVjZxej4PJJImtPgyQDVctxWS/NUFkjCgf1hMjk3VAR2/U6am/FLhClHt665AhGrUfKsBCHLWdIpW/vyRRgGV7yL/UU78/45WFbJWSBFwvwuOkf9S8dOWvSu5Sg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(122000001)(36756003)(82960400001)(316002)(76116006)(64756008)(38100700002)(38070700005)(66556008)(91956017)(8676002)(4326008)(66946007)(110136005)(66476007)(71200400001)(66446008)(2906002)(6512007)(86362001)(41300700001)(186003)(5660300002)(8936002)(83380400001)(2616005)(54906003)(478600001)(6486002)(6506007)(107886003)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWxjMld1VkorTDhNSkN4QzJTUUZCeUhRaFdLdGNNb25zaHdBVEtZOHRTd2VR?=
 =?utf-8?B?QjM0L1VOQWRRb1E2UjdOWnJZVFRkb0NQRnM2TU1JUU9jd1VqMUVlTTBucnVw?=
 =?utf-8?B?U1dUUHp3UHo2T0xXNmpnMy9nUzdNR3luR0pJQkR0ZldGSm5aWWZocHpFUVRP?=
 =?utf-8?B?SENrL2JwS2FKcUIzQi9SdE5IZVBEcFliMUR2Q1FjVitZTUtrYjcyb0tzWDdX?=
 =?utf-8?B?U0NMMFRFcEdVT28zRmd5MXl6ZC80Zys0T2RUUzFnam53eDQ3TkdSdXdZVTBy?=
 =?utf-8?B?c1kyVnNjcmFDaW9Qb3owMEpBRitRSno5QnVRU2hKYi9YYkNJOEYyQWtoMW5J?=
 =?utf-8?B?T3NBU21QTVN0RlpnMS9zU1JKRGRvYXo3dSt1VnNZeEFoRDJ0VjlMV0Yxd2Za?=
 =?utf-8?B?ZnMrdm1razYyRG1CQnp0Nk9KZzdYTmVHV0dieTFvS1lyZmNha2RmcTU1QldG?=
 =?utf-8?B?Wm5tVlMzWk5ubGhjQVRpZTB0elVOakZ5OVQrdEd0QW5EY0VPUEZjYjM3aWVW?=
 =?utf-8?B?RDFxdVc4QUpzKzVOeE9EVWhZR0hUZzJWL2FJUWtTRkIwSlVXNmJ1RHJJc3h4?=
 =?utf-8?B?a1ZWdGYrRGRaY29Oclc1TU54R1NhenV6eDRzWjdMd3AzZVBLajVEQnZBUkcz?=
 =?utf-8?B?TUNXRUYyUDM2NFpLOWRtNm9DZEdPSGtkQmM4b3FvdUdpMjVySzNlV2swdGZL?=
 =?utf-8?B?YzEyVXpUMzg0K01WZm5tekFScW1vQVVVWFZUclJxYXd4U3JnUVMzZ1NybmhX?=
 =?utf-8?B?eDljVE93RnVRcUFBYXNyTHhaSlVZSXR6SlI2TG1MMkcxRXFVT2RrTGFUMUR1?=
 =?utf-8?B?ZHI5c1pkWngzczl0TytZU3ZET1dLazdJNmY4VHMwZGlka0hQTEg1OERZZmhW?=
 =?utf-8?B?RnF3TGxhVTBhYjBzMnhHMXhlNHNtdm9PeEZPUS92M3laS3g5ZmNzSzFmeW50?=
 =?utf-8?B?WlBOK1YzbUhhN3FBZG51enpteUE0cVVYVExFS054NXo0dkNUWHpmUllNdjQr?=
 =?utf-8?B?NlNDa0xTUjE3bzlQcldlNlh4TjlZbVdMcE5WWWpiUzdvYVRNbThFaVExeWJy?=
 =?utf-8?B?ODFJWnpqM2IxWE1WbXlxSkVneGZLQTZ5bmdIcS9Ka2lmN0E3Ti8veHVMYWpr?=
 =?utf-8?B?MTdWUWlDenRpRStNTWg3VkF3eGdHMUp3ZXcyYkVaQ3BkdkdFZlJ5UU1VMWx6?=
 =?utf-8?B?Y3pOWDdoWVJ5MTVBbnViaG9XTmEvTjA3Qkcza1NnYzVvNHYxTDd0SWRUdzRH?=
 =?utf-8?B?Qk1DWFlzNy9vYVdwUFFwcUFUNi95QnpRNm1MS1BWVk1aWEJRNE50YzEzbU8v?=
 =?utf-8?B?OWtUcmRCaDNLWVVjL0RBOEtTMkdKZm9YRjNCM0swVGcwSmpHbVRqajlmQW9G?=
 =?utf-8?B?di9PWXV6dGZ1YW4zdmZabmQyQmYramUyVk9WNDduNnlNTnA3eHY0L211aC9M?=
 =?utf-8?B?VGhrZVdZeEpuNGJSVzdKbmFKVTJ3R2lMRG1BK01RalRIQ25rR3pLUjZtMkFU?=
 =?utf-8?B?TWsvd0JQUzNrR0d0Q2JLZzZjZk9DQnF5MldZRjU4a0FDTkJzZytSWkxCR3dx?=
 =?utf-8?B?dVlPeE5hSGJlL0YwNG45Mk1jUTk5S0EvYWlRWVlhTFRBeEh6UXpaMVA2QXJZ?=
 =?utf-8?B?Wm5od0tkY1o3OUdhUG5tQ1hMaC8ycEh0QlBLUDlkc2p4MXdaZDA5WVJUdmJP?=
 =?utf-8?B?VXIyMTVmdUQ0SEl2ZzhnWk4zaTAvMlpGOTBwb3p3VUcvMzBYOVRqYmhJbXpZ?=
 =?utf-8?B?UjFnb2RDazI3NE1CL1I0Z21SQlMyY3NvMjBEN1BZa1RsNHI0cUI4ZE5meWl4?=
 =?utf-8?B?MGEwMFM1TnRUZmlFNGxYWUtpdk1pZHZrZXRNWStkZ0d1Tnh6YTc2b3RlYk5a?=
 =?utf-8?B?b2k4c01pbE5iUGkwSEN6aGtCZ3FYV1kwYmVOK0RNK2xVOGhQdGlXdkxSRXJF?=
 =?utf-8?B?bFhZVnR2dnNBVmM2bXBmS2pNSWNPcm5XNGRYSXo0V3g1L2orM3phT3drWjNp?=
 =?utf-8?B?UU9GZE9sUVFLQ2htSENkeUJhM1dCc3QzMm9qSWNWaXZrdFlQOGM2aXhGaHlK?=
 =?utf-8?B?bzhEbklWK01wOGpDUFZhcWpvUFQxNU80UTM1dTZIZ3NFbHdGUkl5d2t2Y0ZD?=
 =?utf-8?B?TjlpVVZEc0RneTg2M3FnUWxDaTNmdmI5K0VPZ3kzNk9oeWk2V25SRzhEdFJ1?=
 =?utf-8?Q?uUwn58LUDHiMcySBGf2u55s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E6CC6F01D20DF47A837B74D68FFA1C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7873ba6-281b-40fc-0925-08daadfaadcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 15:42:19.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXm/HNTnJ3M6OLFZaC205F8yGbVX6sjoulcYtoNNyaIBOsYoXLnzK/SYr4xNmCCPdsCsk5UNJabeiPfXKQ8Ug10VTj6tPsoF4DpMXi9oKNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6401
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTA3IGF0IDE2OjQzIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jIGIva2VybmVsL21vZHVsZS9tYWluLmMNCj4g
aW5kZXggYTRlNGQ4NGI2ZjRlLi5iNDQ4MDZlMzFhNTYgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9t
b2R1bGUvbWFpbi5jDQo+ICsrKyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+IEBAIC01Myw2ICs1
Myw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvYnNlYXJjaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L2R5bmFtaWNfZGVidWcuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9hdWRpdC5oPg0KPiArI2luY2x1
ZGUgPGxpbnV4L2JwZi5oPg0KPiAgI2luY2x1ZGUgPHVhcGkvbGludXgvbW9kdWxlLmg+DQo+ICAj
aW5jbHVkZSAiaW50ZXJuYWwuaCINCj4gIA0KPiBAQCAtMTIwMyw3ICsxMjA0LDcgQEAgc3RhdGlj
IHZvaWQgZnJlZV9tb2R1bGUoc3RydWN0IG1vZHVsZSAqbW9kKQ0KPiAgICAgICAgIGxvY2tkZXBf
ZnJlZV9rZXlfcmFuZ2UobW9kLT5kYXRhX2xheW91dC5iYXNlLCBtb2QtDQo+ID5kYXRhX2xheW91
dC5zaXplKTsNCj4gIA0KPiAgICAgICAgIC8qIEZpbmFsbHksIGZyZWUgdGhlIGNvcmUgKGNvbnRh
aW5pbmcgdGhlIG1vZHVsZSBzdHJ1Y3R1cmUpDQo+ICovDQo+IC0gICAgICAgbW9kdWxlX21lbWZy
ZWUobW9kLT5jb3JlX2xheW91dC5iYXNlKTsNCj4gKyAgICAgICB2ZnJlZV9leGVjKG1vZC0+Y29y
ZV9sYXlvdXQuYmFzZSk7DQo+ICAjaWZkZWYgQ09ORklHX0FSQ0hfV0FOVFNfTU9EVUxFU19EQVRB
X0lOX1ZNQUxMT0MNCj4gICAgICAgICB2ZnJlZShtb2QtPmRhdGFfbGF5b3V0LmJhc2UpOw0KPiAg
I2VuZGlmDQo+IEBAIC0xMzIxLDcgKzEzMjIsOCBAQCBzdGF0aWMgaW50IHNpbXBsaWZ5X3N5bWJv
bHMoc3RydWN0IG1vZHVsZSAqbW9kLA0KPiBjb25zdCBzdHJ1Y3QgbG9hZF9pbmZvICppbmZvKQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICBrc3ltID0gcmVzb2x2ZV9zeW1ib2xfd2FpdChtb2Qs
IGluZm8sIG5hbWUpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBPayBpZiByZXNvbHZl
ZC4gICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChrc3ltICYmICFJU19FUlIoa3N5
bSkpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeW1baV0uc3RfdmFsdWUg
PQ0KPiBrZXJuZWxfc3ltYm9sX3ZhbHVlKGtzeW0pOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgdmFsID0NCj4ga2VybmVsX3N5bWJvbF92YWx1ZShrc3lt
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicGZfYXJjaF90ZXh0X2NvcHko
JnN5bVtpXS5zdF92YWx1ZSwNCj4gJnZhbCwgc2l6ZW9mKHZhbCkpOw0KDQpXaHkgYnBmX2FyY2hf
dGV4dF9jb3B5KCk/IFRoaXMgb2YgY291cnNlIHdvbid0IHdvcmsgZm9yIG90aGVyDQphcmNoaXRl
Y3R1cmVzLiBTbyB0aGVyZSBuZWVkcyB0byBiZSBmYWxsYmFjayBtZXRob2QuIFRoYXQgUkZDIGJy
b2tlIHRoZQ0Kb3BlcmF0aW9uIGludG8gdHdvIHN0YWdlczogTG9hZGluZyBhbmQgZmluYWxpemVk
LiBXaGVuIGxvYWRpbmcsIG9uIG5vbi0NCng4NiB0aGUgd3JpdGVzIHdvdWxkIHNpbXBseSBiZSB0
byB0aGUgYWxsb2NhdGlvbiBtYXBwZWQgYXMgd3JpdGFibGUuDQpXaGVuIGl0IHdhcyBmaW5hbGl6
ZWQgaXQgY2hhbmdlZCBpdCB0byBpdCdzIGZpbmFsIHBlcm1pc3Npb24gKFJPLCBldGMpLg0KVGhl
biBmb3IgeDg2IGl0IGRvZXMgdGV4dF9wb2tlcygpIGZvciB0aGUgd3JpdGVzIGFuZCBoYXMgaXQg
Uk8gZnJvbSB0aGUNCmJlZ2lubmluZy4NCg0KSSBlbmRlZCB1cCBuZWVkaW5nIGEgc3RhZ2luZyBi
dWZmZXIgZm9yIG1vZHVsZXMgdG9vLCBzbyB0aGF0IHRoZSBjb2RlDQpjb3VsZCBvcGVyYXRlIG9u
IGl0IGRpcmVjdGx5LiBJIGNhbid0IHJlbWVtYmVyIHdoeSB0aGF0IHdhcywgaXQgbWlnaHQNCmJl
IHVubmVlZGVkIG5vdyBzaW5jZSB5b3UgbW92ZWQgZGF0YSBvdXQgb2YgdGhlIGNvcmUgYWxsb2Nh
dGlvbi4NCg0KDQo=
