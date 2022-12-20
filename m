Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45954651F27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiLTKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiLTKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:44:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43618178BC;
        Tue, 20 Dec 2022 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671533050; x=1703069050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pYWu9IQAQd9FCG7kppU3+lTqRZPpJjg5wnZGRUd/5Jk=;
  b=V4SEAFrO5BiY60g+iTByMmKONpJfVwwWsh+foh7r/lmpUugDiOC4Z8kE
   5xPASXGbAQSduGzBZ2Dhwjitvhfnfm96ekQJrXqRkKO3gJFM4VV1XtRfj
   6/ZTwu5kff1Hvyak3nLNKtUm0C0vWJ6zRncKm8oegN8W7VTfpgJwbXPOb
   QmW0Tl+80aLLVHUsFmecwmgzF8ZQ0TFsvAePEg74EBQAq3KEdSIm6RrCX
   DvHauLPcRdMPfJ/T2jyPdrAlNjFtzDaRYUP9iBLg3WYTbgi/Ib1fSVwNO
   SmetrXh1NXITtMpaY3DjW2hQ3nsVqOJxn9JRKOPJV58SfWyO4b0LNujtb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="317220301"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="317220301"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 02:44:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="739703560"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="739703560"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2022 02:44:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 02:44:09 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 02:44:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 02:44:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 02:44:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjBhtka24k9fXBgUhcudoP+/mQdT9Wpcdxoh5nUIhP0Awo7OfpgyzGcxQOD6Oy4Mf1fsvPnxn2xZtt8u56BqQfpdhRkxBBNMAHpR3Sg6ZwqCemZvFDBQlqmErZY3Z3/jtrcz+OoSTleMG9Sdo9xl9w/YhO2lBS4myEZU3ajXgsPQlYq67JSQO9RsN2ybrhA4FXyHpES7fmq7Wz0sjU0m+XRkjOj2DePMqt1rS+xQU7oqeQsnYNTEieSNF9e+cczMz9qb4ZFFnLvdEaaX36NpbI1dUfxAnHWsSks5KJQtCRMV9ZQWRxtPdDbtVEdWVu1k9duJ0cKKJhIqOyz7sWPyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UekyEtwAaw2T+U5o6Tc9qpvyYM3KzlMWkBDZuCve/ZY=;
 b=fFRJZzGlDo6nfOGrxdra5yWD6fHnCVbZuSvDVLCg53OSsVFhwFdCf5zgiSGdUpRL0cc7vWnMjM+ix00v4v3lgT4GVEX4JuaHNTJzFMk7mbdTjI5jS4B/iAVkgdV8pdHQ+5p8TfhmZy1TmF4owC0qZEgcSfJK95yFlG43A9j1mvHw3DsFBfF/LSIBRWxJt20RWGmS/MlCscj8dfuQufSKJZyER76YHRHukdPrVwNY/5Sry9wFI8ZptiuUNSfffEtsgwp1frD1daal1BRiFIjV8kwCBEXw9PdcKxHDh3oTAfKfneZlREO48RYYtmfEa/lMcEwHolUJeaFURojORg2V6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Tue, 20 Dec 2022 10:44:07 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3ca9:a067:1c92:7a31]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3ca9:a067:1c92:7a31%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 10:44:07 +0000
From:   "Chang, Junxiao" <junxiao.chang@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>
Subject: RE: [PATCH] softirq: wake up ktimer thread in softirq context
Thread-Topic: [PATCH] softirq: wake up ktimer thread in softirq context
Thread-Index: AQHZCtu9FgSt2BLnhEqT/Df9j5aCWK52jjbA
Date:   Tue, 20 Dec 2022 10:44:07 +0000
Message-ID: <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20221208075604.811710-1-junxiao.chang@intel.com>
In-Reply-To: <20221208075604.811710-1-junxiao.chang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|DS0PR11MB6399:EE_
x-ms-office365-filtering-correlation-id: 721eb6fd-57e8-46fc-0602-08dae2771eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ojiL+RT0N4XzU8wCaRIpKBQsmZUPqqzzwxzysevS0vUnvwOhfY3BUzizorYAEWTgQPQ0+HfdTLZ3kva5qabfM01luHetqV1VVPWjtBCQ4ozr54qK8SLJs4R6KJA7KF4BlvniwpqJMQT+5ay82BQvfgcKPEIgkX4AeTXYnNWQ7rIbgbeEN3u3xNF38Wq3k9aRWAa6iFb7qGWez/3VNdh+D88ARqbQ9xG8q01e9Tfj1Y0kkFNxHkD1I2laEH1VdTP+XrESDMt5D8fwkXXMFi7xZ2hKrN1LYQsLyOLcfPXbbv6F8jJ3cPVe9Mzv1d3sX84j1R+QDTuNW3YxsYQpYgxASJE/FlPdDD2wuBPaia91ukdaTbvD/StLHqZoP6Cdnbsc0ji7Et3pjfcNvR/reNKr5SzYZlfKKxn2W/jkOWwk7xzryreuutVFTHRVc0nMqy3Jl4K2IoWvZ0lEMEGlv7mBqin7tKjYa8BpI42jUO5rmSr5Kx0lV6Ak/AvThkXUkVh2lF9txxZHPPL7iOiSFfYCpspVkLWyUWWIOyIgOiju3SRa2htLYXBbwk7YKd4JmXwk6bKr0/5UBDdR5JF8lkTwnPvQRBilwyTDZ+oQ+NeUw+P67f1QjbaAgpRqWwJCYd5olrU/CHJ13ViZhJ1R1Z19l20YEO1ThUSTuOAr02vVEme5XZ8o7d6UTq8OFLHYYZs3UZ4BHQXfuL3wc1KBnoHTew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(66899015)(2906002)(41300700001)(86362001)(8936002)(76116006)(52536014)(5660300002)(66446008)(64756008)(33656002)(66946007)(66476007)(8676002)(4326008)(66556008)(316002)(6916009)(54906003)(38070700005)(71200400001)(38100700002)(478600001)(122000001)(9686003)(26005)(7696005)(55016003)(53546011)(6506007)(83380400001)(186003)(107886003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PN/GBqKUgUqmCdqOd8jG9dHByHXF0NuIPWUjG2bpcI/jY6aTxporCJF5zyzv?=
 =?us-ascii?Q?bt3FbaHQyquFTVOq+0aBFl7Eq8bAFUACYqCzYzbuO+WzpTciBkBmvmOGz1vs?=
 =?us-ascii?Q?VJey24FFrRQGl4bVoq3HHuJJbnxWMIy8CpY0ji7I36ubOzdE8cBZinKS27Iv?=
 =?us-ascii?Q?3yV+y8pFP2rVv+SoOgxOD0ryi2gQkplnrmHDTv+6i6EdlZDdA+NBCdhIxw/2?=
 =?us-ascii?Q?SY/iN/vE9Y+KZ4J3uo5I3u7g2R3e62on3hDBSNoLcEWLKU6v2DL0b+JqzeB7?=
 =?us-ascii?Q?ENK4r6Qe3VdK4pshGVZGWX6WMfobJV8+rySiOwPDz4gvEvjby/oV/sNq1NM+?=
 =?us-ascii?Q?TpCpXvs48Cdyuc6Ud+ceApjUm707Vpb6fP0/kMny9jAHCkzBFyGNmCklEt53?=
 =?us-ascii?Q?Jqu1AIUK1F9GX9BnvEFeOhvM3mjyZdWmrrpEnhdmn1bVAqUEZ8mK2bjO+C1w?=
 =?us-ascii?Q?l2HUHlH3MDaDUISyljjThD0JfLZT50A6GYe/Ua0zFaHf6xvLn8bFwiAo+BKF?=
 =?us-ascii?Q?kTACWwOlsgmf2emWyA2npp8uNTOkUITbVrQbb4QwUBhxO/byAaVp8tZoj9/W?=
 =?us-ascii?Q?lU0+KTdx/PdVQAHZDrQ0dCct+HsG8SXUDGZgOlmnOSst7uxwMIxRQXU+Lq7I?=
 =?us-ascii?Q?/VFesbKeqaZuWAHOnace2sPfSsq4nMAV441xJ/zxaWGUxqmLcwwRJaKND4bI?=
 =?us-ascii?Q?huPRWIkGny7KH22GsKdvpt7XDNqPlK2O/hvx8JC+qrUnUsRBabnqAIFiZ6/P?=
 =?us-ascii?Q?aIarhvG23ajZhbPVB3PO5VCSzs9m8UPaELV9ZAq09fhlLDENTvE747EF65JD?=
 =?us-ascii?Q?9Bo0LZqJ5o7AkJ2i0VArwSB4c7X4TXMs+nY/fylIRs5cIwgsr2PjgHZaF5E2?=
 =?us-ascii?Q?jhQOg8QxEJnIExVTyx8chaN3Ke/K43K2hm6GmPfaaXKVbDmQxDBipgR0MWk0?=
 =?us-ascii?Q?/zZEsN+ITGQFi1SUwulUYDsjZK2IKgxqXybS9ZnnfoRWkmodRT7fVSIsDfXW?=
 =?us-ascii?Q?QVqzwnYC3QoKYnFbI2ejyVKKmiFmGhASEntM24sKGnJ6pEjn3y7LseXOjjev?=
 =?us-ascii?Q?UDD1L34kGVOt5cvUUafRrBiQ99w97VdLe5z+CT4mxUEet+jf5alJ/C94hOce?=
 =?us-ascii?Q?JhtuojwB5u05hlUNfmrRubPWQAaE2aPP4pTyIV7pq1lq4B2cunIJ8EqPVv9+?=
 =?us-ascii?Q?AiC6hLfUsFOQBR+WzWAEnVK7z0uHmEA3gr1PoQmzvPgSbm34/qIUXXSmCz6t?=
 =?us-ascii?Q?889YaUkKHOu24/agrtucBulHGGwWdb2dfTyyN/qoWGIMxjgPI6P6JKqY1K6U?=
 =?us-ascii?Q?eM58AJE2VMQJj4DfMjk1OHuc1iYwRaVGnuYN8LqkLWQjealRC9IzrtNU4S8u?=
 =?us-ascii?Q?++gNe1v7DomoNmqncRBuO5PSOlWDmMg3iSOLlPlWTdQ/33GsIF2MMfVd1kKw?=
 =?us-ascii?Q?LGK5xK/UqjZr6LNMfyHNCUUgrtgQdD2urgPI0ovZxsl2jIlMmgY8QuevYjsP?=
 =?us-ascii?Q?yTRIcr2I0BxdcymM1z76+DVKxq6nTiCFSGF2waflkqWYhjAF25kWgSAwUC0P?=
 =?us-ascii?Q?0ub+XQFu/oEE120PBDwt7QAPf/Sfx4zAJcMv9J3I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721eb6fd-57e8-46fc-0602-08dae2771eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 10:44:07.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+Rr8xoJB8rx21bN/LhYzGZ3dkKdJNAzKxUOgxaqq2YCoUVkL/EYs0c0ElCI7IrwfNbZvB2qw60rKNotr1VaHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.19-=
rt kernel as well.

This issue is easier to reproduced when there is heavy network workload whi=
ch introduces a lot of softirq events. If hrtimer interrupt is triggered in=
 softirq context, with current RT kernel, it will not wake up ktimers threa=
d which handles hrtimer event because in function __irq_exit_rcu, "in_inter=
rupt()" is true:

static inline void __irq_exit_rcu(void)
{
...
        preempt_count_sub(HARDIRQ_OFFSET);
        if (!in_interrupt()) {
                if (local_softirq_pending())
                        invoke_softirq();

                if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers()=
)
                        wake_timersd();
        }
...
}

Then ktimers threads stays in sleep state, hrtimer function will not be cal=
led although hrtimer interrupt has been triggered. Ktimers thread might be =
woken up in next timer interrupt which introduces long delay.

Any comments are welcome.

Regards,
Junxiao

-----Original Message-----
From: Chang, Junxiao <junxiao.chang@intel.com>=20
Sent: Thursday, December 8, 2022 3:56 PM
To: linux-kernel@vger.kernel.org
Cc: linux-rt-users@vger.kernel.org; bigeasy@linutronix.de; tglx@linutronix.=
de; rostedt@goodmis.org; Chang, Junxiao <junxiao.chang@intel.com>; Peh, Hoc=
k Zhang <hock.zhang.peh@intel.com>
Subject: [PATCH] softirq: wake up ktimer thread in softirq context

Occiaionally timer interrupt might be triggered in softirq context, ktimer =
thread should be woken up with RT kernel, or else ktimer thread might stay =
in sleep state although timer interrupt has been triggered.

This change fixes a latency issue that timer handler is delayed for more th=
an 4ms in network related test.

Fixes: 2165d27554e8 ("softirq: Use a dedicated thread for timer wakeups.")
Reported-by: Peh, Hock Zhang <hock.zhang.peh@intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 kernel/softirq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c index ab1fe34326bab..34ae3=
9e4a3d10 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -664,13 +664,10 @@ static inline void __irq_exit_rcu(void)  #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt()) {
-		if (local_softirq_pending())
-			invoke_softirq();
-
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers())
-			wake_timersd();
-	}
+	if (!in_interrupt() && local_softirq_pending())
+		invoke_softirq();
+	if (!(in_nmi() || in_hardirq()) && local_pending_timers())
+		wake_timersd();
=20
 	tick_irq_exit();
 }
--
2.25.1

