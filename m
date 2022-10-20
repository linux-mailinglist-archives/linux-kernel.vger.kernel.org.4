Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFA560574D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJTGZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJTGY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:24:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C49C3549
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666247095; x=1697783095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fMzWa/Gwpyre4BKSb3g+2SAajdFRcLvOcuzd+v6Vjew=;
  b=nyTf+h5o+FVOyScjhKQyuTfxNbkc4AIMK4hXy0oo31l//WDPrtV8UryI
   rklJM5fooPsMpfGzt9Gz1P2i9yEuFn/wPvpWfTcGiBg8zZ7bykPRZu4gq
   tspZUtR0k1ROSp9adbiqYr6UyGlWY6aFYuU3Hh9axP3FVmv87NkJT/8j9
   P86gm8TG0E2IdqEBXIUsZSyAT4FRp6c3FRbOBdkjTK92YxuSxTmWMNOOs
   SiBQsTP1+3wSXGiGGlx04/Up1IW4YZ2Uz4keb/Lg0JSNn1f//50Hetuvz
   ZHz4ntiaHrb2SShe4nS3X+YHCWRuZCrLoDTtN/4qZhNHNaVW5C+JDNclX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="289928873"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="289928873"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 23:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="624498800"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="624498800"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2022 23:24:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 23:24:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 23:24:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 23:24:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 23:24:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW+AoIZLeqtRDD/6Tz2LWCkgcEBJojGOdSTggVjf5obwHeTYsRd21D1GEAJjKGi2aj5BvFmKHf0TAZx1qNung8cGTrohx3ykvcT5cphYCg+8tHXRWyBVonypxa6B/SiKCrGxNVHAtACDTWuwcto3ch2X5UM9fG8NM1hLmFgdY50TRBtkwlG/c/raX4n1kbmuXDQJ15+3rgDyaCig27yBvwbJC4KaylOJrTGd34Oqvh0yAzvwZLJYz17FFca3hPxaOQR52Dab4EdL8OeT78MndklYl/Lk6tninBFfZEreedFj9smNFfN/WxG2H/dgDNA1q90PqEnMdElEFGZwESrjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMzWa/Gwpyre4BKSb3g+2SAajdFRcLvOcuzd+v6Vjew=;
 b=WmJLhnz47jiaNWp9YBkboeN3jwgdOEbuV1aPBmPmqt8kOaO5Bbort97WsjU7Z7FC2Al0B+LvgN4WR4OsJZR1R7Nbv3f8jcRGUITdDJVHeWi4OcKh1pMVIbla/tUJSY6hA+ygYksBJ0BztH93iJLvSSI5tF9hvZCl7kOMDNbxwEoOaUdBI8HoTNyCZdVSymAPWioEdL6Ax6am1ZOM8sLP8USTEPcIKm2kYoaux2Tmp/pknzM0LnHCvX4tVlvDM/62lkde7oMh0WmUc5trPdYrNQU3dVeOmSREPcM3sb3a34TRQnii6T2VkZwuatH9kOmJ+Tu2T8QT+P/Ek2DCtbKcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DS0PR11MB7382.namprd11.prod.outlook.com
 (2603:10b6:8:134::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 06:24:40 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.034; Thu, 20 Oct
 2022 06:24:40 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Topic: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Thread-Index: AQHY47Kv7yW3S865XEiTjYU/Nl/o964VodIAgABWNFCAAMBdgIAAC5GggAAJXQCAAAO2cA==
Date:   Thu, 20 Oct 2022 06:24:40 +0000
Message-ID: <BN6PR1101MB216117B35240DCD5E0F8526BA82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
 <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <7bbc19c8-3494-1770-d186-ce5a92d511aa@suse.com>
 <BN6PR1101MB21614EE46D700C24E7D77E8FA82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <a7e33fc8-3333-02a3-903b-ae6ffbf09f3d@suse.com>
In-Reply-To: <a7e33fc8-3333-02a3-903b-ae6ffbf09f3d@suse.com>
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
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DS0PR11MB7382:EE_
x-ms-office365-filtering-correlation-id: 30077044-3311-4d56-e9df-08dab263c54a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlbPkjIQCmGBoBJ3npo4Yh6tDadsL5yuTQIQxXgnbVt0Nn7e8g2MubdZh2fqDz/kizv3BYiKBHLonmS2A/Y5m4nez3ZYARDTeH8CDx+mQY6d6XHpC9UBQg6Al7cVPi7w1/49+f6FJ1BOMirKxQAhGKIMw/Nh7A7v+qHdzks5QlEMPxWRKxmGvv0lrIbWp92b5BCq5UbQe6jJYs2+NT5dmhBb9hHgFOj/vRao0NGyyHt6Fx3sfq5cEEtNXGmlEzLVwC1in3yLbutNWdvjakdpfR10vCFgaJaPv3u/UBUg5jlMnpiGSAi3ce+UFcZqJK1E6F5lRtrLKZmRdVUvFn+cUyu4OaXB3bn0MPRPiPotKHmzIzB//U+sr8QSzEaPvQhJunGP5FHbI4/gvAyQKhla36M/GTtI74s/TTV0fYcvtrFoZkGSW2TS0C+keKvlRuI0jdj6a/UB6CvlbDV+kC/zcXJyyyEZOiXVydJ7mWtn1ngLH1vvK8nEB+dZyJ/p8gYV/1pQHYi2GAXCChHnjGgTSKPUSlvak3tVzGBbimjTGb1g1cs4hrFmeh/kYwrm/quuvFC7y0xHzeATUu1fXq8+b2dLRYkCl9aKhGYvyEzBsdwLEx3vNHOd6cYmgzHhMWvZ2DYUdOk8RkzWflwqbeEUofPYb61evC6nQIxqP9SzhOr6ZQ88Rx92HuJF2ssHJg7p6xJJtHwg/Mg/Zf3so3xEDk/eAs0/gHRICXGL2kWMzEdeiD5zxacck55BzzAlmciEqbmE7lacXvhSBjxqqkfgiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199015)(76116006)(110136005)(66446008)(316002)(54906003)(53546011)(41300700001)(55016003)(5660300002)(83380400001)(9686003)(6506007)(7696005)(26005)(8936002)(52536014)(64756008)(86362001)(66946007)(7416002)(66476007)(66556008)(8676002)(4326008)(38100700002)(2906002)(66899015)(82960400001)(71200400001)(38070700005)(478600001)(186003)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWNvZ1BrZ0NXUXVVMExIMUd4UVZBUDQzYmtCMFlRT2hYTkF4U2MzV3RVRi8w?=
 =?utf-8?B?NEFhUHZ6VkhOOW5RZHNFMURzaFhvZlFnaE4yOWRKR0FnTzRrSnlTTTZqUCtv?=
 =?utf-8?B?SnNaNm5QZDhLVzBiNksrUFUzYlJicjA5bjQvQUViVy85QkNMVEhGU2o1UUhy?=
 =?utf-8?B?T1A1cS9UN3JWb2tnS0RyOCt5TVlxQUYrWDRLY2tvY1VVS2NaVlV0NWpXai9X?=
 =?utf-8?B?MEpjK3Y2UWlUTUc5ZlN3Ull4ZzNaWEFndFgxVHhzTEp3L3U4bmVLY0lGeERk?=
 =?utf-8?B?NFJLNFhocmNIK2U4ejZ2MEJ2TTMvb1R1ZDdxdEZ0RElmcmxYejFkdU8yN1lz?=
 =?utf-8?B?WDRqYWw3VDNvVkNtSWNJN0gxbXlERTNDemUrbmxlZlJ0Rko5NVFUam1pQTQ5?=
 =?utf-8?B?WCt2T01idmNOMnd6Z1N5bHBPT1lwMkd1UHhIU2dFc1lqZDBCUURoUjhNZXB5?=
 =?utf-8?B?ejY4QjRkemFmTWI2RStnSHM5Y05ZaWxYRktYVVd3SmdFYThvRWNJNGhUN2RX?=
 =?utf-8?B?cTRqUkhldEtIM1ZURFJlR3dKaFRkbldCbjBHYzRieW13cDBOc0FJOXVzRXdY?=
 =?utf-8?B?Z3d1UGF6d0ZCalp1RVd3TXl0VEt5YktMZUx1RUlzbkJ0TEQ5QThMaTQxQ2xD?=
 =?utf-8?B?QTZYUVROR1FHWUY2ZEhlQmhxTWoyTVpYVGJ2R0Y3M0NLQ0hGWFpqNDQvQms1?=
 =?utf-8?B?cXpXVFZqa1lpM2grbFpGSy9YanRIRk5keWE0S0czQjhYTEZWRDlybDhyWEJZ?=
 =?utf-8?B?Zk5tQUc0dlFMS0FpM3grWnZydEJ4NVBiVDc5VjVwa0VmRmcrM0hELzNGdk5a?=
 =?utf-8?B?dVloZEhITGVqdWNZS2p0Z2h4SnFrR3A5MWpjTjhGSzB0UDFybGQyKzd4d2Ur?=
 =?utf-8?B?M2k4c0JyN2t5K2JoWDlsWENjMHVxSTBrUXRxeUsxUlBZcE5lNVpXUEhZZE1m?=
 =?utf-8?B?Wlhlei9WNWx2c0h6VnVEL0JKYjZnWFcrTXNvMzlET012S1hhcCtLSURpNjRx?=
 =?utf-8?B?YkYrcU5CT1NrODh1K3dtWmhCK2VIelRtMklua2xMUDI0enNHSTFRdVF5dWFv?=
 =?utf-8?B?KzRNWHZicDFINysyNGVRRC9rcElXQWN3bk9FN002L1lxWHY1bEZsNlNXemdB?=
 =?utf-8?B?dG5VdGRVTWUvTTJ2akhXK0kvald0TUNaa1d0ekZ6ZVpacERaeTlHWVJ1dUZv?=
 =?utf-8?B?K2NHM2I0OUVpbDBDb2t4VjR2ZWJFdEZ3ZjhidTRiQi9ldyswZDlabTBxRnJx?=
 =?utf-8?B?N1dvcmZ2R2xVREZFMnlnTnQwQStCWmxPdXR4bVVWbDViMk5pZ0M3bFlOSkxn?=
 =?utf-8?B?SmV3cVhpb3ZNVE5SS2xQS09lRnllb3M3cUpucG1xSXVoVVRBYTA3Wko4Z0x6?=
 =?utf-8?B?U2ZoSHJrUzl4L2dvRkN6bVVJaW92VVdidWFwa3hrWlBiTVJUWnJoeklhWDY2?=
 =?utf-8?B?K3p5V1o1TzNNU0xid0F1cXRROUEzTitWL1YyUUZTVVJ2WVV1aVdhOEhHb28z?=
 =?utf-8?B?SHZ4MDJ0TFhFeHpmUlM5czJTZHhzdURjTFpDUlNVVDJxWDlWQ3BDRlFJZU9n?=
 =?utf-8?B?aGphdWZmNUJqV0FkZzJkWTFQaUdRdUZuQ2RSL2U0bVh5bk51SDlNR0poK2RE?=
 =?utf-8?B?eDlEaGF0OFhjNW9uRjhISFcrWVo2QTQxcm9ESUw5RUEvQWx0ZWNCVkFUQWkr?=
 =?utf-8?B?UFJZZDBrcnNiQmplNzhVRlg5VjJiUzlzZzVwbnBXNHVzTCtHUFlBSUJnS3FU?=
 =?utf-8?B?b2thVGRJRGQ3UUdIdWxyWXc2Vk1temNMWE9ycDkwSDNISnU0eGFTUzFyekNJ?=
 =?utf-8?B?YU5JRlc1N2xGNHBVYldsb3RUQUU5a1RTRTZ6M2hETWRlK09kTk0zZU1PbWpB?=
 =?utf-8?B?Z2FHUkJaMGc2aFZjWmRQaUxWZHY4V2lzZ0FZQURwUGZVYm9nai9HYWdCMWJu?=
 =?utf-8?B?NTVkZDJ4YzdJbDdtT2lBcGZMcXR4dTRBMEVVVUZiUlVvNDd2aHFUQUczZ1dG?=
 =?utf-8?B?MkcyV1AxTGVGSUlpR0xURHZ1SzhlY2E2YnArcGFCbEJ0Z0VZZUFKWVNCbTBJ?=
 =?utf-8?B?VG5ZVmVQZm1qM3V5NkVpUHh6Lzg2UTZ0NEU2dENvTXFrYURCd05lZG1mR3lh?=
 =?utf-8?Q?BuIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30077044-3311-4d56-e9df-08dab263c54a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 06:24:40.7561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKziJwggE6/6FnxnI4PifYVoEotoPgdnRWI7pTIjEGWRGtMXiD0V5N+AUhA20ESbMdF1a0rFXOYmyHdeeEQzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7382
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyMC4xMC4yMiAwNzo1OCwgTGksIFhpbjMgd3JvdGU6DQo+ID4+IE9uIDE5LjEwLjIyIDE5
OjQ1LCBMaSwgWGluMyB3cm90ZToNCj4gPj4+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBfX2luaXQg
bGtnc19pbml0KHZvaWQpIHsgI2lmZGVmDQo+ID4+Pj4+ICtDT05GSUdfUEFSQVZJUlRfWFhMICNp
ZmRlZiBDT05GSUdfWDg2XzY0DQo+ID4+Pj4+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2
X0ZFQVRVUkVfTEtHUykpDQo+ID4+Pj4+ICsJCXB2X29wcy5jcHUubG9hZF9nc19pbmRleCA9IG5h
dGl2ZV9sa2dzOw0KPiA+Pj4+DQo+ID4+Pj4gRm9yIHRoaXMgdG8gd29yayBjb3JyZWN0bHkgd2hl
biBydW5uaW5nIGFzIGEgWGVuIFBWIGd1ZXN0LCB5b3UgbmVlZA0KPiA+Pj4+IHRvIGFkZA0KPiA+
Pj4+DQo+ID4+Pj4gCXNldHVwX2NsZWFyX2NwdV9jYXAoWDg2X0ZFQVRVUkVfTEtHUyk7DQo+ID4+
Pj4NCj4gPj4+PiB0byB4ZW5faW5pdF9jYXBhYmlsaXRpZXMoKSBpbiBhcmNoL3g4Ni94ZW4vZW5s
aWdodGVuX3B2LmMsIGFzDQo+ID4+Pj4gb3RoZXJ3aXNlIHRoZSBYZW4gc3BlY2lmaWMgLmxvYWRf
Z3NfaW5kZXggdmVjdG9yIHdpbGwgYmUgb3ZlcndyaXR0ZW4uDQo+ID4+Pg0KPiA+Pj4gWWVhaCwg
d2UgZGVmaW5pdGVseSBzaG91bGQgYWRkIGl0IHRvIGRpc2FibGUgTEtHUyBpbiBhIFhlbiBQViBn
dWVzdC4NCj4gPj4+DQo+ID4+PiBTbyBkb2VzIGl0IG1lYW4gdGhhdCB0aGUgWGVuIFBWIHVzZXMg
YSBibGFjayBsaXN0IGR1cmluZyBmZWF0dXJlIGRldGVjdGlvbj8NCj4gPj4+IElmIHllcyB0aGVu
IG5ldyBmZWF0dXJlcyBhcmUgb2Z0ZW4gcmVxdWlyZWQgdG8gYmUgbWFza2VkIHdpdGggYW4NCj4g
Pj4+IGV4cGxpY2l0IGNhbGwgdG8gc2V0dXBfY2xlYXJfY3B1X2NhcC4NCj4gPj4+DQo+ID4+PiBX
b3VsZG4ndCBhIHdoaXRlIGxpc3QgYmUgYmV0dGVyPw0KPiA+Pj4gVGhlbiB0aGUgam9iIGlzIG1v
cmUganVzdCBvbiB0aGUgWGVuIFBWIHNpZGUsIGFuZCBpdCBjYW4gc2VsZWN0aXZlbHkNCj4gPj4+
IGVuYWJsZSBhIG5ldyBmZWF0dXJlLCBzb21ldGltZXMgd2l0aCBYZW4gUFYgc3BlY2lmaWMgaGFu
ZGxpbmcgY29kZQ0KPiBhZGRlZC4NCj4gPj4NCj4gPj4gVGhpcyBpcyBub3QgaG93IGl0IHdvcmtz
LiBGZWF0dXJlIGRldGVjdGlvbiBpcyBnZW5lcmljIGNvZGUsIHNvIHdlJ2QNCj4gPj4gbmVlZCB0
byB0d2VhayB0aGF0IGZvciBzd2l0Y2hpbmcgdG8gYSB3aGl0ZWxpc3QuDQo+ID4+DQo+ID4NCj4g
PiBZZXMsIGEgWGVuIFBWIGd1ZXN0IGlzIGJhc2ljYWxseSBhIExpbnV4IHN5c3RlbS4gIEhvd2V2
ZXIgSUlSQywgdGhlDQo+ID4gWGVuIFBWIENQVUlEIGlzIHBhcmEtdmlydHVhbGl6ZWQsIHNvIGl0
J3MgWGVuIGh5cGVydmlzb3Incw0KPiA+IHJlc3BvbnNpYmlsaXR5IHRvIGRlY2lkZSBmZWF0dXJl
cyBleHBvc2VkIHRvIGEgWGVuIFBWIGd1ZXN0LiAgTm8/DQo+IA0KPiBJbiB0aGVvcnkgeW91IGFy
ZSByaWdodCwgb2YgY291cnNlLg0KPiANCj4gT1RPSCB0aGUgWGVuIFBWIGludGVyZmFjZSBoYXMg
YSBsb25nIGFuZCBjb21wbGljYXRlZCBoaXN0b3J5LCBhbmQgd2UgaGF2ZSB0bw0KPiBkZWFsIHdp
dGggb2xkIGh5cGVydmlzb3IgdmVyc2lvbnMsIHRvby4NCj4gDQo+ID4+IEFkZGl0aW9uYWxseSBt
b3N0IGZlYXR1cmVzIGRvbid0IHJlcXVpcmUgYW55IFhlbiBQViBzcGVjaWZpYw0KPiA+PiBoYW5k
bGluZy4gVGhpcyBpcyBuZWVkZWQgZm9yIHNvbWUgcGFyYXZpcnR1YWxpemVkIHByaXZpbGVnZWQN
Cj4gPj4gb3BlcmF0aW9ucyBvbmx5LiBTbyBzd2l0Y2hpbmcgdG8gYSB3aGl0ZWxpc3Qgd291bGQg
YWRkIG1vcmUgZWZmb3J0Lg0KPiA+Pg0KPiA+DQo+ID4gTEtHUyBpcyBhbGxvd2VkIG9ubHkgaW4g
cmluZyAwLCB0aHVzIG9ubHkgWGVuIGh5cGVydmlzb3IgY291bGQgdXNlIGl0Lg0KPiANCj4gUmln
aHQsIGl0IHdvdWxkIGJlIG9uZSBvZiB0aGUgZmVhdHVyZXMgd2hlcmUgYSB3aGl0ZWxpc3Qgd291
bGQgYmUgbmljZS4NCj4gDQo+IE9UT0ggdG9kYXkgb25seSAxMSBmZWF0dXJlcyBuZWVkIHNwZWNp
YWwgaGFuZGxpbmcgaW4gWGVuIFBWIGd1ZXN0cywgd2hpbGUgdGhlDQo+IHJlc3Qgb2YgbW9yZSB0
aGFuIDMwMCBmZWF0dXJlcyBkb2Vzbid0Lg0KPiANCg0KR290IHRvIHNheSwgbm90aGluZyBpcyBt
b3JlIGNvbnZpbmNpbmcgdGhhbiBzdHJvbmcgZGF0YS4NClhpbg0KDQo+IA0KPiBKdWVyZ2VuDQo=
