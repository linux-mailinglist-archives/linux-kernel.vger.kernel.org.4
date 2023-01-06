Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3921165FCCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjAFIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjAFIc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:32:56 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833BE676CE;
        Fri,  6 Jan 2023 00:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672993975; x=1704529975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4ghODEvXXVDPlgRJdYYwyIz4iNfN+zjRxyOhySAjgqk=;
  b=XMw1CBsjUA1WXunDsBKGshMWhFR7o5BY3oxgHU9RStKt8bXCDZiNog3G
   Y6gLcs53PbcVnwrBp2XoYVErn9UMi2SxVpau+hFPNEOYxI8VsS3s8ReUQ
   p9lUngrNjHXBpy1GYEowMVh4tXN9/+7cZLRabe68D4XqYynVO22cfP/BD
   EKnnDpe/XHgFIh7nrd0DsLGiTn5rZj0PjTM2oVtbb21TVaOzFJkvf5maS
   XypyhQmAGc9SnXmcJdyibwpvk5+VhkbaWsivkcxUG+ShYilqan7LfS1dN
   EltIhXXdLysVYvvhawLwwzZSaczBGHq2zIQOZt7XlvIHAMKlcI+fhJ6f4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="384740546"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="384740546"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 00:32:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="686407000"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="686407000"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2023 00:32:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 00:32:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 00:32:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 00:32:54 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 00:32:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLyEmX6J98F863mYlKV6xKxjjGpu96CdPoXD6X5rZrY5tNheU6B83eEVnLCc7TJe78JGZbjAvLpt/CsgiXOuF+gLLQpx77jCuH3sRIzNSDrGO66+79NO44OiYoNIjvzZfRO7rZD1f53inqtCJnU8RM9AqkUDWMa/VTX9pQPDGDVlCV0bGIlAeiSHAt+VHZ6Q09TAxlmXP9x6G7HF59V/rF7xv2jat+1gJhRAHGcrEoWDH+3Qev4kTRCjba2Elc5rUxAly1Suq9b9yBqvaNkZWWAxAHqrZ89DnWy48HQEUEurDaMuY+1z2wAZa7kOaYC+tKL10JBNmf/F5m9K5GMJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ghODEvXXVDPlgRJdYYwyIz4iNfN+zjRxyOhySAjgqk=;
 b=D+bWCYrrkM8qLxm5fR51jmhM5W2QHG4gongIt2jSM8PfxZngrYb6Eqn6MK0aS6rBxmvlIIQf3nnZv8CKD4LeeBz8rm3rqk8RRiMXFrCW1kRke7UIfwIimpNrYAoc0uWUPbCJWwi7iWk/uhjNFRCIlsxREHgK+UTXfcM2AmpCGwfUu8QiUpDb7PBWwEiifM/PKoATYIij6z5qoJPPo+QSaYtADZV622W88cmwxAwTO4dPNKiKbXZM1Z8FJ8PO4A1kHIE90YALeqpjq3Pp+568GFTmZIAY8I2Uvk4CEj3PaMHZjnC1zHOxPeaYGgKZOtB0uODQbTWxbqGOmtpNI3Cfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 08:32:51 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 08:32:51 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] thermal/drivers/intel: Use generic trip points for
 intel_pch
Thread-Topic: [PATCH v3 2/3] thermal/drivers/intel: Use generic trip points
 for intel_pch
Thread-Index: AQHZIIrw6YvVRg38NUeL6XVYfNpeL66REdYA
Date:   Fri, 6 Jan 2023 08:32:51 +0000
Message-ID: <ff0b001a0b7c7beb17e007219414a39ba6d953ef.camel@intel.com>
References: <20230104222127.2364396-1-daniel.lezcano@kernel.org>
         <20230104222127.2364396-3-daniel.lezcano@kernel.org>
In-Reply-To: <20230104222127.2364396-3-daniel.lezcano@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA0PR11MB4767:EE_
x-ms-office365-filtering-correlation-id: 705e8289-3a67-4a1d-6ae5-08daefc0998e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6Ko3CvtA8lwoc3496k7efrZB+Z1N+rPfZCSu5VXzH5wkyZVtovB+0d1M0ydtEywCT2h9ST86I+V6en589J6qtkGzROWx9ZksQcyxp8uhaATKryJLUTNgT6Oj85bzRRiwhqFAy6XOjpaGMuDgnoltWeolAls/nvjYa4dvN+jqo9N6gfH2vLbJ2x0Ut8eCVXSIDbhuhvJF+p1kZdP2DMi1jIqSxXqvgCC6hIsAgyCaIK+2ZZB47Y2lp/S0FQ7FWA0GQnWPXUihIlNxYhfI4XwyPSWAWQzpYMFbaKnHrwXWL+UoVjgkig1iYdQzmBRYqOdzYLJA72TtoQjVmEenUhpUMxck3+Mg9cQFhUbseJN/Gn96geZhP8KyO6HUGWMTQJyUw0TaAoW0CF+2ne3yCMOudfs7NUe8CIIq2Rc+Vono6cN6EvnmKAHhESfUX6gwaL9vTezuI0fxTJ1VpsWdHxD8JFelRZZg2aLW0yeoQvaGGkt7l77f/IoVUZd2S/XYVQKX/mQ15eN/OQWZJ6vTVGIWZLHUMbnR1g41a1N0DwfuAzjW3bkgXBIpD15BR95JamLV4+zfsXGTOrbPYerw9PtwXZL+F9/DnhSbsmjSNeeLCKpKsArHZvMYr8Nac4eYNWdHlE9v6OpGrJaTLkglWJTMPg8w65dIEqnf5jvTCAzy9ctw1qw54tRArm3muCxvDVU2nv/Ta8ban04NWqH7FV/m9GVy//GDS5LyiReM2/RJEg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(83380400001)(26005)(186003)(6512007)(86362001)(2616005)(38070700005)(36756003)(122000001)(38100700002)(82960400001)(478600001)(54906003)(2906002)(64756008)(41300700001)(316002)(110136005)(8676002)(91956017)(7416002)(76116006)(5660300002)(4326008)(66946007)(8936002)(66556008)(66476007)(6506007)(6486002)(71200400001)(66446008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hTLzhjZ0dEUjFlTGVROWNIeVhkZ1NxS1VuTmV4UUtCWGlUNWcwS1ljZ0Z3?=
 =?utf-8?B?ZnlSMVpnZy9oS3JsQVBXWHUvN0ozTy9ORGdpZWE4YThjRTFZYkZkOWh1dXFp?=
 =?utf-8?B?N21uR2hSRnJRdkZvbFVlV05vWkszM0tiTGozTU5kU2ltTmpGdTFGcXc5eTdZ?=
 =?utf-8?B?L3FRMSs3anBlekNMSXlNVGx5WlJVMG9wT0I1M0NCcVBLbGl2NTBoczE2S3Vu?=
 =?utf-8?B?aXRSRVA4YTNwaUhCaXZrakpLL3haMU11MkJwMDl4NTVULzJhS2lDbDFkSFBm?=
 =?utf-8?B?cEd1Vk9LMTFjSzV2cFloQVd0SnVCNDIrL0VaeGRTN21UZ25yMkxxZGpCdUow?=
 =?utf-8?B?NEtwNWtNZmpBWXlqN3BhdGt0YU5HUC82QnNDbk5xSHBqNkRyK1JFSFB4bDV4?=
 =?utf-8?B?S0VIZG9pQVNzT04rd1ExalZKbFFBN2psZ2RxZjF5bEl1eWV3ZE8rS292eXdV?=
 =?utf-8?B?bFZtVzJOTU1wWXIxUzNQeXlMNlpsWDZKR0dFMGtYSUdYL3hKWEhvR3h6ckF0?=
 =?utf-8?B?dUNpVEJSYkhpdkZLQU5xSTlackFET3F1enVvdGJjbWplUFB4QzdNMG1zbFdu?=
 =?utf-8?B?alEyM0xXWjdUKzdhMm9OQW5FMHl0ZzdsZllyZjYzT084dGJqQkNBVnd0cGZ5?=
 =?utf-8?B?UyszR1lhYWh4OGlxKzZqOEJvUG9Wc2ZpTmJRYmF6TEYrc05LcEZiRDZqaGQr?=
 =?utf-8?B?bjIzNWVDMTA2WEd1MEtaVEZuc0J2UForL0xZWlB1WitaZU44NWxsdjdEdXRu?=
 =?utf-8?B?cTFlWXIzK0tOYnJ2M21pRm5YQzJYN0RoQ3o5UThZOVBsZmlMbUYraTkwSEZy?=
 =?utf-8?B?clp6YkJNd3RFalh0eXNwR0ZqV2hjM3I5WVh6Z00wZ0wvZEgvUWNoL0NUTlN5?=
 =?utf-8?B?eGtVYlF0N0lLbXZnbTREYlZqRjlvTXFzaiswUDBwL1FiTE9ISzFZS0pJRjhJ?=
 =?utf-8?B?d1kwdUtQUmxXUzhqdEY3RmJCcXVMRWgwWHpjWnpRb2tCTWdaOC9YcWptZ1JY?=
 =?utf-8?B?Vjh0MGZsa2hMMjlxRThVcmJQbGlRMFFkdUhGNTFPSXRScWFxUHJ0YkZHSFhH?=
 =?utf-8?B?ZDdDSDZtYXFlR3NjUFBKWWtKSEFraC95d3RONHV0alJDSzdnd2Ewb0tXWkNL?=
 =?utf-8?B?MjBrRVg2UG0zSmlpNGhGeDBpTXJSczY4cFgxN3k1SWozMWJIaS9jUTNDTnQ2?=
 =?utf-8?B?dTRXNUJOSmtURGZMaGx1Zi9FVUtTU0VnK2JHQUJoQnI5NFZFM1VBV3RKMWxM?=
 =?utf-8?B?UEl2bUtSaWdtNDJXY0I3OUdCRUpaOSt2NEZmVExIdE53S29sbElPNWhmaGo1?=
 =?utf-8?B?Z0tvOWw5bmZJNG8wSzZRWTdPWmJxRVJHbWFKRE1FMDRocVlyOTZ6Z1ZCMFdS?=
 =?utf-8?B?SzBVNDBia3JEZHhWck9xcjFhdjZLZTZUTTlndDVYOWlRTXUwaFJVdWtZalNF?=
 =?utf-8?B?cTlTR3JrOGJvbGMrL1o2RlJ6cVQxMXQ5cWRTeTBCOUhWQ203R2FmelJVVyth?=
 =?utf-8?B?KzJVWWJpSmpFckdFUlNRclpqWGEwZ2xJOW9DUVlOL0hRY0JXaFdDN1ZpMkNS?=
 =?utf-8?B?a1lqamM3K0o0aTUzK3oxZzltMit5ZEZaUDdiMUJGNEd1VXhPV3pZQTZzMGEz?=
 =?utf-8?B?V3c2S2tMVGo4SktrV2FJdGQxM3RTMUkwZWMxaVcydHlwM0c0M0F4UUIvOERO?=
 =?utf-8?B?YVRPdnhoVjJSMWxSQVBFLzMzanRRS1k1bUF1YnVZbzZ5dmlTMHZad25DSFNw?=
 =?utf-8?B?V2ZjNFJsQVhkTzkzTEN5WCttcEU2KzNzYU44R1dQWTNuMXcyQ1ZKTXo0VlZm?=
 =?utf-8?B?RklhZ01HaWNoZVhIRVJrUDhIL3NpOTMzUE94U0RxN29LQXFVcWVlNkladHVN?=
 =?utf-8?B?d2ZwVmt0QjZYekhNd2MycnVmR09IMzBOc1B0RTNad0lUVHpzWmRwWWtWc1R6?=
 =?utf-8?B?ZlRrenhTUFovSW5MYy80dHlrVXNhYzFtSEdselp1UTVnSEdVRHF2RnFndUNO?=
 =?utf-8?B?aVpoTWY3cTJRNGpNc0JuVFpkWi9sU2toYi9ZaFBFTTFUanoxT1ZaaWEwelNi?=
 =?utf-8?B?MkhJTG1uaHMrZHFCZVM2TDIwcXp4L29FbWZnd1h0K0ZaWFF2RnFGUUwzVzlL?=
 =?utf-8?B?SmFWSER0Q2s1cFV5eld3UlpjWDdCZGNhQlNiZjE5bkEwUVJ2eVRMT0x1R3FM?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C90D12340EA88D409B25CA62E9D2F1EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705e8289-3a67-4a1d-6ae5-08daefc0998e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 08:32:51.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wth4RAsQslJ/LlXPuetCxI/yroIedj07XE2J1gxD4fuALNptP2wtV8rvz8aR9ktOUN7xp5jhy4hdZTbxh1KObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTA0IGF0IDIzOjIxICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gRnJvbTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IA0K
PiBUaGUgdGhlcm1hbCBmcmFtZXdvcmsgZ2l2ZXMgdGhlIHBvc3NpYmlsaXR5IHRvIHJlZ2lzdGVy
IHRoZSB0cmlwDQo+IHBvaW50cyB3aXRoIHRoZSB0aGVybWFsIHpvbmUuIFdoZW4gdGhhdCBpcyBk
b25lLCBubyBnZXRfdHJpcF8qIG9wcw0KPiBhcmUNCj4gbmVlZGVkIGFuZCB0aGV5IGNhbiBiZSBy
ZW1vdmVkLg0KPiANCj4gQ29udmVydCB0aGUgb3BzIGNvbnRlbnQgbG9naWMgaW50byBnZW5lcmlj
IHRyaXAgcG9pbnRzIGFuZCByZWdpc3Rlcg0KPiB0aGVtIHdpdGggdGhlIHRoZXJtYWwgem9uZS4N
Cj4gDQo+IEluIG9yZGVyIHRvIGNvbnNvbGlkYXRlIHRoZSBjb2RlLCB1c2UgdGhlIEFDUEkgdGhl
cm1hbCBmcmFtZXdvcmsgQVBJDQo+IHRvIGZpbGwgdGhlIGdlbmVyaWMgdHJpcCBwb2ludCBmcm9t
IHRoZSBBQ1BJIHRhYmxlcy4NCj4gDQo+IEl0IGhhcyBiZWVuIHRlc3RlZCBvbiBhIEludGVsIGk3
LTg2NTBVIC0geDI4MCB3aXRoIHRoZSBJTlQzNDAwLCB0aGUNCj4gUENILCBBQ1BJVFosIGFuZCB4
ODZfcGtnX3RlbXAuIE5vIHJlZ3Jlc3Npb24gb2JzZXJ2ZWQgc28gZmFyLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiAgICAgVjM6DQo+ICAgICAgIC0gVGhlIGRyaXZlciBLY29uZmlnIG9wdGlvbiBzZWxlY3Rz
IENPTkZJR19USEVSTUFMX0FDUEkNCj4gLS0tDQo+ICBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvS2Nv
bmZpZyAgICAgICAgICAgICB8ICAxICsNCj4gIGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9w
Y2hfdGhlcm1hbC5jIHwgODggKysrKystLS0tLS0tLS0tLS0tLQ0KPiAtLS0tDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDY5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9LY29uZmlnDQo+IGIvZHJpdmVycy90aGVybWFs
L2ludGVsL0tjb25maWcNCj4gaW5kZXggZjBjODQ1Njc5MjUwLi43MzhiODhiMjkwZjQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMv
dGhlcm1hbC9pbnRlbC9LY29uZmlnDQo+IEBAIC03NSw2ICs3NSw3IEBAIGNvbmZpZyBJTlRFTF9C
WFRfUE1JQ19USEVSTUFMDQo+ICBjb25maWcgSU5URUxfUENIX1RIRVJNQUwNCj4gIAl0cmlzdGF0
ZSAiSW50ZWwgUENIIFRoZXJtYWwgUmVwb3J0aW5nIERyaXZlciINCj4gIAlkZXBlbmRzIG9uIFg4
NiAmJiBQQ0kNCj4gKwlzZWxlY3QgVEhFUk1BTF9BQ1BJDQoNClRIRVJNQUxfQUNQSSBkZXBlbmRz
IG9uIEFDUEkgYnV0IHRoZSBQQ0ggdGhlcm1hbCBkcml2ZXIgZG9lcyBub3QuDQpTbyB3ZSB3aWxs
IHJ1biBpbnRvICJ1bm1ldCBkZXBlbmRlbmNpZXMiIGlzc3VlIHdoZW4gQ09ORklHX0FDUEkgaXMN
CmNsZWFyZWQgbGlrZSBiZWxvdw0KDQpXQVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVz
IGRldGVjdGVkIGZvciBUSEVSTUFMX0FDUEkNCiAgRGVwZW5kcyBvbiBbbl06IFRIRVJNQUwgWz15
XSAmJiBBQ1BJIFs9bl0NCiAgU2VsZWN0ZWQgYnkgW21dOg0KICAtIElOVEVMX1BDSF9USEVSTUFM
IFs9bV0gJiYgVEhFUk1BTCBbPXldICYmIChYODYgWz15XSB8fA0KWDg2X0lOVEVMX1FVQVJLIFs9
bl0gfHwgQ09NUElMRV9URVNUIFs9bl0pICYmIFg4NiBbPXldICYmIFBDSSBbPXldDQoNCnRoYW5r
cywNCnJ1aQ0KPiAgCWhlbHANCj4gIAkgIEVuYWJsZSB0aGlzIHRvIHN1cHBvcnQgdGhlcm1hbCBy
ZXBvcnRpbmcgb24gY2VydGFpbiBpbnRlbA0KPiBQQ0hzLg0KPiAgCSAgVGhlcm1hbCByZXBvcnRp
bmcgZGV2aWNlIHdpbGwgcHJvdmlkZSB0ZW1wZXJhdHVyZSByZWFkaW5nLA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3BjaF90aGVybWFsLmMNCj4gYi9kcml2ZXJz
L3RoZXJtYWwvaW50ZWwvaW50ZWxfcGNoX3RoZXJtYWwuYw0KPiBpbmRleCBkYWJmMTFhNjg3YTEu
LjUzMGZlOWIzODM4MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVs
X3BjaF90aGVybWFsLmMNCj4gKysrIGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3BjaF90
aGVybWFsLmMNCj4gQEAgLTY1LDYgKzY1LDggQEANCj4gICNkZWZpbmUgV1BUX1RFTVBfT0ZGU0VU
CShQQ0hfVEVNUF9PRkZTRVQgKg0KPiBNSUxMSURFR1JFRV9QRVJfREVHUkVFKQ0KPiAgI2RlZmlu
ZSBHRVRfUENIX1RFTVAoeCkJKCgoeCkgLyAyKSArIFBDSF9URU1QX09GRlNFVCkNCj4gIA0KPiAr
I2RlZmluZSBQQ0hfTUFYX1RSSVBTIDMgLyogY3JpdGljYWwsIGhvdCwgcGFzc2l2ZSAqLw0KPiAr
DQo+ICAvKiBBbW91bnQgb2YgdGltZSBmb3IgZWFjaCBjb29saW5nIGRlbGF5LCAxMDBtcyBieSBk
ZWZhdWx0IGZvciBub3cNCj4gKi8NCj4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgZGVsYXlfdGltZW91
dCA9IDEwMDsNCj4gIG1vZHVsZV9wYXJhbShkZWxheV90aW1lb3V0LCBpbnQsIDA2NDQpOw0KPiBA
QCAtODIsMTIgKzg0LDcgQEAgc3RydWN0IHBjaF90aGVybWFsX2RldmljZSB7DQo+ICAJY29uc3Qg
c3RydWN0IHBjaF9kZXZfb3BzICpvcHM7DQo+ICAJc3RydWN0IHBjaV9kZXYgKnBkZXY7DQo+ICAJ
c3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6ZDsNCj4gLQlpbnQgY3J0X3RyaXBfaWQ7DQo+
IC0JdW5zaWduZWQgbG9uZyBjcnRfdGVtcDsNCj4gLQlpbnQgaG90X3RyaXBfaWQ7DQo+IC0JdW5z
aWduZWQgbG9uZyBob3RfdGVtcDsNCj4gLQlpbnQgcHN2X3RyaXBfaWQ7DQo+IC0JdW5zaWduZWQg
bG9uZyBwc3ZfdGVtcDsNCj4gKwlzdHJ1Y3QgdGhlcm1hbF90cmlwIHRyaXBzW1BDSF9NQVhfVFJJ
UFNdOw0KPiAgCWJvb2wgYmlvc19lbmFibGVkOw0KPiAgfTsNCj4gIA0KPiBAQCAtMTAyLDMzICs5
OSwyMiBAQCBzdGF0aWMgdm9pZCBwY2hfd3B0X2FkZF9hY3BpX3Bzdl90cmlwKHN0cnVjdA0KPiBw
Y2hfdGhlcm1hbF9kZXZpY2UgKnB0ZCwNCj4gIAkJCQkgICAgICBpbnQgKm5yX3RyaXBzKQ0KPiAg
ew0KPiAgCXN0cnVjdCBhY3BpX2RldmljZSAqYWRldjsNCj4gLQ0KPiAtCXB0ZC0+cHN2X3RyaXBf
aWQgPSAtMTsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+ICAJYWRldiA9IEFDUElfQ09NUEFOSU9OKCZw
dGQtPnBkZXYtPmRldik7DQo+IC0JaWYgKGFkZXYpIHsNCj4gLQkJdW5zaWduZWQgbG9uZyBsb25n
IHI7DQo+IC0JCWFjcGlfc3RhdHVzIHN0YXR1czsNCj4gLQ0KPiAtCQlzdGF0dXMgPSBhY3BpX2V2
YWx1YXRlX2ludGVnZXIoYWRldi0+aGFuZGxlLCAiX1BTViIsDQo+IE5VTEwsDQo+IC0JCQkJCSAg
ICAgICAmcik7DQo+IC0JCWlmIChBQ1BJX1NVQ0NFU1Moc3RhdHVzKSkgew0KPiAtCQkJdW5zaWdu
ZWQgbG9uZyB0cmlwX3RlbXA7DQo+IC0NCj4gLQkJCXRyaXBfdGVtcCA9IGRlY2lfa2VsdmluX3Rv
X21pbGxpY2Vsc2l1cyhyKTsNCj4gLQkJCWlmICh0cmlwX3RlbXApIHsNCj4gLQkJCQlwdGQtPnBz
dl90ZW1wID0gdHJpcF90ZW1wOw0KPiAtCQkJCXB0ZC0+cHN2X3RyaXBfaWQgPSAqbnJfdHJpcHM7
DQo+IC0JCQkJKysoKm5yX3RyaXBzKTsNCj4gLQkJCX0NCj4gLQkJfQ0KPiAtCX0NCj4gKwlpZiAo
IWFkZXYpDQo+ICsJCXJldHVybjsNCj4gKwkJDQo+ICsJcmV0ID0gdGhlcm1hbF9hY3BpX3RyaXBf
cHN2KGFkZXYsICZwdGQtPnRyaXBzWypucl90cmlwc10pOw0KPiArCWlmIChyZXQpDQo+ICsJCXJl
dHVybjsNCj4gKw0KPiArCSsrKCpucl90cmlwcyk7DQo+ICB9DQo+ICAjZWxzZQ0KPiAgc3RhdGlj
IHZvaWQgcGNoX3dwdF9hZGRfYWNwaV9wc3ZfdHJpcChzdHJ1Y3QgcGNoX3RoZXJtYWxfZGV2aWNl
DQo+ICpwdGQsDQo+ICAJCQkJICAgICAgaW50ICpucl90cmlwcykNCj4gIHsNCj4gLQlwdGQtPnBz
dl90cmlwX2lkID0gLTE7DQo+ICANCj4gIH0NCj4gICNlbmRpZg0KPiBAQCAtMTYzLDIxICsxNDks
MTkgQEAgc3RhdGljIGludCBwY2hfd3B0X2luaXQoc3RydWN0DQo+IHBjaF90aGVybWFsX2Rldmlj
ZSAqcHRkLCBpbnQgKm5yX3RyaXBzKQ0KPiAgCX0NCj4gIA0KPiAgcmVhZF90cmlwczoNCj4gLQlw
dGQtPmNydF90cmlwX2lkID0gLTE7DQo+ICAJdHJpcF90ZW1wID0gcmVhZHcocHRkLT5od19iYXNl
ICsgV1BUX0NUVCk7DQo+ICAJdHJpcF90ZW1wICY9IDB4MUZGOw0KPiAgCWlmICh0cmlwX3RlbXAp
IHsNCj4gLQkJcHRkLT5jcnRfdGVtcCA9IEdFVF9XUFRfVEVNUCh0cmlwX3RlbXApOw0KPiAtCQlw
dGQtPmNydF90cmlwX2lkID0gMDsNCj4gKwkJcHRkLT50cmlwc1sqbnJfdHJpcHNdLnRlbXBlcmF0
dXJlID0NCj4gR0VUX1dQVF9URU1QKHRyaXBfdGVtcCk7DQo+ICsJCXB0ZC0+dHJpcHNbKm5yX3Ry
aXBzXS50eXBlID0gVEhFUk1BTF9UUklQX0NSSVRJQ0FMOw0KPiAgCQkrKygqbnJfdHJpcHMpOw0K
PiAgCX0NCj4gIA0KPiAtCXB0ZC0+aG90X3RyaXBfaWQgPSAtMTsNCj4gIAl0cmlwX3RlbXAgPSBy
ZWFkdyhwdGQtPmh3X2Jhc2UgKyBXUFRfUEhMKTsNCj4gIAl0cmlwX3RlbXAgJj0gMHgxRkY7DQo+
ICAJaWYgKHRyaXBfdGVtcCkgew0KPiAtCQlwdGQtPmhvdF90ZW1wID0gR0VUX1dQVF9URU1QKHRy
aXBfdGVtcCk7DQo+IC0JCXB0ZC0+aG90X3RyaXBfaWQgPSAqbnJfdHJpcHM7DQo+ICsJCXB0ZC0+
dHJpcHNbKm5yX3RyaXBzXS50ZW1wZXJhdHVyZSA9DQo+IEdFVF9XUFRfVEVNUCh0cmlwX3RlbXAp
Ow0KPiArCQlwdGQtPnRyaXBzWypucl90cmlwc10udHlwZSA9IFRIRVJNQUxfVFJJUF9IT1Q7DQo+
ICAJCSsrKCpucl90cmlwcyk7DQo+ICAJfQ0KPiAgDQo+IEBAIC0yOTgsMzkgKzI4Miw2IEBAIHN0
YXRpYyBpbnQgcGNoX3RoZXJtYWxfZ2V0X3RlbXAoc3RydWN0DQo+IHRoZXJtYWxfem9uZV9kZXZp
Y2UgKnR6ZCwgaW50ICp0ZW1wKQ0KPiAgCXJldHVybglwdGQtPm9wcy0+Z2V0X3RlbXAocHRkLCB0
ZW1wKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBwY2hfZ2V0X3RyaXBfdHlwZShzdHJ1Y3Qg
dGhlcm1hbF96b25lX2RldmljZSAqdHpkLCBpbnQNCj4gdHJpcCwNCj4gLQkJCSAgICAgZW51bSB0
aGVybWFsX3RyaXBfdHlwZSAqdHlwZSkNCj4gLXsNCj4gLQlzdHJ1Y3QgcGNoX3RoZXJtYWxfZGV2
aWNlICpwdGQgPSB0emQtPmRldmRhdGE7DQo+IC0NCj4gLQlpZiAocHRkLT5jcnRfdHJpcF9pZCA9
PSB0cmlwKQ0KPiAtCQkqdHlwZSA9IFRIRVJNQUxfVFJJUF9DUklUSUNBTDsNCj4gLQllbHNlIGlm
IChwdGQtPmhvdF90cmlwX2lkID09IHRyaXApDQo+IC0JCSp0eXBlID0gVEhFUk1BTF9UUklQX0hP
VDsNCj4gLQllbHNlIGlmIChwdGQtPnBzdl90cmlwX2lkID09IHRyaXApDQo+IC0JCSp0eXBlID0g
VEhFUk1BTF9UUklQX1BBU1NJVkU7DQo+IC0JZWxzZQ0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4g
LQ0KPiAtCXJldHVybiAwOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgaW50IHBjaF9nZXRfdHJpcF90
ZW1wKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0emQsIGludA0KPiB0cmlwLCBpbnQgKnRl
bXApDQo+IC17DQo+IC0Jc3RydWN0IHBjaF90aGVybWFsX2RldmljZSAqcHRkID0gdHpkLT5kZXZk
YXRhOw0KPiAtDQo+IC0JaWYgKHB0ZC0+Y3J0X3RyaXBfaWQgPT0gdHJpcCkNCj4gLQkJKnRlbXAg
PSBwdGQtPmNydF90ZW1wOw0KPiAtCWVsc2UgaWYgKHB0ZC0+aG90X3RyaXBfaWQgPT0gdHJpcCkN
Cj4gLQkJKnRlbXAgPSBwdGQtPmhvdF90ZW1wOw0KPiAtCWVsc2UgaWYgKHB0ZC0+cHN2X3RyaXBf
aWQgPT0gdHJpcCkNCj4gLQkJKnRlbXAgPSBwdGQtPnBzdl90ZW1wOw0KPiAtCWVsc2UNCj4gLQkJ
cmV0dXJuIC1FSU5WQUw7DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAgc3RhdGlj
IHZvaWQgcGNoX2NyaXRpY2FsKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0emQpDQo+ICB7
DQo+ICAJZGV2X2RiZygmdHpkLT5kZXZpY2UsICIlczogY3JpdGljYWwgdGVtcGVyYXR1cmUgcmVh
Y2hlZFxuIiwNCj4gdHpkLT50eXBlKTsNCj4gQEAgLTMzOCw4ICsyODksNiBAQCBzdGF0aWMgdm9p
ZCBwY2hfY3JpdGljYWwoc3RydWN0DQo+IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6ZCkNCj4gIA0K
PiAgc3RhdGljIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlX29wcyB0emRfb3BzID0gew0KPiAg
CS5nZXRfdGVtcCA9IHBjaF90aGVybWFsX2dldF90ZW1wLA0KPiAtCS5nZXRfdHJpcF90eXBlID0g
cGNoX2dldF90cmlwX3R5cGUsDQo+IC0JLmdldF90cmlwX3RlbXAgPSBwY2hfZ2V0X3RyaXBfdGVt
cCwNCj4gIAkuY3JpdGljYWwgPSBwY2hfY3JpdGljYWwsDQo+ICB9Ow0KPiAgDQo+IEBAIC00MjMs
OCArMzcyLDkgQEAgc3RhdGljIGludCBpbnRlbF9wY2hfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGNp
X2Rldg0KPiAqcGRldiwNCj4gIAlpZiAoZXJyKQ0KPiAgCQlnb3RvIGVycm9yX2NsZWFudXA7DQo+
ICANCj4gLQlwdGQtPnR6ZCA9IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVnaXN0ZXIoYmktPm5hbWUs
IG5yX3RyaXBzLCAwLA0KPiBwdGQsDQo+IC0JCQkJCQkmdHpkX29wcywgTlVMTCwgMCwgMCk7DQo+
ICsJcHRkLT50emQgPSB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJpcHMoYmkt
Pm5hbWUsDQo+IHB0ZC0+dHJpcHMsDQo+ICsJCQkJCQkJICAgbnJfdHJpcHMsIDAsDQo+IHB0ZCwN
Cj4gKwkJCQkJCQkgICAmdHpkX29wcywNCj4gTlVMTCwgMCwgMCk7DQo+ICAJaWYgKElTX0VSUihw
dGQtPnR6ZCkpIHsNCj4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVy
IHRoZXJtYWwgem9uZQ0KPiAlc1xuIiwNCj4gIAkJCWJpLT5uYW1lKTsNCg==
