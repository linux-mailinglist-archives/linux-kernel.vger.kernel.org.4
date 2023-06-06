Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E633272502B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbjFFWu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbjFFWug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:50:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB391728
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686091835; x=1717627835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j4owAEfT9qM/0ewXwbIn577ZEr59pnnhnUC9ZVZHmr4=;
  b=AlYPu0waOVMhyEalNsVSSkNiAs2/j8iOnbpR4rww+f21c7caxVmGjZhs
   6WszSIRioj6gR6HYFClmBwKBsQqZ5G2AjTVZ/isFegY8wSvEMxCEjv1Iw
   337Jid9t7HBStJ0fhqJZu2B4ceHdlUWAIvWlnnG/JlNXizm7/e9U2GtEo
   6Dh5VtFma6D8NjbSPu3ySWxfPpNXVKpadYAqA1TbFv2kS6VprbvVw+MGk
   PKPeiQt1Lz9aKI0zhAnHhvfu6kSU5MmioW+LamkvzTqX0aW/+FCd+N1Ns
   5BI98nf7J5Zwpi9cv5UsXQmvRUqMRXSkKhyz9vrXnMSrw9jCVDGVmIpP/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="341469848"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="341469848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 15:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="853602301"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="853602301"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2023 15:50:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 15:50:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 15:50:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 15:50:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 15:50:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIML4La8AkWROCCSHcx6D5nuk3Xo2LDDYz8yM+sTZcE9oUtiVMRTVCO55obalk8CctWi5YEmVbxJMONdmok/I4pt+lXtRH0ZDhxGmRKcjfh8fTF/uyrSTlhGqcrjo0SyxGXenOIg2fFD5soN1fUM+ForJRbEigXSSPoXapf+vmnXUWIU4Kj1o4sQ5wivUOre9/WM9J3g4vYh/uC8lb3D/wD8lD4kL5STm9BWV/msK9Ox1gBAZ6D8j21F4o6PsEPjfiLnFuFXNYcKCjkRFnfNI5wYOUsrRDS4JVcCmhL/Q2BijzZUgavkYTyQHwZV0i9N5DJ7yKtKwrHqCtnW5AOGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4owAEfT9qM/0ewXwbIn577ZEr59pnnhnUC9ZVZHmr4=;
 b=bPKjEHeH3L7NSYtg3cFtFMnDzxlN6fP4eQW9BkDdUQnrm1UHvaxFMjkPNnfnvO36AoILsZPSUWTnPvr8Nd6ttL3jkPH+I0/qSNu5S1ODpZskGjE4LCq3inOwwXZDd/ZZdm0TuP5d5MBGPkwcUyxth5BR8GUx3koHTzZ4FVaCJ2eHfyWyeX+d3QKy3ZsoS6Z2IIVtXljjNn6G7Nqkl0DT6F4vsPw03wRtaD7F+omt5qdV3oMoSz9qYl3PTGmhHPthwkShmN7a88dYq8YH+E6liYsHuYZr9zbX6JCcHomKkmpuKCUTfYVa34FMGhxqi6cMdvi+mlfyvYQpjbds/pXfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7988.namprd11.prod.outlook.com (2603:10b6:510:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 6 Jun
 2023 22:50:28 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 22:50:27 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill@shutemov.name" <kirill@shutemov.name>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH] x86/tdx: Explicitly include <linux/errno.h> in
 <asm/tdx.h>
Thread-Topic: [PATCH] x86/tdx: Explicitly include <linux/errno.h> in
 <asm/tdx.h>
Thread-Index: AQHZmCim8jOtX6SwhEChddwFpeg98q99wC+AgACY9oCAAAfJgIAAAU8A
Date:   Tue, 6 Jun 2023 22:50:27 +0000
Message-ID: <4d1e620aa261f51a31c823fcd3ad4835b342b2b1.camel@intel.com>
References: <20230606034000.380270-1-kai.huang@intel.com>
         <c84707e6-4f74-dc89-6243-63a72e86c62b@linux.intel.com>
         <df89f1c66059e717e9a66e314da24f939cc3eabc.camel@intel.com>
         <20230606224543.a4jex2dmn43dvze4@box.shutemov.name>
In-Reply-To: <20230606224543.a4jex2dmn43dvze4@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7988:EE_
x-ms-office365-filtering-correlation-id: bb4fbeb8-388e-4a0a-fd3f-08db66e06bf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Cg+LhfOvKOcMgNp6WEP3dme8TnUjz2mxVBclFfA9RmLRfPNMon1rrM3S/P8gK/VfaQ2xvhQEUnn0ISaD2moB4q53Fi5LhJ+lkgIZ8kf0cbyeC5llN6XojaJLat3oUKCmnlEvxt2X2sy7LJGemyF7ZaSx10MxTYbt7ydpSvUSYbV46oMIskFfPJ/k1EqNp87JJsR69Zsn6qp7bOyBm5xDg8ph15EMChDUO1WGGFwsCp+0g0Oj2edjN9zowYwWRSr+tFicgxIbh8mL7ZmRcdZ17HRHW+3x+sk/ScvUpbHEHCjWz0XSVo/JJDAzYkPaYKkucgYDzwV+tk7hFzTmBXKi9w/V8u0U6UfLPBV7cBtUsUBr7H+BYPmjLB34Ne2Mh72F84SSWxUgoLLJPMSAB5FCZOnPPCZBkmKQHRJpt58MIC2O4aYDA21dsMhy7LxvnTy+Cl7T/4J6i1BI3KhetjKecpPbjibodZw4EJrjHQvuEqPr2R4mTInsEGgPKzLeX9n+SVSVaFgulNZGkLe6fYJndEw3MKIUbtqYLmh1m/cYEl2vE/BvKYW6WSxugLHSb05wcVT5WOR/wYxhv5ayzJbcVA0NBY6HRpvMQt2d6YIy8qGBxz5pLdJ5CLBDOrfiyr0kL4Unq/HzThMZOVMzurWHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(36756003)(86362001)(966005)(2616005)(83380400001)(6486002)(53546011)(6512007)(6506007)(26005)(2906002)(4744005)(186003)(76116006)(66556008)(82960400001)(4326008)(66476007)(66446008)(6916009)(122000001)(71200400001)(478600001)(64756008)(41300700001)(5660300002)(91956017)(316002)(66946007)(54906003)(38100700002)(8676002)(8936002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlIxQ3FUU2QrVlIyYXFXQzNnaVloMko1RTlwRjRubjYwT1F3bzhINmlmeFVj?=
 =?utf-8?B?Q2wzMThaaFNqTkFOS0d6S3NQeHZWRFlZaThTMDBjM09QTlNYNjBQNHNwZkFU?=
 =?utf-8?B?dms0RGhuV09RZUVvTTJySXd6WmdjSjJsTDlsZXdpSU8yWWZPeUZGL3ZDT1BL?=
 =?utf-8?B?L0NvbGo0ZStkZTRvcFRxc1JYRjdSVmdoZENhNExPMnQrWGs3Y1BMbTR1Ym5p?=
 =?utf-8?B?akpWNHdTVzBIUW1QdXB6azYxK0YweW5wb04rN0xmVlIrazE2eE5qSU9PVVZH?=
 =?utf-8?B?Q2NPTnhmTzBTVFlUeDErd1oyb3BWMERxUWsxSnVZME1jc29sVFJ5U0xJVGxi?=
 =?utf-8?B?V3JoWXIrYWlzTVdlSW9EejRpZWhoZGh6VExBRXM2QWJJTjM4d1hZNFVoMDJw?=
 =?utf-8?B?ZlhCaGtuSEhmYkphNkVENHo2SC9QUWxNNXVzaWhwVTlJMjhKekpSU2hhRWJV?=
 =?utf-8?B?NkY5by9ubm9ZNDNlbERyY1N6WEZsNDZCemVJMkltZWt6ZElGeW95Ykp6ZjAw?=
 =?utf-8?B?cnNvWUN6ZkNFYlJid3BWaGg1OTJiM3llWENVeEdBZWpSN2pQc01lcExDcUFa?=
 =?utf-8?B?OFRXaGY4YmtGOW1VRU1CekwrbWVibUpadm9UTXRocWxtZ1krYXIrU1NyYkZC?=
 =?utf-8?B?dFAxYzVuTTE1SGF0TDQyYVk2OCs5NVlqZ2tvUmlSWldFZWRUa202bmI1eEZP?=
 =?utf-8?B?b1VxZm5pN2FEOUp5dWJ4WkIvSHpybVQyRVkzelBoQzExdzZici8rMjUzV3Zl?=
 =?utf-8?B?czltaVl1cGRaTXdVdGhFUUxzTlo3dkYxazRQb3dPVDg4T1FINVBUeHI3M3I4?=
 =?utf-8?B?Y0NUTWg2NXcrTHgrY1BaQUIrUm9kL1VBcU1BZ2ExZ05pWndFaUxCUkY3NGpV?=
 =?utf-8?B?OEZOTGNCa2tWc0RoRnl4cDNwM1JxblA1RnNpR1FrSHU1eXZGdXJVV3c4TGI3?=
 =?utf-8?B?a0ZhR3Z3KzBEY1B3V016d2t4eEJiaVB5bHFaaXRtS1BRemRIWU5RMy9qS2gx?=
 =?utf-8?B?czZ5YXRtT2R3YkU4ZGlLaENIRlBzS2NNdVBqc0RqNmQ2MEQ3WHp5UHphcnRo?=
 =?utf-8?B?c0NCUDNyUDZEeUpJODBhRTZqM2tzRFIyQyt5dmNHb1FmTytWcEwrSmVSdlRN?=
 =?utf-8?B?SUs2VjRSeE1sWUJNS3J5L1NMekZSK1pDVERKYkFtMy9OL2FLY1kxNm80SUhP?=
 =?utf-8?B?UXZJMTdqWHVzaFBzMVFLRFBRMXVTaUhSVzJLaGRodGlsZ3AzdkxnSE43TjVN?=
 =?utf-8?B?YVp5UjFMaWduWXVYQlVIdHh4ZnoxNENsRUVZRXpOdnpyZ2R0K0IyOGwxVWhk?=
 =?utf-8?B?SEpoYTNwQm1BTkNKTFB5UVkrTkh5dTFvWXdpUlZoamJuUUJ3U3NNV08ybVUw?=
 =?utf-8?B?QjhsMFJETCtCdXdpRDhrZWhSOVpBK0VxMnlPQU1tUU83bE8vMEtCV0w3SllK?=
 =?utf-8?B?Nk1LNXM0TXVsV0ppcGlod3R4ZVVlYmZQUExodXQveVlKNGtKdVhuMlZxWUdJ?=
 =?utf-8?B?ckpQeEFTOHNXUnRoV0psQ2JhaGlsekE5MWs5Q29XSnpIb1kybFpFV3p5NjFv?=
 =?utf-8?B?RnlFUzJFL3dXTEM3SmQzVnNHSUN6eEZsTElmZzJCWWlUSW84WjVTNzdXWnVh?=
 =?utf-8?B?Qm15V3Z3QTJacnI4Z01WSlRTQUZqV1F3ZHJ3SStDQTRubGI4aVdtL0pRK3NT?=
 =?utf-8?B?YUFjSkptZjl4bGYveWs3SkNxb2pmV0k5bThWbGZSVEFtVCtnbVQyM01DSzdT?=
 =?utf-8?B?NnRCVkd5dWtaaUdaMzFWdWFmUklNTHFQL1lkTUx5OU1SVm1keDVSTVcxSTE4?=
 =?utf-8?B?eDJmY2t3VFRCMXlDTE1xb2laZzZlK0FUejltbWh0QUNUckVxa0Zsd3YrUWFM?=
 =?utf-8?B?SlA0MnY4TWwxVkNvWGo5Nk9YQ2Z5MVhrV2Z2Qk5qMFdMdGhoNEJkeTc2TWdk?=
 =?utf-8?B?ZkwwT05LdEdqOERsUTJ5aGI3SXRCU3htcWV5TlFJTmxtakZwM3plZHJXU1BZ?=
 =?utf-8?B?UE1pZk9vb2VzLzZKWXFDM0hpS3JURW00a245VzJQMWxtQkVvZTErTXJZSHlU?=
 =?utf-8?B?dEx2UlE0NDNGUW5VazMwdDcyd1loNXk1cFhpMDJJSksveTAzV0srQUxyOXhE?=
 =?utf-8?B?SFhOZU9BUkdIVGtHV0h5dFN6UU1wRnNZNWdiMlBMSllYZVVuMldtNmljUE1Y?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57EE5E1F1656424F94D48FACC273581B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4fbeb8-388e-4a0a-fd3f-08db66e06bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 22:50:27.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQC7//NjyMGiPPlUvZZqk5tqKAz5mRtkBHCdebqGYESA6sUURfiSj0ing6gsi4bHK9V/GBrQeCoiRYwhyhCdWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTA3IGF0IDAxOjQ1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgSnVuIDA2LCAyMDIzIGF0IDEwOjE3OjUzUE0gKzAwMDAsIEh1YW5nLCBL
YWkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIzLTA2LTA2IGF0IDA2OjEwIC0wNzAwLCBTYXRoeWFu
YXJheWFuYW4gS3VwcHVzd2FteSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gNi81LzIzIDg6NDAg
UE0sIEthaSBIdWFuZyB3cm90ZToNCj4gPiA+ID4gQ3VycmVudGx5LCBpbiA8YXNtL3RkeC5oPiB0
ZHhfa3ZtX2h5cGVyY2FsbCgpIHNpbXBseSByZXR1cm5zIC1FTk9ERVYNCj4gPiA+ID4gd2hlbiBU
RFggZ3Vlc3QgaXNuJ3QgZW5hYmxlZCBpbiB0aGUgS2NvbmZpZyB3L28gaGF2aW5nIDxsaW51eC9l
cnJuby5oPg0KPiA+ID4gDQo+ID4gPiBNYXliZSB5b3UgY2FuIGV4cGxpY2l0bHkgc2F5ICJDT05G
SUdfSU5URUxfVERYX0dVRVNUIGlzIG5vdCBlbmFibGVkIg0KPiA+IA0KPiA+IEl0IGFsc28gY2Fu
IGJlIGRpc2FibGVkIGJ5ICFDT05GSUdfS1ZNX0dVRVNULg0KPiANCj4gQm9yaXNsYXYgaGFzIGFs
cmVhZHkgZml4ZWQgaXQgZHVyaW5nIHVuYWNjZXB0ZWQgbWVtb3J5IHBhdGNoc2V0DQo+IGFwcGxp
Y2F0aW9uLiBIZSB1c2VkIDxhc20vZXJybm8uaD4sIG5vdCA8bGludXgvZXJybm8uaD4uDQo+IA0K
PiBTZWUgWzFdIGFuZCBbMl0uDQo+IA0KPiBbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQvY29tbWl0Lz9pZD03NWQwOTBmZDE2N2Fj
YWI0ZDdlZGE3ZTJiNjU3MjllODc3YzBmZDY0DQo+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyMzA2MDYxNjE2MDYuR0RaSDlieGhyR25Ga2FMbDJBQGZhdF9jcmF0ZS5sb2NhbA0K
PiANCg0KV29uZGVyZnVsLCB0aGVuIHdlIGNhbiBkcm9wIHRoaXMgb25lIDopDQo=
