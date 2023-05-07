Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CB6F99B2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjEGQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 12:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGQY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 12:24:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF712096
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683476668; x=1715012668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0WP4dghnKLg9bELbd4SLdswM3bLNn6HhSJgmYqZoEfU=;
  b=gdt8qsHzUdco3JF98sT78R+JVzQbut4DaJs1fDYHbsOFYFPjkBk2R0XE
   BsrLH2Y+3aze9U38GRvtPEvQnqKwSUQnNqpa351g7ZKaYVL37xNsdZDPp
   m4bJIUBrG1HqN12MuZIliRkLAirno3QNRJM7qUsFjt3EasE5/9f8Ip1gS
   qkSMBEwSw+n6XG2c9bAH9kNL8hdwQ+TYd4bfnANYF2RAAmplX3P1kIoez
   f8DhHLbLnbz4iMNUFOrUJML3lv04cK/HPjH1cBWVyqFqT7y8kMElys3bu
   KM33ygdULTV7CzQivsAF5RXe8mNobZOBWiFXrUt3pgaCjkI+/92Oa3LGE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="348321934"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="348321934"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 09:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="822403403"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="822403403"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2023 09:24:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 7 May 2023 09:24:27 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 7 May 2023 09:24:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 7 May 2023 09:24:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 7 May 2023 09:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVYkRYOX2M2ajyjIGk2e4gwloAgLfv1Jxd9DzZNJL3A3NLgvfoxryAgLY2A2dImf7GdArWs4FtWItW8FpcWXd4/ZwiLqqw1J60ElS6MltQGglabxvUuGp6vBOw+Zep5RRPEd/VVni+8A2kGq2jR0WlNAWVV//OZF+nRNxQnbe9efelSHkdff8JlmBwqjV77+oA8lvCsT8piANDOB5F792td/4zGVWi5LWKc73CLAl1/Og9nHjGVeR/WEE4xsGJ1qTUxXGYwN95sH1aicxfuHco7BVhEEIHR8fBVRtes8Bd5n9OhTU7gKvdrnKyEDvwslemYTeNIjqS41gF925EFL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WP4dghnKLg9bELbd4SLdswM3bLNn6HhSJgmYqZoEfU=;
 b=itJFMdCWtCAtOrLdioqZE563g4h7pUSSYKEEFBFhETtQzf+p0KaCWsKd6A3VYM4CrYBiSj+aJs4c4u0swSt7DFpL2yweNB36nde6i+pI7W/qphBuvyjyVhAvTN61xEMPoCiZOS1iCI/lREAydbnZKQ1VDc+wzpOXnFXMauMiOu46d7dW5mxpVDELBlfzoNl3ELgGE+UVMogx5556rE4/rtB33PLEmkRLdg8xQqguOiTHWbDcnxMsLLdkFu/LSesm98d91kBUWdzhQN2hbdDB9nGmkM/QcmYKmcEGeQGaSfbhFLT31N7R8Azk5n8TATH1RM9EPBLAismoixCWuw8++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Sun, 7 May
 2023 16:24:25 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%7]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 16:24:24 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
Thread-Topic: [GIT PULL] x86/shstk for 6.4
Thread-Index: AQHZdvLFwdOoBiNv3EeiRW4XzF36M69BDVuAgABnQwCAAAPJgIAMPVyAgABM/wCAAAKeAIABDX6A
Date:   Sun, 7 May 2023 16:24:24 +0000
Message-ID: <bd7c4f53cd27224308bff305513978dced1495ad.camel@intel.com>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
         <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
         <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
         <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
         <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
         <ad5b44e17c1c17ebdc581169fec7e80f7ef2a4d4.camel@intel.com>
         <CAHk-=wiZjSu7c9sFYZb3q04108stgHff2wfbokGCCgW7riz+8Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiZjSu7c9sFYZb3q04108stgHff2wfbokGCCgW7riz+8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB5328:EE_
x-ms-office365-filtering-correlation-id: 4c3f5f5c-a15d-4fca-d733-08db4f1785ae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0J5uwyKt5k+pMpvGjO8RHREO1c+fUwAAqqQAl8rWg03Lwb2A/h26wB/nZ5FrIAm+We/Ib0yekaOZCsNzTRTxQUUeEyAZu+O71sKxrrgFxrVBnyO6mIzEFFzgsOq2fw/UnSUI8u3xg9Zm3GpbyXvgp2huq/3cgn9zfCHMh/U91XQPwhRsp20YTG4PF/lIZA5yNDqElOqLHiCIir3tpLr0i8GyUF03oJFCsVYO+xkW5l/0ou7l+/efsw1LLQYseUOPXf36hrJDHXBJS2PbavPDuF9zPwvB1d2682vqJv0OPBTiScMze7TR7kIkCZdPm6BtgDDa3ZJHYPn5YVuR6TwhPaAtI1JiovJeEsrH0JYk2SZpydKkgJfw/Xme650/0pU2We3x+OV3ORKfqnBE9ttokNgZoaKKhizqBIYKu/0bqoIye8xLiyG56LJ+zxX+LffVCGB8+zEQKb7BATQxi0jFjdV4BCxitvVhFZjAmu6/c1cSHlOGVTsgV0sS92/IlaOkq48ZZYfPGVCnZBZVmxX8wHZJygYvSVkb9QTO00/HXz0AtBs7lpHH/YmuCAvAxwWLdVf4sGlunEe+GL6DV85UUxsYVChZ/WKZH6SlIJdhwO9iLDig0hBRB3CtRlsrOF04
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(86362001)(36756003)(4326008)(54906003)(91956017)(76116006)(316002)(66946007)(6916009)(66476007)(66556008)(64756008)(66446008)(6486002)(478600001)(5660300002)(8676002)(8936002)(71200400001)(41300700001)(2906002)(122000001)(38100700002)(38070700005)(82960400001)(2616005)(186003)(26005)(6512007)(6506007)(83380400001)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3dRU2JHZFpETU1RWS9Jc2p5enhVZmlBMVBGTmt0TTB2ZkdNS1crRFAxT0Zq?=
 =?utf-8?B?eEQvTEZlcUljc2w4bGQzZU5RV2dGQUQraUdwc2hvVENvOHhTV3hseEZVZFZF?=
 =?utf-8?B?V2YwNHRJOVN1SkIzZnlqaGFWRU9EcWdvRzltNmhMWlB0dDcwVFN1TnVVWERW?=
 =?utf-8?B?eGFXZk9Ca3BXaXZuMUUzSzVuRHVsTHBDcVRvalQ4OTVlRS91NW04MURkQzIz?=
 =?utf-8?B?bzd2bkNrbzBXdVBmSnROR2tnS05qUVBhU0xITEVGNHd0bmhVdENTeU8rYlJn?=
 =?utf-8?B?NlFkS2hQTXZiUWppeEZVVnQyYUttTDBIdE0wQ1BCK1pXK3FlZUs3VGFNZS8z?=
 =?utf-8?B?RGhmR0xaTVVxNWw5SDk5TUw0WmlLd2tPaGNlRGQraFBLeUJEaG4zamh2UzZV?=
 =?utf-8?B?ZXVlclVhU2x1K3FHWnR5SmxhQkp4MjQxR1UyOEpIbGJXdlA5czZVcklRYjJP?=
 =?utf-8?B?NkZReU5raDN6UnFpNUhNODk5bXVjTjRDZXYzTm4zNlhRblFTUEhvRHNrRUpo?=
 =?utf-8?B?bmR3MHZSb3ZvcFYvMlo5bkV3a2R6MU1DeWlKN0pmOGZ4d3RKSnRpVEJvNnBw?=
 =?utf-8?B?UTJHc3ZZMDNORTVGakExdnBMVytQWld5dndOYVJ2bUhtTS9LUW94YnJraUNr?=
 =?utf-8?B?K0N6bTl3WUtaNS9XdW83a250NE5VbllvVGVpVU9YWmpMTG14SGFYcGtsTVhn?=
 =?utf-8?B?U0psQlRMbkJpZEJMMnI2d1RKWVJiWjhsYk1TTGFxcFMvSVJCS3JPOVBhUlFU?=
 =?utf-8?B?UGpYNC9Zck0xRkpHR2NmelpweERtYk1LcFgrdHUwWUZDVjdNUUpxVGVYck5S?=
 =?utf-8?B?MS9hcHBzeFhDL0lncTRGQzJOYm52NkFYbWFzUmRxd3RIYVl1UWRSWmJ4VnJX?=
 =?utf-8?B?WFdUYXFFNVRhRElLOGNXNGdQUHI5d1pxbUZnQiszNk5sM2h4TTdJYXlwTjU4?=
 =?utf-8?B?MXNYZjRVNWM1cVVCM25BU01INUw1S0loYmxZZWVEb2ZvVWEwTkNSQVlkK2NN?=
 =?utf-8?B?YzU2M0tzZk45dDRlWFB0SEJyTGR0YTNmMXlhd2VaampCeVpESktCZHd3NmlD?=
 =?utf-8?B?M3ZwNnNvVjhQOGxCOW9Jakc4MHgxNGVjTE1hZ3JOaDgwTFpjejd0d3BjMnpu?=
 =?utf-8?B?R0t6UjZaaGZldVpyVVBoMXVSYTNuSGpnS1gxcmF3SXFPeFQxczYzT1RGNFF5?=
 =?utf-8?B?YkQwV1Ntb1Y2VjNkNGlrNkU0aFBEdDVUY2dPWDVIUEwwL3M3bUFDeUY0YWRj?=
 =?utf-8?B?a2JXU3hWZFhkRktmK04vby8vd29jbEw1M2R0Uk1DdjNUU2NyaFNFbC8vSDVW?=
 =?utf-8?B?eU5COXZTQWtUUWNraGp1RWlXQ0FxUjE0Sm96UVV3UkhWcW4vYXB1S3FwMHFG?=
 =?utf-8?B?NnlwNTZYbnBXSnd1NUhLamlzaHZDSnI5emJiTk5yQkMvVUdFWUdRczJ3Y3Qz?=
 =?utf-8?B?R0tRRFQ3L3NidmZwd24vK0xQTmV4WEJFcmp4RTlsRTQ5YTRzeHduSmVQdzYv?=
 =?utf-8?B?SllFcVgvN1BZMDNvRUVBNXZHYUIvWFoxQ05QNFROMUFybDV2Z25DWDJ1dUgr?=
 =?utf-8?B?SWpKYWRmQWg3MUpwZVhtUXJ6R0k3VGUzcFNxdk5HVEN2WWxJcDByTStKSmZ2?=
 =?utf-8?B?dCtobkdUT3JFNHNPdHRzSDBScWl3OXFSbTJTVUNhVGU0OGJaV0gzTVdaY29C?=
 =?utf-8?B?aWtXTUFtKy9adXJzOVFPQzJ2djJiSkRNUTJKWG9WQ1RnSFJiK0lXSUJ0UFl0?=
 =?utf-8?B?ZlU5amNOVnJIT1pyTVZ4UHluSTZDaUcxeVZ2TEp0ZE56aGthZExlVndHYzl5?=
 =?utf-8?B?MzZRbHl2Q05uSWFwZk80Wi8rSlpMdUFqTWxoNzVnak1VcXI1WjFubUs1ejIv?=
 =?utf-8?B?WGVlT2QyczhjSGY0M3hYZXVndW5RcGRUMUNDTVNvWWI1R3RqTkZNbkRPWTVJ?=
 =?utf-8?B?Z3BlMktGREZaRm9FS0xuU2FwYTBUZkk0SVZFUmVRQXZ1ZGlybEhCRHJLT0gy?=
 =?utf-8?B?TmNXRkdUOEVocGl3NWEvd3ZxZHRNU2ZHcTc1c1lET0J0N0RGWTZvNG9CbkhE?=
 =?utf-8?B?K3lBdnNTWnBrYjVTOW5ydG4vR0dMNjlOWnh4dm43MFh1Z1ljMlh4VExIKzRr?=
 =?utf-8?B?S0JJeGNLdUFDNlFoZ2R1RTFnNkpEWlNQdTNuUzBYdE5yZmViRGNISlk0Rkox?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2C22C70116D3D4B8D5A17DBCF632007@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3f5f5c-a15d-4fca-d733-08db4f1785ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 16:24:24.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TX4t/PcxDhhHjfpcf3mlJydu18ErCKW4qNvec9dKkTVWboD0ct82/5+sZaQCHfdMwEokX1cExATuNFIQ8/537gZRuyBozAGx2K7I3vkiGh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA1LTA2IGF0IDE3OjE5IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gU28gSSB0aGluayAibm92bWEiIGlzIG1vcmUgY2xvc2VseSByZWxhdGVkIHRvIHdoYXQgdGhl
IHNlbWFudGljcw0KPiBhY3R1YWxseSBhcmUsIGFuZCB0aGUgImtlcm5lbCIgdGhpbmcgaXMganVz
dCBhICJvbiB4ODYtNjQsIHdlIGhhdmUNCj4gdGhpcyBzcGVjaWFsIGNhc2Ugd2hlcmUgd2UgZG9u
J3QgaGF2ZSB2bWEncyBhbmQgZG9uJ3Qgd29ycnkgYWJvdXQNCj4gbG9zaW5nIHRoZSBkaXJ0eSBi
aXQiLg0KPiANCj4gSG1tPw0KDQpZZWEsIGl0IHNlZW1zIG9rLg0KDQpUbyBtZSB3aGF0IHB0ZV9t
a3dyaXRlX25vdm1hKCkgcmVhbGx5IGRvZXMgaXMgbWFrZSBhIFBURSB3cml0YWJsZSBpbg0KdGhl
IGNvbnZlbnRpb25hbCBzZW5zZS4gVW5mb3J0dW5hdGVseSwgbm93IHRoYXQgIndyaXRhYmxlIiBp
cyBzdGFydGluZw0KdG8gZ2V0IG92ZXJsb2FkZWQsIHRoZXJlIGlzIG5vIGdvb2QgbmFtZSBzcGVj
aWZpYyB0byB0aGUgb3JpZ2luYWwgdHlwZQ0Kb2Ygd3JpdGFibGUuDQoNCkkgZG9uJ3Qga25vdyBp
ZiBJJ20gYmlrZXNoZWRkaW5nIGhlcmUsIGJ1dCB3aGF0IHB0ZV9ta3dyaXRlKHB0ZSwgdm1hKQ0K
a2luZCBvZiBkb2VzIG5vdyBpcyByZW1vdmUgYSBQVEUncyBwcm90ZWN0aW9uIGluIGEgZ2VuZXJh
bCBzZW5zZS4gQWZ0ZXINCnVzaW5nIGl0LCB1c2Vyc3BhY2UgY2FuIGNoYW5nZSB0aGUgbWFwcGlu
Zy4gU29tZXRpbWVzIHdpdGggbm9ybWFsDQp3cml0ZXMgZm9yIHRoZSB0aGF0IHR5cGUgb2YgVk1B
LCBzb21ldGltZXMgd2l0aCBzaGFkb3cgc3RhY2sgYWNjZXNzZXMNCmZvciBhbm90aGVyLiBTbyBJ
IHdvbmRlciBhYm91dCBsZWF2aW5nIHB0ZV9ta3dyaXRlKHB0ZSksIGFuZCBjcmVhdGluZw0KcHRl
X21rdW5wcm90ZWN0ZWQocHRlLCB2bWEpIG9yIHB0ZV9ta21vZGlmaWFibGUocHRlLCB2bWEpLiBU
aGlzIG1ha2VzDQptb3JlIHNlbnNlIHRvIG1lLCBidXQgdGhlbiBJIGd1ZXNzIGV2ZXJ5IG90aGVy
IGFyY2hpdGVjdHVyZSBoYXMgdG8gd2FkZQ0KdGhyb3VnaCB0aGlzIGNvbmNlcHQgdG8gZGVhbCB3
aXRoIHRoZSBzaW1wbGVyIHdyaXRhYmxlIHBhdHRlcm4gdGhleQ0KY2FyZSBhYm91dC4gSXQgYWxz
byBubyBsb25nZXIgbWF0Y2hlcyBWTV9XUklURS4gSSdsbCBzdGljayB3aXRoDQpwdGVfbWt3cml0
ZV9ub3ZtYSgpLCB1bmxlc3MgeW91IGxpa2UgdGhhdCBiZXR0ZXIuDQoNCkJUVywgSSBmb3Jnb3Qg
dG8gbWVudGlvbiB0aGF0IHRoZXJlIGlzIGFub3RoZXIgYXJjaGl0ZWN0dXJlIChtYXliZSAyKQ0K
dGhhdCBpcyBleHBlY3RlZCB0byB1c2UgdGhpcyByZWZhY3RvciBmb3IgaW1wbGVtZW50aW5nIHRo
ZWlyIHNoYWRvdw0Kc3RhY2tzLiBTbyBGV0lXLCB0aGlzIGNodXJuIGlzIG5vdCBqdXN0IGZvciB4
ODYuDQoNCg==
