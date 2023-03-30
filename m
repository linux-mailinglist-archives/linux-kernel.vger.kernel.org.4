Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97146D0056
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjC3J5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3J5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:57:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CEF6E91
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680170251; x=1711706251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7TKdEjR3Zex1LUxVNpCQnuKfNlNN3VoC/vyoFSJeV/k=;
  b=BmHcH3RfBd9PHw+RTaELn3c3yNWpZSivSh970Gwsqu3/Awhn4l3k+0u5
   5z8UHCHkWNmt3UsjbHdESqhiBg0ihm/KRf3AGqRvSgUBWhv0ZYrhr2cjR
   35YzF5La4lZcIcFe8w6fxFm1/xLP1iEgb/4Zn5h31jAQXABTgzpxUa+bD
   X0LXO6Scpkq3j9W2kaG40iLwQ9Se+fgYSHSxuGal3jphOh5Cw92N66BuF
   8G28Y9U2t7+1cUdw3dJ7vv2qsB3KaB2Vw95w7f6N1Jd+xt+SCSezRt3lH
   RyMYfIBfuxkbHPxurM4g5ClCjJ2ibYcgQB23UZKFlW1wZ8Q2zYvPIxbXS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="325047176"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="325047176"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 02:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687184748"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="687184748"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 30 Mar 2023 02:57:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 02:57:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 02:57:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 02:57:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 02:57:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw3ojWwTK6YHJaxnNrpUxQO5LTBYi/F9cHc832qPBNcCSV+/Mrc6wtV4CLNAemzrZoFS1AG70b0CGLl8RzDhHueGEBf79Dalvm60vlFQR4cgiWkYVfqtYkCYSSyv9+GBFaVrEp5XbeHPY6w9SKkT9rTCyhMhpRMfruuQcwbFpny/ZBc5ZKNNpKb5dF5obel5OKfMN2MLoc3CvyO5onMC9H6APrOYVyBZQE8FFuOW5qIDwhnN1Nyk66L1utcCiCJz2aQzcB/AW8ScNl3ias1TGPzzJslrD7WvTF0/Oj948zgjHNtvFK6qUrQsLxXKkeVECMWK2cSXFZfQnWOoG+dM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TKdEjR3Zex1LUxVNpCQnuKfNlNN3VoC/vyoFSJeV/k=;
 b=Xz+tClBSanu/bEdHt8DZ0zFoyBX93jp4yEp9buBYP6DOzbp0iLqL4dKtWkQBLkgOZxxImgEDkzugA3w3lUIyupw9kjhRHZWnzphV/eA6fZ9sjxtvvdorugJ+rg1/uckzpsqOGt4kChc7KqV27L+XtR+L4j1QEv1gg6qn7lZhGQwa3pi3MBsUvGBJRks+Vi6UhBA0nl+NoxMHb3U4+eqXlh21Q3+auSI8vvpxEGMCvuapVJaZAHrc7JrndsbK+I8RqNoujf66gye1zOR7PBFSQBC9pHq6ZaJ9WkBd6I9eCQ+SDt/SYBtpujZ4JiU9a4RMofVmJRTLuH+nb7KNsIiE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 09:57:26 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 09:57:26 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG v6.3-rc4+] WARNING: CPU: 0 PID: 1 at
 drivers/thermal/thermal_sysfs.c:879 cooling_device_stats_setup+0xac/0xc0
Thread-Topic: [BUG v6.3-rc4+] WARNING: CPU: 0 PID: 1 at
 drivers/thermal/thermal_sysfs.c:879 cooling_device_stats_setup+0xac/0xc0
Thread-Index: AQHZYoE+LdFAnhbylEauIlrDwFO/fK8SXWGAgAC5qgA=
Date:   Thu, 30 Mar 2023 09:57:26 +0000
Message-ID: <22cab1d16c75cf07e0846a136c355615bc9b05dd.camel@intel.com>
References: <20230329165819.50ce6ab1@gandalf.local.home>
         <CAHk-=wiEdcjdceNdfVGPEcbSmAKh_rjtBSy5_Z3Yyx2GFEgLFA@mail.gmail.com>
In-Reply-To: <CAHk-=wiEdcjdceNdfVGPEcbSmAKh_rjtBSy5_Z3Yyx2GFEgLFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH8PR11MB8064:EE_
x-ms-office365-filtering-correlation-id: 3fb2e0f2-18f7-4972-a5cd-08db31052aab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvJLXf7cRNz3+A6raYQH7oGyrGp3+7Dg660yZ0M4ge2TTLnr+5NpuLwkQEG5m8pNlZacTGN8/suS0m+ifSxxVLsgQmpvrJYu645aEeKZae+NWt8wttGpMScEPyBt3TtQrVK5BHfLCTsAHo9z9IbDqXZG9htN+5BQZyWZoTIw7Oe4AvzXFbrbe+Z1TfxHBNFDF4Aa+aDIXvWQnlhyR4Y6rUy0ZzDI+xpD2ylrxiBmRGREuiOOMFw48nt5H+PssW2lcpqgEQ6oqXKGYYewzYSEbMqqOxqkmg7ekGtoBgA9YtRSnA0Qi4jFRTn9G3lzrNI6QOqY82bs2xPYegAD3jJ5UbYKSHDgxkXfPQnTFsQRP6d5AeCtLKeUtkbUEaWYpvjt5OgfkOXaNfUUvM9pw+N+GK9iwgUJ4ZUEOIo93Kz596yeRF38/Km9pnTJNFnC6Zc918G8jco9a6ubV4fOg0Bm29BPiRkoehhFQSZ5KZrPZIJc06QqZjSYe8mfGDfZK0bEelvEcSuukHiQyYfo6/+zR/qpSPe5GEDPfkFI6dV/WUKdyQS5MYOZ7ouPB5vKIUQ3LIMFVGcIXibkFckDcdR8Pfe9HwCnuZuHMcdWhc0YEMJTc9u+0qw3yU+dsVBCeTGr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(2616005)(53546011)(110136005)(316002)(54906003)(83380400001)(6512007)(186003)(6506007)(6486002)(71200400001)(26005)(8676002)(122000001)(38100700002)(36756003)(86362001)(478600001)(8936002)(38070700005)(5660300002)(91956017)(76116006)(82960400001)(66946007)(64756008)(66446008)(4326008)(66556008)(41300700001)(66476007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3I5Yi9wVUhaa2lDUWVwdTNkMEdYWE5haUdpQ2JNMUJyNWpmQXhYQ1UvWjdJ?=
 =?utf-8?B?aFBEbkZKNmdaMXlZOVFjTWNHS3JleWpjK016aVE1ak0vY04wQ21RRVhhMzY5?=
 =?utf-8?B?YWRCbmNDQXQ5VndCYmdmbmpnbVJVUWtyNnhGK0c5clZ2Nm8rVzV1dnBCYnlV?=
 =?utf-8?B?d1B6Y1Zld00vTmg2QTJ0cGVoaUNQaDltTTNVZUlidEdGclBwRDNBelBVN0sv?=
 =?utf-8?B?OWROcDh5bzY4K245d256NHh0T1E1VmM4NU5MNUl3VGtJQWpkY1lKK3dQWWQr?=
 =?utf-8?B?d1VDSjlReW4reGJWdGhxUnRmSDJBSUNJaXUrclN4M1A1cFVqRWlMNEV0L1Ay?=
 =?utf-8?B?SGFtbkQxNk1nWDYwNDRNdWxGMW9DYmp0NVE3SUJ0UlpMQXJkWmsxVVY0S25V?=
 =?utf-8?B?N2FmN2laT0JpckhTa0tTR0lZTk11WFlNbGgwcE12WFUvbTgrYmU0RjJXdWRU?=
 =?utf-8?B?SXlYenh4RkZ6MS9FN2gySkJWSEh0M1hxR05hdmV2RGFEYjBCM2xERWdEcGVK?=
 =?utf-8?B?K3RuSmVWRFdyeUNmQ251NmVoZTFheWF6YmRWS2E5TllvUmJBalBHM1p6UjAr?=
 =?utf-8?B?empQVE9CTmFoYTlnWm5vTWQrdWFrSDZzbU1JVkRISXlQdkdDSUtTUUVmWlk2?=
 =?utf-8?B?OGI4RlVDeDAzeW84NnNVd3JuenlVN3FpMFpKT3ZYdUZoQWtTZjBLQkRzNVkx?=
 =?utf-8?B?c0dUNjNraDFIT0hqM0Y0VFRERlJmSi9tc1ZtRGNhUHZydTVtWHVqMS8xL1hm?=
 =?utf-8?B?VkZiYmtwZ2I3a2RabUkvOVRzK2gzWFRhOVhnWTdaUGVqT3BLdFZwenJ3WjFJ?=
 =?utf-8?B?YjQvRkphRlVkcEMrTjlHcU90VGpiYmEwdGJMZGVJbWtXOUdVZitnOVZrVFhz?=
 =?utf-8?B?U05mUVVCOFFtT05WQ0FhVlRqWG5TNVg1am5XY1Ard2ptbVZtSkM4U1JnR2Zt?=
 =?utf-8?B?NW1lbWlqbUFSTzFuVUJpUXE4bGtoc3ZnNENmMnk3bjBPMkl1Q2dYU3pzYUw2?=
 =?utf-8?B?amNMME1oRExlN1RqbmVJY0pzbEQ5b1lGQTFIUDZuTjJ3QmxxTCtrUVVScUVU?=
 =?utf-8?B?ZnZEdjlPcHM3dm5MRFMrVVdIRWwwbWxQNnI1endEMGpSSFpPYUNkTk93dVFT?=
 =?utf-8?B?Z2J1N1ozU2lKdlh4bVpBYjBaaFh3OVhRMktuUEdCR0RRRGZwSTkwZ3p5YzB0?=
 =?utf-8?B?cUppbWpQQUF4M0JPUkhDL2MrblVSamV4eklobVFHaVpSMGcyM2ovckxOcTE2?=
 =?utf-8?B?TG5XSGJtQWYrZTlpQ0hlSndqNnh4ZkE4N0JCZVU0NlJnSU9pV3liTWEzY3hv?=
 =?utf-8?B?SEIrY1FZSjZ0L0laYUhxNzJMNkJWajlheDU3SGt6cDd1c1VCS3Q1MG15dmVQ?=
 =?utf-8?B?Uk1GSERUSzFjU0Rzc0pmL0Z3U29uc2J5YnJGWTNhSmMrcGU3NVcyUHViV2lx?=
 =?utf-8?B?MHFlQW5zWERxT2pUTW0xTXRsZVZ4RWtwTnBuR0xkSUNvajB1RU1IS3Z6Tlkx?=
 =?utf-8?B?THBuQ1J6S0MrZW9qS2RNa0V3aDk5NXRVd2hCZUtDVURTcHVnWlNoSDFVd1dF?=
 =?utf-8?B?bUlaM0I1RjFQSWIyK3JjSU9DOG5vRDJjTGpneXBLU0ZzZ3lYTEIxOC9GTzRQ?=
 =?utf-8?B?ZmpGL3R2OXVXWW52K2lyUk1LYlpXZTNjNmNjZG5LQUhlZ05oWkRlVmM5azRT?=
 =?utf-8?B?NDJEOEQ3MlJ0WWpEYWNxcnpBN2tHR0plVkl0cFoyNTlVTkI4c1ZEQ1M1L1Rt?=
 =?utf-8?B?djd3M0FjOWRvU0VnR29iM1hKeEtEeGVLMzBXaXk3d1BFWFl3dmRoeEFLOW9p?=
 =?utf-8?B?MUFQZjRKa1U5eWpLdVN3eWNaRzZkNllKZGo2NDgyenhReDlGQXRseTR1SXRu?=
 =?utf-8?B?N284cmRRR3h2V3d3M244Q21MMk9JL1Z1UUt2bTZRSS9XSnRCWEJUcjNXa29Y?=
 =?utf-8?B?dWJwK1lTZVRLdGhPQlNQem1FbzlKaUx2bDVXYytONmpqSlFaQmJxTXJPTmlQ?=
 =?utf-8?B?UG8vbUNaNkhRbG40bnl4VWdYRXlhMGxLNWV1Rmg1WTJXcGZCR21jc2N1cDlC?=
 =?utf-8?B?N216dzdQZGM1Rm92djdTOXQ0UW1TOG81TFpZeWVpU0liNklha2hYRk5DTlVV?=
 =?utf-8?B?N3VsU0FBc0grUUVlT3lXRWVPYzNEUXRSM1hOenR4TTQ2elFseUxpSkRoOHVG?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE4F9FECCA847C4BB01C1063A9B602B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb2e0f2-18f7-4972-a5cd-08db31052aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 09:57:26.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6ubQziz/diaaVCrwt9wDQyNUkVDrRnOyzEFoXngbyDGha/QkyEzTtX6+714PLE1m4hOitv/gEGgIaMxXioJpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExpbnVzLA0KDQpPbiBXZWQsIDIwMjMtMDMtMjkgYXQgMTU6NTIgLTA3MDAsIExpbnVzIFRv
cnZhbGRzIHdyb3RlOg0KPiBPbiBXZWQsIE1hciAyOSwgMjAyMyBhdCAxOjU44oCvUE0gU3RldmVu
IFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+IHdyb3RlOg0KPiA+IEluIHByZXBhcmF0
aW9uIHRvIGFkZGluZyBteSBwYXRjaCB0aGF0IGNoZWNrcyBmb3Igc29tZSBraW5kcyBvZg0KPiA+
IGJ1Z3MgaW4NCj4gPiB0cmFjZSBldmVudHMsIEkgZGVjaWRlZCB0byBydW4gaXQgb24gdGhlIExp
bnVzJ3MgbGF0ZXN0IGJyYW5jaCwgdG8NCj4gPiBzZWUgaWYNCj4gPiB0aGVyZSdzIGFueSBvdGhl
ciB0cmFjZSBldmVudHMgdGhhdCBtYXkgY2F1c2UgaXNzdWVzLiBCdXQgaW5zdGVhZCBJDQo+ID4g
aGl0DQo+ID4gdGhpcyB1bnJlbGF0ZWQgYnVnLiBMb29rcyB0byBiZSB0cmlnZ2VyaW5nIGFuIGFk
ZGVkDQo+ID4gbG9ja2RlcF9hc3NlcnQoKSBvbg0KPiA+IGJvb3QgdXAuDQo+IA0KPiBTbyBJIHRo
aW5rIHRoYXQgbG9ja2RlcCBhc3NlcnQgaXMgbGlrZWx5IGJvZ3VzLg0KPiANCj4gSXQgd2FzIGFk
ZGVkIGluIGNvbW1pdCA3OTA5MzBmNDQyODkgKCJ0aGVybWFsOiBjb3JlOiBJbnRyb2R1Y2UNCj4g
dGhlcm1hbF9jb29saW5nX2RldmljZV91cGRhdGUoKSIpIGJ1dCB0aGUgcmVhc29uIEkgc2F5IGl0
J3MgYm9ndXMgaXMNCj4gdGhhdCBJIGRvbid0IHRoaW5rIGl0IGhhcyBldmVyIGJlZW4gdGVzdGVk
Og0KPiANCj4gPiBzdGF0aWMgdm9pZCBjb29saW5nX2RldmljZV9zdGF0c19zZXR1cChzdHJ1Y3QN
Cj4gPiB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2KQ0KPiA+IHsNCj4gPiAgICAgICAgIGxv
Y2tkZXBfYXNzZXJ0X2hlbGQoJmNkZXYtPmxvY2spOyA8PDwtLS0tIGxpbmUgODc5DQo+IA0KPiBZ
ZWFoLCBzbyBjb29saW5nX2RldmljZV9zdGF0c19zZXR1cCgpIGlzIGNhbGxlZCBmcm9tIHR3byBw
bGFjZXM6DQo+IA0KPiAgLSB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3NldHVwX3N5c2ZzKCkNCj4g
DQo+ICAtIHRoZXJtYWxfY29vbGluZ19kZXZpY2Vfc3RhdHNfcmVpbml0KCkNCj4gDQo+IGFuZCB0
aGF0IGZpcnN0IHBsYWNlIGlzIHdoZW4gdGhhdCBjZGV2IGlzIGNyZWF0ZWQsIGJlZm9yZSBpdCdz
DQo+IHJlZ2lzdGVyZWQgYW55d2hlcmUuIEl0J3Mgbm90IGxvY2tlZCBpbiB0aGF0IGNhc2UsIGFu
ZCB5ZXMsIHRoZQ0KPiBsb2NrZGVwX2Fzc2VydF9oZWxkKCkgd2lsbCB0cmlnZ2VyLg0KPiANCj4g
QXMgZmFyIGFzIEkgY2FuIHRlbGwgaXQgd2lsbCBhbHdheXMgdHJpZ2dlciwgYW5kIHRoaXMNCj4g
bG9ja2RlcF9hc3NlcnQoKQ0KPiBoYXMgdGh1cyBuZXZlciBiZWVuIHRlc3RlZCB3aXRoIGxvY2tk
ZXAgZW5hYmxlZC4NCj4gDQo+IFRoZSAic3RhdHNfcmVpbml0IiBjYXNlIHNlZW1zIHRvIGFsc28g
YmUgY2FsbGVkIGZyb20gb25seSBvbmUgcGxhY2UNCj4gKHRoZXJtYWxfY29vbGluZ19kZXZpY2Vf
dXBkYXRlKCkpLCBhbmQgdGhhdCBwYXRoIGRvZXMgaW5kZWVkIGhvbGQgdGhlDQo+IGNkZXYtPmxv
Y2suDQo+IA0KPiBUaGF0IGxvY2tkZXAgY291bGQgYmUgbWFkZSBoYXBweSBieSBoYXZpbmcNCj4g
dGhlcm1hbF9jb29saW5nX2RldmljZV9zZXR1cF9zeXNmcygpIGNyZWF0ZSB0aGF0IGRldmljZSB3
aXRoIHRoZSBjZGV2DQo+IGxvY2sgaGVsZC4gSSBndWVzcyB0aGF0J3MgZWFzeSBlbm91Z2gsIGFs
dGhvdWdoIHNvbWV3aGF0IGFubm95aW5nbHkNCj4gdGhlcmUgaXMgbm8gIm11dGV4X2luaXRfbG9j
a2VkKCkiLCB5b3UgaGF2ZSB0byBhY3R1YWxseSBkbw0KPiAibXV0ZXhfaW5pdCgpIiBmb2xsb3dl
ZCBieSBhICJtdXRleF9sb2NrKCkiLiBBbmQgb2J2aW91c2x5IHVubG9jayBpdA0KPiBhZnRlciBk
b2luZyB0aGUgc2V0dXBfc3lzZnMoKS4NCj4gDQo+IEJ1dCBJIHF1ZXN0aW9uIHdoZXRoZXIgdGhl
IGxvY2tkZXAgdGVzdCBzaG91bGQgYmUgZG9uZSBhdCBhbGwuIEkgZmluZA0KPiBpdCBkaXN0YXN0
ZWZ1bCB0aGF0IGl0IHdhcyBhZGRlZCB3aXRoIGFic29sdXRlbHkgemVybyB0ZXN0aW5nLg0KPiAN
Cj4gDQpJIGp1c3QgcmVhbGl6ZWQgd2h5IEkgY2Fubm90IHJlcHJvZHVjZSB0aGlzIHByb2JsZW0g
b24gbXkgdGVzdGJveC4NCg0KSW4gb3JkZXIgdG8gdGVzdCB0aGUgb3JpZ2luYWwgcGF0Y2ggd2l0
aCBBQ1BJIHBhc3NpdmUgY29vbGluZyBlbmFibGVkLA0KSSByZWJ1aWxkIHRoZSBrZXJuZWwgd2l0
aCBjdXN0b21pemVkIERTRFQuDQpUaGlzIHRhaW50cyB0aGUga2VybmVsLCBhbmQgY2xlYXJzIHRo
ZSBkZWJ1Z19sb2NrcywgdGh1cyBJIGRpZG4ndCBnZXQNCmFueSBsb2NrZGVwIHdhcm5pbmdzLi4u
DQoNCnRoYW5rcywNCnJ1aQ0K
