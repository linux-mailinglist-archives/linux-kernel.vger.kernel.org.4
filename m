Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15A65B6260
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiILUy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiILUy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:54:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D98C474FF;
        Mon, 12 Sep 2022 13:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663016065; x=1694552065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fgpmsOoojrKog4Cw/pt9efqAdKP08VRVH55JZkl/NPA=;
  b=ZJwCItw19QItK2m978EgKvV5BatsaJBDLwVPAW1d3nB1sxGsgO/OnS4I
   8uFDpHGXGv+AUNZlxtfV4eWI92YNfrMv9huU6YraHvBd4OrZIHSCVxXZ4
   VefoFSW05xKOENK1w0LWo3wlmQlOJZF7SSEPB338ma0o9gjMiere9PW9C
   qCahKWD2GUYXOo06Nt7+Q5Z3Crsi3Vjq1kM6CXrokpgPjRasSFjTxevfF
   NwvwVxf3FVaan4aguCencarxDEpT8NKUD7wA4NRq1fMLYKXEjnukYNv07
   +MTIYLnpvsXunWBcDc7ZN8HpOBGiQ6zUdEiOlIk/kfmoWzpOK2JYqLur3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="384263969"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="384263969"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 13:54:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="684580746"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2022 13:54:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 13:54:24 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 13:54:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 13:54:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 13:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA39CGso41d2UQmQ/20rbOPxEfe5cC1g27nT+D+vjvKba4Ro+8ZNIiTmDWMe+XkyM/zjPcknESLABuNJI0WdgIY+Vn6eBX2YOB5nLVE1Sm3owWRWFS9Xg2xzgy1tFhA2Azldt26yOaGeagSboXnIWdgMIW8/wu6uKHTvePf1eFPVaVm0WRRybJ3/vE+lS4K8OumjFkTfishrZS1+j1GgOjocsMBc5NrM5FEXxNviCh9/Je1y0rluO+irOOKoKIoqg4oM456/IQBBkJhf8ySGF+DxVXi/rMxNBaLdKd0EMtB33K446ESRSSJxDbmqBBhwgND3gUZWlLLKVZWHldZuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgpmsOoojrKog4Cw/pt9efqAdKP08VRVH55JZkl/NPA=;
 b=YP4+TAGKbu3I3cZQAR+MI+EoQ+JjmLZChptmbWy+QE3r95TMaoiUE4JxfHw6jGUARuACOwI/QxInqO1YTKvRil7wppvdYnQ7KAXoC3UZjNkqPDf+28DYB+nN30tfjkkYfEJByZzfVeajmNhbPT2QvCdXC8scAYDmugo7eHvQAm2vfgQ/VWAti5kzHrGEpfgapDiBIsPNE0GYC1k/zAv834HECblTtS5ColZkiTKZ7FzwrYMevonnC51Z22xR6VBz6qxm51rXl/u6vYCQgHxPpEAUcLXGqgGmYdO04DPhcuq+eBzJuO9BuZI1Adc+o5Cl3TIejUVuifA+9n3/RHMtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Mon, 12 Sep 2022 20:54:20 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 20:54:20 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
Thread-Topic: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
Thread-Index: AQHYxCOqzZOxa9vUg0Knyate5r52r63boeEAgAA+dYCAAADvgIAAahuA
Date:   Mon, 12 Sep 2022 20:54:20 +0000
Message-ID: <b68befe6d17cd60a18cc29d7ca2187d91c19f9bc.camel@intel.com>
References: <20220909080853.547058-1-kai.huang@intel.com>
         <Yx8OTDwhqbgvGp4p@kernel.org>
         <ce358ac4-a473-158c-ccce-c50af813fb6d@intel.com>
         <28d7a4bf-591f-3afa-b9ea-526a14abc587@intel.com>
In-Reply-To: <28d7a4bf-591f-3afa-b9ea-526a14abc587@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6454:EE_
x-ms-office365-filtering-correlation-id: 3a3096c6-28cc-4fad-5774-08da9500f6e1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lsfC8bdyR7kcMxVLroaLiMgIOmRlA+XXx111GH8GcG+pcs0hWUKYak5qrpZGQBPcJtjLuCpez26k3d2Lt8aRgdsEcVvRMWvWYw9TzrXVtfRD/FxVjPtSqwYpppy11g4jK1vd7XO3XAxIEj8foAuTT/VGJUN6uYKMtRkAp8YLBsCWLezYJLqsXeKm87ZwjgvGMC0KUbmZBeM2pAdiQs+yXxnKjC7/AN3fBRdzU+rtBAqM0hwUHuUKK3xdJ6vap3Dv0Cox1wMM1oOEuhNxt7/0qy3WFwNl135o7MyaS23II1GV4DnX2kdxAAOUYfigLY5ATwhpclriHsaXY7Qm9t4wP2x8KhGv6toc7wsig1E+A70vKjp+s63T3TqxFGewuCHXC6OGuearOWfjWOMChkXoPMWiBZkJJoBxTzaqoYKhPLYyBF9l58ZMAgYTSidjFlGg814C+K5SgFCWGeUCwE76uUnatPJbaMieS8BZDOMYi+5iVv4Atup0scKRyMH8dAyHsF1PTYMqqlrBGvSpUYLSXPyvyu2tfBIAolIr+8Bg32qH+e/IDbY8rTOCPCF3eTtdXKC5axmk7rlaA/oOmLOGXWqgBjphQVmMG1eQ8BBy/Bo+2Fz4edVHZIRqWV+ANOOyAEnllxd9UaHpWjRJA+aKMdXFYpYDh1TMbef92NpE5DO6zy+Zuq70r8odPYY24ja3Wd3MNNScEIVgaNBj2maF4OJNEZQ3AzKHDOtwY9QJzQjfcT1Gv3VCDTwUmSapTcDlp1SaEnvUouX9I0fO8mfD+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(2906002)(53546011)(26005)(71200400001)(66476007)(478600001)(110136005)(5660300002)(38070700005)(36756003)(82960400001)(8936002)(41300700001)(6486002)(91956017)(66446008)(66556008)(316002)(8676002)(64756008)(4326008)(76116006)(122000001)(83380400001)(38100700002)(6512007)(66946007)(6506007)(54906003)(86362001)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTYxTFFSRjB6OUtVYjJZYzYvUFFrUi9yLzVXbHRPOXpoTURJTW5NL1dHZzRR?=
 =?utf-8?B?cDQ2TTA2ZGQxMWJBT1hSV0hkYnY0eUs3Q09BUEo1ZUVybG9NMTdNRWZGK2Zx?=
 =?utf-8?B?NUJmSzc0TXpPWHJKWjJRWTBQWFNzcXRsdi9FUGlVd2huY0JkZCswamhCd3Na?=
 =?utf-8?B?dUpuZENRMWxoc1dyWDRpbmZYdms3VHByWnpwWEdlUy8wY1hvRmgwWW5sNTYx?=
 =?utf-8?B?UUVJeHJSUm9ReURrVG85bEhUeEtBdS80RjRIQlBJQmw0a0N4QTcyejNsOVRM?=
 =?utf-8?B?UjNWazFOL1pwSnc0RXkzdytIYTIveVFvRGZJUFNxVVk2NWlsNTJrV2VVMTkz?=
 =?utf-8?B?eWRPYmhtYUhYd1lOMy9ZWnJyRnU2U3AyY3RXVzdsaC9yZU12T0d1Z1NCQ0pH?=
 =?utf-8?B?VWQwZ3JWb0VpM3N3VWtVLzVLVThtYWwyOUxwc0FDd1Y2dHVwL2NmckFBbkdG?=
 =?utf-8?B?b3M4d0lVSlBpbFAxS3NUVUIwcE9mRVNmZ3BwR0N0cmhGaXFzM3FMc0VJbXN2?=
 =?utf-8?B?NCtKNHNzQmFoa2NRb2cwL2FWdVFuSytKUE5tTkxuWE9YR3hHelQrVDh0SEJX?=
 =?utf-8?B?bHVrRmRPRzBuWFdZMXFVRlN2VW9UUHFZUEh5WENQODlxeGVpQ2VTMVVBMU1N?=
 =?utf-8?B?aW80Snlzb3NGZnNWbzhRVTBKSHU2MnVzTDE0VjR4MGFwcGYxZWtrWlViNnhS?=
 =?utf-8?B?WmRiUWhBb2YwTXRZUlk5NkY2OEFTL0N3WW1YcDhHb1pKalhWQkpEUkE4Rkc0?=
 =?utf-8?B?ajdIMVdlSjBsd0prcVpGMDZFYjd1dFg2ZjFmbzY4TE9nWHl3RHRVcjhqbG9O?=
 =?utf-8?B?bEFLNTFrRm5ieHhHdzQzZ0VkVUcxcldXYkhwclp3Z0lpSWk1YUxWbFp0MFdk?=
 =?utf-8?B?VDV2RzZXM0l2SDlRbStuYVBuRGV6My82SGFOWitGQ1d6WHVvcnpJNnpLakpm?=
 =?utf-8?B?dGFBRVBYYnpoY1FTOENiY2RtMEdCdUlLM1Jtc25Tem9Gb08rN0YxbExWTmtP?=
 =?utf-8?B?MjhMWmswUEZzWVRDckJNQ0Rzdko3elpkNjFpWGVzc3JUMkMvbjlBOEVLdnNv?=
 =?utf-8?B?VmR5OHZYOUlqZDZzdlJyNi84UnlST1laQUxOdStWRUFUV3huZVJhcmxiOElE?=
 =?utf-8?B?KzRGL0Y5RThjOWVwOGprUVYvYWQvV0dnbDJEcVhvS0VNUW0wY1NJZHFBSU4z?=
 =?utf-8?B?UWJ4V0QwTi9Xd2ZCVFMyRldlN3BKVWxxeDRQWTdoZWVXbk4reGs3Smsxc2Nu?=
 =?utf-8?B?MkxCcUo0WEU0MTF4U0FEYkNyNG56d2s0VStGUjljQTNPTXpMa2xRS1JBY2pU?=
 =?utf-8?B?ekJYWHBmVFNudkIxSVpNcWdHZ3NyeXJkRWtzYmh0RXRlMThmNXNyY1R3U2xI?=
 =?utf-8?B?MGhldGl3YlNZSWFVTjlXMThheDUycW5QSHlUSXJrL2RORkRpYmgwaG5ya1lK?=
 =?utf-8?B?b3p0TUprbTdsYldhaU9iSElMaWJUK1I1V3RLeUtJalAwMmxPajBoVVAyZWMy?=
 =?utf-8?B?UFFwdjJtN2VvQk1HekhZQlRHVXRpZzVNaCt3cVZKVUxYa0pmWFd5QlZ1VnNs?=
 =?utf-8?B?UDYzbkdvaFh2V2w5WkVlOVpUVDkzbWNqbHhhSFNNbERreEtqT2VVU2dqUTcx?=
 =?utf-8?B?VXk5MFpaSW13SW9iTlVwQWJ1Nmdwc2lnTDFzYTFROEYzdGl1eUhOSml4dmMy?=
 =?utf-8?B?aHBWSDlESlBrakw3ZCt2UUJreFk1QWx6VUNuMWJ2OHI1bHZuNjNRTjhwRHll?=
 =?utf-8?B?WDQxSys5eE1HcFNEeFhqOVBVVEszQjVQc3ZTMzZiaVppekhQT0NyOFZOL3cw?=
 =?utf-8?B?UTBTUHRqUTlSSS91WjUwNFoxOGlBaUl0NzBnYkFuTGR1WjNrdS9xZlBWR2JP?=
 =?utf-8?B?YVdQcmJTUGs0dk5uK1Q4Q1FxL0FWQVBIWWlzeXlWcGlyUUVrV3JIdlpJUjhy?=
 =?utf-8?B?K2lGanQyVmN0TzRnam91VUdBSzVDNkp5OVgweHFoR01TbHpSbzRVS3dOMzBq?=
 =?utf-8?B?d0NqdzgramVTOFlLcEFVS2lNdy82RmlyQnZ3UG1XV25Hb2xldDlwL1BNWmk0?=
 =?utf-8?B?ZHJ4UzVOOVZNenpIZCt4emNaZy9McXZDbS9FRHQyUEIvUjRQU3J2M0V6NEVL?=
 =?utf-8?B?THczd1RxZEZwWXgvUGRyZ1JJN2RIWEZ5elNZM2ZNN3hDWHNQZUNTK3M1TVZT?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4C4E8273775414B9A9E6BC0A5C0EB7B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3096c6-28cc-4fad-5774-08da9500f6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 20:54:20.0223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/2jCv6i4y6c9K2V3IHQeHknoTOeEASO4lLr4HQ0OamBmWIY7z/BXwYUDa7X4OoN5pg07O1AG2LXLfz6VbLTEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
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

T24gTW9uLCAyMDIyLTA5LTEyIGF0IDA3OjM0IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8xMi8yMiAwNzozMSwgUmVpbmV0dGUgQ2hhdHJlIHdyb3RlOg0KPiA+IA0KPiA+IE9uIDkv
MTIvMjAyMiAzOjQ3IEFNLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+ID4gPiBPbiBGcmksIFNl
cCAwOSwgMjAyMiBhdCAwODowODo1M1BNICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiA+
IEN1cnJlbnRseSBvbiBwbGF0Zm9ybSB3aGljaCBoYXMgU0dYIGVuYWJsZWQsIGlmIENPTkZJR19Y
ODZfU0dYIGlzIG5vdA0KPiA+ID4gPiBlbmFibGVkLCB0aGUgWDg2X0ZFQVRVUkVfU0dYIGlzIG5v
dCBjbGVhcmVkLCByZXN1bHRpbmcgaW4gL3Byb2MvY3B1aW5mbw0KPiA+ID4gPiBzaG93cyAic2d4
IiBmZWF0dXJlLiAgVGhpcyBpcyBub3QgZGVzaXJlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IENsZWFy
IFNHWCBmZWF0dXJlIGJpdCBpZiBib3RoIFNHWCBkcml2ZXIgYW5kIEtWTSBTR1ggYXJlIG5vdCBl
bmFibGVkIGluDQo+ID4gPiA+IGluaXRfaWEzMl9mZWF0X2N0bCgpLg0KPiA+ID4gPiANCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiA+ID4g
SXMgaXQgYSBwYXR0ZXJuIHRoYXQgZmxhZ3MgYXJlIGNsZWFyZWQgd2hlbiB0aGV5IGFyZSBkaXNh
YmxlZCBieSB0aGUNCj4gPiA+IGtlcm5lbD8gSSBkb24ndCBrbm93IHRoZSBhbnN3ZXIgZm9yIHRo
aXMuDQo+IA0KPiBUaGVyZSdzIG5vIGdvb2QgcGF0dGVybi4NCj4gDQo+IEJ1dCwgb25lIGd1aWRl
bGluZSBpcyB0aGF0IHRoZSBYODZfRkVBVFVSRV8qJ3MgYXJlIGZvciB0aGUgKmtlcm5lbCouDQo+
IFRoZXkgYXJlICpub3QqIGZvciB1c2Vyc3BhY2UuICBUaGUgZmFjdCB0aGF0IHRoZSBmZWF0dXJl
cyBhcmUgZXhwb3NlZCB0bw0KPiB1c2Vyc3BhY2UgaW4gY3B1aW5mbyBpcyB1bmZvcnR1bmF0ZSwg
YnV0IGl0IGRvZXNuJ3QgY2hhbmdlIG91ciBndWlkZWxpbmUuDQo+IA0KPiBTbywgaWYgdGhpcyBw
YXRjaCBpcyBkb25lIG9ubHkgZm9yIHRoZSBiZW5lZml0IG9mIHVzZXJzcGFjZSwgSSBkb24ndA0K
PiB0aGluayB3ZSBzaG91bGQgYXBwbHkgaXQuDQoNCkl0J3Mgbm90IGRvbmUgZm9yIHRoZSB1c2Vy
c3BhY2UuICBBRkFJQ1Qgbm8gb25lIGlzIGNvbXBsYWluaW5nIGFib3V0IHRoaXMuICBJDQpqdXN0
IGhhcHBlbmVkIHRvIHNlZSB0aGlzIGFuZCB0aG91Z2h0IGl0J3MgYSByaWdodCB0aGluZyB0byBk
by4NCg0KQWxzbywgaW4gbXkgb3RoZXIgcmVwbHkgdG8gdGhpcyB0aHJlYWQgSSBwdXQgb25lIHJl
YXNvbiB0aGF0IEkgdGhpbmsgaXQncw0KcmVhc29uYWJsZToNCg0KIg0KQnV0IGZvciBTR1ggZXZl
biB0aGUgY3VycmVudCB1cHN0cmVhbSBjb2RlIGNsZWFycyBTR1ggZmVhdHVyZSBpbiBzb21lDQpj
b25kaXRpb25zLCBmb3IgZXhhbXBsZSwgd2hlbiBTR1hfTEMgaXMgZGlzYWJsZWQgYnkgQklPUyAo
aW4gd2hpY2ggY2FzZSBvbmx5IEtWTQ0KU0dYIGNhbiBiZSBzdXBwb3J0ZWQpIGFuZCBLVk0gU0dY
IGlzIGFsc28gZGlzYWJsZWQsIGkuZS4gZHVlIHRvDQpDT05GSUdfWDg2X1NHWF9LVk0gaXNuJ3Qg
c2V0Og0KDQogICAgaWYgKCEobXNyICYgRkVBVF9DVExfU0dYX0xDX0VOQUJMRUQpICYmIGVuYWJs
ZV9zZ3hfZHJpdmVyKSB7DQogICAgICAgICAgICBpZiAoIWVuYWJsZV9zZ3hfa3ZtKSB7DQogICAg
ICAgICAgICAgICAgICAgIHByX2Vycl9vbmNlKCJTR1ggTGF1bmNoIENvbnRyb2wgaXMgbG9ja2Vk
LiBEaXNhYmxlIFNHWC5cbiIpOw0KICAgICAgICAgICAgICAgICAgICBjbGVhcl9jcHVfY2FwKGMs
IFg4Nl9GRUFUVVJFX1NHWCk7DQoJICAgIGVsc2Ugew0KCSAgICAgICAgICAgIC4uLg0KCSAgICB9
DQogICAgfQ0KDQpTbyBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGNsZWFyIFNHWCBpZiBib3Ro
IFNHWCBkcml2ZXIgYW5kIEtWTSBTR1ggYXJlIG5vdA0KZW5hYmxlZCBieSB0aGUga2VybmVsLg0K
Ig0KDQotLSANClRoYW5rcywNCi1LYWkNCg0KDQo=
