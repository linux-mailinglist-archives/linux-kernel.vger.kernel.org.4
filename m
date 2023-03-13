Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCBE6B7B27
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjCMOz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjCMOzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:55:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09111ABDF;
        Mon, 13 Mar 2023 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678719288; x=1710255288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VHgufCU7d7T9872t0WWY7vfgk9G56mV5UC3HCpqOxu8=;
  b=lrI5soqx9R1kH8c7dxH2gVjej26kMQLOtV6zXdP2ai7uzXp8alcBi4i4
   2U0CyX6wg1VG6lp6+l9VckiHCAcuO5Tai3W6Lc1LPTKWwftHQlQ40kI/j
   k0Wv+qJ/BRGhS4+8gdHLHKV0ijQYP9HtdEnxbO/NiHA1u8tyezRwlj5Oa
   j5UJPfrCyeboEXyKR1dBqfxwZwcJy6Hym7kJUidduLeIxwZJwQA5yBcfK
   i6aDO7BxFql/MC/qL0a5mCAaYg50Cu2dBHsU+6CbN4l34g0BDmrEA6LMY
   ASck1uFU6jcV7ssWG79ua99JTQ4Q5zKIMr+aB1KveFlVpszhv9kD72asr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325526218"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="325526218"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 07:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708902823"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708902823"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 07:54:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 07:54:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 07:54:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 07:54:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 07:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h26W5dktQ+WCMbrw5U84nPV1riNpDQj8/LbTXCHKW97Glwb07UXOtBOoOFB1mAU4VL4xQ0vQyoPWD5E/KjFwvOgHp5xu6nCaKz5OfB0KMcWGOxuUx5LZ2UUERVvTCczQYNZPM3RfZFES6cpJKaYYrYJJsxCYmNhY5UU98BjcT2A13E6EQtTPXENNl+09qypBz7uwcK27IaM9NJZEeQOp01RxZ8g35zjZPnj6PuF7GTr8Q/RBWveODSm1J5iHaxVernYmKcfiKD8iCo2Ze94nPijumqEI+F1K/DedWVXk9dJiDDUeFYFwxdetJRfQOrHbVxoKSj10KLioomQ+TEV+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHgufCU7d7T9872t0WWY7vfgk9G56mV5UC3HCpqOxu8=;
 b=GhBWbn9dLlNz3qZ0oupfvpzEbUulx7EAbgSQ/ooKs8k+ZNXTJVWlksOR6gVBISkduItOtTMWIiXi7K3DGl6oDHSwujlrx6SgPn2J+Zl7+7/DYypmU+XbrIDyPeHCQDJO1gn8t7UbPlNJ04UU8kqmtMMkWvykScZg6bOUwQByWWJwsV61AUPLZ7iG8u8Cihn/dKiCvPvuIBDOFOBMRsTyFK71pVgzpzyEhBuP0Nb9ohBKxOQIx0JzURDV8s8oeoZzoLJ5xxB2rmAU3074vKVVFCx4ySQVGNSwx7wP1Z/n9NrCI1YRfnp+OJ/N8SW2qftSpfgr8cWhyRmQ/OhE2dM7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 14:54:28 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 14:54:28 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] ACPI: processor: Reorder
 acpi_processor_driver_init()
Thread-Topic: [PATCH v1 1/4] ACPI: processor: Reorder
 acpi_processor_driver_init()
Thread-Index: AQHZTgXV++ts3wGoK0aUxKpjfYeUSq73XdiAgAFrEYCAABJzgA==
Date:   Mon, 13 Mar 2023 14:54:28 +0000
Message-ID: <ff9d343113b184f08877952608d3424d87687a42.camel@intel.com>
References: <2148907.irdbgypaU6@kreacher> <2885079.e9J7NaK4W3@kreacher>
         <49cefdcb5d50c1920b9c9533d30e886e368f3fe7.camel@intel.com>
         <CAJZ5v0hm3S_3eOsVm5vTUX23ynPXhY469ctZUpLdHZFt+b2KHA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hm3S_3eOsVm5vTUX23ynPXhY469ctZUpLdHZFt+b2KHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB7498:EE_
x-ms-office365-filtering-correlation-id: 32bea309-df0e-46cb-b45c-08db23d2d86c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oyuuzCk2W2SsELnm8EvyK6BaEyd/1gJpJCyFjH+a+P0wSD/EJGx5Im0VMMsKpmCKBk84DQ/pM/efCXSoN/7FN7L0RIKSUNDFhRdwlatmO8VsjPCdiv2gOv5nBsYAJXamYLDrdMzsPjmNgeV13di2jl/s1ulmeYsFisrD/M7VH4FqPk1PIOGghOx0u2rCWn/7Z6plOREZRxysQ5EbHbFDrmFxoBeBI5rrOZRvUF5wFmRDSFJfNJdI+Fe/G7OuXf6bIr0SSK90mppoUakGoLqxitYBAdNq3E/t+SyCQGbtv2N9GjrrJK917QBiabh0+RyKrntEm9uqs5AObssCx75mQ/CPf6wzC263I7GX1lwv6/3vW9WyAq8Zr9vuLqipMmdyWlpS/83ZRtjh3GDhElOKkl0TSbXQ9+2APWOUmFW07h6D3z7aTPYxrSUAnLCZM5Igz5O5MbjzFRZj45wo4uMlH6pVDX7J/enq1nS8eevDgwNiUaqXSOnSk4bom2i30KPs7xu1RwANd3BxPlxekhoxyM7QIA1LpqGWhHD9HmeYGTslaNLhO6l3vVi2ydvv8X1rhAAtxkBJBjqgkaRlx1Ll7LB5y4YDapd1X8QbNey4TD5icYc+ATeFTmTfNyy+sxhSyYl6+hK9efebwjLSzDCwhaOmMrSAsj2IuJ8rMMjxlsWLYk0XUCfp2i+k2EioMQ6oMzAqFZ6UTpdRbkOAB3Zpe3O+JvEE6n7Xj45+v0w9utU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(5660300002)(36756003)(83380400001)(478600001)(26005)(53546011)(6512007)(6506007)(6486002)(2616005)(966005)(71200400001)(38070700005)(91956017)(4326008)(186003)(66946007)(8676002)(64756008)(66476007)(76116006)(6916009)(66446008)(8936002)(41300700001)(86362001)(66556008)(54906003)(316002)(38100700002)(82960400001)(122000001)(84970400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWZOeGlSTkh2cUlnQ0lJa0lMY2RwWm9nYXk1K1h1OW5YMFoveGlGN2hqUFR4?=
 =?utf-8?B?cmFiWjBNRS8zeWVRSFJ2azZHZkZDbG13UmwySDA3K0lhc3RISzVTSFhGY3pj?=
 =?utf-8?B?aWNxZnBFSXBzQTFCQzNWUkFkNVpNVUlmK2FPT0RnUEFzWlFlMW9rTWpTSEJQ?=
 =?utf-8?B?dXo3aU1heTJWeUdHUlpTOFo5ODdBbFE0dlFZdFFha2JGQ1NtR2tqVFFVMW15?=
 =?utf-8?B?WmtuNDcyNmhVRmpCL2hXQXAwWVZpRDArTkNPR0hCeGdORHVFWE9GYUVOOW12?=
 =?utf-8?B?QW5GMU9aZEFFYThYZkJGMVFhOUZqTXRsOFpXSHZIeGZ1bGNLOHRFSVRqamt3?=
 =?utf-8?B?cGFsNzJJS1RBeDdHN0RTVVdpalpCaW5TVWFvR1FoTlVkNi8rUzkxVE0relJr?=
 =?utf-8?B?c2NLUjRHUVBlSDdha2pUd29PaTVYYloyWEhyY1dySWgwaFNoaXpXRVhhbmti?=
 =?utf-8?B?NEM4NFlGWThBUS91QnlNK3p6YmgxUmpMazAzUVJWUHN6cVg4M216N2dWNEgr?=
 =?utf-8?B?c0Y3Zzk5dXRPYi9FZnNqYnFyNThFZ1FmQ095RFd6RlpQWUdmMHJmWDRFeVJQ?=
 =?utf-8?B?dVJmWXRSbHRwU1A4dytJcG5telNoN0dwdTBFN3F3U3ZTNkRpb1hBdWtOaU03?=
 =?utf-8?B?SnJ3RFlVVEhEdHhQOFAxTU9PTW9xUWV2S3pRYXJOdVVhdEdDL1hXd3FoN0ZS?=
 =?utf-8?B?cFFNMW5XWFB1VXpxdWQ3cGZJSG10aHphb25QaGh0a3lEQTE2WEkwa0cyZ1d1?=
 =?utf-8?B?QWcwbUF5NUVNUGdTV295RTlnb1NBOStKNXJpTDJ4WUR3VGZoMHN1UW5MQ1dm?=
 =?utf-8?B?dkxRQmtsUU1EUjd0Z2F1R1dWMFdGZU9sSDRBOXFyMG9QYzVDWEIyU2ZCWU9a?=
 =?utf-8?B?ZlZicm1DRDU2Q2RGMjJtRUJaRVkzNVBSSm5OSnRMMUk4aHF5aThTdDlVNVpa?=
 =?utf-8?B?ZCtHMjZRWUs5c0czcnR1WVM3dmJFZjRFcHJqS0VHWEhMRzVXc2hobHYxekI5?=
 =?utf-8?B?WVRabC8rZWl2aXFwbDZ6SFpFa0Y5Wk0zMmVIL3VkaUhBN1kyeEVLRjZySHUw?=
 =?utf-8?B?WUdxNmVwSHFxQkNWVHlWd2dFQ2dnVVFQcVRmRStZRG43QjV2Y0xzSEp6ejZT?=
 =?utf-8?B?eDhaRkUyZEpnV2NSeG43VW5vSnE1SjBhQnM4VFZ3QU5BR2dhSFZNSUphd2pt?=
 =?utf-8?B?M1YyNEkyUlZ3c0RiVUQ4K3dTYUQ3WmlEaHZhU0hhNmJlS3JPRHEwMU1IZTdD?=
 =?utf-8?B?Wldvc01rYmR3MDdaeU4wR0JIcXFNaXRFZDRkTGlQdFdyaTYxSDA4bzJmS09l?=
 =?utf-8?B?dTJmdkVSVUx4aFRRUkxKUFM4di9TbmlOeEhJbTRYT0cyRm94WmpDQW4rVEt4?=
 =?utf-8?B?LzNpTS8xeXdXUFBRdFFHbnoxZEYvaVVJdWl6Q1NkaWdsamFnSWloTmtyY1dm?=
 =?utf-8?B?MlBIZUE3U1kycEpWMENUb0dSNXZNMC9uYWN3VVNhYkZGaVgxQXBod2lPMjI5?=
 =?utf-8?B?Y3BLQ3hIT3RVZUtMMmRyMnlqbWhreWltU2d4cHhITWh5cEoxQUNXSVE1R1gv?=
 =?utf-8?B?Q012UVJCV2hjQjhOT3A4eFk2WXhxUlpyaG5pNGh0a1lWM1JBQTNicnVlUkRZ?=
 =?utf-8?B?bGJuSjh6bkxreUZFOXNEcEFMNm1yNU4vSWttWGFVUWR6dkYra1BDR29nSjVY?=
 =?utf-8?B?QVNrVWJpYjBjeEg2eW94bVlSK1lZK09hRENOS3libE5CVGhtZDkyR3duNklL?=
 =?utf-8?B?RUNUZmhRdzQzTmpQZWljOHVhQjVxWktBd1BUanVFVmVWL0JtSi8wTkZMNUNC?=
 =?utf-8?B?Z2tUMUhmMWFCV205c0NvVTRyNzR6SUN4RExCTXZ4eHYxSGVRaDBTaGxOdlBu?=
 =?utf-8?B?cW56ZFdFK0xmVDdJc3NvSDVaUWZsNDJneG55VUxDbi9COEI3c01Uelc5Y0hR?=
 =?utf-8?B?dzVVekJVVUcxcDFWbFY4bjNlSnVLeFNlUEJYM0pEaUxTcE9XYUhFWEJEc1BQ?=
 =?utf-8?B?Wnd3bm9vdXpOcWszdlByRUQzREh5WjJDZTZLTFpUV2VHOXkwU3BZdVc4eWQr?=
 =?utf-8?B?T2pGRFgwRm5DT2h2K3VqUGJVUEZJV2VtclVFVkxNanB6V250SElKK0dsaU9V?=
 =?utf-8?B?aUxzcDNYL3FPakwzYjM4aG9DZUwvVWpLbnY4R1MzbzZzZFZhSFJHbnlGSzFV?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D70CEC10C81C274A943E66A300BB596F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bea309-df0e-46cb-b45c-08db23d2d86c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 14:54:28.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0dgJEVvWKAwgP2ARS2gM269YOQeQktAUT7VnzHOZwOg5Sm9fRywnHDGAbdddTqL6WZr6YkkN88CMsohRqXaWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
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

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE0OjQ4ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gU3VuLCBNYXIgMTIsIDIwMjMgYXQgNTowOeKAr1BNIFpoYW5nLCBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMy0wMy0wMyBhdCAyMDox
OSArMDEwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBGcm9tOiBSYWZhZWwgSi4g
V3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+ID4gPiANCj4gPiA+IFRoZSBj
cHVmcmVxIHBvbGljeSBub3RpZmllciBpbiB0aGUgQUNQSSBwcm9jZXNzb3IgZHJpdmVyIG1heSBh
cw0KPiA+ID4gd2VsbCBiZSByZWdpc3RlcmVkIGJlZm9yZSB0aGUgZHJpdmVyIGl0c2VsZiwgd2hp
Y2ggY2F1c2VzDQo+ID4gPiBhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgdG8gYmUgdHJ1ZSAo
dW5sZXNzIHRoZSBub3RpZmllcg0KPiA+ID4gcmVnaXN0cmF0aW9uIGZhaWxzLCB3aGljaCBpcyB1
bmxpa2VseSBhdCB0aGF0IHBvaW50KSB3aGVuIHRoZQ0KPiA+ID4gQUNQSSBDUFUgdGhlcm1hbCBj
b29saW5nIGRldmljZXMgYXJlIHJlZ2lzdGVyZWQsIHNvIHRoZQ0KPiA+ID4gcHJvY2Vzc29yX2dl
dF9tYXhfc3RhdGUoKSByZXN1bHQgZG9lcyBub3QgY2hhbmdlIHdoaWxlDQo+ID4gPiBhY3BpX3By
b2Nlc3Nvcl9kcml2ZXJfaW5pdCgpIGlzIHJ1bm5pbmcuDQo+ID4gPiANCj4gPiA+IENoYW5nZSB0
aGUgb3JkZXJpbmcgaW4gYWNwaV9wcm9jZXNzb3JfZHJpdmVyX2luaXQoKSBhY2NvcmRpbmdseQ0K
PiA+ID4gdG8gcHJldmVudCB0aGUgbWF4X3N0YXRlIHZhbHVlIGZyb20gcmVtYWluaW5nIDAgcGVy
bWFuZW50bHkgZm9yDQo+ID4gPiBhbGwNCj4gPiA+IEFDUEkgQ1BVIGNvb2xpbmcgZGV2aWNlcy4N
Cj4gPiA+IA0KPiA+ID4gRml4ZXM6IGEzNjUxMDVjNjg1YygidGhlcm1hbDogc3lzZnM6IFJldXNl
IGNkZXYtPm1heF9zdGF0ZSIpDQo+ID4gPiBSZXBvcnRlZC1ieTogV2FuZywgUXVhbnhpYW4gPHF1
YW54aWFuLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gTGluazoNCj4gPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXBtLzUzZWMxZjA2ZjYxYzk4NDEwMDg2ODkyNmYyODI2NDdlNTdlY2Zi
MmQuY2FtZWxAaW50ZWwuY29tLw0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KPiA+IA0KPiA+IFRoZSBmdWxsIHBhdGNo
IHNlcmllcyBmaXhlcyB0aGUgcHJvYmxlbSBidXQgdGhpcyBvbmUgZG9lcyBub3QuDQo+IA0KPiBU
aGF0IGlzIGEgY29ycmVjdCBvYnNlcnZhdGlvbiwgYnV0IHRoZSAkc3ViamVjdCBwYXRjaCBmaXhl
cyBwYXJ0IG9mDQo+IHRoZSBwcm9ibGVtICh3aGljaCBpcyBub3QgYWRkcmVzc2VkIGJ5IHRoZSBy
ZXN0IG9mIHRoZSBzZXJpZXMgQUZBSUNTKQ0KPiBhbmQgc28gaXQgZGVzZXJ2ZXMgYSBGaXhlcyB0
YWcgb2YgaXRzIG93biBJTU8uDQoNCkFtIEkgdW5kZXJzdGFuZGluZyB0aGlzIGNvcnJlY3RseSB0
aGF0IHRoaXMgcGF0Y2ggaGVscHMgaW4gYmVsb3cgY2FzZT8NCg0KY3B1ZnJlcSBkcml2ZXIgbGlr
ZSBpbnRlbF9wc3RhdGUgaXMgcmVnaXN0ZXJlZCBiZWZvcmUgd2UgcmVnaXN0ZXIgdGhlDQpub3Rp
ZmllciBjYWxsYmFjayBpbiBwcm9jZXNzb3JfZHJpdmVyLiBJbiB0aGlzIGNhc2UsIHdlIGFyZSBu
b3QgYWJsZSB0bw0KY2F0Y2ggdGhlIENQVUZSRVFfQ1JFQVRFX1BPTElDWSBub3RpZmljYXRpb24g
YW5kIGNwdWZyZXEgc2hvdWxkIGJlDQpjb3VudGVkIGFzIHBhcnQgb2YgY29vbGluZyBzdGF0ZXMg
d2hlbiByZWdpc3RlcmluZyB0aGUgQUNQSSBDUFUgY29vbGluZw0KZGV2aWNlLiAoYWNwaV9wcm9j
ZXNzb3JfY3B1ZnJlcV9pbml0IG11c3QgYmUgc2V0IGF0IHRoaXMgdGltZSkNCg0KT3IgZWxzZSwg
aW4gbm9ybWFsIGNhc2UsIHRoZSBBQ1BJIENQVSBjZGV2LT5tYXhfc3RhdGUgYWx3YXlzIHJldHVy
biAwDQood2hlbiB0LXN0YXRlIG5vdCBhdmFpbGFibGUpIHVudGlsIHdlIHJlY2VpdmUgdGhlIENQ
VUZSRVFfQ1JFQVRFX1BPTElDWQ0Kbm90aWZpY2F0aW9uIGFuZCBjYWxsIHRoZXJtYWxfY29vbGlu
Z19kZXZpY2VfdXBkYXRlKCksIGJvdGggd2l0aCBhbmQNCndpdGhvdXQgdGhpcyBwYXRjaC4NCg0K
UGF0Y2ggMiwzLDQgd29ya3Mgb24gbXkgdGVzdCBwbGF0Zm9ybSwgd2l0aG91dCBhcHBseWluZyBw
YXRjaCAxLzQuDQoNCnRoYW5rcywNCnJ1aQ0KDQo+IA0KPiBJIGd1ZXNzIEkgc2hvdWxkIGNsYXJp
ZnkgdGhhdCBpbiB0aGUgY2hhbmdlbG9nLg0KPiANCj4gPiBUaGlzIGlzIGJlY2F1c2UsDQo+ID4g
DQo+ID4gc3RhdGljIGludCBjcHVfaGFzX2NwdWZyZXEodW5zaWduZWQgaW50IGNwdSkNCj4gPiB7
DQo+ID4gICAgICAgICBzdHJ1Y3QNCj4gPiBjcHVmcmVxX3BvbGljeSAqcG9saWN5Ow0KPiA+IA0K
PiA+ICAgICAgICAgaWYgKCFhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQpDQo+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+IA0KPiA+ICAgICAgICAgcG9saWN5ID0gY3B1ZnJlcV9j
cHVfZ2V0KGNwdSk7DQo+ID4gICAgICAgICBpZiAocG9saWN5KSB7DQo+ID4gICAgICAgICAgICAg
ICAgIGNwdWZyZXFfY3B1X3B1dChwb2xpY3kpOw0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4g
MTsNCj4gPiAgICAgICAgIH0NCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+IH0NCj4gPiANCj4g
PiBBbHRob3VnaCBhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgaXMgc2V0IHRvIHRydWUgd2l0
aCBwYXRjaCAxLzQsDQo+ID4gYnV0DQo+ID4gd2UgZG9uJ3QgaGF2ZSBjcHVmcmVxIGRyaXZlciBy
ZWdpc3RlcmVkLCB0aHVzIGNwdWZyZXFfY3B1X2dldCgpDQo+ID4gcmV0dXJuDQo+ID4gTlVMTC4N
Cj4gPiBzbyBhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgaXMgbm90IHRoZSBvbmx5IGRlcGVu
ZGVuY3kgaGVyZS4gOigNCj4gDQo+IFJpZ2h0LiAgVGhhdCdzIHdoeSB0aGUgb3RoZXIgcGF0Y2hl
cyBpbiB0aGUgc2VyaWVzIGFyZSBuZWVkZWQgdG9vLg0KPiANCj4gPiA+IC0tLQ0KPiA+ID4gIGRy
aXZlcnMvYWNwaS9wcm9jZXNzb3JfZHJpdmVyLmMgfCAgIDEyICsrKysrKy0tLS0tLQ0KPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gPiAN
Cj4gPiA+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2RyaXZlci5jDQo+
ID4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KPiA+ID4gPT0NCj4gPiA+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMv
YWNwaS9wcm9jZXNzb3JfZHJpdmVyLmMNCj4gPiA+ICsrKyBsaW51eC1wbS9kcml2ZXJzL2FjcGkv
cHJvY2Vzc29yX2RyaXZlci5jDQo+ID4gPiBAQCAtMjYzLDYgKzI2MywxMiBAQCBzdGF0aWMgaW50
IF9faW5pdCBhY3BpX3Byb2Nlc3Nvcl9kcml2ZXJfDQo+ID4gPiAgICAgICBpZiAoYWNwaV9kaXNh
YmxlZCkNCj4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiANCj4gPiA+ICsgICAg
IGlmDQo+ID4gPiAoIWNwdWZyZXFfcmVnaXN0ZXJfbm90aWZpZXIoJmFjcGlfcHJvY2Vzc29yX25v
dGlmaWVyX2Jsb2NrLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IENQVUZSRVFfUE9MSUNZX05PVElGSUVSKSkgew0KPiA+ID4gKyAgICAgICAgICAgICBhY3BpX3By
b2Nlc3Nvcl9jcHVmcmVxX2luaXQgPSB0cnVlOw0KPiA+ID4gKyAgICAgICAgICAgICBhY3BpX3By
b2Nlc3Nvcl9pZ25vcmVfcHBjX2luaXQoKTsNCj4gPiA+ICsgICAgIH0NCj4gPiA+ICsNCj4gPiA+
ICAgICAgIHJlc3VsdCA9IGRyaXZlcl9yZWdpc3RlcigmYWNwaV9wcm9jZXNzb3JfZHJpdmVyKTsN
Cj4gPiA+ICAgICAgIGlmIChyZXN1bHQgPCAwKQ0KPiA+ID4gICAgICAgICAgICAgICByZXR1cm4g
cmVzdWx0Ow0KPiA+ID4gQEAgLTI3NiwxMiArMjgyLDYgQEAgc3RhdGljIGludCBfX2luaXQgYWNw
aV9wcm9jZXNzb3JfZHJpdmVyXw0KPiA+ID4gICAgICAgY3B1aHBfc2V0dXBfc3RhdGVfbm9jYWxs
cyhDUFVIUF9BQ1BJX0NQVURSVl9ERUFELA0KPiA+ID4gImFjcGkvY3B1LQ0KPiA+ID4gZHJ2OmRl
YWQiLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBhY3BpX3Nv
ZnRfY3B1X2RlYWQpOw0KPiA+ID4gDQo+ID4gPiAtICAgICBpZg0KPiA+ID4gKCFjcHVmcmVxX3Jl
Z2lzdGVyX25vdGlmaWVyKCZhY3BpX3Byb2Nlc3Nvcl9ub3RpZmllcl9ibG9jaywNCj4gPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFVGUkVRX1BPTElDWV9OT1RJRklF
UikpIHsNCj4gPiA+IC0gICAgICAgICAgICAgYWNwaV9wcm9jZXNzb3JfY3B1ZnJlcV9pbml0ID0g
dHJ1ZTsNCj4gPiA+IC0gICAgICAgICAgICAgYWNwaV9wcm9jZXNzb3JfaWdub3JlX3BwY19pbml0
KCk7DQo+ID4gPiAtICAgICB9DQo+ID4gPiAtDQo+ID4gPiAgICAgICBhY3BpX3Byb2Nlc3Nvcl90
aHJvdHRsaW5nX2luaXQoKTsNCj4gPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ID4gIGVycjoNCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiANCg==
