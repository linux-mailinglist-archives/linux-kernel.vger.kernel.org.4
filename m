Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280E1607C45
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJUQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJUQbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:31:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B4F24AE36
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666369864; x=1697905864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XJw4pUFYFz3yrZl9/XtAMgAnbBO1MhARX3oTzTNzUb4=;
  b=fr4F9nWyqZL0WCd+UsoEsWp35iux4fLUGBJI2pdnQSQMPwtQXTnXhsTu
   6uu8b9tSUv7ruiCaCUiaxArY53RjKPxgxmg5Wj04HxzOisoATDBD/sI1G
   m31DELddJTJ/fmqD591fDVX6CBIb5nv9BUwF4iXBQFmU3E4h59S9j+f4f
   Q79UfEVMcoS2QnfYzVzW2tMi6VpSvB/NlyEYVct8dmyiiw/P0+Es6rfDz
   Ljc6l0xzahxvVnrWHF+AFXjOJbjU+fc/qW/kRmLFMN1hmNv0omN8GecOJ
   XCX0WYHabODwbmjDum7MbpKqejMal6HF34OGhWpNq28B+XRS8T+sOVTTh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="371254840"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="371254840"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 09:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="719789301"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="719789301"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2022 09:30:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:30:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:30:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 09:30:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 09:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHoCtfI8Y1wAQbt2gE71M4nLe4ICbG4k122SYo/yMQ5jYqS05Nxg/96/rmth7qhOjKFa+RJgMlYj2gLG69DvLuXOIVtZOnEVQ+N9t5mVez42yJAFED0TEZCwu72IDmTG/jD0hZzAqDjKau08pwVWkbw4sUICF1YZr8uVo5RBpuUEH0NEUqGZf7PRIkIhf8ZhxhjRXWgmLAd3ytsDEFWu6KNcoXIhoFypCKfGF0XzSGV96Bji+6ZlQVo+dWzUBFFV744ML+MzJWI9mZQT5V+un+YRh949YTcHfgpddvsrW4NhJc+xUBslTFuoG1BaqAc4Zrv3LTgXkEgSPzD0vkOwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJw4pUFYFz3yrZl9/XtAMgAnbBO1MhARX3oTzTNzUb4=;
 b=B7UbIYdzcVjq3tlbQPFzh2c5DVHucdQqoDi1lct63VIO7d58MfEOnf2afPAHULztQe6U67vR4YbHUW046amfsQEdgtgnwijEe/yc9T8B5EehC8N8f+H5fGd2R48hBD4gFXTUxVuraSiwKKeYU8bJYT/4mnt6CMT0J2neOuaqlj3sEXeqFD5fxvR9eartIttDSAJHZSj8nCmXOg5QpewPvTm9fTGo1A4BYxnD1fOMyoFOB1E+3foM4VvQL3bIbJ9PZkiQv0huoCqXQ5rj344o5no4eWd8Sy0xQ3Pwg5HCEDIAhbiX1jOZ0SDKmjH8Wu077dWg4wteoUWe5PFpOINklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 16:30:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 16:30:50 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        David Laight <David.Laight@ACULAB.COM>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2] mm, hwpoison: Try to recover from copy-on write faults
Thread-Topic: [PATCH v2] mm, hwpoison: Try to recover from copy-on write
 faults
Thread-Index: AQHY4918CFTupvxOP023uLR6ydGaFK4YPAZAgAAI4DCAAFK+AIAAczbQ
Date:   Fri, 21 Oct 2022 16:30:50 +0000
Message-ID: <SJ1PR11MB6083CEDBA2719825A1AD325EFC2D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB60838C1F65CA293188BB442DFC289@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20221019170835.155381-1-tony.luck@intel.com>
 <893b681b-726e-94e3-441e-4d68c767778a@linux.alibaba.com>
 <Y1GqGbBNk6fX/OnD@agluck-desk3.sc.intel.com>
 <359bae4e-6ce3-cc7e-33d0-252064157bc6@linux.alibaba.com>
 <Y1IbOAvpGzA8bst1@agluck-desk3.sc.intel.com>
 <1643d19d795b4a8084228eab66a7db9f@AcuMS.aculab.com>
 <SJ1PR11MB6083624E288992BFA902CC8CFC2D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dda2321d-15f4-342a-2fbe-5c535858eb34@linux.alibaba.com>
In-Reply-To: <dda2321d-15f4-342a-2fbe-5c535858eb34@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5582:EE_
x-ms-office365-filtering-correlation-id: 24fbf98f-ab13-4652-d0d7-08dab3819dec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBh3P5MYJaaGN3M158V9ZuIwx+Vx0dGF26PnoENThRw4RQynMyt08cCO4cAF6SVU34RGR7UEw798v00sYpaFGhPzavERgknsgW1sndU7RIoTfCkNLscSbAKk0X0Dj3+FC0HmwCl/ZYMDfZS1X1rjZ1hKFQrmPqTUHvr7Tfpfuj0znHB+L1/CoYSLjWMxEBbo2jesK9zc1ufzolsIuU+3o3zjHhZ7sVe748IRmDea2hPFZN5lwD6bPyeuXVhkct80jA41VDiKJOB93/hZ70ysoeNq4apQzssPRgOkXDufhls1u438HKb0Yr4uDDtX0cXJG5Z+2R6VrGSbPaflAP9saJJ3SPWPk/2u8nsP+ygwUQ1Q6zDV8jpPtN4GbnlWxuufWiBxNORxD0o80FABSPw4Gm/e11F9bwZl+Y0lJV1YFBm2nXh26HnpaJeI5XePcvqIR1bpV3PtxDIJDt6EgeQZRpdbZZS8qjSX7a9WS4l0FBiUgWSDGyS3LOidmUGAgYG8inX+bHYp5l3ksOk2DjxDQdM7CvFbsInZz2sM1m33O3wLGusrNsOg5wEE2lceVoJ858fRM4ftPCPV8Qw5rUxhersmSPSAytsSwGf8uOO0Ga2JDU+i6eHTJljx0fKLwlpIVBIO623DM6BFnqlfXN+5RE8ZRpRAZzPZQs20kTfNTb8l7Rnif8B/4F74xK+wd8G5UfdfCX2/DVM2PkPzFUg/S9I04gIC9QyWnqsf0Pdt++ncGraZpSzPefTGKFnb6f5VPpI4FsZTLTTu6XcFZzEdCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199015)(478600001)(76116006)(33656002)(86362001)(38070700005)(122000001)(5660300002)(7416002)(82960400001)(2906002)(186003)(55016003)(41300700001)(9686003)(4326008)(6506007)(26005)(38100700002)(71200400001)(66946007)(316002)(66476007)(110136005)(54906003)(66446008)(66556008)(7696005)(52536014)(8936002)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVZRaVBpaWVOc2plekdMWkdYVVM1cEtvUlNVc3lGcmdXdHQ1YmY3VWpVNjRH?=
 =?utf-8?B?clRzK2NOaklSbDJRM2tvWkJWSThybU03L3RVaTRvNkwrZWN6MVVqaXZyYVZp?=
 =?utf-8?B?UjhiTFZLQVdCU2JlZ1FDdEtHaGxQRDdDTnZ4M1dGMjFVTkRWZ2ljcjREOXlt?=
 =?utf-8?B?SzNBMFBVLzdvc3gyMVhzNTJhL0E0V1lwaTd0QUVabnVZeDRCOCtlSHVMZ0Fv?=
 =?utf-8?B?SUtOSnVaNnBreEFCVDR2MXAzWThZMlJtL2Z6YUM5aW9BQWFySk8yU3BUOG82?=
 =?utf-8?B?dng0bzR1TkhRZXMzL2ErbkwyTUN3c0l5UGdXQ0FBKzYzTnlkYzZEdEcwWkRP?=
 =?utf-8?B?UU1BMHJLTHBISTZud0g3VDkzZndZL3ZOTkM3WDFYZEtJc1pHb2liVWpLNGs5?=
 =?utf-8?B?RjdJVGlwek12YlJud0FkcUJLVUIzVHFtc0hodDI0cHRMT0xURXR3UXZKVzlj?=
 =?utf-8?B?QkJtU0NvRG03MW9aVTFHYlZuWU1pMmE2VVZ1dmJaUXJ3VXU3YXZOMVgyejdO?=
 =?utf-8?B?SmROeTV2QmtiLzdzNWVaTDNEY28zNURrK281dWJUeG95UEcyQWt0YUFWYXZE?=
 =?utf-8?B?ckY5dUI2SzBjNCt5V042L3RHQi9rSjQ5QWM0b29IWW5PaVE2cGZKWHpYUjZu?=
 =?utf-8?B?TWJFVDZqZDdUVGhWNGMyalVneHJtQ2JXTC9kdUdURTZWV0hzVERhQVZTWXov?=
 =?utf-8?B?MFBlMFhOOFl0M00ybUlxcnJQQkhiSmhrTjRkekZFT3l1dnlkWVQ5TWJYMG44?=
 =?utf-8?B?ZlZEazB0aVhXUGYvTDBHb1AvbmxONUlrdnZZTFppYml2b2JOUzdSb2g1UWxZ?=
 =?utf-8?B?Njd3cGxMaGRSbXlUZVRtc3gvRHROR3BMNW8zNXAxcFdIUzBFdnpuWEt3NGFD?=
 =?utf-8?B?UVBCUUpBTkRPUDk2WTRyb0pPYlpCSkhsVUxsY0V4MnBNTzhFWVlFWjlMWmZH?=
 =?utf-8?B?REZESkdqK0VpdVRDeWMxWEx0anhSK2pFV2pncEVNNlRhNXJMRzJMejg1TmN3?=
 =?utf-8?B?b0tGQlVoK042Q1U2ekJSYS9udVB3Y2JWRDJTWkFRWGMyQlBic0c1T011dG9I?=
 =?utf-8?B?cVQ5NmY0TU5yUnRhMTFzUE16eG9BT0o4Y1J1TjAwUWR4YkQyMTV6Mjhuai82?=
 =?utf-8?B?aFdQZ2k5SEhia2c3NUZWVjBXbDZTY2ROYjZqcFhsWExyenl3RnlTbVh4cHlm?=
 =?utf-8?B?d3BRNFIyL0NQTEFDUmJGcUs4bG81U09XcGwyRzhFbGxHOHFBNDZ6cE5wY3Ax?=
 =?utf-8?B?ODM0cDlKZ1RMVjl5dmR3ZzVjSUpmSEQyRlNKbmxOaFZaVHFiL1VXZVJRNVBY?=
 =?utf-8?B?OWdhYVpRNzFBMkx3MmZNK05FRXQyc2g0TEN0WlcxODNTWStublMzUmJPVmdB?=
 =?utf-8?B?Wml6RzRFd3NJOExRS1g4N3ZIN2huZVV4eWxLRDVFYStYWDhwOXozRkRYQ3RH?=
 =?utf-8?B?L3loNWdhRWlzbzRvS3BBdG5CeGp2TGxTQjd1Umk2LzBSendlZGovVUdQbkhR?=
 =?utf-8?B?N0dLN0lpdWdhOGZJd2I5VUxuZUZ4ZStjRWZOUVJpV2MzSVFVQW0vT1JNcG5K?=
 =?utf-8?B?SE00Q214eWViUVB0UXJzSys3Sm5VSUxhSWd3R2p6VE5oS2pxbXJ6SDRib0lq?=
 =?utf-8?B?MFVwL29vdHh5QzBkMVh0OS9PeWpGb1c1bmViL3V6UnROaWpqRjJ4TjVmV0E0?=
 =?utf-8?B?L3l2eXBMRnhKZWo2NFpVUXl3dmlLYy9qUFJnVisva0ZJbW00RkRVU0pJalhv?=
 =?utf-8?B?SVdOc2hoWGxLYXdjMUdaS21BcHJmalFabzFlSFFXK2k5YTJMc1JoM3ZOS2Rn?=
 =?utf-8?B?L3NDOGt3TE40K0xOKzJmRUduMURZNVlQTnVPV1pUem5Wb1A5N2xrbW53M1J4?=
 =?utf-8?B?c0p3dmNTamdHSnpBSzNnYlJaaXJNMW5oWmlLanlNa0ZZanBzRVBGM0gvUlEy?=
 =?utf-8?B?blNsenRWWmZNZlpGWjZqK1BQaVlJUnFZZXdNMnlscFRHbGYwQ0huRmRjanR1?=
 =?utf-8?B?ODVhK2RkT2ZXclJNOUJHU05VT2FSWVhUTndkTFgrc20vTURhQWZ1eWY1aVpm?=
 =?utf-8?B?dkRjSXFCWTFCNDRzREpLQ0lWUTgwd1V1L3Nyd1dwWlpRMXVQUUxHK1QwM0cr?=
 =?utf-8?Q?PzNdqQ9xGauCKtLUsFTCk+ERv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fbf98f-ab13-4652-d0d7-08dab3819dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 16:30:50.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKoyJ5LHLFoF+WW7gt3P2Djl6oDv/3H5+ygRlAgwHM5ozDK6v7/TTzBKzgpDXLCFzeKkblKfRnB0RCdNrrAoYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQnV0IG1heWJlIGl0IGlzIHNvbWUgUk1XIGluc3RydWN0aW9uIC4uLiB0aGVuLCBpZiBhbGwg
dGhlIGFib3ZlIG9wdGlvbnMgZGlkbid0IGhhcHBlbiAuLi4gd2UNCj4+IGNvdWxkIGdldCBhbm90
aGVyIG1hY2hpbmUgY2hlY2sgZnJvbSB0aGUgc2FtZSBhZGRyZXNzLiBCdXQgdGhlbiB3ZSBqdXN0
IGZvbGxvdyB0aGUgdXN1YWwNCj4+IHJlY292ZXJ5IHBhdGguDQoNCg0KPiBMZXQgYXNzdW1lIHRo
ZSBpbnN0cnVjdGlvbiB0aGF0IGNhdXNlIHRoZSBDT1cgaXMgaW4gdGhlIDYzLzY0IGNhc2UsIGFr
YSwNCj4gaXQgaXMgd3JpdGluZyBhIGRpZmZlcmVudCBjYWNoZSBsaW5lIGZyb20gdGhlIHBvaXNv
bmVkIG9uZS4gQnV0IHRoZSBuZXdfcGFnZQ0KPiBhbGxvY2F0ZWQgaW4gQ09XIGlzIGRyb3BwZWQg
cmlnaHQ/IFNvIG1pZ2h0IHBhZ2UgZmF1bHQgYWdhaW4/DQoNCkl0IGNhbiwgYnV0IHRoaXMgc2hv
dWxkIGJlIG5vIHN1cnByaXNlIHRvIGEgdXNlciB0aGF0IGhhcyBhIHNpZ25hbCBoYW5kbGVyIGZv
cg0KYSBoL3cgZXZlbnQgKFNJR0JVUywgU0lHU0VHViwgU0lHSUxMKSB0aGF0IGRvZXMgbm90aGlu
ZyB0byBhZGRyZXNzIHRoZQ0KcHJvYmxlbSwgYnV0IHNpbXBseSByZXR1cm5zIHRvIHJlLWV4ZWN1
dGUgdGhlIHNhbWUgaW5zdHJ1Y3Rpb24gdGhhdCBjYXVzZWQNCnRoZSBvcmlnaW5hbCB0cmFwLg0K
DQpUaGVyZSBtYXkgYmUgYmFkbHkgd3JpdHRlbiBzaWduYWwgaGFuZGxlcnMgdGhhdCBkbyB0aGlz
LiBCdXQgdGhleSBqdXN0IGNhdXNlDQpwYWluIGZvciB0aGVtc2VsdmVzLiBMaW51eCBjYW4ga2Vl
cCB0YWtpbmcgdGhlIHRyYXBzIGFuZCBmaXhpbmcgdGhpbmdzIHVwIGFuZA0Kc2VuZGluZyBhIG5l
dyBzaWduYWwgb3ZlciBhbmQgb3Zlci4NCg0KSW4gdGhpcyBjYXNlIHRoYXQgbG9vcCBtYXkgaW52
b2x2ZSB0YWtpbmcgdGhlIG1hY2hpbmUgY2hlY2sgYWdhaW4sIHNvIHNvbWUNCmV4dHJhIHBhaW4g
Zm9yIHRoZSBrZXJuZWwsIGJ1dCByZWNvdmVyYWJsZSBtYWNoaW5lIGNoZWNrcyBvbiBJbnRlbC94
ODYgc3dpdGNoZWQNCmZyb20gYnJvYWRjYXN0IHRvIGRlbGl2ZXJ5IHRvIGp1c3QgdGhlIGxvZ2lj
YWwgQ1BVIHRoYXQgdHJpZWQgdG8gY29uc3VtZSB0aGUgcG9pc29uDQphIGZldyBnZW5lcmF0aW9u
cyBiYWNrLiBTbyBvbmx5IGEgYml0IG1vcmUgcGFpbmZ1bCB0aGFuIGEgcmVwZWF0ZWQgcGFnZSBm
YXVsdC4NCg0KLVRvbnkNCg0KDQo=
