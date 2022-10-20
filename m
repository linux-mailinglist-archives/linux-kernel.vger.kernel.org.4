Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C499E605494
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJTAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJTAuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:50:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837D80513;
        Wed, 19 Oct 2022 17:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666227006; x=1697763006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wbuLO7SUWVm4XVv98UgZ5JmpVZ0RHtIa75TP1HC/loo=;
  b=V86+2UVWR3tk2eRScUQgndFo7OlHvbv2h9K+TnJXnzOGidOoY4qVn+Aq
   MmgZxilSA2Dqu23BjUzqUMB8cnW8YaNosRDJzyK8rxhG3iHZhDjUhgnP1
   FMBho+i2jxuSFj5ITNCnrOq0c1ei6EmyS7kyjMOIL7/Ts9mgeNNl486hT
   DzKGzUo1AdyV+GHNtRAN/mJfj6c+ulVjcshmj7mJdykRCR57G9BNH2o0j
   gKio/9ZJ4ZjH8PVz5mt25mjRXzj+/ArsFdDgqjwL5I7h+yYkrzD0g0GjV
   d0n86iA2A8ACJTbVv4vBVMmgcsQA+gZcS6tZVBcjXE7g956kQxHmL3sLJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="306559668"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="306559668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 17:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="629513872"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="629513872"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 19 Oct 2022 17:50:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 17:50:05 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 17:50:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 17:50:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 17:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJIeBtL8iLmeZB03gXrDCq+60qsCjayQY0PN94oL0CMsHffu5uifVulgs5rSk5Fie3/qr4/CsvGxWmh6FdXDmzQQ+Zq/bpPNudDdKBUOHh5deXOvVu6KyfSIZWgZLjPOsT+M8SpPzjCBMiRB7FECXjZjG1vytr5df2AT/n+/lHnBGPo+eJrGYa+SJi02T8mPvGzZGBo5IPMYU7J97YTbw0xAkQxU7/Co/+HZtBghrfqDREbio1WSV2P1Zuco6dPIBNLHNrul74u90YiunRb2K00dXanmK4nNHP0O5YYgizFUi6Kgxo76B65TVcGvVyoTNTSIKmzY5doTGz+KagV9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbuLO7SUWVm4XVv98UgZ5JmpVZ0RHtIa75TP1HC/loo=;
 b=Wvz8L6agiUTxkQ8RGstGBKnHPODIc3CLOJC7omhCq6K5iyhy4g7TTqnba6TLBtlHJomcGkXrQ5MLVGiFjT+bIfPK5TLSzddvUtXCxc5f+WlGtt4nPDaAt8h2AqClKWHAkqjODsnYbYV/Wr8kPBkjsu34Y07WWJ3Cf2yH/WC/0pC/lgEYNXZh5THkL+hf624lMq8eckEUmuh5kSrSo9MaGsDNutIeiDq9VZ0egsuwtDQnrHwcwKxXE7yvvlr7p24D3cH7Z/XiX1cbgLTsUjX1kU7nIA64Ye6R7on+ggMXLw/ylq9SvEDK9BIm8Ip1m69Gkk0hBuqoGXc1Axl7ZAWgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS7PR11MB6013.namprd11.prod.outlook.com (2603:10b6:8:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 00:49:56 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%8]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 00:49:56 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is
 enabled
Thread-Topic: [PATCH v2] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY
 is enabled
Thread-Index: AQHY5BMiqtn9aRLISUax1EEE3mTeOq4WY6yAgAAPEUA=
Date:   Thu, 20 Oct 2022 00:49:56 +0000
Message-ID: <PH0PR11MB58809A4318B47FA8669C4360DA2A9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221019233835.395474-1-qiang1.zhang@intel.com>
 <20221019235257.GJ5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221019235257.GJ5600@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DS7PR11MB6013:EE_
x-ms-office365-filtering-correlation-id: 8c249071-e000-4773-266c-08dab235025a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AB8eacaC0A10R3NSRprTogrwcx3N+1BVJgU5YT6VawoRI8hoc+uE6tuJsQ7sNtC9xnN4tKZdSa5I8rVr5ULIrERRjH7WOmACt6FDd4kRI/CLnVpmYmslzGkEMdJutgcXUQGd2uqmkWIgerMKPI0etEdb06IZCbRm0LJPJLnMmQ/QoZF4PsDO+8RoR7Ky4T7jCIPussqQy+k9IHF6mh6aFyDMCw5xy5LXhyAF0ROMy41S6yjD6XvyLf+Ri4NXvFufHt+KsGN5FV7MV/sfdL381owYMvqsOt2jtam6UCmr21fTTjfYn35fGV7HTEimLd3V55ZMtk5W9kl8RAooBmvZXW/uBfv8yqXzMH6eX+MoFfUMEa3hGvAch2ZfcQGkQWCcG/53u5yRwOdWu4r8Rn9NXV0Wy6Jp/A+myJVDpU5YpFs6sV+R/rIt1KBvYxPxbdvg3UdpPimB4k0UIucglUrm0yQPaa6GKSwqbM7/DccGzpwz94WS/y/DwTKNkHw35ZHpuDU9w7cpQrK2ts44QeSz1MiiNDnMAAdjZ1CMkBiQqrR2fRW2/yMMw2iTJeOGtxgfvdOhpvkFQqfr8wBa7/pJpa2ndzTE8GEWq4ucFDBi+GwugPPB0WC0mphHlrP04EywKrxEKi+onRNAT0ZYBWK7mnBykMbB+beP0AYSBU4qsZVxl9BgPXR2HFbSBA6EkYOG2kPyAmMnQRkwGQsqf0TWKlhIMn9sxK3x8AV4Zag+tCe0zlulJOXip8oBJ7fBUazut3w2pHArOohcdR7fKL8JHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199015)(6506007)(7696005)(122000001)(41300700001)(9686003)(26005)(6916009)(54906003)(66556008)(76116006)(64756008)(66946007)(66476007)(66446008)(8676002)(33656002)(82960400001)(478600001)(4326008)(86362001)(38100700002)(2906002)(71200400001)(55016003)(38070700005)(316002)(83380400001)(52536014)(5660300002)(8936002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhHWnZWU2IveVFKb3BENmFuM2hJVitSTEhUV2I3QUZYdjRmRXNCSGMxekRw?=
 =?utf-8?B?eTRrK1gvaGlPZndRWWY5RVA0azRlVXM3RnZqeXZpemhXZXM3Vy9rOWwvQ1hV?=
 =?utf-8?B?WTg1cFo3U3d0eHZtQ0NyeWlQQks5d1QvN1ZxSVgwS0prdlVCdXZ0Qkp2QkYv?=
 =?utf-8?B?dGI2K0RYUzFZVEJ0NG1LU2pGdmMvS2JGdzI2djlsa2tHQlpEZXFJeHhNcDZv?=
 =?utf-8?B?bU5uS25RVEJDMzkzMmRTRVBVY0p2UVhYT3lieFFCYUk5eDZJNGUyaVpOVHJv?=
 =?utf-8?B?OEYyTVY1L0pKUU9WL2grRlV2NWFTTmhGVDlNM211dy8yTDM5N2h0Sml5akJs?=
 =?utf-8?B?NFdLdTErSTUvMHBuTGpNalJUaU1UVWF1Tzh6aHlFbHJpZ0pjUzl2Y25SSTNT?=
 =?utf-8?B?c0UrYUxmT1FKUkhKcC9pWDhzU1hybFU1UXV6V1ZtMVF2ZXlMMGxDVVp3Y3h1?=
 =?utf-8?B?Z3JOeUtOVGlEcDhtVWZHV1R5WmpCSmQ3TE9jQXFUL1d1MVlrdG9lRGZTOWVy?=
 =?utf-8?B?SjZ1aUpNeCtQUkxtMEd4WktncDkwWCtYVHdwR1dYTGtzaXYvbVpNS3VjNytN?=
 =?utf-8?B?THF3N1VxU2RJKzg2V0h1S1ZoWTU1anlmWE5KRStzNHlhVUpFRS9Pd2h3bE9R?=
 =?utf-8?B?aHJhU2RsZk9PK21aMDVLVmJmdzRMVmRLK3BQaEVYTlpLWUtsOURFdVUyQ0d0?=
 =?utf-8?B?eENhRW1vV1JFYmVXcEQ4YmFBVDhaRnNpSXVld0pZYlFSUTBFQWpkMmxhVHpX?=
 =?utf-8?B?dWIrZ1BFNkJZNmxoSlBwU2pYU1o3Y0JPQ0E2cjMvR0hpVFBJRUxqekJLK3Ux?=
 =?utf-8?B?SmtHdEE1UXVoakVrWisraXBEYXA3MjlybEdTTm1xeTZRUC9vUWs1SDhvT3gr?=
 =?utf-8?B?YmY2QVo0SVdaOWU2MVNQMWZmb2hDMSsxZGhjU1prMi84anhjZUE1ZXlaWEdp?=
 =?utf-8?B?dmpUWThodzdFTzJXcjJ0dy9QK3RCTjhQZy9pMTUrNzJrandkbUdnUHBWODVR?=
 =?utf-8?B?S0FyN3BoQWhFMjdDTHJ5L3IwQUcxSWNZV3c0QlFRMmZFTmpCM011WHcydEI2?=
 =?utf-8?B?ckxWa0tCcWZHdHI1NWZERHpGdHNwVDEzRWFuUVV2ZytvYTFvVkJlOEtsckNp?=
 =?utf-8?B?MFpOTWpidEh3T284aUVZclFRSHRkWi9uOGJTVDZQbVE4TUJTVm1TMDRVbkt0?=
 =?utf-8?B?MmxoV3FkbXpaY3pvejhrWVRhV3JrOWUxOGlYSWRFTXNKMTk1NS9YSDZFQkhp?=
 =?utf-8?B?dW5KU0xvcE8rNEQ3dmlyc2tlU2htR2F0UGVjNnFHWFQ2WXNvcmFsdHRrRHha?=
 =?utf-8?B?NWNMQkJnV2RPMUxIaG11QTkzdXNXRWZtblVZMEgwMVgyekJOaVJXS200WEM2?=
 =?utf-8?B?SFcrTSt3ZEhqUnBKZWhQaWdQSlhaWFlTN3VJUVlCM0dTTUhCZ2Q3QVFFMDl6?=
 =?utf-8?B?R1dLYTA0S3dNNlVlZ0g1dmFUNzR0K1RIVitkRWdlbVpHVWNISDQvYUVCYkZD?=
 =?utf-8?B?NWxadi9YUkx6RmJwWGxSTmZ2bGdCbTlLSU5kL3pqd0NHd1ZsWE1rL3JxNGgz?=
 =?utf-8?B?WTBzb1RlMHJDRW1xUllIN1VHUm1vS1ptbXhwOURPVGRURlNGSkpHUmZpSlN5?=
 =?utf-8?B?NFhQV2FuTGMwUzJ5aENGVHFRVmVMRnNvcnVPUmVJd0plTHh3a1VIeHZYakQ0?=
 =?utf-8?B?WXJWOC9jQ0k4UXIzU0RVVWpQTXgwTGltMnN6MStvSU43ZHo2d0F6cWdwdTE2?=
 =?utf-8?B?YytMeEpVV2tDNDlSdXF4N3ZJb28zQWFsV2pLVHhhUDlha3c0K0FlZG03V2Mz?=
 =?utf-8?B?NWhCOG8xanFQdGVlNTMvTE5MMmFrMk9GTlRDY1VNekRUWWhYaUVsN09qY3JP?=
 =?utf-8?B?ZmswYXdyQTJLVXpONEYyVG5Gdk1kdHl0V2FBL1BFcTFUR0hrNm5SY3c5SDI1?=
 =?utf-8?B?NnFiQkJLRXRTVy9MOFo2VElPR2tJWmpjUURiNWFWRVQ5T0UwcWRGZnZkY28w?=
 =?utf-8?B?bmVQNzQ1NFZyWjV3a3o5ZDNGdzZETUVnSTRpSnpQTm5ZeWU1N2ZWMDFhUVBk?=
 =?utf-8?B?a3A1bURJSkJZZkxsQVl3OThPNlNaemhvc0ZaeE5vRkhiRWRWcHdIZjJBNDhN?=
 =?utf-8?Q?r3vYnBWdMUnT1zuVYhO0Xdbxk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c249071-e000-4773-266c-08dab235025a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 00:49:56.8351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ld6TP0dIi/ZqJ5wUwM2AOWn/AZQM/awpml94hKYEE5lWglFMot9WWo6voQ/Xam2vBPbONRtGwF2K1GexQRdVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6013
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBPY3QgMjAsIDIwMjIgYXQgMDc6Mzg6MzVBTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0K
PiBDdXJyZW50bHksIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB0aGUgQ09ORklHX1JDVV9MQVpZIGlz
IGVuYWJsZWQsDQo+IGludm9rZSB0aGUgY2FsbF9yY3UoKSBpcyBhbHdheXMgbGF6eSwgaXQgYWxz
byBtZWFucyB0aGF0IHdoZW4NCj4gQ09ORklHX1JDVV9MQVpZIGlzIGRpc2FibGVkLCBpbnZva2Ug
dGhlIGNhbGxfcmN1X2ZsdXNoKCkgaXMgYWxzbw0KPiBsYXp5LiB0aGVyZWZvcmUsIHRoaXMgY29t
bWl0IG1ha2UgY2FsbF9yY3UoKSBsYXp5IG9ubHkgd2hlbg0KPiBDT05GSUdfUkNVX0xBWlkgaXMg
ZW5hYmxlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVs
LmNvbT4NCj4gLS0tDQo+ICB2MS0+djI6IA0KPiAgVXNlIElTX0VOQUJMRUQoQ09ORklHX1JDVV9M
QVpZKSB0byB0aGUgZXhpc3RpbmcgZnVuY3Rpb24gb2YgdGhlIHNhbWUgbmFtZS4NCj4gDQo+ICBr
ZXJuZWwvcmN1L3RyZWUuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUu
YyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+IGluZGV4IGFiYzYxNTgwOGI2ZS4uZWNmNDJiMGQzNzI2
IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvcmN1L3RyZWUuYw0KPiArKysgYi9rZXJuZWwvcmN1L3Ry
ZWUuYw0KPiBAQCAtMjg4Nyw3ICsyODg3LDEwIEBAIEVYUE9SVF9TWU1CT0xfR1BMKGNhbGxfcmN1
X2ZsdXNoKTsNCj4gICAqLw0KPiAgdm9pZCBjYWxsX3JjdShzdHJ1Y3QgcmN1X2hlYWQgKmhlYWQs
IHJjdV9jYWxsYmFja190IGZ1bmMpDQo+ICB7DQo+IC0JcmV0dXJuIF9fY2FsbF9yY3VfY29tbW9u
KGhlYWQsIGZ1bmMsIHRydWUpOw0KPiArCWlmIChJU19FTkFCTEVEKENPTkZJR19SQ1VfTEFaWSkp
DQo+ICsJCXJldHVybiBfX2NhbGxfcmN1X2NvbW1vbihoZWFkLCBmdW5jLCB0cnVlKTsNCj4gKwll
bHNlDQo+ICsJCXJldHVybiBfX2NhbGxfcmN1X2NvbW1vbihoZWFkLCBmdW5jLCBmYWxzZSk7DQoN
Cj4NCj5UaGlzIGlzIG11Y2ggYmV0dGVyLCBidXQgd2h5IG5vdCBzb21ldGhpbmcgbGlrZSB0aGlz
Pw0KDQpZZXMsIGl0IGxvb2tzIGJldHRlciwg8J+Yii4NCg0KPg0KPglyZXR1cm4gX19jYWxsX3Jj
dV9jb21tb24oaGVhZCwgZnVuYywgSVNfRU5BQkxFRChDT05GSUdfUkNVX0xBWlkpKTsNCj4NCj4J
CQkJCQkJVGhhbngsIFBhdWwNCg0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoY2FsbF9yY3Up
Ow0KPiAgDQo+IC0tIA0KPiAyLjI1LjENCj4gDQo=
