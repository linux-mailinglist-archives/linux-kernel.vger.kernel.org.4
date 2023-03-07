Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6A36AF777
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCGVXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjCGVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:23:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B2360BE;
        Tue,  7 Mar 2023 13:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678224186; x=1709760186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vI4sFYkk8stAr3FvYzTukMmoDwenXelm2/4/Q/YQOvk=;
  b=ErCzVBXl6PkF2W0LO4j/NojNXXznStcRz3hjyzRNvel0/S8Uf5lzQJsE
   E1UZ+KyIOqEvtRbOXRn0wG+zIVn3eQZxwzFtfHqL3SOUoq3FXPM6Odj9T
   D35oSOaZMNN4gEk90aXBuJdUK7rgSabcFt4aJhKWKwySfDYIWS1nM1kKx
   mQtFF3Gh2c65NbZerJRr/FKrFwjqihtQyrn35aLYeGwLliVZDZf110J8h
   QiTO7/yPfDjEy1MIJ/ROTAyplKTSNhH7/E0zoO78xMKjBCvFD4a5nMlb6
   5eKbmikgS9Q1BvBVgWS7nMHxbm3MGoHJKIfJPxOf87Cd9gIDrXyRFmmga
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398555983"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="398555983"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 13:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="1006043910"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="1006043910"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2023 13:23:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 13:23:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 13:23:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 13:23:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 13:23:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GokC29+4mXAKRm5Am4sw3Xs3VRMF7DHgYp0O/n0Zmhpe9tc6MHN6RtiFdLk7uxa8FRXhG5MKiNLNeVO60wppul+IBqxvR4NRbQ7E1lPa52qzO3dAjHi440NpJ6NRzxCpqMEp9FlAcCE+Ad1aAnOXdadkkQL76VX6ELR4cWjHJ7SF2ecTbK8nN6BKR05AmejhQH4EjXcLtUwus5E79Qa6825ylcikAiNP5wI3yGT9C0zMN1+X+XSS7Q2YEy6JYX55qgmKfKJb5CHAiKHylSDz338dgLb7D6d6g+MubhnyK0KCvMKiqeBhmbhDMPOvzhtXwodsyRuMnxh48JESnF8jXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI4sFYkk8stAr3FvYzTukMmoDwenXelm2/4/Q/YQOvk=;
 b=V04viHC2zmQNIP+Q4YEZASy/RrQrzlnGJsVgCyPY5levGWpPEq3VSSg/HQKfJSPjNPVeBQw6RALM9TwPlIFiEfzatXEQeLP8DURWIA1ICNoga5JTC6pWu0Mnfl38mgz5bIcGLyUwlYSl8desd29uGUEaKmazx73sEclNHQ4eMU0oYZ2tmMNKCIIet0L7g5qPylEYaq7CVDv49g5qLZod/u9J+V0XQn6zSFCfl8CugKrhae2qJXflP7EDmY97L33tlCDRGeV38ivc5QeOzt3LmqF25VudSA+aG71DiWKYnaqwsxG4zLKEpXxLs5l7R5mIZOJUcmIzCwQL6Z6mOmpEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Tue, 7 Mar
 2023 21:23:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6156.019; Tue, 7 Mar 2023
 21:23:00 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Thread-Topic: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Thread-Index: AQHZTiWcwVo9jaQOt0u1ztY/yRpe/a7tql4AgADNkgCAAL2tgIAAd3MAgAAhmACAAAL3gIAAA5lAgAACGICAAAGrIA==
Date:   Tue, 7 Mar 2023 21:23:00 +0000
Message-ID: <SJ1PR11MB60834C09C9F85D401C2EB0FBFCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230303231133.1486085-1-eranian@google.com>
 <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
 <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAHk-=whzzd53rW5Uk0oK7bXVXS_X6sJiisnhrqaz+MkutO7qug@mail.gmail.com>
In-Reply-To: <CAHk-=whzzd53rW5Uk0oK7bXVXS_X6sJiisnhrqaz+MkutO7qug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: 65ddcf6e-b2df-4c77-d864-08db1f522101
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cAVYtMvMxeJ3p+Q8E6gJXa61x3bvv/hLsEAMvPJ5g07a7Q8R5Ipe+KX06tpC3W56Das/qUxwX45d3CXSHkt/W8Yb54kicBtTzWippUwfbMLH1fsBD/rA83nLcK9p8tkDYCmZYG0YP4+1VEM49PfCSGpmV+fmKU+Kek394ZsTXl+44Wm4gYl7HF6Tu0nOM3E7LQj3+DsOeylHJx+VRbYQVFrwqzJyMi21JpS1/d2XpU9dw6tZRX3cnQj8kl27whhPW3YsfHt0X0Y8toY2jmlf/aIfXu7jVx6rtLjXMMZxWmXVkz+nPOMtuNjLC021b7XM5d4H7Bn0e0aLfJ+z86tJ3JFbP5iw9hmtfPLWaJdF/ybrG5IqGjCJF+5vM0mI1eIF6tvveodRBdEeHmqRiT45mieJXgGN0YNTPHZ8lG9MUew3NF0UJEaIBOUDH1Ci2yaXzxYayN8s/J+lwE13NNN15uoodh2DgiHAjK4Shu2jOi7wRt2tw9sVo+BWOwywiixZ7KQAX9Yruw1QMUAoFzBN0NUcmehwX72R96geOYoU3JS5EJfJ0yPoEo8AOPpM35MeeO1XWGusII8lH5d7leEBgHgfbnXaN7NsQ7Sbh0xjdLP7c4Qw6PlJQrNww8JJGF/2iUKV17UqFuwXBZshbbvTyx/nLYYnE+HE0UzkpxE354uLayJGXm7nVJqZuUizzwoXyzYoFkSSqhy+QHtqX0m9cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(2906002)(86362001)(7416002)(71200400001)(41300700001)(8936002)(5660300002)(38100700002)(82960400001)(52536014)(38070700005)(7696005)(6916009)(66446008)(66946007)(316002)(66476007)(55016003)(8676002)(76116006)(64756008)(4744005)(122000001)(66556008)(4326008)(33656002)(478600001)(26005)(9686003)(186003)(6506007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1mbGg3MEM4OFl3K2ZUWlB5aS9FSEd4eGx1aUVpUTFBYlJuYkI4ZURTWlpM?=
 =?utf-8?B?VzRBQmlFZVl6TjFzSmtTU0Nlc0JROFRBa1ZVMXh0Zks4ckQ3cExDVmxGS3hB?=
 =?utf-8?B?Q2pRbnVkTENBeDFScDI5c1B0NVF1WGpsZml1S05vaWxtaWxJOU9xTUIwSWgr?=
 =?utf-8?B?VHQ3cDIrZHozVVc3ajlpSmVaa3Z6RkkrZ2tVU29pd0xYaHNZY2tESC9hb2lM?=
 =?utf-8?B?ZTc1blBjWmQvUmlnYldmUy9WNE5EeGNDdjZWYkQ0VmV3dUVyMmM3V0RLWWZL?=
 =?utf-8?B?RFYrZkJ5WktTOTBqK0lvcGh5RWtwVjFPWEVjdTJBanlCRXR3Q3J4QlFkZlJz?=
 =?utf-8?B?Z25NQWxXenRTd25idUdXcjcxUEtlOExrWFkwaXBOckhkWTRVUHIvN3lxQW5F?=
 =?utf-8?B?UWUwTWViUHJidzNBSXJQRXVsa3NkVjlPb3BxbENydzBqRUV2TWREeWJLMFZ6?=
 =?utf-8?B?eXlLVWJxcjR3L0haWWxsKzN1MEF2cXBIaGZINlVUSUdOU283bWdqVFJpK1Jr?=
 =?utf-8?B?SUptYlB5TDM0TXd0RUxMVU93bjlQeWEzVnlKd1JLZ0xuWUhSOWJMaEFraG5F?=
 =?utf-8?B?UHFKN0Nyd3h0WGsxRkVDK2YyUUlNMTFOZU0xUDBRUE5QbWQ1dTd0b2hTZkZF?=
 =?utf-8?B?UE12UnFXamV2OTdaejBaeU9TR1dQM3paSU9Vc040RldRbE9STUFGbm9qeEda?=
 =?utf-8?B?bWF2OW9URlZSYTY1OElOTEZpeHRzTWRJbVlmNW5ncWdwc2kzV3VqRFZFam1E?=
 =?utf-8?B?Z1BIaW9SZUU0ZWlRL3JjNkhxeVBwbHd1VDdJaFFMeVRKYWoyNjNTMEE5cmhD?=
 =?utf-8?B?d0k1dTRXbG1mSnJTS0lxWkpsNnovakRtUVBLcGRzZjJYc1cxR1RCTHN5aGJO?=
 =?utf-8?B?WUlvcVVMUG03MDE1NXI1VS9YR1RtU2YzOGFpaDE5WG5yc0hNQ3V1L2hSUlhL?=
 =?utf-8?B?d3F1U3VPQVBXTHJEVHZkYm5JZUZUQ1QwVWZRalhwKy90U2tJU3c3cjJEWEdK?=
 =?utf-8?B?SkdHTEFlZE5zZW16V25oa3kwckNlTVNWMXk5QURRbFNkUXVkUmgrOHVSdWFJ?=
 =?utf-8?B?TVh3bGVOS09Rbk1yazRUTGtScGp2amZrTStxWVFJMXE3aUlod09JM2xHSjA4?=
 =?utf-8?B?VDVsYTBtb29lb2FBYitiQWlsdzVEYVF4R3ZvV0VzWFBVSHM1am16cDl3V1h1?=
 =?utf-8?B?b09nWUFScDdVMzR0dy9Ra0tLTnZrVlVmMFFuc3NMNWNHRVR4QVBhVFZUbFZh?=
 =?utf-8?B?QTdnK3hWeHJaQ1BRbnRwdkVrM0lvbjdpajA1M0JtS0p5YzFYMTd0YjNySjUz?=
 =?utf-8?B?OXYxN0JLbzFTREY5QU02aFRxTE5GUk80cHQ0a2hIQ0VYNlVreThjVVBnNWh6?=
 =?utf-8?B?cWg5MElDVzdZWUo0MUthNUtMK2dxa0U4b1NLYmdacGxBVzR5eUk2UmpBQXIw?=
 =?utf-8?B?OVhrdHBzaDNsbVNaTWh4TlFmVXptOHQyWkNBRm03dEp6eFFwRkw0d29TalZ3?=
 =?utf-8?B?Y3hyYXh6K2VWckRlMlRUdXp3eXhJajZXdCtmOVo5N0h6MXZ6OE82ZHVYa2oy?=
 =?utf-8?B?NERxWCtNVXNlQjVSNkNwVkFPQVI1QjZ0bzFwZUZBNmZ1dkhPVE1LRDJBNHRI?=
 =?utf-8?B?TkNjV1djSlNUcjFuUW9MbzM3T2NyRE1OQVR0cWVkZHRGNDBDZCtTUUR6dXlZ?=
 =?utf-8?B?S2lxb3g0UGE1ZzVwZ0Vmd3kyV25KelR1dWRVc1Q1U1J1bHliT2NUUHQ1eUhJ?=
 =?utf-8?B?MlRuN1VzSi94UVV1V0p0UFBQQ2t4Lzhzd1FkcXE0YldXVE5NS0xBME11MHZr?=
 =?utf-8?B?NzBuUnZXR0lYd2MybXpiRkhGM1RuaVJzR2xqUk1rRkRGaERhV3MrM3huUkk5?=
 =?utf-8?B?VnVFbTNvQWdHUFQvbjFDREszM1JMOXhEWFI2dGdML2ZSVS9pNTg5azlGS0kw?=
 =?utf-8?B?VUxFM0JRcjlMaENzOWI0V09oVmRQUGRBV21qSFBodE9PbXBqbW0rZW9YMnZk?=
 =?utf-8?B?eUVUYXlnVE85ZmdnSURJa0dhY2FOT2Y2S29rM0wzdzV1OHNLQlhiT2ZheWdR?=
 =?utf-8?B?a1BVeXl4RGQvQnhoaHZ2enFLbzRHTkNOb0V6OWR4WlJIcGM1dnZPRHM4bGd5?=
 =?utf-8?Q?HCLyN/YhJSt8dySkoAjlhZNqw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ddcf6e-b2df-4c77-d864-08db1f522101
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 21:23:00.4293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGKKLhVsQdpyUxto68WsEFYQwMHcea/zeyvOii//y7JyJ0gUg4THNpD71FzfOqV8Asld5x4WMQfOWhLbq//k0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMaW51eCBoYXMgYSBsb3Qgb2YgInN0YXRpYyBpbmxpbmUiIGZ1bmN0aW9ucy4gQnV0IHRoYXQn
cyBub3QgYXQgYWxsDQo+IHdoYXQgdGhhdCBmdW5jdGlvbiB3YXMuIEl0IHdhcyBsaXRlcmFsbHkg
anVzdA0KPg0KPiAgIHN0YXRpYyB2b2lkIF9fcmVzY3RybF9zY2hlZF9pbiguLikNCj4NCj4gd2hp
Y2ggaXMgZGlzZ3VzdGluZyBhbmQgdmVyeSB3cm9uZy4NCg0KQWguIEkgd2FzIGxvb2tpbmcgYXQ6
DQoNCnN0YXRpYyBpbmxpbmUgdm9pZCByZXNjdHJsX3NjaGVkX2luKHZvaWQpDQp7DQogICAgICAg
IGlmIChzdGF0aWNfYnJhbmNoX2xpa2VseSgmcmR0X2VuYWJsZV9rZXkpKQ0KICAgICAgICAgICAg
ICAgIF9fcmVzY3RybF9zY2hlZF9pbigpOw0KfQ0KDQp3aGljaCBkb2VzIGhhdmUgdGhlICJpbmxp
bmUiIGF0dHJpYnV0ZS4NCg0KSSB3b25kZXIgaWYgY2hlY2twYXRjaCBjb3VsZCBjYXRjaCBtaXNz
aW5nICJpbmxpbmUiIG9uIHN0YXRpYw0KZnVuY3Rpb24gZGVmaW5pdGlvbnMgaW4gaGVhZGVyIGZp
bGVzPw0KDQotVG9ueQ0K
