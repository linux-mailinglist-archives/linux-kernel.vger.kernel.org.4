Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958B26AD87A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCGHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCGHuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:50:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD07C9F8;
        Mon,  6 Mar 2023 23:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678175399; x=1709711399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3JVDhu/QQ/qNkI+OE0aYwqNET2inQIwAC7nEXQmcxsM=;
  b=L9J8wNPI5dsWhS81wO7cwVNBHdYcY9VxTCEpKk1ZH6Ks8tcm4PSRkkAo
   0UiuKvastnBS71wvwJ29uwDv+7d8Hr6lBZNg/X/RnOuWuy9fHcyQbxbsj
   I2eQYhS/0arePCpG9mzeAKzlCNF7O304GC/O5d3ZdQqFnt64IvzCM1e0k
   Us6y/fvR8RsYpOOmPWzfWvpaL2CgMfPgmFNDcyv0rBbS0LePhuQflHKB6
   AWv2Re/APKbnMppJtHYmRyyut0qxXLvqTHuZvyfb9Ih+b3mw1vZEe7HP2
   j14lq+9hBlAsBeGuA5bpZrvNvCbodbWPjo9GMx9fR1p638X8dlQgVrmlM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400608992"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="400608992"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 23:49:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="740628498"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="740628498"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2023 23:49:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 23:49:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 23:49:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 23:49:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 23:49:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3R4f76nR9WNSRAShTImSazAYYMFRCsGxtXLmI4yXQb9gHDeis/l1WDMrwcSlSxa8c0U1FqrVG53K567lnblwsNBIULBpOIxOVfItC882OSnbpWGD2fcJUBV+A1tcUmflSQVHLW6Rw7pQ4hwkXlvSyAPca/Ho1A315SmYcSzbDXT9muywjf0v0Q1tR+9KsP/CwtpGOTbUHtJArqLjPO/qIpGKTh6M6aVaeK8L6MwJZGCNPN5LXIDACoNhCIoMgujBU0ddBFbRQYPQkl03m+ADIPTH14EcuT9cN9k2krx0welEgCCQHKD0+nmf56BP/C2uqDcwZGlZia0+KQMh+SN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JVDhu/QQ/qNkI+OE0aYwqNET2inQIwAC7nEXQmcxsM=;
 b=eezkGDhLYwRzap4BHG4lL7B8e9gHNfj9VvJ2bSCGAa55Kog5b0ssGXuuEZ4i3JdncK14Dv4hQpbTT+EVgIMazVPpnF2S8gq4AvfYJqy2b/lcWU1IMLTCLFRD+1y+Q2SY6TUQ8uApnD6msEu5msaYredt0roPltILhvu/5hJu41AlGe8LAxrYpi1GExxszK/BDSY8SWno4nMWa9uRcJYhlboPuZySItk0/CDNXNeR7ixFIg+nXusJoAvQA4D30qKfMTBC9e+ITOVnfSwKZRkKkOD033xKE+iir/JDyykunVIz+fQaty254ygpYBGDbA5Q5N9bVQ/qmFOi7pYzYaHi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by DS0PR11MB7632.namprd11.prod.outlook.com (2603:10b6:8:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 07:49:49 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%8]) with mapi id 15.20.6156.027; Tue, 7 Mar 2023
 07:49:49 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: RE: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Topic: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Thread-Index: AQHZThiYp3MlrzfqvEWnd0vYLxlOHa7pzeSAgAOQlXCAAHskAIABB5Eg
Date:   Tue, 7 Mar 2023 07:49:49 +0000
Message-ID: <IA1PR11MB61710CDB2B6B47118832770E89B79@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
 <IA1PR11MB617141A98ADB1F301FCA07E589B69@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230306144950.GR1301832@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230306144950.GR1301832@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|DS0PR11MB7632:EE_
x-ms-office365-filtering-correlation-id: 3e91051b-9b6a-4a54-56f2-08db1ee0873d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MowjknHHocASjWRTZWKxjnd2lqdKn7j5fsySZHMseZg8tSrDMaMiWfJ8bQqQTyQo60dLYdzsSVJyAR9ah1sLlmxfmsVF5HJhIoKAD4mH+iB9e0JP+EkY9GAThDWUd2O0hf7OHpWEVsSLQjhmHI4bU/hbty9PsTgTLh7Poo9RUPydgrILni7PV552je+B3T3eViG4irX6eQWGfZ1XC4g591PJZTV8hWIwyGIZg64PLgsLkT7xCl9oNMsKFWd7ocKUxvbV2YdAWJ6Y7juU00e9jiXlPBdV3oBbrbRJbjZSoYHnPunx/aLo/FEO/DxF00r3IYLn0VwfEI5gOgav47IKJeUsYLRghEvp7OBmk7kpGpyBG99A5GIiZ2dQXOvRfFjHKtJB/+igF4XiqMkd3MaS7PBSO8v1CcXUeQ0K1GYDByvaHZsgQnl2KHylwwFNRTSdIes3qe6qDGH80KGnX56VGfmuHAWmhgABoGeD7CUXLSEuVjSGlw2GQg0E48wwnGu6QR1VdtCsNGG+hA7ZAZWA+3KgRCpDF9rT1cPhPgtTsRkpmzOctOQ3yAM26peCDpqDJaCii2DxTzu1I1anRUSC5K42PDB4nbl35L9MyevmvAIn71/rL29O0dfVIRuaj0B18Y2+YomCR67tP6XRKmVcofGfMksfXeXmeNvvgnkNMzrl7Xl66mVelef1dgAn77mJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(52536014)(16799955002)(4326008)(76116006)(64756008)(41300700001)(66946007)(66556008)(6916009)(66446008)(66476007)(8676002)(8936002)(6506007)(5660300002)(2906002)(122000001)(86362001)(82960400001)(38100700002)(38070700005)(33656002)(7696005)(26005)(966005)(71200400001)(54906003)(55016003)(316002)(478600001)(83380400001)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFhhQjNJMkhOb1B5aHpvSXBSMHc2THRvVmU2VXd6cnFubHc2MG9OUEwzSTI0?=
 =?utf-8?B?NXg3SUZibmtkcnpMNEpjZk5YeEdnVU1ZZzIvVTFpYVV1NW0vQ2RhWElZUlEw?=
 =?utf-8?B?SzZKNEFiSXJKTzFHYWYrb0lTeTltbDNTRmNUVkZKc241YjJDTHBjakFWV0R2?=
 =?utf-8?B?dVR3VDRiNjRpUzJ5STROVG00V3h1WEZrakRZaGh1SHFYRWhrZ1NIZFc5T3ZC?=
 =?utf-8?B?bjVmRkQwS1o5K1F5S1B0Z3JHMkNZOGxjelN3Ti9aNWtkdXdGZFgyam51Y2hG?=
 =?utf-8?B?V3h3bitGbEVSeXpnYVVxQkx5NnNqSGRISjRkelFIblhlUGxKNXVjNDB2WkUw?=
 =?utf-8?B?MDVBbUw5RUpsQ093UUFxOVh0VjFKNUpXQnhFaUdYQ0pYL1htZm5vT2NrSEJk?=
 =?utf-8?B?M3ExSXFMeTRDY294OEVEM0drL09sRHVNZlBFOTRHU29JQzErU1dRdkkyYWtK?=
 =?utf-8?B?QkEyTkFCdGNXeTQ5b2J3R0dXdDgrUDEzS3A3TW5id3dKZnRjSGRqeGhzMGFC?=
 =?utf-8?B?K1h6NG5mWTJEa2FnbTdlUDBTNlpsdG1MOW1kMURSd3FzOGNIL0hGRDRoVGpw?=
 =?utf-8?B?eEdMSUNNWlEzdUxBc0RlVldzNjhMZTdwL3lXell6S0NodXgzM3dybTJLenhs?=
 =?utf-8?B?clM5Nmh2Z21OZUtjQnNvRmVERFcwbUhOOXZBUTNteTBOdm85R0RzbXdYNTdN?=
 =?utf-8?B?eXhaVkZESHBONmR3aExGRWtZZUtBTlNVaEF3VlFPYk9sMlE0VkVXSk5EVlZK?=
 =?utf-8?B?OHE5bTBZd0pJdGNlM0FYWGt2dVhkNU52enhZc0RuWTAyMnA5QzBodzFjRVIr?=
 =?utf-8?B?TVlrL2VOR0xtRTdGcWNrU1RZcld5VGpQTnBlNHpzd254dWJQNDB3em5CdVZD?=
 =?utf-8?B?M1ZMN3hUM1RXc2ZkTlA4U2tSTHU0d3lwdjRtOWhsN0t3SXVXdU84YTNwTDJs?=
 =?utf-8?B?U2FDajFZRkhPWm9ZMkZ0UW9XU20yY2M2Z0xmam1hUVh3MlkwNkgyancvWWlN?=
 =?utf-8?B?QnFHZldtOUNMSzlPNVNMR3JieXVnOEx5eXl4OHB3R0dPRm1IOVprZGUzUTE2?=
 =?utf-8?B?V3dTNlVkOWFOT1VESk5TVzNERm91TXEzTGNCSWs1cUswWS9NSzRBY1hWQllU?=
 =?utf-8?B?Z3krM3BVSnNnYysxelFMeTZaUnN4elNtYjR6SUs4clF2SWxPcmdZRVFESXdR?=
 =?utf-8?B?YkdMamZEcUw1OHk2N3JjT3pNa2lWcll6TzJUM1huUzJQM0ZXcGR4Yll3N0pT?=
 =?utf-8?B?OVVENmtqRmxpSnNuTVRXSjdrMGF0M29LL09ZMEh2UlB6a0RZakxYZHlSUW1D?=
 =?utf-8?B?Vk4xaEdYMldDa29Fa3BhK1puRzJ1Y2Q5U1F1S25XUmlXMkhHY0FjOCtEMVcy?=
 =?utf-8?B?OUsxUFJsbFdHelhxUjhaRG4xd3k3UHdIRTY2dEx5d0dYdmdabVppY3E2ajRm?=
 =?utf-8?B?MzFpNXdEc2I2Tm1yUW9ObHJ5UFlmcXliNkJnS095Qk5RZW52d3lncU9lTmx4?=
 =?utf-8?B?VkQyS1I2Q2J6MmlZN3pNZG5UYStWeVBoVEVEeVhhNUZoRVRPOVJ5M3B3VmQ1?=
 =?utf-8?B?eWJ1bTdieUprbDRNQ0FaMC9tK0tpL0lsY3lyTWtBWGpqbHducGNhV05Ja05y?=
 =?utf-8?B?MXdtOEhOd1pRV2kzOHU5ZnhCN091Z1lVR2lNSzJUU09XK1RRWFREQ3VpZ3V0?=
 =?utf-8?B?QWZTYjVscnNOUVZEdE1weXJLWW1TbUhYK21hSmtOVWkveVE3UFhsVzJKM0ZB?=
 =?utf-8?B?YzhyZEx3anRMVVErREtzOU1EbWp1a1ZHU0ozcURZNVgrcDZyYzVuZmFuby9X?=
 =?utf-8?B?d2pNdEMrd2s1VE5oaU9EdjlWL0NHeGowdnR2K2k0RG1UMDN5L2pxUXIyZTRC?=
 =?utf-8?B?UnRvMDNKTFprd0x4ajFVZS8vUFdGVDIveFB0bXEzK2hBaXE3TU44eWQvbW90?=
 =?utf-8?B?WXJNV0NZbmtFMlkrMEgxbk1qOHl3TjhCdWxPeGtJbmFvWW1TUTJWQTgzNWt0?=
 =?utf-8?B?cWJsazV0T1NCNnBuK0RIbXEvTzZ4dFlNSHBKQ3Eydy81TlNrQkwzZU9yZkw0?=
 =?utf-8?B?U0dWOHZnMjdOYWxmaDZJTFdwT2lsd0lvRktqa2NWeUM5cGRQK3FCM1hVRUxN?=
 =?utf-8?Q?VABFnHkh40y0eUg0pFtRoTPJd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91051b-9b6a-4a54-56f2-08db1ee0873d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 07:49:49.3196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TgHisFkdt+l+bq9UJWt+aUs2JAGvinxeBhcxb7Letu2IE0kr1uHBWBrmePHn/DJjc8ylQpxfAn/k1XHBnBGl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQYXVsIEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+IFsuLi5dDQo+
ID4NCj4gPiBUaGFuayB5b3Ugc28gbXVjaCBQYXVsIGZvciB0aGUgZGV0YWlsZWQgY29tbWVudHMg
b24gdGhlIG1lYXN1cmVkIGRhdGEuDQo+ID4NCj4gPiBJJ20gY3VyaW91cyBob3cgZGlkIHlvdSBm
aWd1cmUgb3V0IHRoZSBudW1iZXIgMjQgdGhhdCB3ZSBhdCAqbGVhc3QqIG5lZWQuDQo+ID4gVGhp
cyBjYW4gZ3VpZGUgbWUgb24gd2hldGhlciB0aGUgbnVtYmVyIG9mIHNhbXBsZXMgaXMgZW5vdWdo
IGZvcg0KPiA+IGZ1dHVyZSB0ZXN0aW5nIDstKS4NCj4gDQo+IEl0IGlzIGEgcm91Z2ggcnVsZSBv
ZiB0aHVtYi4gIEZvciBtb3JlIGRldGFpbHMgYW5kIGFjY3VyYWN5LCBzdHVkeSB1cCBvbiB0aGUN
Cj4gU3R1ZGVudCdzIHQtdGVzdCBhbmQgcmVsYXRlZCBzdGF0aXN0aWNhbCB0ZXN0cy4NCj4gDQo+
IE9mIGNvdXJzZSwgdGhpcyBhbGwgYXNzdW1lcyB0aGF0IHRoZSBkYXRhIGZpdHMgYSBub3JtYWwg
ZGlzdHJpYnV0aW9uLg0KDQpUaGFua3MgZm9yIHRoaXMgZXh0cmEgaW5mb3JtYXRpb24uIEdvb2Qg
dG8ga25vdyB0aGUgU3R1ZGVudCdzIHQtdGVzdC4NCg0KPiA+IEkgZGlkIGFub3RoZXIgNDggbWVh
c3VyZW1lbnRzICgyeCBvZiAyNCkgZm9yIGVhY2ggY2FzZSAody9vIGFuZCB3Lw0KPiA+IEpvZWwn
cyB2MiBwYXRjaCkgYXMgYmVsb3cuDQo+ID4gQWxsIHRoZSB0ZXN0aW5nIGNvbmZpZ3VyYXRpb25z
IGZvciB0aGUgbmV3IHRlc3RpbmcgYXJlIHRoZSBzYW1lIGFzDQo+ID4gYmVmb3JlLg0KPiA+DQo+
ID4gYSkgTWVhc3VyZWQgNDggdGltZXMgdy9vIHYyIHBhdGNoIChpbiBzZWNvbmRzKToNCj4gPiAg
ICAgOC40LCA4LjgsIDkuMiwgOS4wLCA4LjMsIDkuNiwgOC44LCA5LjQsDQo+ID4gICAgIDguNywg
OS4yLCA4LjMsIDkuNCwgOC40LCA5LjYsIDguNSwgOC44LA0KPiA+ICAgICA4LjgsIDguOSwgOS4z
LCA5LjIsIDguNiwgOS43LCA5LjIsIDguOCwNCj4gPiAgICAgOC43LCA5LjAsIDkuMSwgOS41LCA4
LjYsIDguOSwgOS4xLCA4LjYsDQo+ID4gICAgIDguMiwgOS4xLCA4LjgsIDkuMiwgOS4xLCA4Ljks
IDguNCwgOS4wLA0KPiA+ICAgICA5LjgsIDkuOCwgOC43LCA4LjgsIDkuMSwgOS41LCA5LjUsIDgu
Nw0KPiA+ICAgICBUaGUgYXZlcmFnZSBPUyBib290IHRpbWUgd2FzOiB+OS4wcw0KPiANCj4gVGhl
IHJhbmdlIGlzIDguMiB0aHJvdWdoIDkuOC4NCj4gDQo+ID4gYikgTWVhc3VyZSA0OCB0aW1lcyB3
LyB2MiBwYXRjaCAoaW4gc2Vjb25kcyk6DQo+ID4gICAgIDcuNywgOC42LCA4LjEsIDcuOCwgOC4y
LCA4LjIsIDguOCwgOC4yLA0KPiA+ICAgICA5LjgsIDguMCwgOS4yLCA4LjgsIDkuMiwgOC41LCA4
LjQsIDkuMiwNCj4gPiAgICAgOC41LCA4LjMsIDguMSwgOC4zLCA4LjYsIDcuOSwgOC4zLCA4LjMs
DQo+ID4gICAgIDguNiwgOC45LCA4LjAsIDguNSwgOC40LCA4LjYsIDguNywgOC4wLA0KPiA+ICAg
ICA4LjgsIDguOCwgOS4xLCA3LjksIDkuNywgNy45LCA4LjIsIDcuOCwNCj4gPiAgICAgOC4xLCA4
LjUsIDguNiwgOC40LCA5LjIsIDguNiwgOS42LCA4LjMsDQo+ID4gICAgIFRoZSBhdmVyYWdlIE9T
IGJvb3QgdGltZSB3YXM6IH44LjVzDQo+IA0KPiBUaGUgcmFuZ2UgaXMgNy43IHRocm91Z2ggOS44
Lg0KPiANCj4gVGhlcmUgaXMgYWdhaW4gc2lnbmlmaWNhbnQgb3ZlcmxhcCwgc28gaXQgaXMgYWdh
aW4gdW5jbGVhciB0aGF0IHlvdSBoYXZlIGENCj4gc3RhdGlzdGljYWxseSBzaWduaWZpY2FudCBk
aWZmZXJlbmNlLiAgU28gY291bGQgeW91IHBsZWFzZSBjYWxjdWxhdGUgdGhlIHN0YW5kYXJkDQo+
IGRldmlhdGlvbnM/DQoNCmEncyBzdGFuZGFyZCBkZXZpYXRpb24gaXMgfjAuNC4NCmIncyBzdGFu
ZGFyZCBkZXZpYXRpb24gaXMgfjAuNS4NCg0KYSdzIGF2ZXJhZ2UgOS4wIGlzIGF0IHRoZSB1cGJv
dW5kIG9mIHRoZSBzdGFuZGFyZCBkZXZpYXRpb24gb2YgYidzIFs4LjAsIDldLg0KU28sIHRoZSBt
ZWFzdXJlbWVudHMgc2hvdWxkIGJlIHN0YXRpc3RpY2FsbHkgc2lnbmlmaWNhbnQgdG8gc29tZSBk
ZWdyZWUuDQoNClRoZSBjYWxjdWxhdGVkIHN0YW5kYXJkIGRldmlhdGlvbnMgYXJlIHZpYTogDQpo
dHRwczovL3d3dy5naWdhY2FsY3VsYXRvci5jb20vY2FsY3VsYXRvcnMvc3RhbmRhcmQtZGV2aWF0
aW9uLWNhbGN1bGF0b3IucGhwDQoNCj4gPiBASm9lbCBGZXJuYW5kZXMgKEdvb2dsZSksIHlvdSBt
YXkgcmVwbGFjZSBteSBvbGQgZGF0YSB3aXRoIHRoZSBhYm92ZQ0KPiA+IG5ldyBkYXRhIGluIHlv
dXIgY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiA+IEJ1dCB3ZSBjYW4gYXBwbHkgdGhlIGJpbm9t
aWFsIGRpc3RyaWJ1dGlvbiBpbnN0ZWFkIG9mIHRoZSB1c3VhbA0KPiA+ID4gbm9ybWFsIGRpc3Ry
aWJ1dGlvbi4gIEZpcnN0LCBsZXQncyBzb3J0IGFuZCB0YWtlIHRoZSBtZWRpYW5zOg0KPiA+ID4N
Cj4gPiA+IGE6IDguMiA4LjMgOC40IDguNiA4LjcgOC43IDguOCA4LjggOS4wIDkuMyAgTWVkaWFu
OiA4LjcNCj4gPiA+IGI6IDcuNiA3LjggOC4yIDguMiA4LjIgOC4yIDguNCA4LjUgOC43IDkuMyAg
TWVkaWFuOiA4LjINCj4gPiA+DQo+ID4gPiA4LzEwIG9mIGEncyBkYXRhIHBvaW50cyBhcmUgZ3Jl
YXRlciB0aGFuIDAuMSBtb3JlIHRoYW4gYidzIG1lZGlhbg0KPiA+ID4gYW5kIDgvMTAgb2YgYidz
IGRhdGEgcG9pbnRzIGFyZSBsZXNzIHRoYW4gMC4xIGxlc3MgdGhhbiBhJ3MgbWVkaWFuLg0KPiA+
ID4gV2hhdCBhcmUgdGhlIG9kZHMgdGhhdCB0aGlzIGhhcHBlbnMgYnkgcmFuZG9tIGNoYW5jZT8N
Cj4gPiA+DQo+ID4gPiBUaGlzIGlzIGdpdmVuIGJ5IHN1bV8wXjIgKDAuNV4xMCAqIGJpbm9taWFs
KDEwLGkpKSwgd2hpY2ggaXMgYWJvdXQgMC4wNTUuDQo+ID4NCj4gPiBXaGF0J3MgdGhlIG1lYW5p
bmcgb2YgMC41IGhlcmU/IFdhcyBpdCB0aGUgcHJvYmFiaWxpdHkgKHdlIGFzc3VtZT8pDQo+ID4g
dGhhdCBlYWNoIHRpbWUgYidzIGRhdGEgcG9pbnQgZmFpbGVkIChvciBkaWRuJ3Qgc2F0aXNmeSkg
Imxlc3MgdGhhbg0KPiA+IDAuMSBsZXNzIHRoYW4gYSdzIG1lZGlhbiI/DQo+IA0KPiBUaGUgbWVh
bmluZyBvZiAwLjUgaXMgdGhlIHByb2JhYmlsaXR5IG9mIGEgZ2l2ZW4gZGF0YSBwb2ludCBiZWlu
ZyBvbiBvbmUgc2lkZQ0KPiBvciB0aGUgb3RoZXIgb2YgdGhlIGNvcnJlc3BvbmRpbmcgZGlzdHJp
YnV0aW9uJ3MgbWVkaWFuLiAgVGhpcyBvZiBjb3Vyc2UNCj4gYXNzdW1lcyB0aGF0IHRoZSBtZWRp
YW4gb2YgdGhlIG1lYXN1cmVkIGRhdGEgbWF0Y2hlcyB0aGF0IG9mIHRoZQ0KPiBjb3JyZXNwb25k
aW5nIGRpc3RyaWJ1dGlvbiwgdGhvdWdoIHRoZSBmYWN0IHRoYXQgdGhlIG1lZGlhbiBpcyBhbHNv
IGEgbW9kZSBvZg0KPiBib3RoIG9mIHRoZSBvbGQgZGF0YSBzZXRzIGdpdmVzIHNvbWUgaG9wZS4N
Cg0KICBUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBjb21tZW50cyBvbiB0aGUgbWVhbmluZyBvZiAw
LjUgaGVyZS4gOi0pDQoNCj4gVGhlIG1lYW5pbmcgb2YgdGhlIDAuMSBpcyB0aGUgc21hbGxlc3Qg
ZGlmZmVyZW5jZSB0aGF0IHRoZSBkYXRhIGNvdWxkIG1lYXN1cmUuDQo+IEkgY291bGQgaGF2ZSBp
bnN0ZWFkIGNob3NlbiAwLjAgYW5kIGFza2VkIGlmIHRoZXJlIHdhcyBsaWtlbHkgc29tZSAocGVy
aGFwcw0KPiB0aW55KSBkaWZmZXJlbmNlLCBidXQgaW5zdGVhZCwgSSBjaG9zZSB0byBhc2sgaWYg
dGhlcmUgd2FzIGxpa2VseSBzb21lIHNtYWxsIGJ1dA0KPiBtZWFuaW5nZnVsIGRpZmZlcmVuY2Uu
ICBJdCBpcyBiZXR0ZXIgdG8gY2hvb3NlIHRoZSBkZXNpcmVkIGRpZmZlcmVuY2UgYmVmb3JlDQo+
IG1lYXN1cmluZyB0aGUgZGF0YS4NCg0KICBUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBjb21tZW50
cyBvbiB0aGUgbWVhbmluZyBvZiAwLjEgaGVyZS4gOi0pDQoNCj4gV2h5IGRvbid0IHlvdSB0cnkg
YXBwbHlpbmcgdGhpcyBhcHByb2FjaCB0byB0aGUgbmV3IGRhdGE/ICBZb3Ugd2lsbCBuZWVkIHRo
ZQ0KPiBnZW5lcmFsIGJpbm9taWFsIGZvcm11bGEuDQoNCiAgIFRoYW5rIHlvdSBQYXVsIGZvciB0
aGUgc3VnZ2VzdGlvbi4gDQogICBJIGp1c3QgdHJpZWQgaXQsIGJ1dCBub3Qgc3VyZSB3aGV0aGVy
IG15IGFuYWx5c2lzIHdhcyBjb3JyZWN0IC4uLg0KDQogICBBbmFseXNpcyAxOg0KICAgYSdzIG1l
ZGlhbiBpcyA4LjkuIA0KICAgMzUvNDggYidzIGRhdGEgcG9pbnRzIGFyZSBsZXNzIHRoYW4gMC4x
IGxlc3MgdGhhbiBhJ3MgbWVkaWFuLg0KICAgRm9yIGEncyBiaW5vbWlhbCBkaXN0cmlidXRpb24g
UChYID49IDM1KSA9IDAuMSUsIHdoZXJlIHA9MC41Lg0KICAgU28sIHdlIGhhdmUgc3Ryb25nIGNv
bmZpZGVuY2UgdGhhdCBiIGlzIDEwMG1zIGZhc3RlciB0aGFuIGEuDQoNCiAgIEFuYWx5c2lzIDI6
DQogICBhJ3MgbWVkaWFuIC0gMC40ID0gOC45IC0gMC40ID0gOC41LiANCiAgIDI0LzQ4IGIncyBk
YXRhIHBvaW50cyBhcmUgbGVzcyB0aGFuIDAuNCBsZXNzIHRoYW4gYSdzIG1lZGlhbi4NCiAgIFRo
ZSBwcm9iYWJpbGl0eSB0aGF0IGEncyBkYXRhIHBvaW50cyBhcmUgbGVzcyB0aGFuIDguNSBpcyBw
ID0gNy80OCA9IDAuMTQ1OCANCiAgIEZvciBhJ3MgYmlub21pYWwgZGlzdHJpYnV0aW9uIFAoWCA+
PSAyNCkgPSAwLjAlLCB3aGVyZSBwPTAuMTQ1OC4NCiAgIFNvLCBsb29rcyBsaWtlIHdlIGhhdmUg
Y29uZmlkZW5jZSB0aGF0IGIgaXMgNDAwbXMgZmFzdGVyIHRoYW4gYS4NCg0KICAgVGhlIGNhbGN1
bGF0ZWQgY3VtdWxhdGl2ZSBiaW5vbWlhbCBkaXN0cmlidXRpb25zIFAoWCkgaXMgdmlhOg0KICAg
aHR0cHM6Ly93d3cuZ2lnYWNhbGN1bGF0b3IuY29tL2NhbGN1bGF0b3JzL2Jpbm9taWFsLXByb2Jh
YmlsaXR5LWNhbGN1bGF0b3IucGhwDQoNCiAgIEkgYXBvbG9naXplIGlmIHRoaXMgYW5hbHlzaXMv
ZGlzY3Vzc2lvbiBib3JlZCBzb21lIG9mIHlvdS4gOy0pDQoNCi1RaXV4dQ0KDQo+IFsuLi5dDQo=
