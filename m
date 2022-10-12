Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA05FC9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJLRAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJLQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:59:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27F72B2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665593975; x=1697129975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FyXgYW92sVXgSYe/1zhKIObQu9eZtik4LjsiYeHiR9o=;
  b=gr+b3m9BnRu2Zf1zfHxVXOhd19UU8C7INHwShRMuhrMwQKp+R1eT1MDb
   keavLIHITBUFwmpgdS0U5yfOtjBpp9hTmAoPzGBwtEV9RRNAbuhYTg8Uc
   eP2lP6XbR9iNr5I4k5y+7TdFih9/1XiKWypKg3JEiSrcLJ3yq8NFT4SKp
   yEMWBQWF4VOMkSGhjqy9VEURs5xM4ChCgrC1tRwIB8+hSXOn/3Qu3MHuu
   7cbnw47kiacwhs4usC1LCOu02dJeoBMv0gfX/d2LyKJn7oA0DeYQz1yy7
   CdAjbv7mVIPPSGwDT25bOqcGEeVUTac3NIlhIu1IaGi1ZiUEJMZA63uH4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="288117240"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="288117240"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 09:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="715990672"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="715990672"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Oct 2022 09:57:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 09:57:23 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 09:57:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 09:57:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 09:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8Ue4DmnuWdTQk6/MD1UAROgqebXMHTIWQP+U3WsnxNk4+/du65bMg/f4BON4eTF+MHrVHUsetJtY21BnT04/6Jh4fVmFnuT8xsUwDiIPQVbVRhdaSOBeCoshKOYiMwbqCrYdAqRmzdIMtFn5S0uK0J+EhybwesHmVnNwPRW+OieA8qnSHM1gXgPhcdKU7T6jjFNgFwZsFeAcFw4hF5qW1LecGBXpPagFJ1arOMERb6150YGHHNmGd/Arv3As2ISLx2VRKm6e6R960XcV3sRqq06pXjvZY0uQct2NGBX9CWUTcv9tr3D9cjiQFYut3bswf5oaOKbzVQnTz9SMB3msQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyXgYW92sVXgSYe/1zhKIObQu9eZtik4LjsiYeHiR9o=;
 b=C85qK7xZKnTxwijV3tNDVfohbiZb977/J02Ew7dNEifITKPsNPyufW4l2mqw/pvMrGkthOAsv7ULlFMhHhQgWINUthxV8r6M2w2oHgOqjCEnh/joB8iBHVU9+sO9cu1irCOIh7m+KR12crZBh4Y3RGWFY8FRBAyAdm2FWKIq6deBuYdF44TMGreemKELeQ4r3M02dNpSxL5FaetUdFZ+dOH2EZ6A9Ovz25bdQjVvQ85EYpZE8uMsylHuIcSIVUE1+1EjNT73FpCZh5cVR52EHhO1IZ3IUw0c4bgC6w911ZWUnSBDe4bRTde9QkZNZxOu+WiVEh2DWKcoMKVDqgDKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 16:57:20 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::41ec:63f7:b996:ecaa]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::41ec:63f7:b996:ecaa%4]) with mapi id 15.20.5676.028; Wed, 12 Oct 2022
 16:57:20 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Peter Newman <peternewman@google.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "James Morse" <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "Gaurang Upasani" <gupasani@google.com>
Subject: RE: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Topic: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Index: AQHY2jkmvJhDFvNe+UOP5fpzrFAn7K4DELqAgAABLdCAAB4mAIAFHX8AgAJXawCAAFoTgA==
Date:   Wed, 12 Oct 2022 16:57:20 +0000
Message-ID: <IA1PR11MB609766CD48E8A78F7C99983B9B229@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
In-Reply-To: <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
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
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH0PR11MB4854:EE_
x-ms-office365-filtering-correlation-id: ebe1df41-217c-4833-470b-08daac72d3a1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjkxPBeV4Svy4z6vdJKpjy22o3XmZqW58N/k5EhN9ssF9guy069+zJdWjQ7lkfAiyBSTh+jqFbw/s2nZX81fZyiI6JEFoBzIDWlMfAhkpkaSWHNV7r+WBNc3paHHVRTwTvKbnH9f0Isyqr4PFX1J1IE4hoHFKWTxAQgNxAi0yXXD+FD+Nk2wRSZt5CzjPL1qlYPSRYSmbsndW8fKAVKAZkareM3/yxNXE/qIBxWp0kXn/AcpVHy2rjT1TcjW6AujeToGfFa5K94l4mLtEH8SanMt6Ap5ixdjPbhYxmPuxMWSuB3LTDJAn/JnjKdJOSLH9pcBAb9UDYSwtrcEEvKaXG5w51DMfIw37fAWhDBUZ1h10bRyLJBs3e44MGdmdoF89m9oPhVQV44bf8czxfl/IVXttagcbtXMuq1qDmRxYJDqZw1Xm+N7dvybNk5ZVuXwFXohjny+n0ir5+K+awJ1+ZyguRDLOJLVry1arYCFIaKshzdya12oiESvnYpCUTIZhSQneuv4OB7vmopXSgM8T9WH7hFBw8uY+KTNLE9NQ4Yd9cm+FK1ru6PutbdAbPkNEbjJN0Q1+n1KAYyHyOgtllB1qFLhkKCjkMeAfuk5y/JGO5p+V77PbeqBe/x9rVif1s7bQR9yRiGp1yiILXx1ngrCD+12dgE9Lf8tfKCOuMjsAL2dTOxEjgy365684NA1wrCybNn18RbOdfxWUT4yKC0EoCzkB4YjtSFiSoypFGXRfdInmFN+sng74xFBq3wBXxZCTo5fXfoXB8jwiyN+CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(6506007)(26005)(33656002)(7696005)(6636002)(186003)(110136005)(54906003)(2906002)(41300700001)(316002)(122000001)(38100700002)(478600001)(52536014)(82960400001)(9686003)(8936002)(38070700005)(86362001)(76116006)(66446008)(4326008)(8676002)(66476007)(66556008)(55016003)(66946007)(64756008)(71200400001)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZMeHgyK2NLeXQxUVZ1Rmo3WVl4Y3ZNQk5wclpqT09namxyOGcxT1o2RmYx?=
 =?utf-8?B?Tk1yVWdmcWtoWjRxdWFmb0I2N21sejRldllvTEJ1NDNEOHJFbWtrWXFvMERP?=
 =?utf-8?B?RmpFUUR5dVE0OUY3bVVVQnZSazY4YTYvbE5oZDlKV3EvRGhnQmFQSXdRMjJL?=
 =?utf-8?B?ZnNpMkJtUjhUakxEYVlKanorU0tIODVsNmVpSGNvTDJ3aHpSWWlKZ21JVHB1?=
 =?utf-8?B?QlBYRmZ1SklxVkJJQ3pZVnBia05kRERvMHRoOEVMaldTQS81czMzaUxIcW1E?=
 =?utf-8?B?TmZYd1RsMkUwNkNoWTJoUnNpVXpqeldNVGlSVExLUUdsVXRmQnl4dklFVGdY?=
 =?utf-8?B?bDRzUzgzWWh6T0pNRFMzci9SZGJISnZiNTN4NmpNQmRaMXhCV2VycDF3QWZZ?=
 =?utf-8?B?MSsvSXlCd0JJZkhJM1A0VnFUTkdvU1ExZU5xOVRJSUZiMnhsMVpoZUE1Vjlz?=
 =?utf-8?B?Q0N4WVhubGloT3VydUlEL3p0eE5ackhHb1dhVDk0a1hFejU0bGd0YUVhOW42?=
 =?utf-8?B?OHQ1emN5R1RrVVYwR3g3OWtZd09aUUlZSGN5T2xPLzZHNEgxNE5BOC9KMDFD?=
 =?utf-8?B?OFRJWnIwRkUwNy9yd0R1dHE3M2pVMjVuRG0zV3JidlR3Y1NkR3FlS0JBcnJv?=
 =?utf-8?B?bFhvQUttc0x4QzVQdDdEWGJ5dk8yMkVNNFBhdy9peUhMVFFrZEhxcWoxeXRM?=
 =?utf-8?B?a1pjTVh0clA5cWVsNVYwbVk1MDRBRHZJc01JMVBSQ285S2U2KytZOGdMYXgx?=
 =?utf-8?B?NlhVSVF5cDhwMFpPMjkxdW14aDhPUDBBYjR2N0tzQ3ZZRjVHQ05Ocm9RYnpn?=
 =?utf-8?B?ZUFoclBsWmhGMWI3cXVyK3dmOHNVWVV4ZW1NSjNzc2pJcjczK25OVS9FRjkv?=
 =?utf-8?B?L0RmVVV2SjRjR1lRaVNYYytvQWkzeEhCZklhTmsydjFFaTlESnB6Z3NvemR4?=
 =?utf-8?B?TEdwdVNGaXZzaWkwV3p0MVZXMXFoMVpPT3M1V2VxTXJxT2k1YkZ1aUZ2cUlC?=
 =?utf-8?B?Y2FiOUdleCtad2tRTm9NekdTY0Y1Ym9GSVlPM0s1bnNBN2lOUjMrSnZqNHpz?=
 =?utf-8?B?emlkSlZaaHhPRGxRd1VCNjFSM3NOMlhOekpTcndlV2kyelBlRVR2MUhKbjJz?=
 =?utf-8?B?Qk5yTkt2eHFKTVFXTjI1Z0EvTndQM0s5WDRHeXJVZFJmSXErZW1OdjgrOTQv?=
 =?utf-8?B?anlEZ0NSeDFQa2k0TkxQaXBlQXBrN0QzeDFYcEc1ZExQM09VYm9xNklqcjUr?=
 =?utf-8?B?TFdIeTlnOEJCZ1FLQ0FSZVJ3K1B5NnB2TDFBUkFMc09udVIzQnRNYXVKQ3hN?=
 =?utf-8?B?ZVRpLzdVVlpmbTFGMHo2dlBKK3J0aGhObDUwNytIMXpVbmZsSUdXU2NKVnVz?=
 =?utf-8?B?Nm96RkhsRXRNUW52NHhKa21YQ1ZmbXg3Ukppb2lQZmVKTW43Z2c3LzIvZHR3?=
 =?utf-8?B?MkdoamQwc29qVXM1Z2VmbGl0TnRrNmlST09wanM3OVBIVGE1cFhkSHNLTkhh?=
 =?utf-8?B?Y1dwNG5OKzJwc3JRVGRKNVlteEYxK1ZUZVBKTHRKb0ZLMlRLT3ZRcUxwSEZk?=
 =?utf-8?B?NjhDcGV4MDBRZm83SHFHcEsxVEZTbW5qWWFtSkduNXMzaGdja1Izcit1dXZB?=
 =?utf-8?B?NGgxMnp4alhma2YxUHc2MGtCYW5UN1FwOWdUeVplbkZNRHUxNzdQMkp2S1A3?=
 =?utf-8?B?NWs0U0lzWmowL1NFam9QZFZiR3RZRFFwZFVwK2gvSzB5WEVTNjNNakNqNTgy?=
 =?utf-8?B?VkVudXBYUVhrYmVQc3d2ZDFRZUdBZ1BUT3ROQUoyL2dqYlo0bEIrMHRURmRU?=
 =?utf-8?B?bXJKb2RibnNkU1hoejhueVVLRW9PSEozNUN1K3prcStWWVV5WURDYTY5Z3Fn?=
 =?utf-8?B?V0twRkVaOU03M0djaU9tNHk3MzVnUjZubWRIMWQ1eUpsdkU2dzdjYnBFWGRt?=
 =?utf-8?B?bFBjRXR2SHNQRGR2TzZyc0txK0kvd3ZVOVpVem84S3pVaEtVdURQV3JCMVBp?=
 =?utf-8?B?SDRLK3N6V0phZm9jWnZlaTFmdFBzRys0UTFaQzQ0S2ZSWEJ1ak5lREhreXJ1?=
 =?utf-8?B?c3d3U21jNXpFbVFsbVFOWjhlaVkra3Z5ZjVqb09LbXdUTkZXYVpVSklpc2NF?=
 =?utf-8?Q?zrSFHOhW9zQIkT61+qolzs9g5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe1df41-217c-4833-470b-08daac72d3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 16:57:20.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsz+fjdHnmoeqCUCw2lCyycpYhuZDlnMXy7J/QQ81PltiXuznpATYe3SL19HDwXU9IL8coNiFWUArh09+lQu4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldGVyLA0KDQo+ID4gPiBJIGRvbid0IGtub3cgaG93IGNvbXBsZXggaXQgd291bGQgZm9y
IHRoZSBrZXJuZWwgdG8gaW1wbGVtZW50IHRoaXMuDQo+ID4gPiBPciB3aGV0aGVyIGl0IHdvdWxk
IG1lZXQgR29vZ2xlJ3MgbmVlZHMuDQo+ID4gPg0KPiA+DQo+ID4gSG93IGFib3V0IG1vdmluZyBt
b25pdG9yIGdyb3VwcyBmcm9tIG9uZSBjb250cm9sIGdyb3VwIHRvIGFub3RoZXI/DQo+ID4NCj4g
PiBCYXNlZCBvbiB0aGUgaW5pdGlhbCBkZXNjcmlwdGlvbiBJIGdvdCB0aGUgaW1wcmVzc2lvbiB0
aGF0IHRoZXJlIGlzDQo+ID4gYWxyZWFkeSBhIG1vbml0b3IgZ3JvdXAgZm9yIGV2ZXJ5IGNvbnRh
aW5lci4gKFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkNCj4gPiBhbSB3cm9uZykuIElmIHRoaXMgaXMg
dGhlIGNhc2UgdGhlbiBpdCBtYXkgYmUgcG9zc2libGUgdG8gY3JlYXRlIGFuDQo+ID4gaW50ZXJm
YWNlIHRoYXQgY291bGQgbW92ZSBhbiBlbnRpcmUgbW9uaXRvciBncm91cCB0byBhbm90aGVyIGNv
bnRyb2wNCj4gPiBncm91cC4gVGhpcyB3b3VsZCBrZWVwIHRoZSBiZW5lZml0IG9mIHVzYWdlIGNv
dW50cyByZW1haW5pbmcgaW50YWN0LA0KPiA+IHRhc2tzIGdldCBhIG5ldyBjbG9zaWQsIGJ1dCBr
ZWVwIHRoZWlyIHJtaWQuIFRoZXJlIHdvdWxkIGJlIG5vIG5lZWQgZm9yIHRoZQ0KPiB1c2VyIHRv
IHNwZWNpZnkgcHJvY2Vzcy1pZHMuDQo+IA0KPiBZZXMsIFN0ZXBoYW5lIGFsc28gcG9pbnRlZCBv
dXQgdGhlIGltcG9ydGFuY2Ugb2YgbWFpbnRhaW5pbmcgUk1JRA0KPiBhc3NpZ25tZW50cyBhcyB3
ZWxsIGFuZCBJIGRvbid0IGJlbGlldmUgSSBwdXQgZW5vdWdoIGVtcGhhc2lzIG9uIGl0IGR1cmlu
ZyBteQ0KPiBvcmlnaW5hbCBlbWFpbC4NCj4gDQo+IFdlIG5lZWQgdG8gbWFpbnRhaW4gYWNjdXJh
dGUgbWVtb3J5IGJhbmR3aWR0aCB1c2FnZSBjb3VudHMgb24gYWxsDQo+IGNvbnRhaW5lcnMsIHNv
IGl0J3MgaW1wb3J0YW50IHRvIGJlIGFibGUgdG8gbWFpbnRhaW4gYW4gUk1JRCBhc3NpZ25tZW50
IGFuZCBpdHMNCj4gZXZlbnQgY291bnRzIGFjcm9zcyBhIENvUyBkb3duZ3JhZGUuIFRoZSBzb2x1
dGlvbnMgVG9ueSBzdWdnZXN0ZWQgZG8gc29sdmUNCj4gdGhlIHJhY2VzIGluIG1vdmluZyB0aGUg
dGFza3MsIGJ1dCB0aGUgY29udGFpbmVyIHdvdWxkIG5lZWQgdG8gdGVtcG9yYXJpbHkgam9pbg0K
PiB0aGUgZGVmYXVsdCBNT04gZ3JvdXAgaW4gdGhlIG5ldyBDVFJMX01PTiBncm91cCBiZWZvcmUg
aXQgY2FuIGJlIG1vdmVkIHRvDQo+IGl0cyByZXBsYWNlbWVudCBNT04gZ3JvdXAuDQo+IA0KPiBC
ZWluZyBhYmxlIHRvIHJlLXBhcmVudCBhIE1PTiBncm91cCB3b3VsZCBhbGxvdyB1cyB0byBjaGFu
Z2UgdGhlIENMT1NJRA0KPiBpbmRlcGVuZGVudGx5IG9mIHRoZSBSTUlEIGluIGEgY29udGFpbmVy
IGFuZCB3b3VsZCBhZGRyZXNzIHRoZSBpc3N1ZS4NCj4gDQo+IFRoZSBvbmx5IG90aGVyIHBvaW50
IEkgY2FuIHRoaW5rIG9mIHRvIGRpZmZlcmVudGlhdGUgaXQgZnJvbSB0aGUgYXV0b21hdGljIENM
T1NJRA0KPiBtYW5hZ2VtZW50IHNvbHV0aW9uIGlzIHdoZXRoZXIgdGhlIDE6MSBDVFJMX01PTjpD
TE9TSUQgYXBwcm9hY2ggd2lsbA0KPiBiZWNvbWUgdG9vIGxpbWl0aW5nIGdvaW5nIGZvcndhcmQu
IEZvciBleGFtcGxlLCBpZiB0aGVyZSBhcmUgY29uZmlndXJhdGlvbnMNCj4gd2hlcmUgb25lIHJl
c291cmNlIGhhcyBmYXIgZmV3ZXIgQ0xPU0lEcyB0aGFuIG90aGVycyBhbmQgd2Ugd2FudCB0byBz
dGFydA0KPiBhc3NpZ25pbmcgQ0xPU0lEcyBvbi1kZW1hbmQsIHBlci1yZXNvdXJjZSB0byBhdm9p
ZCB3YXN0aW5nIG90aGVyIHJlc291cmNlcycNCj4gYXZhaWxhYmxlIENMT1NJRCBzcGFjZXMuIElm
IHdlIGNhbiBmb3Jlc2VlIHRoaXMgYmVjb21pbmcgYSBjb25jZXJuLCB0aGVuDQo+IGF1dG9tYXRp
YyBDTE9TSUQgbWFuYWdlbWVudCB3b3VsZCBiZSBpbmV2aXRhYmxlLg0KDQpJbiB0aGUgdmVyeSBm
aXJzdCByZXNjdHJsIGltcGxlbWVudGF0aW9uLCB3ZSBkaWQgZm9yZXNlZSB1bmV2ZW4gQ0xPU0lE
IHBlci1yZXNvdXJjZQ0KYW5kIGFsbG9jYXRlZCBDTE9TSUQgcGVyLXJlc291cmNlIG9uIGRlbWFu
ZCB0byBhdm9pZCB3YXN0ZSBDTE9TSUQuIEJ1dCB0aGF0DQppbXBsZW1lbnRhdGlvbiB3YXMgdG9v
IGNvbXBsZXggYW5kIGVhc2llciB0byBjYXVzZSBidWdzIGFuZCB3YXMgbm90IGJsZXNzZWQgYnkN
CnRoZSBjb21tdW5pdHkuIFRoZW4gd2UgY2hhbmdlZCB0byBhbGxvY2F0ZSBzdGF0aWNhbGx5IHVz
aW5nIG1pbmltdW0gQ0xPU0lEIG51bWJlci4NCldlIGRlY2lkZWQgdG8gY2hhbmdlIHRvIHBlci1y
ZXNvdXJjZSBvbiBkZW1hbmQgaWYgaXQncyByZWFsbHkgdXNlZnVsLg0KDQpCdXQgc28gZmFyIHRo
ZXJlIGlzIG5vIHJlYWwgdXNhZ2UgeWV0LiBUaGUgY3VycmVudCBDTE9TSUQgYXNzaWdubWVudCBz
dGlsbCBzdGFuZHMgc28gZmFyLg0KDQpJbiB5b3VyIGNhc2UsIG9ubHkgdHdvIENMT1NJRCBpcyB1
c2VkLCByaWdodD8gVGhlIGN1cnJlbnQgQ0xPU0lEIGFzc2lnbm1lbnQgY2FuIHN0aWxsIGJlIHVz
ZWQsIHJpZ2h0Pw0KSWYgdGhhdCdzIHRoZSBjYXNlLCB1bm5lY3NzYXJ5IGNvbXBsZXhpdHkgYW5k
IGJ1Zy1wcm9uZSBtYXkgc3RpbGwgYmUgdGhlIHByb2JsZW0gb2YgcGVyLXJlc291cmNlIG9uLWRl
bWFuZA0KQ0xPU0lEIGFzc2lnbm1lbnQuDQoNClRoYW5rcy4NCg0KLUZlbmdodWENCg==
