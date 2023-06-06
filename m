Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFEA723C91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFFJJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFFJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:09:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA828E69;
        Tue,  6 Jun 2023 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686042550; x=1717578550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eYyQxzg7h/DvtEilOgNwE21oTec5z6uJDGuUob+W7FQ=;
  b=F026BxPofA2uIeRGzrqzyQ2jWepbtO9uM0IMxVpjeh8Z/r7oigo382py
   YexL+4d/cNQH0hoAk0dc5ZlwlpY/7QNlY3F/cM4lIo6IfqiN1jal/CIqd
   GmbsRFc4iH+C3etVPeH9vexUM7NSEkAf0os3yqjgxC7LfW9KZOI/ezRBV
   Wan7++Cric/tQvhhZI4uMAUurHR3wWeFyq+Zj4WrmrnuOgpAdsgPgMqw/
   uwBalLgV9LbwnDY0nHQPCPpNBgLI46uUsE2lNtyqO+4DUDmV04BXnD8Y0
   S85GtdHv7c7u+4dYYyZBoeI/CdtrkuQHo9MgKdKh/DN4wyfKyNw84gqIn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="354106609"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="354106609"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 02:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="774042981"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="774042981"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 02:09:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 02:09:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 02:09:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 02:09:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 02:09:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsv1lEhxjabgRe06cuu6Pm9ba26PaWGgSR3PrkhVXgUP3WjwliErnf8Px18wX3gjJ+z77wBYa6LAdTSz0TQX5fQBtC1nMFrj8VObGSDtNxtrNPpEZ3KjL9LTTy9H9fdOuHW1Q7WWnoOkwG6suyjuj2wIP7HYjUpnUTZEoAO2l/DgQ+NHUpcNeGOK1zUybDwAlwHv1ug8ZYQbrit0HBHJN8oqds8+CTbe/VHz6KY6Sg/vlF8KgJRUrScoCH9D01ggPrZC9pzcKhUuLyQzyoDCxovvI2K88dC9kv1/r1N6aCLM2t8Ki/1ew2ue+04UdYtNpV1alEhQ2lNau0gmGaLbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYyQxzg7h/DvtEilOgNwE21oTec5z6uJDGuUob+W7FQ=;
 b=ayMoxc8nPvuACnIgwoYH5NEGOdLjhZyb5ndoaqQgFIaZGqJrxDsInVzf0RvwYzS8sH3DtXvzyptmQtpV2FsIl+nOnSHfhjMJtaeFxZVAJ+3muNfUNbI/6tuUVnRoCkI8IW/9da3645Nhe8hC7tEObdW9ODvGPIe/JhqPQ97+291DQ+evW8CJAJ/RoLMYYOGFyeBMxCbfV/dmfaRd9Rm+4QDcSvoPC38d3ImbbLZr5fAgCxBxDnk20ZJElQSuF/21UyRu22CnnN8tNsYXe7cVK6NjOLMOe/VUnbyCa6M+mkl1KXkPojU/27NLt9yrIZf9fZWgBrIGh7xT37gRhwJMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:09:06 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::a549:be63:2844:ca7e]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::a549:be63:2844:ca7e%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:09:05 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dreyfuss, Haim" <haim.dreyfuss@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: iwlwifi: mvm: Fix -Warray-bounds bug in
 iwl_mvm_wait_d3_notif()
Thread-Topic: [PATCH v2] wifi: iwlwifi: mvm: Fix -Warray-bounds bug in
 iwl_mvm_wait_d3_notif()
Thread-Index: AQHZlYpVt/RT/Oc9vUiPiHUXBnFu2q98+kiAgACHtoA=
Date:   Tue, 6 Jun 2023 09:09:04 +0000
Message-ID: <b5d79c8c19325353c51c6b8a8338410e101cd8c8.camel@intel.com>
References: <ZHpGN555FwAKGduH@work> <202306051758.CD86F1E638@keescook>
In-Reply-To: <202306051758.CD86F1E638@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CO1PR11MB4883:EE_
x-ms-office365-filtering-correlation-id: ffab73de-1d80-42b8-4810-08db666dad5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7yF79e+ekwHN9qFb53kOkRtcnFiQEbEdtx/Recp9418aoL7EaPRL6Mj9CndYvwDR59PEuArtmczSOwcczWbC8O6AXlJj0hcAlWTdrpX4t8dMEflYXKOWIkj79ClMWq+PYcbKTjcNL1A8b9bYiVtkNAI7BCTwu8YkyzMUYqXjnXVTA8qzwCL1hApJyvqkamTNFa5Jb/JaM/w+SdgflFXws/A5ZwiM5KxBLDLnZyQTaCuHlQ9FX22TH060sQhklcG2vFk5DPthMNFp7muj1jcPTKOnmzj2XFXLCPJUl4e8KYNouhFV8STrYMcOqWzepxezt/uygdXKrjCu//HErUgMZMIaIvPsdSEjzlEBCX2NcH3IfttCSQUISzPKZha2n3UfjA7AroS4nw0n6Ju5lSyYkgzc2Ta1P5qnoJgdZ8fGHYCk+icbHIALHN/8VlYHs1GA4uOyXme6LxiQFA2XbSRYLxFnH9BiFCeeVQzeYm65oc9CeGZLA8PectIAfHvP8aMPDBK/f25r84yEO9X8YlTNgJoZuFC3OlTCcVoCxOcuXVZpr0cw/vtWQxuCXghxPhyWMhheva4oecsVjHRNR9PnPXYiG6NbG4E2JqY9HOnxL4EWUTTUBygb8LCqarSgWW8rDnwT8G36MC5RHHfNc141VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(186003)(2616005)(966005)(6506007)(6512007)(26005)(6486002)(66446008)(71200400001)(82960400001)(36756003)(76116006)(4326008)(122000001)(91956017)(66946007)(38100700002)(478600001)(83380400001)(66556008)(38070700005)(8676002)(86362001)(8936002)(5660300002)(64756008)(66476007)(110136005)(54906003)(316002)(2906002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODBaOWJGdmhOdnliMjBVMHcwWVhiTE1vV2ZWakFNWXdPUWtnd1JSQjJCSUVi?=
 =?utf-8?B?LzdDckY1RHJJMUoyWXYraStNSmpKRGdjUzNDRVoraytKdFMvN0YybFNpWHhh?=
 =?utf-8?B?MXU5Z3FlVFV1Ui9HZyt0eTBpWktuKzg3MHhCNmN3RVZCdktrZ294YXlEUUV1?=
 =?utf-8?B?ZFYrd1lQS1JMNFZCMGNrUDVhMlc0TUl4cmJweGxNVFRKNEppODVtZFViUFJJ?=
 =?utf-8?B?YVZISCtWN0tLOUpJMFJucUlWdUppam8xWlBMWWdYUDhPUmQ5SW5DNWp2UnQ4?=
 =?utf-8?B?TlRKQ3kzU2ZxMWkvSGNjcE4xVEhqSVlUcktBdXNzWlpTdEZFYlhEUnpwelhV?=
 =?utf-8?B?U1NiM3QzZXF5cUoyME5VVWdxdEwxK3ZCUkUzRHFBbXhaNUd1NHl3QUFCcEhQ?=
 =?utf-8?B?RVZRbWJvRGdZZTkzMU5WMi9VbUJvbkxWWkhFajZNZENTSzU1NjhVOGgyTnBM?=
 =?utf-8?B?d2JvREtJQ01LblBaVWYyL1ppSGFaOXN4Q1UrZm1kV1ZqeE5QQ2xudFpDbVdo?=
 =?utf-8?B?UGM0M1VGa3ZFSjBOQ2pBMGIxQksxUy9MODJqRXlFSkd3VTNSYmFaZ1lqbHIr?=
 =?utf-8?B?TnhMQ0tiNnl2RFJsaHdLOE1Gdk1vN3g0L0cwRFpXT3lxbUJuL0krRU11MkhQ?=
 =?utf-8?B?V3Y4T250dDNybnRQcXdkcjZsY3pJTUFDeVNuQlNPM05peUlqNW56Q2ZQS0Za?=
 =?utf-8?B?RU1VUkJnVjJqUDl4YTlMbzcrc001VTc0RW1IMFIzUGxmcjVsaEtBeENCdFFJ?=
 =?utf-8?B?ZW93bjhLenRmRVI3MUlBSXptcHBOMWNtOEtvcnVXYmV0NnRqMnF3ZSsrZ3pi?=
 =?utf-8?B?Z0dOYzVEZzBqMGRtcFRQZk9sK0dUNUk5WDgrODUwRlUybEk5STNValRaYkRw?=
 =?utf-8?B?MDdFT3RHei93amlSanJFcm5pMHFXdWVBMlhqY1NPenVKZkRUS2U3azJ6eFU4?=
 =?utf-8?B?b3l4TEd6cndaR0ljMGwzcW1YdUFFeUNUVkttMFZ0T2VlT1AzWHRwdStBMXZX?=
 =?utf-8?B?MFRoTGVqMktVMktadTk0MHZWalVaeE9BSDFVL3NFS0trMzA2dUdjQ3dUVk5O?=
 =?utf-8?B?MTJMb3BKSUtBSXJiTXVMR0dzMDhlYjlhcUxGRVZNbnFRbDNTQUIyMEhhWEpL?=
 =?utf-8?B?U3dUak5XSFROTEtSVTRSOStEK3dsc0FFNlc4b0tKc0ZZZnhjNDlUengybys2?=
 =?utf-8?B?Z0JndGpDcEQwZTB2aWJqMjdTSnpIZWVjQWpSMlE3eXpvRHdXWVdSY0Mwbk5B?=
 =?utf-8?B?Q1dNQU9xSTRQNnpneGE5blFhbnhKb3Y4cDNNbWZTT0UrbnhOMW81SkRLSlRj?=
 =?utf-8?B?NVZSRHBDTXlwMitKb2ZOVHZlaW1WMkJpYlpaN2gwdjU5cFpUZVI1UVB6d05q?=
 =?utf-8?B?V3lscFZsaTQ1YXQ4NDNJeitzdlJkaXZiVFliRVZSbUJSd1lhRVFFc0NBcFhj?=
 =?utf-8?B?Q1ZFTVc3ZjZmTkc5aUZmV1ZvUU9FeEhpbmh4VDVwRFBCTG0yYnJyNSs2TmpU?=
 =?utf-8?B?d2RYUjhXdTJSbWc1bUlCUjdlbVpVNis1OEx1NVRwM0FEdG9vRUFsUml5TDF4?=
 =?utf-8?B?cWVMM2kvZkJ3Rmk4Y2FqeUxhMDJqeGdIaTRzQUI4U1pPcG5qNFRFbXhERTh0?=
 =?utf-8?B?N2dpVG1ETTN6cmFTcUxaVGV0WElabktiTEU1V1ZKZEJDTTJNSXNJaThLdTdT?=
 =?utf-8?B?NGZZcXRKRDlsQTExVllpbjRSUVJycWVvZDZBTFB2MkhuVm56MWNCL2pqeE9F?=
 =?utf-8?B?YjhOam1kNUNjMnJOQUpDcVppUU5ZUEZ1M0VSbHc2Sm9rL0VHbm9UZEFsdTZv?=
 =?utf-8?B?VTN3U0txU3R2QktpV2RFdnhEZFpCR01qRDVMZGMvK1h2eDBCT1djeG5sNWtM?=
 =?utf-8?B?VDU5c0dpNkthb2c1VWEzaTdta1pyM2FXVk9teGZYWExhSlNQdk14YmthK1Vk?=
 =?utf-8?B?OUUrWXpYZkorZU8yVTNQN3ZDdnozOWJGYTN3dm5tM3JlcEIxK2tiMVlPSVFh?=
 =?utf-8?B?R3J4MkMrdHRaVThCMjZQRXQrVVVMTzBQUjZTdGZ0Misvd3Y0ZzZUSnoycXR2?=
 =?utf-8?B?Sk0rZzRsZ2RFZUw0MzA3ei8zRmxtTlJSRlowbnF6RDRLQXFZaDcxVllyUVNW?=
 =?utf-8?B?VkhUdmN4ZmEvc01XOHpMbnRwY2JNZUtYUXIvd2xzZjJYREp5QU1TYkJsYy9K?=
 =?utf-8?Q?cHik8X75NeQZGhLl6XZ0OSk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40AE347A8FA4A0438515FD3E86DC7E8B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffab73de-1d80-42b8-4810-08db666dad5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 09:09:04.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWqvxvJveIrSP4um4XJV/AhIzbd1A75KBWamXZWGLWcRLmprmXGtqdakM3Br5HCyUMp7BgNWGDokQEYKsN0Z8LD2VHy05IUZGAmieg2lLuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
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

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDE4OjAzIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6Cj4gT24g
RnJpLCBKdW4gMDIsIDIwMjMgYXQgMDE6NDI6NDdQTSAtMDYwMCwgR3VzdGF2byBBLiBSLiBTaWx2
YSB3cm90ZToKPiA+IGttZW1kdXAoKSBhdCBsaW5lIDI3MzUgaXMgbm90IGR1cGxpY2F0aW5nIGVu
b3VnaCBtZW1vcnkgZm9yCj4gPiBub3RpZi0+dGlkX3RlYXJfZG93biBhbmQgbm90aWYtPnN0YXRp
b25faWQuIEFzIGl0IG9ubHkgZHVwbGljYXRlcwo+ID4gNjEyIGJ5dGVzOiB1cCB0byBvZmZzZXRv
ZmVuZChzdHJ1Y3QgaXdsX3dvd2xhbl9pbmZvX25vdGlmLAo+ID4gcmVjZWl2ZWRfYmVhY29ucyks
IHRoaXMgaXMgdGhlIHJhbmdlIG9mIFswLCA2MTIpIGJ5dGVzLgo+ID4gCj4gPiAyNzM1wqDCoMKg
wqBub3RpZiA9IGttZW1kdXAobm90aWZfdjEsCj4gPiAyNzM2wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG9mZnNldG9mZW5kKHN0cnVjdCBpd2xfd293bGFuX2luZm9fbm90
aWYsCj4gPiAyNzM3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmVjZWl2ZWRfYmVhY29ucyksCj4gPiAyNzM4wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEdGUF9BVE9NSUMpOwo+ID4gCj4gPiB3aGljaCBl
dmlkZW50bHkgZG9lcyBub3QgY292ZXIgYnl0ZXMgNjEyIGFuZCA2MTMgZm9yIG1lbWJlcnMKPiA+
IHRpZF90ZWFyX2Rvd24gYW5kIHN0YXRpb25faWQgaW4gc3RydWN0IGl3bF93b3dsYW5faW5mb19u
b3RpZi4KPiA+IFNlZSBiZWxvdzoKPiA+IAo+ID4gJCBwYWhvbGUgLUMgaXdsX3dvd2xhbl9pbmZv
X25vdGlmIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLm8KPiA+IHN0
cnVjdCBpd2xfd293bGFuX2luZm9fbm90aWYgewo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBp
d2xfd293bGFuX2d0a19zdGF0dXNfdjMgZ3RrWzJdO8KgwqDCoMKgwqDCoMKgwqDCoCAvKsKgwqDC
oMKgIDDCoMKgIDQ4OCAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIC0tLSBjYWNoZWxpbmUgNyBi
b3VuZGFyeSAoNDQ4IGJ5dGVzKSB3YXMgNDAgYnl0ZXMgYWdvIC0tLSAqLwo+ID4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBpd2xfd293bGFuX2lndGtfc3RhdHVzIGlndGtbMl07wqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyrCoMKgIDQ4OMKgwqDCoCA4MCAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIC0t
LSBjYWNoZWxpbmUgOCBib3VuZGFyeSAoNTEyIGJ5dGVzKSB3YXMgNTYgYnl0ZXMgYWdvIC0tLSAq
Lwo+ID4gwqDCoMKgwqDCoMKgwqDCoF9fbGU2NMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVwbGF5X2N0cjvCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKsKgwqAgNTY4wqDC
oMKgwqAgOCAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIC0tLSBjYWNoZWxpbmUgOSBib3VuZGFy
eSAoNTc2IGJ5dGVzKSAtLS0gKi8KPiA+IMKgwqDCoMKgwqDCoMKgwqBfX2xlMTbCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhdHRlcm5fbnVtYmVyO8KgwqDCoMKgwqDC
oCAvKsKgwqAgNTc2wqDCoMKgwqAgMiAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoF9fbGUxNsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzZXJ2ZWQxO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLyrCoMKgIDU3OMKgwqDCoMKgIDIgKi8KPiA+IMKgwqDCoMKgwqDCoMKgwqBf
X2xlMTbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFvc19zZXFfY3Ry
WzhdO8KgwqDCoMKgwqDCoCAvKsKgwqAgNTgwwqDCoMKgIDE2ICovCj4gPiDCoMKgwqDCoMKgwqDC
oMKgX19sZTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3YWtldXBf
cmVhc29uczvCoMKgwqDCoMKgwqAgLyrCoMKgIDU5NsKgwqDCoMKgIDQgKi8KPiA+IMKgwqDCoMKg
wqDCoMKgwqBfX2xlMzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51
bV9vZl9ndGtfcmVrZXlzO8KgwqDCoCAvKsKgwqAgNjAwwqDCoMKgwqAgNCAqLwo+ID4gwqDCoMKg
wqDCoMKgwqDCoF9fbGUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dHJhbnNtaXR0ZWRfbmRwczvCoMKgwqDCoCAvKsKgwqAgNjA0wqDCoMKgwqAgNCAqLwo+ID4gwqDC
oMKgwqDCoMKgwqDCoF9fbGUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmVjZWl2ZWRfYmVhY29uczvCoMKgwqDCoCAvKsKgwqAgNjA4wqDCoMKgwqAgNCAqLwo+ID4g
wqDCoMKgwqDCoMKgwqDCoHU4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHRpZF90ZWFyX2Rvd247wqDCoMKgwqDCoMKgwqAgLyrCoMKgIDYxMsKgwqDCoMKg
IDEgKi8KPiA+IMKgwqDCoMKgwqDCoMKgwqB1OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0aW9uX2lkO8KgwqDCoMKgwqDCoMKgwqDCoMKgIC8qwqDC
oCA2MTPCoMKgwqDCoCAxICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgdTjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzZXJ2ZWQyWzJdO8KgwqDCoMKgwqDC
oMKgwqAgLyrCoMKgIDYxNMKgwqDCoMKgIDIgKi8KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoC8q
IHNpemU6IDYxNiwgY2FjaGVsaW5lczogMTAsIG1lbWJlcnM6IDEzICovCj4gPiDCoMKgwqDCoMKg
wqDCoMKgLyogbGFzdCBjYWNoZWxpbmU6IDQwIGJ5dGVzICovCj4gPiB9Owo+ID4gCj4gPiBUaGVy
ZWZvcmUsIHdoZW4gdGhlIGZvbGxvd2luZyBhc3NpZ25tZW50cyB0YWtlIHBsYWNlLCBhY3R1YWxs
eSBubyBtZW1vcnkKPiA+IGhhcyBiZWVuIGFsbG9jYXRlZCBmb3IgdGhvc2Ugb2JqZWN0czoKPiA+
IAo+ID4gMjc0M8KgwqDCoMKgbm90aWYtPnRpZF90ZWFyX2Rvd24gPSBub3RpZl92MS0+dGlkX3Rl
YXJfZG93bjsKPiA+IDI3NDTCoMKgwqDCoG5vdGlmLT5zdGF0aW9uX2lkID0gbm90aWZfdjEtPnN0
YXRpb25faWQ7Cj4gPiAKPiA+IEZpeCB0aGlzIGJ5IGFsbG9jYXRpbmcgc3BhY2UgZm9yIHRoZSB3
aG9sZSBub3RpZiBvYmplY3QgYW5kIHplcm8gb3V0IHRoZQo+ID4gcmVtYWluaW5nIHNwYWNlIGlu
IG1lbW9yeSBhZnRlciBtZW1iZXIgc3RhdGlvbl9pZC4KPiA+IAo+ID4gVGhpcyBhbHNvIGZpeGVz
IHRoZSBmb2xsb3dpbmcgLVdhcnJheS1ib3VuZHMgaXNzdWVzOgo+ID4gwqBDQ8KgwqDCoMKgwqAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMubwo+ID4gZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYzogSW4gZnVuY3Rpb24g4oCYaXdsX212
bV93YWl0X2QzX25vdGlm4oCZOgo+ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9tdm0vZDMuYzoyNzQzOjMwOiB3YXJuaW5nOiBhcnJheSBzdWJzY3JpcHQg4oCYc3RydWN0IGl3
bF93b3dsYW5faW5mb19ub3RpZlswXeKAmSBpcyBwYXJ0bHkgb3V0c2lkZSBhcnJheSBib3VuZHMg
b2Yg4oCYdW5zaWduZWQgY2hhcls2MTJd4oCZIFstV2FycmF5LWJvdW5kcz1dCj4gPiDCoDI3NDMg
fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBub3RpZi0+
dGlkX3RlYXJfZG93biA9IG5vdGlmX3YxLT50aWRfdGVhcl9kb3duOwo+ID4gwqDCoMKgwqDCoCB8
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmM6NzoKPiA+IEluIGZ1bmN0aW9uIOKAmGttZW1k
dXDigJksCj4gPiDCoMKgwqAgaW5saW5lZCBmcm9tIOKAmGl3bF9tdm1fd2FpdF9kM19ub3RpZuKA
mSBhdCBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9kMy5jOjI3MzU6MTI6
Cj4gPiBpbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmg6NzY1OjE2OiBub3RlOiBvYmplY3Qg
b2Ygc2l6ZSA2MTIgYWxsb2NhdGVkIGJ5IOKAmF9fcmVhbF9rbWVtZHVw4oCZCj4gPiDCoCA3NjUg
fMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIF9fcmVhbF9rbWVtZHVwKHAsIHNpemUsIGdmcCk7Cj4g
PiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fgo+ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
dm0vZDMuYzogSW4gZnVuY3Rpb24g4oCYaXdsX212bV93YWl0X2QzX25vdGlm4oCZOgo+ID4gZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYzoyNzQ0OjMwOiB3YXJuaW5n
OiBhcnJheSBzdWJzY3JpcHQg4oCYc3RydWN0IGl3bF93b3dsYW5faW5mb19ub3RpZlswXeKAmSBp
cyBwYXJ0bHkgb3V0c2lkZSBhcnJheSBib3VuZHMgb2Yg4oCYdW5zaWduZWQgY2hhcls2MTJd4oCZ
IFstV2FycmF5LWJvdW5kcz1dCj4gPiDCoDI3NDQgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBub3RpZi0+c3RhdGlvbl9pZCA9IG5vdGlmX3YxLT5zdGF0
aW9uX2lkOwo+ID4gwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefgo+ID4gSW4gZnVuY3Rpb24g4oCYa21lbWR1cOKA
mSwKPiA+IMKgwqDCoCBpbmxpbmVkIGZyb20g4oCYaXdsX212bV93YWl0X2QzX25vdGlm4oCZIGF0
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmM6MjczNToxMjoKPiA+
IGluY2x1ZGUvbGludXgvZm9ydGlmeS1zdHJpbmcuaDo3NjU6MTY6IG5vdGU6IG9iamVjdCBvZiBz
aXplIDYxMiBhbGxvY2F0ZWQgYnkg4oCYX19yZWFsX2ttZW1kdXDigJkKPiA+IMKgIDc2NSB8wqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gX19yZWFsX2ttZW1kdXAocCwgc2l6ZSwgZ2ZwKTsKPiA+IMKg
wqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+Cj4gPiAKPiA+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4
L2lzc3Vlcy8zMDYKPiA+IEZpeGVzOiA5MDVkNTBkZGJjODMgKCJ3aWZpOiBpd2x3aWZpOiBtdm06
IHN1cHBvcnQgd293bGFuIGluZm8gbm90aWZpY2F0aW9uIHZlcnNpb24gMiIpCj4gPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZwo+ID4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2
YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPgo+IAo+IE5pY2UgY2F0Y2ghCj4gCj4gPiAtLS0KPiA+
IENoYW5nZXMgaW4gdjI6Cj4gPiDCoC0gVXNlIHNpemVvZigqbm90aWYpLCBpbnN0ZWFkIG9mIHNp
emVvZihzdHJ1Y3QgaXdsX3dvd2xhbl9pbmZvX25vdGlmKS4KPiA+IMKgLSBGaXggdHlwbyBpbiB0
aGUgY2hhbmdlbG9nIHRleHQgcy9ib3Vkcy9ib3VuZHMuCj4gPiAKPiA+IHYxOgo+ID4gwqAtIExp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWhhcmRlbmluZy9aSHBFalRtQnlzNWND
T0daQHdvcmsvCj4gPiAKPiA+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
dm0vZDMuYyB8IDggKystLS0tLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL212bS9kMy5jCj4gPiBpbmRleCAzN2FhNDY3NmRjOTQuLjZkMTAwN2YyNGI0YSAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmMK
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmMKPiA+
IEBAIC0yNzMyLDE3ICsyNzMyLDEzIEBAIHN0YXRpYyBib29sIGl3bF9tdm1fd2FpdF9kM19ub3Rp
ZihzdHJ1Y3QgaXdsX25vdGlmX3dhaXRfZGF0YSAqbm90aWZfd2FpdCwKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHdvd2xhbl9pbmZvX3ZlciA8IDIpIHsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpd2xfd293
bGFuX2luZm9fbm90aWZfdjEgKm5vdGlmX3YxID0gKHZvaWQgKilwa3QtPmRhdGE7Cj4gPiDCoAo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBub3RpZiA9
IGttZW1kdXAobm90aWZfdjEsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb2Zmc2V0b2ZlbmQo
c3RydWN0IGl3bF93b3dsYW5faW5mb19ub3RpZiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlY2VpdmVkX2JlYWNvbnMpLAo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoEdGUF9BVE9NSUMpOwo+ID4gLQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBub3RpZiA9IGttZW1kdXAobm90aWZfdjEsIHNpemVvZigq
bm90aWYpLCBHRlBfQVRPTUlDKTsKPiAKPiBUaGUgb25seSBxdWVzdGlvbiBJIGhhdmUgaGVyZSBp
cyB3aGV0aGVyIG9yIG5vdCBwa3QtPmRhdGEgYWN0dWFsbHkKPiBjb250YWlucyBzaXplb2YoKm5v
dGlmKS1tYW55IGJ5dGVzPyBJdCBzZWVtcyB0aGUgbGVuZ3RoIGlzbid0IGNoZWNrZWQKPiB1bnRp
bCBhZnRlciB0aGlzIGFyZWE6Cj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxl
biA9IGl3bF9yeF9wYWNrZXRfcGF5bG9hZF9sZW4ocGt0KTsKPiAKPiBTbywgcGVyaGFwcyB0aGlz
IG5lZWRzIHRvIGJlIGNoYW5nZWQgaW5zdGVhZCwgYW5kIHRoZSBsZW5ndGgKPiBkb3VibGUtY2hl
Y2tlZCwgZXRjLiBQZXJoYXBzIGEgcmVndWxhciBremFsbG9jICsgbWVtY3B5IGlzIG5lZWRlZCB0
bwo+IGhhbmRsZSBwa3QtPmRhdGEgbm90IGJlaW5nIGxhcmdlIGVub3VnaD8KPiAKcGt0LT5kYXRh
IGFsd2F5cyBoYXMgdGhlIGNvcnJlY3QgbGVuZ3RoIGFzIGl0IGlzIHRoZSBhY3R1YWwgZGF0YSB0
aGF0IHRoZQpmaXJtd2FyZSBzZW5kcy4gVGhlIHByb2JsZW0gaXMgdGhhdCBub3RpZl92MSBoYXMg
dHdvIGZpZWxkcyBpbiB0aGUgbWlkZGxlLAp0aGF0IG5vdGlmIGRvZXNuJ3QgaGF2ZSBhbmQgdGhl
IHB1cnBvc2Ugb2YgdGhpcyBjb2RlIGlzIGp1c3QgdG8gcmVtb3ZlCnRoZXNlIHR3byBmaWVsZHMs
IHNvIHRoYXQgdGhlIHJlc3Qgb2YgdGhlIGZ1bmN0aW9uIGNvdWxkIHdvcmsgd2l0aCBub3RpZi4K
ClRoZSBvcmlnaW5hbCBjb2RlIHdhcyBidWdneSwgc2luY2UgaXQgYWxsb2NhdGVkIGFuZCBjb3Bp
ZWQgb25seSB0aGUgcGFydAp1bnRpbCB0aGUgZmlyc3Qgb25lIG9mIHRoZXNlIHR3byBmaWVsZHMg
dGhhdCB3ZSBkb24ndCBuZWVkLiBTbywgc2luY2UKdGhlIGZpeGVkIGNvZGUgYWxsb2NhdGVzIHRo
ZSBjb3JyZWN0IGxlbmd0aCAoYW5kIGNvcGllcyB0aGUgZmlyc3QgY2h1bmspCndpdGgga21lbWR1
cCgpIGFuZCBpbW1lZGlhdGVseSBhZnRlciBzZXRzIHRoZSBmaWVsZHMgdGhhdCBjb21lIGFmdGVy
CnRoZSAiY3V0IG91dCIgcGFydCwgbm90aWYgd2lsbCBiZSBvZiBjb3JyZWN0IHNpemUgYW5kIHdp
dGggY29ycmVjdCB2YWx1ZXMuCiAKCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAoIW5vdGlmKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsKPiA+
IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBu
b3RpZi0+dGlkX3RlYXJfZG93biA9IG5vdGlmX3YxLT50aWRfdGVhcl9kb3duOwo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbm90aWYtPnN0YXRpb25f
aWQgPSBub3RpZl92MS0+c3RhdGlvbl9pZDsKPiA+IC0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtc2V0X2FmdGVyKG5vdGlmLCAwLCBzdGF0aW9u
X2lkKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5vdGlmID0gKHZv
aWQgKilwa3QtPmRhdGE7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+
IC0tIAo+ID4gMi4zNC4xCj4gPiAKPiAKCkFja2VkLWJ5OiBHcmVnb3J5IEdyZWVubWFuIDxncmVn
b3J5LmdyZWVubWFuQGludGVsLmNvbT4K
