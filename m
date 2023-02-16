Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92709698C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBPGIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPGH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:07:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193DD1420E;
        Wed, 15 Feb 2023 22:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676527676; x=1708063676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Aq3DFLjmCqes1Gb2yHmOWjnxgdZqc1d7LyH9oYWqkDY=;
  b=eV5405fP73CGa/Farcp4i1rkQF9pJE3yFB59VV5+PXlZMBiF06gjkA8F
   /uSxgm1DVhgt1EXFBlBSB47D2K7ErNzE9RkHfKX/LeBIY6Sd/+jYBCcpr
   ooKM39Dzba2jW7JOe9/G+XQANmEYSgFdO3odpe4V9OZE+t46Ild6IlH0H
   KGquyf9Ztrb/S/jq+LdrifGj6od6VxU6nBwgjFdexX0snLp/Uwm2AzIdw
   HRD7EQkrFSyXqrK0Te7lLUs1BSiKUhl4pyICoqAU7w82chiLVKy7JuUyq
   HfatgQnEv8x3vFZ2lZ/IX710KdsmBzMjeJAqs4+fCNIfiNAz98bIQNMCq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="332957816"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="332957816"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 22:07:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="672037333"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="672037333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 15 Feb 2023 22:07:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 22:07:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 22:07:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 22:07:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 22:07:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgh2z/G1uS8U+gP/ln6Y0jj5QFYERIU03Jlf4WXyRfou5FRPjN6Y04Xfx6ZWFZzHz9/tRUKUbcGd7ANR57u3ghnpiSbujDXaxR9eNIGwiO4lPHj4lJHlBMDbhxk4fSX570iSpiD2mj/LpL5b1L14LaMdieqvcIy1Ygj58i55P6dXS374YTsElthsvVFOGfADLUUYANBUX2RAPH/+yB1ZC/XaBioFEz/5LFd58zb2w4c/CneBfn4p3kbMtw7UEZsVcyjmxZ+LhLUX1wYVYJLrEQomOwZ+q3R60CczWhJ0mvi/+2u888DpXFLDSYrP69m6VHYM7TRSK70j3imUveauYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq3DFLjmCqes1Gb2yHmOWjnxgdZqc1d7LyH9oYWqkDY=;
 b=Oi0otrTFDEHBYJOP29Q/VYbo7aKXDtB0iGTNStCZYa6qTGuQZovYVarvu+xERlXY3BK2+q0lkwMBLWfTZlzYQ+31+zAj0wCUufUyX5YbWCuUoujhld+8GHIQOZx0sTsBKgNjojHEgSFb3Ow8VM4eH2W41WOiXUynqst/OfH4fZwGEsp1l/tehT3bWBJlglHg35PjlxcrTL9oLniIPcuNdz4/trglkkmeZRYlGMCaBRUGSR+lA+0tF4YSKBcowlt0OAS9aTvc0ZssNmDhHCKKPmarJ8YMwqrJinQc1E705gzywVf59KHEGET7iLQwhR4dS/+jNkPrOFG/tVFpdX/J/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 06:07:51 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 06:07:51 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
Thread-Topic: [PATCH v2] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
Thread-Index: AQHZPOIDJWGM7YhpLkqPODfumLDrA67QImgAgAD4ajA=
Date:   Thu, 16 Feb 2023 06:07:51 +0000
Message-ID: <PH0PR11MB58804706BEA2ADC92FD86C21DAA09@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230210000021.1007853-1-qiang1.zhang@intel.com>
 <CAEXW_YSdXWcM_WO8FNNAs_sy=d=dwd7Ox9Aayucu9hgJ9BLhHQ@mail.gmail.com>
In-Reply-To: <CAEXW_YSdXWcM_WO8FNNAs_sy=d=dwd7Ox9Aayucu9hgJ9BLhHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW5PR11MB5785:EE_
x-ms-office365-filtering-correlation-id: 770ef755-49f1-45da-2453-08db0fe422ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93Ooic9tKyP95verW3WY/s4EYJVF2p7Z8V6UrOSeqRi4o0XxDHVVolJQSttJYyX7GMkUElCX+Jhs3lsGIN6oiWSey/ON97Q031GEGclWQS/a/OIgcgBkUOoPQCd2DJHobH3g/a1dA12rKQpXDdSunj0c1aRNfQRrodOikaGfIPWKZo3iG6vrK0Urjosf6b9c5br+1QJY5mCfI3JDPQ1z+MVTQfdNFpXrll2jdpccgzr/poDEXpXUR0GAEHhkAJy3V0bfJhgMoNJ3F3FVlRI38IaBfhdJ3NZMHIy1FTrFND8EJcrobP3FNDoY1NPe4Bp3yYv61weQ77AdNGd/i5J4VhAXrb4fyCLSEnjhRMFTyt/hLRk0zxB8mqrUZBCh2ono6lYa7TE95GEt3Wxy2iAgDw/6kRHb3YkYjvUkK8W3lwgve5Epr4kPnMRGBw8ZxM7aQ1/woaMLRYy7TUoU49ZOseqs1T36kwBM/xt6nNycnoKc6g1fn3aFJhUkW28dnoCHTPmDTbpmCW+v7ItNSSZ2vQsEySaL2Fl7mNU4z1YurjidDpuj1qE+agAQATKjN1KcMRcE2nynb0iYO/LrSU7st5jRZbfAkudKvN9i90MBVR5Zjs41vWsb3p+Tanju/0WmTXcOh/Ngdxar1zLzhR9w3ZNxATovpQneTgWD4sgv/NdQkvVOpqBejFKji/5XeVC6X3byXw9NuF+U1FSx9oToUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199018)(5660300002)(2906002)(71200400001)(33656002)(7696005)(6506007)(9686003)(186003)(478600001)(26005)(55016003)(86362001)(122000001)(4326008)(6916009)(8676002)(41300700001)(82960400001)(76116006)(66556008)(83380400001)(66476007)(38070700005)(64756008)(66446008)(54906003)(38100700002)(66946007)(316002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzJNekVNejZEMmdZQWJhU2tsVVRoRHVJcFpFamowRENMQjZpd2pJWkd6S3Y0?=
 =?utf-8?B?eEQ4OFQ4emxPejRKbkNBZHdpQS9uWHpkVEo0OTFCSTRXVkJOSVREYUVIWHlm?=
 =?utf-8?B?VVhvWG9KYVJQS0Q0Q21rTkxid2hVVkxPaXg1OVRwZGZJOG1mSUpMZldjbjli?=
 =?utf-8?B?VWRvQXZmYUpLOWdTSk9oMCtMNTRQTXR6dXRzZFQ0SFplM0xEM2g2SmQzVk1V?=
 =?utf-8?B?ck55KzZlRHRHUjZqY1RlK084VU1RaEtGUUlpY3ZrS3g1NzAvYUtKSXdKcHBo?=
 =?utf-8?B?MnBmbnJlZFhDb2UvcFJIQURLaERiVmorSlZFSis1TzZ6WitzVlEvQ2M5TjFp?=
 =?utf-8?B?U2RKR0pqMzV5dktScTltbWQ2QVdJRWc1YldDcmJ5ejhNS2J2WFB3MUV0YjFF?=
 =?utf-8?B?NXVELzIxZjZMWTVCL1hOY3kzeXkzVDJvcEgrZEhFVWxveHdSbFdWMHliQ1Vk?=
 =?utf-8?B?S2RReFF3RUxhdVU4NWxrVElCSWtHYmYyeFAwVUZ2ZE1zdmxzVGlTYXJPeldm?=
 =?utf-8?B?YU9kVHZ3Y0lJSnlXK3dBeXBaQW9FQkVMV0RnN0tWZHZ0UVlwY0JwaHlYYysy?=
 =?utf-8?B?MGdOTnVpSFNwT2NkU3ZYTW5sV2lSL2ZoWmJ5QnZ3T0YreWJPVTBLSDlQS2RN?=
 =?utf-8?B?b0RwNm5xc1hIbDNmbzRnUEhPUTNkZUpKWDBzbnhWMXdyR2RTR2ZQVEliSGxu?=
 =?utf-8?B?RGU5SU1hTlpjWWcvOFpVK0wraFFZTXd2czB5TXIxekZrK29TYjJ5UjZkK29B?=
 =?utf-8?B?eU9pcEhzM0RtMmw3QkNUWXhHWWErY1E5TDYzbmZSRUJJb1lwTGdTTktSa3dm?=
 =?utf-8?B?R2xQYTB6dmNuM1lQa09GbzBGbVIzMnFTa2tRaUJzMVZpWWkzQ0s3dmtZZ21E?=
 =?utf-8?B?cVVJWk5QSHdaRmdsTSszMmpMSXZLelJGMVc3MFAvREV6eDN0Y2lJVUNVZ1Ex?=
 =?utf-8?B?V2RvTWlSV2VnUmdDT3pNYSs4cXVISlRMUzcxOUlHQkU4Q2h6WTE2SlpkbnRm?=
 =?utf-8?B?WXk2aEpDNWhrMVQ0NHJyMW9oWGg5Q21TT1dndlpORTBQVmlBWGJaS2RTejBF?=
 =?utf-8?B?T05LSGJUVGhGK3Q1SXd6V1VNSTVpRFBIaVlmZHlieXNuZEhYWFVqaXg4OVJ5?=
 =?utf-8?B?Y3dHQk5Gdk1ZZVE4cDU5ckhVZTR1T3E0cmI2NzZkeTNaT3ZoMzI2K2xid3Uy?=
 =?utf-8?B?NTRQMkt6Vkt0aWtEemRtZmMxWE52ZjMzMG5adWNQdWRYLzZ5L05EZ2lWbWdJ?=
 =?utf-8?B?Vy9Sd0FKZTZTWW1qUnQwQWIyMDNmbUhlMlgvL0hvdzh1aUlqUHAzZlBPR3kx?=
 =?utf-8?B?M2tQVUNRZW1NOVB0VytySXRWNzhCZ1VhUnlvWXoyR2FoMmx4cFFQSEh6THRs?=
 =?utf-8?B?RlBXWWFQWERYZ0dEekdFZmVQTTJLeFg4aGpmS2FPNW5UQXFQTmZCWXIyK0sw?=
 =?utf-8?B?aVJFRWZmNHUxdkE4V09PNjY3VVlZUVBsRnMrRFJmRTRJdkcvNWRwSFh0NW9n?=
 =?utf-8?B?dmlGbkYwYUtJSzIvWnZrdVNoUkpJY3krRnNGKzhJYVVYZVdaT2wzK0N0VkZu?=
 =?utf-8?B?cU1xdVZkalFaN1ZrU3VVZFcwNWxwMDgvZ3EyNk5IT3pkMEZLam1UNE5zOTZE?=
 =?utf-8?B?c1hiTExlbWI2a0xTWDUxS3JvR1gweXZXd1RQWTEvb1pPU0NyTWRxZXQ2U08x?=
 =?utf-8?B?OUFxY0ozTkxJSEpKNkwza3E3K3c5eXRja2xlWER4ZWQ2YS9KazRrWXAwdEZH?=
 =?utf-8?B?RlZ3VTlXc3pyeUNkaFhMSU0zYytuTTB3QUNaUlcrbU1na3lsUDY4UExpbEcy?=
 =?utf-8?B?ZzZ0ZzhvTjNRT0dZV0s5R2ZPVnA1eW1rK3dzZ2VTRnFya2p0Z0VlSnB1S3Ny?=
 =?utf-8?B?ekk0TE9ITXE4RmNHcXprc2JIbTVJQUVSZmNTcmlpakU2cXBBUmlXRzFqK2Vp?=
 =?utf-8?B?aGFsMGt4Q0NVY21iSHZITHVNNmphZWhuMTFmb1VrWm9nTTNPdXZNanhKVXdG?=
 =?utf-8?B?WSt3VVhOSVFHeTUrSUJMZklVOVZSRGRydVpoM0V3TnpxdzFtYWRaUW9mYk9V?=
 =?utf-8?B?YnJsUGdMWmNrOXhCRDI4YTUrc3VTb2lreDNsLzhoMmxaN0ZlSi9YQmNndEJW?=
 =?utf-8?Q?bG7HSSRik17RRffchN6CEiG9r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770ef755-49f1-45da-2453-08db0fe422ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 06:07:51.1411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGgCzc7ttz9EVUHLfp5PNBa+kYRWPJinUbtlSTNPNMFgx8+VJqGE/JjPk4INKXumHrJc5vPfgJdo5s0N9vig3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
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

Pg0KPiBGb3Iga2VybmVscyBidWlsdCB3aXRoIENPTkZJR19OT19IWl9GVUxMPXksIHJ1bm5pbmcg
dGhlIGZvbGxvd2luZyB0ZXN0czoNCj4NClsuLi5dDQo+IFRoaXMgY29tbWl0IHRoZXJlZm9yZSBh
ZGQgY2hlY2tzIGZvciBjcHVtYXNrX2FueV9hbmQoKSByZXR1cm4gdmFsdWVzDQo+IGluIGhvdXNl
a2VlcGluZ19hbnlfY3B1KCksIGlmIGNwdW1hc2tfYW55X2FuZCgpIHJldHVybnMgYW4gaWxsZWdh
bCBDUFUNCj4gdmFsdWUsIHRoZSBob3VzZWtlZXBpbmdfYW55X2NwdSgpIHdpbGwgcmV0dXJuIGN1
cnJlbnQgQ1BVIG51bWJlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhh
bmdAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGtlcm5lbC9zY2hlZC9pc29sYXRpb24uYyB8IDYgKysr
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvaXNvbGF0aW9uLmMgYi9rZXJuZWwvc2NoZWQv
aXNvbGF0aW9uLmMNCj4gaW5kZXggMzczZDQyYzcwN2JjLi41MzQzOTdhYjdhMzYgMTAwNjQ0DQo+
IC0tLSBhL2tlcm5lbC9zY2hlZC9pc29sYXRpb24uYw0KPiArKysgYi9rZXJuZWwvc2NoZWQvaXNv
bGF0aW9uLmMNCj4gQEAgLTQ2LDcgKzQ2LDExIEBAIGludCBob3VzZWtlZXBpbmdfYW55X2NwdShl
bnVtIGhrX3R5cGUgdHlwZSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNwdSA8IG5y
X2NwdV9pZHMpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGNwdTsN
Cj4NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGNwdW1hc2tfYW55X2FuZChob3Vz
ZWtlZXBpbmcuY3B1bWFza3NbdHlwZV0sIGNwdV9vbmxpbmVfbWFzayk7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGNwdSA9IGNwdW1hc2tfYW55X2FuZChob3VzZWtlZXBpbmcuY3B1bWFza3Nb
dHlwZV0sIGNwdV9vbmxpbmVfbWFzayk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChj
cHUgPj0gbnJfY3B1X2lkcykNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGNwdTsNCj4NCj5OaXQ6IG5v
IG5lZWQgb2YgImVsc2UiLCBzaW1wbHk6DQo+DQo+cmV0dXJuIChjcHUgPj0gbnJfY3B1aWRzID8g
c21wX3Byb2Nlc3Nvcl9pZCgpIDogY3B1KTsNCg0KVGhhbmtzIEpvZWwsIEkgaGF2ZSBkb25lIHRo
ZSBzYW1lIG1vZGlmaWNhdGlvbiBpbiB2MyB2ZXJzaW9uLCAgYW5kIHRoaXMgY2hhbmdlIGlzDQph
bHNvIHJlbGF0ZWQgdG8gYSAwOGFlOTVmNGZkM2IsIGFmdGVyIHJldmVydCBpdCwgdGhpcyBjYWxs
dHJhY2Ugd2lsbCBkaXNhcHBlYXIuDQoNClRoYW5rcw0KWnFpYW5nDQoNCg0KPg0KPm9yDQo+DQo+
aWYgKGNwdSA+PSBucl9jcHVfaWRzKQ0KPiAgIHJldHVybiBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+
cmV0dXJuIGNwdTsNCj4NCj5UaGFua3MuDQo=
