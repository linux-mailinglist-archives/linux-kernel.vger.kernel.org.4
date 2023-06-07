Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08663726014
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbjFGMvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjFGMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:51:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012D726A9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686142259; x=1717678259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u/wVm1uA50DNS3KU9F05zHhhP+GHp+rWPkNMraptS7Y=;
  b=TsW74G37O1FjMG9JSN/ycmKSOxonlQWNNfHYdy56lJ3MjonbE3Li7QqM
   R0NhjaXi0yzNppsEngO7INqTu11Csw9Z6f282dBWeRIp77ePFgGJwawyW
   WhHj+WUSAZGBckC4RF0zp2gQuTXyFi9cka4EXXyIpQzPd6aYYilMASk/J
   Xo0tDDPt874/o77Pzy2b/RoD/ymOVq0IVWJOClk0pnRYC4NX97wj44sr6
   dBw5Mm/LGFXJ13pH85S12aIrqfayyQ6DzcSxPgvT9o6TK2VSaTDIYQjdX
   K9PlBKOpuWi0M97MAo9d1z609BPrzt5ocNR9WNA59ltr5Jrxeos3ewPE0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="443342414"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="443342414"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 05:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="779430492"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="779430492"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2023 05:50:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 05:50:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 05:50:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 05:50:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 05:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOUnXQiunvqedVd08njNonMOq4/ysvZMc1I9shWmiVYIrOlI8JRNtbQJhIVLai1iP/rTGaE0vmxXgZwlIQelmQ8s76+Abd6pq8ArxCCSLv7k8ZRxLKBmpQ2Vkwa72DNruH0odB3XUcSTw2bwFk7Gjy4ZJCP2HOYsavz8nIHZlVqgOiCwqNuqe8ZJqf924lC5l0B9FMzC4DvziNVTObyoigEqrgdyIkWfgtUuG3MGj0SHi+V278KDSUUqqQ4vEG75heWDU5qVH/LjcmrHDstHyRLjb0cYjCYCq88zkBybMJPowemvfaCMO4Fs9mQ62B2fyhAXLiWIfjojm0GHjQKD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/wVm1uA50DNS3KU9F05zHhhP+GHp+rWPkNMraptS7Y=;
 b=liG2jC51mJLfPsfjWSEs0lgySGZzAH+b0g94Qusd5544l2QmFo7Rf3M9fhqAMxwtYzMyvD8KQn7urdfGEeeYCimJgyvacQ9Ubar9c+OJauWO7jSs4jnzEaybcHsp+Ijv7ovs62Ik7tg+rSQv4Wg9d3m905qd7oGgmQNoqTK0n5oEk2Xg8is7dwuVbPMjjtu+5rq0Idh3pvqQtvoFByj0TBAeQlcf0AgRVPGTpHvTJ2ve1gt43OH+m5GxqvANWgwXgSxMpfTZvTx/0X2jkM6QQSgere39qdrsEQ7k0IewbxvRQs46hiAU8HY0jdkcIqO0Nw1U0/zI8G8eflwpnuDndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:50:33 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:50:32 +0000
From:   "Ma, Yu" <yu.ma@intel.com>
To:     Dennis Zhou <dennis@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Thread-Topic: [PATCH] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Thread-Index: AQHZmHJCKr3K+mTGpUq3KANBsKgbqK9+J0mAgAAiyACAAQFqoA==
Date:   Wed, 7 Jun 2023 12:50:32 +0000
Message-ID: <SN7PR11MB7590D345281CF63E1414E88EE153A@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <20230606125404.95256-1-yu.ma@intel.com>
 <20230606192127.w66indpq74ec6eyt@revolver>
 <ZH-kZA5kRmWjcrTI@V92F7Y9K0C.corp.robot.car>
In-Reply-To: <ZH-kZA5kRmWjcrTI@V92F7Y9K0C.corp.robot.car>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|CY8PR11MB7012:EE_
x-ms-office365-filtering-correlation-id: e5203aad-82b1-4310-9726-08db6755c7bd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeSgsNOH2M5jNJPcJesn7EH7vg0vCudW/qRi1zt5FeAP5lFUTMVkA3Rp3ZScPB4CWuyLk3woGEbSouldmVj/xb+krRaKpS3MYd/cWsNPd14FbYK8BfHlvjqdgSsxZ7tLizLol5RGeA8wqpm4gThno3NGg+3mB8Kk4Ollx3po9tQ3e5zpcugcPo6eOgpbXuPblGt/9LQBaCcR/tXzmDcVr+3uBiRT3E3aTwUAFkOCS32dCFPCgve9Ie0GnJEnNxFjB6I5gVFvANl2hDFRh08erZ1UOgvhPP6UekvBONhWEYajNvsJisaiUJQmsnT+2u8SVqJpAIP+Egeox+BYHRi0EV7qhGPfoF5MK3yOxKa8WXBsnnIOhN3npcuqGgypG3l0BacTM/PVG+jus3E6ZuIfM/NtWRz7nXUhUzhrz/gUq7+UIdA9uissBciMZR4cLOMNkOWuH5bm0GU4AgFOK2Ib/qu58xLs3SXu8qK2Vu4gxierCa6/h+qe1l5bicEf/jg+9BKQ5FgL+rGZQ1ZYYY0H9oEDYO/PfnGwEjFiiemUVltYljZXtofn0TQ0VzrheHWDzlQdjKZwNn/VfBzOyEJ6/b5RtOKCQYqbUDi4BX02+G6bvUKnx+eQOBGF+MYBOp/t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(71200400001)(7696005)(66556008)(82960400001)(2906002)(64756008)(76116006)(66446008)(122000001)(66946007)(66476007)(110136005)(54906003)(8676002)(8936002)(52536014)(38070700005)(5660300002)(86362001)(38100700002)(41300700001)(33656002)(316002)(4326008)(55016003)(478600001)(6506007)(9686003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWN2MFhmSWFOVGllNG4xUTFoQ2JqMEtQVU1WUWtlM2UwM0dzT0t4Y3orL1BP?=
 =?utf-8?B?MjlNQnBkT2s5U01ZV1pwMm5HQ3ZMbzhnOWRKVy9VRVhCYUtucitLdHdoOFlr?=
 =?utf-8?B?aTdBV1hsOCtoSEIwMDZVMEpWdGtOQ0JqWTM0YzZxTzFyOFZWazhscjBYQ1Ns?=
 =?utf-8?B?RitNNGFncFBDdHovWk1zby9TQnhXdHV5dXA0N0ZvQms5d3J6eEs0czFyWDdU?=
 =?utf-8?B?TTV5NVRSKzlyRG5PRjFXUzQzN1dQNEU0clVTazQ2by9jbmlJdjdpU1dUdjBZ?=
 =?utf-8?B?eVkzNlRqMzVCem9kejlJNGVSblZXcGJ4eEx4MGx1cDRLOGJXWjduL1VMaG9X?=
 =?utf-8?B?R3luM2NTVVdQTk03WjFGaFN1dTd5QjRVT1Nua3JoOHhNdTFCR0syaFhSbTVT?=
 =?utf-8?B?cnkrWFZEVHduckpMNEVNSXEvb2M3aEhyckxKc01iOVJaaE5mYm1lUG9XUWQ1?=
 =?utf-8?B?VytWaitXRlJWekpEUlp5VXFFdnBkYzVLQVJmdk5OaEYxSlFsdTZibzJ4cklX?=
 =?utf-8?B?TXRrOXJNNThZVGQxZHN1V0ZmbDZlRTdiNUtZRHo1OTV4SzRHMlg5MDIvTzdw?=
 =?utf-8?B?QTlxcWphZWNlVElXbVROdjlhS0M2V2s0MTJBQTQ2L1pKclBaK0lPNEMwYnpJ?=
 =?utf-8?B?UnViQm9QaER6QmhEUWw5K3lTdUpDemM1S1MyaUx0ajVTQWhrU2pIcW16VUJ3?=
 =?utf-8?B?S1UxUEpERFFHdkVFdUdWSnNoaUJoM1k4Z1oyT0ErN1VKU3FTZWdtVHlpc1JY?=
 =?utf-8?B?WjMyWUc2b09NaSt0SzRGa0dmR3ZjWk9uSkRubFBhSmJDRHd0d0NaUXBRYVNS?=
 =?utf-8?B?UWE4RzdQdnczS2w0MXk4c3FVVmRkd0JBVnBEY1ovQlhyb1JHbS9QbkdYN0ti?=
 =?utf-8?B?WldyUStFb2dHRDdPTVF6UnR4UlByb1VMT2pqeFVIOFpucVBxTWN3Nys3VXZL?=
 =?utf-8?B?emNTK25PTWNRbnRqbEpPTU54L2E5M1NoeUgybWJZNlRkKzlteEVJWEwzaDQ5?=
 =?utf-8?B?bDc0SnFkQVJERURnMTNKU0RmZ1VsNndhNy84RW1qNGhDTEhQWGVPdHErVlB4?=
 =?utf-8?B?OHBURHdwTUthYTNjZVlSajZ0MnpCYU43Uld4T3Q2dHYrclhJRkFZU3RkczJD?=
 =?utf-8?B?Q09OYy8zK0MydW5SMnErM3ZBNkQzUTFzdTR2OFMyS1B2RDJOYnZXcmVqU2pQ?=
 =?utf-8?B?Vjl0S2N6dkJtQ1NYd1B0V0JsZythZkpXRHZFUHFJWHE3dlVvRk1ITW4vdXU4?=
 =?utf-8?B?cExZejdxa2ZqV0JyQ0Y5WG5kdDZyaWRCY3haRCt5TDRuc2dXaVBPZVpMSVZG?=
 =?utf-8?B?cEFTazBuUndWQWdjaHNXS2tCOEMwd1htSk9Rdk94YVd6V1pvNDk1cHZOanBr?=
 =?utf-8?B?OU9iaFk0TDJqNzFOZkZqYktwVm9xK0xwZWNvQmQwMDJtN0R4blV1dUNaNWpB?=
 =?utf-8?B?bmNNMlpOK1AybGhKVlIvaGNXUm94c1FmeE9Qd3BtcW13Z0kxZjROYkF2aXpk?=
 =?utf-8?B?QUVZZklKS1BBbXpaVnBLZmV6c2dlK0JPYlM5WHhwK2thbWNvUk9YUmdTVkxG?=
 =?utf-8?B?UTVmbnNyeHJnZ1ZFSFFLRU5Vb2MzUUtLS1RiTXJGS284OVNJUlB4bENxUTVP?=
 =?utf-8?B?TDFEd0c0cTkveDh2NFh3VjV5U2FFUkUvVGREZ2NtM3loVGp2QUNQQW5LaVQw?=
 =?utf-8?B?OTBIYVZIWlhEQzJTb05tUUZJWUREcERTZGtGK1ExbTJLZUpIV1Fqby9vVGhO?=
 =?utf-8?B?Y0ZWYjVjZWp2ZWluMXI3WGIrREFETGhNZG9WK3FsUm5YbEhEUVNwbnlkZXp2?=
 =?utf-8?B?UjhDUGRIcURJR25oQ2NqWXUrTDYvMTV3RElHZUhmRURRV3pZSzl5SkRiY0hl?=
 =?utf-8?B?R05VNEcweEpoUzRwdmlpK3hkUnBrZUFHRy9YbmtEYU9Qci8ybTVzNUtyM29u?=
 =?utf-8?B?TGpiamF0cVI3WTBQV1hGMlNsMnlqOXFHc3hiRjJNWUVBakdoVVFCK1hxbUx5?=
 =?utf-8?B?aVV1Ykxpdjc0VWRNbEY0QzlCdE0rTEljMTF1d3UwZmN1eU9Dc1JFL0k3aUY3?=
 =?utf-8?B?cmxDRjYwT3piMUpwc1R4dVFHTDMzMWFRbURzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5203aad-82b1-4310-9726-08db6755c7bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 12:50:32.3978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3eJ/suDvM0Wwy9DeV3BwsskIUX7nAnhjUokUPEqYeXnwDKAi9mmAZN2NH5/qzy7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIZWxsbywNCj4gDQo+IE9uIFR1ZSwgSnVuIDA2LCAyMDIzIGF0IDAzOjIxOjI3UE0gLTA0MDAs
IExpYW0gUi4gSG93bGV0dCB3cm90ZToNCj4gPiAqIFl1IE1hIDx5dS5tYUBpbnRlbC5jb20+IFsy
MzA2MDYgMDg6MjddOg0KPiA+ID4gV2hlbiBydW5uaW5nIFVuaXhCZW5jaC9FeGVjbCB0aHJvdWdo
cHV0IGNhc2UsIGZhbHNlIHNoYXJpbmcgaXMNCj4gPiA+IG9ic2VydmVkIGR1ZSB0byBmcmVxdWVu
dCByZWFkIG9uIGJhc2VfYWRkciBhbmQgd3JpdGUgb24gZnJlZV9ieXRlcywNCj4gY2h1bmtfbWQu
DQo+ID4gPg0KPiA+ID4gVW5peEJlbmNoL0V4ZWNsIHJlcHJlc2VudHMgYSBjbGFzcyBvZiB3b3Jr
bG9hZCB3aGVyZSBiYXNoIHNjcmlwdHMNCj4gPiA+IGFyZSBzcGF3bmVkIGZyZXF1ZW50bHkgdG8g
ZG8gc29tZSBzaG9ydCBqb2JzLiBJdCB3aWxsIGRvIHN5c3RlbSBjYWxsDQo+ID4gPiBvbiBleGVj
bCBmcmVxdWVudGx5LCBhbmQgZXhlY2wgd2lsbCBjYWxsIG1tX2luaXQgdG8gaW5pdGlhbGl6ZQ0K
PiA+ID4gbW1fc3RydWN0IG9mIHRoZSBwcm9jZXNzLiBtbV9pbml0IHdpbGwgY2FsbCBfX3BlcmNw
dV9jb3VudGVyX2luaXQNCj4gPiA+IGZvciBwZXJjcHVfY291bnRlcnMgaW5pdGlhbGl6YXRpb24u
IFRoZW4gcGNwdV9hbGxvYyBpcyBjYWxsZWQgdG8NCj4gPiA+IHJlYWQgdGhlIGJhc2VfYWRkciBv
ZiBwY3B1X2NodW5rIGZvciBtZW1vcnkgYWxsb2NhdGlvbi4gSW5zaWRlDQo+ID4gPiBwY3B1X2Fs
bG9jLCBpdCB3aWxsIGNhbGwgcGNwdV9hbGxvY19hcmVhICB0byBhbGxvY2F0ZSBtZW1vcnkgZnJv
bSBhDQo+IHNwZWNpZmllZCBjaHVuay4NCj4gPiA+IFRoaXMgZnVuY3Rpb24gd2lsbCB1cGRhdGUg
ImZyZWVfYnl0ZXMiIGFuZCAiY2h1bmtfbWQiIHRvIHJlY29yZCB0aGUNCj4gPiA+IHJlc3QgZnJl
ZSBieXRlcyBhbmQgb3RoZXIgbWV0YSBkYXRhIGZvciB0aGlzIGNodW5rLiBDb3JyZXNwb25kaW5n
bHksDQo+ID4gPiBwY3B1X2ZyZWVfYXJlYSB3aWxsIGFsc28gdXBkYXRlIHRoZXNlIDIgbWVtYmVy
cyB3aGVuIGZyZWUgbWVtb3J5Lg0KPiA+ID4gQ2FsbCB0cmFjZSBmcm9tIHBlcmYgaXMgYXMgYmVs
b3c6DQo+ID4gPiArICAgNTcuMTUlICAwLjAxJSAgZXhlY2wgICBba2VybmVsLmthbGxzeW1zXSBb
a10gX19wZXJjcHVfY291bnRlcl9pbml0DQo+ID4gPiArICAgNTcuMTMlICAwLjkxJSAgZXhlY2wg
ICBba2VybmVsLmthbGxzeW1zXSBba10gcGNwdV9hbGxvYw0KPiA+ID4gLSAgIDU1LjI3JSA1NC41
MSUgIGV4ZWNsICAgW2tlcm5lbC5rYWxsc3ltc10gW2tdIG9zcV9sb2NrDQo+ID4gPiAgICAtIDUz
LjU0JSAweDY1NDI3ODY5NmU1NTJmMzQNCj4gPiA+ICAgICAgICAgbWFpbg0KPiA+ID4gICAgICAg
ICBfX2V4ZWN2ZQ0KPiA+ID4gICAgICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUN
Cj4gPiA+ICAgICAgICAgZG9fc3lzY2FsbF82NA0KPiA+ID4gICAgICAgICBfX3g2NF9zeXNfZXhl
Y3ZlDQo+ID4gPiAgICAgICAgIGRvX2V4ZWN2ZWF0X2NvbW1vbi5pc3JhLjQ3DQo+ID4gPiAgICAg
ICAgIGFsbG9jX2Jwcm0NCj4gPiA+ICAgICAgICAgbW1faW5pdA0KPiA+ID4gICAgICAgICBfX3Bl
cmNwdV9jb3VudGVyX2luaXQNCj4gPiA+ICAgICAgICAgcGNwdV9hbGxvYw0KPiA+ID4gICAgICAg
LSBfX211dGV4X2xvY2suaXNyYS4xNw0KPiA+ID4NCj4gPiA+IEluIGN1cnJlbnQgcGNwdV9jaHVu
ayBsYXlvdXQsIOKAmGJhc2VfYWRkcuKAmSBpcyBpbiB0aGUgc2FtZSBjYWNoZSBsaW5lDQo+ID4g
PiB3aXRoIOKAmGZyZWVfYnl0ZXPigJkgYW5kIOKAmGNodW5rX21k4oCZLCBhbmQg4oCYYmFzZV9h
ZGRy4oCZIGlzIGF0IHRoZSBsYXN0IDgNCj4gPiA+IGJ5dGVzLiBUaGlzIHBhdGNoIG1vdmVzIOKA
mGJvdW5kX21hcOKAmSB1cCB0byDigJhiYXNlX2FkZHLigJksIHRvIGxldA0KPiA+ID4g4oCYYmFz
ZV9hZGRy4oCZIGxvY2F0ZSBpbiBhIG5ldyBjYWNoZWxpbmUuDQo+ID4gPg0KPiA+ID4gV2l0aCB0
aGlzIGNoYW5nZSwgb24gSW50ZWwgU2FwcGhpcmUgUmFwaWRzIDExMkMvMjI0VCBwbGF0Zm9ybSwg
YmFzZWQNCj4gPiA+IG9uIHY2LjQtcmM0LCB0aGUgMTYwIHBhcmFsbGVsIHNjb3JlIGltcHJvdmVz
IGJ5IDI0JS4NCj4gPg0KPiA+IENhbiB3ZSBoYXZlIGEgY29tbWVudCBzb21ld2hlcmUgYXJvdW5k
IHRoaXMgc3RydWN0dXJlIHRvIGF2b2lkDQo+IHNvbWVvbmUNCj4gPiByZXZlcnRpbmcgdGhpcyBj
aGFuZ2UgYnkgYWNjaWRlbnQ/DQo+ID4NCj4gDQo+IEkgYWdyZWUgd2l0aCBMaWFtLiBJdCB3YXMg
b25seSByZWNlbnRseSBwZXJjcHUgd2FzIGFkZGVkIHRvIHRoZSBtbV9zdHJ1Y3Qgc28NCj4gdGhp
cyB3YXNuJ3Qgb3JpZ2luYWxseSBvbiB0aGUgaG90IHBhdGguIEl0J3MgcHJvYmFibHkgd29ydGgg
cmVzaHVmZmxpbmcgYXJvdW5kDQo+IHBjcHVfY2h1bmsgYmVjYXVzZSBhcyB5b3UgcG9pbnQgb3V0
IGJhc2VfYWRkciBpcyByZWFkX29ubHkgYWZ0ZXIgaW5pdC4NCj4gVGhlcmUgaW4gZ2VuZXJhbCBh
cmVuJ3QgdGhhdCBtYW55IG9mIHRoZXNlIHN0cnVjdHMgb24gYW55IHBhcnRpY3VsYXIgaG9zdCwg
c28NCj4gaXRzIHByb2JhYmx5IGdvb2QgdG8ganVzdCBhbm5vdGF0ZSB3aXRoIF9fX19jYWNoZWxp
bmVfYWxpZ25lZF9pbl9zbXAgYW5kDQo+IHBvdGVudGlhbGx5IHJlc2h1ZmZsZSBhcm91bmQgYSBm
ZXcgb3RoZXIgdmFyaWFibGVzLg0KPiANClRoYW5rcyBMaWFtIGFuZCBEZW5uaXMgZm9yIHF1aWNr
IGZlZWRiYWNrLCBJJ2xsIHNlbmQgb3V0IHRoZSB1cGRhdGVkIHBhdGNoIHdpdGggY29tbWVudCBh
cm91bmQuDQoNCj4gQW5vdGhlciBvcHRpbWl6YXRpb24gaGVyZSBpcyBhIGJhdGNoIGFsbG9jYXRp
b24gd2hpY2ggaGFzbid0IGJlZW4gZG9uZSB5ZXQNCj4gKGFsbG9jYXRlIGVzc2VudGlhbGx5IGFu
IGFycmF5IG9mIHBlcmNwdSB2YXJpYWJsZXMgYWxsIGF0IG9uY2UsIGJ1dCBhbGxvdyBmb3INCj4g
dGhlaXIgbGlmZXRpbWVzIHRvIGJlIGluZGVwZW5kZW50KS4NCj4gDQo+IFBTIC0gSSBrbm93IEkn
bSBub3Qgc3VwZXIgYWN0aXZlLCBidXQgcGxlYXNlIGNjIG1lIG9uIHBlcmNwdSBjaGFuZ2VzLg0K
PiANCkxPTCwgc3VyZSA6KQ0KDQo+IFRoYW5rcywNCj4gRGVubmlzDQo+IA0KPiA+ID4NCj4gPiA+
IFJldmlld2VkLWJ5OiBUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBZdSBNYSA8eXUubWFAaW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4g
PiAgbW0vcGVyY3B1LWludGVybmFsLmggfCAyICstDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL21t
L3BlcmNwdS1pbnRlcm5hbC5oIGIvbW0vcGVyY3B1LWludGVybmFsLmggaW5kZXgNCj4gPiA+IGY5
ODQ3YzEzMTk5OC4uOTgxZWViMmFkMGE5IDEwMDY0NA0KPiA+ID4gLS0tIGEvbW0vcGVyY3B1LWlu
dGVybmFsLmgNCj4gPiA+ICsrKyBiL21tL3BlcmNwdS1pbnRlcm5hbC5oDQo+ID4gPiBAQCAtNDEs
MTAgKzQxLDEwIEBAIHN0cnVjdCBwY3B1X2NodW5rIHsNCj4gPiA+ICAJc3RydWN0IGxpc3RfaGVh
ZAlsaXN0OwkJLyogbGlua2VkIHRvIHBjcHVfc2xvdCBsaXN0cyAqLw0KPiA+ID4gIAlpbnQJCQlm
cmVlX2J5dGVzOwkvKiBmcmVlIGJ5dGVzIGluIHRoZSBjaHVuayAqLw0KPiA+ID4gIAlzdHJ1Y3Qg
cGNwdV9ibG9ja19tZAljaHVua19tZDsNCj4gPiA+ICsJdW5zaWduZWQgbG9uZwkJKmJvdW5kX21h
cDsJLyogYm91bmRhcnkgbWFwICovDQo+ID4gPiAgCXZvaWQJCQkqYmFzZV9hZGRyOwkvKiBiYXNl
IGFkZHJlc3Mgb2YgdGhpcyBjaHVuaw0KPiAqLw0KPiA+ID4NCj4gPiA+ICAJdW5zaWduZWQgbG9u
ZwkJKmFsbG9jX21hcDsJLyogYWxsb2NhdGlvbiBtYXAgKi8NCj4gPiA+IC0JdW5zaWduZWQgbG9u
ZwkJKmJvdW5kX21hcDsJLyogYm91bmRhcnkgbWFwICovDQo+ID4gPiAgCXN0cnVjdCBwY3B1X2Js
b2NrX21kCSptZF9ibG9ja3M7CS8qIG1ldGFkYXRhIGJsb2NrcyAqLw0KPiA+ID4NCj4gPiA+ICAJ
dm9pZAkJCSpkYXRhOwkJLyogY2h1bmsgZGF0YSAqLw0KPiA+ID4gLS0NCj4gPiA+IDIuMzkuMw0K
PiA+ID4NCj4gPg0K
