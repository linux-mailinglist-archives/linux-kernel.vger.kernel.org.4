Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFDD6BB6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjCOPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjCOPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:05:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4192B17155
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892747; x=1710428747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=90kGZFxwdDLzfaqGIvGqU+g8YWb1VtN4puG4BCHLY5A=;
  b=WoFfkkLT9C8lSzSzFSkQtU+AqW2xQDNJrDuHLnWcZhDxbNHNDeGztbGY
   m71nBLU3oAPTIosx+YUVNLP4vy/U5kWmLxK2AqwFvyNIE5+geHJyqpczP
   LfGYVIqZZq8NRrLLHAL9+ARpyyQ9j+NAjMFC6heY7/P714U5qWMM94wEK
   o4WTbIHw3MlxYBI4sibeAx9h6N11Fq/7lxwXG+z8S5CdCiXEfblfHjEiM
   9PhqTn/944D9N/pHfC5ZVlLEp9RpCsDWTgHa9k5TbyoNtWKhaXTGx/uIs
   xoOVme2pyIA+aO3uv+ODMSssDModu0T9GSTbL4V+l25FMdNIBUp2dC+4F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="337750873"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="337750873"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 08:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="1008873736"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="1008873736"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 15 Mar 2023 08:05:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 08:05:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 08:05:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 08:05:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 08:05:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a12eeLivfkcvJsymqHl8wovIbb4c92EiIWd8P2gfR4LhPlwaIOxip2K8U6LVvKWMmNzzUtxnKpEw9h/TO0YJCwnYWXNW+7CyF6RhOTTW0wlftBX4oD+J2WIZdi2PA9uQUEJ89MNfPbd/ljwIz7JiC9O5t1lTfG5LuMRSNv0QUWeK8D9jHS0a/M/SA3KwdzSNxiLFdhOdmH/rEbgTz1rDfQFf3CeSxU/6TL9XWTRXoSNrnSXr9lC5N7zgbYpqunHgWOfzEJ1tWyxnk7Fch/koGM+rJ2NH3fEHeMXUsLMyRCR88Me2GdnAlrjjb++dYSnD0zIIj1G+CwsnQp+I81V2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90kGZFxwdDLzfaqGIvGqU+g8YWb1VtN4puG4BCHLY5A=;
 b=SKk9M9m7V19Gz/arZun25rTfdufqrmdbZGaNZc12d9PNh/vaJRiB+vyvOW6nz1soz0TxUtW2CtgN6wAqHC6XecgyMwT1rJOor1OnAMkSOobFlJ1XfFIToMC/9T73ztX7Hkm/YeNEWP9SM3rtyPjre7gwQ+fBYhSCNCkqTaJRTdtWsjPcFMDcYeHAYuYrQkURjMhuBVOLMEQiO1sPih9qb6rNbi/3iEsIKuUDH1aEHMhnvONZiDvF+LyiytnKCvGTgZKhmL+KHbtKVxThO17FVoYpFrKahAC5bIgAJz5J4QjseK+4GDf+buJq8sYj2bAhRv54bCBf9nVwqe3+LFD0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by PH0PR11MB5831.namprd11.prod.outlook.com (2603:10b6:510:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 15:05:38 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::1181:71b3:9254:ea83]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::1181:71b3:9254:ea83%5]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 15:05:38 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "alexs@kernel.org" <alexs@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "siyanteng@loongson.cn" <siyanteng@loongson.cn>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "Cui, Dexuan" <decui@microsoft.com>, "hare@suse.de" <hare@suse.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "src.res@email.cn" <src.res@email.cn>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mporter@kernel.crashing.org" <mporter@kernel.crashing.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "freude@linux.ibm.com" <freude@linux.ibm.com>,
        "alex.bou9@gmail.com" <alex.bou9@gmail.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH 23/36] driver core: bus: mark the struct bus_type for
 sysfs callbacks as constant
Thread-Topic: [PATCH 23/36] driver core: bus: mark the struct bus_type for
 sysfs callbacks as constant
Thread-Index: AQHZVdny9jWFDb3H1k+8eDqp8RD0rK7783sA
Date:   Wed, 15 Mar 2023 15:05:38 +0000
Message-ID: <57762efb335cb27ff2995a8c4263083f66546061.camel@intel.com>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
         <20230313182918.1312597-23-gregkh@linuxfoundation.org>
In-Reply-To: <20230313182918.1312597-23-gregkh@linuxfoundation.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|PH0PR11MB5831:EE_
x-ms-office365-filtering-correlation-id: 4b0b79da-5b3b-4830-3903-08db2566bc9e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzAUMRwrG6qqxKDbXqN8lK+ns8qEZRZ6f32rhogJVRsk+O1x+lR+Dg2Cw7egOFYPVd5cjP3PnkspwGN9kH3JsvpATmi0quEy0AGF+E7G3ksCpLJ3ptd85MwEIyuVGGUC5qmVs3Us5BLrtzgSF2gpZGwTu7Vo5et1zCavwOK9jH3n/DRKIhUY+v28Vq2B67hl8aqA30BSmT0R/j4uAkB+lHk69STjYBn2RmPm1OeEM806W9atj/GVAVjOEvsP/B5oupP/DEV3XpV3QQqEnq/FlUKzNzNNiQPjc9qYjQK+BesoY8YI2OQy2ka/8Nl8i+VPmjXSaubFFwPy+kszFb4UkAovOIBiXwMbqIzwjyty1kG/2SWELhJNHq5ywX87GOsJmkmD8AoIhrYDaF1nlkrSLf51ZEa1ajn6tSBrcfB8s+8+GbJSfGJdYVH6QajzLoKIrdr9IZ2wovufSq/rbh8o4H0OYVEFQgThjZ28sh6o47KJ+ky9HmVe3lYUUZuWQ7NX7qlvQDxpYC+4laWccldDu+RQF1DDVN/bZs5W/+8zwCv2mbbl434hyXppZFZT48HWxFvuqX5X0dIhftcpPc97d+Ry/XO7iPkxwexTyt71ELf/oWcRKETeGn8o2mdHSD53FInhwcyx92TO+LGBKy5MEb2hCatkqZJL6ncWyVJOCGDRBrUPzR1DEl0pVDb+iwY9nWSdMP35BmVenfAkG7GXlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(36756003)(38070700005)(38100700002)(86362001)(82960400001)(122000001)(2906002)(41300700001)(7416002)(7406005)(8936002)(5660300002)(4326008)(6512007)(2616005)(186003)(26005)(6506007)(83380400001)(110136005)(54906003)(316002)(66556008)(64756008)(76116006)(66476007)(66446008)(66946007)(478600001)(107886003)(71200400001)(6486002)(8676002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzdRWVU3cm5SMlFOSUlmaDFTUUZzR08yajFlRktDUFI3bzJ0b1B4Y2VoWUhF?=
 =?utf-8?B?MTgzUi9wdEl1SUI0OElsaDQwRnFna2dXZURhRUJ6VllXOFF1NkpCVHdDRXlM?=
 =?utf-8?B?L2oxUmZFd0R2Z2oxcUFHWFVudy9qY2o4TlNsbll1MGNtL0V2cm5IbW5kdTdy?=
 =?utf-8?B?Mm5IQ210NnhjWmpzWUhZZEtQSndJVkljTi9hbGNkNU0waHNhbU03alVCRElm?=
 =?utf-8?B?RE0yZy9yQWVNNWJYanUrR3FjeGJHTkRvWCtlSWVwK0d3ckFmSmVFQURHUlBo?=
 =?utf-8?B?REowRzBiaXFWTnNobXFleWJjYitZTW5wekRhc2xiNjA4T2c2RDUyR1BWTzNS?=
 =?utf-8?B?NGdnMWNGRTc5eDBqcitOZHAvWlAyZUJHWUtqd0tzZUVtQnUwaUNyV25jY0Y1?=
 =?utf-8?B?czZFZzVoR0JaNTV6SVR4cWhvTWdGUGJ4d3lVM0JHODYxYVhwL3p3REhHYmg0?=
 =?utf-8?B?MHZ5SHBSQUtneHFadnBndUdTc2JrZllpRmtUbzNMQ2xMbFAvOGJ1SE5Kc1k0?=
 =?utf-8?B?V1RBVXh5QzZGUEJsV2RqQ0ZWNHRXTERKbW9vT0NQSzZ1TEEvbTczRXU0UjdU?=
 =?utf-8?B?bkx1cTBWKzdCTGNNTzhRSys2S1R4aHdtZzlqTXIydHlsYi9oT1U0cUtMc2xy?=
 =?utf-8?B?OS91UkoybTR3M0tkTm1wSHJTOXNzQzlxRHF0NDVmQnNVdk05amtPTHo0NEtO?=
 =?utf-8?B?bzRtR0lBS1NGb2tJSUMyUjArVm94bzJtbDJVUG1lTEM4c3ZQTENTWk1MWjFT?=
 =?utf-8?B?YnlOcWkxQWI4WDhCcW9TWjUyRkdmUjdpQVVFN0w1b0xvZW5JeDdiYXNtQ2pm?=
 =?utf-8?B?Tmx3aXVZUmlKUlVUY3pxbmZhVFc0emNEbmJ3ckJlSmUvcXR4WnVkSDdMRjhS?=
 =?utf-8?B?bVoxN2I2bE9abHgxSGExYUNLQjE5VzdSQmpJWElLOXZvN0ZlM0E5bWZ3Q1B0?=
 =?utf-8?B?dmMyUm5MaERHNlFtNTEwdEpXcFJOa0tsMEV4R1YrbUdlYW15dlNxcVlVZ1BD?=
 =?utf-8?B?TjhHUU01bHdZbFhUNGtRcFRTZlFHd3lUZ21RV0FXUkFROXMzTm1Ud3BZMSsv?=
 =?utf-8?B?bG9SSEVRLytxVENseEtvQnJBUXpkRVQ5a0FNd2lSSTZ2QkoybnROMnV3YTI4?=
 =?utf-8?B?ck93UXZSVW5wUW45eUtaOFAwT0JCTWJUbUtTZkhUQlQzZy91NGQycUFGK3Rx?=
 =?utf-8?B?WWNPaE1KU3ZPclJDNUtKNm11UnFIZ045S2creEpEQllvd3JVUVdwNGFnbXMy?=
 =?utf-8?B?WUFhN2p6N09XSGhKR3NyZ3E5bDN2b2JuOUF4eVpLVHg3dkJqZWpTR3NMLytR?=
 =?utf-8?B?SXFNVFdhZUMySjY3K2NCYkZUSU4waWVMdWh1N28wYUVhdUhvMzRuaWVoOHVS?=
 =?utf-8?B?ekpGazF3ZVRSdEkzRGliQnBWNzFpK1JFdmxvSFFaOHNtSTZSSzN5Nzc5MDFJ?=
 =?utf-8?B?S0hTVHJwVGZUOWg0MkM3QTRiZnM2VlQ3RDlEdWVObjhESTJud0czb2pYbFpM?=
 =?utf-8?B?L2tQWE1SMkZhUURTMFJHdDNiRUFkeFlqd1NtZTRZMkNrb2p2T0VIV20yZWla?=
 =?utf-8?B?OW1aQWc0NzNUUmxQTnpUbENNeENnQnpLSFkzWWVnS0x5NWNmZVhTaGVRTU9a?=
 =?utf-8?B?djRJbEhValhOVmw2Z01mdU9UaCs5dWZick5JSklsOGh2Z0JDQWEwY2UrckFZ?=
 =?utf-8?B?dm9Vdy9WTEw3U0dxaG1BMHA4Mzg1bWdSSGJxT3ZaMGlUVlVOMFArYzYveUk2?=
 =?utf-8?B?L1J2T2dCZlJLUHg5ZDJMbzRER0gvSDRweW16YWExR1NzRHQ3b1VUUUpNQjEw?=
 =?utf-8?B?cExWTytTMzZaYjFUKzhpenZqOW13VVB2d1EyRldtaks4aWNweG54TXFvR0li?=
 =?utf-8?B?V1BDM0I4S0d0VUFUamV1NnE2SnZrSkt1YjZiVzRYUEVTSjlSYTcvbnFNRDdB?=
 =?utf-8?B?b1l3Qi9pT0tseDhOcjlwYWVnbzIxV2ZQRlFtUzZ6czhCTDNyMVA1UkppMkZM?=
 =?utf-8?B?Qzd6QXBCTHJYSGs4TitMYkIwWDFSU1RhYlhMVS9VZ1NSZ1Q5SnNSV05qYnQx?=
 =?utf-8?B?SXdsUU9SK2svSnJ1YmJYSC91ZU5GdmsvcFRQakxGS0I0MFhnK1BQLzcwczlQ?=
 =?utf-8?B?R2ZHamFBUzRxeUV3Zkd1eXJRODREOVM2bVNvSnlXOVdmZjRabzRuR0J0ZFV2?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A83973FCC0802B48B8512E28D5312118@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0b79da-5b3b-4830-3903-08db2566bc9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 15:05:38.3966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/316ue3xhB8vQOGlyRDBlC0DJj4XLhQyFY5NY2YsE3LebAs8147urkfL01u0aXU5cTBNrvkOp19ldtQWb7A6HuXXUcjpm/dqmWOYn7jbDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE5OjI5ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6Cj4gc3RydWN0IGJ1c190eXBlIHNob3VsZCBuZXZlciBiZSBtb2RpZmllZCBpbiBhIHN5c2Zz
IGNhbGxiYWNrIGFzIHRoZXJlIGlzCj4gbm90aGluZyBpbiB0aGUgc3RydWN0dXJlIHRvIG1vZGlm
eSwgYW5kIGZyYW5rbHksIHRoZSBzdHJ1Y3R1cmUgaXMgYWxtb3N0Cj4gbmV2ZXIgdXNlZCBpbiBh
IHN5c2ZzIGNhbGxiYWNrLCBzbyBtYXJrIGl0IGFzIGNvbnN0YW50IHRvIGFsbG93IHN0cnVjdAo+
IGJ1c190eXBlIHRvIGJlIG1vdmVkIHRvIHJlYWQtb25seSBtZW1vcnkuCj4gCj4gQ2M6ICJEYXZp
ZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0Pgo+IENjOiAiSmFtZXMgRS5KLiBCb3R0
b21sZXkiIDxqZWpiQGxpbnV4LmlibS5jb20+Cj4gQ2M6ICJLLiBZLiBTcmluaXZhc2FuIiA8a3lz
QG1pY3Jvc29mdC5jb20+Cj4gQ2M6ICJNYXJ0aW4gSy4gUGV0ZXJzZW4iIDxtYXJ0aW4ucGV0ZXJz
ZW5Ab3JhY2xlLmNvbT4KPiBDYzogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+Cj4gQ2M6IEFs
ZXhhbmRlciBHb3JkZWV2IDxhZ29yZGVldkBsaW51eC5pYm0uY29tPgo+IENjOiBBbGV4YW5kcmUg
Qm91bmluZSA8YWxleC5ib3U5QGdtYWlsLmNvbT4KPiBDYzogQWxpc29uIFNjaG9maWVsZCA8YWxp
c29uLnNjaG9maWVsZEBpbnRlbC5jb20+Cj4gQ2M6IEJlbiBXaWRhd3NreSA8YndpZGF3c2tAa2Vy
bmVsLm9yZz4KPiBDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KPiBDYzog
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+Cj4gQ2M6IERleHVhbiBDdWkg
PGRlY3VpQG1pY3Jvc29mdC5jb20+Cj4gQ2M6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xl
LmNvbT4KPiBDYzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4KPiBDYzog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+Cj4gQ2M6IEhhcmFsZCBGcmV1ZGVuYmVyZ2Vy
IDxmcmV1ZGVAbGludXguaWJtLmNvbT4KPiBDYzogSGVpa28gQ2Fyc3RlbnMgPGhjYUBsaW51eC5p
Ym0uY29tPgo+IENjOiBIdSBIYW93ZW4gPHNyYy5yZXNAZW1haWwuY24+Cj4gQ2M6IElseWEgRHJ5
b21vdiA8aWRyeW9tb3ZAZ21haWwuY29tPgo+IENjOiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRl
bC5jb20+Cj4gQ2M6IEl3b25hIFdpbmlhcnNrYSA8aXdvbmEud2luaWFyc2thQGludGVsLmNvbT4K
PiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4KPiBDYzogSmVucyBBeGJvZSA8
YXhib2VAa2VybmVsLmRrPgo+IENjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pgo+
IENjOiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPgo+IENjOiBNYXR0
IFBvcnRlciA8bXBvcnRlckBrZXJuZWwuY3Jhc2hpbmcub3JnPgo+IENjOiBNaWNoYWVsIEVsbGVy
bWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+Cj4gQ2M6IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0
LmNvbT4KPiBDYzogU3R1YXJ0IFlvZGVyIDxzdHV5b2RlckBnbWFpbC5jb20+Cj4gQ2M6IFZhc2ls
eSBHb3JiaWsgPGdvckBsaW51eC5pYm0uY29tPgo+IENjOiBWaXNoYWwgVmVybWEgPHZpc2hhbC5s
LnZlcm1hQGludGVsLmNvbT4KPiBDYzogV2VpIExpdSA8d2VpLmxpdUBrZXJuZWwub3JnPgo+IENj
OiBZYW50ZW5nIFNpIDxzaXlhbnRlbmdAbG9vbmdzb24uY24+Cj4gU2lnbmVkLW9mZi1ieTogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KPiAtLS0KPiBOb3Rl
LCB0aGlzIGlzIGEgcGF0Y2ggdGhhdCBpcyBhIHByZXBhdG9yeSBjbGVhbnVwIGFzIHBhcnQgb2Yg
YSBsYXJnZXIKPiBzZXJpZXMgb2YgcGF0Y2hlcyB0aGF0IGlzIHdvcmtpbmcgb24gcmVzb2x2aW5n
IHNvbWUgb2xkIGRyaXZlciBjb3JlCj4gZGVzaWduIG1pc3Rha2VzLsKgIEl0IHdpbGwgYnVpbGQg
YW5kIGFwcGx5IGNsZWFubHkgb24gdG9wIG9mIDYuMy1yYzIgb24KPiBpdHMgb3duLCBidXQgSSdk
IHByZWZlciBpZiBJIGNvdWxkIHRha2UgaXQgdGhyb3VnaCBteSBkcml2ZXItY29yZSB0cmVlCj4g
c28gdGhhdCB0aGUgZHJpdmVyIGNvcmUgY2hhbmdlcyBjYW4gYmUgdGFrZW4gdGhyb3VnaCB0aGVy
ZSBmb3IgNi40LXJjMS4KPiAKPiDCoERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kcml2ZXItbW9k
ZWwvYnVzLnJzdCB8wqAgNCArLQo+IMKgRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zeXNmcy5y
c3TCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArLQo+IMKgLi4uL3RyYW5zbGF0aW9ucy96aF9D
Ti9maWxlc3lzdGVtcy9zeXNmcy50eHTCoCB8wqAgNCArLQo+IMKgLi4uL3RyYW5zbGF0aW9ucy96
aF9UVy9maWxlc3lzdGVtcy9zeXNmcy50eHTCoCB8wqAgNCArLQo+IMKgYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wc2VyaWVzL2libWVidXMuY8KgwqDCoMKgwqAgfMKgIDQgKy0KPiDCoGFyY2gvcG93
ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy92aW8uY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKy0t
Cj4gwqBkcml2ZXJzL2F0YS9wYXRhX3BhcnBvcnQvcGF0YV9wYXJwb3J0LmPCoMKgwqDCoMKgwqAg
fMKgIDYgKy0tCj4gwqBkcml2ZXJzL2Jhc2UvYnVzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKystLQo+IMKgZHJpdmVycy9ibG9j
ay9yYmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAzNCArKysrKysrLS0tLS0tLS0KPiDCoGRyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVz
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICstLQo+IMKgZHJpdmVycy9jeGwv
Y29yZS9wb3J0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMiArLQo+IMKgZHJpdmVycy9odi92bWJ1c19kcnYuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0KPiDCoGRyaXZlcnMvbmV0L25ldGRldnNp
bS9idXMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArLQo+IMKg
ZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgZHJpdmVycy9wY2kvcGNpLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArLQo+IMKgZHJp
dmVycy9wZWNpL3N5c2ZzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgZHJpdmVycy9yYXBpZGlvL3Jpby1zeXNmcy5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4gwqBkcml2ZXJzL3MzOTAv
Y3J5cHRvL2FwX2J1cy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQyICsr
KysrKysrKy0tLS0tLS0tLS0KPiDCoGRyaXZlcnMvc2NzaS9mY29lL2Zjb2Vfc3lzZnMuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKy0tCj4gwqBkcml2ZXJzL3Njc2kvZmNv
ZS9mY29lX3RyYW5zcG9ydC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArLS0KPiDCoGlu
Y2x1ZGUvbGludXgvZGV2aWNlL2J1cy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDQgKy0KPiDCoGluY2x1ZGUvc2NzaS9saWJmY29lLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICstLQo+IMKgMjIgZmlsZXMgY2hh
bmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgODggZGVsZXRpb25zKC0pCj4gCgpbLi5dCgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BlY2kvc3lzZnMuYyBiL2RyaXZlcnMvcGVjaS9zeXNmcy5jCj4gaW5k
ZXggZGI5ZWYwNTc3NmUzLi5jMDQyNDQwNzU3OTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9wZWNp
L3N5c2ZzLmMKPiArKysgYi9kcml2ZXJzL3BlY2kvc3lzZnMuYwo+IEBAIC0xNSw3ICsxNSw3IEBA
IHN0YXRpYyBpbnQgcmVzY2FuX2NvbnRyb2xsZXIoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpk
YXRhKQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcGVjaV9jb250cm9sbGVyX3NjYW5fZGV2aWNl
cyh0b19wZWNpX2NvbnRyb2xsZXIoZGV2KSk7Cj4gwqB9Cj4gwqAKPiAtc3RhdGljIHNzaXplX3Qg
cmVzY2FuX3N0b3JlKHN0cnVjdCBidXNfdHlwZSAqYnVzLCBjb25zdCBjaGFyICpidWYsIHNpemVf
dAo+IGNvdW50KQo+ICtzdGF0aWMgc3NpemVfdCByZXNjYW5fc3RvcmUoY29uc3Qgc3RydWN0IGJ1
c190eXBlICpidXMsIGNvbnN0IGNoYXIgKmJ1ZiwKPiBzaXplX3QgY291bnQpCj4gwqB7Cj4gwqDC
oMKgwqDCoMKgwqDCoGJvb2wgcmVzOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0OwoKQWNrZWQt
Ynk6IEl3b25hIFdpbmlhcnNrYSA8aXdvbmEud2luaWFyc2thQGludGVsLmNvbT4KClRoYW5rcwot
SXdvbmEK
