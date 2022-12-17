Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24EA64F6F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLQCIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLQCIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:08:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC562791C;
        Fri, 16 Dec 2022 18:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671242915; x=1702778915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MsoYU59qWLrLWiE8IonA/E0pu/iegfrU8zlJE+O43gc=;
  b=CKIItV8hzXE9doqclf2JSJE/WCMkrzsbkGtGuUiG56EjDFb1vsJx+Ww7
   DU+Kel/8Cu9WR/oBVeAO8hf0/crEgdP0xKJ9x9jNRnVBdb95+nUf1KsqS
   pUQebHHlnL8fiP+FBzBB5vEwJvNN9f7alymH7kAmKf0h+59Y/5GWcFs7W
   GXY2miZ6oW8cRzj3MdeZUZAEnPERAus5U1rkMQOwcFd2rHVombbTLNExw
   jAodyqG7zPARc1f5queSN/dnwGHC0f6+Yf1VLXGKVwPvX/4wLFd+8YJuM
   6QKgzGTugzqIJrX72XWbFmXtoy8+8gIiBUVZOeytVeT4HZ2+YRrDs3zuR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="317785761"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="317785761"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 18:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="627749405"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="627749405"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2022 18:08:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 18:08:31 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 18:08:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 18:08:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 18:08:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa1z2AmdTIpMkx83qDx/RJZxi8H3iCw7LLoQy8D1/+SdLVEnjWekTfJtE/z8zXWx/g1tWeNDe0OA1p5435+Iv5c6z5XNcnkBhr8JcoICHVBYsfzGY+SBm69gbMaG35Xf4NUObjc2/Aq/MZAuyLVvZPDfM/52mDmAJZz18iR5sMGHvZRUU9YqNQ9Tm2p5VYEjbt/xP4YJlQsW2/IxfGeaj4CCsoYwhcgDBq2h4YrqHWh3lxKk24KFzKneizcHKjQB/f2k1g07npAeoh8Zd31enVM7CKQffruAqE8vPltKt69+AFmhoPvKWtZ8VtA/JcsSHwRqmzt2EoghxrEH/AY2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmeY3SHdorjjMUOHR1dfs86nLcBXK9XBhfQ7Um2n/Oc=;
 b=dWDwWb50nvP3vefTR/Yps/cpsEp1ORxpmpEW2XK5oifISPf7t0Q5fWkrmjxdhJVPm5pgY/xBB4BjgrGmCn0/7SRB2cgL2qu/q+NSEvM458v5XX60tDoPqnbiAzpnYvLroDuCbwnzsSkvWPQ3qaTmesHa/N7VzB6zRz1OHi2hXoTvLMRjSzKnoYu4EWdQKmFXVMtjb30aRMVJJgQZ083netRnCL+JiuirHY1BKXPCzxyiQU0M043sE0MyeGkGffTOzrT2lppCFehQMeBhlNA2Iv+9mFkedXQKZHWMd8Dp+DfzN5XkkblKNBCL+x6UqBJpr3P0Dc6z/mHQ/kc/5LrcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 17 Dec
 2022 02:08:27 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 02:08:27 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Thread-Topic: [PATCH] rcu: Fix opposite might_sleep() check in
 rcu_blocking_is_gp()
Thread-Index: AQHZEDjb4JuHblX+NUKrHh1V8qzf2q5xRmGAgAAGjvA=
Date:   Sat, 17 Dec 2022 02:08:27 +0000
Message-ID: <PH0PR11MB5880526CB255AFF91F0D76A2DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221215035755.2820163-1-qiang1.zhang@intel.com>
 <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221217010345.GF4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL3PR11MB6313:EE_
x-ms-office365-filtering-correlation-id: 468430eb-866c-4cf1-1585-08dadfd3961a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEkGBLzSzbHdPgvFZnUu+h3/qxWzWsyaWTmWyap7X93u71+UtrK76XuyZQYfwE2wzpWOXBYp4YMJnTWWxz9vXrlj7Xj1/SNg4gJ3DteIV3LF1UQJn+l4cdaVZMt0CSQ+b6YCzqBeXlxLOQyzJag0ZCAg9pBmuFBpBCwjU+IBI2p6shVq9KL48/ls2PL4e3o5QZWbaKN7oPzbfvzmdN7VvHnvXzwvrpuUEPIZmQOzmHMqvqeASpqw/EC0NHcNkktVtXX2EFgZZYapi2zw5JD4bvQcNWVyoR9fCtwYguv4NC+7wIv/ozAM/RZGqpDHVAY1tx0rwqeKPBGpdy7HLuuKQBdNRJ01GZQt6yd/mPh2brwtmJJDQmmJqlJNYXKu1YSx9PcS9/tGWPhNlLoQXzOx4y7Pj03NsEd6tmKFcQI9xFvS/vHVlLkI1jkL8tLjCsJUw/wV1jJtHGTCloMsMyKvcYEFbvTMN2/ba1nd+e4GPBuTpDYX1XmemslyzCcdcAjB7cgb0UXNuHiPQOqlqH7kUdDR1+TAX0MoLP2tmc1Sx7vdo0pQdbUOQBivaZnRqzgTD7YNUy4L86aTvlJ27rIRgrICUNAaqADrQuBuHgjynSOrPMMr5B4m6AfedI5HbbO/rhFSBBISdBUd4a6N9mSS3ZFGaHnU0d500E0Qlia0/ScjoFsnhEGin/l5fTypr0pj4NTV5WyyqPEw1SieVpLdrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(26005)(6506007)(2906002)(82960400001)(7696005)(86362001)(122000001)(52536014)(33656002)(4326008)(66556008)(5660300002)(83380400001)(54906003)(66446008)(76116006)(6916009)(8676002)(41300700001)(64756008)(316002)(66476007)(38070700005)(66946007)(38100700002)(8936002)(55016003)(9686003)(186003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HIsFeXsRSUSzSFb3VpjbQEg+j4wWpasHvfRLd20sDu0I8FCfmReDKx7UHNi1?=
 =?us-ascii?Q?eQkD5khJPvImMb5bllUR22j4jEzvn2RSDRb/xNV89x/fcT3jaHZDZvtcwVB4?=
 =?us-ascii?Q?+d8wheE/tC+purVsMGeYp43NmanXS02zUtwvbOjtjjRV2BLGbrHj4QeMNgTL?=
 =?us-ascii?Q?M/WqfvA84xxkoWz802KbG8KJqNSRgx62SOssfUpTgXEb1oXdwTIJ0y20UZ5v?=
 =?us-ascii?Q?4S5K/BVsj4Pc2CwUcKeoxjkf4GU4iH/LWOCsHXIStBTCDBGxqkIblNHsHAne?=
 =?us-ascii?Q?hb3OrNtvo2PXwwQhxAakRVAV3cS42QciZi5Tz0mjexbYbKPusED/Izt83mjJ?=
 =?us-ascii?Q?aRA15WP+uLH4gxjIuWCcVVKqTDFSuV6tas8/mje5lGHAETV6ppYSEhl98X92?=
 =?us-ascii?Q?SzXiKZukd4EOXyobhBh3ecSj+lLfyZTwVMgssY86YLeJYB1XYRt6+FuVpYV+?=
 =?us-ascii?Q?I+iacH1I5eTpSiRI+4IBLvKaqXbijG6vt9vMVrDxKwXyT4LdRccL8tKcQWiF?=
 =?us-ascii?Q?BGRC7vWo/uc1GOdFCUlDDbr1zq8bcgsEhzmGOB0mpvJLrKjue9YCly5ZE/T1?=
 =?us-ascii?Q?wI/B5JoYMAKr+aZG8eOD/lIoYhBL8goFN45mFlaQr1FR0odaxSqhSOe54TL5?=
 =?us-ascii?Q?IyFi0NaW23tJTXC39BT9TxLghHiVg4pUK96bJzpAEMDxNG6x3tibve7Lc5yD?=
 =?us-ascii?Q?hEd8piKBkAsYjfJR4GS2gOyxpFD2OFHEnvzRryAn+T13ddDRxlUbYkvqgEQu?=
 =?us-ascii?Q?X231LZiQLHLYKhqT7Z9+qlPDRBXF6mxe8WyDaVP1RjEFM5ZGV5E2BoaT9gWB?=
 =?us-ascii?Q?zWXkKXc5id0hM2PLSJjZELlhODLTvWvAz80wTZDDYpjuQTnyx3Nl5+9KIVZU?=
 =?us-ascii?Q?dmxu105rrfZhfs+MCPo7Ll1BWzh9W0Puc1d4xVI1z3jIGBf7uhkpEULlVotC?=
 =?us-ascii?Q?eHZ+vmK9pDyQvG/UemZx0mwOblA6cDI5w1V3yNJv1WC7OVJn3ekCA92kRCOr?=
 =?us-ascii?Q?Lfj6i+Snzp7GftLfDmJcTAlB0DFXiwO6g1ZC5FYkXuB9VtIu96CkaRMapd3/?=
 =?us-ascii?Q?Uz+GYvLopkgUyPpZyK9jo9aYyLKtVsx7TRlzULa5FOaJu//4E63/s5X7IYgq?=
 =?us-ascii?Q?In/gCrMhRjL9/LrfMDSnnnFBoCPEFfCHzUti7m5I4QGNcmrlIh+mSuEfo4go?=
 =?us-ascii?Q?hbIRxQ+KLbSzhLu/QJYuyBRY8PM1ZovGQuzruexSzV5i+xegn5nYXScDvBVi?=
 =?us-ascii?Q?126V2bgfbyt4SQRF4hDVrQFkiYlwisWyGo5wfqJCRC9B/gZYZjtdOfr1biwW?=
 =?us-ascii?Q?DA/w4XSPM09SJMbWA4Y+Q92uFhw6vgJjuxE1cBUBdoACVFbwEXU6s9NkRiXV?=
 =?us-ascii?Q?3hr6eHE/H41fQ5VneuXCEO5JlY5Ys9ftwKXTayg90mCdFFxHJkeM+AXhF8hr?=
 =?us-ascii?Q?58m3n7C/D9CDl0TU7Z40VMBdt/MZ5LYOMT9TxSNLPiidyON/zricteLFZiT6?=
 =?us-ascii?Q?o2IvknAL1eVLVcBgbVwpll+COBp11H3etVW4SVnizroNyGq3exw7A9SaLU5P?=
 =?us-ascii?Q?nWLvkLp1CPsMmamcF/UUj/3Mek/g7rLqoRa6u0jQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468430eb-866c-4cf1-1585-08dadfd3961a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 02:08:27.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEURDLKke2O904lSSLLPgowN9BxY1cyY7tya4unFcAMa+YhvecIZ5dJ/0v5/eXWE4B8tr7+sWY4NHDuB8QjzVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 11:57:55AM +0800, Zqiang wrote:
> Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
> synchronize_rcu_*() will implies a grace period and return directly,
> so there is no sleep action due to waiting for a grace period to end,
> but this might_sleep() check is the opposite. therefore, this commit
> puts might_sleep() check in the correct palce.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Queued for testing and review, thank you!
>
>I was under the impression that might_sleep() did some lockdep-based
>checking, but I am unable to find it.  If there really is such checking,
>that would be a potential argument for leaving this code as it is.
>

__might_sleep
   __might_resched(file, line, 0)
      rcu_sleep_check()

Does it refer to this rcu_sleep_check() ?

If so, when in the RCU_SCHEDULER_INACTIVE state,  the debug_lockdep_rcu_ena=
bled() is always
return false, so the RCU_LOCKDEP_WARN() also does not produce an actual war=
ning.

Thanks
Zqiang


>But in the meantime, full speed ahead!  ;-)
>
>						Thanx, Paul
>
> ---
>  kernel/rcu/tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ee8a6a711719..65f3dd2fd3ae 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3379,9 +3379,10 @@ void __init kfree_rcu_scheduler_running(void)
>   */
>  static int rcu_blocking_is_gp(void)
>  {
> -	if (rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE)
> +	if (rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE) {
> +		might_sleep();
>  		return false;
> -	might_sleep();  /* Check for RCU read-side critical section. */
> +	}
>  	return true;
>  }
> =20
> --=20
> 2.25.1
>=20
