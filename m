Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF016662B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjAKSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjAKSWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:22:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CF55AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673461361; x=1704997361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XWWOxRS0sLD5BhIdpMJ6XbpeAVxP/C0G7NQ9fyzRUxU=;
  b=GzvKnPcJFmVauzZJyw0dmBWD6mJyjcrCgxhmvdQzWV6ry8KJ8/ZTkDRj
   KJDsUwaJHBc/u++TvYu4quUSymJv70zjxLZdpe0T0uSwGUyyc5cWp0iwV
   93pM+GJo4riX85Ea9Q14VvEZGFVKqK2xFpnoBSjgmzFT+OtufoSb5ubKh
   D8jtlyDGVh+RxNTXM9u1P5B5TSktUeiB5gclyvtnzM06NkZ2bRogXn3EC
   SDp5+9ZoZ3j/n4lILpeKFNQmEUxQfTOccF3E7EBe0t6IPoZwoAARdQsPL
   bxSsq/9C1+0sXzZv2gthFwHEMafgdWzXEkjW1BDwipYpUTzyz9/ReBBmc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350726139"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="350726139"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 10:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720815789"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="720815789"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jan 2023 10:22:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 10:22:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 10:22:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 10:22:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 10:22:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1rTgGj9OWAE6vO8MMAJdcNdrLiAzXu2gdL+Bcg8QEmrwrC4iNrL6b2yycVlv9VN/wqpj9J71EOp5TaISowL4rdjl7IuEd8DW89NNGedeKamT2cUXrqo4VlCZt+AM7ZOroqZhtI+3raxCgNmuIA9PZ83gtb/Vez/VhayoCCEMSUZeiD3bkAfD50pn4HEKgf80itAGMAL19XuGuYYiDrNO5AS3HzS5K95Lc93OozvN3JuTohuJ89X0GI+XOJB6aKQscKm5+mUBM98DBSWjRhQNFdnasDcxbeoY/2NwTfcYnP7JMgupw0ZqoJpZQRpSnLQA7YVqnb0P0pKY94v2MiaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWWOxRS0sLD5BhIdpMJ6XbpeAVxP/C0G7NQ9fyzRUxU=;
 b=IztLQxpLJQnjXsIwIYdsBe2VFnkiU0fE6BxM0WNnf0RF05knFwYWwx/QlbcGem+/ZLnQTy6QcM7K5E3ROE7TCcOVgyfbrJDbVyasLIin6bImmMOiVBO16BcLFv7MCx1bungtqhyCUliERLtVZevsxkitYnQv8fFKrOD0aBPmdQQ3GHJzrfB2FW/9FShkZPMBtqQy5FL4dFrv3+8xgBhumweMXgxo78W7DXl4jWRDcDeKII/GiyimxtrehfqGV/OFtGvDWGrbCFEHbSR6aAHYfguFPr+rp3JTpne4mE5WutbdB0fes7rNk3fLq6itVG0/xhFM/ubk6vbHWExxDJBaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 18:22:37 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::52ef:33cf:9be9:fcb0]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::52ef:33cf:9be9:fcb0%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 18:22:37 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>
Subject: RE: [PATCH v5 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Topic: [PATCH v5 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Index: AQHZA0vp+9PqVRslgESQoHG9Btr4Sq6Zi9wAgAA/82A=
Date:   Wed, 11 Jan 2023 18:22:37 +0000
Message-ID: <SA1PR11MB67342AB67CC1EA0654762488A8FC9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20221128164028.4570-1-xin3.li@intel.com>
 <20221128164028.4570-6-xin3.li@intel.com> <Y77H+rThnJixLEQC@zn.tnic>
In-Reply-To: <Y77H+rThnJixLEQC@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SJ0PR11MB5005:EE_
x-ms-office365-filtering-correlation-id: 4486237d-d300-4ef6-ef9d-08daf400d133
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SN6LFA09uGfmxgquWEQxrEipUD1I9zrEhQyDtAZMJIZv/5P6p+JjJ+aKtVeIuiPkS9RTJqBlOvzzwc4PxrFJSEifsM+OhCXmChpcG7H94UZj8XPX/uaL0RMyb6DxVqVu3njVEwIrp+jU8WIqCeDBniYPSsRT41pOPJp+SoPQIvL9rUmzwf9zK8uw/xT+YVqymoxgcl3T7Q6VOeDnryNnNVQWrw7LCbO8V/cF5GmYFQUq1qqEXXB66VhRgv3+k8IJbIo8GKGIK+Yox+VmCXsoiTxYpwahuIOuB8ETgC7CO+/tiidk3x9z+/3UGtJ/Lt/p+dltA5JguGKMAnIVCsjT+uCcQCQQ83eFCbscx4dvyxyPMH2/CWgtJZoArMUKdpAPcBFdr8ouyE4RIfFlz3O7S6g81Cv9Byg15MXG/xZXg0HTLRmD8Q4KtIrjQyymINd0qlsDzgJNjbIge8uzJj8s+KvCwP29lO9Gf7OTJzt8FPi+AHZmPiYmFCxbP1KHqTHXaOmLgG5Onu8fsEy0gjxSUpR8l0lFzLvzSH5Tjbw1AStZkf1d+kgj8RfZXgULpDQCUW4rKmzujQMHIIUPyjaBQVnWhj3b8IaJauFSwbn7fH2VRxsNEYbTqo3eDIBV7fj9Qvbs+5UBZpnMGa60tos8GwDOqX+yohK4FcdWoa2obrW5UIFaB7XRNLW0yspIc9mnP5oPAJkjjPirWxPPK96h1xpzspmS6Bz5jHHExxLVMvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199015)(86362001)(54906003)(8676002)(66946007)(41300700001)(66476007)(76116006)(6916009)(83380400001)(64756008)(4326008)(66446008)(38100700002)(82960400001)(122000001)(33656002)(38070700005)(7696005)(66556008)(966005)(26005)(186003)(6506007)(478600001)(8936002)(52536014)(316002)(7416002)(2906002)(55016003)(71200400001)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWN3VmI0M2ZiVThvN1o5QzIvYnB6cU5lRDI0czBtUGwwTURxWGxtNTIyRlFX?=
 =?utf-8?B?MTFUL3JjRThoMmc3OUFDOU9Cdmx6dnJ4VDhZWmVXWkNaaGpQRHJ3S2gzd3p1?=
 =?utf-8?B?Yy9WMFh0d3MwcFIwdEc3RytnNm9PeHVxSUgvc2RWMHYrZHc3VksxTmZ5QlRG?=
 =?utf-8?B?aTkxM1NGUmZFY2ZkZXIrQloxVlpJSU5ac3JpN3oxTmFYR0RXaE1mNThpUWV5?=
 =?utf-8?B?ZnJDbU9TZkRZNS9QdUtYWFgyWjBaRDVhTzVXQXVjVjdIcEM2Zkxjc3hEOTJk?=
 =?utf-8?B?ZEM0L1BucGJobDBoRU8rYnA4b3c0RFptR29ieVo1MkZHUC9SN2xnZDMyK05s?=
 =?utf-8?B?WWM1ZWZGNGphdGlBVm1LOXkvbDAwaVZaUXdVd05qaVJ1M2s3TU5xKzZEcktE?=
 =?utf-8?B?ajZMZTNnQ0N3L1VFMGVMdGJZQkcxbWtLNXFqWU93RUZyemt6ZFpGazlHVVcr?=
 =?utf-8?B?c1M4RjM5cE9LNStObjNRcjEwYmFFS0dvUDNQTGJqUWJCb29DQTN3dWYvaksx?=
 =?utf-8?B?bVd2QVA2WFp3d2JEYVU1cWRBN2VUTXkvaGpCWjBOTzYxMkxvTldQMDErQWJq?=
 =?utf-8?B?UnRSTW1IckhSRlhJRExzRGIyT2F4ZEp5ZUU3dmtBZE9qRXFwYmZkUWFxbEJI?=
 =?utf-8?B?Y0xMTlhiWWdidHhVZzQrcU5QRjg2bDlXeC9Oc0swNWhoS2JsRm9IUFlTUElO?=
 =?utf-8?B?bURHSnYxR3RRbnRDelowTmJUcjlKRTJFS05MS0RkM2RVdFVuNVo0T2Y0SVpm?=
 =?utf-8?B?ekM1TkNTQ3N0L3F0WTVGZ05IYVhNTkNSZzZIdmsvWGt2TFFhb1FwSm53MTZF?=
 =?utf-8?B?YmNaYlg1elBvUXFjM2IwSkQ4aHJNYkc5NHBCdUV3bm03VWNPdzk0R0FZQ0cy?=
 =?utf-8?B?ZGtMSktGRzY3bktMQXJIWENiajNLWG40Y0o5MjU5NUZlWjVVMnRvT3JDaXdh?=
 =?utf-8?B?SDZmRzRCY3RHZEpXR2dXRkpJWEpQbnc0TEZhQldiaExxOUpFMVNwbmx6Uk1x?=
 =?utf-8?B?SDlLWkZicU1Oc01IVzB6VnpkWHB6bE9kRjR2cGJNWERyZ01HdHY0Sk5qajdr?=
 =?utf-8?B?M3NsVWVub0xma28xRzh2a0MyREorV2R4VWhBcCtXSzZMQ2Z5OUo0aFBXQ2x4?=
 =?utf-8?B?YjJUcDk4elRIaXo4USs2emZsVlZ0VzRvbDd0L0U5b0FOTTJ5cFcyWFVodVRZ?=
 =?utf-8?B?cU5FOVR3M040RFBiNU9neHE1Zk45Vko5ZWtqelhlbkR5UEUxRXd5bURDeUpa?=
 =?utf-8?B?MWxIT2VwY3V2L1JPeTRjQk9kcG9WZWxOajlNWk5QTkswdVlteU4zejJaSm8w?=
 =?utf-8?B?WDZKdlcyTW9kbEx2R2sxV2pQbDRaV2hBYmpyWXZJRGt3Qkx0SVV5SFlNZi91?=
 =?utf-8?B?bG5MZzJxQ3M3dzdUZGVWMVZ0Nk5QaXEwVTdOWDJ3OWVFMTNMRlc1c3p6MjV5?=
 =?utf-8?B?a21icUYxbVNVejJKSmpEa0FZeTBjRWxhTU5EVXlFZzAzNmtWbmpVREVodzdj?=
 =?utf-8?B?eGtTa0FjbDNPamRyYnl3RFhNMUlWaG9oNnFDMlpVR1RyUldmMXVXdkRrbW93?=
 =?utf-8?B?RzQ4TldmRVVMM1k1VGFITWszRDMvS0FYTmhDUkh3SlBKeUNTQlN4SUN0eUk4?=
 =?utf-8?B?N0xjOW9UNVJRK0xVNWZBTENENGFCL0lmQTBzUUY0MGJCaU1aVGNvRVgzRUNt?=
 =?utf-8?B?WWkyMHc2ZnlaQVRYNzc1VlZhN3FrWkZWQnBQTzUrM1FKVjNEMktPSnpYUkpa?=
 =?utf-8?B?RmhZRzYrSS83YWw1cElPaW50SmN3aktGSnpmWXZuQXBIS1ZVbm1KZEljUERa?=
 =?utf-8?B?Mk80WERNUHdyL2pXMWNiSGtMOEVxSE1SSkF0aVRTcm9DakIrdTJ2c01rR1o1?=
 =?utf-8?B?UUUvYkFKL25aNzJTRXhCZTFoSnBnanBYSnBYZGJTV1FyQVRkd2FvTzZLN3kw?=
 =?utf-8?B?NS9lbEZBanVtOGpxSjh3cGNZaThzY2IvVlZSVnE2UjdiMU1FeEVkOTFySXo5?=
 =?utf-8?B?QlNxaVJHb0U5NllVSTUyRHJQcVc5SjJRb093bWM4UDVmaHhTSldXei90TzVT?=
 =?utf-8?B?djNMRTE4VDUrVXd1QVVCNXVtWDl3TEFuYXNsNUpXUDc0VlY1eDJZRVdDSDVj?=
 =?utf-8?Q?RFnF/kle68yiBVgM8gyBiYdLK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4486237d-d300-4ef6-ef9d-08daf400d133
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 18:22:37.3209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y948UDGbKJq1utavASk/wtc0Z9XtxRrxSW/k8IWqSjBCVPB6F6I2/9jieygq/dPskyeRG8PvQDa5981TojHSog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
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

DQo+ID4gVGhlIExLR1MgaW5zdHJ1Y3Rpb24gYXRvbWljYWxseSBsb2FkcyBhIHNlZ21lbnQgZGVz
Y3JpcHRvciBpbnRvIHRoZQ0KPiA+ICVncyBkZXNjcmlwdG9yIHJlZ2lzdGVycywgKmV4Y2VwdCog
dGhhdCAlZ3MuYmFzZSBpcyB1bmNoYW5nZWQsIGFuZCB0aGUNCj4gPiBiYXNlIGlzIGluc3RlYWQg
bG9hZGVkIGludG8gTVNSX0lBMzJfS0VSTkVMX0dTX0JBU0UsIHdoaWNoIGlzIGV4YWN0bHkNCj4g
PiB3aGF0IHdlIHdhbnQgdGhpcyBmdW5jdGlvbiB0byBkby4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEguIFBldGVyIEFudmluIChJbnRlbCkgPGhwYUB6eXRvci5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQnJpYW4gR2Vyc3QgPGJyZ2Vyc3RAZ21haWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBYaW4gTGkgPHhpbjMubGlAaW50ZWwuY29tPg0KPiANCj4gSSdtIHJlYWRpbmcgdGhpcyBT
T0IgY2hhaW4gYXMNCj4gDQo+IGhwYSB3cm90ZSBpdCAtPiB0aGVuIGl0IHdlbnQgdG8gUGV0ZXIg
LT4gdGhlbiB0byBCcmlhbiAtPiB0aGVuIHRvIEp1ZXJnZW4gLT4gYW5kDQo+IHlvdSdyZSBzZW5k
aW5nIGl0Lg0KPiANCj4gSSdtIHByZXR0eSBzdXJlIHRoYXQgY2Fubm90IGJlIHJpZ2h0Lg0KPiAN
Cj4gPiAtLS0NCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdjQ6DQo+ID4gKiBDbGVhciB0aGUgTEtH
UyBmZWF0dXJlIGZyb20gWGVuIFBWIGd1ZXN0cyAoSnVlcmdlbiBHcm9zcykuDQo+ID4NCj4gPiBD
aGFuZ2VzIHNpbmNlIHYzOg0KPiA+ICogV2Ugd2FudCBsZXNzIEFTTSBub3QgbW9yZSwgdGh1cyBr
ZWVwIGxvY2FsX2lycV9zYXZlL3Jlc3RvcmUoKSBpbnNpZGUNCj4gPiAgIG5hdGl2ZV9sb2FkX2dz
X2luZGV4KCkgKFRob21hcyBHbGVpeG5lcikuDQo+ID4gKiBGb3IgcGFyYXZpcnQgZW5hYmxlZCBr
ZXJuZWxzLCBpbml0aWFsaXplIHB2X29wcy5jcHUubG9hZF9nc19pbmRleCB0bw0KPiA+ICAgbmF0
aXZlX2xrZ3MgKFRob21hcyBHbGVpeG5lcikuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYyOg0K
PiA+ICogTWFyayBESSBhcyBpbnB1dCBhbmQgb3V0cHV0ICgrRCkgYXMgaW4gVjEsIHNpbmNlIHRo
ZSBleGNlcHRpb24gaGFuZGxlcg0KPiA+ICAgbW9kaWZpZXMgaXQgKEJyaWFuIEdlcnN0KS4NCj4g
Pg0KPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gKiBVc2UgRVhfVFlQRV9aRVJPX1JFRyBpbnN0
ZWFkIG9mIGZpeHVwIGNvZGUgaW4gdGhlIG9ic29sZXRlIC5maXh1cCBjb2RlDQo+ID4gICBzZWN0
aW9uIChQZXRlciBaaWpsc3RyYSkuDQo+ID4gKiBBZGQgYSBjb21tZW50IHRoYXQgc3RhdGVzIHRo
ZSBMS0dTX0RJIG1hY3JvIHdpbGwgYmUgcmVwYWxjZWQgd2l0aCAibGtncw0KPiAlZGkiDQo+ID4g
ICBvbmNlIHRoZSBiaW51dGlscyBzdXBwb3J0IHRoZSBMS0dTIGluc3RydWN0aW9uIChQZXRlciBa
aWpsc3RyYSkuDQo+IA0KPiBJIGd1ZXNzIHRoYXQgZXhwbGFpbnMgd2hhdCB0aGUgU09CIGNoYWlu
IGlzIHN1cHBvc2VkIHRvIG1lYW4gLSB5b3UndmUgZ290dGVuDQo+IHJldmlldyBmZWVkYmFjay4g
QnV0IHRoYXQgZG9lc24ndCBuZWVkIHN1Y2ggYSBTT0IgY2hhaW4uIFNvdW5kcyBsaWtlIHlvdSBu
ZWVkDQo+IHRvIHJlZnJlc2ggb24NCg0KWW91ciBndWVzcyBpcyBjb3JyZWN0LCB3aWxsIHJlbW92
ZSB0aG9zZSBTT0JzIGluIHY2Lg0KDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5n
LXBhdGNoZXMucnN0DQo+IA0KPiBUaHguDQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAg
ICAgQm9yaXMuDQo+IA0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJv
dXQtbmV0aXF1ZXR0ZQ0K
