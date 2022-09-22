Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE79D5E5B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiIVF6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIVF6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:58:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D688AB443B;
        Wed, 21 Sep 2022 22:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663826300; x=1695362300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Ro9BhU2f+G7AhbrWEpdq4f1CIuFTivh384gJ70aoqM=;
  b=DQyjP9589FzeX/XYop+6Y2F4XNQ7r9NMZjkmdRMIHs0GbJifT22ofWFO
   dtgpm1d/v8/EhoROD8S6cY0gtc960X3C4GU20PeGEm1q86WGd6HNAQaO1
   uVtPrSS0mQUPhTXNjY2QmxWwyj7L/sghDSxhcLQ7bauEIqk2uYxW0xypL
   4BCD5dGwtaYAWvwL1G55Yp5uLX5+ap8swUUQiy9Idj291jxQ7wGTeYcGS
   IqwABzSoWZr+U+zUEpKTHutiizrgGmvuvBmakARA9oLq38nOhrdin8BAU
   l4Mk1ddCdnurSshBnN9eeLmnX2fqkYCAYlzgU9Mh4dOivIs8MZgyj/ol3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301051417"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301051417"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 22:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="597295727"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2022 22:58:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 22:58:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 22:58:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 22:58:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 22:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RueTtFyT3SDiTlRkq9RYsdSMvZzREU2sN6gDLHx8E/M2FaHzr8wH4CgH9qhNazK1ajLTcNo5pwdL/UcUmUd4xDMqp1qeBM6ZtP67nkrE8Dd1iEwVGQpTd20SYRS6DeHRJVqSer42vC+k0SI3oE0frNNdHUed+w4bBkOiAvzCHsSUPM+a9gToiX8a073L06X+bF3ekjN2Ct39zC5MBCA3oVwEchCUdFB+ww3wlbzL1wt95dz6ZGLlB0YIJlZHL+ktTh+cR7s8OdoWfURIqW/y+FGwbANSELbNZpqUzkRKUYfGrs1eK/FyTInBMgZTQu90jE5WorReyyg1luxkKPw6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ro9BhU2f+G7AhbrWEpdq4f1CIuFTivh384gJ70aoqM=;
 b=hI0oM8AdyldZlk1/AY4wFwCYz+OTAi3knvxxEK+60NBwAp36ETAKRGwDVKbHTEYPIB124xsrEkFKRFNM0JVwNb3jdppPoZlhPVCFC6+uoFJ2NSmdL1s9aoxlgWAbgIKjztPfk6tvoH5OxhErsUrE2q/vhyLRo09O0H+CojMwZKcLV1j1cFuckeQHLFxToxXrhVrhm/jcE7uOSz5MwlyjYKwbOGbqDTniu6rtCa3H9PBZjLGa2OXioshWLifW5gsC93CQy2/pFModsR6Alfo/NG2HHfc2oiHysNlWdqAFKAnEGgkfVaYNRZVYDxhqDKwXHZn7wLpXdsjH48ngcTVUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 22 Sep
 2022 05:58:16 +0000
Received: from IA1PR11MB6218.namprd11.prod.outlook.com
 ([fe80::31e2:9f90:e4ad:3370]) by IA1PR11MB6218.namprd11.prod.outlook.com
 ([fe80::31e2:9f90:e4ad:3370%7]) with mapi id 15.20.5588.018; Thu, 22 Sep 2022
 05:58:15 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Krogerus, Heikki" <heikki.krogerus@intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH 0/2] Update the PCIe device ID's for USB device
 controllers on Alder Lake platforms
Thread-Topic: [PATCH 0/2] Update the PCIe device ID's for USB device
 controllers on Alder Lake platforms
Thread-Index: AQHYxzUhBoqp8j9iYUerUCsgv6REJ63rAhKw
Date:   Thu, 22 Sep 2022 05:58:15 +0000
Message-ID: <IA1PR11MB621864E69E4782427A5C4816F14E9@IA1PR11MB6218.namprd11.prod.outlook.com>
References: <20220913055316.23050-1-shruthi.sanil@intel.com>
In-Reply-To: <20220913055316.23050-1-shruthi.sanil@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d67f695-f6bd-44ce-8374-08da9c5f70ce
x-ms-traffictypediagnostic: CY5PR11MB6090:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLHVUhScyFVt8wlXv0v87/pWvZjoaX5koKYYxxYN8vNcegvOe/MxuoyO/qJsdChXuQN/5qAd0DdVKpZ/vFkQgFOjlgadGcjR/3E4ouDDAisgh4D1xAkjwUc+Kg8mx5MXHhEfwsjm9wJBzG4Z2lSRtLLaOnwTdSlCG514Dwl0uWUbpXwDng47iMZM85NUAJfg4ejvmgBFQpoU96HJL7Rk7rE4iROGRi9m7576rr6UuhnFDbvXOqTqgCcKTBYzYtvuexzsdOc9zXd/XvbtxOBvloNpRp5bNFhHzACmE5Zo5er8xZHWQJrsvlSwQD4OLFgcRARbap9GW4O1d0wTlOAbQApqM6YLWQgrSVrZo2isKCX2FVa7DB7OcPea8+CqzVJ1Idtvlobvqm5O6clX8tguLwCOpo4/NSFnAUFhAN8MW3KP0RFQKFpbg6l1ghAoM7nzlHlhc2alKQKp94Gver5BJir4yNy9DnZJUyqt7l9yyp7YBRI6D17YE4t/6rjA1m52uamtdQFNKi1HT/95ISn8GVAA0ERsRZaovdk+G37UsCPX/ncdO888kukIRl/8TwvYJcbPsliTiq9P9Pzj7aO6NCu0pFeC4SbMnGe0yI1dFR9fAsvaANROTd0X3llml+EX3sqTF3uNVW3pFZAEyXk4tclDM/KyWaFbkSvvBF6BFn+DaFXyeUdFSQChprxhRsx/joblAnMG+DEX7+TrbUR0ZSwgavFOv76zHxN9fLC2JrfMNHzHfTn5JIj21i/Oz+OS6QeaN/toIjk/ukLPaqPpTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(38070700005)(52536014)(122000001)(71200400001)(66946007)(8676002)(66476007)(66446008)(4326008)(82960400001)(5660300002)(478600001)(26005)(55016003)(33656002)(64756008)(38100700002)(66556008)(41300700001)(8936002)(9686003)(186003)(53546011)(107886003)(76116006)(6506007)(110136005)(316002)(54906003)(7696005)(2906002)(15650500001)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXhyYVFPNVgwalVyTVkyMGZJVzY4ZG1GT0QxT2EydVlwTmRnODA4cWRXTkVx?=
 =?utf-8?B?TTg4TE83cnM1UUw3T2hTdjYwQWpSdXQ2ejRCMi9EKzI3MnJ0ditJSlFVOEdF?=
 =?utf-8?B?dnNDRnhMSEh5RXo3UWc2TXpDYW9IZFhQdWhEZlRZN2hBTGFLT1Z3bUZ3RVFu?=
 =?utf-8?B?c3pZNmpyam9QcWU3QXAzd0JDc1pXNTR6dDQ3RXZFU3k2eGlwelZWZ1ZZbWxi?=
 =?utf-8?B?N0k0d0FxQlhya09SN29HOWpub0w4MGdKSnpwZ3hBZmYyRzkxQ3plV2YrRmti?=
 =?utf-8?B?dE0xRGlOVVNoQWd6Q2NvSFFhZVNyRlZBS3Jrb2xGdzNpeTExTUtZN2xlSElN?=
 =?utf-8?B?NHlNa2QwT3p4TUVHVS9TYjEva0hCaVRINUUzSVY5TlFPeHpmcHZZVXV5Vkpy?=
 =?utf-8?B?b2RMMDdVS1BhYitIWVBIdy9aZ2tLTUFvTGJGSWJWL29vbGtWclIxbHlodGU0?=
 =?utf-8?B?OUg2QXh0VC9YM0JHbXVOMnAvMnd0Umg0QndIL1VFYkUzTGwyaFMyOTE2T21v?=
 =?utf-8?B?Q0FlUTgreGs4VnVoMVhpakxWYU1GbVQzOU9QSzBMU202ME1lcVp2b3BaQ3FI?=
 =?utf-8?B?cThNVTliSWxTaGlUUDRsNHovSFFKbVlpNkZqL1AxM3R4ZHZBeExROHh1ditp?=
 =?utf-8?B?eWE1cWtTMnJSdm15R0IzL3FXbXZaZkxrTEtmdTlVWWNrUzExNlV5cVdOYzhu?=
 =?utf-8?B?NnpVWGdWVjJwb2lFRTJFSEowMDNueTd0QkRpOVFOT1hwZGI5amVaN3JvVFo4?=
 =?utf-8?B?dU50elBEdVhNYUIzNE1udWR1czREdFlvd0ZvamM3VVNPOWgrVW1lMVIyM0pm?=
 =?utf-8?B?a3RZa21Xc2Z0a29UKzY5cjQ0c1NkQm5hUjdHZXBCeCtKamJWVGNtRUFQY0lY?=
 =?utf-8?B?RTNpVEkrYm9wcVoyN2pMU0kybzBYV3NiM3B5WnNNeFpNOVNnbFljRHlIdzg5?=
 =?utf-8?B?YTlsanM0eVdtbTNyNTlHekhrL2NVdVlpb2lyVkx4aGR0MUQvOGVpb3FlRlBy?=
 =?utf-8?B?ZVZDR2lKamJoNGs3bGljc0FlMXZqR3MwNUc3UjM5M2NFSzQwQXZrV1EyVjZ2?=
 =?utf-8?B?ZTV5bFUyWlRqS05CTnVDV2pzTzU2NGZtVGhuUlM1aEpncGpYVlRVd28rQkFz?=
 =?utf-8?B?RUZaZTluVVJLa2h0REFScVFTYS8zeHJaUDVGNE1sS1pKUjJzNldPc0x6U2FQ?=
 =?utf-8?B?VEpVVXJUK09NejFJd0xqSmVpc3NWdVQrNnZuaGRTMjFUOU1NSlZZcnNpN0t0?=
 =?utf-8?B?aXdJcVdDSUdQb29LMENTWkFkamUxZWxSOU9xQ1U0enVqOW1TKzlFSlhaTHpD?=
 =?utf-8?B?M09ZNUNTVGVheWgrUWNqdUYrcjNIamcrTDhEZVNzb2tNN1J6dmlDU1VzSk9S?=
 =?utf-8?B?UUVjcGtiUm9Da3lVbGxCYmZXbWVnZXBncFp0Z1JMbUdEMGJIa0FZN2NKWE5y?=
 =?utf-8?B?VHNyUzBuZFRjK3BJMFMwOUpWblJha1FQb0RWakY1NWVXVWdZaFk5UFdMZzFi?=
 =?utf-8?B?UlVuMytzWlBRS0F5elVockpjUkY3MTFKK0x0bUliQUcvR1hnRGZXa0g0MnBO?=
 =?utf-8?B?b0hTMWtRalI3R2svbm5pWGxrMHlwVk1XOVN6TFUvUTNrV1ZyVXFuZUxUL01J?=
 =?utf-8?B?NEZyekZxaWRpeDZPL2tNRHF4SUJBWTRqL3VNa1pXcVJOR04vTzlDVExpTHNO?=
 =?utf-8?B?L0lBVEFUeVVtbDJUM0p2aDcrVi9VbFh4aEw5NmRBdVc2ZGhzZUU0TWNWUzI5?=
 =?utf-8?B?UlZDcE1Qb082d2N5ZDBGTXFtY2lZdTl4ZW5UY2x3L3M4MnFiTFNJYjdCblVh?=
 =?utf-8?B?OXYzL0tQanVQQjZESjVFYmZGWXVpeXNXTm11Y1NxZ1ZNVCtvTW50NDFPUjhB?=
 =?utf-8?B?QmpNRVQxcVpvUjg4Wkl0ekxITGdHY3hNVWJSY245Q0dmWkVrSGR4OC9Fb09v?=
 =?utf-8?B?MzFMVStoTWpOQ2xvWk5HY01tVWlyaHp5L1BNK3M3VlFKVkxDdzlnNGpscy91?=
 =?utf-8?B?RVcxbnkydzNHcDI4R3BWUnhvZy9iaEl3QlVDbWFuS2hkK2JEM1VDN2lPLzk0?=
 =?utf-8?B?RndhODF3d293Wk5oSFVMUXRackF6R1pSL0FFay96TG50NlZNK21SYmxWTjht?=
 =?utf-8?Q?cI4SXkf2tkefnLLewwJzyIMUo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6218.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d67f695-f6bd-44ce-8374-08da9c5f70ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 05:58:15.4286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJmCkPqJdfvrLW5mOM0+h/nEP3Bm1jtwU3emTDrlQAmu7hUKBQ5DY7+qBJ02qGRC7G3LBF4Ci40Ai18/25OQpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
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

R2VudGxlIFJlbWluZGVyISDwn5iKDQoNCg0KUmVnYXJkcywNClNocnV0aGkNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYW5pbCwgU2hydXRoaSA8c2hydXRoaS5zYW5p
bEBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxMywgMjAyMiAxMToyMyBB
TQ0KPiBUbzogYmFsYmlAa2VybmVsLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxp
bnV4LQ0KPiB1c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBLcm9nZXJ1cywgSGVpa2tpIDxoZWlra2kua3JvZ2VydXNAaW50ZWwuY29tPjsgVGhv
a2FsYSwgU3Jpa2FudGgNCj4gPHNyaWthbnRoLnRob2thbGFAaW50ZWwuY29tPjsgU2FuZ2FubmF2
YXIsIE1hbGxpa2FyanVuYXBwYQ0KPiA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVs
LmNvbT47IFNhbmlsLCBTaHJ1dGhpDQo+IDxzaHJ1dGhpLnNhbmlsQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIDAvMl0gVXBkYXRlIHRoZSBQQ0llIGRldmljZSBJRCdzIGZvciBVU0IgZGV2
aWNlIGNvbnRyb2xsZXJzDQo+IG9uIEFsZGVyIExha2UgcGxhdGZvcm1zDQo+IA0KPiBGcm9tOiBT
aHJ1dGhpIFNhbmlsIDxzaHJ1dGhpLnNhbmlsQGludGVsLmNvbT4NCj4gDQo+IEFsZGVyIExha2Ug
aGFzIHNwbGl0IGRpZSBhcmNoaXRlY3R1cmUgZm9yIHRoZSBVU0IgZGV2aWNlIGNvbnRyb2xsZXJz
Lg0KPiBUaGUgVVNCMiBjb250cm9sbGVyIHJlc2lkZXMgaW4gdGhlIFBDSCBzdWIgc3lzdGVtIGFu
ZCB0aGUgVVNCMyBjb250cm9sbGVyDQo+IHJlc2lkZXMgaW4gdGhlIENQVSBzdWIgc3lzdGVtLiBI
ZW5jZSB3ZSBuZWVkIHRvIHVwZGF0ZSBib3RoIHRoZSBkZXZpY2UgSUQncw0KPiBmb3IgdGhlIGRl
dmljZSB0byBiZSBlbnVtZXJhdGVkIGNvcnJlY3RseS4NCj4gDQo+IFNocnV0aGkgU2FuaWwgKDIp
Og0KPiAgIHVzYjogZHdjMzogcGNpOiBVcGRhdGUgdGhlIG1hY3JvIG5hbWVzIGZvciBVU0IgUENJ
ZSBkZXZpY2UgSUQncyBmb3INCj4gICAgIEFsZGVyIExha2UgcGxhdGZvcm1zDQo+ICAgdXNiOiBk
d2MzOiBwY2k6IEFkZCBQQ0llIGRldmljZSBJRCBmb3IgVVNCMyBjb250cm9sbGVyIG9uIENQVQ0K
PiAgICAgc3ViLXN5c3RlbSBmb3IgQWxkZXIgTGFrZSBQDQo+IA0KPiAgZHJpdmVycy91c2IvZHdj
My9kd2MzLXBjaS5jIHwgMTQgKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IGU4Mzlh
NzU2MDEyYjZjYWQ3YTRlZWI2N2IwNTk4YWMzZjM0OWY4NjMNCj4gLS0NCj4gMi4xNy4xDQoNCg==
