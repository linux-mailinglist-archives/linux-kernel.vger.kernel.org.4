Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E25B3603
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIILFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIILFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:05:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C80B5A65;
        Fri,  9 Sep 2022 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662721528; x=1694257528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FiDC9msdMt6bGoQ5/F9UDgXnaZ7B2Itmld9tHggtekg=;
  b=Iolwm7UpVADnTtilkVRyznj+vPdmPTSpyx6UTsL/CBQRP/dXofnw+Esm
   94lWdHlBclJXrue6jVlRoVS8gVLvQngxDnLp+pCHEtgoqaFT7ABDjkEvQ
   e8XzooLbh7oUdJmb4VtutiqdzHgANQK93OP18O/BBKGXOzSv1/QXNrdvc
   q87cAuG9bOTGzE2XFGGiU+zaXSHUne56YpeV4ILBIpiKMqBdyFpZw/tQf
   IIJTrE7jeyWB2BoISRvnptbdathOuO5oJjfB90/0J1J3sSmo0tQOpCl+K
   JTZWd0k4g+F/M0CKDRePZFOxHLDP85M05RRMn5zrBPKraOx9qKgppllGU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="383745833"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="383745833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 04:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="757565956"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2022 04:05:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 04:05:28 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 04:05:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 04:05:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 04:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHHAVd9xaxlZhusseh7s9CN0n50S+dq4b0I6WLT8H5TR3ewGUT3zk30k7kDIbKwN44LcvGv7cohi8pPR69Zj6vr93cP3l9FHqBIEjaw6Za/DeteaVnA1srTBr8z3dqHO9WQqag5/DjqqAIXlJwOhu9J7lA6vdxvzXA7R57llvDz58u9bc38DHTa5jyfz8Zmt4DiyT/03h5fXqEonL861BO3HEZKlzbVVY8YdJjpyfz2A6x18eVAtiIgllSZdBnMpKmhnvAg0fy9X74PuGtzOmQDLNBEYVFfLKcdN3uGndz663rQx/SNutZUVMp6Hv+LuFbTl2koq1Y3cZLgPrpWkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiDC9msdMt6bGoQ5/F9UDgXnaZ7B2Itmld9tHggtekg=;
 b=jMjYc2GF9q+Jovp4/9Ry3chUMAD81EnBPkYzvbRTkMQx+pJxDFM+pB7DDqXSYBMhRO1H/8cXPRzuebBTjBMVbTXDaMe7eKcWIAp9yCcXS7x9TDTeTKlIfcnnGY8gUPc2QzbpCzuaLXyCSTW9xGaKh5ycr7D1cDeLaqjJI5EhyzcpldO1sWOUXUuFHxU5HA4Dh7zG5AafcrzRy3ckBvt/2Q6XgU5kR6M7boXeZ2MUn2KbmVsZUpOVhJC/2dZKeKItiK+LTTj0DRkTzV3BUi+NWTgTaXm0LyALqp5y0RdOXH+8gXm0Ik5QUOXwj9zAE7dgkE5chx3ROQXQPRSfx6k8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Fri, 9 Sep
 2022 11:05:25 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%9]) with mapi id 15.20.5588.015; Fri, 9 Sep 2022
 11:05:25 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>
CC:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
Thread-Topic: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
Thread-Index: AQHYxCOqzZOxa9vUg0Knyate5r52r63W79cA
Date:   Fri, 9 Sep 2022 11:05:25 +0000
Message-ID: <608162bc28e4afef5133968c67b2bfcf4b6ef851.camel@intel.com>
References: <20220909080853.547058-1-kai.huang@intel.com>
In-Reply-To: <20220909080853.547058-1-kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 538877a4-4ac1-45a4-8a9c-08da92533250
x-ms-traffictypediagnostic: SA2PR11MB5196:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogUzSYSJJLZSooR26GzoQE+WZudNPq3CJfofvMSZrrGUzpoXsOngLigO1+2p4NsYGG2BGWw0mQW7O4lzwlha3v7MGt0ku/TyxswjTigRRvnx/wXj4j+j9NWr5I8p8zIZspS8Hz5NiMQ7H4QZcL3Yh7fDtOVW9wpEYlvqEU4zUT9UdsuLE3knK35rdQjBHXIj3ydNJ2Qz+I8raEbozKkeln+FHfsjHinJZvLxryw/w121StPtODyc47LRldqH6Hmgf4FovhZQDV2ujimiu3jg24biDImGfm3WjOs9OzH6/h54MZVb5JipHh1kU/SMZd+fMhqGYybnu/IjlejpjotnaKisKFntFCL2asO5A69bsfj0bQoa2UqFB80HX5vIEuhYYF/IlwqBcGN5siZdKjbr2AE9NIlHae3eLtfy18KRrFMZWhEfcWMyfpX5pRpZWUOydnjoMCDEobCOBx3zUOpfJMsZMcNccu5Z1PxEV0he8bh0+gHdVnHfzZzE455CS9CoBsQaW/aFgafE0JpHV1K8QNzkhKTYJtdW7/M8ESSZEhg5mRIqL/0EF1KQ27EwtS2oL5e8ib4pa4YYga9/AXmceI2IjGoguHz4s68AZZvstprnTvbSis2voz+I+cXmLqEtFHd9VycYcJG5AwQjTeaPpxt/msdK626faFRCdaZQsxoKo+TnRSI+JUtgxIJm9i6FPMZm/UCb9yW0U/O/92xHRmPzdtKqwkTOm/zAHev+yWsbz0Jb388FBN8pnENuBtHOQwHtqCLP7bi+UuHSHRduiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(39860400002)(396003)(6506007)(6512007)(26005)(71200400001)(6486002)(478600001)(41300700001)(2616005)(186003)(2906002)(8936002)(5660300002)(54906003)(316002)(6916009)(4326008)(8676002)(66476007)(66556008)(64756008)(76116006)(66946007)(66446008)(91956017)(82960400001)(122000001)(86362001)(38100700002)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFAxQ00rWXFzNlZrWG1RU0JjNlBnQXJ4ZmhQMjRYRW1rT2Z6d3BaRm8rdGtk?=
 =?utf-8?B?dHJTYTk4V3VCWXNKdUdxUnVtMnUyRXl5QlI3N2ZuTmlUbndlUWtzZFYvcnRD?=
 =?utf-8?B?aW1IVEttZGhkcEM5ZDRyZ0gyK1hhdkZQMU1YVkg0eFREN2NZWC8vb0JaeHlT?=
 =?utf-8?B?T3llajdQRW4ydkZaMm5aQ29YUm5CRmZDYzFlcEs2bk5kZmV3ZTZmQlJhQVht?=
 =?utf-8?B?WGJyTG45eStGd3hJWVorc3hVUVd4UDl6UzlJR0xaR0VJMTQ5WW5KUFdkTXds?=
 =?utf-8?B?VXM1WXQyS3lsUnhVaHE1b1dnQTk2QVp4SSs2NmM4cTBMNVhWamxLQTBWbS80?=
 =?utf-8?B?bWFsN3Z6c2FqOU1Oa1BzZitJTTNaSEc1Q2NiOUJCT2FlemxaMkRISHJ2ZEc2?=
 =?utf-8?B?OGxobU5ROWtpUEtNejF1N2w2Smprb0xTa2ttVk1Fb0cvYkVSaWJvK0l1TWJ0?=
 =?utf-8?B?a3dKdVhSUlNibWVGNHgyTVh6TGRXS3VWNjNURjdVTi9sRTVKQWFjVlJLUmc4?=
 =?utf-8?B?WEdSUE9yTDM4L0NNUDBlS3pxMWlORzY5R29nMjRRdG5ma3VuTkM2VlNybWJR?=
 =?utf-8?B?amVhMC81WXFKcUd3ZHlBT0N6aTFPRHMxaTY5ZU0wbW5FWkJCQzhtTmpqUHI0?=
 =?utf-8?B?cWg2VTZiT3JLN3A1bnFFUmNCZC9CT3NrV1pqYzRZeXpxWnFCZVYzalhBbFQ2?=
 =?utf-8?B?UTVZTDh2dXJyQjNHNWdTdFc4WGpZUzZIcmhXaTQwOVhRSHlFcnNCdnd0TXhM?=
 =?utf-8?B?R2hWaGdWOGdVN1lPaVQyOG1sTUxXNHUwWHFYZXB2aEZnS29YVWJ4eFhTTGhT?=
 =?utf-8?B?ZjZ0S1RZWlZxVWdYTTN6MVBhbUQrNjhBSlhjRnF2T2wySnVBeXB2ZXBSWldZ?=
 =?utf-8?B?OHl1NCtReFVOc2pDNSswTDVqMldiWE9ONVh5ZUFOYjZtTDY4eGMvRWhXR2N3?=
 =?utf-8?B?SWQ1L2cza3ZyWlF6N3lJeE5yR3JwdWFTZUc5MG9zdVZCdFJYdks2MEhoZk5T?=
 =?utf-8?B?VXR3Mk0vY3JNaXlVZzZXaU9paE44c3A3STFPZmpTdUV5QWVTUFRHYWt3cUZP?=
 =?utf-8?B?UENqVHhkVDB6MmZmbEJrOWZjZkxIQUYvcHlxY2ZuYnVFbXIxTWlnSVk1U1JH?=
 =?utf-8?B?OFhpS1RpWGdPbTRVWktDYUdMWG95RCtqSDBtNHlEWm1jVGx6KzNPMC96ZjZX?=
 =?utf-8?B?MDJjSGo3VmQvTXdGRkJEcmo3QWt5Y0tVODQwQms0TVloRjNyaFdRQThFdFNi?=
 =?utf-8?B?NC8yUmhKU1RXU051elRhUm5BRGdMaTIwUHNXZmMybkNIenVZdTBCYlZwVVVU?=
 =?utf-8?B?Qjd5RmhiWjRWVUplTHBHR1JSMVM3YkVra01HSCtkajVsOWFUWUs1MVV3TE83?=
 =?utf-8?B?cGVYenlnRVlSakJ2bmc0NE1kUVl3NTd1dnU0K1ZrcW1uV1liWFVFYkdlNHM5?=
 =?utf-8?B?UU0vY00vZjJFcE9ZZnJBby9ZbGk0NlpVMlhWMUhCTHNRaWhNVlB2Mk81VHIr?=
 =?utf-8?B?WmVPNENNaDFsZU5GdFRxSXBWZlRRN3phcERvMWFnS21MRXhncEpoaHNrUFJa?=
 =?utf-8?B?Z2FXU051cSs4NE9TSGpESGV6KzMvcXRIelkwV2F1QWtXWkdwcXNlZWxCK3FJ?=
 =?utf-8?B?eTRSZm4wLy8rd05yWlcrZzdUaDRsNjVESXoveVc4bXAxY0tGQVdkcTRKR1V2?=
 =?utf-8?B?UExxczhhWEIvSlRmYnVrMTdxZlY2Uk5oWHNFS0lidXhoRFNqSnVUa0ZiUDdl?=
 =?utf-8?B?MW82RHBubGlsTmtQVitZSWcrNWdrdWM4WVBIOVR5TGNDNTVFZTZMMDNVczJ3?=
 =?utf-8?B?dDFmYldrSmR6M0hqK1V2U2U4YXZiTFdNeEFIVXZ3Ly8zb1dBZHpCSW1CQlZ0?=
 =?utf-8?B?ZGgxT2trN3lNYmdCTVVON2VGUEVZeU5lc0lCTjFkYU9FVUJQS0ZGQ21FOXdV?=
 =?utf-8?B?bFJvQm1tZWpoaCtVS3VyQlhrMUtKVkt2V0ZJT1dKTjR3dG5DamVSdUJyZmZa?=
 =?utf-8?B?NHBidUl1cE9HTjJVaFZ0ZVVNekw1a1Z2VFBMenVHT3BjYU1yaXFkTUpKUngy?=
 =?utf-8?B?Q1BsU2QyazBuQ2hPUVExblRzbis4MWRjYVpOVWdnNGRmSzA0UkE0ejNxbllY?=
 =?utf-8?B?NnFuTjM2cWFsRTJQZnFReVFwUVd5WGo4Nng4RFBHaVZ6L0t6TWt3d3pZVXRl?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AAAC26954E9D84E9D3FE9C7034D08F9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538877a4-4ac1-45a4-8a9c-08da92533250
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 11:05:25.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omDGdrnvlGRBVgydOKF06OO0nvGGgKbP28J60+bacdzMc9SUyy2RJi4wf1ZqFA44anOyERZlFGmikkPj3nHUkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDIwOjA4ICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IEN1
cnJlbnRseSBvbiBwbGF0Zm9ybSB3aGljaCBoYXMgU0dYIGVuYWJsZWQsIGlmIENPTkZJR19YODZf
U0dYIGlzIG5vdA0KPiBlbmFibGVkLCB0aGUgWDg2X0ZFQVRVUkVfU0dYIGlzIG5vdCBjbGVhcmVk
LCByZXN1bHRpbmcgaW4gL3Byb2MvY3B1aW5mbw0KPiBzaG93cyAic2d4IiBmZWF0dXJlLiAgVGhp
cyBpcyBub3QgZGVzaXJlZC4NCj4gDQo+IENsZWFyIFNHWCBmZWF0dXJlIGJpdCBpZiBib3RoIFNH
WCBkcml2ZXIgYW5kIEtWTSBTR1ggYXJlIG5vdCBlbmFibGVkIGluDQo+IGluaXRfaWEzMl9mZWF0
X2N0bCgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwu
Y29tPg0KPiAtLS0NCj4gDQo+IEhpIERhdmUsIFNlYW4sIEphcmtrbywNCj4gDQo+IENvdWxkIHlv
dSBoZWxwIHRvIHJldmlldz8gIFRlc3RlZCBvbiBTR1ggKEJJT1MpIGVuYWJsZWQgbWFjaGluZSB3
aXRoDQo+IENPTkZJR19YODZfU0dYIHVuc2V0Lg0KPiANCj4gVGhpcyBwYXRjaCBpcyBnZW5lcmF0
ZWQgb24gbGF0ZXN0IHRpcC9tYXN0ZXIsIGJ1dCBpdCBhcHBsaWVzIHRvDQo+IHRpcC94ODYvc2d4
IGNsZWFubHkgYXMgd2VsbC4NCj4gDQo+IC0tLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9mZWF0
X2N0bC5jIHwgMTMgKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2ZlYXRfY3RsLmMg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2ZlYXRfY3RsLmMNCj4gaW5kZXggOTkzNjk3ZTcxODU0Li4y
ZjY3NDA5ZjVmMDAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvZmVhdF9jdGwu
Yw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2ZlYXRfY3RsLmMNCj4gQEAgLTE5MSw2ICsx
OTEsMTkgQEAgdm9pZCBpbml0X2lhMzJfZmVhdF9jdGwoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0K
PiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+ICsJLyoNCj4gKwkgKiBCeSByZWFjaGluZyBoZXJl
LCBpdCBpcyBjZXJ0YWluIHRoYXQ6DQo+ICsJICogIC0gQ1BVIHN1cHBvcnRzIFNHWC4NCj4gKwkg
KiAgLSBTR1ggaXMgZW5hYmxlZCBieSBCSU9TLg0KPiArCSAqDQo+ICsJICogSG93ZXZlciBpZiBi
b3RoIFNHWCBkcml2ZXIgYW5kIEtWTSBTR1ggYXJlIG5vdCBlbmFibGVkLCBqdXN0DQo+ICsJICog
bmVlZCB0byBjbGVhciBTR1ggZmVhdHVyZSBiaXQuDQo+ICsJICovDQo+ICsJaWYgKCFlbmFibGVf
c2d4X2RyaXZlciAmJiAhZW5hYmxlX3NneF9rdm0pIHsNCj4gKwkJY2xlYXJfY3B1X2NhcChjLCBY
ODZfRkVBVFVSRV9TR1gpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQoNClNvcnJ5IG15IGJh
ZC4gIEkgc2VudCBvdXQgdGhlIHBhdGNoIHRvbyBxdWlja2x5LiAgVGhpcyBjaGVjayBzaG91bGQg
YmUgbW92ZWQNCmRvd24gYWZ0ZXIgY2hlY2tpbmcgWDg2X0ZFQVRVUkVfVk1YIGZsYWcgd2hpY2gg
bWF5IHJlc3VsdCBpbiBlbmFibGVfc2d4X2t2bQ0KYmVpbmcgc2V0IHRvIGZhbHNlLiAgSSdsbCBz
ZW5kIG91dCB2Mi4NCg0KLS0gDQpUaGFua3MsDQotS2FpDQoNCg0K
