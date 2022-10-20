Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A560571E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJTGFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJTGF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:05:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735E31213DC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666245924; x=1697781924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVHVzHmqR3FIIyTOk92urR1teYFbIPllKAENmA2h1S0=;
  b=ZsdDD5Py6Fl4UQac1V94hrks6d4INiEM9zKX35EwDrudIiKapV4oCWzO
   EbntbgcvpIYgy9B03MWG/2uuwS5NyeJ5AOQIRK23bHGPlRVLX/iFEmU5c
   s7fVGGXlqUbibRTSR5FcEoz6ZC+1FKldw2LY9Txsvz/zmv95dfiLkYc0R
   4DlVenYz+NvtlWIkO9Mt7yQU5fuxrkkMyeCVPbkBkiLnO9O6L3EXqUQ52
   Yc95ERtbavkb67cVOI1QtnB2aHiXKGeyTbdlkil3f1mbXmJVkueWSq58z
   SP/RJ0IoluDDU8DJqggLjK5hnTMS7aGxNpnQWu66vPeX7pwXihWqVxVvt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="370825488"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="370825488"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 23:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="629616244"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="629616244"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 19 Oct 2022 23:05:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 23:05:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 23:05:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 23:05:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 23:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7bAmh6vnKwZymu6k44UM6hA7qe5rZCwbOH4mA+XxpuOJiFGUJtquQkl7NcGU3sdb36UBH/PGd3vcBmscK4LPOzYW3k4BGxBWj6InWC6fhVKjQbsJp1fA6AdsSltV6NbMCKThcE0oQsT681EPw49DgBHPrPA3Hv/xKYP8B9SCQpPOd8wDfqH7mUvUhHebRhRzxlGTDTICwPGmJSfOe/L1rw2T+M7PogxT+Y1CTS7VFXUf6ocVFDbvGJeyrJyB/giF1qYWTPwXCig18QchpKlmmfAZLO2RoxBbww5kywf6pv0Xun9i7/2o8bZaMfLd548CD02mQNNb/UU1ti0iN9+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHVzHmqR3FIIyTOk92urR1teYFbIPllKAENmA2h1S0=;
 b=PYidFbAPdjNS/wgrBYzURwAmWAetWKvRhPU7KXUYL2ujzxZFPO0UDC+EC4O4axIZmG8THdOdypi8BPo7W4KRyJGH11ufZFAGED223oVTGW56dCnlZ7kSP/U0TLeX0WwS5ZR49RXnwOyy9po5o1ARV/Jr7WV7pdc58qIlbKtoGtTyQ3NjSdgA9X+dJs2DpRccocjc7ZNdY6123JfrsqV7l2rrRq+3KM8NSuoyfpCCme509xAK3RuW13w9GXbGHylZ7t9l0+RM4BFqCOVXC7ktAy33PETb1dgHbozeWkgMgoKwQCm8PZ3XKil+bkwTL0bTcGw5af1dyp8TIIGjdAohgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by SJ0PR11MB5168.namprd11.prod.outlook.com
 (2603:10b6:a03:2dc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 06:05:01 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.034; Thu, 20 Oct
 2022 06:05:01 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Topic: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Index: AQHY47Kv7yW3S865XEiTjYU/Nl/o964VodIAgABWNFCAAApDgIAAtnuAgAAR2QA=
Date:   Thu, 20 Oct 2022 06:05:01 +0000
Message-ID: <BN6PR1101MB21613786459F40312E2FFC0AA82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
 <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <FDC4F3E7-DEDD-41CC-93E6-8021F16B509D@zytor.com>
 <826853e4-f7ce-349d-c0c0-74516af6ff8c@suse.com>
In-Reply-To: <826853e4-f7ce-349d-c0c0-74516af6ff8c@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|SJ0PR11MB5168:EE_
x-ms-office365-filtering-correlation-id: 31e8dfc5-1e57-46f5-4fd3-08dab261066a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uIV6wmiGYItfV7xba5puJWsyWPSingCEQy9erMpshj/rkCL6+AgVskJCn0DlwTAj5gOlOfU095q4AqCI+mhAlAHjQlFJMIodbzaR/+wrJTUYvFNedsj/1YxB7Ht3frjGuOwVIL/0lh+dw7c1hpUIWkGZ49PRgZCkFlIG1UrUrdmrDYE0jVJs0pOrdE1ZMdDoiKf3eZlltdq72nQJqfiCIPzOlmpX1ZdYa5REaOrQtv5MVjZrwdtCv4SkZlMFblN/Vpil3UC7dCrHoJEKN+F+0/7+TU0MHEptFA5aQYrVFm5R/V2rDN+HCXa9cAgH3/T6/JI4p2BUTggY3AHetaLtlrHbvG5ZgCX3JpBtcNgfw7OE4PqALAOrb0kN6X5e1t8V+UBUtL9u6IarIRFVQ4IIHN/CLED8axOJ29gVssjdfKNcaDvyB93IojBjs8px5avRr/uu5ADiTuATRkEaGRNeYZ5q6G1AcnZ1ABdv5YFa8AcnWSAbT3pQXoISFeknxdcWMktzPJR1stBpFvGCjBx0t+ksv/Y18sncSTILNCSNIh8r+CvpyS7ioqkIULTUoqtOo8eY+rSrnP089GrKhEp/VjZbeKRfXrSIYfhnli8tqZzJ13zAcx+J+6TiKj6eOjRgBddfkRiaXAIw5iZ9lMlvxpD9GVwjROIuvMGHbW1S6ibMAW9qaAY8GCFZe4DIHFniBKRfmfKYcxgj8brjJHlo5bOONdTLF1Q2JOG37ysD0xrW/3cJsI0vajPcwcfpeelnR3RqrLaNfa58WTfmm79ZZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(26005)(316002)(7696005)(52536014)(54906003)(8936002)(110136005)(9686003)(86362001)(33656002)(558084003)(4326008)(66476007)(8676002)(7416002)(76116006)(64756008)(66446008)(66556008)(66946007)(41300700001)(122000001)(186003)(38070700005)(55016003)(2906002)(5660300002)(6506007)(82960400001)(71200400001)(38100700002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDBtTGJkcVJIMEtHaEwzS2ZLUnJpQ1lWbjlSc2pSWmlSeGVmdUoyREZaWEdk?=
 =?utf-8?B?Y2hhTUFMSUVydUZNVHhPWUc5c0NrVGRGNkFBQUQvMDVYYUZRcXE3MW9vczd2?=
 =?utf-8?B?ZlpGbGJsS1pLZG9zVXozMHladDkySGxZcGQ3RS92K3NHa3g0YStST2ZHYjJu?=
 =?utf-8?B?SjVZNTdnWWdlK2dUVXpLOVo2VVpjejJ2QmIrTzBxOHJTS0twaWlBZkd5NWo1?=
 =?utf-8?B?VUNTQkZhTXQ2ZzBXZ1RjQkppa0lwSzhkUEQvUk9kcjBwekkxVHFuQkFIeEpZ?=
 =?utf-8?B?ZWk5THpIV3VpYUV1UVJsVUlveHVaQmUxQ3c5SmpUb1IwenNpMU9PZ3FiUkpv?=
 =?utf-8?B?TGhXYWc4SGxPTHplNnNJYmp6ZUxJWllpa3BMcVVMUEhDWFBpRTE4OUpHS2c1?=
 =?utf-8?B?bmR1OHcvMUJnWEp6VWkvREtVbHArRE55RmQyNTdhT2dHanRCUWdrcEtkOGta?=
 =?utf-8?B?ei9PUVRtZGlnOGZTbGJRY2UzdUlpZG5Zd1AxVnIwS3JRL1N6SlZ6NjNDSWF5?=
 =?utf-8?B?UnBjYkl3MThCRkRYaDZObER0SFl4MlNFVVg5Z3pGRStiMFVRcDVQODFsUlZD?=
 =?utf-8?B?Z3J0N21EalppMHV3djZTOWRyUm5XRldtZXUwN0pkWGUrY3lSSHhQQmNXSWlV?=
 =?utf-8?B?WmREQXlZK1AxUndkZm9ScHVCY0UzelVmRk5tUmsxTjJLdDY3b1lvb3R3eFdD?=
 =?utf-8?B?NnVNajg0YWgyNnFaNVUrQlF3cHdnZEJ3NFpmOWZhRXVJQmFVYno4bGEwSkV1?=
 =?utf-8?B?TG1WNWFyMGxHbXpXd3AvaWFSWUlQeWFTNmI5UkowOFRGaldBSWF1ZDFWNG5z?=
 =?utf-8?B?TlhIMzNjamJpR1RVc0d4aCt4YTlIQTR0VzFWQm5ER0UwMWY1SHpRcndROEdM?=
 =?utf-8?B?ZEgrVC9JNjRYZUMxQVlOVXNmMVRsVnVsUDZ3V29DU05CSGpxU2h1MDF2MEpw?=
 =?utf-8?B?QUc2d3RuOWtLVjZxUXJ0S0RxMm91UWNDWW84TkxKY1I1WnRMd2tqMUpyK2lT?=
 =?utf-8?B?MDhDdW8wVEYzNzJqUTNSeWdQRUZaNVMrYUlOVmsvc2pNU0cxeUk1L0hvbGd2?=
 =?utf-8?B?b21BdFNiWk9hME9uZzVCa2hyYnBUZW9pR2FBWmh4WjlKMWVMeTFSQkF6Wjl3?=
 =?utf-8?B?cUVHL2phVkZWY0xVaDVveUNuQSt6elJZUTBJSjdEZGJNc0cxY0RLOE4zdnBD?=
 =?utf-8?B?SXEvM0srSnp4M2lPN2tqSXpFc3FjUVpiK2MrbkZnQVBFZ2RFTUNQdWt1MHNm?=
 =?utf-8?B?Rm1td0lxUWZRbDdiajBQR3FzeGVVKzQ0Ris3WWZWOGNHTzdRZ2VKMzlueEk2?=
 =?utf-8?B?ZGZrVFRydGM5YUZYdUJwcGsrQTQ1cFd6VUs4MnFLSnpnOFNWelFHc3J5K1NC?=
 =?utf-8?B?b1Y2M0FBYlhvbEJ3aTZpUDBCRk4wUkljYlVqbDZUVFZKclQ3NmF1VDlZazRt?=
 =?utf-8?B?cTZnQXhCT2U4UXAxb3NPUlBKVTBYRVFXVjRvN29TRUUydDIyTTJrZ1A0bndD?=
 =?utf-8?B?aEcxWWhRRmxSNmF2M1paRlZlN2RacER0TE53VWhOOW11aERkNi85SWNNd3k0?=
 =?utf-8?B?QzZnNmFPeU5qcDl1ZDhMbG5xRzY1YTV4WWxOYnU4bUZvd01aWEg3TTlteHFD?=
 =?utf-8?B?M1AvZytQRmp3VGZmekhhUVBhRXBrL0ZJK2crQk13b3p5S3Z5bDZ1YVArc3Bn?=
 =?utf-8?B?QUVVUzAwcWxmVmVaUWhST1RXSlRmc0NEOVNNbDlKcmU2Zmp6NDVhRHprNlNZ?=
 =?utf-8?B?L29uQm9KOTNyQ1lzQWN1enlweVAxOHVqczlXNThSMXFtVkwyMmorSUI4dnVp?=
 =?utf-8?B?NmlQczgxYSt1Q1BzWWZwQVppVnNtbW1LYzF4KzA0T1NmMEdwT1hzRG1odHpX?=
 =?utf-8?B?NmsybUp4NTAvaVE3YUtLOXg3NWRoSjBtN21uUFBrYlhFQkZCQ3ZvZFV2Y3Z2?=
 =?utf-8?B?SmNTNXdyakxGUmc2b2ZpVGRndTJLMWJsVEh5L0FRQVdnY2x3SmM1WnppTVRo?=
 =?utf-8?B?V2x5S2ZncVAvZzNva2VBeGM4VlQ3d21rdENldFNoSEx3S05rME41bEhWdytv?=
 =?utf-8?B?STQ5cVhHaGFWRzI3bDA2NVZ1RkpXam1rWmx3cXJlRTg3RUVCUm5XNWUyOUZt?=
 =?utf-8?Q?oKk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e8dfc5-1e57-46f5-4fd3-08dab261066a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 06:05:01.4923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJuhhU8NkgAX6hR4c5ze38TMzEMFSXRjg4n7dFUK4wyOwmo95zY6z12xbDhuL7T0n7GcueuFn0y7D78QYzG8Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4NCj4gPiBNb3N0IHRoaW5ncyBkb24ndCBmcm9iIHRoZSBwYXJhdmlydCBsaXN0Lg0KPiA+
DQo+ID4gTWF5YmUgd2Ugc2hvdWxkIG1ha2UgdGhlIHBhcmF2aXJ0IGZyb2JiaW5nIGEgc2VwYXJh
dGUgcGF0Y2gsIGF0IGl0IGlzDQo+IHNlcGFyYWJsZS4NCj4gDQo+IFdvcmtzIGZvciBtZS4NCg0K
VGhhbmtzLCBJIHdpbGwgc2VuZCBvdXQgdGhlIHBhdGNoIGFmdGVyIFhlbiBQViB0ZXN0aW5nIChu
ZWVkIHRvIHNldHVwIGl0IGZpcnN0KS4NCg0KWGluDQoNCj4gDQo+IA0KPiBKdWVyZ2VuDQo=
