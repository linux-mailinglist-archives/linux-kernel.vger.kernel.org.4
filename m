Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F8566025B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjAFOiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjAFOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:38:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D2DEF;
        Fri,  6 Jan 2023 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673015894; x=1704551894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PZLPz+9767EnRfwpCDP/tjc5brek05asl07y9ULD0/A=;
  b=LFfV8FzbOaBBi44LzELzl3PC7E9PkcEnzqFTA1Y1agPvRRivSn217dNE
   6R8YZ3NmRzp2zE4hfB8KKnoKkhZZOJk7c1LYQ7gWUPXfJOWEAqpRSqgEL
   KmnYKi/kqP9KUblYw5f0EjxePuh+xAar/Y1IEoydnBiU50epZxOst4PRj
   3cw+iLKYuoZ+EyvYXpnFnKbuQOIXRF9lZhIzGtxfZIYC1UBGGqK63ejYe
   hssxfjXUiv6tNfyROi5lLRf1lx/ISs40Zr4JZGMLVRanQstpHTMD9xiFO
   vXUd0X6BBvAUhhtCCxn5ELS9MQHCOjkmXuMkbM/CxYiE+qDiQ0U7x6exw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="349696282"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="349696282"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 06:38:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="655968340"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="655968340"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2023 06:38:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 06:38:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 06:38:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 06:38:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 06:38:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw9xdtvnJNVTaUgJmdGqtwbf4mdSISlmraEXZOHGw6Wr8NIw8lxlmxTONt+4VUlSVVX1AEqMaCjEuj6rQDaKmDVRRlewX5Fq8WdX+QOOHHM3rcMqxTkQtBQqfexatlbACJP/n91m8+QWOra8ONUdCpRYTyrbsYDhDgWj/DlffzzF7Kj9AhrAOdkC2NOokWrUqHAImXwOgXIhckw5tZgDgsvkF0cWbfve3kf8RaObetT4ATzz7iCkLm0woIU8uoO9XWbuj9vlNkYg7jxBMYw8lwtvZk7+r/6UoEqK6+vPRss3225kcaf85SGYifyH3cEjDVHUYxLQHVAVjmRIUFoTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZLPz+9767EnRfwpCDP/tjc5brek05asl07y9ULD0/A=;
 b=O9sgpD+D6Lhn8z2Gb69QDO4xlk85yoThhpX72M/f+G7KSOpEk14a9cb1uGqdeCUYjJIcFKAhLVR1aTNQ5ZXqBPdKM9bK6bEU4/JfUr06RyZ4Rgu9gYwG4ahOSMXfWPvrTNLmAtCx8BRgZvWo0YtKrf2OzPjqpgbc4GOJFZFAx+/PcS4dPTZ1GZsg7lM+K3eBQHLHLHiQenq8ZTNQhla73s0Dy97bc9Fe5n3W6CXagMwhs2a+l0U6e5smXOHT8FZTG2S/j6AozXuh0WxMbmFr56pBV96077gqr2v8QYULINyI2zKU6L4FLRBc7L7hfyn8CLAiik6yxeOWH2A/T02Bzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 14:38:11 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 14:38:10 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Topic: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Index: AQHZIF1bxwQ7XEIB0EO18Lgdi7O9X66PZGKAgAAyjYCAAVIkAIAATGEAgABCzQA=
Date:   Fri, 6 Jan 2023 14:38:10 +0000
Message-ID: <d6ae35f1e72d4bb8e02f44fe6d9369f1a5f21619.camel@intel.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
         <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
         <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
         <Y7aejeHDpLlwwYbr@zn.tnic>
         <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
         <Y7f6RhF8FuK9R399@zn.tnic>
In-Reply-To: <Y7f6RhF8FuK9R399@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SN7PR11MB7603:EE_
x-ms-office365-filtering-correlation-id: 10e1e159-fafd-46cf-ac46-08daeff3a22e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYGSEbVCkAmTPQ7ugd/mUxzpZEA5MzmYDHnXXysywf+YRxUPVMrX2H8/apP6P7nUmU2FPCBhweaKr8j7NtJmcXaD/juRcXCTSDdobAAxjf4SmiaMcKXKx0MdfBmuPxyfClhMQk+TOdle4PCYibgA1fwg8Xe8ZYO/jauIh+LA4JjubLVf7MpGDk3JyAIsetmEOHEjxF5ff6woqtaoqxMs5vWEOkH3vPya5OHmIw1yexSzjN0RITMN2WPUE42pg1hoAJADKcZUMjOjYtC0FnOyy/3xmNQ+SsXzUrJBjyD/diE1d3lXTzCxiWmZDVePdhUriFgDcV4xdgcF+C1rwvTVAQPGBEsD6zU/AXclx5+eEW/a+udjWnXpBdHHi6iMxSnZyLo9ekayp6e2QjWl7RE2omTXD6y6tgdfSkjB4GgrubBJuAWxmw6iBM+jaLI8sTuoEDLqDUCxRtQXNLMLYQWZBcVk724udeXgjpLjLK/2T7si8uhNzSxuBgmcq6fnp0zD/bzIf03hQtZoe96FuJr9guN6bxYzN2q+nwYIDmvXb37WcbONwv+H3oIPTcN1WVlKvbZjos9wOHXMgSscTCYGRfuZswnxW7hCOESB3oA9tvF7Q982hhsvDRxGxnHukiwssRJV98VpBpQvpursQEQeS1RMNT/zQSDaqfNWvFB+BdB3N7Xb3yJbCWND6dGOn43ko8ylN1juOkYI91YvaMyqZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(38070700005)(66946007)(122000001)(38100700002)(82960400001)(36756003)(86362001)(6506007)(2616005)(91956017)(76116006)(64756008)(478600001)(6486002)(71200400001)(186003)(6512007)(26005)(6916009)(54906003)(66446008)(66476007)(8676002)(4326008)(2906002)(316002)(66556008)(8936002)(7416002)(41300700001)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDk5WG1obldvNnN6WHBzaFgxSm5KYTBKR0IveTdjOEZZLzEzdldqa09lV3Ji?=
 =?utf-8?B?Um53U3lzR3A0cE51dzl1SEZQcTRoYjJtYlNXbEF2dG1kTk1aMW1JbklNRm5V?=
 =?utf-8?B?dkpjL2RoNjdvTjM0RDJpdUppcERvcGVJcml4MGlULzBWQWdoaTU2VzFGNDkz?=
 =?utf-8?B?eW11cVNoUERrNGMxaThqOXNEdDduZTFkbjlsZDMwVW1QZDNucTd1MkltQXdD?=
 =?utf-8?B?T1ZtMkFvNnVMckpNUmQxc2M3dTlyak5TM3lhSm9HV3AzdDJtdDk5SmFMZk9J?=
 =?utf-8?B?M3k5U0I2aTdkM0VWNlg4MDllRnpCN1o4MWtxTW1kam5WWW9TTHZOZTNpaStU?=
 =?utf-8?B?V1RNM2VFTitNYzdaR2E5cEM3WjZ1NktVa1BBaktiVWFVRDNPV2haM0krZytr?=
 =?utf-8?B?dmdFQnRlMmxLa1NsRW1pN2tZL3BTNFVxL0lYNGsxNmhGSVQxVmU4bmIwc1Zn?=
 =?utf-8?B?bTdZaTJJQ1dNRVJGai9zYnJnWnBsQzlrNWw3b1RHWVdycFcyREZkRktYa2tI?=
 =?utf-8?B?T0JnZFNKeFJETUpha2J6dHdNTkl1Rzk0VXVabllwVVVsY2lvaVoxNFpaRjdI?=
 =?utf-8?B?ZVJPM29EMGNBQjN6WGhiNG5uZk1uS1laSHh6d3JPd0JjRXpRalFxbzY2Rndx?=
 =?utf-8?B?U1YvNVEwWjRmTzBaNGQyczUxYkw1SEtTa2dFdHBqQ0J6U0FJTzhDN1dHeFZo?=
 =?utf-8?B?c1NqUGh0RC9iSWtrRFhWVU1lZm9nSEw3N1JVcEsxRGxyWjFFV2oxdnJrVWdl?=
 =?utf-8?B?eG5ZR3JUbnFyelBxenprUjlzTTNpRXhMc1F1TVFDZ0VRRXF4YzloeDArS2NY?=
 =?utf-8?B?SWxybmpqOHVudzNOZXBGTzJxejByT3U0YmxzYmtwYnlDMmc3UzdLcW9lU0lR?=
 =?utf-8?B?eTNjSUQzNTcwZG96a1I4L0Mra2J3Mi9jR3ZUNFFXM3gxQ29paXpYc050c3gr?=
 =?utf-8?B?QjdFa3JtaFVwbEZTMmZrNkZnaG5rMG5aeDlUMDZUbWQ0MnNFMEk1cUtLMXdm?=
 =?utf-8?B?SjhUOFZIS05LR3dPaEFtUVk0RStjeXY0RmlRRm1RcEJ4MVEzR3Q1TzZYRnQy?=
 =?utf-8?B?dGdnY3NvdDQ4VVlTTlVkQ3hwYk1rb1JwMThycEI1UWhoSG1oVkVCNTN3ajFp?=
 =?utf-8?B?Q2ZCbzBad3JjT1VlWGlJZ3dlTTJ2NUJ5OEtkZkJNRDhXcjJLME5wY21TVFZO?=
 =?utf-8?B?UUVESXhKRm16cXdrZDc1czdVb2R4cWVGYnFLTnJXVGhrUnhRekZMclJmQ3Za?=
 =?utf-8?B?Wk9Tam1uaStFUHBwSkYreXJUL2JBRmpHTko3OVlqS0dhem5PL0U1Qm9keEtu?=
 =?utf-8?B?eEdHU0lKZEVwTmh3UHJGZ1g1RkpBaUxkN3FaY3ZmQmZqWDVGYWRFOGYyT1pq?=
 =?utf-8?B?ZXpYaWNpbFJKNFBiMXN2SGFIa1JwaGtaTXJJUEo5SHp0OERuVk9ZWWplakFn?=
 =?utf-8?B?WVNDanhyNXhvaGdaN1VEeXZYL3lBVFBWZ2dvRHlQM2g5NmU4QWtUTlVOV0dN?=
 =?utf-8?B?RlZIRUdPYkg5QW1PMFIrSy9NQ2xPRWY0V0pqK0RraG83QVlNcFplVEVodlhX?=
 =?utf-8?B?K2hIWG5YSVBtLy82aXZUL3VIVnV4Mlg2bHBmUFY2TmhlU0h2MGVXZk9pVjhX?=
 =?utf-8?B?ODZRVm4zZkgyc0UwL0VDV0ZUU0xuU2YrMmdXaGM1R0Z6T0NUdEoxMENZY3FX?=
 =?utf-8?B?OThPbm5Gdk5uOU1vSkk1WThnTDlMK3ludlQyMml0UzdPN2NrenAzZTNFNGtN?=
 =?utf-8?B?T0cvNlJqWHk1ak1JWTlEcWdtcWVrV1Y4OGN6V1NYNUorY0NFaUxMOVhwdlla?=
 =?utf-8?B?cU5pSWZ0YU5EOUs2T1haVnUrM0lnNURpRHVxOFppRnNuUlh4U0NDdjg1QnF5?=
 =?utf-8?B?YjVyWEdxcm9NMytwVlRaV1U4SEVwWm12K3V3cW5xZUdwZGRsK0I0MnkySHlj?=
 =?utf-8?B?cGl5U2FBa0RIVmh1UndPMVFEbGs4UjVsQVJtZUM5K0hEeSt4OHNTK2sySEwr?=
 =?utf-8?B?K0hPQ3Z5aURMTVY2eUQxSkdmUG53dDRqcS9HQ05hWjM4YmdMQ1pDNFFPVnQ0?=
 =?utf-8?B?Q3pqUDdxR0EyTk5Jb3RNd25kdk9OWjJjYS85Mjl6RG90NzZoMG5mNkJKaUdo?=
 =?utf-8?B?SWxmSHdaSHVUaDdFdEVqVFdRQTdHcFNFVmhocWMwVCs3OVgwVytXSFNmcTRV?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A8010C2B6E7AC4FA70097A224669F64@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e1e159-fafd-46cf-ac46-08daeff3a22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 14:38:10.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIfnfyis1Z98ugP8PXxbbmbXaSf1hGIH3i5GE5hojeluZ5Cx+Gno3jRr7VmK2N/a81tG7DnTVvDJlTPgqdaaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJvcmlzLA0KDQpPbiBGcmksIDIwMjMtMDEtMDYgYXQgMTE6MzkgKzAxMDAsIEJvcmlzbGF2
IFBldGtvdiB3cm90ZToNCj4gT24gRnJpLCBKYW4gMDYsIDIwMjMgYXQgMDY6MDU6NDFBTSArMDAw
MCwgWmhhbmcsIFJ1aSB3cm90ZToNCj4gPiBCdXQgSSBzdGlsbCBoYXZlIGEgcXVlc3Rpb24uDQo+
ID4gVGFrZSBSQVBMIGZlYXR1cmUgZm9yIGV4YW1wbGUsIHRoZSBmZWF0dXJlIGlzIG5vdCBhcmNo
aXRlY3R1cmFsLA0KPiA+IGFsdGhvdWdoIDgwJSBvZiB0aGUgcGxhdGZvcm1zIG1heSBmb2xsb3cg
dGhlIHNhbWUgYmVoYXZpb3IsIGJ1dA0KPiA+IHRoZXJlDQo+ID4gYXJlIHN0aWxsIGNhc2VzIHRo
YXQgYmVoYXZlIGRpZmZlcmVudGx5LiBBbmQgc28gZmFyLCB0aGVyZSBhcmUgOA0KPiA+IGRpZmZl
cmVudCBiZWhhdmlvcnMgYmFzZWQgb24gZGlmZmVyZW50IG1vZGVscy4NCj4gPiANCj4gPiBJbiB0
aGlzIGNhc2UsIGNhbiB3ZSBoYXZlIHNldmVyYWwgZGlmZmVyZW50IGZsYWdzIGZvciB0aGUgUkFQ
TA0KPiA+IGZlYXR1cmUNCj4gPiBhbmQgbWFrZSB0aGUgUkFQTCBkcml2ZXIgcHJvYmUgb24gZGlm
ZmVyZW50IFJBUEwgZmxhZ3M/IE9yIGVsc2UsIGENCj4gPiBtb2RlbCBsaXN0IGlzIHN0aWxsIG5l
ZWRlZC4NCj4gDQo+IFdlbGwsIHlvdSBhc2tlZCBhYm91dCBkZXRlY3RpbmcgQ1BVcyBzdXBwb3J0
aW5nIFJBUEwuDQo+IA0KPiBOb3cgeW91J3JlIGFza2luZyBhYm91dCBkaWZmZXJlbnQgUkFQTCAi
c3ViZnVuY3Rpb25hbGl0eSIgb3INCj4gd2hhdGV2ZXIuDQo+IA0KU29ycnkgdGhhdCBJIHdhcyBu
b3QgY2xlYXIgZW5vdWdoLg0KDQpNeSBvcmlnaW5hbCBwcm9wb3NhbCBpcyB0aGF0LCBpbnN0ZWFk
IG9mIG1haW50YWluaW5nIG1vZGVsIGxpc3RzIGluIGENCnNlcmllcyBvZiBkaWZmZXJlbnQgZHJp
dmVycywgY2FuIHdlIHVzZSBmZWF0dXJlIGZsYWdzIGluc3RlYWQsIGFuZA0KbWFpbnRhaW4gdGhl
bSBpbiBhIGNlbnRyYWwgcGxhY2UgaW5zdGVhZCBvZiBkaWZmZXJlbnQgZHJpdmVycy4gc2F5LA0K
c29tZXRoaW5nIGxpa2UNCg0Kc3RhdGljIGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkIGludGVsX3Bt
X2ZlYXR1cmVzW10gX19pbml0Y29uc3QgPSB7DQogICAgICAgIFg4Nl9NQVRDSF9JTlRFTF9GQU02
X01PREVMKFNLWUxBS0VfTCwgICAgICAgICAgIFg4Nl9GRUFUVVJFX1JBUEwgfCBYODZfRkVBVFVS
RV9UQ0NfQ09PTElORyksDQogICAgICAgIFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFNLWUxB
S0VfWCwgICAgICAgICAgIFg4Nl9GRUFUVVJFX1JBUEwgfCBYODZfRkVBVFVSRV9VTkNPUkVfRlJF
USksDQogICAgICAgIC4uLiANCiAgICAgICAgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoQUxE
RVJMQUtFLCAgICAgICAgICAgWDg2X0ZFQVRVUkVfUkFQTCB8IFg4Nl9GRUFUVVJFX1RDQ19DT09M
SU5HKSwNCiAgICAgICAgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoU0FQUEhJUkVSQVBJRFNf
WCwgICAgWDg2X0ZFQVRVUkVfUkFQTCB8IFg4Nl9GRUFUVVJFX1VOQ09SRV9GUkVRKSwNCiAgICAg
ICAgLi4uDQogICAgICAgIHt9LA0KfTsNCkFuZCB0aGVuIHNldCB0aGUgZmVhdHVyZSBmbGFncyBi
YXNlZCBvbiB0aGlzLCBhbmQgbWFrZSB0aGUgZHJpdmVycyB0ZXN0DQp0aGUgZmVhdHVyZSBmbGFn
cy4NCg0KVGhlIGdvYWwgb2YgdGhpcyBpcyB0byBkbyBtb2RlbCBsaXN0IHVwZGF0ZSBpbiBvbmUg
cGxhY2UgaW5zdGVhZCBvZiA0DQpvciBtb3JlIGRpZmZlcmVudCBkcml2ZXJzIHdoZW4gYSBuZXcg
bW9kZWwgY29tZXMuDQoNCklmIHllcywgdGhlbiwgdGhlIHNlY29uZCBxdWVzdGlvbiBpcyB0aGF0
LCAgdGhlcmUgYXJlIGNhc2VzIGxpa2UgUkFQTA0Kd2hpY2ggaGFzIG1vZGVsIHNwZWNpZmljIGJl
aGF2aW9yLiBUbyBtYWtlIHRoZSBkcml2ZXIgdG90YWxseSBjbGVhbiwgSScNCm0gd29uZGVyaW5n
IGlmIHdlIGNhbiBoYXZlIGRpZmZlcmVudCBmbGFncyBmb3Igb25lIGZlYXR1cmUgc28gdGhhdCB3
ZQ0KZG9uJ3QgbmVlZCB0byBtYWludGFpbiB0aGUgZXhjZXB0aW9ucyBpbiB0aGUgZHJpdmVyLiBT
YXksIHNvbWV0aGluZw0KbGlrZQ0KDQpzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgaW50
ZWxfcG1fZmVhdHVyZXNbXSBfX2luaXRjb25zdCA9IHsNCiAgICAgDQogICBYODZfTUFUQ0hfSU5U
RUxfRkFNNl9NT0RFTChTS1lMQUtFX0wsICAgICAgICAgICBYODZfRkVBVFVSRV9SQVBMX0RFRg0K
QVVMVCB8IFg4Nl9GRUFUVVJFX1RDQ19DT09MSU5HKSwNCiAgICAgICAgWDg2X01BVENIX0lOVEVM
X0ZBTTZfTU9ERUwoU0tZTA0KQUtFX1gsICAgICAgICAgICBYODZfRkVBVFVSRV9SQVBMX0ZJWF9E
UkFNIHwgWDg2X0ZFQVRVUkVfVU5DT1JFX0ZSRVEpLA0KIA0KLi4uIA0KICAgICANCiAgWDg2X01B
VENIX0lOVEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFLCAgICAgICAgICAgWDg2X0ZFQVRVUkVfUkFQ
TF9ERUZBDQpVTFQgfCBYODZfRkVBVFVSRV9UQ0NfQ09PTElORyksDQogICAgICAgIFg4Nl9NQVRD
SF9JTlRFTF9GQU02X01PREVMKFNBUFBIDQpJUkVSQVBJRFNfWCwgICAgWDg2X0ZFQVRVUkVfUkFQ
TF9GSVhfUFNZUyB8IFg4Nl9GRUFUVVJFX1VOQ09SRV9GUkVRKSwNCiAgDQouLi4NCiAgICAgICAg
e30sDQp9Ow0KDQo+IFlvdSBjb3VsZCBkbyB0aGUgc3ludGhldGljIGZsYWcgZm9yIGZlYXR1cmUg
ZGV0ZWN0aW9uIGJlY2F1c2UNCj4gYXBwYXJlbnRseSBnaXZpbmcNCj4gaXQgYSBDUFVJRCBmbGFn
IGlzIHNvbyBleHBlbnNpdmUgKC9zYXJjYXN0aWMgZXllcm9sbCkgYW5kIHRoZW4geW91DQo+IGNh
biBwaWNrDQo+IGFwYXJ0IHN1YmZlYXR1cmVzIGluIHRoZSBSQVBMIGNvZGUgYW5kIGRvIGZsYWdz
IHRoZXJlLCBhd2F5IGZyb20gdGhlDQo+IHg4NiBhcmNoDQo+IGNvZGUgYmVjYXVzZSBubyBvbmUg
c2hvdWxkIHNlZSB0aGF0Lg0KDQpJIGdvdCB5b3VyIHBvaW50Lg0KDQp0aGFua3MsDQpydWkNCg==
