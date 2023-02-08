Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E5668EF96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjBHNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjBHNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:13:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662A446160;
        Wed,  8 Feb 2023 05:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675861988; x=1707397988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GO0dboIhHMBfteSO4nIbX2w7nGOQxaP2fuIFMCh2miQ=;
  b=ilGnDZHx5sxYZKbKqQ1wFeWb7jumPkD0uzm3gdG7fUOm5ISuzoBa5ow9
   3YHjPV0535jo8R7GktXbaqicSfaj1iH0y6vEO9BVqrPHOevUwY7/d+PmD
   ek7ijN/ejikq/mENFgopo69EtDgsdAYErGLPZuRTHUfIHzeS0eo6TDq3a
   yKjQahFCYrItEtkYsxOeUUl7J1NxXGDq+L41SFBBc5FWI38er4qRMZwfN
   m47Z7ABX3n/kUFJ/r6G0lJGjs6JX2gwwuQsp2seEtPCoNvcUU2cJzde0G
   ud5uTy+aX7FhB1mLU0ocOVZt8JQ8SsDegO7prIImMUw8bOAy6E2OG4pXK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310145907"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="310145907"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 05:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="776014210"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="776014210"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 05:12:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 05:12:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 05:12:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 05:12:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 05:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5phVuaJclIMzG/4g/MmOqtNxtH9f1FBdV2jWJD15NfKGZ42VeOfUsE5ApTpiajrgwxjzezQSn2q+9/nimVJJbZZfXFPlX7etKMa0RPPLWRbMWm9tzsB8zAZM1deIbJdLd1fJD4C8bf/LUd3tr953+g48RUyQSymDn1JRrVz/zrgFyzpA14db38n4fLiWymra3/uayqJ6czlhedT4gOE9oYV1GVs8tihyCRjX1njJOkk+e1EroofVNQ3ZiLyFbFvBeW2wygU+2qTtNtsyk6RECOClHH7t+Nnoh91u1BHTeTIS02rkJP62gdZFxYqdj65vH/FL4SqLmwvCpKrgtdqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO0dboIhHMBfteSO4nIbX2w7nGOQxaP2fuIFMCh2miQ=;
 b=XKNeExfxzN60mh7I6QLNfln3u7OO/tXGDRNEVZESZqJNS7ck2asHbkQ+xeDAz0XPCGSp6DO2YYNNkeSKkMA5OfzzXOs3x1gs5cmMz6Hhxpn+Ldge0tzkGQrHxSDgwLCyoltrFvIAEaeTZUnoK1N9RKqfkYWR58+MypF52Kf15Mkg32pUzTY/uJTVz1E5zv04w6nn369H5ZkY0z3gKlLOVktDN3evGI9S1CCJVhf4WSz8Eeo6p4I9lpIZKe23p4Kcnc3JAB/iNocSaUTirmO0hU7XlKKvRMHe+hPltxfYiA5hzNPMkOzG0T+254ZpwMhcRCCz0b0xvphv60qlM16fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Wed, 8 Feb 2023 13:12:41 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::52f:ae62:7fbd:600e]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::52f:ae62:7fbd:600e%8]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 13:12:41 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Fix bind rcu related kthreads to housekeeping CPUs
Thread-Topic: [PATCH] rcu: Fix bind rcu related kthreads to housekeeping CPUs
Thread-Index: AQHZO22F191pxAkNDEeN6nL3yploxK7E+ylQ
Date:   Wed, 8 Feb 2023 13:12:41 +0000
Message-ID: <IA1PR11MB61717873D4697DBB04526F6489D89@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230208033408.3997610-1-qiang1.zhang@intel.com>
In-Reply-To: <20230208033408.3997610-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|DM4PR11MB6504:EE_
x-ms-office365-filtering-correlation-id: 8146a501-37eb-4caa-831a-08db09d628ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJLd7Re4M4/hSBcd+iJbBQGdM6kMRHyqoD0urDM0ahS10okvhiyoDYAfTrQUvkPlapMRfVJeLa4o3TIWvFh7wWO+b6rZAZl8ZlMlUcfzDr4QXQqwuNjrVg3/EKs+vbexRtEQcKXQg0KD+gtRjrvuXq09snbDqxtcv50ftijcDFduu5FBT+D5Ec84MFwIITInslRudOsW1XvB6Uf3SoYGB3MzoBNiJLiY/MzO5VdXS+jEwWAnHzJeRuCLV1Mru3x8uMBgjHLVhFtUr0AIewEmmbu+5zvzJFJpMMj52oHkK7ZZWsXntr/WCjMZFdVIgNhVW51ZIcuXvYLf/MzyBbOqGzx1n6+u6tRS6pQkFX4pO4yfFJuBcxJgE0TxhjFk3/WX7rqLebd8uqOCNWXPyJNUSbjCVUt7Xd0g6DJm8r9kINJ/macgkMQQ8J5NPvpGOlMEIsUdEbLCdCF9x6woKBzffXd2jNwUdfHDXyUPaKWNZdAUiW84dA4f2nFNMPXzSl0Cj+3TAIUiTEMsggThFX2Yf1/HopERd1LQg+FKsmBD7R7octezE0UE6WgffHvAiO/im/W8Ajmv1hDc+dDn10kqWYmK+pJTaGNwSMCN7D1tAVLGnqP9/6g/GcO+SrtmZdYwm7ASBNuva16rjKvdXXtXfm9ky+aKtkMpR5hZL3ZOnh7Z3p6Q/QvmdIL1e9Oxuj9la6lzm4eRmcz61+wP7nKDqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199018)(4326008)(66574015)(8676002)(66556008)(66946007)(76116006)(64756008)(66476007)(66446008)(41300700001)(82960400001)(38100700002)(122000001)(186003)(26005)(2906002)(38070700005)(71200400001)(55016003)(33656002)(478600001)(8936002)(52536014)(6506007)(53546011)(9686003)(316002)(86362001)(110136005)(7696005)(5660300002)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE9kWWhvK3NhZVExaHBZYnNMU0wxa01LMytQU2ZhNE1GUkl1U0NaMk1DbGUx?=
 =?utf-8?B?TFk1MGlMNWtBUnR1bDg0MmtFb1hyVlloY1BRdFhtbmorWCtKb3MrTUo0Vmdm?=
 =?utf-8?B?UzNQRFZuNllwT2o5b01iREJrRzFEcm54V2t2RkZxTUVhWmN5NFdNSEVadmg1?=
 =?utf-8?B?dUFOdjUvcGl1VWNiSkUwSGZLbk4rWDdBYTB4OEx1V0o3U3pTNW1nelB1cm9l?=
 =?utf-8?B?UWNkMTg3Z3lJWDNTVjd4RXpwSUZ1YTFkZG03aFR2c1c4OWYzViswTXBMYzI3?=
 =?utf-8?B?ZjFKNE5zVGFXeVFxUkEyUXBSeXdDRzd0NEpZMEh0cWxrT2lCTEtxelFOUWI1?=
 =?utf-8?B?ZFNHUCtjTUdidExIbS9vVEpqNkFlS1lzaE52K1Y0dHE4ZmxGR0J0SXVOclpw?=
 =?utf-8?B?cXdlVXFQSEVjWk5idUtKclNod1FTeDhFckNTVWNzeitiSGYvKzNvVXhXMGVj?=
 =?utf-8?B?SWZyTkx3WUtBV3ZpcGRXa0VEc2EvS2JhTGxOZVp5WTVmaWtDdDRHQStBSXVn?=
 =?utf-8?B?NzRLc1ZGN2VUSVB6VndyZ1pWcjdqeUo0V25hNUNFbmpsRkVrZm5scmZlNTdK?=
 =?utf-8?B?eXVxMjVPRTd0c2Z2VUgzY285RW9vNWhsMFI5YmxkcEIxTjl3aW5aNWtGSmZx?=
 =?utf-8?B?VlpVaUFKQWp0VFhRY1gyekhOOEdRWnZxK2lNbCtnQ2V3SU93b3NrWThZOUFi?=
 =?utf-8?B?STc1TldvYTQ5M2NlcGZ5ZGo1U1dydVFSd0NVc01BalpBcWJvdS8zdnN3Tmcy?=
 =?utf-8?B?elMwTkhLZDEzNlRzbEpFUFpTYktHenBvT2NqNmIzRHJPZU1vWTI4ZHY3YmFu?=
 =?utf-8?B?TktUSUJiMnJmYzRTSUcyb2ROaXJrZXpHZExGQVYvTlFXdnlaZTVLTFVycTBS?=
 =?utf-8?B?V1lZaXQ4bXZBeUNTaGNxMEF2d2ZKWTdZMVRwdis3d0FaaDZZdC8zTEU2N1NW?=
 =?utf-8?B?T0p2a05zZ0U0cEFBZTIwMk9RYk1aR253ZU1tWkdyd2lqYmRxS1lLcEFzSllo?=
 =?utf-8?B?VnRrVGhNQytVSUQxR1krcmhFc3ViSkl6STI1aC8yMEJtdVFkbS91T3dZZmEr?=
 =?utf-8?B?eW9HM1VBbnNMRmNvVjZneUI5ZHZEemZNL2dGbjZlM0l4bWVWQ0JJZnhZUzM3?=
 =?utf-8?B?TXo4Qzd2UlR4RTRUOXgyc3dXNmk2bTJ2NGhiR3VLTHpIWjY2K0llMi94WHd4?=
 =?utf-8?B?cUdubkEzSlZIMk1mTFpBQ3A5L1RXc0E0VmQ3RDEzbkozbzNBZ0lleTBKWjN3?=
 =?utf-8?B?Q0NGOWpBMUEzL1FWeGxYYVQ3aDlWT1ovNlNWalBBOEJzenExaGJtRWp4TjFj?=
 =?utf-8?B?czhmUDMyQmlOL1crWjMrZ08yMFFKWFNiSUZaVGRrMVZxdFY5ODBreGloaUps?=
 =?utf-8?B?ek4rTnNSeEhvc0Y5TW1SOE9hNkN6U3gySkd3UllaYVFNYkd0NGxyNTRjWU5o?=
 =?utf-8?B?VjNXWTY5cGU2V1F0VXZYM0tUV05MRGVoTzBoSVdaS1B0OUNwaFY0Z3dNdDFY?=
 =?utf-8?B?b3J6SGZIMDk2MHVCcm14YWtpVVE4VDBJRXRxMXRVTDJkdHQ0YXJjVk5jWVNQ?=
 =?utf-8?B?OXVKY1NUbXBObWg3SzUwTnNVN1VmY0VOQ0NrQzY2N0RKNzc3VzVVMlFYQzRt?=
 =?utf-8?B?NVkwNXR1MjNJSmNDOGh4OUlkMWt0ZmFsL3lDUmZGS1FnODl1YTJzdi9YVmxP?=
 =?utf-8?B?cEMvWHkyTFI0dGIvVFFSZkgrbG96REVJN1ZpbUEzcHQ4SmFyQlpyWk1sQ2RL?=
 =?utf-8?B?anF5WG91TXdQVXJ3M3orZTBJRjRhNWtmVFQzUjAzQW1vU0ZyK1ArZHRLNnRB?=
 =?utf-8?B?eTZpZWVzNzA1eXhTcks4cGVCOCtMeDZoR054TStpQ1ZGMWtZUU5QOUlGa0hP?=
 =?utf-8?B?QXZjUU9UbWorNDlTd0NxS0Fjd0NTZUdkL2tVdmRkQmF5emlINElvWTg5QWY3?=
 =?utf-8?B?MEFscXRpSnYvdDFmZEVDaktMbXdPenI2Mnc2ZTBtSDZ6aHIwaFN1eHhSQll2?=
 =?utf-8?B?ZXV3ajB0NytVcjl6STFycHVrWHFaQXdwM0lHK1VTK1cwY2h1VGpmRFdPVGlT?=
 =?utf-8?B?dGFFU1B4NU54MC8rTVVPU0ptWUJuMmJEQ1VBd2lnTjlMY0lpYmVmeWV6UFVC?=
 =?utf-8?Q?OB4MGXcybMXaubTlN17BjGeuV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8146a501-37eb-4caa-831a-08db09d628ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 13:12:41.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAujfu8LaskJUQfZULEfxDtkNSHuwtNX2jpF5VtPDKc+Mg7i9/v0vUsFsc6WN2XBo7l6xxaqWk/9KwpYG4F/hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGlkIHRoZSB0ZXN0aW5nIGFuZCBjaGVja2VkIHRoZSBDUFUgYWZmaW5pdGllcyBvZiBSQ1Uga3Ro
cmVhZHMgYnkgcnVubmluZyAicHMgLWVvIHBzcixjb21tfCBncmVwIHJjdSIgWzFdOg0KDQpXaXRo
b3V0IFpxaWFuZydzIHBhdGNoOg0KICAgIC4uLg0KICAgIDAgcmN1X3ByZWVtcHQNCiAgICAwIHJj
dW9nLzANCiAgICAwIHJjdW9wLzANCiAgICAwIHJjdW9wLzENCiAgICAwIHJjdW9nLzINCiAgICAw
IHJjdW9wLzINCiAgICAyIHJjdW9wLzMNCg0KV2l0aCBacWlhbmcncyBwYXRjaDoNCiAgICAuLi4N
CiAgICAzIHJjdV9wcmVlbXB0ICAgLy8gb24gaG91c2VrZWVwaW5nIENQVSAzDQogICAgMiByY3Vv
Zy8wICAgICAgICAgICAgLy8gb24gaG91c2VrZWVwaW5nIENQVSAyDQogICAgMyByY3VvcC8wICAg
ICAgICAgICAgLy8gb24gaG91c2VrZWVwaW5nIENQVSAzDQogICAgMyByY3VvcC8xICAgICAgICAg
ICAgLy8gb24gaG91c2VrZWVwaW5nIENQVSAzDQogICAgMCByY3VvZy8yICAgICAgICAgICAgLy8g
b24gbm9uLWhvdXNla2VlcGluZyBDUFUgMC4gIFsyXQ0KICAgIDAgcmN1b3AvMiAgICAgICAgICAg
IC8vIG9uIG5vbi1ob3VzZWtlZXBpbmcgQ1BVIDAuICBbMl0NCiAgICAyIHJjdW9wLzMNCg0KWzFd
IFRoZSAxc3QgY29sdW1uIG9mIHRoZSBvdXRwdXQgaXMgZm9yIENQVSBJRHMgYW5kIHRoZSAybmQg
Y29sdW1uIGlzIGZvciB0aHJlYWQgbmFtZXMuIA0KWzJdIEFkZGVkIGRlYnVnIG1lc3NhZ2VzIGlu
dG8gdGhlIHR3byB0aHJlYWRzLCBhbmQgZm91bmQgdGhhdCB0aGUgdHdvIHRocmVhZHMgZGlkbid0
IHJ1biBhZnRlciBhbGwgQ1BVcyB3ZXJlIG9ubGluZS4NCiAgICAgU28gaWYgdGhleSBydW4gYWdh
aW4gYWZ0ZXIgYWxsIENQVXMgYXJlIG9ubGluZSwgdGhleSB3aWxsIGFsc28gYmUgbW92ZWQgdG8g
aG91c2VrZWVwaW5nIENQVXMgYnkgWnFpYW5nJ3MgcGF0Y2guIA0KDQo+IEZyb206IFpxaWFuZyA8
cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA4LCAy
MDIzIDExOjM0IEFNDQo+IFRvOiBwYXVsbWNrQGtlcm5lbC5vcmc7IGZyZWRlcmljQGtlcm5lbC5v
cmc7IGpvZWxAam9lbGZlcm5hbmRlcy5vcmcNCj4gQ2M6IHJjdUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSByY3U6IEZpeCBi
aW5kIHJjdSByZWxhdGVkIGt0aHJlYWRzIHRvIGhvdXNla2VlcGluZyBDUFVzDQo+IA0KPiBGb3Ig
a2VybmVscyBidWlsdCB3aXRoIENPTkZJR19OT19IWl9GVUxMPXkgYW5kIENPTkZJR19SQ1VfTk9D
Ql9DUFU9eSwNCj4gcnVuIHRoZSBmb2xsb3dpbmcgdGVzdHM6DQo+IA0KPiBydW5xZW11IGt2bSBz
bGlycCBub2dyYXBoaWMgcWVtdXBhcmFtcz0iLW0gMTAyNCAtc21wIDQiDQo+IGJvb3RwYXJhbXM9
ImNvbnNvbGU9dHR5UzAgaXNvbGNwdXM9MCwxIG5vaHpfZnVsbD0wLDEgcmN1X25vY2JzPTAsMSIN
Cj4gDQo+IHJvb3RAcWVtdXg4Ni02NDp+IyBwcyAtZWYgfCBncmVwICJyY3VfcHJlZW1wdCIgfCBn
cmVwIC12IGdyZXAgfCBhd2sgJ3twcmludA0KPiAkMn0nDQo+IDE1DQo+IHJvb3RAcWVtdXg4Ni02
NDp+IyBwcyAtZWYgfCBncmVwICJyY3VvcC8wIiB8IGdyZXAgLXYgZ3JlcCB8IGF3ayAne3ByaW50
ICQyfScNCj4gMTcNCj4gcm9vdEBxZW11eDg2LTY0On4jIHRhc2tzZXQgLXAgMTUNCj4gcGlkIDE1
J3MgY3VycmVudCBhZmZpbml0eSBtYXNrOiAxDQo+IHJvb3RAcWVtdXg4Ni02NDp+IyB0YXNrc2V0
IC1wIDE3DQo+IHBpZCAxNydzIGN1cnJlbnQgYWZmaW5pdHkgbWFzazogMQ0KPiANCj4gVGhlIGFm
ZmluaXR5IG9mIHRoZXNlIHJjdSByZWxhdGVkIGt0aHJlYWRzIGlzIG5vdCBzZXQgdG8gaG91c2Vr
ZWVwaW5nIGNwdW1hc2ssDQo+IGV2ZW4gaWYgY2FsbGVkIHJjdV9iaW5kX2dwX2t0aHJlYWQoKSB3
aGVuIHRoZSByY3UgcmVsYXRlZCBrdGhyZWFkIHN0YXJ0cy4NCj4gDQo+IHNldF9jcHVzX2FsbG93
ZWRfcHRyKCkNCj4gIC0+X19zZXRfY3B1c19hbGxvd2VkX3B0cigpDQo+ICAgIC0+X19zZXRfY3B1
c19hbGxvd2VkX3B0cl9sb2NrZWQNCj4gICAgICB7DQo+IAkJYm9vbCBrdGhyZWFkID0gcC0+Zmxh
Z3MgJiBQRl9LVEhSRUFEOw0KPiAJCS4uLi4NCj4gCQlpZiAoa3RocmVhZCB8fCBpc19taWdyYXRp
b25fZGlzYWJsZWQocCkpDQo+IAkJCWNwdV92YWxpZF9tYXNrID0gY3B1X29ubGluZV9tYXNrOw0K
PiAJCS4uLi4NCj4gCQlkZXN0X2NwdSA9IGNwdW1hc2tfYW55X2FuZF9kaXN0cmlidXRlKGNwdV92
YWxpZF9tYXNrLCBjdHgtDQo+ID5uZXdfbWFzayk7DQo+IAkJaWYgKGRlc3RfY3B1ID49IG5yX2Nw
dV9pZHMpIHsNCj4gCQkJcmV0ID0gLUVJTlZBTDsNCj4gCQkJZ290byBvdXQ7DQo+IAkJfQ0KPiAJ
CS4uLi4NCj4gICAgICB9DQo+IA0KPiBEdWUgdG8gdGhlc2UgcmN1IHJlbGF0ZWQga3RocmVhZHMg
YmUgY3JlYXRlZCBiZWZvcmUgYnJpbmd1cCBvdGhlciBDUFVTLCBzbw0KPiB3aGVuIHRoZXkgcnVu
bmluZyBhbmQgc2V0IGhvc2VrZWVwaW5nIGNwdXMgYWZmaW5pdHksIGZvdW5kIHRoYXQgb25seSBD
UFUwIGlzDQo+IG9ubGluZSBhdCB0aGlzIHRpbWUgYW5kIENQVTAgaXMgc2V0IHRvIG5vX2h6X2Z1
bGwgQ1BVLCB0aGUgY3R4LT5uZXdfbWFzayBub3QNCj4gY29udGFpbiBDUFUwIGFuZCB0aGlzIHdp
bGwgY2F1c2UgZGVzdF9jcHUgaW4gdGhlIGFib3ZlIGNvZGUgc25pcHBldCB0byBiZSBhbg0KPiBp
bGxlZ2FsIHZhbHVlIGFuZCByZXR1cm4gZGlyZWN0bHksIHVsdGltYXRlbHksIHRoZXNlIHJjdSBy
ZWxhdGVkIGt0aHJlYWRzIGZhaWxlZCB0bw0KPiBiaW5kIGhvdXNla2VlcGluZyBDUFVTLg0KDQpz
L3NvLy8NCnMvaG9zZWtlZXBpbmcvaG91c2VrZWVwaW5nLw0KLi4uDQoNCj4gVGhpcyBjb21taXQg
dGhlcmVmb3JlIHJlYmluZCB0aGVzZSByY3UgcmVsYXRlZCBrdGhyZWFkcyB0byBob3VzZWtlZXBp
bmcgQ1BVcw0KDQpzL3JlYmluZC9yZWJpbmRzLw0KDQpDb3VsZCB5b3UgdHdlYWsgYWxsIHRoZSBj
b21taXQgbWVzc2FnZXMgdG8gZml4IHRoZSB0eXBvcyBhbmQgdGhlIGdyYW1tYXIgZXJyb3JzPyDw
n5iKDQpPdGhlciB0aGFuIHRoYXQsIA0KDQogICAgVGVzdGVkLWJ5OiBRaXV4dSBaaHVvIDxxaXV4
dS56aHVvQGludGVsLmNvbT4NCg0KPiBhZnRlciB0aGUga2VybmVsIGJvb3Qgc2VxdWVuY2UgZW5k
cywgYXQgdGhpcyBwb2ludCBhbGwgQ1BVcyBhcmUgb25saW5lLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGtlcm5lbC9yY3Uv
dGFza3MuaCAgICAgICB8ICA3ICsrKysrLS0NCj4gIGtlcm5lbC9yY3UvdHJlZS5jICAgICAgICB8
ICA3ICsrKysrKy0NCj4gIGtlcm5lbC9yY3UvdHJlZS5oICAgICAgICB8ICAxIC0NCj4gIGtlcm5l
bC9yY3UvdHJlZV9ub2NiLmggICB8IDEzICsrKysrKysrKysrKy0NCj4gIGtlcm5lbC9yY3UvdHJl
ZV9wbHVnaW4uaCB8ICA5IC0tLS0tLS0tLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRp
b25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3Rh
c2tzLmggYi9rZXJuZWwvcmN1L3Rhc2tzLmggaW5kZXgNCj4gYmFmN2VjMTc4MTU1Li44YjM1MzBj
Y2EyOTEgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdGFza3MuaA0KPiArKysgYi9rZXJuZWwv
cmN1L3Rhc2tzLmgNCj4gQEAgLTU0NCw5ICs1NDQsOCBAQCBzdGF0aWMgdm9pZCByY3VfdGFza3Nf
b25lX2dwKHN0cnVjdCByY3VfdGFza3MgKnJ0cCwgYm9vbA0KPiBtaWRib290KSAgc3RhdGljIGlu
dCBfX25vcmV0dXJuIHJjdV90YXNrc19rdGhyZWFkKHZvaWQgKmFyZykgIHsNCj4gIAlzdHJ1Y3Qg
cmN1X3Rhc2tzICpydHAgPSBhcmc7DQo+ICsJYm9vbCByY3Vfc2V0YWZmaW5pdHlfc2V0dXAgPSBm
YWxzZTsNCj4gDQo+IC0JLyogUnVuIG9uIGhvdXNla2VlcGluZyBDUFVzIGJ5IGRlZmF1bHQuICBT
eXNhZG0gY2FuIG1vdmUgaWYgZGVzaXJlZC4NCj4gKi8NCj4gLQlob3VzZWtlZXBpbmdfYWZmaW5l
KGN1cnJlbnQsIEhLX1RZUEVfUkNVKTsNCj4gIAlXUklURV9PTkNFKHJ0cC0+a3RocmVhZF9wdHIs
IGN1cnJlbnQpOyAvLyBMZXQgR1BzIHN0YXJ0IQ0KPiANCj4gIAkvKg0KPiBAQCAtNTU2LDYgKzU1
NSwxMCBAQCBzdGF0aWMgaW50IF9fbm9yZXR1cm4gcmN1X3Rhc2tzX2t0aHJlYWQodm9pZCAqYXJn
KQ0KPiAgCSAqIFRoaXMgbG9vcCBpcyB0ZXJtaW5hdGVkIGJ5IHRoZSBzeXN0ZW0gZ29pbmcgZG93
bi4gIDstKQ0KPiAgCSAqLw0KPiAgCWZvciAoOzspIHsNCj4gKwkJaWYgKCFyY3Vfc2V0YWZmaW5p
dHlfc2V0dXAgJiYgcmN1X2lua2VybmVsX2Jvb3RfaGFzX2VuZGVkKCkpIHsNCj4gKwkJCXNldF9j
cHVzX2FsbG93ZWRfcHRyKGN1cnJlbnQsDQo+IGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX1RZUEVf
UkNVKSk7DQo+ICsJCQlyY3Vfc2V0YWZmaW5pdHlfc2V0dXAgPSB0cnVlOw0KPiArCQl9DQo+ICAJ
CS8vIFdhaXQgZm9yIG9uZSBncmFjZSBwZXJpb2QgYW5kIGludm9rZSBhbnkgY2FsbGJhY2tzDQo+
ICAJCS8vIHRoYXQgYXJlIHJlYWR5Lg0KPiAgCQlyY3VfdGFza3Nfb25lX2dwKHJ0cCwgZmFsc2Up
Ow0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUuYyBp
bmRleA0KPiBlZTI3YTAzZDc1NzYuLjBhYzQ3YTc3M2UxMyAxMDA2NDQNCj4gLS0tIGEva2VybmVs
L3JjdS90cmVlLmMNCj4gKysrIGIva2VybmVsL3JjdS90cmVlLmMNCj4gQEAgLTE3ODEsOCArMTc4
MSwxMyBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCByY3VfZ3BfY2xlYW51cCh2b2lkKQ0KPiAgICov
DQo+ICBzdGF0aWMgaW50IF9fbm9yZXR1cm4gcmN1X2dwX2t0aHJlYWQodm9pZCAqdW51c2VkKSAg
ew0KPiAtCXJjdV9iaW5kX2dwX2t0aHJlYWQoKTsNCj4gKwlib29sIHJjdV9zZXRhZmZpbml0eV9z
ZXR1cCA9IGZhbHNlOw0KPiArDQo+ICAJZm9yICg7Oykgew0KPiArCQlpZiAoIXJjdV9zZXRhZmZp
bml0eV9zZXR1cCAmJiByY3VfaW5rZXJuZWxfYm9vdF9oYXNfZW5kZWQoKSkgew0KPiArCQkJc2V0
X2NwdXNfYWxsb3dlZF9wdHIoY3VycmVudCwNCj4gaG91c2VrZWVwaW5nX2NwdW1hc2soSEtfVFlQ
RV9SQ1UpKTsNCj4gKwkJCXJjdV9zZXRhZmZpbml0eV9zZXR1cCA9IHRydWU7DQo+ICsJCX0NCj4g
DQo+ICAJCS8qIEhhbmRsZSBncmFjZS1wZXJpb2Qgc3RhcnQuICovDQo+ICAJCWZvciAoOzspIHsN
Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5oIGIva2VybmVsL3JjdS90cmVlLmggaW5k
ZXgNCj4gMTkyNTM2OTE2ZjlhLi4zOTFlM2ZhZTRmZjUgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9y
Y3UvdHJlZS5oDQo+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5oDQo+IEBAIC00OTUsNyArNDk1LDYg
QEAgZG8gew0KPiAJCVwNCj4gICNkZWZpbmUgcmN1X25vY2JfbG9ja19pcnFzYXZlKHJkcCwgZmxh
Z3MpIGxvY2FsX2lycV9zYXZlKGZsYWdzKSAgI2VuZGlmIC8qICNlbHNlDQo+ICNpZmRlZiBDT05G
SUdfUkNVX05PQ0JfQ1BVICovDQo+IA0KPiAtc3RhdGljIHZvaWQgcmN1X2JpbmRfZ3Bfa3RocmVh
ZCh2b2lkKTsNCj4gIHN0YXRpYyBib29sIHJjdV9ub2h6X2Z1bGxfY3B1KHZvaWQpOw0KPiANCj4g
IC8qIEZvcndhcmQgZGVjbGFyYXRpb25zIGZvciB0cmVlX3N0YWxsLmggKi8gZGlmZiAtLWdpdCBh
L2tlcm5lbC9yY3UvdHJlZV9ub2NiLmgNCj4gYi9rZXJuZWwvcmN1L3RyZWVfbm9jYi5oIGluZGV4
IGYyMjgwNjE2ZjlkNS4uMjU0ZDBmNjMxZDU3IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvcmN1L3Ry
ZWVfbm9jYi5oDQo+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZV9ub2NiLmgNCj4gQEAgLTg5NCw4ICs4
OTQsMTQgQEAgc3RhdGljIHZvaWQgbm9jYl9ncF93YWl0KHN0cnVjdCByY3VfZGF0YSAqbXlfcmRw
KQ0KPiBzdGF0aWMgaW50IHJjdV9ub2NiX2dwX2t0aHJlYWQodm9pZCAqYXJnKSAgew0KPiAgCXN0
cnVjdCByY3VfZGF0YSAqcmRwID0gYXJnOw0KPiArCWJvb2wgcmN1X3NldGFmZmluaXR5X3NldHVw
ID0gZmFsc2U7DQo+IA0KPiAgCWZvciAoOzspIHsNCj4gKwkJaWYgKCFyY3Vfc2V0YWZmaW5pdHlf
c2V0dXAgJiYgcmN1X2lua2VybmVsX2Jvb3RfaGFzX2VuZGVkKCkpIHsNCj4gKwkJCXNldF9jcHVz
X2FsbG93ZWRfcHRyKGN1cnJlbnQsDQo+IGhvdXNla2VlcGluZ19jcHVtYXNrKEhLX1RZUEVfUkNV
KSk7DQo+ICsJCQlyY3Vfc2V0YWZmaW5pdHlfc2V0dXAgPSB0cnVlOw0KPiArCQl9DQo+ICsNCj4g
IAkJV1JJVEVfT05DRShyZHAtPm5vY2JfZ3BfbG9vcHMsIHJkcC0+bm9jYl9ncF9sb29wcyArIDEp
Ow0KPiAgCQlub2NiX2dwX3dhaXQocmRwKTsNCj4gIAkJY29uZF9yZXNjaGVkX3Rhc2tzX3JjdV9x
cygpOw0KPiBAQCAtMTAwMiwxMCArMTAwOCwxNSBAQCBzdGF0aWMgdm9pZCBub2NiX2NiX3dhaXQo
c3RydWN0IHJjdV9kYXRhICpyZHApDQo+IHN0YXRpYyBpbnQgcmN1X25vY2JfY2Jfa3RocmVhZCh2
b2lkICphcmcpICB7DQo+ICAJc3RydWN0IHJjdV9kYXRhICpyZHAgPSBhcmc7DQo+IC0NCj4gKwli
b29sIHJjdV9zZXRhZmZpbml0eV9zZXR1cCA9IGZhbHNlOw0KPiAgCS8vIEVhY2ggcGFzcyB0aHJv
dWdoIHRoaXMgbG9vcCBkb2VzIG9uZSBjYWxsYmFjayBiYXRjaCwgYW5kLA0KPiAgCS8vIGlmIHRo
ZXJlIGFyZSBubyBtb3JlIHJlYWR5IGNhbGxiYWNrcywgd2FpdHMgZm9yIHRoZW0uDQo+ICAJZm9y
ICg7Oykgew0KPiArCQlpZiAoIXJjdV9zZXRhZmZpbml0eV9zZXR1cCAmJiByY3VfaW5rZXJuZWxf
Ym9vdF9oYXNfZW5kZWQoKSkgew0KPiArCQkJc2V0X2NwdXNfYWxsb3dlZF9wdHIoY3VycmVudCwN
Cj4gaG91c2VrZWVwaW5nX2NwdW1hc2soSEtfVFlQRV9SQ1UpKTsNCj4gKwkJCXJjdV9zZXRhZmZp
bml0eV9zZXR1cCA9IHRydWU7DQo+ICsJCX0NCj4gKw0KPiAgCQlub2NiX2NiX3dhaXQocmRwKTsN
Cj4gIAkJY29uZF9yZXNjaGVkX3Rhc2tzX3JjdV9xcygpOw0KPiAgCX0NCj4gZGlmZiAtLWdpdCBh
L2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaCBiL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaCBpbmRl
eA0KPiA3YjBmZTc0MWEwODguLmZkZGU3MWViYjgzZSAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3Jj
dS90cmVlX3BsdWdpbi5oDQo+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaA0KPiBAQCAt
MTI5NCwxMiArMTI5NCwzIEBAIHN0YXRpYyBib29sIHJjdV9ub2h6X2Z1bGxfY3B1KHZvaWQpDQo+
ICAJcmV0dXJuIGZhbHNlOw0KPiAgfQ0KPiANCj4gLS8qDQo+IC0gKiBCaW5kIHRoZSBSQ1UgZ3Jh
Y2UtcGVyaW9kIGt0aHJlYWRzIHRvIHRoZSBob3VzZWtlZXBpbmcgQ1BVLg0KPiAtICovDQo+IC1z
dGF0aWMgdm9pZCByY3VfYmluZF9ncF9rdGhyZWFkKHZvaWQpDQo+IC17DQo+IC0JaWYgKCF0aWNr
X25vaHpfZnVsbF9lbmFibGVkKCkpDQo+IC0JCXJldHVybjsNCj4gLQlob3VzZWtlZXBpbmdfYWZm
aW5lKGN1cnJlbnQsIEhLX1RZUEVfUkNVKTsNCj4gLX0NCj4gLS0NCj4gMi4yNS4xDQoNCg==
