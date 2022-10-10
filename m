Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297FE5FA47E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJJUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJJUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:04:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF87676D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665432254; x=1696968254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uqB580kq00Z7ek5RtSxeVv1KvTy33hT7+0H6GrpnT8k=;
  b=bjlPUQwg1HX9ZwXDFxmX2HExyl82R/MzF62MEMinszZmBh7/CyUjuqA6
   hn6atlkhxaujoYKRLvQk3eI6BjX4t3Isw6viVIEGoWKmYSh/jObOHPASs
   rEGithLCoj29q+mA8TLJx7ZPNy/BXvENADuHz7/Q1wDsz6zdEA1LQ4afk
   5WfYUsUaUwxCizM1pU45yW2UY2jcX0iueu0mhhB0eJBIPuNktnamgBt5p
   Hqu0K8Ub+LBK2vM3R8hVSVgGDarQ+rK0A93eeL10tViwxaZlD6Z854v6u
   KcoG4AT8BOISqcHMPfPPYeArDdepX26ePxVfnOEDMAHA9lFNggJNK+OoH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287586398"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287586398"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="694781631"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694781631"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2022 12:59:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 12:59:15 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 12:59:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 12:59:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 12:59:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRqxvJWfR2z2KP3DND2+IY4CUEn5VJCTmDiZN26pIrw/tAzvAJCQ4h1PadhLI0CUnY63/0bBmnwWwXNPyvyDIa1+W0ul724TV+upZELD+eLjJhmxjj+PgJUosAk3UVJMNcuVhswTUL9wxBl6sk0C3p7T+ga7CxuprN6DJdDB61i5OteMhuLNiNPKPrAMTNaD3y093VP1uuP7Ts/9GpYY2YsJGbVnKpLQQ0aJue+kitamqlu2I5GBwZBAMoMMeNzQyVXyfCZ6Wm9kNTfKgX1mjJjVxYr0DxgwbUK8bXSsygehwBto2sE+w0sSFzzh849BwJLumJpY/ErMNvVXvUDoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqB580kq00Z7ek5RtSxeVv1KvTy33hT7+0H6GrpnT8k=;
 b=jT8oZs0HYJyWIN+zgYpewzVcApqZLJfkVS6Bfknu7aDmftEP9GqFOSKoGHBIjBjLcsT9tlnGtCtRB6XZ2KnCjyboooagPfzD3SEqA9JhNljNeRlJxJbuOvR7VYzrVf00LusVDgtxd+pikeZ40s2HYSwwR8BjyzG5F84zzEyZggDoF2Y97EUvmTnZkvTrseNPjFqgcUOj8kUZ0M9hEG4IGXxK4NPEWpLCacXmhLuniEjPYtDTcqPhRnWm4xhR4ke0bSYQfs8O8rh5eis+gttbNmObr1QQE+/+y75EbeXR59LtJqRYY+FnT2/w6Bw6mai21AUh3npTCO1ULinLMqN4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 19:59:11 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 19:59:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "songliubraving@fb.com" <songliubraving@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 1/4] vmalloc: introduce vmalloc_exec and vfree_exec
Thread-Topic: [RFC v2 1/4] vmalloc: introduce vmalloc_exec and vfree_exec
Thread-Index: AQHY2qcFG8hSD9xDFk6RFr9wUYNvpK4H8qoAgAAOSYCAAA9EAA==
Date:   Mon, 10 Oct 2022 19:59:11 +0000
Message-ID: <36141d5a3c61d1cf39d9abe50ee736642e8ae0a3.camel@intel.com>
References: <20221007234315.2877365-1-song@kernel.org>
         <20221007234315.2877365-2-song@kernel.org>
         <53f0f3feebceead8a40185a5fe59ab15f8bcdcb6.camel@intel.com>
         <F038FF61-C131-4FA0-8F19-647A3486A3F9@fb.com>
In-Reply-To: <F038FF61-C131-4FA0-8F19-647A3486A3F9@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB4947:EE_
x-ms-office365-filtering-correlation-id: 857b0ac4-1fce-4c61-91f4-08daaaf9e653
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdYxEVaRZ+oSxGhEd9xBH7dpCuB0u7vwPlaN76EqWfVd/tLSQsvE1P0XRP1+y4+TYFSUGv3UdeDwEiI6TX8dO0+4K9a4J7cx1VZ95GJ6J/ue0dP7ecyFeZOeW3V7gXAJ4gtpHLkFtVInLXCBC8zFR40nIPVL1lUB/horhmBCfDIBxpph8hST81eGd6Qpk4DFfr152OytS7OREiN2UT8QDWqlnSVpW9g/uVHPxF9vuovzKKBMuT2Ro5o3Hh7nI/UWjmc8V9RzyJYOiU64ubWhPbIPac5yyXH79EcJxcUheo0HX/y8cTQ5rlJP0Cp4/BZAc7d7CD3lt5xPeOXn24PdDE+WnV8z3koGNQ/nnZOlfObrjI/7ACnPFKbYtb7LWJHs0K639JSlJzvzkScPQWf2ZUalvRG6+Vg4GGAydcWVjcLvXNq9s11KgldqaDaTVe1A1IivCMZ8BIh2Wf0XC9J/OWEZR7SV+PTEjogDnP4XYYeO35bBHChwe4CnPrdGQxo4tCwra3vxD136o5Gaz96beVePMq6nECgGHdmTvZiq2yW136vM1tE02UbAFgzcND2RIQESB0c53v7o4aZIU/PbR0OapCKuRH4uBz/vhDp6ALJKF9ohtYNAkaGdDdpRFGyByflIwm6Fyr0Bg57syDnXuJNmHzijB71fWZHm7Rk2s/K/nK9978h0/Hai+135p2rU7ALmyUJm49ednKgLFA7A3FtdMMZDuGp9m/kVhQmTx3PEciLHQA5DSUaFVRe/L8x7wEHm5/magBMs7AD7g5UBSQb69eIBln2MPtQo5ZNeU98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(6506007)(53546011)(26005)(91956017)(82960400001)(38100700002)(66556008)(122000001)(316002)(71200400001)(8676002)(66446008)(86362001)(66946007)(76116006)(4326008)(64756008)(66476007)(38070700005)(36756003)(186003)(478600001)(6486002)(2616005)(2906002)(6916009)(54906003)(4001150100001)(5660300002)(8936002)(7416002)(4744005)(41300700001)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmhJU1ZqWVVTSGJwT2ExNW9UMHkvQ3Q2R3pGOWpzS1hMNzA3dDdrNmZpcVkr?=
 =?utf-8?B?ZGhLRmZWdFArUnhQb0doVVBMNlgwc2ZzZ3NhVUVNaHRKcG42OFR3dVl2S1Fv?=
 =?utf-8?B?RGpGUUxLejhDN0NsSjJlNWpReUNyWVV2czZWVjkrN2xSQWZ4MmthVUJ2Skhq?=
 =?utf-8?B?ZEtTMUV6Slp3Zjh5TFZxU0FkWVNhQmcwOHJZYzRCZGwrVzNtbFE5cnNDNmd6?=
 =?utf-8?B?ZkVtaHhOcTZ0ZllFOXRLY2xCSmVseGNFYmEvdTdmVUFEU0syWXJ2MzZ3Wnoy?=
 =?utf-8?B?bzZ2Um9TeVlVcHk2K2ZUQ1JkL1pXMnBBcTA4V1B2UjQySE95dnNUTXVwUkhk?=
 =?utf-8?B?QTlZbC9pR0NJZnNJdEQvK3djUDh5WEJDOHVSUTEveWJoVVQ0TUl0bDM4U3N0?=
 =?utf-8?B?bkFaYnA1K0VLLytBdzVFZWJ5RGcybURJaW5QVUYvQzFLTjk1b01MWFV0T0ZV?=
 =?utf-8?B?WTA3Z0ZpVncxVDJvL28rUk9IQTVCV01zbzlUS2NCLzlhNWhPelI2cGwvTG5p?=
 =?utf-8?B?QVRWYy9rVUdkdEpiMTZUSW9LYXVQRk42eHFnU3NxdVpTdGxENG44all3L1BL?=
 =?utf-8?B?eFN5ZGpGRWV1TXNaeFdJVlhRakNBVk1XWUErbGtnakI5S1YrbklZM2QwMXJu?=
 =?utf-8?B?aitCVFRibWNLSVdPcnJVd1JQclU3bVJ0VnAydTNuZkpUZHQrNnVDUXMwK2FZ?=
 =?utf-8?B?WlZUT21rL0JmRUhOVGdjbmZ0TTZoWE9xbm9jc25oWk5wODhxZUJzTWdrVUxF?=
 =?utf-8?B?aERtMXpNRmRmSXFHaUdNK2R5a21zYzNrVkVNWTNHSldpemd6dkU2ejFNcVRq?=
 =?utf-8?B?aFd6a2R2b3lsVlVPRGRMQnc2ZjZnWDhlb3h5NFpsek16NUIxb3cyaExJc0tx?=
 =?utf-8?B?TkFiSW93K2srbldMOEh1a2F1eHpoTGhybUFiK09UWU51c3cxQVNNUkwwTzBi?=
 =?utf-8?B?KzZvMVhDQ0kxWEh1blkxdHJQeDcxWnczL2ZtaGRidXJVMUtNVTJheHhXVkdx?=
 =?utf-8?B?VjhjajFNVTFwVnA4dDlsZ0JocUt4amFpTVI3WW1TTEN4d01RRDlvVXY2enlw?=
 =?utf-8?B?YjdSamlUU2RBWEhzdjJDZzAyNkZMMnFKdkZ5ZmV5c2krVXZJTlExb0lPM1p3?=
 =?utf-8?B?YzA1ZGdaa3NyNFM3N0tUdzFQK0tFR2R4bktNSE0xand0alhCVnpsOWsyd1NF?=
 =?utf-8?B?ZFVYRVAzYTYzcDZ6RktWRjFueFkvQ0M4dE05VWprbjBvMjhpbDM5ci9XSlRo?=
 =?utf-8?B?dUJ0QTN0a1J1cWQyTVRaOFZQV2FuL1dmOGtYeERoUndVajA2UDZRUW5MSFRW?=
 =?utf-8?B?a3dqNGgxeW5IaXM2RWtRTVFlTVR5RzlsNGtVeloyNUJ0Q1M2UnAwQVVjK0p5?=
 =?utf-8?B?UWZDcWJZZnBzenM0dm5HUXFhOTR2czluQzdRWFRQbFBTNzREeUtRTGNHdDU5?=
 =?utf-8?B?dDFVRFUvU3VZRTFCNUdPa1phWjNJVU9YY3lkZkFOSlVYMGZ0QWtqWGgzcjZ2?=
 =?utf-8?B?NXluTGxjb3BBNmJhUWltV0tTNmFZK1pYZDhiQW1TcjlZajNUN1ZXajJGLzVS?=
 =?utf-8?B?OVU5MDE4aUlndDl6emFRZzB1cTB1dGdTdGpjc1RzaXpWUVhhZlVGNWlCM0Za?=
 =?utf-8?B?dEFXTEpraFdtTUhqVk9yQ0FPNzdnMEpYZVBRdXR4ZG81WlNQSUVuR3ljTmxT?=
 =?utf-8?B?QVRXSXZVNkgvTDd5L1M5VHgrNEgwSEUxTWVwSnVRUUd4elc3N1l5UWZ4eUh4?=
 =?utf-8?B?ZEMzOEtyTEVvdjYvM1JyUGo4elF3VExFdUVmdVUrWjVMdGZuVXFqK0tFbXVC?=
 =?utf-8?B?N0JuYldTL1NLUERKNk1OQzJjNVRNLzZoZCtDQ2M3TGFONjZ4ZFYvSzhjcEw3?=
 =?utf-8?B?WHJJZ2V6dHJ3UHVkYzhEajQ3eU9tVGd1b1hvdENSMm84U0VxaU95amRHYU0y?=
 =?utf-8?B?Slozemw0bUlsSXZyR0ZUd0lnWjVSczhaSk96L0dvc2ZSQ1oxL3ppSm9qMWha?=
 =?utf-8?B?VVBibVBMUmw0UVdaQmJLZmNhVXF6U2Q1d3BiZlg5cHlSdERKWVR5NE8vVm5R?=
 =?utf-8?B?TTJURURkcnNBY0FUMFNSQWdTblFHcWFXUXJ6VzZoUUdMUEl0WGxUMFVoR2Vj?=
 =?utf-8?B?TzVNNFAvZkFUY1d4NDJ2cTgxZHhwOE9jRHdzNEN4VTNCUmRneG1DUzBpUStD?=
 =?utf-8?Q?ldwswa5epVSYSav2G9RcKEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A3DDEB836E6C94B9403AB97B0A1FC78@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857b0ac4-1fce-4c61-91f4-08daaaf9e653
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 19:59:11.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIxDKr1LIz7aDYkThaRWVjNdAFPfHhLVtPLjvFkAkLp5osIZAxlvsCQlsiE9yrpPHkjWJACTOr3/rYEx0CyW2GSpqwWySXUTzsgSr8zDREc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTEwIGF0IDE5OjA0ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4gPiBP
biBPY3QgMTAsIDIwMjIsIGF0IDExOjEzIEFNLCBFZGdlY29tYmUsIFJpY2sgUCA8DQo+ID4gcmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEhvdyBkb2VzIHRoaXMg
d29yayB3aXRoIGthc2FuPw0KPiANCj4gV2l0aCBLQVNBTiBlbmFibGVkLCBCUEYgd29ya3MgZmlu
ZS4gQnV0IG1vZHVsZSBsb2FkIGRvZXMgaGl0IHNvbWUNCj4gaXNzdWVzLiANCj4gDQo+IEkgZ3Vl
c3Mgd2UgYXJlIG1pc3Npbmcgc29tZSBrYXNhbl8qKCkgY2FsbHM/DQoNCkknbSBub3Qgc3VyZSB3
aGF0IHRoZSBkZXNpcmVkIGJlaGF2aW9yIHNob3VsZCBiZS4gRG8geW91IG1hcmsgdGhlDQppbmRp
dmlkdWFsIHZtYWxsb2NfZXhlYygpIGFyZWFzIGFzIGFsbG9jYXRlZC9mcmVlZCwgb3IgdGhlIGJp
Z2dlcg0KYWxsb2NhdGlvbnMgdGhhdCBjb250YWluIHRoZW0/IFNpbmNlIHRoaXMgaXMgdGV4dCwg
aXQgaXMgZ29pbmcgdG8gYmUNCmdldHRpbmcgbW9zdGx5IGZldGNoZXMgd2hpY2gga2FzYW4gaXMg
bm90IGdvaW5nIHRvIGNoZWNrLiBOb3Qgc3VyZQ0Kd2hpY2ggaXMgcmlnaHQsIGJ1dCB0aGVyZSBz
aG91bGQgcHJvYmFibHkgYmUgc29tZSBzcGVjaWZpYyBrYXNhbg0KYmVoYXZpb3IuDQo=
