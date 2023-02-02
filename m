Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0970A687CCE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjBBMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBBMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:03:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9436CA07
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675339381; x=1706875381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LdXH5MGQdZQneHFO1gCol6qBNqBsEMTtX5lolWP5xco=;
  b=P3Pkw2yp7p0OpuJEbLSMd4aOnwX/q2q84Gog2U0szbDRky/6su6tY2TT
   ykEsiaWvvKHlZSvFEwvsiiXD/3f5wNOYWuqbh0ONa8eMxWSchqtsbzI1t
   u2VquGgM21aLGr0/lvHLNzSyLDh8lxYK0fVilScj2/OB4hmnAFvbi1VLr
   JxsNRHOEwJ/4CCPrkMZ60i7jSdn61+cpRlEaLj5ei6JgG4+jHIUO7jsxs
   3VGouahYkjUzHLiuG+JUuwhUbhJgb2G2Bn+GrZ2I2HzNkj17C9+IG7DBo
   816Rl36moSPzynwKKg+0oAkqm0lLKVTZ1VaKyWBDTshnHnJPV2JJVXUA3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="326123845"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="326123845"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 04:02:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667269194"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="667269194"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 02 Feb 2023 04:02:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 04:02:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 04:02:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 04:02:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 04:02:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoCqHq8yYH/w3E19WdlcR2SPU9pJdWn327OvyjRO62DgEz1w+y3M1mhjtBMizmV/QCmBq/SDMgoC1rjG4b1vpSpbzIfATOFGrnSovEOEqfGUjcgKP9iX6i9d6KP4brCUZxzi7SzIf/QOJNseG4V4WfSJDG4o6MnDWk9qniNtkypa3AeeRYHru+rcrBberozjrPGXrahIlyiVbEQBcc3m2mCfgZb5g06ibDPDLfSmW9FozMETGpDkhkeuv/7qy/mnheGQ+9I5q/EZaHcG5ANJwgmc+GmGDOOak9EDyMFyd6ZIo0KxEWM5oM1pKVaShEpQgRqf2Hc+zDW4zbv+ab/lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdXH5MGQdZQneHFO1gCol6qBNqBsEMTtX5lolWP5xco=;
 b=JoKCgTe1vFrKz3FB8n8+23v4QST1gc1+HNXPlZla20/3omD15oeq+7A4XUM83xyMUOS9/hjsE8zsvyNWSNHKhLtXKyL8thHjHPgxDQZ4HvdiNnRcibzL5BFgphrgGitTxbNWYDJ81hlyOTNsDom+8Hzg/TTHEWD1/CadPQBJHZRQpvC4BFIHuxtnRdbhzFj2Y+Wqd4XdxIz+HTGU0JOn3U1m+2WXo1FR4SUj1OEyFe5D+gpN3cCKfEFMsQSSwk3tFSBiYbhnX2V2KnRW9yLHay/LkE4WomFy490OkrGQkA2/2yoWq7tGJTuOWkFHduWwqxUFKH5XExs50NagiD7cBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH7PR11MB7146.namprd11.prod.outlook.com (2603:10b6:510:1ed::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.24; Thu, 2 Feb 2023 12:02:46 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 12:02:46 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v1 2/6] virtio console: Harden port adding
Thread-Topic: [PATCH v1 2/6] virtio console: Harden port adding
Thread-Index: AQHZLA3vw4V3Al1WwUykKBeCo0Hwe66l2xqAgAApS4CAABNfgIAAFRAAgAv40wCAAA7OgIAABMoAgAAJy4CAAAw2gIAADOUAgAAIGYCACT9JMA==
Date:   Thu, 2 Feb 2023 12:02:45 +0000
Message-ID: <DM8PR11MB57503A4325D2955D96F581C8E7D69@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
 <87edrgp2is.fsf@ubik.fi.intel.com> <Y9PSObAeUyHK2cc3@kroah.com>
 <87bkmkoyd1.fsf@ubik.fi.intel.com>
 <20230127094425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230127094425-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH7PR11MB7146:EE_
x-ms-office365-filtering-correlation-id: e8cee762-c623-443a-b30e-08db05156583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCxh7S/PVx5cV46jEcVtRYl7kf/Gc8VrBFgOl05/aYt8tv/APutdskhAo2KG8JzjW7q3iYT80b0yQHVH/rixXZJVkgs1898EhopuEgiUG6q743mhgXam8h+w1CYOJNnH5R/nTuB859VzU4wssuHKl71uMULSA6g1BRzELqIw4oKTxJgMek3pb4UIUfeVbe+MQJTNrx0YcA4jphsS7AHe7YWyWgbOr/X0/n3/6f5kqDSDQJiIGfsuN4CC0zLrQdFDAE2ME2Hi1pxkczE+ShSiU1o3/yxK7mdMTEvXypzUA2+w4UZXkalsW72nH5UoW870ouPrHexT7dAUZieCC0YtV9sBtqly5yM/2r4rwsrCFFv77D5CXhL/khFdBr81nnrEkBDh2DF4f2fGNIsIzOs9VuSdzDrzCH1WRj+R5X+KJ5mfNDCRWrpp8393Xn5fpCliwbkOLCxE9IJAgLbVbUGsqkX4nKuJgR/s2Yioq9Iqvyb22E8rD3vy+UCp/8EGMudqj9ZeXJG1wCxBJ4PDh66kf9cHOrdJ6OwKKPpgI+stkUP3EoQG1G/2tNSruPc9OmuStlXShVVjquSanv+Oxnha0KgUxUypz8epjJIsZFIQeAxBGSwUPzB0b87jRlSq0zMT8BHTbo0Ye1m9KqJQ11VZ3EtRtV4tlXW+cqJ87lGiRiDB8z4Ci68oKXJo77N2Te1RZ2DU7vAZEUsKww2jZ8Iong==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(76116006)(186003)(38100700002)(122000001)(8676002)(316002)(38070700005)(110136005)(54906003)(5660300002)(2906002)(8936002)(82960400001)(52536014)(66556008)(7416002)(66946007)(64756008)(4326008)(66476007)(41300700001)(66446008)(83380400001)(6506007)(55016003)(26005)(9686003)(71200400001)(33656002)(7696005)(478600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjA3Vm5jdkZsNFdUYzNLV0NkWmxyWDFEMHRCYjVNZWFEY3Y2U3JhVFVrSnpa?=
 =?utf-8?B?dzNGUGF3djI3eHo1MEVtVkZYdjhEZjMxc2xQWGNsSzA0STJSRkVjTjZBVGJs?=
 =?utf-8?B?OUx4RGFCVFhkZFpiZk5ObnZLQWJJZ0lUV1AzTGlzbWp5dldMK3d4c004cVRD?=
 =?utf-8?B?SjhETXZ0d2cxMXRqTTdKWkhBNGRXcVgyTjdaUHdWOGRvOVQvYlpZdDJXd2Fp?=
 =?utf-8?B?R0NORHZzcXZib2d3Uk0yUDlJYWl3bWd6ZzVwU2llZDRKZlh1dDlZUUZHUjZ3?=
 =?utf-8?B?Q2UwMzYxTzFGYzhacjV6N0xWdzIzek5PRytOR1ZVYTg1VEN0MnFuQUFqUEdx?=
 =?utf-8?B?cHh5cU4zaC8vakg0ZXpxSldDVUlrNWVkS0lldng5MDArV2Fta1podm9TdHVN?=
 =?utf-8?B?d3JkdzZvaE5EMTdOWVpDanErRWNhaXlLV0ZqQXZmWCtsS1NMVWs1SWJUMVFW?=
 =?utf-8?B?cUlKYndQc3J0SXcrQlBpUFhoUHNJSEt3NEt2TzdQVzVaM3pHQzhmdHVQajR1?=
 =?utf-8?B?M1BmNGd2Qi9hd0VZeFJTeGVEdGVUbnNqMUtHSENXdHk5SVZjYkd4eHdXd2Rv?=
 =?utf-8?B?WWpESmk5VVliU05wcGd6MytmeTI1eTh5QjFiK0pmc0JPRFlFM2cxNXdwOFE1?=
 =?utf-8?B?WDlpZVpKeXRwMXR1amlDTGdhdjVNMXhHSkZUU2VnM2RyT1F2U1JVT1JXcDdP?=
 =?utf-8?B?YUhpcExEaUlSeWVWZTdIUFRoK1ZtR3E4bytLdmp1NWx3aldUZUlHalBKdVJC?=
 =?utf-8?B?dS9qUlVhLzA5U3ZNWXJYUHAwdFBkUHcvcUU3dkg3eDJHY1paNjNvS1JETFIz?=
 =?utf-8?B?d2JZTmxLTitGV1JpbHk1RExwMkFLL1JDbm1VejhpWm8vclVPSkc0THN2NlJB?=
 =?utf-8?B?V2xRdHpSc1BlVy9wRndsRENsOHZZeXIvbEJIVzBmNGI4QWpRa0hCRkVWdjk4?=
 =?utf-8?B?djY2RkI0ZFVraE03VHpaRWE3V3RyRUk5U1BmaHlnUExFQWY3MUIrQ1F1TnFF?=
 =?utf-8?B?NE4xc3diazV0NWFkZkNTeUU1SEZNSFk3SUtzTWdMQTk1R25LNXFLTm81UUZP?=
 =?utf-8?B?Nk41RnZneWF6dzFTMXJ3RTRoRlZ3NW9WZWxONXpIMHJnSW5WWk0zUVh5Zng0?=
 =?utf-8?B?dmV2UTR1VHErNU92WnBMci9jUk1KYnlLblNoRmhIdk5Tb1FXV1ljMWRJV3ZQ?=
 =?utf-8?B?RmhZejlxUTM2TGVQd1ZBNWhMUWpyRG1WeVdEOXR4ZUNQRkFSSjZSazBBZTln?=
 =?utf-8?B?VUt4U1owMldNb2JobzhJckhKUmJWQmhiYXhXL2tQNGIyV1VuYUxYK3c2NEF3?=
 =?utf-8?B?QXJVWW9yUnFPSjZxdWo4OWxIMkVURUg3VVFWSWYwekg0Z3VoUmdXWk9UWERj?=
 =?utf-8?B?d0ExUWVrM0xGZ1JOVWJNZUVBVFVaKzBGbnEvTUJUU3JFRXZTLzJCbXpZOXZ0?=
 =?utf-8?B?VFdDT3JodGsxa1dGa0JtNFZDV2FGMWJRUmNwU1RRUmVrN0NSRXV2VHIrNXRC?=
 =?utf-8?B?VVRjWHZmVE9HalNoOG9ReEZ6QW5wOHBzbHNOamRiVGtYaElBYTd3aHY0aEti?=
 =?utf-8?B?QTkvaUhvT3JDdm5wZ1pGempFYnZkV0loMi9IR04rUVVuWTdlU296bElIV1lI?=
 =?utf-8?B?NjJmaHE4STBZZ1ZwbWRCVFVnUUJMMmhlVktqRnVkQm0yMkwyR1JXZmcraVd3?=
 =?utf-8?B?Y0dlbUFKNVU3SUZIVll4OEJnSGJZcHkrMWF6WDA4bWt1MjhXeDBRZ0JJdFA3?=
 =?utf-8?B?UEcrTHpYRnZHS0NRdTFoQVh3NThGRUVWYlhkVEtGQ2VUaXhtZGFYT3JaZVRw?=
 =?utf-8?B?MmpOKy9FWDhqRHkxZWtiWGg0TC9JQUVoRWZqWkdxcW5KVUpOdXllSmtvTXpS?=
 =?utf-8?B?MXppa1puWHdHUEVEVkw0TEdnbTd1NU9KSHErM21MSnAwMlNjYjJtdHk5Tm1W?=
 =?utf-8?B?MVcrK3ArMU5QM002RTdndnFNayt4VzAwTmxMdXQ0b1dCT0NRS1V5MHdudFFo?=
 =?utf-8?B?YklEaitLZitaa21rVzFNOGRHejY5RDJLTnQ5bWxTNVRqS3RCYzQ2dmZteUVI?=
 =?utf-8?B?enZwUmNGY1JxMkxSalA4VGdNOEVHUnlzRWhiaEw5dURhUHJYRVY3MHVjQ01u?=
 =?utf-8?Q?uLaYZgfPSl8shXtBoYE4sgege?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cee762-c623-443a-b30e-08db05156583
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 12:02:45.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwopPmRKZJ+JFmFIz4weqmy6E8xyIzh8OLjOwe1n3//YMl3cKrfJ3Q3CoteMw9A4xT1Yn6pLstHx1YOcYv5DFmvkCIhWakXtejBD23+ybt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIEphbiAyNywgMjAyMyBhdCAwNDoxNzo0NlBNICswMjAwLCBBbGV4YW5kZXIgU2hp
c2hraW4gd3JvdGU6DQo+ID4gR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZz4gd3JpdGVzOg0KPiA+DQo+ID4gPiBPbiBGcmksIEphbiAyNywgMjAyMyBhdCAwMjo0
Nzo1NVBNICswMjAwLCBBbGV4YW5kZXIgU2hpc2hraW4gd3JvdGU6DQo+ID4gPj4gIk1pY2hhZWwg
Uy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cml0ZXM6DQo+ID4gPj4NCj4gPiA+PiA+IE9u
IEZyaSwgSmFuIDI3LCAyMDIzIGF0IDAxOjU1OjQzUE0gKzAyMDAsIEFsZXhhbmRlciBTaGlzaGtp
biB3cm90ZToNCj4gPiA+PiA+PiBXZSBjYW4gaGF2ZSBzaGFyZWQgcGFnZXMgYmV0d2VlbiB0aGUg
aG9zdCBhbmQgZ3Vlc3Qgd2l0aG91dCBib3VuY2UNCj4gPiA+PiA+PiBidWZmZXJzIGluIGJldHdl
ZW4sIHNvIHRoZXkgY2FuIGJlIGJvdGggbG9va2luZyBkaXJlY3RseSBhdCB0aGUgc2FtZQ0KPiA+
ID4+ID4+IHBhZ2UuDQo+ID4gPj4gPj4NCj4gPiA+PiA+PiBSZWdhcmRzLA0KPiA+ID4+ID4NCj4g
PiA+PiA+IEhvdyBkb2VzIHRoaXMgY29uZmlndXJhdGlvbiB3b3JrPyBXaGF0IGVsc2UgaXMgaW4g
dGhpcyBwYWdlPw0KPiA+ID4+DQo+ID4gPj4gU28sIGZvciBleGFtcGxlIGluIFREWCwgeW91IGhh
dmUgY2VydGFpbiBwYWdlcyBhcyAic2hhcmVkIiwgYXMgaW4NCj4gPiA+PiBiZXR3ZWVuIGd1ZXN0
IGFuZCBoeXBlcnZpc29yLiBZb3UgY2FuIGhhdmUgdmlydGlvIHJpbmcocykgaW4gc3VjaA0KPiA+
ID4+IHBhZ2VzLiBJdCdzIGxpa2VseSB0aGF0IHRoZXJlJ2QgYmUgYSBzd2lvdGxiIGJ1ZmZlciB0
aGVyZSBpbnN0ZWFkLCBidXQNCj4gPiA+PiBzaGFyaW5nIHBhZ2VzIGJldHdlZW4gaG9zdCB2aXJ0
aW8gYW5kIGd1ZXN0IHZpcnRpbyBkcml2ZXJzIGlzIHBvc3NpYmxlLg0KPiA+ID4NCj4gPiA+IElm
IGl0IGlzIHNoYXJlZCwgdGhlbiB3aGF0IGRvZXMgdGhpcyBtZWFuPyAgRG8gd2UgdGhlbiBuZWVk
IHRvIGNvcHkNCj4gPiA+IGV2ZXJ5dGhpbmcgb3V0IG9mIHRoYXQgYnVmZmVyIGZpcnN0IGJlZm9y
ZSBkb2luZyBhbnl0aGluZyB3aXRoIGl0DQo+ID4gPiBiZWNhdXNlIHRoZSBkYXRhIGNvdWxkIGNo
YW5nZSBsYXRlciBvbj8gIE9yIGRvIHdlIG5vdCB0cnVzdCBhbnl0aGluZyBpbg0KPiA+ID4gaXQg
YXQgYWxsIGFuZCB3ZSB0aHJvdyBpdCBhd2F5PyAgT3Igc29tZXRoaW5nIGVsc2UgKHRydXN0IGZv
ciBhIHNob3J0DQo+ID4gPiB3aGlsZSBhbmQgdGhlbiB3ZSBkb24ndD8pDQo+ID4NCj4gPiBUaGUg
Zmlyc3Qgb25lLCB3ZSBuZWVkIGEgY29uc2lzdGVudCB2aWV3IG9mIHRoZSBtZXRhZGF0YSAodGhl
IGNrcHQgaW4NCj4gPiB0aGlzIGNhc2UpLCBzbyB3ZSB0YWtlIGEgc25hcHNob3Qgb2YgaXQuIFRo
ZW4sIHdlIHZhbGlkYXRlIGl0IChiZWNhdXNlDQo+ID4gd2UgZG9uJ3QgdHJ1c3QgaXQpIHRvIGJl
IGNvcnJlY3QuIElmIGl0IGlzIG5vdCwgd2UgZGlzY2FyZCBpdCwgb3RoZXJ3aXNlDQo+ID4gd2Ug
YWN0IG9uIGl0LiBTaW5jZSB0aGlzIGlzIGEgcmluZywgd2UganVzdCBtb3ZlIG9uIHRvIHRoZSBu
ZXh0IHJlY29yZA0KPiA+IGlmIHRoZXJlIGlzIG9uZS4NCj4gPg0KPiA+IE1lYW53aGlsZSwgaW4g
dGhlIHNoYXJlZCBwYWdlLCBpdCBjYW4gY2hhbmdlIGZyb20gY29ycmVjdCB0byBpbmNvcnJlY3Qs
DQo+ID4gYnV0IGl0IHdvbid0IGFmZmVjdCB1cyBiZWNhdXNlIHdlIGhhdmUgdGhpcyBjb25zaXN0
ZW50IHZpZXcgYXQgdGhlDQo+ID4gbW9tZW50IHRoZSBzbmFwc2hvdCB3YXMgdGFrZW4uDQo+ID4N
Cj4gPiA+IFBsZWFzZSBiZSBzcGVjaWZpYyBhcyB0byB3aGF0IHlvdSB3YW50IHRvIHNlZSBoYXBw
ZW4gaGVyZSwgYW5kIHdoeS4NCj4gPg0KPiA+IEZvciBleGFtcGxlLCBpZiB3ZSBnZXQgYSBjb250
cm9sIG1lc3NhZ2UgdG8gYWRkIGEgcG9ydCBhbmQNCj4gPiBjcGt0LT5ldmVudD09UE9SVF9BREQs
IHdlIHNraXAgdmFsaWRhdGlvbiBvZiBjcGt0LT5pZCAocG9ydCBpZCksIGJlY2F1c2UNCj4gPiB3
ZSdyZSBpbnRlbmRpbmcgdG8gYWRkIGEgbmV3IG9uZS4gQXQgdGhpcyBwb2ludCwgdGhlIGRldmlj
ZSBjYW4gY2hhbmdlDQo+ID4gY3BrdC0+ZXZlbnQgdG8gUE9SVF9SRU1PVkUsIHdoaWNoIGRvZXMg
cmVxdWlyZSBhIHZhbGlkIGNwa3QtPmlkIGFuZCB0aGUNCj4gPiBzdWJzZXF1ZW50IGNvZGUgcnVu
cyBpbnRvIGEgTlVMTCBkZXJlZmVyZW5jZSBvbiB0aGUgcG9ydCB2YWx1ZSwgd2hpY2gNCj4gPiBz
aG91bGQgaGF2ZSBiZWVuIGxvb2tlZCB1cCBmcm9tIGNwa3QtPmlkLg0KPiA+DQo+ID4gTm93LCBp
ZiB3ZSB0YWtlIGEgc25hcHNob3Qgb2YgY3BrdCwgd2UgbmF0dXJhbGx5IGRvbid0IGhhdmUgdGhp
cw0KPiA+IHByb2JsZW0sIGJlY2F1c2Ugd2UncmUgbG9va2luZyBhdCBhIGNvbnNpc3RlbnQgc3Rh
dGUgb2YgY3BrdDogaXQncw0KPiA+IGVpdGhlciBQT1JUX0FERCBvciBQT1JUX1JFTU9WRSBhbGwg
dGhlIHdheS4gV2hpY2ggaXMgd2hhdCB0aGlzIHBhdGNoDQo+ID4gZG9lcy4NCj4gPg0KPiA+IERv
ZXMgdGhpcyBhbnN3ZXIgeW91ciBxdWVzdGlvbj8NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiAtLQ0K
PiA+IEFsZXgNCj4gDQo+IA0KPiBOb3Qgc3VyZSBhYm91dCBHcmVnIGJ1dCBpdCBkb2Vzbid0IGFu
c3dlciBteSBxdWVzdGlvbiBiZWNhdXNlIGVpdGhlciB0aGUNCj4gYmFkIGRldmljZSBoYXMgYWNj
ZXNzIHRvIGFsbCBtZW1vcnkgYXQgd2hpY2ggcG9pbnQgaXQncyBub3QgY2xlYXIgd2h5DQo+IGlz
IGl0IGNoYW5naW5nIGNwa3QtPmV2ZW50IGFuZCBub3QgZS5nLiBzdGFjay4gT3IgaXQncyByZXN0
cmljdGVkIHRvDQo+IG9ubHkgYWNjZXNzIG1lbW9yeSB3aGVuIG1hcHBlZCB0aHJvdWdoIHRoZSBE
TUEgQVBJLiBXaGljaCBpcyBub3QgdGhlDQo+IGNhc2UgaGVyZS4NCg0KV2UgZG8gZW5mb3JjZSB2
aXJ0aW8gdXNhZ2UgdmlhIERNQSBBUEkgb25seSBmb3IgVERYIGd1ZXN0LiBBbGV4IGhhcyBhIHBh
dGNoDQpxdWV1ZWQgZm9yIHRoYXQgYWxzby4gDQpCdXQgbm90IHN1cmUgaWYgdGhpcyBhZGRyZXNz
ZXMgeW91ciBjb25jZXJuIGhlcmUuIA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==
