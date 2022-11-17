Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F862D131
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiKQCk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKQCkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:40:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7C42F50;
        Wed, 16 Nov 2022 18:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668652852; x=1700188852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q0w0wdjOePeAD4vrohNJ61vECjS3BhbQ7+JeBlVpt6U=;
  b=h1MBVEtBSODyDfr59kqFn3kbj6FF2vOihsbGMGuuv22cqNLaiK0KNNpn
   NEFqdulbHLVtK8CeBy9QUYHdoxfPHdSoO0CUJqLrreT5ZWi2pgy9kBVp3
   OGwBNIQ/jZ25X61nHsLTjashSWdMCf1jvnZ63IWi1DoFE24JNx9FVN2Z5
   IIMmD82K/IxHmUQ8Z1wDy/coho9EiKHgjR93jAuqMo2YBA3tL8pj9inup
   UR4io6z5l8+bXr0emIGjRG4uE5jMlOv9NnAXgCefQtMfVTX2kCvPB4PTE
   EoyxAEbF2pTxvjuobzxMpUjsQrIhYWwqormnACGlMou+Mt7WNK0IxZIpu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="312750909"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="312750909"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 18:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="708426943"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="708426943"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2022 18:40:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 18:40:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 18:40:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 18:40:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 18:40:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9xvYCwFN2x92Pdel2QXVaDP8GAp9+PDurZws1LG1zjje1ZKGICBC9DEe7WGO4wBOkmMpZQ2Bp/4tg9u4fU3pLAJZ/690EQbPEV1v6za8hXuzkIT6suXZlfGubpIR0VW+TBHivZduJpCcej13gB2GzLqtKVJ6d2SFLD+CA/BqmdOYF8ndcVBdbOSPnfMSlS2JJ9IRqXbCRWlj+rMgGgMtfntUBiyW6RBBBWAVd0pIF1mSAwx6Crvpp0PtyjH2WJAWGRqqcLXCYVAKOsWp5FXOyofamf1cl7ljT2Sd3XILxw1MOCCl0+lyLE3hNzPqdLZFZTnLW6Y62RNrGStttRaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0w0wdjOePeAD4vrohNJ61vECjS3BhbQ7+JeBlVpt6U=;
 b=ILa3ftsrPo7uucrCnZrGfhD3yH28qaokgHC/79xBTeG9I/aHzB6XAAfWsJb5bUFfKYm7/QrbSsb26uPMS99NX5LR6aZQpw4lXLd2dLSlt2P8uceRc2XIPw7r2vTCZDmefrOabnPYbXJuK3RxLqqCiw8UjtYqBU0hpz3g5OXbL+h1E4n+qVkIv4y5x6LtMLuljjY3i0/FMSwH9SDTFaFtOJdkVk8X1wG2M9zFlQEPInnJARP56SRXEnWXo9UUA27uTaAbQbDHJCpLgC8dnoTI7dQYPUiwWAZ52fswyqmmy6pBcuMb0Xt4912CpTqMUlUxpNFCyBZ9H8VYOEPbacHpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 02:40:49 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::c11e:4ee0:b397:f87d]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::c11e:4ee0:b397:f87d%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 02:40:49 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "Brown, Len" <len.brown@intel.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>
CC:     "Jain, Rajat" <rajatja@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Thread-Topic: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Thread-Index: AQHY9NCeT5T+Y2aluUSa4j5m2ryDMa49jLAAgAFD1YCAAQD8AIAAPaKAgAJjOoA=
Date:   Thu, 17 Nov 2022 02:40:48 +0000
Message-ID: <c4f7710514676bad549570e4b0140395c88af1c1.camel@intel.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
         <20221110064723.8882-2-mario.limonciello@amd.com> <871qq6tnqx.ffs@tglx>
         <MN0PR12MB6101BB92574BEF0A0AE2AB11E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
         <f1bff724-252c-e403-f02b-2fff49b2283f@redhat.com>
         <cb3886e5-7005-ffd4-28a2-8258a1473ea4@amd.com>
In-Reply-To: <cb3886e5-7005-ffd4-28a2-8258a1473ea4@amd.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|CO1PR11MB5155:EE_
x-ms-office365-filtering-correlation-id: cf702bc3-8da8-4815-0edc-08dac84522f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjNjOyxrR3p3pPp691U6r8Ae6v7vr+ZiVonom5x/EUd6GINYax9+JbsmcwSr7GlLpeYOiqNRsVaz/Ga/lvvTGPis3W+4xvP2Al0uKF8yy//NT55O/S1cfD49MRpd6NIVrDXaJyR/juIAStLot/t4MhJMUSSIkYbPMkq0zS3qbRiwHSntnl0HWyIRf+/LO427ARxWwhDzm3rUV9NMOXg6yWRMdQWkhqmlYJR9M97eVwdS9hM+5pRRb0tvGPo5jfij4aMI/rQEm8Bqm5+nCkI9qcuCnb8lqf2eCs+QqJpzCnpO5UcVpQXO88ABKQbokvlnKkJzWgOjeSQHpQJbPJO+T0+q7CsUeW33E8UhcU31yko4eCpryLHm0OoL1FBkXTixzWPpPnZIZKDM4A2+dU+BdKFGxzJiuS8bdpLlkAahz0TgMbBu711DKgahLIOfR4W1vX2PYsqVl4odOGiO4sRHowqAIouZ7K+22/E4jVD6GJ/tfGpBUOgppLlXVJ9+jYSdcgQmlAScyLnddT1buq/9Jy123xOJ1pqIUSnImi3Zn3q0RIoABgW9rdy/sbGBiXGQvnCdvJTArCRdt3iGGSxdjbymKdbt4wmvq/psNgAGJrWFFwY0Rw3t8pq1BJvWqCnOlecPLJUgLxiJn9/fuZnFQ1o7B3tPECzwUuFL/BVhOsjrOpMS9nkIzMucA0J5HojvgZ5o4M4HqH2KjJMwq2lY53+HSSdDl69Ai/JNOAmjjtRj2fk505tGVCmbn5Uf0vmWhJas0gwr6Mi7cQxYm5asMuaVAxRwxSXToTTfPhxGE90=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(66899015)(122000001)(921005)(38100700002)(3450700001)(4001150100001)(2906002)(66946007)(4326008)(8676002)(82960400001)(5660300002)(7416002)(8936002)(86362001)(64756008)(76116006)(66556008)(83380400001)(478600001)(316002)(66446008)(54906003)(110136005)(2616005)(66476007)(6486002)(71200400001)(41300700001)(38070700005)(26005)(36756003)(186003)(6506007)(53546011)(91956017)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amNSNm5aVlR4bEozdFZYNkp2Q3BodVNScjh2RzFjeldLS29laWE4dmJ1UTc4?=
 =?utf-8?B?WnRUU1ZYbVBBUngzL1pyTlRDVHNjMTJXbnd6Zm1lYUx2UXBWQzV2bVkzaCs2?=
 =?utf-8?B?cmxCNzBYaXJYMUhGMUw0eE5yN2RqRHBFWFNIZW9uM2JiZHJyQ3RhR3BYM2FU?=
 =?utf-8?B?VDM3U2pOT25udVRaRTcrZDdha3Q5VDZiU3oyMjFHVmxzaVNUbU4zSTVkd0lZ?=
 =?utf-8?B?MHEwN2hNaGIrNlpIMGZrSkF6SnFhNktPVE9rdXpBaDdZeDUvSXdmc0JoSm82?=
 =?utf-8?B?MkhvUXhVWWhzY1VQL2pxMklOMmxPZVdlK29ONThQYndKMDE5cFFFQVN2K0Jk?=
 =?utf-8?B?ejNhcW0vUDQxeENSWVdBSVlJRkVOb0RiVWFGMUsvUGZxRURPQXNRMlMzLzNm?=
 =?utf-8?B?a2hNS2dYSysrZFZoOE5WeUNaSkxOaFl6aVdYYWdFNGRJSjNidHVuQllqeTNG?=
 =?utf-8?B?SVkvend2VzVvNXJwMzczWHc1L3JlTHlPMVVVRUJqOWVVaGREcG5HcXBrVkFS?=
 =?utf-8?B?aksyQml2cTFnSnkxbHJCSjFRendUa2V4NlNsdGFMRUUveUh2bW5XMmtrTHpk?=
 =?utf-8?B?aXZXYjgwTDBsbWgwTEFCZHhNb0ptRG42N3BVR0gxUTNXcE1BdTVRbVpEZlEx?=
 =?utf-8?B?dDZvcEJGdTA0dHJJMUZDQnVhNXB6QzMrR2lsemdKUWZyOHVsaytLYUhubUxD?=
 =?utf-8?B?VU5TSUJUYUpoT3cyOWdKUEluTXhKU1dhTDhDbUtMUEhMb2hycjJ1eUtONmFF?=
 =?utf-8?B?QWx4WWNJUWZpYS9EQmpmVWpSY1pqdEs2OTUyRzVDNCtzWmZ5OHBOM2xpN3dJ?=
 =?utf-8?B?NFJkOEtJRXJySWNUWGtsLzVPSHdmYXZBYnB5M0Z2TVBJMWlJNUduSXJTendG?=
 =?utf-8?B?MFJzUmxkNjVaa3MzSk0rdzJIenFqaFdhWlgrcGpWZmdXVUdLb004bmxNejBq?=
 =?utf-8?B?dGZZMXRyTHYwSFRjRVNmSnM4bGtFaFBYc2ZDVlI2MG91ZURyQlNVWUllRFdF?=
 =?utf-8?B?a2Vlc2lMUVJ3QW1JNDRiNUtWZGJIQU5Yc2FCUktmVWFNR1NnNndrYU1wOTBT?=
 =?utf-8?B?VWw1ZGFRbC9qSCtPN2NvWlByOUZVTkNOQnM2VDNtRHJKVk02Kzc2elJ0UGht?=
 =?utf-8?B?dVpJZlpHNGpVN3VpUXNpUEYzTHk4dTdPUmFaVmdJbFFMeDhMekplNWN3eThG?=
 =?utf-8?B?Tm00N1RqRkcxK2RqdjFqMVhVVXE2TWhxTWYvbDdrbmhUUWtXMWJDTTluVzEr?=
 =?utf-8?B?Y0hYQmtyQjlweGlIb2NPN0RBYWs2cHJ5MGovcWFEZWN0R2xGWjJQSlkxdndV?=
 =?utf-8?B?U296MlM0SHJTemowQy9CS3hwaHd5dGpGL1ByRlQyOE5QZVcxVWRMV1dFYlBF?=
 =?utf-8?B?Q21weEpXanZESVdlcGVPQ2ZaN0RHSzlXaU5JeFZrZndXWS9CamJUVm1pYSs1?=
 =?utf-8?B?OFlvdEdUNUFHV0FMYm5qS0pKUm5jUEoyNDd2M0lNSEdkWmVFeUlndzBjTnJj?=
 =?utf-8?B?SWJmOE05L1Q1MXRjNkRmM0ozS1ZDem45K3hWVW9GSmJIKzNuVVVGcitMd2lI?=
 =?utf-8?B?ZXcwUENGZjdJZUtlVVp6TVV0bnF3eFgwOXhlSGZsM0dJMllJQ3ljakxuZEFk?=
 =?utf-8?B?ZUFkRnJPNndJaG9sMzBsYzFLN3lLQ1U0VzdCV08yRmdWSkhnUTFEUUgrTHJU?=
 =?utf-8?B?eitDdGhJZjFUWmJlRTJsdEk3bjA3cVVheDlSRGJjdnhPdloxVm95cVQ4Q2Jm?=
 =?utf-8?B?b2laL2JES1NiSDI5d3RoTTFMeHAweVF5dXlORzVlWFptNjkyTHA0L1R6NjVx?=
 =?utf-8?B?WGJqM3QvdHZNSGU1OVNuQ0xHSStKUnVhZTAyZmI1UDYrRzIyWmVIQm1icTJC?=
 =?utf-8?B?RXZZdFgraWZrdWVHTGloTEUzaHBGRDRJK2s1dXk2V29pOVV5OWVTWXlNNDRC?=
 =?utf-8?B?OFFLQjI5UG5lVDBXMHpDRDJwOXJ3VDZ3Rlk4RFl4Z1RrQkZhUm5DREF2WjZJ?=
 =?utf-8?B?UjZtRmUyUnhvR1E2Yk92aldWejZGWE4rSWFPRkw1NFZmWTZyMzlEZmVndkQ5?=
 =?utf-8?B?WW5OVEJ1aHZva3VZVXdjbEtvek0wYVpOVVdKVllVZ0FYRzkyZy94ZEFNa3VD?=
 =?utf-8?B?YjdqYm5iNlo3OXZHbjFNQ1pYUi9UR1RwSTNROTJqS2x3NzFIejJGeXBRVHBw?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D39F816E772094C8BCE3FC50253195C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf702bc3-8da8-4815-0edc-08dac84522f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 02:40:49.1236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LnqEpp3MD8LjlhSreet42vR72YiPB1LEnc8akTJY/pd1q8TMmW3e0LTct+IJuOX6zeeylhZlGgBrksVKRT+0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDA4OjEzIC0wNjAwLCBMaW1vbmNpZWxsbywgTWFyaW8gd3Jv
dGU6DQo+IE9uIDExLzE1LzIwMjIgMDQ6MzIsIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+ID4gSGkg
TWFyaW8sDQo+ID4gDQo+ID4gT24gMTEvMTQvMjIgMjA6MTIsIExpbW9uY2llbGxvLCBNYXJpbyB3
cm90ZToNCj4gPiA+IFtQdWJsaWNdDQo+ID4gPiANCj4gPiA+IFRoYW5rcyEgQXBwcmVjaWF0ZSB0
aGUgY29tbWVudHMuDQo+ID4gPiBBdCBsZWFzdCBjb25jZXB0dWFsbHkgaXMgdGhlcmUgYWdyZWVt
ZW50IHRvIHRoaXMgaWRlYSBmb3IgdGhlIHR3byBzeXNmcw0KPiA+ID4gZmlsZXMNCj4gPiA+IGFu
ZCB1c2Vyc3BhY2UgY2FuIHVzZSB0aGVtIHRvIGRvIHRoaXMgY29tcGFyaXNvbj8NCj4gPiANCj4g
PiBGaXJzdCBvZiBhbGwgbGV0IG1lIHNheSB0aGF0IEkgdGhpbmsgdGhhdCBoYXZpbmcgc29tZSBn
ZW5lcmljIG1lY2hhbmlzbQ0KPiA+IHdoaWNoIGFsbG93cyB1c2Vyc3BhY2UgdG8gY2hlY2sgaWYg
ZGVlcCBlbm91Z2ggc2xlZXAtc3RhdGUgd2VyZSByZWFjaGVkDQo+ID4gaXMgYSBnb29kIGlkZWEu
wqAgQW5kIHRoYW5rIHlvdSBmb3Igd29ya2luZyBvbiB0aGlzIQ0KPiA+IA0KPiANCj4gU3VyZSEN
Cj4gDQo+ID4gSSB3b25kZXIgdGhvdWdoIGlmIGl0IHdvdWxkIG5vdCBiZSBiZXR0ZXIgdG8gaGF2
ZSBzb21lIG1lY2hhbmlzbQ0KPiA+IHdoZXJlIGEgbGlzdCBvZiBzbGVlcCBzdGF0ZXMgKyB0aW1l
IHNwZW5kIGluIGVhY2ggdGltZSBpcyBwcmludGVkID8NCj4gPiANCj4gPiBFLmcuIEkga25vdyB0
aGF0IG9uIEludGVsIEJheSBUcmFpbCBhbmQgQ2hlcnJ5IFRyYWlsIGRldmljZXMgKGp1c3QgYW4N
Cj4gPiBleGFtcGxlIEknbSBmYW1pbGlhciB3aXRoKSB0aGVyZSBhcmUgUzBpMCAtIFMwaTMgYW5k
IHdlIHJlYWxseSB3YW50DQo+ID4gdG8gcmVhY2ggUzBpMyBkdXJpbmcgc3VzcGVuZC4NCj4gPiAN
Cj4gPiBTb21ldGltZXMgb24gUzBpMSBvciBTMGkyIGlzIHJlYWNoZWQgZHVlIHRvIHNvbWUgcGFy
dCBvZiB0aGUgaHcNCj4gPiBub3QgZ2V0dGluZyBzdXNwZW5kZWQgcHJvcGVybHkuDQo+ID4gDQo+
ID4gU28gdGhlbiB3ZSBoYXZlIHJlYWNoZWQgImEgaGFyZHdhcmUgc2xlZXAgc3RhdGUgb3ZlciBz
MmlkbGUiDQo+ID4gYnV0IG5vIHRoZSBvbmUgd2Ugd2FudC4NCj4gDQo+IEF0IGxlYXN0IHRoZSB3
YXkgaXQncyBidWlsdCByaWdodCBub3cgaXQncyB0cmFja2luZyB0aGUgczBpeCBjb3VudGVyIGZv
ciANCj4gSW50ZWwgYW5kIHRoZSBzMGkzIGNvdW50ZXIgZm9yIEFNRC4NCj4gDQo+IEJUVyAtIHdo
ZW4gSSBkaWQgYWxsIHRoZSBjbGVhbnVwcyBzdWdnZXN0ZWQgaW4gUkZDIHYyIEkgbm90aWNlIEkg
d2FzIA0KPiB0YWtpbmcgdGhlIHJhdyBudW1iZXIgZm9yIEludGVsLCBhbmQgSSBoYXZlIHRoYXQg
Zml4ZWQgZm9yIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiBJIGRvbid0IGtub3cgaWYgb3RoZXIg
Y291bnRlcnMgZXhpc3QgZm9yIEludGVsIGZvciB2YXJpb3VzIGhhcmR3YXJlIHN0YXRlcy4NCg0K
VGhleSBkbywgYnV0IHRoZSBpbXBsZW1lbnRhdGlvbiBpcyBoaWdobHkgcGxhdGZvcm0gc3BlY2lm
aWMuDQoNCj4gT24gdGhlIGN1cnJlbnQgQU1EIHNpbGljb24gdGhpcyBpcyB0aGUgaW50ZXJlc3Rp
bmcgbWV0cmljLg0KPiANCj4gPiANCj4gPiBPVE9IIEkgY2FuIGltYWdlIHRoYXQgaWYgd2Ugc3Rh
cnQgYWRkaW5nIHN1cHBvcnQgZm9yIGZ1bmN0aW9uYWxpdHkNCj4gPiBsaWtlIHN0YW5kYnktY29u
bmVjdCB1bmRlciBMaW51eCB0aGF0IHRoZW4gd2UgbWF5IG5vdCBhbHdheXMNCj4gPiByZWFjaCB0
aGUgZGVlcGVzdCBodyBzbGVlcC1zdGF0ZS4NCj4gDQo+IENhbiB5b3UgZWxhYm9yYXRlIHdoYXQg
eW91IG1lYW4gYnkgc3RhbmRieSBjb25uZWN0P8KgIFdvV0xBTj8NCj4gQXQgbGVhc3Qgb24gdGhl
IGN1cnJlbnQgQU1EIHBsYXRmb3JtcyBXb1dMQU4gY2FuIGhhcHBlbiB3aGlsZSB0aGUgDQo+IHNp
bGljb24gaXMgaW4gdGhlIGRlZXBlc3QgaGFyZHdhcmUgc2xlZXAgc3RhdGUuDQo+IA0KPiA+IA0K
PiA+IFNvIEknbSBhIGJpdCB3b3JyaWVkIHRoYXQgaGF2aW5nIGp1c3QgYSBzaW5nbGUgbnVtYmVy
IGZvcg0KPiA+IGxhc3RfaHdfc3RhdGVfcmVzaWRlbmN5IGlzIG5vdCBlbm91Z2guDQo+ID4gDQo+
ID4gSSB0aGluayB0aGF0IGl0IG1pZ2h0IGJlIGJldHRlciB0byBoYXZlIGEgbWVjaGFuaXNtIHRv
IHNldA0KPiA+IGEgc2V0IG9mIG5hbWVzIGZvciBody1zdGF0ZXMgKG9uY2UpIGFuZCB0aGVuIHNl
dCB0aGUgcmVzaWRlbmN5DQo+ID4gcGVyIHN0YXRlICgqKSBhZnRlciByZXN1bWUgYW5kIGhhdmUg
dGhlIHN5c2ZzIGZpbGUgcHJpbnQNCj4gPiB0aGUgZW50aXJlIGxpc3QuID4NCj4gPiBUaGlzIGxp
c3QgY291bGQgdGhlbiBhbHNvIGFsd2F5cyBpbmNsdWRlIHRoZSB0b3RhbCBzdXNwZW5kIHRpbWUs
DQo+ID4gYWxzbyBhdm9pZGluZyB0aGUgbmVlZCBmb3IgYSBzZWNvbmQgc3lzZnMgZmlsZSBhbmQg
d2UgY291bGQgYWxzbw0KPiA+IHVzZSB0aGUgc2FtZSBmb3JtYXQgZm9yIG5vbiBzMmlkbGUgc3Vz
cGVuZCBoYXZpbmcgaXQgcHJpbnQNCj4gPiBvbmx5IHRoZSB0b3RhbCBzdXNwZW5kIHRpbWUgd2hl
biBubyBody1zdGF0ZSBuYW1lcyBhcmUgc2V0Lg0KPiANCj4gU28gaXMgeW91ciB0aG91Z2h0IGlz
IHRvIGhhdmUgYSBzaW5nbGUgc3lzZnMgZmlsZSBzb21ldGhpbmcgbGlrZSANCj4gL3N5cy9wb3dl
ci9zdXNwZW5kX3N0YXRzL3MyaWRsZV9zdGF0cyB0aGF0IHdvdWxkIHNob3cgdGhpcz8NCj4gDQo+
IHN0YXRlIFx0ICUgXHQgZHVyYXRpb24gKHVzKQ0KPiBzMGkzwqAgXHQgOTkuNSUgXHQgMTAwMA0K
PiANCj4gRm9yIEFNRCB0aGF0IHdvdWxkIGJlIGEgc2luZ2xlIGxpbmUgYW5kIEkgZG9uJ3QgdGhp
bmsgaXQncyB3b3J0aCB0aGUgDQo+IGV4dHJhIGNvZGUuwqAgSSB3b3VsZCBsaWtlIHRvIGtub3cg
aWYgaXQgYWN0dWFsbHkgbWFrZXMgc2Vuc2UgZm9yIEludGVsIA0KPiB0aG91Z2guDQoNCk5vdCBo
ZXJlLiBFbmdpbmVlcnMgY2FyZSwgYnV0IHRoZSBwbWMgZHJpdmVyIGFscmVhZHkgcHJvdmlkZXMg
dGhpcy4gTW9zdCB1c2Vycw0KYXJlIG9ubHkgY29uY2VybmVkIGFib3V0IHdoZXRoZXIgdGhlaXIg
c3lzdGVtcyByZWFjaCBsb3cgcG93ZXIgaWRsZSwgd2hpY2hldmVyDQpTMGl4IHN0YXRlIGl0IGlz
Lg0KDQo+IA0KPiBXZSBhbHNvIG5lZWQgdG8gdGhpbmsgYWJvdXQgd2hhdCB3aWxsIGJlIGFjdGlv
bmFibGUgd2l0aCB0aGlzIA0KPiBpbmZvcm1hdGlvbiBieSBjb25zdW1lcnMgb2YgaXQgYmVjYXVz
ZSBJJ20gY2VydGFpbiBpdCB3aWxsIGJlIGxlYWRpbmcgdG8gDQo+IGJ1ZyByZXBvcnRzLg0KDQpJ
IGFncmVlLiBXaGlsZSBJbnRlbCBTb0NzIG1heSBzdXBwb3J0IG11bHRpcGxlIHN0YXRlcywgaXQg
aXMgbm90IGFsd2F5cyB0aGUgY2FzZQ0KKHBhcnRpY3VsYXJseSBmb3IgVGlnZXIgTGFrZSBhbmQg
bmV3ZXIpIHRoYXQgeW91IG5lZWQgdG8gcmVhY2ggdGhlIGRlZXBlc3Qgc3RhdGUNCmluIG9yZGVy
IHRvIGFjaGlldmUgdmVyeSBnb29kIHBvd2VyIHNhdmluZ3MuDQoNCkRhdmlkDQoNCj4gDQo+IExl
dCdzIHRoaW5rIGFib3V0IGEgaHlwb3RoZXRpY2FsIGJ1ZyByZXBvcnQ6DQo+ICJJbnRlbCBTeXN0
ZW0gb25seSBzcGVudCAyMCUgb2YgdGltZSBpbiBkZWVwZXN0IGhhcmR3YXJlIHN0YXRlIi4NCj4g
VGhleSBhdHRhY2ggdG8gdGhlIGJ1ZyByZXBvcnQgczJpZGxlX3N0YXRzIHRoYXQgbG9va3MgbGlr
ZSB0aGlzOg0KPiANCj4gc3RhdGUgXHQgJSBcdCBkdXJhdGlvbiAodXMpDQo+IHMwaTLCoCBcdCA4
MC4wJSBcdCAxMDAwMDAwDQo+IHMwaTPCoCBcdCAyMC4wJSBcdCAxMDAwMDANCj4gDQo+IElzIHRo
YXQgYW55IG1vcmUgYWN0aW9uYWJsZSB0aGFuDQo+IC9zeXMvcG93ZXIvbGFzdF9od19zdGF0ZV9y
ZXNpZGVuY3kgc2hvd2luZyAxMDAwMDANCj4gYW5kDQo+IC9zeXMvcG93ZXIvc3VzcGVuZF90b3Rh
bCBzaG93aW5nIDUwMDAwMA0KPiANCj4gSSB0aGluayBpbiBlaXRoZXIgY2FzZSB0aGUgbmV4dCBh
Y3Rpb24gaXMgbW9yZSBkZWJ1Z2dpbmcgd2lsbCBiZSBuZWVkZWQsIA0KPiBzdWNoIGFzIHR1cm5p
bmcgb24gZHluYW1pYyBkZWJ1ZyBvciBzb21lIG1vZHVsZSBwYXJhbWV0ZXJzLg0KPiANCj4gIlBy
YWN0aWNhbGx5IiBJIGV4cGVjdCBzb2Z0d2FyZSBsaWtlIHN5c3RlbWQgb3IgcG93ZXJkIHRvIGJl
IHJlYWRpbmcgDQo+IHRoZXNlIHN5c2ZzIGZpbGVzLg0KPiANCj4gPiANCj4gPiBSZWdhcmRzLA0K
PiA+IA0KPiA+IEhhbnMNCj4gPiANCj4gPiANCj4gPiAqKSBVc2luZyBhbiBhcnJheSwgc28gdXAg
dG8gTUFYX0hXX1JFU0lERU5DWV9TVEFURVMNCj4gPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gQSBm
ZXcgbmVzdGVkIHJlcGxpZXMgYmVsb3csIGJ1dCBJJ2xsIGNsZWFuIGl0IHVwIGZvcg0KPiA+ID4g
UkZDIHYzIG9yIHN1Ym1pdCBhcyBQQVRDSCB2MSBpZiB0aGVyZSBpcyBjb25jZXB0dWFsIGFsaWdu
bWVudCBiZWZvcmUgdGhlbi4NCj4gPiA+IA0KPiA+ID4gPiBPbiBUaHUsIE5vdiAxMCAyMDIyIGF0
IDAwOjQ3LCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+ICdBZGQg
YSBzeXNmcyBmaWxlcyc/DQo+ID4gPiA+IA0KPiA+ID4gPiBDYW4geW91IHBsZWFzZSBkZWNpZGUg
d2hldGhlciB0aGF0J3MgJ2EgZmlsZScgb3IgJ211bHRpcGxlIGZpbGVzJz8NCj4gPiA+IA0KPiA+
ID4gWXVwIHRoYW5rczsgYmFkIGZpbmQgYW5kIHJlcGxhY2UgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
IHdoZW4gSSBhZGRlZA0KPiA+ID4gdGhlIHNlY29uZCBmaWxlLg0KPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiA+IEJvdGggQU1EIGFuZCBJbnRlbCBTb0NzIGhhdmUgYSBjb25jZXB0IG9mIHJlcG9y
dGluZyB3aGV0aGVyIHRoZQ0KPiA+ID4gPiBoYXJkd2FyZQ0KPiA+ID4gPiA+IHJlYWNoZWQgYSBo
YXJkd2FyZSBzbGVlcCBzdGF0ZSBvdmVyIHMyaWRsZSBhcyB3ZWxsIGFzIGhvdyBtdWNoDQo+ID4g
PiA+ID4gdGltZSB3YXMgc3BlbnQgaW4gc3VjaCBhIHN0YXRlLg0KPiA+ID4gPiANCj4gPiA+ID4g
TmljZSwgYnV0IC4uLg0KPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIGluZm9ybWF0aW9uIGlzIHZh
bHVhYmxlIHRvIGJvdGggY2hpcCBkZXNpZ25lcnMgYW5kIHN5c3RlbQ0KPiA+ID4gPiA+IGRlc2ln
bmVycw0KPiA+ID4gPiA+IGFzIGl0IGhlbHBzIHRvIGlkZW50aWZ5IHdoZW4gdGhlcmUgYXJlIHBy
b2JsZW1zIHdpdGggcG93ZXIgY29uc3VtcHRpb24NCj4gPiA+ID4gPiBvdmVyIGFuIHMyaWRsZSBj
eWNsZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUbyBtYWtlIHRoZSBpbmZvcm1hdGlvbiBkaXNj
b3ZlcmFibGUsIGNyZWF0ZSBhIG5ldyBzeXNmcyBmaWxlIGFuZCBhDQo+ID4gPiA+ID4gc3ltYm9s
DQo+ID4gPiA+ID4gdGhhdCBkcml2ZXJzIGZyb20gc3VwcG9ydGVkIG1hbnVmYWN0dXJlcnMgY2Fu
IHVzZSB0byBhZHZlcnRpc2UgdGhpcw0KPiA+ID4gPiA+IGluZm9ybWF0aW9uLiBUaGlzIGZpbGUg
d2lsbCBvbmx5IGJlIGV4cG9ydGVkIHdoZW4gdGhlIHN5c3RlbSBzdXBwb3J0cw0KPiA+ID4gPiA+
IGxvdw0KPiA+ID4gPiA+IHBvd2VyIGlkbGUgaW4gdGhlIEFDUEkgdGFibGUuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gSW4gb3JkZXIgdG8gZWZmZWN0aXZlbHkgdXNlIHRoaXMgaW5mb3JtYXRpb24g
eW91IHdpbGwgaWRlYWxseSB3YW50IHRvDQo+ID4gPiA+ID4gY29tcGFyZSBhZ2FpbnN0IHRoZSB0
b3RhbCBkdXJhdGlvbiBvZiBzbGVlcCwgc28gZXhwb3J0IGEgc2Vjb25kIHN5c2ZzDQo+ID4gPiA+
ID4gZmlsZQ0KPiA+ID4gPiA+IHRoYXQgd2lsbCBzaG93IHRvdGFsIHRpbWUuIFRoaXMgZmlsZSB3
aWxsIGJlIGV4cG9ydGVkIG9uIGFsbCBzeXN0ZW1zDQo+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4g
dXNlZCBib3RoIGZvciBzMmlkbGUgYW5kIHMzLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIGFib3Zl
IGlzIGluY29tcHJlaGVuc2libGUgd29yZCBzYWxhZC4gQ2FuIHlvdSBjb21lIHVwIHdpdGggc29t
ZQ0KPiA+ID4gPiBjb2hlcmVudCBleHBsYW5hdGlvbiBvZiB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRv
IGFjaGlldmUgcGxlYXNlPw0KPiA+ID4gPiANCj4gPiA+ID4gPiArdm9pZCBwbV9zZXRfaHdfc3Rh
dGVfcmVzaWRlbmN5KHU2NCBkdXJhdGlvbikNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoHN1c3BlbmRfc3RhdHMubGFzdF9od19zdGF0ZV9yZXNpZGVuY3kgPSBkdXJhdGlv
bjsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChwbV9zZXRfaHdf
c3RhdGVfcmVzaWRlbmN5KTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK3ZvaWQgcG1fYWNjb3Vu
dF9zdXNwZW5kX3R5cGUoY29uc3Qgc3RydWN0IHRpbWVzcGVjNjQgKnQpDQo+ID4gPiA+ID4gK3sN
Cj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBzdXNwZW5kX3N0YXRzLmxhc3Rfc3VzcGVuZF90b3Rh
bCArPSAoczY0KXQtPnR2X3NlYyAqDQo+ID4gPiA+IFVTRUNfUEVSX1NFQyArDQo+ID4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdC0+dHZfbnNlYyAvDQo+ID4g
PiA+IE5TRUNfUEVSX1VTRUM7DQo+ID4gPiA+IA0KPiA+ID4gPiBDb252ZXJzaW9uIGZ1bmN0aW9u
cyBmb3IgdGltZXNwZWNzIHRvIHNjYWxhciBuYW5vc2Vjb25kcyBleGlzdCBmb3IgYQ0KPiA+ID4g
PiByZWFzb24uIFdoeSBkb2VzIHRoaXMgbmVlZCBzcGVjaWFsIHRyZWF0bWVudCBhbmQgb3BlbiBj
b2RlIGl0Pw0KPiA+ID4gDQo+ID4gPiBXaWxsIGZpeHVwIHRvIHVzZSBjb252ZXJzaW9uIGZ1bmN0
aW9ucy4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICtFWFBPUlRf
U1lNQk9MX0dQTChwbV9hY2NvdW50X3N1c3BlbmRfdHlwZSk7DQo+ID4gPiA+IA0KPiA+ID4gPiBT
byBub25lIG9mIHRoZXNlIGZ1bmN0aW9ucyBoYXMgYW55IGtpbmQgb2YgZG9jdW1lbnRhdGlvbi4g
a2VybmVsLWRvYw0KPiA+ID4gPiBleGlzdHMgZm9yIGEgcmVhc29uIGVzcGVjaWFsbHkgZm9yIGV4
cG9ydGVkIGZ1bmN0aW9ucy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYXQgc2FpZCwgd2hhdCdzIHRo
ZSBqdXN0aWZpY2F0aW9uIHRvIGV4cG9ydCBhbnkgb2YgdGhlc2UgZnVuY3Rpb25zIGF0DQo+ID4g
PiA+IGFsbD8gQUZBSUNUIHBtX2FjY291bnRfc3VzcGVuZF90eXBlKCkgaXMgb25seSB1c2VkIGJ5
IGJ1aWx0aW4gY29kZS4uLg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHlvdSdyZSByaWdodDsgdGhl
eSBzaG91bGRuJ3QgZXhwb3J0OyB3aWxsIGZpeC4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4g
PiArc3RhdGljIHVtb2RlX3Qgc3VzcGVuZF9hdHRyX2lzX3Zpc2libGUoc3RydWN0IGtvYmplY3Qg
KmtvYmosIHN0cnVjdA0KPiA+ID4gPiBhdHRyaWJ1dGUgKmF0dHIsIGludCBpZHgpDQo+ID4gPiA+
ID4gK3sNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoYXR0ciAhPSAmbGFzdF9od19zdGF0
ZV9yZXNpZGVuY3kuYXR0cikNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIDA0NDQ7DQo+ID4gPiA+ID4gKyNpZmRlZiBDT05GSUdfQUNQSQ0KPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoGlmIChhY3BpX2dibF9GQURULmZsYWdzICYgQUNQSV9GQURUX0xPV19Q
T1dFUl9TMCkNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IDA0NDQ7DQo+ID4gPiA+ID4gKyNlbmRpZg0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVy
biAwOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+IMKgIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHN1c3BlbmRfYXR0cl9ncm91cCA9IHsNCj4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAic3VzcGVuZF9zdGF0cyIsDQo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoC5hdHRycyA9IHN1c3BlbmRfYXR0cnMsDQo+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgLmlzX3Zpc2libGUgPSBzdXNwZW5kX2F0dHJfaXNfdmlzaWJsZSwNCj4gPiA+ID4gDQo+
ID4gPiA+IEhvdyBpcyB0aGlzIGNoYW5nZSByZWxhdGVkIHRvIHRoZSBjaGFuZ2Vsb2cgYWJvdmU/
IFdlIGFyZSBub3QgaGlkaW5nDQo+ID4gPiA+IHN1YnRsZSBjaGFuZ2VzIHRvIHRoZSBleGlzdGlu
ZyBjb2RlIGluIHNvbWUgY29uZ2xvbW9yYXRlIHBhdGNoLiBTZWUNCj4gPiA+ID4gRG9jdW1lbnRh
dGlvbi9wcm9jZXNzLy4uLg0KPiA+ID4gDQo+ID4gPiBJdCB3YXMgZnJvbSBmZWVkYmFjayBmcm9t
IFJGQyB2MSBmcm9tIERhdmlkIEJveCB0aGF0IHRoaXMgZmlsZSBzaG91bGQgb25seQ0KPiA+ID4g
YmUgdmlzaWJsZSB3aGVuIHMyaWRsZSBpcyBzdXBwb3J0ZWQgb24gdGhlIGhhcmR3YXJlLsKgIFdp
bGwgYWRqdXN0IGNvbW1pdA0KPiA+ID4gbWVzc2FnZSB0byBtYWtlIGl0IGNsZWFyZXIuDQo+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gLS0tIGEva2VybmVsL3RpbWUvdGltZWtlZXBpbmcuYw0K
PiA+ID4gPiA+ICsrKyBiL2tlcm5lbC90aW1lL3RpbWVrZWVwaW5nLmMNCj4gPiA+ID4gPiBAQCAt
MjQsNiArMjQsNyBAQA0KPiA+ID4gPiA+IMKgICNpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPg0K
PiA+ID4gPiA+IMKgICNpbmNsdWRlIDxsaW51eC9hdWRpdC5oPg0KPiA+ID4gPiA+IMKgICNpbmNs
dWRlIDxsaW51eC9yYW5kb20uaD4NCj4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQu
aD4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiDCoCAjaW5jbHVkZSAidGljay1pbnRlcm5hbC5oIg0K
PiA+ID4gPiA+IMKgICNpbmNsdWRlICJudHBfaW50ZXJuYWwuaCINCj4gPiA+ID4gPiBAQCAtMTY5
OCw2ICsxNjk5LDcgQEAgc3RhdGljIHZvaWQNCj4gPiA+ID4gX190aW1la2VlcGluZ19pbmplY3Rf
c2xlZXB0aW1lKHN0cnVjdCB0aW1la2VlcGVyICp0aywNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgdGtfc2V0X3dhbGxfdG9fbW9ubyh0aywgdGltZXNwZWM2NF9zdWIodGstPndhbGxfdG9fbW9u
b3RvbmljLA0KPiA+ID4gPiAqZGVsdGEpKTsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgdGtf
dXBkYXRlX3NsZWVwX3RpbWUodGssIHRpbWVzcGVjNjRfdG9fa3RpbWUoKmRlbHRhKSk7DQo+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoHRrX2RlYnVnX2FjY291bnRfc2xlZXBfdGltZShkZWx0YSk7
DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcG1fYWNjb3VudF9zdXNwZW5kX3R5cGUoZGVsdGEp
Ow0KPiA+ID4gPiANCj4gPiA+ID4gVGhhdCBmdW5jdGlvbiBuYW1lIGlzIHJlYWxseSBzZWxmIGV4
cGxhaW5pbmcgLSBOT1QgIQ0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoCBwbV9hY2NvdW50
X3N1c3BlbmRfdHlwZShkZWx0YSk7DQo+ID4gPiA+IA0KPiA+ID4gPiBTbyB0aGlzIHdpbGwgYWNj
b3VudCBhIHN1c3BlbmQgdHlwZSBkZXBlbmRpbmcgb24gdGhlIHRpbWUgc3BlbnQgaW4NCj4gPiA+
ID4gc3VzcGVuZCwgcmlnaHQ/DQo+ID4gPiA+IA0KPiA+ID4gPiBJdCdzIHRvdGFsbHkgb2J2aW91
cyB0aGF0IHRoZSBzdXNwZW5kIHR5cGUgKHdoYXRldmVyIGl0IGlzKSBkZXBlbmRzIG9uDQo+ID4g
PiA+IHRoZSB0aW1lIGRlbHRhIGFyZ3VtZW50Li4uIGVzcGVjaWFsbHkgd2hlbiB0aGUgZnVuY3Rp
b24gYXQgaGFuZCBoYXMNCj4gPiA+ID4gYWJzb2x1dGVseSBub3RoaW5nIHRvIGRvIHdpdGggYSB0
eXBlOg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSBmYXQgZmluZ2VyZWQgdGhpcy7CoCBJbiBt
eSBtaW5kIEkgdGhvdWdodCBJIHdyb3RlDQo+ID4gPiBwbV9hY2NvdW50X3N1c3BlbmRfdGltZSgp
DQo+ID4gPiBXaWxsIGZpeC4NCj4gPiA+IA0KPiA+ID4gPiA+ICt2b2lkIHBtX2FjY291bnRfc3Vz
cGVuZF90eXBlKGNvbnN0IHN0cnVjdCB0aW1lc3BlYzY0ICp0KQ0KPiA+ID4gPiA+ICt7DQo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgc3VzcGVuZF9zdGF0cy5sYXN0X3N1c3BlbmRfdG90YWwgKz0g
KHM2NCl0LT50dl9zZWMgKg0KPiA+ID4gPiBVU0VDX1BFUl9TRUMgKw0KPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHQtPnR2X25zZWMgLw0KPiA+ID4gPiBO
U0VDX1BFUl9VU0VDOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+IA0KPiA+ID4gPiBTaWdoLi4uLg0K
PiA+ID4gPiANCj4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoCB0Z2x4DQo+ID4gPiANCj4gPiANCj4gDQoNCg==
