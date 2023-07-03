Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A8745461
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 06:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGCEGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 00:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGCEGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 00:06:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B9BA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 21:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688357196; x=1719893196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VzeoAwja4tbVdl9D2lBhpyD0OJ/2Cy+abmfOOH+qjyg=;
  b=B4cmXLNAqbRj7LhKw+JB42f5NoGWeEH5RpspaNYney6RaAfxo9x9psl8
   wT8PyTF1FAq1ac3PsFuKi9JAcRPD4qUK6t7G0Ewvoapb4eNPP4Npr7mpN
   tjfrZxQ+grhXzTfKtp+8FIlOUOnXTW5sz5hySrsCLDTYfK66gUHIVxdWc
   +oiJS4zN4PSxn+cr11hEvpIQLzXIdBFQDHH6237VjzNFRjPN6vcJ4n/fb
   7wUCj7ngpX8rZVOyGpDeNvujU4xd19IC2AXFGHr5JDnAxaMjFe2DPGxrv
   StCKzSzO7RNhBfah4PzxwGdDFFtJJkxYKBF22WIkvO1mbobClir4cGPjF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="365355665"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="365355665"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 21:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="695662810"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="695662810"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2023 21:06:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 2 Jul 2023 21:06:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 2 Jul 2023 21:06:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 2 Jul 2023 21:06:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 2 Jul 2023 21:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND2c+SeFon06zBDPs7JLoQFq36Fe4Ik0itrlx2IerjODyEvMRAmb+TIC2mO71RygVtsNhVdve3ggE7iGV/Ugfq2+8S5hFYrvj7EzRxfIg1MgMLYfPcTAgRxEQOilO8+NlBpPOXRLcrg2Bf+8QBvZgvI98GchJlCeObHW3vRmtNSU1sWBwoo9PkqE/3sL2Heu7sbwoJ9+R9B6lcjiNJnBwtstixsBvDoPWLqJ8EDDe/6tJm1A+pdM7YqSvzySAKcxIjUBimOzOJhZEENOdvJ+2jsTBhHXzMUmfc9yF4DjRtODs4+bO9F7eUTmtZwdkJOEs7HN7OYlBw2ZrdTZNX9y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzeoAwja4tbVdl9D2lBhpyD0OJ/2Cy+abmfOOH+qjyg=;
 b=if4WsWXO1AzrQ/lxg6ZUM87geJCJ25nFqQrg65XIYmKX1mlXcA/VOdnFfYw86CeGoq4yY+KNTdJiRZ54lgtzllyafctVW6EpPMbYbbwI5XEyUue/HpCkQlYFY1ix6kyhu2IMdt3lIiblTzp3i6qUq5vbuHX/YehJyuRBXEU0G+oVJ4t7+DJCROFns7lXPAXaCxEeXWq7nOSuO5uRfKR8dSjbqTyTZGNsmRJzikKKblb4HSi+uwY1I3VFZ/ueDbpW+vWuyKfyFyIL/K2ULPituxemnIZDqChlhIejW4EuHHGAE2Ybl5pD9uVSJh93gBdxt7vJyfXAA9aDa/O0ZEQIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 04:06:21 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 04:06:21 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Thread-Topic: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Thread-Index: AQHZpOcz4yOfuGedVUe15UWfk8cDPK+WjIqAgAAxu4CAAAfJgIABXnCAgAAJrwCAASC+IIAAQrOAgALqkRCAAE0tAIABPBqQgAAbjgCACVrzIA==
Date:   Mon, 3 Jul 2023 04:06:20 +0000
Message-ID: <PH0PR11MB567351DA47A104A8D7CEED22CB29A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
 <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
 <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <125c849f-3746-864f-8b8f-6e0a33aca439@linaro.org>
 <PH0PR11MB567334A09B2D4A1D3DDC09F2CB20A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <0599fc9c-0057-7aa5-3332-40922753ad97@linaro.org>
 <PH0PR11MB56734DB18155588535DC0384CB26A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <12c68124-9687-d68c-294a-2bfd13338edd@linaro.org>
 <PH0PR11MB5673A2BA9D39B9CD4C775DA5CB27A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <5b6953ac-6bf6-6663-a566-40f0ae9f9572@kernel.org>
In-Reply-To: <5b6953ac-6bf6-6663-a566-40f0ae9f9572@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|PH0PR11MB5013:EE_
x-ms-office365-filtering-correlation-id: ca192545-ce09-408f-f69e-08db7b7adc00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WU9wF8Jz5r9SelXYS+4Aps7VpaAe1ZbD5yh4dDJzzwM0UvhVkwdn822X9EoXL8KZwo7+JmOt1v76CiV95EbuhV8J4bQRiSP8PSmSgMvzPQFm0anBKU9emVcFDQtGOh21zLKn21Wf+ZayWdT4vQFizs+qVEE7wAD5ywi5P3lPJNQ//66N+/Dn6Hvw3bgZWh0/kRQXtqP5ffXYTdQbr8Zr3bZ2dzUnK32JFXAhMG0c7V9Rzey+inxbI/Dwzt1iY2y2GPYKh+LPeHaAlRIN6YD4Z3RPCZeZiFxtkc3ZV1mF+SUsWnWgPnrIthXEwrLKyFNVAp2HCTHAvpWgWdr/fPgwh3LqpjqcIHWTMbUrC3GtgyyCahM6S9VcqhB9R16vAaa7bEOk7Hp/tytgkhTcvsD/XfA+sEaFj0bdHgLnul3TnbBPFhjtYo5UE2WfHGyv0zmGyK+mCW3FNV+TjOB1ezHZgBuxDw9Rzlcp3cR8kFpjxugDsXcECdvnoHnU89cdz3AxKzWa1un++VsFKt5XncuzHSnMORQO7XHF0xz0UOIrmaxBmzSTPauxV4Ggs/lUhWEqDp1TSC3tuQVmCplnyj4A8n+ACsn4M6kqHHF0+oQ3oyg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(2906002)(41300700001)(5660300002)(52536014)(38070700005)(8936002)(8676002)(33656002)(55016003)(86362001)(966005)(7696005)(478600001)(71200400001)(83380400001)(186003)(9686003)(26005)(53546011)(110136005)(66556008)(66476007)(4326008)(122000001)(66446008)(64756008)(76116006)(66946007)(82960400001)(6506007)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzcxOXZqVCtDTURxKzhKd1plL0d2UFYweDhxK25FdWVqNFptTkRoclNwK0ZU?=
 =?utf-8?B?SXhFS0w4bnVIK0VSVjA4dHRHVVZzMzllZGNFQ2hVblVCUzlNZWsyVitHanBi?=
 =?utf-8?B?VXc3ZW9zUDF5SndOeGVjZ3VDbm1xY0FYcDNMcVoyVjBJWnR5TWFhSUJEQVh0?=
 =?utf-8?B?TDJYcHhYTXk1WlNMcE1RT3R5RnBmMFVwck84Z2FjQTl6VGx0VkZjV2hBN2Zo?=
 =?utf-8?B?c1R2MmV2blhIR0dNa091YXE2akEvbU1HcWp2ODJiM2hsb05nSCtxSGUrTXlt?=
 =?utf-8?B?Vk9sdC9kZCs2Vys1c1FDVGNWbmlvQi83NmpWa1JnbWRiK2sxWVpuSTd1Wnky?=
 =?utf-8?B?bC90TUNlZlBTVUZsVUFGdFN1L1dSUk1pSG4xOFlKQWtiaHdXSUdqK3ExeGEy?=
 =?utf-8?B?V21rRWVVRWZOYTJ3eE84MzQrV3drZ3ZUT2FlQUllaEhTTkI4VkRJN0tFSm44?=
 =?utf-8?B?MUdGYm5mUFVRSmw5bFE4OXBSLzg2cWExZG5JWDdIdVBjTzRUL2pmUHU5OXQ2?=
 =?utf-8?B?NlNJcWhmalZFMTE1SUx5L3RmQ20yaTNSL1RURHREOHF4cXk2cHU3SGxYekR4?=
 =?utf-8?B?cnhQTmlMQjdTR1Urd21rTStrbkxSajlKSVdjc3U4NkU5Qmo0RUZZYVpGQnh6?=
 =?utf-8?B?L2UwbDVncDJ2aGVoSUZXRS9GYlVSeWhZbzFsMGdDVDEwMXFrZkwySkhYU0hV?=
 =?utf-8?B?Tm5IQ1ZOYjVzN1JacG9UWU01aTdkaUp6WmNZQUluZ3RBOE9Hb3ZGRmRCRXps?=
 =?utf-8?B?a2c2dXJ6LzA0cUV6TEM3WHVFVlZmcXdWV3NEazFFSE80bkxTdll0M0gySFVX?=
 =?utf-8?B?Rk0rQVZKQ2ZJejdNZzRMdzJ1cUJoMzZKaEgvLzdXbjBwYk9QdjczUVZvSjVT?=
 =?utf-8?B?YWN0NlZsektvaFpLMFphZXBpTDJnSzVPTVV2VElTTXpIeWk0WjdycFhQKzFz?=
 =?utf-8?B?QklKOG5LaWFaMEdka2RGMzR4cTg2ZzJ2QnFDRU9FK1RSSlFkNVBzLzA2QkUw?=
 =?utf-8?B?eSsvbnNSek9wdm54dWlSeEVNNWpoNFlsT0VkQnQ0TkZZQmszYVNqQWZmWTA0?=
 =?utf-8?B?YmsyRUFFL09md05nc0tJNXZnZ1hhOVdDMmMzcWFXWlVPRVp5K0FqVlBuTE4z?=
 =?utf-8?B?SmhZMEpXRmdDSWVGMUdXN2JwWnNOTm1iaFo0YVRCdHNIL1NDM3ZZV1FPNnVu?=
 =?utf-8?B?cmhJSTRESXFEOVhQeGJxQXBuTm9CWSs0TnE5QStqWitoQW9uYjVQQVBUV0tR?=
 =?utf-8?B?aklDeWRYQ0xEejQzdUdGYVV4cjRYRkF3OUx5c0cvWG5pWW5sdDc4Zm5aUlJ0?=
 =?utf-8?B?ZUEwcjl3YjM3TEk1Ly9rQlVldWpERHgwNkNWWkxvZU9GaDRoSVdNa2hsWmtY?=
 =?utf-8?B?bFNMVG83N1Y0aFpPckJoeUNlcm53eDlaWHRjdFJjYm4xTytHNHZDU2tqZ3pD?=
 =?utf-8?B?eGdLU0c1TEtBeC9Fb0RPSmpWckh4Ymg4NnZuWnJ6UnRObS9wd2lvOVU2NEpM?=
 =?utf-8?B?U3pQejBteTVhZzV0RU5ORCtBTXNZK05mdUFyam5YQ3p4bnRpM2h2bWh5UTlY?=
 =?utf-8?B?cmVDMWtqb3RWL0w5dUI0N3F6eUZHdDZhd3AwMFpUS3BHWHlIK0Ftdys1SC8v?=
 =?utf-8?B?QTllMzF6OVlUZGh1NldGYkJkazNJWFNGY2prMUdCZmczVjFROGoyaVZ6OGlY?=
 =?utf-8?B?cFR2NGZVRC9zRVIzbm1vZHZKZ0RtV0FRT1h5aW9XeGJhNkpuOEw4Tk5NV3VV?=
 =?utf-8?B?WVNrMnI3MDBmK3dzQ1k5Wjg5ME5Xc1Y0Ty9hcmRTQVJVMkxCb2hYTXdNTGV4?=
 =?utf-8?B?WUMxWThrNTlRS3ZaSGZla3JEQkJxaGFOS3BENWZ5cEtDNjY1SDZhOE92aGxn?=
 =?utf-8?B?UElZWUs5SFhkcldRU2F2YUJwMU5ueFVYMjlET1hmQ0JoWERBNXBaVFgvWU9t?=
 =?utf-8?B?RXZvVnFka29nVkFlM2wxMTBzZTdMNFdMUWIwSDZWNWk2U1drMEZJbm5qU3JE?=
 =?utf-8?B?V3d4aGRWSXVxQkVCRU5hRllDSXgrK0pXYXQxMnNhbHRKWDFPdGd6UFlzUmd5?=
 =?utf-8?B?aU51MzRtenNVUmZ1T1NtTGx6OC9GNEc2alZRNXlFSHlvOTFuUnc3SzAvby9i?=
 =?utf-8?Q?o4TqYev2R73XH5IeoCqKdOVEs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca192545-ce09-408f-f69e-08db7b7adc00
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 04:06:20.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwHHSUxAQkzBKrOqQcGj6AnT2vemilGgRli4IKh2CqrnZu7ikz/J7UTupxp5wAY6PdNeEciwHTtpbg0fo7xCig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4+IE9uIDI0LzA2LzIwMjMgMDU6NDIsIExlZSwgS2FoIEppbmcgd3JvdGU6DQo+ID4+Pj4+
Pj4+IFNvIHlvdSBtaXNzIGluaXQgcmFtZGlzay4NCj4gPj4+Pj4+PiBDdXJyZW50bHkgd2UgYXJl
IHVzaW5nIHRoZSBib290YXJncyB0byBtb3VudCB0aGUgcm9vdGZzIGZyb20NCj4gPj4+Pj4+PiBR
U1BJIE5PUg0KPiA+Pj4+Pj4gZmxhc2g6DQo+ID4+Pj4+Pj4gWyAgICAwLjAwMDAwMF0gS2VybmVs
IGNvbW1hbmQgbGluZTogZWFybHljb24gcGFuaWM9LTEgdWJpLm10ZD0xDQo+ID4+Pj4+PiByb290
PXViaTA6cm9vdGZzIHJvb3Rmc3R5cGU9dWJpZnMgcncgcm9vdHdhaXQNCj4gPj4+Pj4+PiBJcyBp
dCBwb3NzaWJsZSB0byBtb3VudCB0aGUgdWJpZnMgcm9vdGZzIHdpdGggdGhlIHViaWZzPW0gY29u
ZmlnDQo+ID4+Pj4+Pj4gZHVyaW5nDQo+ID4+Pj4gYm9vdD8NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJ
IHRoaW5rIHllcy4gcm9vdGZzIGRldmljZXMgYXJlIGZvciBleGFtcGxlIG1vZHVsZXMsIHNvDQo+
ID4+Pj4+PiBmaWxlc3lzdGVtIGNhbiBiZSBhcyB3ZWxsLg0KPiA+Pj4+PiBXYXMgZ29pbmcgdGhy
b3VnaCBtdGQgdWJpZnMgcGFnZSAtDQo+ID4+Pj4+IGh0dHA6Ly93d3cubGludXgtbXRkLmluZnJh
ZGVhZC5vcmcvZmFxL3ViaWZzLmh0bWwNCj4gPj4+Pj4gUXVvdGVkOiAnSW4gb3JkZXIgdG8gbW91
bnQgVUJJRlMgYXMgdGhlIHJvb3QgZmlsZSBzeXN0ZW0sIHlvdSBoYXZlDQo+ID4+Pj4+IHRvIGNv
bXBpbGUgVUJJRlMgaW50byB0aGUga2VybmVsIChpbnN0ZWFkIG9mIGNvbXBpbGluZyBpdCBhcyBh
DQo+ID4+Pj4+IGtlcm5lbA0KPiA+Pj4+PiBtb2R1bGUpIGFuZCBzcGVjaWZ5IHByb3BlciBrZXJu
ZWwgYm9vdCBhcmd1bWVudHMgYW5kIG1ha2UgdGhlDQo+ID4+Pj4+IGtlcm5lbA0KPiA+Pj4+IG1v
dW50IFVCSUZTIG9uIGJvb3QuJw0KPiA+Pj4+DQo+ID4+Pj4gV2h5PyBNb2R1bGUgbG9hZGVkIGJ5
IGluaXRyYW1mcyB3b3VsZCBhbHNvIHVuZGVyc3RhbmQgY21kbGluZQ0KPiA+Pj4+IGFyZ3VtZW50
cywgcmlnaHQ/DQo+ID4+PiBUaGUgc3VnZ2VzdGlvbiBpcyB0byB1c2UgaW5pdHJhbWZzIGZvciBy
b290ZnMgLT4gcmVtb3VudCBVQklGUyBhcyBjaHJvb3Q/DQo+ID4+PiBUaGUgY29uY2VybiBpcyBh
ZGRpdGlvbmFsIGluaXRyZCBpbWFnZSBhbmQgc3RlcHMgdG8gc3RvcmUgaW4gdGhlDQo+ID4+PiBs
aW1pdGVkIE5PUiBmbGFzaCAoMjU2TUIsIEJvb3QgZGF0YSArIFVib290IC0gfjY2TUIsIFVCSUZT
IGltYWdlIC0NCj4gPj4+IH44OE1CLCBrZXJuZWwuaXRiIC0gfjEwTUIgPSAxNjRNQikuDQo+ID4+
PiBXaXRoIHRoZSBtb3VudGluZyBSb290ZnMgZnJvbSBVQklGUyB2b2x1bWUsIHdlIGNhbiBza2lw
IHRoZSBpbml0cmQNCj4gPj4+IHN0ZXAsIGFuZCBzYXZlIHNvbWUgc3BhY2UgZm9yIHRoZSB1c2Vy
IG9wZXJhdGlvbnMuDQo+ID4+PiBMZXQgbWUga25vdyBpZiBJIHVuZGVyc3RhbmRzIHRoYXQgY29y
cmVjdGx5Lg0KPiA+Pg0KPiA+PiBhcm02NCBkZWZjb25maWcgY3JlYXRlcyBodWdlIGRldmVsb3Bt
ZW50IGNvbmZpZyBmb3IgYWxsIHBsYXRmb3Jtcywgc28NCj4gPj4gd2h5IHdvdWxkIHlvdSBldmVy
IHVzZSBpdCBpbiByZXNvdXJjZS1jb25zdHJhaW5lZCBzeXN0ZW0/IEl0IHdvdWxkDQo+IGJhcmVs
eSBmaXQuDQo+ID4+IGRlZmNvbmZpZyBtb2R1bGVzIHRha2UgNTAgTUIgYWxvbmUgYW5kIHlvdSBk
b24ndCBuZWVkIG1vc3Qgb2YgdGhlbS4NCj4gPj4NCj4gPj4gSSB0aGluayB5b3UgbWlzdW5kZXJz
dG9vZCB0aGUgcHVycG9zZSBvZiB0aGlzIGRlZmNvbmZpZyBhbmQgbm93IHRyeQ0KPiA+PiB0byBh
cHBseSBzb21lIGFyZ3VtZW50cyBmb3IgZGlmZmVyZW50IHVzZSBjYXNlcy4NCj4gPiBVbmRlcnN0
b29kIHRoZSBwb2ludC4gSW4gdGhpcyBjYXNlLCBJIHdvdWxkIGRyb3AgdGhpcyBkZWZjb25maWcg
cGF0Y2gsDQo+ID4gYW5kIGRvY3VtZW50IGl0IGZvciBjdXN0b21lcnMgdG8gZW5hYmxlIHRocm91
Z2ggbWVudWNvbmZpZy4NCj4gPg0KPiA+IFdpbGwgcHJvY2VlZCB0byBzZW5kIHRoZSB2MyBmb3Ig
b25seSBkdHMgY2hhbmdlcy4NCj4gPiBUaGFua3MgZm9yIHRoZSB0aW1lLg0KPiA+Pg0KPiANCj4g
WW91IGNhbiBzdGlsbCBoYXZlIHRoZSBkZWZjb25maWcgYnVpbGQgdGhlbSBhcyBtb2R1bGVzLiBU
aGVuIHlvdSBjYW4gaW5jbHVkZQ0KPiB0aGVtIGluIHlvdXIgaW5pdHJhbWZzLg0KVW5kZXJzdG9v
ZCwgYnV0IHdlIGNhbiBtYWludGFpbiBpdCBhcyB0aGUgd2lraSBzdGVwcyBzaW5jZSBwcmV2aW91
c2x5IGZvciBKRkZTMg0KaXMgcGFydCBvZiB0aGUgcm9ja2V0Ym9hcmQgcGFnZSBmb3IgdXNlcnMg
dG8gZm9sbG93IHRvIGVuYWJsZSBmcm9tIG1lbnVjb25maWcuDQpUaGFua3MuDQo+IA0KPiBEaW5o
DQoNClJlZ2FyZHMsIA0KTGVlLCBLYWggSmluZw0KDQoNCg==
