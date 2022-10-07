Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E615F7AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJGPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJGPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:44:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6F12AB2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665157497; x=1696693497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bz4sBVTTQbh/fg9UeNx9Bst9kCYRaZ+vtuDSRTgPUQg=;
  b=LzMiGWKYmCIhUomNPo6bOxObwyf/GVf6TXof5NujG1V2VMw853xvhVC6
   KSFuKjQt4eTB9E6TfZxSvE5YHBneEspbv/fIuQs072WOmps2XvV+oW7IY
   BpmJ8PRg5mcohK34IMjLofKqxkwpS+SplXgPLTI0GBcuie0OzFBIcdUZM
   KSgc7ZXKM9VJuxOZZ9QadCBUqOi+a8DIGbzG3hqtxxcyQLYNi1zYrqQ7S
   yXJ4McPxNCqcRvEYqVn5AzyrY9TZkGgms/JcUECCysK3WJHydXEiKGIaV
   CgrvHPum2dbhoKPozXkkUUBAFpDnocfPWKF9DA5GM0RPzIKUyTQWl6EJZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="304764022"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="304764022"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 08:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="750593542"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="750593542"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 07 Oct 2022 08:44:56 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:44:56 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 08:44:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 08:44:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 08:44:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UznSfMCVxMiOsCrKzp+9ockfsLjL0z5Y/HwrNSdi63ReAxFsoi4uoT9K/mY5PWfausaHL5lQZ2WyYQw8ZE7V5twxCCrk0iihsPmUWYitFftVJX3oTtKoAbTyfjjF6ciat4zmx/hdbC9esBZGjgCtJHPp3Wmk3ppx43jnuJUpdM6XTXxJtZQiwjI8oXC7hOjCcXfD7WASYsISfqsM4n4Uax9sctV+uyH/ZRdEXi906CRdW1i48jL6WG21WyZo3lAItvbkEYSJWoYMwV18QFnYdGsE5AvV1bLRuuwoJZd+aqke7ul4KTKm9oYn0wxQsbsaxZHOTdrzS41akcWQi/ZUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz4sBVTTQbh/fg9UeNx9Bst9kCYRaZ+vtuDSRTgPUQg=;
 b=StLZHTN20jR5Fo3lde5g/uKK7Jbx6/jxkYFnjtCtvUgrHon1WreRqK8VNDLvpOur+PLY6uLuItAi893kpc+OMhBMU2gYGfRMUPm+IdM3EO044dHxvZLUIvBRxMSaZ+tUQuh2JYABgJ+WuLTiT6sq8jvyjP9/TNhrQnE7+Ia+ePKxNgW22P1QjKJh4+wVdfWMLc1CMvblMKWfpeZNpzNvxXrcJ5rM8bfNpvtN7/TwNQhSjqGPdIU3Dd3I+EqYTksPKrXi0UOo63si8JIIOd7TcmEMXaKA0GWTgsIparWnRK+8gp94juMpgiNqcnJLdM11FC1i3OQUytC4RF+6JFJSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 15:44:53 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::41ec:63f7:b996:ecaa]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::41ec:63f7:b996:ecaa%4]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 15:44:53 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>
CC:     "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "James Morse" <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Topic: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Index: AQHY2jkmvJhDFvNe+UOP5fpzrFAn7K4DELqAgAABLdA=
Date:   Fri, 7 Oct 2022 15:44:53 +0000
Message-ID: <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
In-Reply-To: <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
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
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|DM4PR11MB5344:EE_
x-ms-office365-filtering-correlation-id: 1fc9716b-3101-4731-2b66-08daa87ae07f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2oUz0xnQZdeFKFAjm7pw1ErP8nfb4Szdh7NTPrxP+i/4SBLrF5ZegwparqzG0EFb/yNBmMn6KKm/UUfURqJpPrXe8mLsI28u5zWyL1aSijzrTJGZJe7RSVl1fIAmhOzfp1N4M1Uv+9mFz3da5iColXYfwlcAktgfIPjawmni5kYDxPcr/V9zEgp/KxfMaUcYPiYA+btjD/YFbcgoGdfT/p5IjpPhAAy0wjQ8J9014B+K3Cm/YFG3k+sO7v3Kf8JbydQXZx1mmns6VEvRbAnEJLHKiemxD6qCEjJJXkdCtSax1aNolEU3DiKVFlmFoahxAp03voTzqKf6ICTHoORuCE3IDwmesa7pTFnBBHt+W5/kbsayOCdXcA5HwnJo2Hjui3oXCLNH3ftnSlka3+8TOl4/bDXL8E6170YPaxKs4Epvy7yHbYjqPmfnm3SuVf/Y3YLKEXLIbJH/AQJ2BQOypRL9zeNpxqHUEBAuH0RHkeC2li1Gnti8ilhEgLtF4ucOFOoH6uanpVoFJy2oalHBZHA663ehDdmTkcQN6mb6h1FiLAdk8o/OvG92JyjxcYuuTwUzCQvMXj1xK5kyLdCP1LMYoaY836e2zjl33+wxvPhYFhEAwxekk1qRBy92AuGfJ66leAzAEKA2aucr7pgJKI22uJv6nyuU54YTCKnMEWsHMCLwCgZTkEirl8RZDV/OnujeDIAifXg2n3MdqJTfCODhD2bg5mzNgiE5eDpYNS4WzE093dvl2nsuj6EN6ZIzVxuA9bOlXKN6ScUMM3yImw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(53546011)(478600001)(83380400001)(71200400001)(110136005)(54906003)(9686003)(7696005)(6506007)(41300700001)(33656002)(4326008)(66446008)(107886003)(66476007)(8936002)(66556008)(66946007)(76116006)(64756008)(5660300002)(52536014)(8676002)(26005)(2906002)(86362001)(186003)(82960400001)(316002)(38070700005)(55016003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlg3N1ZmQ0h3aEN3T3V2aFNkWGZoR05nbmRYdnZKMXpvVEZCbGpGUHo3OW1w?=
 =?utf-8?B?blZOZitqTGQrMzdCUFVHeDFFVU1wNHAxVzZOYW1UY3FGWHpwQk03U0k3dmtY?=
 =?utf-8?B?dlV2c1RnTkZYaUErRGsxeWd3dTRtOFZ4Rk00UVRUcnQ3dllxZlBlbE9kNVhl?=
 =?utf-8?B?SVJ2NWowSW5rWHN4bWlJSk5MOTl1YU9GQUZCWnZlWUtjZmx0VjZyNzE1UzZ4?=
 =?utf-8?B?U2VPZ3ZGSXZsUUF1UUZXaVFURENSblRRV0F6dkdxRDNDUkE4TzgyUzlhT0l5?=
 =?utf-8?B?OFVEWWkxN25nWjczTllyS3laYW9WOTQ0NVlkY1R4TzErK2trK29sOEJlWVVs?=
 =?utf-8?B?RFV4N2FSQlFuUXNORUppRndzeGVyYjlBZHl2QnRyR2U4S1QwT1FPVUprZ3d3?=
 =?utf-8?B?aGtoQnJEK3Y2TTVUaGZkWDBGODFVaVFpTm1DOTZWOTN1dC9XSUY2a2FPa0Mw?=
 =?utf-8?B?UStVOGZUR3I3bGNFcFJlckpuZ1loWnhIRkI1MXNacWV0TXNONWFWS0c0bEl1?=
 =?utf-8?B?QW5vSEE4cHI5Mm5XNFR3QytNcXpSUWZTOXZYelFvU1pFNlp2aEhOOUtOYjY2?=
 =?utf-8?B?S2F0bGpuUUhBMEpqMGE3UUZQVEg5SStHUDhrRlF3Vm5FRTIzNE16Q0N3Qk9m?=
 =?utf-8?B?RjJtMllXZW1ITXg1dVhCendMQ2FoSGxyMm5rWHN6Ynp5MXBXQ2JvNlI5cGJD?=
 =?utf-8?B?akU1T1NDQktoUE9ZaDVWQi9OT2lvQ21pRGxvVm5rSHI1YXk4VjUzeDNUVnZT?=
 =?utf-8?B?aHVDblp0YnMrYzBoeW5wOFczeENKTW43UzlpYUtjdXZpbERYb090VmFTdzZo?=
 =?utf-8?B?dGJhVzE3dHdxcEhuVFJNR3J3alU0RTlwYm9yMEFqL0tkL2s1VmozaG5TWmFV?=
 =?utf-8?B?YWljeWJBbUprRGNmMERub0NHamtwbmJSOEpqVWUweDB5LzMzQWhkNk5uNjJk?=
 =?utf-8?B?Z25uNThaOHlOTndWZU0rTU5VYWRTNGowc3BxMWZnc1Zyc2VoVzIrWkxGTGpZ?=
 =?utf-8?B?QUJwR05qc2pxYUdRVUhTT0lDMlIrYlJWK0o2RUlpVDFISnV4ZXgzSDYvcjVl?=
 =?utf-8?B?NkllSWl3QUo3ZlRDaXN0S2pHUjlhWDVXeHZCakw2UkludGhVK2NMOEtrY3JU?=
 =?utf-8?B?SktDR2Fzd21OWjFIck8rb25TY25Ca2FwbzB1ek5ncGRUNmJRMVZxN29ydWRY?=
 =?utf-8?B?ekQyOGpWQ1J2UUpLTTQ2UXBVR09NK2w0b20ranpvb0pRUEYzbGFLUERUQzNF?=
 =?utf-8?B?UGh0V2pGQnJVZEN6TjhWRUtYUW9HeGltaURzQVRuMXp2ZytlN0F6ajlwd1ZM?=
 =?utf-8?B?cUdrWHRmTGUzUGZ3V2JGK2tkd04xVXhBdWhKc08vYkd3REd3dG1HVXNTOXJN?=
 =?utf-8?B?VHZld3k3WWlFNWR6amY4UWtvdmZlUjRZallKVkg1VVhuUGxZRC8wOTVUYUtz?=
 =?utf-8?B?OFBWTU54Sk50QzJnRlJBTlVwczk2ZkZxbEJLTXJ4Z1U5a1FWRHovQTJpaEdY?=
 =?utf-8?B?UWNObjR6dHA4c3poYUJpWkRIcCtrdjA4V0k4UlpSdm9hbUFyWmc4VVgvYWll?=
 =?utf-8?B?ai9YU1JrSkIzUkNBY2k1empiRWtqNXdTckxrRzRBRTZoUnBidmkrTFZNSlp4?=
 =?utf-8?B?WkUwc0NZYUc5NkhQZGRPaE1tK0Y4Zys5aHNjNjRlVnR5N05aR2dTSU50VWVN?=
 =?utf-8?B?K2hIWWFFKy9TQ2VjbmxwTWNQb0M1WjhTV0wxNCs5RHVwaFg3enV0aG9PdEpN?=
 =?utf-8?B?dXVxRTFDdllDUjl5dGhXbUxXUVNLd3ArWjJiNXowRmlVOWdmVit2QkxBMXRU?=
 =?utf-8?B?bW5sa1kvY2Q5b2dla1Jpd3A5ZGYvVmJWRlVUMGR1QW1hVk5rb0NaMC96QnFz?=
 =?utf-8?B?MFJ2V1I2STU5bFFTem51Mkp3NG9nYXV4OHRJajF1THZVTHh6MXg0N3pobnRX?=
 =?utf-8?B?cUwvYjJEVzRDUFNUVGFHTldjcTN0UFgzK1hQWms0VEswZmVvWTI3RGNlQnlq?=
 =?utf-8?B?M0V5dWh3RG1ESnhOcGhhOVFaazM2NGxqTFFPTEdxRnVJV0tybWpieVV2QnBG?=
 =?utf-8?B?QlRnZWlHSkxkdjc0RGIxQ2k2RnRpclhUWmFYOC8zUFp5ZDd2bis4eVNxVEdt?=
 =?utf-8?Q?9gWcxYPpMCWVUk/bN0WUUD/mr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc9716b-3101-4731-2b66-08daa87ae07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 15:44:53.1784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /QiU6L9Qd0I+8pxXLyBTJkuQXS5ZvgvxOzHfrzKP0oPEHgpQOTO/FAnPBTDwv5jcEnFEIFT/PBhaTfeEnyhXrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
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

SGksIFBldGVyLA0KDQo+IE9uIDEwLzcvMjAyMiAzOjM5IEFNLCBQZXRlciBOZXdtYW4gd3JvdGU6
DQo+ID4gSGkgUmVpbmV0dGUsIEZlbmdodWEsDQo+ID4NCj4gPiBJJ2QgbGlrZSB0byB0YWxrIGFi
b3V0IHRoZSB0YXNrcyBmaWxlIGludGVyZmFjZSBpbiBDVFJMX01PTiBhbmQgTU9ODQo+ID4gZ3Jv
dXBzLg0KPiA+DQo+ID4gRm9yIHNvbWUgYmFja2dyb3VuZCwgd2UgYXJlIHVzaW5nIHRoZSBtZW1v
cnktYmFuZHdpZHRoIG1vbml0b3JpbmcgYW5kDQo+ID4gYWxsb2NhdGlvbiBmZWF0dXJlcyBvZiBy
ZXNjdHJsIHRvIG1haW50YWluIFFvUyBvbiBleHRlcm5hbCBtZW1vcnkNCj4gPiBiYW5kd2lkdGgg
Zm9yIGxhdGVuY3ktc2Vuc2l0aXZlIGNvbnRhaW5lcnMgdG8gaGVscCBlbmFibGUgYmF0Y2gNCj4g
PiBjb250YWluZXJzIHRvIHVzZSB1cCBsZWZ0b3ZlciBDUFUvbWVtb3J5IHJlc291cmNlcyBvbiBh
IG1hY2hpbmUuICBXZQ0KPiA+IGFsc28gbW9uaXRvciB0aGUgZXh0ZXJuYWwgbWVtb3J5IGJhbmR3
aWR0aCB1c2FnZSBvZiBhbGwgaG9zdGVkDQo+ID4gY29udGFpbmVycyB0byBpZGVudGlmeSBvbmVz
IHdoaWNoIGFyZSBtaXN1c2luZyB0aGVpciBsYXRlbmN5LXNlbnNpdGl2ZQ0KPiA+IENvUyBhc3Np
Z25tZW50IGFuZCBkb3duZ3JhZGUgdGhlbSB0byB0aGUgYmF0Y2ggQ29TLg0KPiA+DQo+ID4gVGhl
IHRyb3VibGUgaXMsIGNvbnRhaW5lciBtYW5hZ2VyIGRldmVsb3BlcnMgd29ya2luZyB3aXRoIHRo
ZSB0YXNrcw0KPiA+IGludGVyZmFjZSBoYXZlIGNvbXBsYWluZWQgdGhhdCBpdCdzIG5vdCB1c2Fi
bGUgZm9yIHRoZW0gYmVjYXVzZSBpdA0KPiA+IHRha2VzIG1hbnkgKG9yIGFuIHVuYm91bmRlZCBu
dW1iZXIgb2YpIHBhc3NlcyB0byBtb3ZlIGFsbCB0YXNrcyBmcm9tIGENCj4gPiBjb250YWluZXIg
b3ZlciwgYXMgdGhlIGxpc3QgaXMgYWx3YXlzIGNoYW5naW5nLg0KDQpBcmUgdGhlICJhbGwgdGFz
a3MiIGNoaWxkcmVuIG9mIHRoZSBjb250YWluZXIgcHJvY2Vzcz8gSXMgaXQgcG9zc2libGUgdG8g
bW92ZSB0aGUNCnBhcmVudCBjb250YWluZXIgcHJvY2VzcyBhbmQgaXRzIGFsbCBjaGlsZHJlbiB0
YXNrcyB0byBhIGRpZmZlcmVudCBncm91cCBpbiBvbmUgc2hvdA0KaW5zdGVhZCBvZiBvbmUgYnkg
b25lPw0KDQo+ID4NCj4gPiBPdXIgc29sdXRpb24gZm9yIHRoZW0gaXMgdG8gcmVtb3ZlIHRoZSBu
ZWVkIGZvciBtb3ZpbmcgdGFza3MgYmV0d2Vlbg0KPiA+IENUUkxfTU9OIGdyb3Vwcy4gQmVjYXVz
ZSB3ZSBhcmUgbWFpbmx5IHVzaW5nIE1CIHRocm90dGxpbmcgdG8NCj4gPiBpbXBsZW1lbnQgUW9T
LCB3ZSBvbmx5IG5lZWQgdHdvIGNsYXNzZXMgb2Ygc2VydmljZS4gVGhlcmVmb3JlIHdlJ3ZlDQo+
ID4gbW9kaWZpZWQgcmVzY3RybCB0byByZXVzZSBleGlzdGluZyBDTE9TSURzIGZvciBDVFJMX01P
TiBncm91cHMgd2l0aA0KPiA+IGlkZW50aWNhbCBjb25maWd1cmF0aW9ucywgYWxsb3dpbmcgdXMg
dG8gY3JlYXRlIGEgQ1RSTF9NT04gZ3JvdXAgZm9yDQo+ID4gZXZlcnkgY29udGFpbmVyLiBJbnN0
ZWFkIG9mIG1vdmluZyB0aGUgdGFza3Mgb3Zlciwgd2Ugb25seSBuZWVkIHRvDQo+ID4gdXBkYXRl
IHRoZWlyIENUUkxfTU9OIGdyb3VwJ3Mgc2NoZW1hdGEuIEFub3RoZXIgYmVuZWZpdCBmb3IgdXMg
aXMgdGhhdA0KPiA+IHdlIGRvIG5vdCBuZWVkIHRvIGFsc28gbW92ZSBhbGwgb2YgdGhlIHRhc2tz
IG92ZXIgdG8gYSBuZXcgbW9uaXRvcmluZw0KPiA+IGdyb3VwIGluIHRoZSBiYXRjaCBDVFJMX01P
TiBncm91cCwgYW5kIHRoZSB1c2FnZSBjb3VudHMgcmVtYWluIGludGFjdC4NCj4gPg0KPiA+IFRo
ZSBDTE9TSUQgbWFuYWdlbWVudCBydWxlcyB3b3VsZCByb3VnaGx5IGJlOg0KPiA+DQo+ID4gIDEu
IElmIGFuIHVwZGF0ZSB3b3VsZCBjYXVzZSBhIENUUkxfTU9OIGdyb3VwJ3MgY29uZmlnIHRvIG1h
dGNoIHRoYXQgb2YNCj4gPiAgICAgYW4gZXhpc3RpbmcgZ3JvdXAsIHRoZSBDVFJMX01PTiBncm91
cCdzIENMT1NJRCBzaG91bGQgY2hhbmdlIHRvIHRoYXQNCj4gPiAgICAgb2YgdGhlIGV4aXN0aW5n
IGdyb3VwLCB3aGVyZSB0aGUgZGVmaW5pdGlvbiBvZiAibWF0Y2giIGlzOiBhbGwNCj4gPiAgICAg
Y29udHJvbCB2YWx1ZXMgbWF0Y2ggaW4gYWxsIGRvbWFpbnMgZm9yIGFsbCByZXNvdXJjZXMsIGFz
IHdlbGwgYXMNCj4gPiAgICAgdGhlIGNwdSBtYXNrcyBtYXRjaGluZy4NCj4gPg0KPiA+ICAyLiBJ
ZiBhbiB1cGRhdGUgdG8gYSBDVFJMX01PTiBncm91cCBzaGFyaW5nIGEgQ0xPU0lEIHdpdGggYW5v
dGhlciBncm91cA0KPiA+ICAgICBjYXVzZXMgdGhhdCBncm91cCB0byBubyBsb25nZXIgbWF0Y2gg
YW55IG90aGVycywgYSBuZXcgQ0xPU0lEIG11c3QNCj4gPiAgICAgYmUgYWxsb2NhdGVkLg0KPiA+
DQo+ID4gIDMuIEFuIHVwZGF0ZSB0byBhIENUUkxfTU9OIGdyb3VwIHVzaW5nIGEgbm9uLXNoYXJl
ZCBDTE9TSUQgd2hpY2gNCj4gPiAgICAgY29udGludWVzIHRvIG5vdCBtYXRjaCBhbnkgb3RoZXJz
IGZvbGxvd3MgdGhlIGN1cnJlbnQgcmVzY3RybA0KPiA+ICAgICBiZWhhdmlvci4NCj4gPg0KPiA+
IEJlZm9yZSBJIHByZXBhcmUgYW55IHBhdGNoZXMgZm9yIHJldmlldywgSSdtIGludGVyZXN0ZWQg
aW4gYW55DQo+ID4gY29tbWVudHMgb3Igc3VnZ2VzdGlvbnMgb24gdGhlIHVzZSBjYXNlIGFuZCBz
b2x1dGlvbi4NCj4gPg0KPiA+IEFyZSB0aGVyZSBzaW1wbGVyIHN0cmF0ZWdpZXMgZm9yIHJlYXNz
aWduaW5nIGEgcnVubmluZyBjb250YWluZXIncw0KPiA+IHRhc2tzIHRvIGEgZGlmZmVyZW50IENU
UkxfTU9OIGdyb3VwIHRoYXQgd2Ugc2hvdWxkIGJlIGNvbnNpZGVyaW5nIGZpcnN0Pw0KPiA+DQo+
ID4gQW55IGNvbmNlcm5zIGFib3V0IHRoZSBDTE9TSUQtcmV1c2luZyBiZWhhdmlvcj8gVGhlIGhv
cGUgaXMgZXhpc3RpbmcNCj4gPiB1c2VycyB3aG8gYXJlbid0IGNyZWF0aW5nIGlkZW50aWNhbGx5
LWNvbmZpZ3VyZWQgQ1RSTF9NT04gZ3JvdXBzIHdvdWxkDQo+ID4gYmUgbWluaW1hbGx5IGltcGFj
dGVkLiBXb3VsZCBpdCBoZWxwIGlmIHRoZSBwcm9wb3NlZCBiZWhhdmlvciB3ZXJlDQo+ID4gb3B0
LWluIGF0IG1vdW50LXRpbWU/DQo+ID4NCg0KVGhhbmtzLg0KDQotRmVuZ2h1YQ0K
