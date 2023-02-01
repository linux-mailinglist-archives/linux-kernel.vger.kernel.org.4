Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583196862F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjBAJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjBAJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:36:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5F85D127;
        Wed,  1 Feb 2023 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675244195; x=1706780195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UTVVnPGMIEZ2mnfrobPqoMqtw0XMfD62FYhXZqG0PHM=;
  b=ecluK1/yJ5m8ywuZNJe+xdmO/M62hb3LQzoP6NKfPJ4hfqg0+jZxnQut
   CVFbraoUCgA2QOpoVuGTn36eHXm0xHb/H7zrx2wqGIUlQ1L81jmltPdUL
   B1/O7h3QPwbSDBXrs07MRudfC0oQ0lLYBdxNdANE8XlggF8INtHcb/9X0
   dA7V0J2IeDPW/EB4HgHkq/XmkfYOx4osWawudU+Z3p8bzuFBnDhDDiVUN
   Pin5afJn4mQjKrXReFgS84xpqLCF57l9YdDssudux10mCPbvec4IPkG9N
   P77/EN5RzLKU+zC/qI/rmfsfasR6RHWtrJ2sSLVQdLUz3fZPcAs4N/2ZY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="326752094"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="326752094"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 01:33:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="664832612"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="664832612"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 01:30:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 01:30:49 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 01:30:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 01:30:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 01:30:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn370WxgJLHGBvqeVOAII3dmiisVuAPfgwIdhSg+tAQGRr+v/3wwXvdNIHoExA+3cblk7loJUlsZtzwAnAH2HBSPOZiJdUN8iCTU1OxtpfvRDk7H7gDEM2JpNnU+x1M3+a+ZEo+CWe7a83nkFutJSXSs/oT9Jt9XddoL6QbPK7XIWZEuReBMS/wJ+25aQaBFN3Xm2R6fz0JXJMSWCF/ve2pG5u1pr04/0jbbbzqqc8eCsPm0qHKmcxEDe3aSM9+Wblx1bzk9cGW5vqpNuMAKn7QGz1F3lJiwn13KbTrxOTxGxBjkekmGyAP/0SBUty11qWfeim5o+Ho6ssbY2SaQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTVVnPGMIEZ2mnfrobPqoMqtw0XMfD62FYhXZqG0PHM=;
 b=RlcvXUN/9BfzNdFDGSqKGViWYLmVKAnGlMTiGMnU+salGE6WNqxCq1PUX7NXUQgebuD5Oug3lZj9JQBCo8jngX07e7JtBgXXXA8/zur/JSrTgNQnmApLAmHm1gaLCTY/CYRDKYHsEjBJjNTqoN2Gz9gDD1gD1goKGaVqKPzwdR6XrCVNA2Ud5e7Yt06gorgi7GV3BZTZbrXtLsiN5KRzw/dNod2yGJmimTg83rHBihCQS2v4scmu4JIROL8A0QKYlJB+unbc6PDecG9a78xAmig4wvASvCRUsd0+TYEr/LYz5T7oKCr8y2KMR3WbX9yQ7+SWdB4my41TFLf0PmtZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 09:30:46 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%4]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 09:30:46 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 0/8] thermal: intel: intel_pch: Code simplification and
 cleanups
Thread-Topic: [PATCH v1 0/8] thermal: intel: intel_pch: Code simplification
 and cleanups
Thread-Index: AQHZNN4k7uIHoJI5tU+cNG//rpyh2K63VCEAgAKB1wA=
Date:   Wed, 1 Feb 2023 09:30:45 +0000
Message-ID: <51f07f67e8943e9009b592007d5d26f2faf583ce.camel@intel.com>
References: <1751684.VLH7GnMWUR@kreacher>
         <CAJZ5v0jpmyBGFMhhKqGH6kfsuAGhhvqwbiM_Ck++_N9kUOav0Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jpmyBGFMhhKqGH6kfsuAGhhvqwbiM_Ck++_N9kUOav0Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH8PR11MB6563:EE_
x-ms-office365-filtering-correlation-id: 70e0be4d-5d1f-40b2-f8fc-08db0436ff40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6SVDCfMH7ZkQg2B23mUc0oReSieToE8niH0XWr5EpZcuZDcZPSXErRCpQlsAt0kPq7klfed1EaawfbxiCSLWpmopHpXyGcxNQybtdNgu26N4iIdnqkkh1Ml7MeQKuujARVClauAAt9h0BrJ13eQlZxw0ZZKL61atu+anBLAPXakMyjvlWitk0zO5AB7Ba8qCDF/vuK5cdifZFqVXvoHmHwww1xtgH+XAiMmy0/74zlgFODSBz5NTndZtFg70Z2SmLr4B/uLuU0TnygJgoKSCdGp4r+RuLGf5HF1fBIuxwqSoF/HX3Vo5ksmtRehgrUX9mmO5yRp/iS/gTUNnFgsY+Fhe+SG07DzPJ+bkfbVDsPRTG/fRwpYldwIwQCWRTzstx1TykWhUd4ok54hyQMJ/aJLBP/MIOJljSFTbegtCV65acfAixTkKMC+QQSbkBtbOHU45m6lzHDbOo33QCuKTwJJqLmNw9jJcyTp2AhZ7EjI5jX6zXsiPu4px4SGsDC9qZtC+423wpCBMnLknnIL1YcgK5fQwSGzPFDn01QgCYf3Hbv6fFnndWzkwF5GlmTk2n0cEw17SjOoDkrUtcQtViXelpCME4eOuosp6Gx65rb51JQgL/UXvyxKylCECIhWzTdGcTBOf/DJRrMEzkhdxApWLySAy9CjQ3OkpsTMPOz4XW8isyqarsgNHBwxP/rALttzVgn4yPZ8GQI3dM2m9FlxS2zz/P0rxK0E5GWry6c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199018)(86362001)(36756003)(38100700002)(38070700005)(122000001)(82960400001)(6506007)(53546011)(26005)(6512007)(2616005)(186003)(71200400001)(316002)(6486002)(66476007)(8676002)(54906003)(110136005)(478600001)(966005)(2906002)(64756008)(5660300002)(66556008)(76116006)(4326008)(66946007)(91956017)(66446008)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFdoeEhXSkNjM2ZVTWs5MHJDSHN6c0xKZGo5Vm9nWFNpMFppWFNhdkhscmlD?=
 =?utf-8?B?VE5IQmpKSVNGVHowaC9tcURWYWNDSlBEYnEzSjJ1blh6d2tNMEpKemlTRzJH?=
 =?utf-8?B?Z0Z3SW1TNGpNUW5QeHpuZWd4ZDd0NGJQUkJ0anVybHVYNmo4YlN1SElSS1hU?=
 =?utf-8?B?ZEthbkRuOGhFcG56cUxsd3kwa1Q2K2lNTCtIUTc2Wk1ScDNnemk2OUd2c0Ro?=
 =?utf-8?B?WEJNVmhLWk1pVi85NVA3UllWQVlDTDBXNmFFa2ZBcWhYK052WHF3b3FKTHlw?=
 =?utf-8?B?MzNVS1hUaVBvVVRILzdyd09tMGJpMnNnUjdVdmJvS3FqVlczaUthQmNISm5z?=
 =?utf-8?B?bkIyakVWSXp4end1R3VuNGlDWEpkK3NPMmlzMGl6YS9nU0pxNkNDMUh0RnNV?=
 =?utf-8?B?OEZUZXYzSHhVaXRoa0FPWnh3V0FZMlM1OVY4Q3pLTHlDaEpHeDgwcmZOOVl0?=
 =?utf-8?B?eDRJSjZkcXJKSDhzYWRySE5xRC9qOHV5eFV2bXVGUVpnd1g5czMyTXRIMHc2?=
 =?utf-8?B?b0RvTG1QUVBCVWVPamNHUUZaQit6dHlGbi9mL2hwOU5ab1NjdXJJMWRwNk9Y?=
 =?utf-8?B?UWlxTXZBcTdLbGhKTXcyUXA4ZndzSG5jUU0zVVF0VExGRVcvWjRpVWF2ZUda?=
 =?utf-8?B?ZnY2Kzd5YTFnYjhuQWROaUIxZjdEVkE5aHVnU0t6ZmljNCtDeGEzTlZhZmFz?=
 =?utf-8?B?NzhFUWMyNmNOaUsyNm1sYnJZZGlQclhHZG1OYVIrQnhkMTFZbnVDNnVmanNP?=
 =?utf-8?B?eVRMV3k4VnI1S0ZaREdjVVNaWExOaUlSN0F3cTd1R2ZDUXZpMlpuSFcwcnRV?=
 =?utf-8?B?MmRmMCtXaldKTVZoMFM2V1JLM3dqTUNjVEsvb0ZEcFdqWWNGbjJUeVBhM0NF?=
 =?utf-8?B?WkpuSEFIbWdFbkNjQjdyUDZ5SkZTcXl2d0orQ2puUUVFL2FNVkVUTS9IZWZP?=
 =?utf-8?B?YW1uUzFFZnFwdVBENVNzZ0txQ1VaZEt6M1lSdWJjREhqVUdDT3VDdTRRRE9M?=
 =?utf-8?B?WXAzb2RlOTFqYjFaWlFvTCtKV1E5K05NQ0x2SnoxVFc5ZFBWUUw5ZEQ0elBj?=
 =?utf-8?B?R3JDcGcwelJQYmdHdHN5cEhjR0x1RllNbXJJaUg5NkFReWpOMnRyVzFvbzVD?=
 =?utf-8?B?UkdranhIcnRWK25ZeDVtTG9ucjZHL28zODlITnI5U3BFdC8xUnlmMDRRY2dZ?=
 =?utf-8?B?ZGZFeXNpRWs1c1I5amF0dGVmWTB6aW8yZHBZakZrMDBtcStqMW9sMTNybWdI?=
 =?utf-8?B?aDJSTEZmMUpNSlRuTnNnK2UraXBvSG14VzBvOVFFdjVhWmkrWTdSQW5lTUsv?=
 =?utf-8?B?am1UVyt2ZWZORU8vVWx5ZnovTkZFTmFONEdFZ2szU2trbFdkUU9GVVlkRUZu?=
 =?utf-8?B?d2FldGZubklUM0hJUW9BcW5BMjhZN1pvTWUrMEtmU0NtL0c3ZXk0bW5YVDln?=
 =?utf-8?B?UmJKbUdEeDQxY2UrNVI2WnFqZitxekFxeXZROVZCNHl2dkZ5TUh5Tk1HMVFT?=
 =?utf-8?B?UElYWFRyLyttTFBPdHY1TlB0ZXZnak9Cb1YwWXFtakcrS2NVTjFualE5c052?=
 =?utf-8?B?V211MWlsclJTL1laK3o1bC9uTEZwMFowQVBaZ01KMVVFZG9pYjd5UjNYUzdC?=
 =?utf-8?B?SWUzZmIvMnFwdUlUZGxSajFqQTJrRndUemcwVjI5NTR4VE1TTENWOGkvMlFs?=
 =?utf-8?B?UnhxR2FOcFh4cVl0TUZ2MU1Sd2NyMFdCa1o5ZFRNUmNEckZGdWY2WFRkSzZF?=
 =?utf-8?B?NDQ4akhFL0JNak1KS0lkWUsvbGtFUXVteFYwRDAyTUV1cHl5eFFNTGRGWjZa?=
 =?utf-8?B?cWxrMTBXUit1dXJSMzlLYzRncXp4M3REQnU2OWpjK0dITWR3QnNxMkpzaGcr?=
 =?utf-8?B?a3FuWlo1ZGlLUXJJcktzYWZUNTFjSG5XY0hSbUNQbkNzRmVNMXNqbHFhUlRN?=
 =?utf-8?B?eHRVanoyUnlCWnhjU1NzdzNmc0RUS2h5UTBxcWJUUGVCeGx5MjAyYUtEbXNi?=
 =?utf-8?B?aW5SRXVXSlA3RTNJS0lHTDVudXVEK0ZGdXFBNjYwczA4aWpzWGZBZkgyN0xE?=
 =?utf-8?B?b2lIZlAvYlRpWENFMUpwZGRPNUV3c0hvYW1ncUNEWUwzaUtPWHhaa0FiRUFX?=
 =?utf-8?Q?2DUaFDPGsQMc/LhwnmL4ia7af?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53FB0F39D9B8DB4FBB21F3823B483097@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e0be4d-5d1f-40b2-f8fc-08db0436ff40
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 09:30:45.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHJHAP+Yd2edXZPYIVvDdcocmezOPqirPdv5nBBzYSSwfKI1i8yI/fWY+GR29UpwUnBqIoi7XnSFplMcNbQ1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDIwOjEzICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgODowOCBQTSBSYWZhZWwgSi4gV3lzb2NraSA8
cmp3QHJqd3lzb2NraS5uZXQ+DQo+IHdyb3RlOg0KPiA+IEhpIEFsbCwNCj4gPiANCj4gPiBUaGlz
IHBhdGNoIHNlcmllcyByZW1vdmVzIHNvbWUgdW5lZWRlZCBjb2RlIGFuZCBkYXRhIHN0cnVjdHVy
ZXMNCj4gPiBmcm9tIHRoZQ0KPiA+IGludGVsX3BjaF90aGVybWFsIGRyaXZlciwgcmVhcnJhbmdl
cyBpdCBhbmQgZG9lcyBzb21lIGFzc29ydGVkDQo+ID4gbWlub3IgY2xlYW51cHMNCj4gPiAobm8g
Y2hhbmdlIGluIGJlaGF2aW9yIHNob3VsZCByZXN1bHQgZnJvbSBpdCkuDQo+ID4gDQo+ID4gUGxl
YXNlIHJlZmVyIHRvIHRoZSBpbmRpdmlkdWFsIHBhdGNoIGNoYW5nZWxvZ3MgZm9yIGRldGFpbHMu
DQo+IA0KPiBJIGZvcmdvdCB0byBtZW50aW9uIHRoYXQgdGhpcyBzZXJpZXMgaXMgYXBwbGljYWJs
ZSBvbiB0b3Agb2YNCj4gDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC1wbS9wYXRjaC81NjQxMjc5LkR2dVloTXhMb1RAa3JlYWNoZXIvDQo+IA0KPiB3aGljaCBp
biB0dXJuIGFwcGxpZXMgb24gdG9wIG9mIHRoZSBjdXJyZW50IHRoZXJtYWwgYnJhbmNoIGluIGxp
bnV4LQ0KPiBwbS5naXQsDQo+IHRoYXQgaXMgYWxzbyBwcmVzZW50IGluIHRoZSBsaW51eC1uZXh0
IGJyYW5jaCBpbiBsaW51eC1wbS5naXQuDQo+IA0KSSBhbHNvIHRlc3RlZCB5b3VyIGxpbnV4LW5l
eHQgYnJhbmNoIGJ1dCB3aXRob3V0IHRoZSAidGhlcm1hbCIgbWVyZ2UuDQoNCi0vc3lzL2NsYXNz
L3RoZXJtYWwvdGhlcm1hbF96b25lNy90cmlwX3BvaW50XzRfdGVtcDotMzI3NjgwMDANCisvc3lz
L2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lNy90cmlwX3BvaW50XzRfaHlzdDowDQorL3N5cy9j
bGFzcy90aGVybWFsL3RoZXJtYWxfem9uZTcvdHJpcF9wb2ludF80X3RlbXA6LTIxNDc0ODM2NDgN
Cg0KVGhlIG5ldyAiaHlzdCIgYXR0cmlidXRlIGlzIG5vdCBhIHByb2JsZW0gYXMgaXQgaXMgbWFu
ZGF0b3J5IGZvcg0KZ2VuZXJpYyB0cmlwcy4NCg0KVGhlIHRlbXAgdmFsdWUgY2hhbmdlcyBpcyBp
bnRyb2R1Y2VkIGJ5IGNvbW1pdA0KM2QyZjIwYWQ0NmY4ICgid2lmaTogaXdsd2lmaTogVXNlIGdl
bmVyaWMgdGhlcm1hbF96b25lX2dldF90cmlwKCkNCmZ1bmN0aW9uIikNCg0KLSAgICAgICBmb3Ig
KGkgPSAwIDsgaSA8IElXTF9NQVhfRFRTX1RSSVBTOyBpKyspDQotICAgICAgICAgICAgICAgbXZt
LT50el9kZXZpY2UudGVtcF90cmlwc1tpXSA9IFMxNl9NSU47DQorICAgICAgIGZvciAoaSA9IDAg
OyBpIDwgSVdMX01BWF9EVFNfVFJJUFM7IGkrKykgew0KKyAgICAgICAgICAgICAgIG12bS0+dHpf
ZGV2aWNlLnRyaXBzW2ldLnRlbXBlcmF0dXJlID0gSU5UX01JTjsNCisgICAgICAgICAgICAgICBt
dm0tPnR6X2RldmljZS50cmlwc1tpXS50eXBlID0gVEhFUk1BTF9UUklQX1BBU1NJVkU7DQorICAg
ICAgIH0NCg0KSXQgaXMga2luZCBvZiBzdHJhbmdlIHRvIHVzZSBkaWZmZXJlbnQgdmFsdWVzLCBi
dXQgYm90aCByZXByZXNlbnRzIGENCmJvZ3VzIHRlbXBlcmF0dXJlLiBXaGF0IGFib3V0IHVzaW5n
IFRIRVJNQUxfVEVNUF9JTlZBTElEIGZvciBmdXR1cmUNCmNvbnNpc3RlbmN5Pw0KDQp0aGFua3Ms
DQpydWkNCg==
