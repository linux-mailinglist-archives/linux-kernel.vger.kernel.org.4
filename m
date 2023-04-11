Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8EC6DDF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDKPKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDKPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:09:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A085BAC;
        Tue, 11 Apr 2023 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681225769; x=1712761769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ix5CSXnC4J/6EijdD67e1YT2sDg/YC2jFHxBRK7f31M=;
  b=e8qMHQYFkHCJPUBd1Fl9QV4ZcQpnpZPqv26hzrQOz5sadoJwEVXkXt/O
   ErrN9JgNSxc9NzifdYrUbT+VU6XejF60s1qPOaZJXCerwsinIPXrkV6+e
   KgNbUUmys5lHpp5JLelGXcdhk2dKhJ8cYJCTuLem6FHveN7RxDv+VRFy+
   jIxqjfv25zgA8T5eUy6X2v+FhAaUzyZ+QrtyH6CveZ58yfP6mk2mfkMtu
   iJ6fzrxy+j46wZeGFLg5/WcPUDsx0PLYWGmy9Eje0m2TrQ6uI2tJ4TJX8
   Pl9Y3BboGJ/aMSxYgoCCSVaWHx7paDYGPNjFZBNlLAzUtVLBAZLTxSgVH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="429933249"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="429933249"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="688616199"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="688616199"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2023 08:09:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 08:09:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 08:09:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 08:09:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 11 Apr 2023 08:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwQvdv3rXnYTRYbX6k8rrbVBo8V5Odh5MkwfeZGA+kLsQ7cgMZg/dWWtODNAmGaUTjNv2m8RikBWgcTwaDyeIZQT4HNIb52B2wFEKDmQbUO0MubjNfgYVdml3U11E49QKK9HaPYC/25qIxAvdglvH+iXTSB13zX/p7GD+jsmIUUBhKUZQOZ8qyjhbIwskuNbuj6Xu1jTK2x+wljMD7un5AKbFIAAOrVhQ4u9Sl4G/ykXUhIXd7Lje2X3vqcoUwb0VofQIk6Pu6VhtGFHeCcpuW+oJFsPD2U08YRaDjl46+7ctt4p8CrXmp7Cu0cNKG5R9Np1DtzQYZrDSocCv8DBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix5CSXnC4J/6EijdD67e1YT2sDg/YC2jFHxBRK7f31M=;
 b=jzJI1bPF3T4DYLZzRh1Pxye8Ob4hmSNTJg/Zis1576RoExmDoyVEIczosoFObVPqggqMK08oq3+Crm7DWmImTS77eJMBZF1OGxeRYSD8ggRcE2JRmSWVmXww08kByUMhcKHMx3OWBtIa1wN5OLROxf5M4Ce55IdniFA5PAmJ+UFIE7UU9mKAZf7PxzJ/jkY09lQq0ERJGAj63iZT+bfQySWr/4dJM7DeF4FlxYKqeRVC2zP9ttw7XD1Ptk010LvfJqDhBdmbmTH+vv4Jb97fSKxhaD/ZcNygYhoaI6yIFKyLBSxqdKyj63uPE2hx/09Gj9rPxutU2Zen/FhN3YWpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:09:14 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 15:09:13 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZaiXby4kI/lAQlUSTC1cR7UMpS68lNdWAgABJBmCAAK/VgIAAAf6ggAAHJACAAACXgA==
Date:   Tue, 11 Apr 2023 15:09:13 +0000
Message-ID: <PH0PR11MB58809695F11E7B4EEBE72F95DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230408142517.800549-1-qiang1.zhang@intel.com>
 <b96953b0-0ac5-477a-a2f0-c211dc17d5dc@paulmck-laptop>
 <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
 <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDV1jhENgED4ctxO@pc636>
In-Reply-To: <ZDV1jhENgED4ctxO@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MN0PR11MB5962:EE_
x-ms-office365-filtering-correlation-id: 2a258638-816b-4aa3-2ecd-08db3a9eb62f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESQMe/RA5nZSBH1U9yv1qiLatSmFnJ6QSk5edtbXc0DsI5orOnYY+QqfLsDfbrXi4xhBSSo2vtozunIDnqtOSpvvrCjLAv32qinXszf3510i+r4zu2MBc4juSbBhQhThxfb+qgOQtMYSndyO/TVcZRPGRmLInqbrhZFVjY99J55fsKfB8qoMLtCD3ytCQs+d0Cs74y0E1TfjbtjikvoSko2mC7C8E1SBhYlj2u5i2zzESJ08yzsbqjphPBuaeJ0pmry8/ES8S2zuiIJG1ieKDwswoWKKYD7S1eoP/douU327fmlgENXGT2dzBGcwCKJ3lC3AHuMI+ZSFsWqLnq9LgFqebUh87oPHje2uhfagMNo4X1bbfWQLIHPQVXzCU2ffRjE3jsPoArcnyklW5TsNTJ1mZ2+Zhg0w/SZ02V/4tY3SpYHEwhws65/B2kVqCPG4gVfFLBrUtW7/Nm2QSOTwYQdFyqrcGMy63aoiyTTFNs8gN1utTpfT8j6Pj4epTH3gSEwVPYC/tX6UZFyT2pY9exggwaDbUiuCw9ypDEAvSKTyRWVTxnufhvVU8RzxQcPQI/ym+kGUKQrajcecnDViZ8mLGUcWdpsIeW5+/Ao+gL9JnMmSfQiUFmrg0mdn6qjs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(7696005)(54906003)(6916009)(478600001)(66556008)(71200400001)(64756008)(4326008)(66476007)(66446008)(316002)(66946007)(76116006)(41300700001)(86362001)(33656002)(26005)(6506007)(9686003)(2906002)(52536014)(8936002)(8676002)(5660300002)(83380400001)(55016003)(38070700005)(38100700002)(186003)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDhsbW5weEJoZjlUbmVKUkJRWDVYcTF2VzA3WjNqVG8yVTFIWlh3dlVjRkIr?=
 =?utf-8?B?VnkxeDFrSXI3VDBnRGtDMjJBSGtwTDlsUCtwdk5FaENhdFB6Y2Fhb2JYd3FM?=
 =?utf-8?B?eUVoYU50bDlNTmVSRWd6VDhCQk81OFdHdmhHZjIyclZtWitHNmFMSUVhRGdE?=
 =?utf-8?B?d0QweXNhMzJ6YzZ6STJ0aE5aRnlzbkhmSk04bHlhYXJQUkRKQW5KdDFWWTh3?=
 =?utf-8?B?dEZvY1o2b04wSE9wWnZzNlMxckk3NkxEVXJKbW8vL0JWR3E5RDlrek42cThl?=
 =?utf-8?B?WXFSQVdXYXlaV1FrTkV5Rjl5YXVXZmpIc2FQRzkrYXhaVzZiWXpheEdTVUIr?=
 =?utf-8?B?d3FZaDlJQnUzWHp4M0M2Ym5wanBsY3dTRHIyY2JnTDcxRU5BU28ydll4Rll2?=
 =?utf-8?B?V3FWMTk2Z0xVTm5CbE42M2ExbjVBa0dvbEJwWWp1VG96UkhDRXk1R29WWE1E?=
 =?utf-8?B?TjJJZ0R1K2sxUG5mUGN3dWtFMUdGaEhNRjRLUGFzV0J4UnIwb3VuUXhSNnRH?=
 =?utf-8?B?b3pUaDdRaGJVODc2STVWSkY5VU1KVEpPNVYrZmx4YmxsM0lvbkM4RmZFeHYx?=
 =?utf-8?B?YUlTLzc3WlNUNVFEbmtwdGNhOUN5YjgzTzcxYVA1bHE3Vk5tRXZFMjhGZXVP?=
 =?utf-8?B?N3EzNU5SejdOWkRnSGdxVEJKb05CR0w4Q1pxWHdScDBGTmxVQnFCWnR5aXhR?=
 =?utf-8?B?SjVPTTlkenRxaFlTUFFLekp2MFc5alViRHhxTkFVRjR2Z1U2cmpSR3FsODI4?=
 =?utf-8?B?M20xanFnczBZZjZuNXE0SDVqeGdLQklLcHdVei82dktiemF2UklqMUdpU0k3?=
 =?utf-8?B?SFNFVG10YlliKzNFU01xUjBSOHB4ckMxREpBeVovRzArWmIwN1NpUFA0VnBi?=
 =?utf-8?B?WnF6WmkxK0NyNlVOZnVkMjU1d3B2MDNDeTlUaTdQMDRza0F6QkVISEFOWGp6?=
 =?utf-8?B?M3ZZQTNZNmFsa2E1cE5UK0JLdXB5TWl5SllaNTkvYk9KZGxXcnE0dG53YjFU?=
 =?utf-8?B?cmxyb2hadFBGQWJxMzh6dWdRUG1hMitNTkNGdjJNN3Ewa2lZUHpOalFwS1Fk?=
 =?utf-8?B?REpLOXJQR0ExdEd3TS9ZY29mYXJiMXFCU2VZYlQzM08waDRabXYrZlI2cVNW?=
 =?utf-8?B?cUhlaGRIeUd4OFh4enJVNjJ4KzQ1dXk2OXdXTVRaTDEwNkxPVENtUHoxaUI4?=
 =?utf-8?B?MnNEUllKNE5WK2hwWDFicWdGWnRMdUZMZng4QVd6d1F0RkFhcC9vV3huV3d0?=
 =?utf-8?B?NTUwT0l0M2Y4Y0pSR2JxdncvYlFlZHRQR0F0Yzd2dWJhOHBiUnNjRVpuN3pu?=
 =?utf-8?B?TjZVWll1K25ZUlVuZFljNUp3THVWRzVHOU5ROW5PV0pzSzZTc2NYSmhDMm4w?=
 =?utf-8?B?R1RGaFVHV1pRZktleUJGdEhzSUZ6cEt3V1B0clU4UjRDd0wxc2dpelJhcXRz?=
 =?utf-8?B?aGhKNFcvR2hUdGhaRDR6bEp0cURvNWVNT1pIZmZSekpyUzREVnN6V0JJcjhz?=
 =?utf-8?B?Y2QxemplSTBGbWFpTElaajhDZTFEaERHbml5di9HT2RCZjhJMFZlSi9FdTV5?=
 =?utf-8?B?MWdOcWxzRGhpLytMeHVUUWJXK3Q4SzRMWWNFWS9BMHhBNmFNcXFGaUVjbGFE?=
 =?utf-8?B?bENiUHlYWjRKb2hCYllQcWJ1Z2drQTIzNWNBYWgxRW9aMnlwNitjZDYwQ1Vp?=
 =?utf-8?B?TWkwZEsxbkY5WUhHWDY3Y1JvU2M3T3hJYlI0Z2xsQ3hSVEw1M0x4dmJiMkVl?=
 =?utf-8?B?QW10VHkzT0hFSGdpN2YxMU14eE5EZGtacS9qbUZPTXNaTjRXeDgxaDFnT1hG?=
 =?utf-8?B?MWNUT3VUSE1FdEt1L3RyMlRPVHI3QkxHaXhRa3MxaCtSL3J3OEFrTS9USVZC?=
 =?utf-8?B?S2FpVmtVOGZZZ0tjNmpoWEhsVHROcUd1cEtvdHpwRFUvL1gvSVN0WkxQa1Mw?=
 =?utf-8?B?eVhwdUkrTnR0am1xVThjendjN3pZMllaL3dCcTduR0RLQkdtN0NBTUQwL2k5?=
 =?utf-8?B?ZVVRTlExTXhoY1NxeEE3Z25Dbjl2YkVjMUFYcHpRaitWUEo2QTdFSFNtcXZ0?=
 =?utf-8?B?Qm5DLzdRaUwvQk1nR3lFVXhKVkZ0dVRUQytmb1ZxVzlMajNrRFNVSXVrcm41?=
 =?utf-8?Q?/OpumZrlh/cyHzCSVg44TzTIR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a258638-816b-4aa3-2ecd-08db3a9eb62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 15:09:13.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mbl2CUpFX2Y6vjc1i3tWAD+U4+Ns05kAx4bCFKaQi32+IYCKC8ku6DKqZu6a1Mt06OPRVZJ30HmFXz4DSe7MTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gQ3VycmVudGx5LCBpbiBrZnJlZV9yY3Vfc2hyaW5rX3NjYW4oKSwgdGhlIGRyYWluX3Bh
Z2VfY2FjaGUoKSBpcw0KPiA+ID4gZXhlY3V0ZWQgYmVmb3JlIGtmcmVlX3JjdV9tb25pdG9yKCkg
dG8gZHJhaW4gcGFnZSBjYWNoZSwgaWYgdGhlIGJub2RlDQo+ID4gPiBzdHJ1Y3R1cmUncy0+Z3Bf
c25hcCBoYXMgZG9uZSwgdGhlIGt2ZnJlZV9yY3VfYnVsaygpIHdpbGwgZmlsbCB0aGUNCj4gPiA+
IHBhZ2UgY2FjaGUgYWdhaW4gaW4ga2ZyZWVfcmN1X21vbml0b3IoKSwgdGhpcyBjb21taXQgYWRk
IGEgY2hlY2sNCj4gPiA+IGZvciBrcmNwIHN0cnVjdHVyZSdzLT5iYWNrb2ZmX3BhZ2VfY2FjaGVf
ZmlsbCBpbiBwdXRfY2FjaGVkX2Jub2RlKCksDQo+ID4gPiBpZiB0aGUga3JjcCBzdHJ1Y3R1cmUn
cy0+YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwgaXMgc2V0LCBwcmV2ZW50IHBhZ2UNCj4gPiA+IGNh
Y2hlIGdyb3dpbmcgYW5kIGRpc2FibGUgYWxsb2NhdGVkIHBhZ2UgaW4gZmlsbF9wYWdlX2NhY2hl
X2Z1bmMoKS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhh
bmdAaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+TXVjaCBpbXByb3ZlZCEgIEJ1dCBzdGlsbCBzb21l
IHF1ZXN0aW9ucyBiZWxvdy4uLg0KPiA+ID4NCj4gPiA+CQkJCQkJCVRoYW54LCBQYXVsDQo+ID4g
Pg0KPiA+ID4gLS0tDQo+ID4gPiAga2VybmVsL3JjdS90cmVlLmMgfCA0ICsrKy0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+
ID4gPiBpbmRleCBjYzM0ZDEzYmUxODEuLjlkOWQzNzcyY2M0NSAxMDA2NDQNCj4gPiA+IC0tLSBh
L2tlcm5lbC9yY3UvdHJlZS5jDQo+ID4gPiArKysgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPiA+ID4g
QEAgLTI5MDgsNiArMjkwOCw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbA0KPiA+ID4gIHB1dF9jYWNo
ZWRfYm5vZGUoc3RydWN0IGtmcmVlX3JjdV9jcHUgKmtyY3AsDQo+ID4gPiAgCXN0cnVjdCBrdmZy
ZWVfcmN1X2J1bGtfZGF0YSAqYm5vZGUpDQo+ID4gPiAgew0KPiA+ID4gKwlpZiAoYXRvbWljX3Jl
YWQoJmtyY3AtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsKSkNCj4gPiA+ICsJCXJldHVybiBmYWxz
ZTsNCj4gPiA+DQo+ID4gPlRoaXMgd2lsbCBtZWFuIHRoYXQgdW5kZXIgbG93LW1lbW9yeSBjb25k
aXRpb25zLCB3ZSB3aWxsIGtlZXAgemVybw0KPiA+ID5wYWdlcyBpbiAtPmJrdmNhY2hlLiAgQWxs
IGF0dGVtcHRzIHRvIHB1dCBzb21ldGhpbmcgdGhlcmUgd2lsbCBmYWlsLg0KPiA+ID4NCj4gPiA+
VGhpcyBpcyBwcm9iYWJseSBub3QgYW4gaXNzdWUgZm9yIHN0cnVjdHVyZXMgY29udGFpbmluZyBh
biByY3VfaGVhZA0KPiA+ID50aGF0IGFyZSBwYXNzZWQgdG8ga2ZyZWVfcmN1KHAsIGZpZWxkKSwg
YnV0IGRvZXNuJ3QgdGhpcyBtZWFuIHRoYXQNCj4gPiA+a2ZyZWVfcmN1X21pZ2h0c2xlZXAoKSB1
bmNvbmRpdGlvbmFsbHkgaW52b2tlcyBzeW5jaHJvbml6ZV9yY3UoKT8NCj4gPiA+VGhpcyBjb3Vs
ZCBzZXJpb3VzbHkgc2xvdyB1cCBmcmVlaW5nIHVuZGVyIGxvdy1tZW1vcnkgY29uZGl0aW9ucywN
Cj4gPiA+d2hpY2ggbWlnaHQgZXhhY2VyYmF0ZSB0aGUgbG93LW1lbW9yeSBjb25kaXRpb25zLg0K
PiA+IA0KPiA+IFRoYW5rcyBmb3IgbWVudGlvbmluZyB0aGlzLCBJIGRpZG4ndCB0aGluayBvZiB0
aGlzIGJlZm9yZfCfmIouDQo+ID4gDQo+ID4gPg0KPiA+ID5JcyB0aGlzIHJlYWxseSB3aGF0IHdl
IHdhbnQ/ICBaZXJvIGNhY2hlZCByYXRoZXIgdGhhbiBqdXN0IGZld2VyIGNhY2hlZD8NCj4gPiA+
DQo+ID4gPg0KPiA+ID4NCj4gPiA+ICAJLy8gQ2hlY2sgdGhlIGxpbWl0Lg0KPiA+ID4gIAlpZiAo
a3JjcC0+bnJfYmt2X29ianMgPj0gcmN1X21pbl9jYWNoZWRfb2JqcykNCj4gPiA+ICAJCXJldHVy
biBmYWxzZTsNCj4gPiA+IEBAIC0zMjIxLDcgKzMyMjMsNyBAQCBzdGF0aWMgdm9pZCBmaWxsX3Bh
Z2VfY2FjaGVfZnVuYyhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gPiAgCWludCBpOw0K
PiA+ID4gIA0KPiA+ID4gIAlucl9wYWdlcyA9IGF0b21pY19yZWFkKCZrcmNwLT5iYWNrb2ZmX3Bh
Z2VfY2FjaGVfZmlsbCkgPw0KPiA+ID4gLQkJMSA6IHJjdV9taW5fY2FjaGVkX29ianM7DQo+ID4g
PiArCQkwIDogcmN1X21pbl9jYWNoZWRfb2JqczsNCj4gPiA+ICANCj4gPiA+ICAJZm9yIChpID0g
MDsgaSA8IG5yX3BhZ2VzOyBpKyspIHsNCj4gPiA+DQo+ID4gPkkgYW0gc3RpbGwgY29uZnVzZWQg
YXMgdG8gd2h5IHdlIHN0YXJ0ICJpIiBhdCB6ZXJvIHJhdGhlciB0aGFuIGF0DQo+ID4gPi0+bnJf
Ymt2X29ianMuICBXaGF0IGFtIEkgbWlzc2luZyBoZXJlPw0KPiA+IA0KPiA+IA0KPiA+IE5vLCB5
b3UgYXJlIHJpZ2h0LCBJIG1pc3NlZCB0aGlzIHBsYWNlLiANCj4gPiANCj4gPiAtLS0gYS9rZXJu
ZWwvcmN1L3RyZWUuYw0KPiA+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+ID4gQEAgLTI5MDgs
NiArMjkwOCw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbA0KPiA+ICBwdXRfY2FjaGVkX2Jub2RlKHN0
cnVjdCBrZnJlZV9yY3VfY3B1ICprcmNwLA0KPiA+ICAgICAgICAgc3RydWN0IGt2ZnJlZV9yY3Vf
YnVsa19kYXRhICpibm9kZSkNCj4gPiAgew0KPiA+ICsgICAgICAgaWYgKGF0b21pY19yZWFkKCZr
cmNwLT5iYWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVy
biBmYWxzZTsNCj4gPg0KPiA+VGhpcyBpcyBicm9rZW4sIHVuZm9ydHVuYXRlbHkuIElmIGEgbG93
IG1lbW9yeSBjb25kaXRpb24gd2UgZmlsbA0KPiA+ZmlsbCBhIGNhY2hlIHdpdGggYXQgbGVhc3Qg
b25lIHBhZ2UgYW55d2F5IGJlY2F1c2Ugb2Ygd2UgZG8gbm90IHdhbnQNCj4gPnRvIGhpdCBhIHNs
b3cgcGF0aC4NCj4gDQo+IFRoYW5rcyByZW1pbmQsIHBsZWFzZSBpZ25vcmUgbXkgdjQgcGF0Y2gs
ICAgaG93IGFib3V0IHRoZSBmb2xsb3dpbmc/DQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3Jj
dS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPiBpbmRleCA0MWRhYWUzMjM5YjUuLmUyZTg0
MTJlNjg3ZiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3JjdS90cmVlLmMNCj4gKysrIGIva2VybmVs
L3JjdS90cmVlLmMNCj4gQEAgLTMyMzgsNiArMzIzOCw5IEBAIHN0YXRpYyB2b2lkIGZpbGxfcGFn
ZV9jYWNoZV9mdW5jKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKSBibm9kZSk7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAg
ICAgICAgICBpZiAoYXRvbWljX3JlYWQoJmtyY3AtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsKSkN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgfQ0KPkl0IGRvZXMg
bm90IGZpeCBhbiAiaXNzdWUiIHlvdSBhcmUgcmVwb3J0aW5nLiBrdmZyZWVfcmN1X2J1bGsoKSBm
dW5jdGlvbg0KPmNhbiBzdGlsbCBmaWxsIGl0IGJhY2suIElNSE8sIHRoZSBzb2x1dGlvbiBoZXJl
IGlzIHRvIGRpc2FibGUgY2FjaGUgaWYNCj5hIGxvdyBtZW1vcnkgY29uZGl0aW9uIGFuZCBlbmFi
bGUgYmFjayBsYXRlciBvbi4NCj4NCj4NCj5UaGUgY2FjaGUgc2l6ZSBpcyBjb250cm9sbGVkIGJ5
IHRoZSByY3VfbWluX2NhY2hlZF9vYmpzIHZhcmlhYmxlLiBXZSBjYW4NCj5zZXQgaXQgdG8gMSBh
bmQgcmVzdG9yZSBpdCBiYWNrIHRvIG9yaWdpbmFsIHZhbHVlIHRvIG1ha2UgdGhlIGNhY2hlIG9w
ZXJhdGluZw0KPmFzIGJlZm9yZS4NCg0KQSBnb29kIHN1Z2dlc3Rpb24uICBhIHF1ZXN0aW9uLCB3
aGVuIG5lZWQgdG8gcmVzdG9yZSAgcmN1X21pbl9jYWNoZWRfb2Jqcz8NCmFmdGVyIHRoZSBleGVj
dXRpb24gb2Yga2ZyZWVfcmN1X3Nocmlua19zY2FuKCkgZW5kcz8NCg0KVGhhbmtzDQpacWlhbmcN
Cg0KPg0KPi0tDQo+VWxhZHppc2xhdSBSZXpraQ0K
