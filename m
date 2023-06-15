Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F373204E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjFOTXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFOTXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:23:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D2E2949
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686856991; x=1718392991;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ygXR1QdGKgGHFUxCMqdiLdj5V/F1Nih7xlVzO6g/qAw=;
  b=nWiVnILfKX8w2LPumwH2FcFE/ldLfB5jlpAPRWZaXegRYKOkzY69OntJ
   I8gYiMJuXK/MoFCIH0mbgrHtZCJf0DxK8VfC7ebVut1oF5/Rlc1O/J8ug
   //qXfSTqe7aqZ+bgLPP+XvW1J6si4xsL/E22rW5wLr2DS0PMsus/DI3mV
   ILTVmkS0TxXctYe5PBu+N7UonX3hV+KrWBTeCnPsm5jWgRpwdtE4fxmqn
   Jy5wxyAUma3AtUg1ovKrjfIzZ7gT1f9N9fl3R8AsN1N+5u0zT5H9/s23w
   CBPILaq/SS5P8h9w68DJ2LegFlBXvcTQ2tIdviF3afwyIpW+QchFUisY6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387588257"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387588257"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 12:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689912450"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689912450"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 12:23:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 12:23:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 12:23:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 12:23:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 12:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLv6FDLeO7W76iVeRu3hmjk/u455Y3slkFx4617RPgGHSs4z77VAz4tA1A34kGTRZpuQAd4w6sgtl2/72OyhcvQsAa8FE1v0/OkJ9gOGyOfRiCRAguBz0bHaQoAYnv3NwANUnqX4Ce/efFl+iCUpH5m7g8oJ6KBm609yN+vKXYWkPZ7yCz1D/O0zPUm7vC+vNJwFNBQZHDSJ1IxzjLVMyYwlITv1t8STZPXAdGG2oKtf6nFB1TpNRadJJ1lK2gDfC/5udMFTupQG2WKG4MBJM85p6cSFXXd6mvCHMn0BLwrzAP4OQWsEwRewQAu8B3zsdvqlHAaEM2yRGk7vVL1Dtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygXR1QdGKgGHFUxCMqdiLdj5V/F1Nih7xlVzO6g/qAw=;
 b=hyOfN+fJJCdS+OkO7VuCKq7T3HYurOZfqFEPgOPsk54Tg88XIIafZMLoFbZ1AJZDYDFJsd7Qf8Cy3IUd0RxyuV2WPegDaZEfHju4yWMOzu52/iPXXdV8uDUs0hBPXyvspTv8dhEguuJ+zalu1j0XqkjtyPbyBsQVwUuuO1xvBGxZch8VkCX2W4O6VKtSCHDsJSasRx6if/wN7UaS8DiKEV8b1CSzusFlGbbcBh7j8tugjcu2W3yKbHtd/3H0Vmuaw1IMuthbOJi0/7S3os9tLWDMvjFMQXtummYWa+Z3To5qF47T/UAb2HfG+/OxJ18/A9dbmIybz/EWAywdturwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by BL1PR11MB5365.namprd11.prod.outlook.com (2603:10b6:208:308::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 19:23:05 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::2728:b097:ff42:bd19]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::2728:b097:ff42:bd19%4]) with mapi id 15.20.6455.030; Thu, 15 Jun 2023
 19:23:05 +0000
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the excluded
 check list
Thread-Topic: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the excluded
 check list
Thread-Index: AQHZnuBLo8//l5DYL061VraX79fiSq+LGOsAgADel8CAAAawgIAAQWrg
Date:   Thu, 15 Jun 2023 19:23:05 +0000
Message-ID: <IA1PR11MB64187D5665064B4E36DF6514C15BA@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20230614164955.1319870-1-michael.j.ruhl@intel.com>
 <b777a049b3817c7eee364310aac89470e9ea882e.camel@perches.com>
 <IA1PR11MB641820FC52D35D1CECE6830DC15BA@IA1PR11MB6418.namprd11.prod.outlook.com>
 <b6d8ab51-f75d-18f1-ed41-e2566eb76f9f@redhat.com>
In-Reply-To: <b6d8ab51-f75d-18f1-ed41-e2566eb76f9f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|BL1PR11MB5365:EE_
x-ms-office365-filtering-correlation-id: a586cfc4-080a-44a2-542a-08db6dd5f1a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rnIIEf/Zlr9k4a2J+tIoK0R9QkebT6sknaoljRNQPRlkqVMGjsuEcF81oK3649o/WG9mnA0cPx+W6p4SJPnZ06iIq9wBEqO96AWHDoryUCEFVUP34lGX1+Z4+F/uHj2IE2QAnzzd1RtW0IDeV+ubDp6Ml5rft+TfS6AdvXL2RS/4UqAB2A/p75+SwH6zMLLUp/IdceytVCGUrI5bkwJfrGzA5E+bmUyeBqDBRH9lyMDtlnR+xnMKu5KdVEiy3O2BHN5UOQpS1yQSFRFDZoytj0sOQDVtRbEV/+7k3XUd2ajFnrN3fQYpnssbUMEfMTLZEUtUgqc2Zc5NIXnYNtbbwLLrByMicryr+DE4gE+swbNy7nibAZJNaa9K4u40x51kx3FY8fWB4W4O9tRJT6XcEIW/MtNO92ShG/0adw4vYtofGGtzuvk1TxJWPd+CmsXAJ+aeJ18yE9fXqc3MsvVER1EEh0I2UBKzdpBXfGx5LLvKCiS/avbAv9VjGsgvOxL5j3ia5QK1Sa+NqileNivq1UpPJqoECz9Up5o9mFdwGuc5h6ON155kHqW9qw8p0IXbUfT23ZhoKPAho9z4cv2NxCBC8RGwVc0404/LIxoUEpFMokhEG2XwvUbA8loXIZQV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6418.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(86362001)(33656002)(38100700002)(478600001)(122000001)(38070700005)(7696005)(41300700001)(8676002)(8936002)(82960400001)(110136005)(316002)(52536014)(5660300002)(6506007)(53546011)(186003)(9686003)(26005)(2906002)(55016003)(64756008)(66476007)(76116006)(71200400001)(66446008)(66556008)(66946007)(83380400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmpqamZqc1VkL1FGRi93U3VEeC9Bc2NIRzhXckx5MjF3VFdEZndRTWJGYUNW?=
 =?utf-8?B?YTBwTEM2dkV0R2lJR1ludUFYVHNQWlFiak1LcGYwTmYxbVl4SkQza0FxT0hZ?=
 =?utf-8?B?VVcxd3UxUFR3WEFVcTJpMTAyRTRFNHpsdkt3aGhBckhHSXlqYTB5dktwL2JF?=
 =?utf-8?B?T3k2UWdlZm1ZTUJPWHB2QUFYMVRIVHMrc2RpaVBrVXpsWjYyUmxoMFY2aVFI?=
 =?utf-8?B?ZkhCeTFtcWJuaUVielZzK1dyU0h5bTVOS01RZ2g3SkVVOUFySGYvR3VCN3RO?=
 =?utf-8?B?NnBVcnZoSnI2WHNBMFRJSkRkWldVdlNjVHQ0UHJ3aTA0bzgwWTNOSSttZHB1?=
 =?utf-8?B?NHMxYW1yOGhsU2NMOGpyOVFYQ09QTHpheitDTVpFUlRCMkgyamxHYnM1YXgw?=
 =?utf-8?B?bmlPdkNJNjdEV01TM0pKa1lBc3ZKMFUwRVg5aDdFVThDbENpVHpIb2NzaFp5?=
 =?utf-8?B?MWEzc1Ird21KQ2d5Nk5KTGtLOWJ6ZnZ6VzZMRUtkUDRQZlY4Sm9WNVArckxr?=
 =?utf-8?B?TGViNjhVUFpkdHE0UVNnNktOWklSZDVHU1d5OHRYUXhzUEVSZ3B0MXJBNzlj?=
 =?utf-8?B?WHYwNFNuTFJZRm5hMVUrVUFkYlpkZ3dPRTd4NjFOaXJSQ1daNEdtZVoxeXJn?=
 =?utf-8?B?Mzh5clJ2bVVUZGwyRkJtZ2NjeU4wVG9BSVVlQjBPR1RLUXc1eFdka1FDTFNR?=
 =?utf-8?B?dDVWTllNSEhUd3ZvRDR1RDBBb1RFZVhINEQ1TUw1UHRvYlV4S25aZ0h3NmUr?=
 =?utf-8?B?bjQ2UjBwSjJVaWROdU8xOU9ma01lWU4wSlJqeUtxakpXWTFyV2NMWFp6b3J3?=
 =?utf-8?B?YUN0VWlVRU41ZjR1U2l5YVZjVkNRZ055RElkMStYU1RrOXVMMHVpZEo2c1Bo?=
 =?utf-8?B?emEwZUZLOXBrYTM1MytMdkRQMmFRTEZxTDBRcXcyLzd5ZlRmVkVTZlpCdXd6?=
 =?utf-8?B?OEVoeUZKUS9FMW83RVdSVktXNWdSWUlpR1BjYS9FNmNjZ0J2V2ZxeWtpbzdG?=
 =?utf-8?B?RHgySVB1d3JXallRdWR5QWJDVTlHS2g3SEFzSnFyU3k5ejJSMmY1bzVaTFpw?=
 =?utf-8?B?MEM2bSt3V2M0QlhLMmVxNGlRUkFrbVpYbEp5QWpIN21mRlBDeUlqMzZHVVNp?=
 =?utf-8?B?V1hhcTd4OCttbGF1VEYrcDJ1SG91MnpOeHlnMUxoc3liZlNrejdZcDZsNjhq?=
 =?utf-8?B?eXhyTGk1bUZVWFhPWWhzUFNwa2J3UXJyOE5kNlp6RnU5ZEc0b1FzbDBrZWdH?=
 =?utf-8?B?TVBGV29JcE4xb21Uemp1VkdHczZrVXZTalBDTkVkc0VSMVlSUnhLclplQUtQ?=
 =?utf-8?B?VVJSVGVUZ1FXSWlEWnNUZ1J0SW5YdGN5ekxXSzRYLzZBSXpMSGh5V28rTlZE?=
 =?utf-8?B?SUU3MktUaDRKWFNHVUpmZ2E2Q0ErYkVUQjZkb1prM0RpcXphM3ZpemRGcFVa?=
 =?utf-8?B?WUk0NndSYzVVRzJyTHlDaHFBUXpFdzRoT252UXliMnZjNmVSbXA2T3piSkc1?=
 =?utf-8?B?R2hvdjMvRHFSalZxU05kRTV1RjdaNkVqMGh0cHRLY0dDaUxha0o5RzFpTlY2?=
 =?utf-8?B?TlNMVEoyTkYwUTNTcUR6YlhTL1lZR0pUZFBJcStqc0VwZEM2ZXpJWUlrMjZT?=
 =?utf-8?B?WjJVMTVlQUY5aEtxWmdpVXVtQTVZclNFMkpLOTRsOHNQV0ZaM1J2K1BVbGtO?=
 =?utf-8?B?ODBPaFh2ck1aSndDSFVRYjhIS3FiNVpMY2FtYTBvVDB5MTBQWDhna3k3OEdC?=
 =?utf-8?B?OFBEMkduZlFPR25BZXZQTjExN1hoOWdsUTJRdkJDWDBucXl5N20zNFlHbW9S?=
 =?utf-8?B?NEVyaHhsQ2hzeUlmd1hoVXZDMExwRTNDMmhwRERkMmFDVEUram9XNnJXSUx0?=
 =?utf-8?B?akExTU1DZTZBV0phUE5jWFI3SmJYaW9tam53SFdGdkpmTE0rOXNXUmd2K2lU?=
 =?utf-8?B?TWVOTkpUNTA0ZVQ1TmVhU21wWm5kb3NjRlAyWGJqZzE1S1ZqTFArSDlnbXVq?=
 =?utf-8?B?OEZiM3MrV24rc3dKOFNJVzZ3OEtpN3dZY2k4cXBpSnV3RmN1bXk4UXJmMWtH?=
 =?utf-8?B?cVJUT1hNczRJam0zUmZVNW1wMk1SZTFRTFZUQVU0bHBqdXcyWmdUQk9PUFI1?=
 =?utf-8?Q?WsfLeMcnF7lXEjFaR0G3pDAeo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a586cfc4-080a-44a2-542a-08db6dd5f1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 19:23:05.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0sRhNjbGydks7bUOc6NLJ0qB7lOG3pMsR09U+iCjcyRFUaqS5LvVug37uMvUACsyswMy/krEmxwuIwn8dn7A8+98Iu9y+FFvL07untriaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5365
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+DQo+U2VudDogVGh1cnNkYXksIEp1bmUgMTUsIDIwMjMgMTE6MjggQU0N
Cj5UbzogUnVobCwgTWljaGFlbCBKIDxtaWNoYWVsLmoucnVobEBpbnRlbC5jb20+OyBKb2UgUGVy
Y2hlcw0KPjxqb2VAcGVyY2hlcy5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBh
cHdAY2Fub25pY2FsLmNvbTsNCj5kd2FpcGF5YW5yYXkxQGdtYWlsLmNvbTsgbHVrYXMuYnVsd2Fo
bkBnbWFpbC5jb207IGNvcmJldEBsd24ubmV0DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gY2hlY2tw
YXRjaDogSW5jbHVkZSBHRU1fQlVHX3h4eCB2YXJpYW50IGluIHRoZQ0KPmV4Y2x1ZGVkIGNoZWNr
IGxpc3QNCj4NCj5PbiAxNS4wNi4yMyAxNzowNCwgUnVobCwgTWljaGFlbCBKIHdyb3RlOg0KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogSm9lIFBlcmNoZXMgPGpvZUBw
ZXJjaGVzLmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMTQsIDIwMjMgOTo0NyBQTQ0K
Pj4+IFRvOiBSdWhsLCBNaWNoYWVsIEogPG1pY2hhZWwuai5ydWhsQGludGVsLmNvbT47IGxpbnV4
LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+Pj4gYXB3QGNhbm9uaWNhbC5jb207IGR3YWlw
YXlhbnJheTFAZ21haWwuY29tOw0KPmx1a2FzLmJ1bHdhaG5AZ21haWwuY29tOw0KPj4+IGNvcmJl
dEBsd24ubmV0OyBkYXZpZEByZWRoYXQuY29tDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2hl
Y2twYXRjaDogSW5jbHVkZSBHRU1fQlVHX3h4eCB2YXJpYW50IGluIHRoZQ0KPj4+IGV4Y2x1ZGVk
IGNoZWNrIGxpc3QNCj4+Pg0KPj4+IE9uIFdlZCwgMjAyMy0wNi0xNCBhdCAxMjo0OSAtMDQwMCwg
TWljaGFlbCBKLiBSdWhsIHdyb3RlOg0KPj4+PiBHRU1fQlVHX09OIGlzIHVzdWFsbHkgY29tcGls
ZWQgYXMgV0FSTi4gIFlvdSBoYXZlIHRvIGNoYW5nZSB0bw0KPj4+PiBkZWJ1ZyBjb25maWd1cmF0
aW9uIHRvIGdldCB0aGlzIHRvIGJlIEJVRy4NCj4+Pj4NCj4+Pj4gY2hlY2twYXRjaCBmbGFncyB0
aGlzIGEgV0FSTiBsZXZlbCBpc3N1ZS4NCj4+Pj4NCj4+Pj4gU2luY2UgdGhpcyBpcyBhIGk5MTUg
bG9jYWwgZGVidWcgbWFjcm8sIGFsbG93IGl0cyB1c2UgaW4gY2hlY2twYXRjaC5wbC4NCj4+Pj4N
Cj4+Pj4gRml4ZXM6IDY5ZDUxN2U2ZTIxMCAoImNoZWNrcGF0Y2g6IHdhcm4gb24gdXNhZ2Ugb2Yg
Vk1fQlVHX09OKCkgYW5kDQo+Pj4gb3RoZXIgQlVHIHZhcmlhbnRzIikNCj4+Pg0KPj4+IE5vdCBh
ICJGaXhlcyIsIGp1c3QgYW4gYWRkaXRpb25hbCBjaGVjaw0KPj4NCj4NCj5UaGF0IHdhcyBkaXNj
dXNzZWQgd2hlbiBkZXZlbG9waW5nIHRoYXQgcGF0Y2g6DQo+DQo+aHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbW0vODd0dTV2ZmxsZC5mc2ZAaW50ZWwuY29tL1QvDQo+DQo+R0VNX0JVR19P
TigNCj4tPiBCYWQgd2l0aCBDT05GSUdfRFJNX0k5MTVfREVCVUdfR0VNX09OQ0UNCj4NCj5KdXN0
IGxpa2UgVk1fQlVHX09OIG9yIENJX0JVR19PTi4uLiB0aGF0IEJVR3Mgb25seSB3aXRoIGFub3Ro
ZXIga2VybmVsDQo+Y29uZmlnIG9uLg0KPg0KPlNvIHRoaXMgaXMgZXhwZWN0ZWQuDQoNCkhtbSwN
Cg0KT2suDQoNCk1heWJlIG5leHQgdGltZS4NCg0KTQ0KDQo+LS0NCj5DaGVlcnMsDQo+DQo+RGF2
aWQgLyBkaGlsZGVuYg0KDQo=
