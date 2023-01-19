Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77070673F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjASQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjASQuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:50:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0844860E;
        Thu, 19 Jan 2023 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674147043; x=1705683043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qJzxAggCQ+98KEWCePWy14RnuxXfZUeASj33XabECts=;
  b=JIWTjs+TUuSEKjjErEzPjimqxNNK4xibmYQy+TSSV7P0imL8QvaM8R+2
   Mv3KCiH34gvPiMYegDceXJk17hHF8UY64K9MLeSOBWlobrkEQp1kGGaAD
   OgIfGyDH5bsMR9uSoq8qQBZO++FEg5Xktz8kiAech1CGpSrcVARLqto9L
   iuhBi2U9/5VN/vl8vsNlHzJfrBMzrH0PsZmqjd3wcoKsIusa6A+Y2JgAB
   h/qtO9J1XRSDyOqhbknjZiKgG9Fqo9iZNCV4t7yBze8/viEn2wil8S1ZZ
   CT97/HLeZzgVQXtFMrrPB9uQsh2wnpFJXVe/SEzqcX40z4DzNOhDJGURJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327437535"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="327437535"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="637766891"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="637766891"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 08:50:37 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 08:50:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 08:50:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 08:50:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 08:50:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ93tnocaeJZyrU568M/sQqQvKwDAZECS9rml83Ep2bITFENLJPk3B8pC+4MwPbyQcmTp+26neJlbvZyIInpYjVwIIys9bC+GsFGlW4g43tDqPCF/2n0ajhu3gIDIk8ElR9N/VzXbDN2bJMKbNTP/T1R33LPEPB9I+kAo6W61JywglWbe8vOB3BNni8WnCVE0gzX8SZ6GejtoPIGdi7Zk7Y6qQtzlZGJ9dLBn+LpnoMIgqMTqyFAxiGFV6yhYzlazPhTdUIXD9vPqe+iw+Vo/UItUdqqYkg6z+ciHH2I7UX4SSjeo6Y97gJ4pJuEXN9XCRQab8S/uCyK5ExLPc5BFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJzxAggCQ+98KEWCePWy14RnuxXfZUeASj33XabECts=;
 b=Idg38Ts7Kw66oaoPOCcSYuwGhHdUqondtdWPU4XCWih8aAt+Phkm+ZyM4fTVNk/gcbosJudN9x7EDi7obQvKE262bcx8o+eRCt8amAoIRe6oiE09MFDsed+3eUwnnpe6zo3bkRDi0UxPM+29NMgTsjId3CBFMjnOWrnBW/4PmNSVfqmkfDO89abl7tXzBapuwTUDL9ZxF4do8OaDmdgwFfESv/jXbdM4oKPodsU0pHtnKkVIv1mVVCK993X6UFfquUYukNeojJN7NfwgRj+7Sgrw1Wa60AxPRy3TiFzbhlxXDrVDPXhFySN+sYesqE1lH9Pmhw1VFy/+i2fFG6ctxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 16:50:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 16:50:34 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH 5/5] thermal/core: Sort the trip points when registering a
 thermal zone
Thread-Topic: [PATCH 5/5] thermal/core: Sort the trip points when registering
 a thermal zone
Thread-Index: AQHZK4F47zkPXqRA50m46Kv1AcfKwa6lVrIAgAAzAACAAGuTgA==
Date:   Thu, 19 Jan 2023 16:50:34 +0000
Message-ID: <546fcd7a262395efeafc93c6cbd0736efab5eace.camel@intel.com>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
         <20230118211123.111493-5-daniel.lezcano@linaro.org>
         <f515876ea2e43e734b8d4ac7feda7f17ee04894f.camel@intel.com>
         <d852675e-fdae-ec02-a4d1-4f3c7c8f64d7@linaro.org>
In-Reply-To: <d852675e-fdae-ec02-a4d1-4f3c7c8f64d7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SN7PR11MB7590:EE_
x-ms-office365-filtering-correlation-id: 04082d85-5787-4c05-789b-08dafa3d4873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/zv9Ys795c9NDJDRG3FdtY6JQyHdqp8Kz/9khJI+/+SIV8vS1Nw6tj1zcWLTB+f8pOEOEQ7Ss1dqrrk+ifukVQavlAsR4MKydMmEinBBsVbRKRmngkwX5LO6ZbZUfpDy3RC+Muukgmo+BB9w0aX7Jdbhkw1F402JJn8vWocGRo/B+Fr5kcGKWuGyIYr+s10nVNEa+bhIKC5PuVZHhFqiOS4FA50u3g024CxFetxZFmg+J47e+V0dFPGmWvZpQv6YvPIwxCT5nQtpwov1HItog1mV3DUE8zKiOqv+sHPXXj/CrH6WEjD9NkEdiy9eQKw7bA60DgVrmLDCIntPXZbhnIRg/MjOMNua/qmsRAfeOcng+nvDzxo21CiWa+6IjM0DMZssID58zeLxouib3fFFABf6hRVYXMkar9Kd8sSvtQ+6TZsbWdXwFnAtkjWQOqQfAKrqMtXc0XfV1R7cmhMFqh5yrG18CqJJMbcjdKTwUYtZ4rCcQD0KUzm9ixlADBVsevoRcMJGchhVO0Y2ZSnukjCJClsXNCpAOr6TBTZwbiH5eeA+5CmdZFPkfAANKd6Mu+jm0ZMMofwSjzqaSqi4wiVjwJvDZOTqMquZEgUCegnlY9t1MgJ07XeAqF712QUUJxC9tPMFFriC06CVXRt3stOgFKbH/MbdRvRPgFqsCj2eh4zDm6Ag+6RfDKQCOoLdm9WLRBCLSkqgchnZAeYZ2iQDM+o1D055NJhhSwPwuY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(66899015)(71200400001)(8936002)(122000001)(316002)(5660300002)(86362001)(6486002)(36756003)(478600001)(6506007)(53546011)(2906002)(2616005)(38070700005)(110136005)(54906003)(83380400001)(66946007)(64756008)(8676002)(4326008)(66556008)(76116006)(91956017)(66476007)(66446008)(38100700002)(82960400001)(186003)(26005)(6512007)(41300700001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmVaY0thZmlhbmNoakUxaEJRanFrTXk4SE9OT0dJcDhDZDBlZk5kMFcweFU1?=
 =?utf-8?B?YjRKQWZ1OEN4bWMzRi9XYUc0VEQvTWlka1JraFl1NGVUdXd0S2ZCTmxyY1NY?=
 =?utf-8?B?VGxkcWwwTjl4ZXBrYW1XY1hQalQ3OU93RzQ0WEFzWjA0ZDg5U0hWck5qQ3oz?=
 =?utf-8?B?b1d3ZWtwQnJCby83M2IxRGlpaUwrWm15NExaNVU1a2ZDclBxSFR4MUJBazNI?=
 =?utf-8?B?RndVU2IrU0ZvVzVTNElVSEV5bkNwVGtvODZnUW1kRFRsdmZpR3huSU1NU3NI?=
 =?utf-8?B?eW44RWRWRmdpSDdaLzVpK3B3WFF1VzZDd3FHcWJMUnl6VExaVk15RDBZL2RV?=
 =?utf-8?B?ajcwTTA5YXRueWkzZThCaVNJUVNGckkyOUtrTUYzU1VlSGhFakpiRE8xQ244?=
 =?utf-8?B?UlZHUitRZ0MyWEVTUmphQ2doZWlBL1phNkZWZmFUbm1VWGplUGY0c0hYVjA4?=
 =?utf-8?B?aTFaME9SNUMrWkRuZU13aGpwM0VZSkRVdURGeEFweVAyMzVNckVZWTJscHkz?=
 =?utf-8?B?SDZWTzdFbGp0SHh5ZnVOZ2I1NDdncHNmNWh3NVpIb05MSkMyK3dOaTRaZGdn?=
 =?utf-8?B?cmZ6d09ZNjIvelRxZ2sxTFgwcnF6VFJBTGtCSkdnM0JGc0E3Q2JsSUVzZThQ?=
 =?utf-8?B?MFRlU093d1QwM0JYcHI2WWVTUFJvNkd1a0RVVEFDTGszbEJEUUpwNHF1dC9M?=
 =?utf-8?B?RzR2eVVWcmg3RUtiZ3IwYVdwbGJCa2U5NmJWQ29kUml3WmZhWituTXo4VzJo?=
 =?utf-8?B?RkdLNEo2VnZsdWV5MDE3bXM1MTZkRFRDZEpUNm16R2FncDFhN1NEcHdNdk9k?=
 =?utf-8?B?REpwcDR4eDEwcFhqcFlRRGN3YzBVTUlzNGhxSVRVV3V2RS9GNEhuOWxiL1Vy?=
 =?utf-8?B?aldKdTJGVnpXVUNLQ2kyalpYS0ZxY1oxRDI5ZmN4RDVaQ2dTMUJrRUhXNkVS?=
 =?utf-8?B?L1hhUkxMR2VHMlEraTFoSFFEVjFtWEhTWEhxQTlHZnFOTWsxWFdCZ1lvRGxi?=
 =?utf-8?B?YlNpbDJkaWFXMkV2NmpWajRqeG92bW1TaWxBU1dTVld2bS9lem0wMDFDK1NR?=
 =?utf-8?B?ZXpSemxpcE1qK0R6R0NxaGdvQ0hoZzFEK2NieGNHVUtIRHFIc3BTU05STWsw?=
 =?utf-8?B?dm03cmpaa2svK3F2eXFIVGJ2U1RZbDg3WHFoSUZaZnNBRnlJV0lJSjlFYmJp?=
 =?utf-8?B?KzBKaFc2eWNGcmF6eDVCUlZ6eU9Ccnp3aW9hSkRnVERUSGowcjhJdmpmd29x?=
 =?utf-8?B?TkNWMi9hN3RrRjFESytpZWhwSHhYOUdqMkhKREpMbGdsdmdRQjh1YkttbGpp?=
 =?utf-8?B?TXFYRDEyV3ZJNHYvYmZQSGxkd0NYalRWVzdWSkFQenNLMGZtRDBidkRmVk4y?=
 =?utf-8?B?emR1cGlzZ0ZzOGtDd3pLU0YwM1EwdHY3VzhaUkVDWE84K1FFM2lPQ3kwWStC?=
 =?utf-8?B?YmpHQ0Z0SW1lclE5dCtMWFFaUDVpRjM0NGdWSng4QUNEbEFjd1IwT016dWxH?=
 =?utf-8?B?aXYzUWR3aFVnK3VPRFkvR2I2blZGeDdCSVpocnRBWC91UmtDMEFTV3QwMll6?=
 =?utf-8?B?Tkg4b2UrV1VqOE1OdFN2YkJ6eDMzbkh0TXhpaDA4UFI1VEZNcHoxM3NlRE93?=
 =?utf-8?B?bEJMS2xTZEZ6TjBuT2ZjRHoxcjRHelRYTlMvRUwwM3REZXhCOWNTWlRTZWxF?=
 =?utf-8?B?SEVLaUtKMGxRRjNMSnN0ckJVS2gzeE5vY01tM2p1a2RqVUhLVktvSUVPZ2FV?=
 =?utf-8?B?NUx6eVdqTFZ3S3ZqRWlKRkZGcGU1UVo1d3JoYlFlS1lrQk1MV05UUXgxaE5V?=
 =?utf-8?B?SVA3RFF4aXZYdlZwWEFYWXBYanpGU1NhOGtMakVraUE2OTh0RnhmcVo3MkVs?=
 =?utf-8?B?L080MTNTcHF6WlFBQS9UcUpDaWtrTTdJV0F6eW51TXhQRjM3UzBNTjlSQlJn?=
 =?utf-8?B?a0VlQVNxcnZkbzkydGFJVVNqMjAwSHRTenBsTUpFVTBKc1JVZG1GS3B4VXF2?=
 =?utf-8?B?V0pOUXc1Y0Q0REkyRjhKUGIyZWo5Sk1PSzlubE1jVGJSNTRLSTVMcFlXMXlD?=
 =?utf-8?B?SENuSnR5emxkczJ4aHB0WFJ1amlKWVZkcFhUR1doNkFpSjFLT1B1a1JpWnlP?=
 =?utf-8?B?N3VVWlFFQ0hXZVNBbmFvNjdOdDkwSWkwVFhuZzNublFkaVhxdTZrd1BnQU8r?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <769B01B634FE5946BE66FE5DC937D949@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04082d85-5787-4c05-789b-08dafa3d4873
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 16:50:34.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTjRZ1NCekjCt+I7Gbwnmi7I450cKJm4wv+Pp0JhCbXHY5xsSuYMr398XhbVJtZgvwTxyedJypZoztOJrY5kNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTE5IGF0IDExOjI1ICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gSGkgUnVpLA0KPiANCj4gT24gMTkvMDEvMjAyMyAwODoyMiwgWmhhbmcsIFJ1aSB3cm90ZToN
Cj4gPiBPbiBXZWQsIDIwMjMtMDEtMTggYXQgMjI6MTEgKzAxMDAsIERhbmllbCBMZXpjYW5vIHdy
b3RlOg0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPiA+ICtpbnQgdGhlcm1hbF90cmlwX3NvcnQoc3Ry
dWN0IHRoZXJtYWxfdHJpcCAqdHJpcHMsIGludCBudW1fdHJpcHMpDQo+ID4gPiArew0KPiA+ID4g
KwlzdHJ1Y3QgdGhlcm1hbF90cmlwIHR0Ow0KPiA+ID4gKwlpbnQgc29ydGVkID0gMDsNCj4gPiA+
ICsJaW50IGksIGo7DQo+ID4gPiArDQo+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBudW1fdHJpcHM7
IGkrKykgew0KPiA+ID4gKw0KPiA+ID4gKwkJZm9yIChqID0gaSArIDE7IGogPCBudW1fdHJpcHM7
IGorKykgew0KPiA+ID4gKw0KPiA+ID4gKwkJCWlmICh0cmlwc1tpXS50ZW1wZXJhdHVyZSA8DQo+
ID4gPiB0cmlwc1tqXS50ZW1wZXJhdHVyZSkgew0KPiA+ID4gKwkJCQl0dCA9IHRyaXBzW2ldOw0K
PiA+ID4gKwkJCQl0cmlwc1tpXSA9IHRyaXBzW2pdOw0KPiA+ID4gKwkJCQl0cmlwc1tqXSA9IHR0
Ow0KPiA+ID4gKwkJCQlzb3J0ZWQrKzsNCj4gPiA+ICsJCQl9DQo+ID4gPiArCQl9DQo+ID4gPiAr
IAl9DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBzb3J0ZWQ7DQo+ID4gPiArfQ0KPiA+ID4gKw0K
PiA+IFdoZW4gdGhpcyBoYXBwZW5zLCB0aGUgaW5kZXgodHJpcF9pZCkgb2YgZWFjaCB0cmlwIGlz
IGNoYW5nZWQsIGJ1dA0KPiA+IHdlDQo+ID4gcGFzcyB0aGUgbmV3IHRyaXBfaWQgdG8gLmdldF90
cmlwX3RlbXAoKS8uc2V0X3RyaXBfdGVtcCgpDQo+ID4gY2FsbGJhY2tzLg0KPiANCj4gSWYgd2Ug
cGFzcyB0aGUgdGhlcm1hbCB0cmlwcyB0byB0aGUgDQo+IHRoZXJtYWxfem9uZV9kZXZpY2VfcmVn
aXN0ZXJfd2l0aF90cmlwcygpLCAuZ2V0X3RyaXBfdGVtcCwgDQo+IC5nZXRfdHJpcF9oeXN0IGFu
ZCAuZ2V0X3RyaXBfdHlwZSBhcmUgbm90IHVzZWQuDQoNCmFncmVlZC4NCg0KPiANCj4gLnNldF90
cmlwX3RlbXAgaXMgY2FsbGVkIGZyb20gc3lzZnMsIHdoZXJlIHRoZSB0cmlwX2lkIGlzIHJlYWQg
ZnJvbQ0KPiB0aGUgDQo+IGZpbGUgbmFtZS4NCg0KeWVzLg0KDQo+ICBUaGlzIHRyaXBfaWQgd2ls
bCBiZSBjb3JyZWN0IGluIHRoaXMgY2FzZSwgYXMgdGhlIGZpbGVzIGFyZSANCj4gY3JlYXRlZCBh
ZnRlciBzb3J0aW5nIHRoZSBhcnJheS4NCg0KeWVzLCB0aGUgdHJpcF9pZCBmcm9tIHN5c2ZzIG1h
dGNoZXMgaXRzIGluZGV4IGluIHR6LT50cmlwc1tdLg0KDQo+IA0KPiA+IFRoaXMgd2lsbCBjb25m
dXNlIHRoZSBkcml2ZXJzIGFuZCB1cGRhdGUgdGhlIHdyb25nIHRyaXBzLCByaWdodD8NCj4gDQo+
IE5vLCBiZWNhdXNlIGF0IHRoZSBtb21lbnQgd2UgdXNlIHRoZSBnZW5lcmljIHRyaXAgc3RydWN0
dXJlLCBpdCBpcyANCj4gaGFuZGxlZCBieSB0aGUgdGhlcm1hbCBmcmFtZXdvcmsuDQo+IA0KPiBU
aGUgZHJpdmVycyBkbyBub3QgaGF2ZSB0byBkZWFsIHdpdGggdGhlIHRyaXAgaWQgb3IgYXNzdW1p
bmcgaXRzDQo+IHZhbHVlIA0KPiBnaXZlbiBhIHRyaXAgcG9pbnQgYWZ0ZXIgcmVnaXN0ZXJpbmcg
dGhlIHRoZXJtYWwgem9uZS4gSWYgaXQgZG9lcywNCj4gd2UgDQo+IHNob3VsZCBmaXggdGhlIGRy
aXZlciBhcyB0aGUgdHJpcF9pZCBpcyBhIGZyYW1ld29yayBpbnRlcm5hbCB2YWx1ZS4NCg0KSSBk
aWRuJ3QgcXVpdGUgZm9sbG93IHRoaXMuDQpQbGVhc2UgY29ycmVjdCBtZSBpZiBteSB1bmRlcnN0
YW5kaW5nIGlzIHdyb25nLA0KDQpTYXksIGRyaXZlciBzdXBwb3J0cyB0d28gd3JpdGFibGUgdHJp
cCBwb2ludCBBIGFuZCBCLCBCIGhhcyBoaWdoZXINCnRlbXBlcmF0dXJlIGJ1dCBpdCBpcyBzZXQg
aW4gdHJpcHNbMF0gd2hlbiB0aGUgZHJpdmVyIHJlZ2lzdGVycyB0aGUNCnRoZXJtYWwgZGV2aWNl
Lg0KDQpBZnRlciB0aGVybWFsX3RyaXBfc29ydCgpLCBCIGJlY29tZXMgdHJpcHNbMV0sIGFuZCBp
dHMgc3lzZnMgYXR0cmlidXRlDQppcyBzaG93biBhcyB0cmlwX3BvaW50XzFfeHh4LCByaWdodD8N
Cg0KV2hlbiBzZXR0aW5nIHRoZSB0cmlwIEIgdGVtcGVyYXR1cmUsIHRyaXBfaWQgaXMgMSwgYW5k
IHdlIGludm9rZQ0KCXR6LT5vcHMtPnNldF90cmlwX3RlbXAodHosIHRyaXBfaWQsIHRyaXAtPnRl
bXBlcmF0dXJlKTsNCg0KSW4gdGhlIGRyaXZlciwgdGhlIC5zZXRfdHJpcF90ZW1wKCkgY2FsbGJh
Y2sgdXBkYXRlcyB0cmlwIEEgaW5zdGVhZCBvZg0KdHJpcCBCIGJlY2F1c2UgdHJpcF9pZCA9PSAx
IHN0YW5kcyBmb3IgdHJpcCBBIGZyb20gdGhlIGRyaXZlcnMNCnBlcnNwZWN0aXZlIG9mIHZpZXcs
IHJpZ2h0Pw0KDQpZb3UgY2FuIHJlZmVyIHRvIHRoZSAuc2V0X3RyaXBfdGVtcCgpIGNhbGxiYWNr
IG9mIHg4Nl9wa2dfdGVtcF90aGVybWFsLg0KYyB3aGljaCBoYW5kbGVzIHR3byB0cmlwIHBvaW50
cy4NCg0KPiANCj4gVGhlIHRyaXBfaWQgaXMganVzdCBhbiBpbmRleCB0byBiZSBwYXNzZWQgYXJv
dW5kLCBzbyB3aGF0ZXZlciB0aGUNCj4gdmFsdWUsIA0KPiBpdCBzaG91bGQgcG9pbnQgdG8gdGhl
IHJpZ2h0IHRyaXAgcG9pbnQuDQo+IA0KPiBGb3IgaW5zdGFuY2UsIHRoZSBkZXZpY2UgdHJlZSBk
ZXNjcmliZXMgdGhlIHRyaXAgcG9pbnQgYW5kIHRoZXkgY291bGQNCj4gYmUgDQo+IGluIGFueSBv
cmRlciwgYWxsIHRoZSBEVCBiYXNlZCBkcml2ZXJzIGFyZSBhZ25vc3RpYyBvZiB0aGUgdHJpcF9p
ZC4NCj4gDQo+IElmIHRoZXJlIGlzIGFuIHVwZGF0ZSBvZiB0aGUgdHJpcCBwb2ludHMsIHdlIHJl
YWQgdGhlIHRyaXAgcG9pbnRzIA0KPiBkZWZpbml0aW9uIGFnYWluIGFuZCBkbyBhbiB1cGRhdGUg
b2YgYWxsIG9mIHRoZW0uDQo+IA0KPiA+IElNTywgd2UgbmVlZCBhIG1hcCBiZXR3ZWVuIHRoZXJt
YWwgY29yZSB0cmlwcyBhbmQgdW5zb3J0ZWQgZHJpdmVyDQo+ID4gdHJpcHMuDQo+IA0KPiBUaGF0
IHdoYXQgSSBwcm9wb3NlZCBzZXZlcmFsIG1vbnRocyBhZ28gYnV0IHdlIGNvbmNsdWRlZCB0aGF0
IHdvdWxkIA0KPiBhbm90aGVyIGV4dHJhIGxldmVsIG9mIGNvbXBsZXhpdHkuIFNvIHdlIGRlY2lk
ZWQgdG8gcmVwbGFjZSBhbGwgdGhlIA0KPiAuZ2V0X3RyaXBfKiBieSBhIGdlbmVyaWMgdHJpcCBw
b2ludCBzdHJ1Y3R1cmUgaGFuZGxlZCBieSB0aGUgdGhlcm1hbCANCj4gZnJhbWV3b3JrIGl0c2Vs
Zi4NCg0KSWYgdGhlIHByb2JsZW0gaXMgdmFsaWQsIG1heWJlIHdlIGNhbiBhZGQgYW4gJ29yaWdf
aWQnIHRvIHN0cnVjdA0KdGhlcm1hbF90cmlwIGZvciB0aGUgZHJpdmVyIHRvIHJlZmVyZW5jZT8N
Cg0KdGhhbmtzLA0KcnVpDQo=
