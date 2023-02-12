Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78756939A7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBLT2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 14:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBLT2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 14:28:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E857DF75D;
        Sun, 12 Feb 2023 11:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676230128; x=1707766128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vVj95BE2CqFuJyv0a0c3dAeUmWSgLIqqTsSO2x71X7c=;
  b=gVnNyi96GKWxbVfRX+D9tRjxdgvYJaLJL8vTY3wkUVSpmdGA5973Vib1
   4aw98OGBuJl2X+wHs8cle+nVa5Z0OOPjlQID7m5yMtSGVtqD7iFz4dq21
   A0MfgUZeeqvnFa1rYzixxzUSja2OjkE2gz0x6Vv9yrByU2s9Mt3PyCu0M
   QFZxiDVAEuuDESnwnTQODbf+48cjhjOQ79H7Votord14bN+zGmrBbAHn/
   oTz4D7i3SNb1P2t/SFVVSVigD5KV8AEWFNLrojMZYYjYwEZwleSqlNZMM
   jjiFrucrc4sJI/6Aw1zG8DDi+WFuwzIq508+qfsUKB6KsvOuwEhSbSoVI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="330759134"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="330759134"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 11:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="646165346"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="646165346"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2023 11:28:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 11:28:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 11:28:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 11:28:47 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 11:28:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7cyO0yaLnxs2dFxadQc+rSI3G/fruTxhTEDowvHJRmNGAGTQa0Jm3X1AfNS7DgasqPnHN6I/qgGQbqAynNbFa0Yzsrn+pHgFUELEnWf4tzE8TSkMT5C24IzsFrJ2hoSGmaJwlNRkcIOYQ2I/sbTyLplN3vpFC6MOGbRnDGq75iLnye3A9Q+uMw1Dxpgbt77b6o5CAjBGwb57K9p0D5nIrkQg16PwL/bnWjcbTySBQnb2euZ0OQzQhxKV3umXihO0oNpByyLDFwIPDhItnfXLVEp0W6Faz0dRzvxrOWDG+DXgr+Lw65HI0YvQq0TJ1p2tA2JZp26sw2mjQooSESy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVj95BE2CqFuJyv0a0c3dAeUmWSgLIqqTsSO2x71X7c=;
 b=DGDmG8+Q+hPKm3NUtuYLhsmaJGX1dqj6dBduTLF8Bx0zkxyrLhpDNM/L4ljAqqwIt4eqJhvyRbjdUSTa18jTTxUrkW+xry+pdIBG+66YSF8rrt9GGJOQZ9xBQmfx5AWrTEj5up/GoeBd16roNNWbZHo0ObhOHUwMWl1PXZiZm5/8W9OTc0pNZZkl7R6LI80somx1zLuACGomLWfaU+2BS12+onMGFxzjvyycjByMNJeCt9eKGj0Uh3UUDe7KN9at5qhGW0HC/t3sD/ujo+MRrschtA34+zkt7QabiOKqGrhzBCjO/avwuTZ9MXhRAxfjlV0hUp/lZ43EpbmswFndVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4525.namprd11.prod.outlook.com (2603:10b6:806:9d::8)
 by CH0PR11MB5426.namprd11.prod.outlook.com (2603:10b6:610:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 19:28:38 +0000
Received: from SA0PR11MB4525.namprd11.prod.outlook.com
 ([fe80::926f:ae78:3882:ee8d]) by SA0PR11MB4525.namprd11.prod.outlook.com
 ([fe80::926f:ae78:3882:ee8d%6]) with mapi id 15.20.6086.023; Sun, 12 Feb 2023
 19:28:38 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rajat.khandelwal@linux.intel.com" <rajat.khandelwal@linux.intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
CC:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Topic: [PATCH v5] platform/x86/intel/pmc: core: Add support to show
 LTR-ignored components
Thread-Index: AQHZPLJVw3BodQlC6E2oKWwEdbGhXa7LtwIA
Date:   Sun, 12 Feb 2023 19:28:37 +0000
Message-ID: <7853400f2472fe799540de86bebddfe4b3d76c6c.camel@intel.com>
References: <20230210181614.192578-1-rajat.khandelwal@linux.intel.com>
In-Reply-To: <20230210181614.192578-1-rajat.khandelwal@linux.intel.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4525:EE_|CH0PR11MB5426:EE_
x-ms-office365-filtering-correlation-id: 992ec823-9d4b-41a0-bd4f-08db0d2f570b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRd5WnR2YAg5gDKFSbK6M+8m4Wqgjq1pZN/ooDUgBExXCz8C0UouJBHOg+xx41hvZXaHuGJShItmETX6WJQhYh09FuumDuVC/yW/0sVe/gwkHY8bm6kz7WWXJ6Z7pcYJd4sfy59mwN5wCcT65vJIU9sS0RIuIZX/N4XddlKqT0G75wTIukU9gJfVa76q2TSME9YtmHMtMErwHfqPkr52W9z+8QXokFenwb1vQt9OXGRH53lFvrYhqxcBqGMVwfWCtTBxOaiKvwGPCl5kdOjdRip066INUHUTaROnDDcAzmeB3Xvxd4eq8AOxIeFV7jegoYK8NMQcUtCkS2nAFc0IBJ/qayVRnaRUGVc7kgEwxuQrBjn4zEMVr5oDPACYu08pLEs3PlCTyrcAUwsCaIYphZ+oWrI0WOlg695SDu/wEazrvdtNB39jGPPXsLL1ju4KHMheCB9ep0tcawblQpTnexLH5op5jecpMBOV/5KQWh2WO7Qa6LW5A7kbVU8nRKG2+VTCD9z9HRUw2tjtrQpxCnyfF0v2q0sWHe1ACtGqpyKOh6RRi/EOT4Y6MFQaAcksI+wfAalXRbXbM4/OJ0qbaagA6LDtLYxL9AY+1o8IGLA5g7EouOTP0yzTQImaoBoqgvHXKWrvnce/dUDC5PQwubDsGvieQg5peQ90A7aifyeFOhk+/BHove/PoMotbdcTGIrJ6xSeTA9BAL+iQYSWwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4525.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199018)(83380400001)(5660300002)(41300700001)(8936002)(122000001)(38100700002)(82960400001)(86362001)(36756003)(38070700005)(2906002)(3450700001)(316002)(54906003)(6506007)(110136005)(6512007)(26005)(186003)(71200400001)(4326008)(478600001)(2616005)(6486002)(66476007)(66446008)(64756008)(8676002)(66556008)(66946007)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajNMajR6R2MzZ1hCd2Roanh1a1hVWEdja1BORi90RHlZVVhiSlRhaG9HSkgy?=
 =?utf-8?B?NVVlc1RBMUNLejIzcHFnK0szMlVRN2VONG9kN0RjT29KYjF1U3FEWnkxcllE?=
 =?utf-8?B?ZWR6a01XRkV0VWxvV0NGdVMwVkc1NEt0NzB5Rkh3a3AxbC9uenEyYkU0aHRY?=
 =?utf-8?B?VTNOZjBSZTVPRUFwYjNaMU9PNW8yd0E2ZXFicHlUcmlkYis1aDJZYXhoMnZT?=
 =?utf-8?B?dkdoUDFjckw0TjQweGY0SjNzb214QXgyUVo5RkdLUUVSY000Wkx3akFGa1lZ?=
 =?utf-8?B?K05WTGdkdzNaaHVqYTdGSlR0d2ZLbDFtOUpWeEhlaTFjdE00MTVmYTZ1K2FF?=
 =?utf-8?B?ejRha05WSUU5UDF0Vmg5WU4yUjdZaUkvRHVvL2NiVDdzYSt1dkRZZFIrbWhW?=
 =?utf-8?B?cWJPT2owcFFTUkhMN1J0cVZZVndLMzlkSHVaWDROSnNka2c1VVhRY05UN3Vj?=
 =?utf-8?B?OExVRjM1cWoyVkhCb2Y2MGhCTWR3S2lmdFhFWDJHc3JPMjh6UGo1MGJRaThS?=
 =?utf-8?B?ck9zSjI5TFk5VFBKWWxlQlpwdVoxaWtGbFIxWWRTQ0NOYkh3eXIva0tFZmhz?=
 =?utf-8?B?aVR0dWhZTDIyMDJMelAxTFRJTktKdFh1SDdMU1ZLbTVLdm5aM2tEUzlPejl3?=
 =?utf-8?B?K1QydUYrN2hnTU9SdkYwUEo4U3pQTzl6bHpJVmwwc2d6MVZVZHlaMW00WGRF?=
 =?utf-8?B?WHducnpDWkgxZHRlN2JJbGtNRTRpcmZSTXlYVTdkUVlNNXVhRkkrRDE2d1Nw?=
 =?utf-8?B?SVZIcVVVQ3V6d0VXMkFoSzkzblR5bHpKQUJHRXpjVW5BWi9kYkxYYzg1c2NI?=
 =?utf-8?B?R0FocndmM3EyTmFRd25veDU3VVByR0QwS0pweTZjU0JsMWtoSXNzUGxqcm4v?=
 =?utf-8?B?bjJBYXM0YituRm43a0tYd0dUN0g2M0pwRXBnWkZEc2grQUNrc2xpOWpOTlAv?=
 =?utf-8?B?cU1JK3ZCcjJvSFp3WTU2RHI3ZkZ3bFpsZEExN1pDS1hseE5Oc2pscTJVMWFi?=
 =?utf-8?B?eUZxVzJkenB6aDlwMGVIQ2UrYnN4NGJtSFZsTmF6cTFkWmdtMzg0N1BVZUgv?=
 =?utf-8?B?eGhOV2o2aTFwcTFudHVPK0JsbmNDYk1rQklzcmlIYTVlMnJhMDd5eFpIdzFP?=
 =?utf-8?B?UE5sUEJad2x5WFlqOExyNFFTbkdxR2xNTWdVWTdldHJHSXNSMDJ5NFRhR1Nh?=
 =?utf-8?B?cXFLS2ZhY1hVTWdyb1M4UURtM0h1MlNSTlFzZk1GaTFLaUNXTS8wNUt4SDdF?=
 =?utf-8?B?ZDRNVEZzQzc3U3B0eUMxdUR2cVJIYmFNaW5uVFpZY0ozNCtHdmZVNzJPWE50?=
 =?utf-8?B?MjR3L3hieFR0b2FlK29Jb0FwNjBGZmlFNzNEbG1Lc1laOW9RYkt5RWlDQXU4?=
 =?utf-8?B?dTRxK3JyK1ZJZXZIZDAxamFoUzYwZzVZVzdCcUo1SGIvWnVHYW5vaXVERlRQ?=
 =?utf-8?B?Q3U3OUpoTnhoWTRpUXBZM3VSbVFqS1BBU2FSYnNqQ2FXVmMycDVtZTFZUGhJ?=
 =?utf-8?B?dVhkcW90TlVZcGFmMjNHWFR5UGJsUmRZdHdZa2d5RVdKSlMyQi9oWklzbUJs?=
 =?utf-8?B?TThreWd2djVUamhQL1JvSkI1SnduN2xuaUhLSmR4ZUlRTjJ3NDkwRmZxQjcr?=
 =?utf-8?B?MlVZTDVRY2x1VWMxSmh3NFBOOW9vdjBjKytqWnRpYjI5bnNOdU1VMFZzT3ZJ?=
 =?utf-8?B?MWlJMmdEVDVjeVYyNU5NcElFZWtpS29DWmVRd1FTRDViQWhlVVo2TzUxTDZ1?=
 =?utf-8?B?RFdMK0hld0RONWFxT1BSa1psalphVFROSTQzOWVzemZKazdOT0d0VjR0SEVF?=
 =?utf-8?B?Q0tnL1psbGtUbkp1UEVRMW1ieGJ4b2ZuL1NMZFlIekppZkcyK0pmUlE1eXdr?=
 =?utf-8?B?dEVWaXNIQkFDbDRrdEdLUGFKbitZQnRZZmV5dmxWU3owenhOZVl1ZUVPRk9a?=
 =?utf-8?B?VVFraUJuOTEyb1JoRXV1aldRd0lzNCtiaVZXNnJFQVhrcTJmUmVoaDJyK2U1?=
 =?utf-8?B?Nkd3eno3NnJ0a2tZaDBTTDRqNTV4SzJvb1JyY0pZbDdzeE8yU2JZZ1pjRUhX?=
 =?utf-8?B?YXNzd21UVzF0ZU9VZHlNbGVDQitrME1iS1EwblIwRkRqTTE5T0ZXNFpvQkVY?=
 =?utf-8?B?bkxGRzY0akF4YVJjT2c3bjd6aWxHT1ZlUHhGbEl1dkpyVHBXU1V6THVNOGxR?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <402DE1B2590BF34CBEFD27BB8C40FE9F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4525.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992ec823-9d4b-41a0-bd4f-08db0d2f570b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2023 19:28:37.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuIDzDkSDxF/Q2gOOUMRfPw7XGYBGi+qWDgu0EHrFMkkt/BORFm2kbDBw6M2BXxMrZhfRTqxLwrQX0HoBqY/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTEwIGF0IDIzOjQ2ICswNTMwLCBSYWphdCBLaGFuZGVsd2FsIHdyb3Rl
Ogo+IEN1cnJlbnRseSwgJ2x0cl9pZ25vcmUnIHN5c2ZzIGF0dHJpYnV0ZSwgd2hlbiByZWFkLCBy
ZXR1cm5zIG5vdGhpbmcsIGV2ZW4KPiBpZiB0aGVyZSBhcmUgY29tcG9uZW50cyB3aG9zZSBMVFIg
dmFsdWVzIGhhdmUgYmVlbiBpZ25vcmVkLgo+IAo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgZmVhdHVy
ZSB0byBwcmludCBvdXQgc3VjaCBjb21wb25lbnRzLCBpZiB0aGV5IGV4aXN0Lgo+IEZ1cnRoZXIs
IGlmIHVzZXIgdHJpZXMgdG8gc2V0IGFuIGFscmVhZHkgaWdub3JlZCBjb21wb25lbnQsIGhlIHdp
bGwKPiBlbmNvdW50ZXIgdGhlIGVycm9yIGNvZGUgb2YgRUVYSVNULgoKU29ycnkgdG8gbml0LCBi
dXQgc2hvdWxkIGRlc2NyaWJlIHRoZSBjaGFuZ2VzIGluICJpbXBlcmF0aXZlIG1vb2QiIHBlciB0
aGUKZ3VpZGVsaW5lcyBpbiBzdWJtaXR0aW5nLXBhdGNoZXMucnN0LgoKRGF2aWQKCj4gCj4gU2ln
bmVkLW9mZi1ieTogUmFqYXQgS2hhbmRlbHdhbCA8cmFqYXQua2hhbmRlbHdhbEBsaW51eC5pbnRl
bC5jb20+Cj4gLS0tCj4gCj4gdjU6Cj4gMS4gSWdub3JlIHRoZSBMVFIgb2YgdGhlIHJlc3BlY3Rp
dmUgY29tcG9uZW50IGFmdGVyIHVubG9ja2luZyB0aGUgbXV0ZXggbG9jawo+IDIuIEFkZGluZyBl
cnJvciBjb2RlIGRldGFpbHMgdG8gdGhlIGNvbW1pdCBtZXNzYWdlCj4gCj4gdjQ6IE11dGV4IHVu
bG9jayBkdXJpbmcgZXJyb3IgY29uZGl0aW9ucwo+IAo+IHYzOiBJbmNvcnBvcmF0ZWQgYSBtdXRl
eCBsb2NrIGZvciBhY2Nlc3NpbmcgJ2x0cl9pZ25vcmVfbGlzdCcKPiAKPiB2Mjoga21hbGxvYyAt
PiBkZXZtX2ttYWxsb2MKPiAKPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3Jl
LmMgfCA2NCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiDCoGRyaXZlcnMvcGxhdGZvcm0v
eDg2L2ludGVsL3BtYy9jb3JlLmggfMKgIDIgKy0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNTMgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMKPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVs
L3BtYy9jb3JlLmMKPiBpbmRleCAzYTE1ZDMyZDc2NDQuLjE2Y2Y2YzYzNGRiOCAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5jCj4gKysrIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuYwo+IEBAIC01Myw2ICs1MywxNyBAQCBjb25z
dCBzdHJ1Y3QgcG1jX2JpdF9tYXAgbXNyX21hcFtdID0gewo+IMKgwqDCoMKgwqDCoMKgwqB7fQo+
IMKgfTsKPiDCoAo+ICsvKiBNdXR1YWwgZXhjbHVzaW9uIHRvIGFjY2VzcyB0aGUgbGlzdCBvZiBM
VFItaWdub3JlZCBjb21wb25lbnRzICovCj4gK3N0YXRpYyBERUZJTkVfTVVURVgobHRyX2VudHJ5
X211dGV4KTsKPiArCj4gK3N0cnVjdCBsdHJfZW50cnkgewo+ICvCoMKgwqDCoMKgwqDCoHUzMiBj
b21wX2luZGV4Owo+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IGNoYXIgKmNvbXBfbmFtZTsKPiArwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgbGlzdF9oZWFkIG5vZGU7Cj4gK307Cj4gKwo+ICtzdGF0aWMgTElT
VF9IRUFEKGx0cl9pZ25vcmVfbGlzdCk7Cj4gKwo+IMKgc3RhdGljIGlubGluZSB1MzIgcG1jX2Nv
cmVfcmVnX3JlYWQoc3RydWN0IHBtY19kZXYgKnBtY2RldiwgaW50IHJlZ19vZmZzZXQpCj4gwqB7
Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZWFkbChwbWNkZXYtPnJlZ2Jhc2UgKyByZWdfb2Zm
c2V0KTsKPiBAQCAtNDM1LDI3ICs0NDYsMTggQEAgc3RhdGljIGludCBwbWNfY29yZV9wbGxfc2hv
dyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQKPiAqdW51c2VkKQo+IMKgfQo+IMKgREVGSU5FX1NI
T1dfQVRUUklCVVRFKHBtY19jb3JlX3BsbCk7Cj4gwqAKPiAtaW50IHBtY19jb3JlX3NlbmRfbHRy
X2lnbm9yZShzdHJ1Y3QgcG1jX2RldiAqcG1jZGV2LCB1MzIgdmFsdWUpCj4gK3ZvaWQgcG1jX2Nv
cmVfc2VuZF9sdHJfaWdub3JlKHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYsIHUzMiB2YWx1ZSkKPiDC
oHsKPiDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHBtY19yZWdfbWFwICptYXAgPSBwbWNk
ZXYtPm1hcDsKPiDCoMKgwqDCoMKgwqDCoMKgdTMyIHJlZzsKPiAtwqDCoMKgwqDCoMKgwqBpbnQg
ZXJyID0gMDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZwbWNkZXYtPmxvY2sp
Owo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYgKHZhbHVlID4gbWFwLT5sdHJfaWdub3JlX21heCkg
ewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSAtRUlOVkFMOwo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF91bmxvY2s7Cj4gLcKgwqDCoMKgwqDC
oMKgfQo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgcmVnID0gcG1jX2NvcmVfcmVnX3JlYWQocG1jZGV2
LCBtYXAtPmx0cl9pZ25vcmVfb2Zmc2V0KTsKPiDCoMKgwqDCoMKgwqDCoMKgcmVnIHw9IEJJVCh2
YWx1ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoHBtY19jb3JlX3JlZ193cml0ZShwbWNkZXYsIG1hcC0+
bHRyX2lnbm9yZV9vZmZzZXQsIHJlZyk7Cj4gwqAKPiAtb3V0X3VubG9jazoKPiDCoMKgwqDCoMKg
wqDCoMKgbXV0ZXhfdW5sb2NrKCZwbWNkZXYtPmxvY2spOwo+IC0KPiAtwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gZXJyOwo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgc3NpemVfdCBwbWNfY29yZV9sdHJfaWdu
b3JlX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAo+IEBAIC00NjQsNiArNDY2LDggQEAgc3RhdGlj
IHNzaXplX3QgcG1jX2NvcmVfbHRyX2lnbm9yZV93cml0ZShzdHJ1Y3QgZmlsZQo+ICpmaWxlLAo+
IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2VxX2ZpbGUgKnMgPSBmaWxlLT5wcml2YXRl
X2RhdGE7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwbWNfZGV2ICpwbWNkZXYgPSBzLT5wcml2
YXRlOwo+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBwbWNfcmVnX21hcCAqbWFwID0gcG1j
ZGV2LT5tYXA7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGx0cl9lbnRyeSAqZW50cnk7Cj4gwqDC
oMKgwqDCoMKgwqDCoHUzMiBidWZfc2l6ZSwgdmFsdWU7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBl
cnI7Cj4gwqAKPiBAQCAtNDczLDEzICs0NzcsNDkgQEAgc3RhdGljIHNzaXplX3QgcG1jX2NvcmVf
bHRyX2lnbm9yZV93cml0ZShzdHJ1Y3QgZmlsZQo+ICpmaWxlLAo+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAoZXJyKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGVycjsKPiDC
oAo+IC3CoMKgwqDCoMKgwqDCoGVyciA9IHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShwbWNkZXYs
IHZhbHVlKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAodmFsdWUgPiBtYXAtPmx0cl9pZ25vcmVfbWF4
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmbHRyX2VudHJ5X211dGV4KTsKPiArCj4gK8KgwqDC
oMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRyeShlbnRyeSwgJmx0cl9pZ25vcmVfbGlzdCwgbm9k
ZSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZW50cnktPmNvbXBfaW5k
ZXggPT0gdmFsdWUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGVyciA9IC1FRVhJU1Q7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBnb3RvIG91dF91bmxvY2s7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGVudHJ5ID0g
ZGV2bV9rbWFsbG9jKCZwbWNkZXYtPnBkZXYtPmRldiwgc2l6ZW9mKCplbnRyeSksIEdGUF9LRVJO
RUwpOwo+ICvCoMKgwqDCoMKgwqDCoGlmICghZW50cnkpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZXJyID0gLUVOT01FTTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byBvdXRfdW5sb2NrOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDC
oMKgZW50cnktPmNvbXBfbmFtZSA9IG1hcC0+bHRyX3Nob3dfc3RzW3ZhbHVlXS5uYW1lOwo+ICvC
oMKgwqDCoMKgwqDCoGVudHJ5LT5jb21wX2luZGV4ID0gdmFsdWU7Cj4gK8KgwqDCoMKgwqDCoMKg
bGlzdF9hZGRfdGFpbCgmZW50cnktPm5vZGUsICZsdHJfaWdub3JlX2xpc3QpOwo+ICsKPiArb3V0
X3VubG9jazoKPiArwqDCoMKgwqDCoMKgwqBtdXRleF91bmxvY2soJmx0cl9lbnRyeV9tdXRleCk7
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmIChlcnIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBlcnI7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHBtY19jb3JlX3NlbmRfbHRy
X2lnbm9yZShwbWNkZXYsIHZhbHVlKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBlcnIg
PT0gMCA/IGNvdW50IDogZXJyOwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBjb3VudDsKPiDCoH0K
PiDCoAo+IMKgc3RhdGljIGludCBwbWNfY29yZV9sdHJfaWdub3JlX3Nob3coc3RydWN0IHNlcV9m
aWxlICpzLCB2b2lkICp1bnVzZWQpCj4gwqB7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGx0cl9l
bnRyeSAqZW50cnk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X2xvY2soJmx0cl9lbnRyeV9t
dXRleCk7Cj4gK8KgwqDCoMKgwqDCoMKgbGlzdF9mb3JfZWFjaF9lbnRyeShlbnRyeSwgJmx0cl9p
Z25vcmVfbGlzdCwgbm9kZSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZXFf
cHJpbnRmKHMsICIlc1xuIiwgZW50cnktPmNvbXBfbmFtZSk7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+
ICvCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmbHRyX2VudHJ5X211dGV4KTsKPiArCj4gwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IMKgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmgKPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2lu
dGVsL3BtYy9jb3JlLmgKPiBpbmRleCA4MTAyMDRkNzU4YWIuLmRhMzViMGZjYmU2ZSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5oCj4gKysrIGIvZHJp
dmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL2NvcmUuaAo+IEBAIC0zOTYsNyArMzk2LDcgQEAg
ZXh0ZXJuIGNvbnN0IHN0cnVjdCBwbWNfcmVnX21hcCBhZGxfcmVnX21hcDsKPiDCoGV4dGVybiBj
b25zdCBzdHJ1Y3QgcG1jX3JlZ19tYXAgbXRsX3JlZ19tYXA7Cj4gwqAKPiDCoGV4dGVybiB2b2lk
IHBtY19jb3JlX2dldF90Z2xfbHBtX3JlcXMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldik7
Cj4gLWV4dGVybiBpbnQgcG1jX2NvcmVfc2VuZF9sdHJfaWdub3JlKHN0cnVjdCBwbWNfZGV2ICpw
bWNkZXYsIHUzMiB2YWx1ZSk7Cj4gK2V4dGVybiB2b2lkIHBtY19jb3JlX3NlbmRfbHRyX2lnbm9y
ZShzdHJ1Y3QgcG1jX2RldiAqcG1jZGV2LCB1MzIgdmFsdWUpOwo+IMKgCj4gwqB2b2lkIHNwdF9j
b3JlX2luaXQoc3RydWN0IHBtY19kZXYgKnBtY2Rldik7Cj4gwqB2b2lkIGNucF9jb3JlX2luaXQo
c3RydWN0IHBtY19kZXYgKnBtY2Rldik7Cgo=
