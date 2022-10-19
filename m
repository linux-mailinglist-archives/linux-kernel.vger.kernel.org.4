Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B728C6053DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiJSXVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJSXVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:21:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F73286EB;
        Wed, 19 Oct 2022 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666221700; x=1697757700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rSPfV0i8roETh3qO0jmsKNBtN9nBFvA/XMTbqwnG0/w=;
  b=P4T64V5ejZcreYr6YZT6TrxddcHl8Tya2b13dWkca9iAO0B9mj6uha2s
   YB5SryqUKc2Bg/a8LHJOqn6lj80ZOi+PiiQ8F9L717as8wDNKKFV/Xy/L
   t/s/O+4MAx26Pb4jFcBu9mlwAfiHMt44s/58u/HrY2vpKekx2bXf8jHkY
   JzEsx85t7lKIAAqvtc8+xjF5gqQce8kpbpuCxSbDJi5HeIHWp3mp6wLUK
   3JRuLedP7nxlx+UCi1R8y7CpZS+/00koG0iR68KFK/oW3HqNC8sb/d4lA
   B3avXHNo+PdDjZZr8pvH5KnbKnLaoCSxjs+0U77BedKhYXSQ+ICAXrNRA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="370767287"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="370767287"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 16:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="874665970"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="874665970"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2022 16:21:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 16:21:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 16:21:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 16:21:39 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 16:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpTMHBik09ZMWMyCb27RMQLjFyfOW61/jxMc6Qme2OMZEus2njqikUbO7+hgcU6Zyruk88hFsk+8UO5kxwKTHEWd+9f8vse8DdJZixv6V/HX9G9MGsVfHhFEEgIFieOUKPrnuW2XurkuVpFCZktJ3kR9wKP4vR5Mi2LqkES7Lf2gXx1Z+10/C/CjsjPvepsEJ4MRrtUSWwfMzZsA9NKGxNMwdBTZUlHs6jVyobGRQydtZUBZgsPVfMOQCsc8lXXctePYB8RCBiBJiFVB2XUMr0F3v4v6559x+dJWZMmKGCvMcTXTerqk/gFfjhzHcwgF44UqzIYhQHJCHHGgrYxBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSPfV0i8roETh3qO0jmsKNBtN9nBFvA/XMTbqwnG0/w=;
 b=mtk8qiVqFbTBLwbztuKSsT52SLs0PsPHXP/fc9vxd+fyB+1VY3j6xvaCbJMBHSGpAZAYO4borNCq2jyk+GaDQaEryJ9qN9DFWBHVCnW2NDVcFpyn7GFDTRl4W3Ap57MUb4t9YzZJbqfTtRZR2C+Z/5vBQndJ666SIxp/5SBhZcejzL7rrQ7YnOrgYrs9UywczJiRIML0ewVtknvCdJXXeNXC8NXbKb1C9zDXD+cUxkw0FfjzWhuzZ7vpORp986LwmG5MX2Yv6pfiSpOD4pe/2tooXRUsEQSdDHW6JkBZC8koT4IWCDcnp/1z1Ipy/32GJXwXWzIDrDJ3vxob71p5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN9PR11MB5339.namprd11.prod.outlook.com (2603:10b6:408:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 23:21:36 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%8]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 23:21:36 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is
 enabled
Thread-Topic: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is
 enabled
Thread-Index: AQHY46sFKFVV7ouRH06ahr0oauX1Qq4VoE8AgAAAeQCAAFzkAIAAC1KAgABQntA=
Date:   Wed, 19 Oct 2022 23:21:36 +0000
Message-ID: <PH0PR11MB5880D9EBE73ECED231014234DA2B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221019174458.GD5600@paulmck-ThinkPad-P17-Gen-1>
 <6E2C7AC3-9BA6-4C5B-A9D7-59F5F6279177@joelfernandes.org>
In-Reply-To: <6E2C7AC3-9BA6-4C5B-A9D7-59F5F6279177@joelfernandes.org>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BN9PR11MB5339:EE_
x-ms-office365-filtering-correlation-id: 2765c73b-ee1b-4c73-57ba-08dab228aad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+9/5oCGpCOVo4tO9D7SyMCMDfKj/FKgLzM+FK4X/VYqWq5TryFIYf0Ju4LJxh3zJn70cZVgopxjMSUeuR/rWH7nnznDwSbpIfSJvIHx1uuvtV60I2cQYGcMTbsUcTw4zQUkbibNQBU1OPkCT8+IIKnnIaTvhzPLcSGxUnlVBXiQ29n5Fu+649TSDYXDkwoX44Tbn0Klijmn7dnP05f8HDb+xWTLbm0uD29jOg0JOwuoVbHIm++9n3WbRhvpcwimw18grC67/QuHs+Wm0AWWWw57XuqNdgV+LKj+rO683LskFHCSBAC/GmSbCuN79feN9c+vwxYVaNjGpfcXVLjH4YWd6vl7w3VTe4GY8WyrctBkJifF2/UDzIPT07gBHbLdKVXpHDGdbyH4hayblL5xW6sCCOtSOEia74T3apDYR2Yn6DFXY4JNC50ekdsR6QBtzle6KStay1jwzvfYz/gMM2vDCAW4c54kUfI0LlF2LxH71/XwT0dugdf/8PZ8QWtFOAf1wI7Ucs7OTNtGlRtf7wk+/FlCuH+nzgSF3SlpOn0ot+d4wcFhSO2VDiF+FGcNOceDUkFeOqXKvny7e/QyOZXSs3wGP566C9jivYK2jecEv2rCZwdDhGl+7uHgaR3pIe6afrOidGykBs8gWBZRN1EqZL6dM60rFjR8s9xxZaN4Nmph4tNzzWhs0KfBCpG0wvcQhO6K8c5F2dakcr6d6kqbzF4Qd/MdgJlAjjAnFaxtMssDTTLZKnzAIbyxWuE3uGR4mNn/vBONQXrM86W27g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(71200400001)(478600001)(83380400001)(86362001)(66946007)(66476007)(66556008)(53546011)(66446008)(7696005)(6506007)(316002)(41300700001)(26005)(9686003)(52536014)(8936002)(76116006)(110136005)(4326008)(54906003)(5660300002)(8676002)(55016003)(2906002)(33656002)(186003)(64756008)(82960400001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW9MeFpZb05TZDk4ZUwyZUd6TGdIOHBYRTZwRWNnTW1rVTRsY2ZrNzdJZ1Nv?=
 =?utf-8?B?bFFMQTFRSTdianJORSs5akJ6WFpLYTRvL09hcW0va1VPSFk0TXZSZVNYNWhn?=
 =?utf-8?B?V08wcGoweHJrZWFjQjRZejdEVDd1aUZScXp0TEsyakQyTkVwZHpNSU51R1ZM?=
 =?utf-8?B?RUV4enpseFBQN0liSFNWeTFXN3BtRmp0MmU1REtRLyt6NEhZNmwwZXlhNE9O?=
 =?utf-8?B?SndGem5SUXQwZlF2UXpFS2E3UHNvUmFjWU10OHhHdkFzU2s3VVNaM0NPRWNP?=
 =?utf-8?B?TFFuUWJHc1lLTkptQlIveE9vSzkxYzFmK1lqK2R6bTVxNHNGRFhleFhkSnlj?=
 =?utf-8?B?b0pEYysrekRUVVVYUWEwSmRuSFNqOHVwU2ErYXBPL3BwbGNySDZMMEFrWTRG?=
 =?utf-8?B?eFhZTS9HSUxiNVhvK2VzNFFuTXRrbGFSTXYxVFVMQ1pTL2UxVmgvcUs0VWZW?=
 =?utf-8?B?bUtZbmFFY3ZjRytxd3NRQlFHUXBJSCtQcDQ5NUpkK0JmWTFtN0dyTFQ4MHF0?=
 =?utf-8?B?K0Z5ajNlV2ZwUFRFWGZvRTUwUXFGbHkrYUppUjNvL0J6Znh4c2VzZGJpMGk4?=
 =?utf-8?B?STMycDN0YVg4TCt1OHRibGFHSi8zMkczaSsySTZ2TTQxNUM1MmYwbHJpTmw2?=
 =?utf-8?B?T3ljWTByRktmdWNMNWl3SlowSzRUUVRTRWpneXp2ZjVhL2RLUUNNRWE3RkdR?=
 =?utf-8?B?SmRVKy9xSStKK0tlNC9oUVBRaysrcjViWEU1cEg0Si9BdEY1Z3VmV0F6N3lY?=
 =?utf-8?B?SHJ0SS9UY0JacHlPQS8rTnBJSFljVzQvTDBVNHRsQ1hzWEdHc2NscDlRNW9w?=
 =?utf-8?B?N2lObnBUVmYxNVQxOXdtRVNjQWVRRDMya0R4NDhRZFRvZVg2d2wxRG0rZUVs?=
 =?utf-8?B?bTllZUdTK0oyaDdXVml1WmZ4S1VMUEtqcEc5Yy9CWW16ck41ZDZRTUxHaUdH?=
 =?utf-8?B?WTYxVlJ5MGx0U1daNW95NGcycWhhQ201dWVnNzNzQmV0N0NBWDJ4T1p1SGR6?=
 =?utf-8?B?SHNXZ2JCRkQzTGd5M1BhTGd6NFUzY2lMdlNla1JPR3pMaVFCaVM3a0dsQzYr?=
 =?utf-8?B?L3lldjV5RENJdmRqRmRtam1Gek5yMGcxakp1NEVRRC9kZnA1UFBSMklpWnNW?=
 =?utf-8?B?N0prQkNvclVYOEE1RFhESWZaZXYyb2dEazRVOEw2SXJFRmNHNllZTFNQRVpx?=
 =?utf-8?B?UWd4UW1NZFdjU1UzMVJPZTRzb1pmaEpKVG9VdG9KS3dyb3NHT213aXJ6cFlz?=
 =?utf-8?B?dDgzTWdtTjY0UFZHWVd3R09QLzA5YkdlUHY2ZVpVSC82aXNmUmxBVEVoaFBn?=
 =?utf-8?B?Vkc2ajM0VTVDYkFTbldpN2krcy94SVE3UXMwMit0Y2ZIbTl1elNaVXlyT2xk?=
 =?utf-8?B?MStHU09FT1dHVndzSW1CWkFMcjAxRUtrNmJCa2tNMnhKNGhOYTc2TzkrQktw?=
 =?utf-8?B?NFlVU2VmS1BGdThwQ1VGeTg4NlRrdERKNTFmTTVFMGVORHhYSzlPVXh1Y2h1?=
 =?utf-8?B?TXN6eHN0aDdzVWQ2SUt2d3pRdGdld1dHcnlxMEx4RTYxZG1UTUd2dDJ5dEJI?=
 =?utf-8?B?YW5Vcy9IRUNDRGdnTXJVa2ZaamJyRHR4Y0V5bU95TDlpTWJLRnNTQnUreE9R?=
 =?utf-8?B?VHhFOHRNNXN2NzNPMVFFS0ZVMGtEMlNOR1pQRFRrb3lHcVh1Mlp6TnFxVlha?=
 =?utf-8?B?R2NLaXczb1pITmhuNFA2eVluVHF2LzEydVZCL29zZ1hCZFkyTFhhaXQyMTBS?=
 =?utf-8?B?QStoaGJQYzhUeklWa0ZzK2VPampEa3hsTS9MVU94eEIxVjVYeC9IcS8xTnVQ?=
 =?utf-8?B?eTBLM3pEOXAySER3NHNUQTdkNGlKaG4xc1Z3eHdKVk5oUkJsTS9ZSkE5ZzBU?=
 =?utf-8?B?endGWWZRbks1MGJsSUhCdzIzakZxM1NFeDYxMVpQbXV4VFpmMFNtdWt5eWZX?=
 =?utf-8?B?V2ZiMEQ4bmpKNnhHQ1FsSll2Qyt1MjZUVDZWK0p0a0tpUzVNUi9VbUppamw2?=
 =?utf-8?B?dG10YXNHOGJsUlhBVi9yVThzcVRGbGVrQUJ6bURTUlhKd21FUVg4S3hZM0Y1?=
 =?utf-8?B?OE9QbUdhbFV6MDFhT2h6c3k5eDczbDNSdEFhTHNBZXhhSHZNbGZSSEI5aVN0?=
 =?utf-8?Q?zRxl1uycUXCfldf1GSBaNErg0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2765c73b-ee1b-4c73-57ba-08dab228aad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 23:21:36.0553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpK+J0ls+cjsCqUtavZXLXC7DWaD7dB4EqQhtyMWBe8f4DhvdMpoeCDBivvkEgjn2QRZwm88ddWJ9B/5tLr5Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBPY3QgMTksIDIwMjIsIGF0IDE6NDUgUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBXZWQsIE9jdCAxOSwgMjAyMiBhdCAwODox
MjozMEFNIC0wNDAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+PiBPbiBPY3QgMTksIDIwMjIs
IGF0IDg6MTAgQU0sIEpvZWwgRmVybmFuZGVzIDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPiB3cm90
ZToNCj4+Pj4+IE9uIE9jdCAxOSwgMjAyMiwgYXQgNjozNCBBTSwgWnFpYW5nIDxxaWFuZzEuemhh
bmdAaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4g77u/Q3VycmVudGx5LCByZWdhcmRs
ZXNzIG9mIHdoZXRoZXIgdGhlIENPTkZJR19SQ1VfTEFaWSBpcyBlbmFibGVkLA0KPj4+Pj4gaW52
b2tlIHRoZSBjYWxsX3JjdSgpIGlzIGFsd2F5cyBsYXp5LCBpdCBhbHNvIG1lYW5zIHRoYXQgd2hl
bg0KPj4+Pj4gQ09ORklHX1JDVV9MQVpZIGlzIGRpc2FibGVkLCBpbnZva2UgdGhlIGNhbGxfcmN1
X2ZsdXNoKCkgaXMgYWxzbw0KPj4+Pj4gbGF6eS4gdGhlcmVmb3JlLCB0aGlzIGNvbW1pdCBtYWtl
IGNhbGxfcmN1KCkgbGF6eSBvbmx5IHdoZW4NCj4+Pj4+IENPTkZJR19SQ1VfTEFaWSBpcyBlbmFi
bGVkLg0KPj4gDQo+PiBGaXJzdCwgZ29vZCBleWVzISAgVGhhbmsgeW91IGZvciBzcG90dGluZyB0
aGlzISENCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNv
bT4NCj4+Pj4+IC0tLQ0KPj4+Pj4ga2VybmVsL3JjdS90cmVlLmMgfCA4ICsrKysrKystDQo+Pj4+
PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+PiAN
Cj4+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9yY3UvdHJlZS5j
DQo+Pj4+PiBpbmRleCBhYmM2MTU4MDhiNmUuLjk3ZWY2MDJkYTNkNSAxMDA2NDQNCj4+Pj4+IC0t
LSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+Pj4+PiArKysgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPj4+
Pj4gQEAgLTI4MzksNyArMjgzOSw2IEBAIHZvaWQgY2FsbF9yY3VfZmx1c2goc3RydWN0IHJjdV9o
ZWFkICpoZWFkLCByY3VfY2FsbGJhY2tfdCBmdW5jKQ0KPj4+Pj4gIHJldHVybiBfX2NhbGxfcmN1
X2NvbW1vbihoZWFkLCBmdW5jLCBmYWxzZSk7DQo+Pj4+PiB9DQo+Pj4+PiBFWFBPUlRfU1lNQk9M
X0dQTChjYWxsX3JjdV9mbHVzaCk7DQo+Pj4+PiAtI2VuZGlmDQo+Pj4+PiANCj4+Pj4+IC8qKg0K
Pj4+Pj4gKiBjYWxsX3JjdSgpIC0gUXVldWUgYW4gUkNVIGNhbGxiYWNrIGZvciBpbnZvY2F0aW9u
IGFmdGVyIGEgZ3JhY2UgcGVyaW9kLg0KPj4+Pj4gQEAgLTI4OTAsNiArMjg4OSwxMyBAQCB2b2lk
IGNhbGxfcmN1KHN0cnVjdCByY3VfaGVhZCAqaGVhZCwgcmN1X2NhbGxiYWNrX3QgZnVuYykNCj4+
Pj4+ICByZXR1cm4gX19jYWxsX3JjdV9jb21tb24oaGVhZCwgZnVuYywgdHJ1ZSk7DQo+Pj4+PiB9
DQo+Pj4+PiBFWFBPUlRfU1lNQk9MX0dQTChjYWxsX3JjdSk7DQo+Pj4+PiArI2Vsc2UNCj4+Pj4+
ICt2b2lkIGNhbGxfcmN1KHN0cnVjdCByY3VfaGVhZCAqaGVhZCwgcmN1X2NhbGxiYWNrX3QgZnVu
YykNCj4+Pj4+ICt7DQo+Pj4+PiArICAgIHJldHVybiBfX2NhbGxfcmN1X2NvbW1vbihoZWFkLCBm
dW5jLCBmYWxzZSk7DQo+Pj4gDQo+Pj4gVGhhbmtzLiBJbnN0ZWFkIG9mIGFkZGluZyBuZXcgZnVu
Y3Rpb24sIHlvdSBjYW4gYWxzbyBwYXNzIElTX0VOQUJMRUQoQ09ORklH4oCmKSB0byB0aGUgZXhp
c3RpbmcgZnVuY3Rpb24gb2YgdGhlIHNhbWUgbmFtZS4NCj4gDQo+IEkgZG8gbGlrZSB0aGlzIGFw
cHJvYWNoIGJldHRlciAtLSBsZXNzIGNvZGUsIG1vcmUgb2J2aW91cyB3aGF0IGlzIGdvaW5nIG9u
Lg0KPg0KPlNvdW5kcyBnb29kLiBacWlhbmcsIGRvIHlvdSBtaW5kIHVwZGF0aW5nIHlvdXIgcGF0
Y2ggYWxvbmcgdGhlc2UgbGluZXM/IFRoYXQgd2F5IHlvdSBnZXQgdGhlIHByb3BlciBhdHRyaWJ1
dGlvbi4NCj4NCg0KVGhhbmtzIEpvZWwgYW5kIFBhdWwgcmV2aWV3LCBJIHdpbGwgdXBkYXRlIG15
IHBhdGNoIGFuZCByZXNlbmQuDQoNClRoYW5rcw0KWnFpYW5nDQoNCj5Nb3JlIGNvbW1lbnRzIGJl
bG93Og0KPiANCj4+PiBMb29rcyBsaWtlIHRob3VnaCBJIG1hZGUgZXZlcnkgb25lIHRlc3QgdGhl
IHBhdGNoIHdpdGhvdXQgaGF2aW5nIHRvIGVuYWJsZSB0aGUgY29uZmlnIG9wdGlvbiA7LSkuIEhl
eSwgSeKAmW0gYSBoYWxmIGdsYXNzIGZ1bGwga2luZCBvZiBndXksIHdoeSBkbyB5b3UgYXNrPw0K
Pj4+IA0KPj4+IFBhdWwsIEnigJlsbCB0YWtlIGEgY2xvc2VyIGxvb2sgb25jZSBJ4oCZbSBhdCB0
aGUgZGVzaywgYnV0IHdvdWxkIHlvdSBwcmVmZXIgdG8gc3F1YXNoIGEgZGlmZiBpbnRvIHRoZSBl
eGlzdGluZyBwYXRjaCwgb3Igd2FudCBhIG5ldyBwYXRjaCBhbHRvZ2V0aGVyPw0KPj4gDQo+PiBP
biB0aGUgb3RoZXIgaGFuZCwgd2hhdCBJ4oCZZCB3YW50IGlzIHRvIG51a2UgdGhlIGNvbmZpZyBv
cHRpb24gYWx0b2dldGhlciBvciBtYWtlIGl0IGRlZmF1bHQgeSwgd2Ugd2FudCB0byBjYXRjaCBp
c3N1ZXMgc29vbmVyIHRoYW4gbGF0ZXIuDQo+IA0KPiBUaGF0IG1pZ2h0IGJlIHdoYXQgd2UgZG8g
YXQgc29tZSBwb2ludCwgYnV0IG9uZSB0aGluZyBhdCBhIHRpbWUuICBMZXQncw0KPiBub3QgcGVu
YWxpemUgaW5ub2NlbnQgYnlzdGFuZGVycywgYXQgbGVhc3Qgbm90IGp1c3QgeWV0Lg0KPg0KPkl0
4oCZcyBhIHRyYWRlIG9mZiwgSSB0aG91Z2h0IHRoYXTigJlzIHdoeSB3ZSB3YW50ZWQgdG8gaGF2
ZSB0aGUgYmluYXJ5IHNlYXJjaCBzdHVmZi4gSWYgbm8gb25lIHJlcG9ydHMgaXNzdWUgb24gTGlu
dXgtbmV4dCwgdGhlbiB0aGF0IGNvZGUgd29u4oCZdCBiZSBwdXQgdG8gdXNlIGluIHRoZSBuZWFy
IGZ1dHVyZSBhdCBsZWFzdC4NCj4NCj4gSSBkbyB2ZXJ5IHN0cm9uZ2x5IGVuY291cmFnZSB0aGUg
Q2hyb21lT1MgYW5kIEFuZHJvaWQgZm9sa3MgdG8gdGVzdCB0aGlzDQo+IHZlcnkgc2V2ZXJlbHks
IGhvd2V2ZXIuDQo+DQo+QWdyZWVkLiBZZXMgdGhhdCB3aWxsIGhhcHBlbiwgdGhvdWdoIEkgaGF2
ZSB0byBtYWtlIGEgbm90ZSBmb3IgQW5kcm9pZCBmb2xrcyBvdGhlciB0aGFuIFZsYWQsIHRvIGJh
Y2twb3J0cyB0aGVzZSAoYW5kIGVuYWJsZSB0aGUgY29uZmlnIG9wdGlvbiksIGNhcmVmdWxseSEg
RXNwZWNpYWxseSBvbiBwcmUtNS4xNSBrZXJuZWxzLiBMdWNraWx5IEkgaGFkIHRvIGRvIHRoaXMg
KG5vdCBzbyB0cml2aWFsKSBleGVyY2lzZSBteXNlbGYuDQo+DQo+VGhhbmtzIQ0KPg0KPiAtIEpv
ZWwNCj4NCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRoYW54LCBQYXVsDQo+IA0K
Pj4gVGhhbmtzLg0KPj4gDQo+Pj4gDQo+Pj4gVGhhbmtzLg0KPj4+IA0KPj4+IC0gSm9lbA0KPj4+
IA0KPj4+IA0KPj4+PiArfQ0KPj4+PiArRVhQT1JUX1NZTUJPTF9HUEwoY2FsbF9yY3UpOw0KPj4+
PiArI2VuZGlmDQo+Pj4+IA0KPj4+PiAvKiBNYXhpbXVtIG51bWJlciBvZiBqaWZmaWVzIHRvIHdh
aXQgYmVmb3JlIGRyYWluaW5nIGEgYmF0Y2guICovDQo+Pj4+ICNkZWZpbmUgS0ZSRUVfRFJBSU5f
SklGRklFUyAoNSAqIEhaKQ0KPj4+PiAtLSANCj4+Pj4gMi4yNS4xDQo+Pj4+IA0K
