Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418EB720893
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjFBRsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjFBRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:48:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353D01BC;
        Fri,  2 Jun 2023 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685728122; x=1717264122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8jN85xQxC0QKPVZtzrtdKCMQt/woJHVlZN8Du2+Y9D8=;
  b=Dk2TKz+bnejuMWzAOimIXf2ZAE6MHo0OqIzHQEPtVE6Xqj6vMDhLZG8S
   00X0ycaEv7adh/z7R/dHV8SjG+LdqPaAxLr6T1Jcrz8wg2lQSqHec4MxF
   /4nO2HV7Ap2sz93DtxEJJmf4Pa4/S/wu93D56doqWSpWBqs3/AFtjfAoJ
   XQ8sYsPATj7Sa7Jdgf+Z3TXOVCAovScFefPzmOGHxMMhItXsx820/qy0f
   v2bX1vVXyzmwMWaUUHHsxk6myZfjOmcKZ/VOLpYWuKRFzexaBt28aRNxU
   B2zpoAKkLbXNnUUDmnb0kEsptv99L108VAT52FKVjM9CPbgJ0SiBbTb0p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="336290622"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="336290622"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 10:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="702031672"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="702031672"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 02 Jun 2023 10:48:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 10:48:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 10:48:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 10:48:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 10:48:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R32YZtT/JvBzRBLnWxRCSn2cWkIuFjA7s95gl/ct0vQDrt8j3KydPxesIaZ6hGhzKrqRNbd8+dOQFfHU5AxvQJLVUgLaO0zWfV9Wc6Mriib5SRf0NJ42vJFO/bexjdrUZ46K1NZQOkKAVO7brHLYFoL6J9DloY/18UsIOK4dRgd1b9Xcwt8LS2DJltC0uElbtVfSbWtvk6m1jUiiKBHbKCJzfSOBkEN7PsbpJ/AHfrWBg+jnTCh308jPVqdaexaE2mcB9pFxn2/caa4Z6VARNdL1ZD5jUORewD/KJS0pmJC91v1bqtDVweHtmqbhtZiHdnd6NR+UZsWDVvstB/dvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jN85xQxC0QKPVZtzrtdKCMQt/woJHVlZN8Du2+Y9D8=;
 b=M5zKDDs87jSUEWupWrQp+CWVzNysgBeROqS4yHgrBiLdBg5jd66Qn2j5taZ4mmGFKoke1Et4Hpf2bXxSs3lZ4mx9qFkRiaylrWq7U6alhmF74I+Ingeln/Xd7BPLr5Rm8Zc9HbGpPC1gUqNVZBjUKYIbdI1HtRMCSRjkZvxMENQBO8u3y7lceEok39QPnGu2O+RcvHhrrWUamr4QHXAl2C9c6cLLqNWLyiLbOR2NiRLKjzVv41c9QLSPssrJ2OTF8BaL+gndfkzHx0uZZQ7KA/NgoZmxe8j6kCWff74vD5bRSl93ym+vsNt5tqEHWbZ4SZdR9MIYK54NmWv+fju7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17)
 by MN0PR11MB6254.namprd11.prod.outlook.com (2603:10b6:208:3c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 17:48:38 +0000
Received: from SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::9787:88d6:b7e9:50cb]) by SA1PR11MB7109.namprd11.prod.outlook.com
 ([fe80::9787:88d6:b7e9:50cb%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 17:48:38 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 0/4] cxl: Add a firmware update mechanism and cxl_test
 emulation
Thread-Topic: [PATCH 0/4] cxl: Add a firmware update mechanism and cxl_test
 emulation
Thread-Index: AQHZdMfiD6gDV4GhoUa4U5p+L8B5Dq86ve+AgD1NagA=
Date:   Fri, 2 Jun 2023 17:48:37 +0000
Message-ID: <e01185b1a4c07bc5fc0548db26fee124ddcc2536.camel@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
         <y4cqp7r3tt74igqwtcbwshcca66krcjpiopo6frilx272x6ot7@ji2shc7sqk27>
In-Reply-To: <y4cqp7r3tt74igqwtcbwshcca66krcjpiopo6frilx272x6ot7@ji2shc7sqk27>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7109:EE_|MN0PR11MB6254:EE_
x-ms-office365-filtering-correlation-id: 8fa14db7-0157-45a6-505f-08db63919859
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F4IXhln/J/Bas1/3pfrj4CEg5IZeoFJXH6MVbm336q9WDFiGNVGBx1Z1zU4gaazr6QETC3BOujEyae11hYodfrD1BNvYBgY+AXU82Rfv9HdF3O5c9Lro6BlpgHjw9y+d+HPkGdn76YS7fzZrhMLCaZpWTcK4eKGtIKDJrKjAf8/l6oIXfgCuLojwKNRTO9qeMMkCaTRVDSZ9M0T37I3+V2XI6LUoscVlobrsl4tFbPJmXRoT+8ZG+FWuRONxzjz9ZVQYHP0Yt8g9kq5F9X5yagbxidJjLz7vi7StBYPdi7DwVzCeUlXxHSqRYFDll0ifCX7mJFVwFozv3SAnJdlTnNrRSJIMjSZANDkyS2zc827NyJmpP1GJadzERh7s/qAPx3WCUzOVYj4fsPyRW9HT9M2Ec+MOSQKqHADVDjewwmbU9Ev04CfoDHKGxo135OfyYTndyp5U7DKEXY0u0rBlvSaS6n96yrOy/Ory30tqzb73XrigA72wKjqpOJFd6AUR5my/yPnvI3SnXHqOyPgjtUgGvT0HEPIpEhUa7GQrI/I8NtkiVY480h75egcqsVTUlHsrGimaBdh9Hm1vTwuYcOQBErsJ3X4p9lpkX8pZ7px7jFlV5DnOezO09Vir5bMb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(83380400001)(82960400001)(66556008)(6916009)(66476007)(64756008)(66446008)(6486002)(91956017)(76116006)(6506007)(26005)(71200400001)(107886003)(15650500001)(478600001)(2616005)(54906003)(86362001)(186003)(2906002)(5660300002)(8936002)(6512007)(8676002)(36756003)(66946007)(38100700002)(41300700001)(4326008)(122000001)(38070700005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkhDVHdUSXZ6elJsLzRmd0l0cC9VSmdJS0g2RzQrbmpEL05ldHlOY1Ard2ph?=
 =?utf-8?B?UDNWakdSek05dUxva09wQzdzc0I4VE44bEdXV1RDcVhBOS9tNHY0c0N3S1Na?=
 =?utf-8?B?bzZrSUMwVEErK0VGNjBGZmFDdDkzUHY2ODlmanowMnF5dDhKUEdxd1A5bmFC?=
 =?utf-8?B?b2NsdlRRUjdFek84TXNqWlhQY0J4U0lQYTVtRVB1bXZTMFJZTS82bTRVUHhN?=
 =?utf-8?B?QSs1eVVsOU5pWTVKNXY2RGxsd0lkYjRCSWxRNmhVeHUvb1B6VGdjYUUwK0kw?=
 =?utf-8?B?dnlpdHNoRXoySFRxeDBmdDB2enlEOXE1WllUZHF6eFBqeGcycEE2TmpRUE1W?=
 =?utf-8?B?U2JxclpDVmthNGpvd1Vya3Fnc1Vvd1ZQRUYyb3VlaXFOVkFOaXRtd3RvRG9v?=
 =?utf-8?B?SHN2V20vTmc0OWJYT3lucWpzMkIvNFptaS9LMmNXeDkzTGhWbVRLM0xlYzVh?=
 =?utf-8?B?REhYT1ZJRzNIVWhjZFdHODVvL0NzU3NWVVVrUUV6WWZLaU55VzhkSndYa2pU?=
 =?utf-8?B?TCtRVS9lRVI5QVZabTBGVjg1Y2xQcm9oZGN0bVNOdGpoY3R2dDFyRWYzRm0y?=
 =?utf-8?B?SkpjVSt0alBmVjVMaWdVcFdHTDVGNDJCemdpTTVaVHE0NU51UVk0Q0E5bDdN?=
 =?utf-8?B?WTFrUlpka0NvTnUxUEdNNXZTVzhxYUt0c0VRbTI2eTJsUEFQZEJGRVpIeXlY?=
 =?utf-8?B?Z25GMjNVY3I3ZTBkdytjajI2eTNlaEpKNTV1dEw4RENJY3BXdVJxRk5XeElu?=
 =?utf-8?B?OGY3amk2N1Y0RUtBV29TQ2t1ZGYzb01YV0pIOTRHQkNCTVZYVXlWaTFVY1Jq?=
 =?utf-8?B?WE1pRkh1RWRhUXZUd0RpVWhpSE5qS1RoQm80YjBobGcrWW9ISDdyZTZ5WEZj?=
 =?utf-8?B?U2NOU3YzQUx6TjNRTG9abWdVVnhLbC9hZENmT1FtMGg0TXFvNSs1cU5hYWVO?=
 =?utf-8?B?c1RzR3REZmQwQXJjU0JVTFNuTElxVFc1akRzQk5oaTk2UFhzNkpULzJNT0Fr?=
 =?utf-8?B?b0Fjb0tvNkIxTzU5Y1FISmg0TVJUVnRLWHI1ZGpIakRkc1d3dWxFUzN0bTVP?=
 =?utf-8?B?STR4ajVEeXRWT3p2T3JzekNNOU4zaEhjSUZOUGRGWmljaWgyeFVSNXZBcjU0?=
 =?utf-8?B?UVdjT0ZDREI5UUFKTkZ2ZjRvOFMvakZOQjJ3aGRvRUxwK0tNL3RkcGpDcXVU?=
 =?utf-8?B?L2NjbDdRN1N1RmpTOVNXM05Mb0FnbmM4Y2o5NS8yM0tFTXhsSkRPWlhNN0ov?=
 =?utf-8?B?NlBmN0xIOVljVmpVdFZBVllJeHFpQVdGTnR2bkNwa29BMmJnZ3o2MkhUWjhp?=
 =?utf-8?B?TGNvYUNZOURFMElnMjJ5Vndud3phNWVMbzh3Rk4vOW92RjdTUGZzTHJkNkpa?=
 =?utf-8?B?SlJIdGlNNXZjb1JEd09SdkNEeGphL0VEalNxTUVVUWpyTTk0aDUraGNkWkNw?=
 =?utf-8?B?SnFxNHc4dnFJUEFUVXpHTTlQMUVKRFM2aUgwNUhKeU5ITmcrVnJCOTN4MW9K?=
 =?utf-8?B?MjBqem5OcHB6Z0MxUXo3R1pKZnYyekVHbnVBWnEzcVpTMVZIRUpiWElhTkFt?=
 =?utf-8?B?blowTnlBK3hDbnk4THlzYkNsRkk0UXRNdWw0QVZ0R3JydU80MXZtcjBEdzhl?=
 =?utf-8?B?WUlRR1MwSjJ0dVhqTTUrTm90ZHNRYll0blBPelJKY0Zqdk1ZY2FlNjNkNE9z?=
 =?utf-8?B?YzFIUVVVNG9CMTFPZUhOS3NrRjFCU1FkYS9CbzJlcGlaSzhOdFhwYk1ybnIx?=
 =?utf-8?B?UUVWQ1JCNWROanM4aXRDdWZTUFBiMGpsTU1WRzh3UHdMOFdDRlZId0VuVk1I?=
 =?utf-8?B?OWJZS1RwT29VVERPN21FK3plbXZYMG1UWXpPWUVmRUIwMUkvYlZIZDVqTk9a?=
 =?utf-8?B?TFRjdnNZWHpVbkhRZUR1aTB2Q29ZakNEc2toYmNXcnFlbXRCemZkeEVXclVm?=
 =?utf-8?B?NGNQbFJuQXVrbXhSbXFTSGxtRk8ybkhJNlBHVTk2cXVZWUVNRmlaM0VSM3F6?=
 =?utf-8?B?R0pwUjdLckM5RCtaV1l3L2lKQlZ3eDNyVDBiNFJCNzdyelIxU3N2eVdRMlYw?=
 =?utf-8?B?QU9aMTB5ZERZaXZnZGFTOWdzTmhKV0lDVG83SFlpdnhZeXphMG4yTWt6bWdq?=
 =?utf-8?B?cTNpSlpDSXRhRlhGTUZjQVFIa2l1TTRBaGNHMlV6TU1BekZhNDZVS09xTW00?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D840AA35E1C995489F0CB05063DA60AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa14db7-0157-45a6-505f-08db63919859
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 17:48:38.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTD/8+rAVSSfXJuzDnLMyv19ctEkiJ83ZU55a7wRDS/EQxGNYy5GFd/YOveJXEm7iqhCtVcg9LVC2xulSmlwXpHkQbI/a7bKfGsOb7+VKK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTI0IGF0IDEwOjM5IC0wNzAwLCBEYXZpZGxvaHIgQnVlc28gd3JvdGU6
DQo+IE9uIEZyaSwgMjEgQXByIDIwMjMsIFZpc2hhbCBWZXJtYSB3cm90ZToNCj4gDQo+ID4gVGhl
IHBvbGwgaW50ZXJ2YWwgZm9yIHRoZSBUcmFuc2ZlciBGVyBjb21tYW5kIGlzIGFyYml0cmFyaWx5
IHNldCBhdCAxDQo+ID4gc2Vjb25kLCBhbmQgYSBwb2xsIGNvdW50IG9mIDMwMCwgZ2l2aW5nIHVz
IGEgdG90YWwgd2FpdCB0aW1lIG9mIGZpdmUNCj4gPiBtaW51dGVzIGJlZm9yZSB3aGljaCBlYWNo
IHNsaWNlIG9mIHRoZSB0cmFuc2ZlciB0aW1lcyBvdXQuIFRoaXMgc2VlbXMNCj4gPiBsaWtlIGEg
Z29vZCBtaXggb2YgcmVzcG9uc2l2ZW5lc3MgYW5kIGEgdG90YWwgd2FpdCAtIHRoZSBzcGVjIGRv
ZXNuJ3QNCj4gPiBoYXZlIGFueSBndWlkYW5jZSBvbiBhbnkgdXBwZXIgb3IgbG93ZXIgYm91bmRz
IGZvciB0aGlzLiBUaGlzIGxpa2VseQ0KPiA+IGRvZXMgbm90IG5lZWQgdG8gYmUgdXNlci1jb25m
aWd1cmFibGUsIHNvIGZvciBub3cgaXQgaXMganVzdCBoYXJkLWNvZGVkDQo+ID4gaW4gdGhlIGRy
aXZlci4NCj4gDQo+IE5vdGhpbmcgYWdhaW5zdCB0aGlzLCBqdXN0IHRoaW5raW5nIHRoYXQgaW4g
Z2VuZXJhbCwgYnV0IHdlIHNob3VsZA0KPiBwcm9iYWJseSBsaW1pdCB0aGUgcG9sbCBpbnRlcnZh
bCB0byBDWExfTUFJTEJPWF9USU1FT1VUX01TLiBJJ20gbm90DQo+IHN1cmUsIGhvd2V2ZXIsIHdo
YXQgd291bGQgYmUgYSBwcm9wZXIgdmFsdWUgYWNyb3NzIGFsbCBjb21tYW5kcy4gT3INCj4gd291
bGQgaGF2aW5nIHRoaXMgbGltaXQgYmUgcGVyLWNtZCBtYWtlIG1vcmUgc2Vuc2UgaW5zdGVhZD8N
Cj4gDQpTb3JyeSBJIG1pc3NlZCB0aGlzIGNvbW1lbnQgZWFybGllciAtIGFyZSB0aGVzZSBhY3R1
YWxseSByZWxhdGVkPyBUaGUNCm1haWxib3ggdGltZW91dCBqdXN0IHdhaXRzIGZvciB0aGUgZG9v
cmJlbGwsIHdoaWNoIGluIHRoZSBjYXNlIG9mIGENCmJhY2tncm91bmQgY29tbWFuZCB3b3VsZCBq
dXN0IGluZGljYXRlIHN1Y2Nlc3NmdWwgc3VibWlzc2lvbi4gVGhlIHBvbGwNCmludGVydmFsIGlz
IGp1c3QgaG93IGZyZXF1ZW50bHkgd2Ugd2FudCB0byBjaGVjayB0aGUgc3RhdHVzIG9mIHRoZQ0K
YmFja2dyb3VuZCBjb21tYW5kLiBJIGFzc3VtZSB0aGlzIGNvdWxkIGJlIHNldCB0byBzb21ldGhp
bmcgbG9uZ2VyIHRoYW4NCnRoZSBtYWlsYm94IHJlYWR5IHRpbWVvdXQsIGVzcGVjaWFsbHkgaWYg
d2Uga25vdyBpdCB3aWxsIGJlIGEgbG9uZw0KcnVubmluZyBjb21tYW5kLg0K
