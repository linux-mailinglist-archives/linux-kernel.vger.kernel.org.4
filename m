Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31207701D9C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjENNic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjENNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:38:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D538C10D0;
        Sun, 14 May 2023 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684071509; x=1715607509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YeNoulTxOizLNkI6H17Hf3lOaQ3/14NXGaJeqYvED+0=;
  b=DtD0tmkAPLfiXMQFZTyWXMNoAD/FJjAqIitibqi+0dLHn3On0zNFRoqp
   5aXkeqL0v1pYLslc/j4/iV5DmvQxpKgOvz7f+sCfkzT1Z2SJ0FWzIG+Pl
   gu+Oo0lcnW9IBBMr2lbEfCBH498kp8Rk111/2Gg9moLaulCcVP1r4CPFc
   Z4LbG81FLWTEzf5NyTfi+6NRAi4lyl7pbDizq046JBd53ZsEJeWGvltRq
   2huYUcICElsO5SfL7LpZGEDSOLSQ89gPyaHq7dPAvePpdTPxwnrROkzb/
   4oNfKm7Or7rPEyvkxz5PfwqIIuWz8LGrnunWspnD/bMPBp9gYli5mFsAo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="348536278"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="348536278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 06:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="1030614696"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="1030614696"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2023 06:38:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 06:38:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 06:38:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 14 May 2023 06:38:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 14 May 2023 06:38:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9WsjUrYcdpPhyyIyXIO/m8YqAIRjIVsdU+VrFfSAJErwt7Zk9DzC7sggTEMJQPZHAmqKpJ5/SQg2QnB8s8AjA9aUx+wrhMuE21jfYrYeJugcbFmHdEpv+AIO4YyP7sBYYm1tkSQ1G7bOGUJaQfTX1RPmQZAcQSE7qBA1XhJwU8/Z69VEMY1SVED0dKBCqr+mRXQeZJuiSH7gWUWCs9UsqeN8rnnO6ZifoCHDT+WxTxEOS/uo41cRIY/fCfgBf3oKGu17DjB5qQoFDCcujkC9pvA3Fy0kmHzDGxCwqCaVpkFn2taZI+EXKxFvQkjBGEeMmfXg/mh71YLhFSGG4vE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2amuyAoI13+mRXka8ce26LoN5JZCN3mGFjvwf/lJO4=;
 b=bXYQ0tcvtQ1B17UqYCG549Hygev9foQqp9mYGSn+i815bNKS84PZrb1BFZsWlDaOZ8Cdoizjcz/mMZd2Zyzstq4ypMdpxoEmxkQNY4/IAIF2JuUP/QvOzivhMadNoY/GNvst1IKv39DCTwsnj3QB1QecZyPAkOSmDfW4y+GFdXDi76i3Zzy3drREglbJZGZxU1p6PgS+2NYh3wfaNNmYgM3W/w/BtFAtQkcwuwMT/Rn+LP6/HUdWHYqGldbVvQb0OsZ32w1fSMqvN92KJEcup9/6R3ivwr7vyFjEPXuPr5tlXhnjsOkCUGIAkHtV5rzTs3HBh5mVoIt1XtedlvU0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH7PR11MB6883.namprd11.prod.outlook.com (2603:10b6:510:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 13:38:26 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%2]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 13:38:25 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Thread-Topic: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Thread-Index: AQHZg2KlduYd6z/enEeC6gWcmPig2q9Uip+AgAATm4CAAHvjAIAA2thggAAU/ICAANAYgIAA/3nAgAB4ZICAAXiaIA==
Date:   Sun, 14 May 2023 13:38:25 +0000
Message-ID: <IA1PR11MB617117F9C7A2077CF71877D3897B9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <IA1PR11MB6171B1AD7716B95B0B2C683889759@IA1PR11MB6171.namprd11.prod.outlook.com>
 <30F06C03-6950-4E2B-B3CE-3939B3CDD295@joelfernandes.org>
 <4d508096-300c-4d16-9c39-18598d00b500@paulmck-laptop>
 <IA1PR11MB6171866D6AEE79DD3413157E897A9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <527de9fa-1ec6-4ba7-8bce-b0447e751c07@paulmck-laptop>
In-Reply-To: <527de9fa-1ec6-4ba7-8bce-b0447e751c07@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH7PR11MB6883:EE_
x-ms-office365-filtering-correlation-id: 5d310819-0ed0-4ab3-fc8b-08db54807e86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzAJTgzQ1Dzz9lN7IXvtpJPcCQeX9s6ffWUCH4fR+Xv5IHXzc2hQzJYJaGcr6wsl6km71RFs/CV0Gp+X7z+R50OSIWn3Bm/VdMbyYOzI4hNZCsWgoh1ddlVeWR+awdBwSX0umSYf2Ga8+sl0knNS5kyZNrK2DsNF8Bj7cCl1vHN61MqWhCEOfPH8YZ9R/z6MyBH5vwRLqRzlEcphtIm9ZbtpCKHDVU82d2bsTISwEXOb06g9r5coaBp3aOw6KCEyy6syX7dgaDZmnSEpwVBDVnq4xkf7IzFIe9xCVWkdNk3A6ZXDlcGF1XqONjE9yDQTm8yBHiGP6tIpy997C0VabE/lrTmCDMMo+FaFs3tWswhUp9o+2Rplw/XLVVwabVcN2mly0dZQSdCdxF085hBqwmIxtjAsnX6kzFK/V2mcRoIhEJ2Vl+h0bJ+NT4JtNp8jxhS+5vQhxjMFrMmwXp4DF3NwfJW+/T37ZQd5QZo2hqBaEBQECs19+rR4rkD7Kn4nBbj83ZE/5/wMw5I5NiicN0dHy8cZDBb3rwTh6om5Hlt9Wcd9ymmvkNe+0/5jhRhHtJZ0oYQIGQYjfGRifpPQ1Wh74B1Utaj/ihl6T2jUKDJWinAe4o9lO1/8XtPpXkfG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(54906003)(478600001)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(66946007)(76116006)(71200400001)(7696005)(316002)(2906002)(55016003)(8936002)(8676002)(41300700001)(5660300002)(26005)(52536014)(122000001)(82960400001)(33656002)(86362001)(38100700002)(38070700005)(83380400001)(186003)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?99NTkssydY0ZMmqsEdCc6bTS6RSWBPfYWcwnbCKA4OykS13LbwefSd+BSL0n?=
 =?us-ascii?Q?lFOb4kYfkD8xrSNgpOPQ2EfT2TJECw5SMjp21BGLAHm6TYJnJJ2eegU7OiyT?=
 =?us-ascii?Q?Cg41/X0VtpZw2GfhUuaiexLD+6JdGt+u54j9bVPFSALzLcY5jJZsU1dVgkSo?=
 =?us-ascii?Q?KUglp4GlTI1RX1XsxWRRqcl9RBGw2hEb7INz/Fqn2d8+6jqA34IzlzGCvZ0q?=
 =?us-ascii?Q?ILcgophwBdnhPCFTEQLWsEBESpbQyuA+6yptt46xJxTOZB4MDDry1EP8Rx4p?=
 =?us-ascii?Q?7TRNFGhS6b9DW6dMr4Eb9ZUxcAFmTONc1YFid2pxHNWpsUJtasW21S+TsC7z?=
 =?us-ascii?Q?oOyhKTDgZR7E4ttyk2UUqcb69HmGmDdQcUkJTaczvAY5UyzgsN0IVdxNqfsd?=
 =?us-ascii?Q?vlpw/8wphl4Vjc+2c6DtDR4A91Q6+7DYTfoK+Np1whFXJcJHwj7HGgbNc6v8?=
 =?us-ascii?Q?o6eV3N2xJ3LliDHkbgmOUDbVeJ/ZbiMCjx/9atjduVP1D506CI9n8ZRCTo7c?=
 =?us-ascii?Q?vz/xDg8Ha4B3aP4fto+W9e83PJ0XRoh0D1dAo0KHDmX+L0LtdtDSfvtIbpOZ?=
 =?us-ascii?Q?yn/APYDVRx11TH3Y25H56QVX10OO+voEoUx8bHPNmiRkEXixhfruLIWzmaQw?=
 =?us-ascii?Q?AfL/qG6y1r+NKTAncUOL9O12/W5JDPnZDMHvCUCil6uCz8pXeM1fRVAV6P4r?=
 =?us-ascii?Q?KJGp1UCOsa8aeA/1Rl9XQzLideIqnw6gSzlp/IIm0ZadapOSf43n+PprGVOm?=
 =?us-ascii?Q?UC4m/x50lip2npIuULKmfMzLnY60xVSVCmBKNzcYFnj9RvHzaagSWRaGKVHq?=
 =?us-ascii?Q?rav3Wsh1EYrTBZqPdX7kRvHwCEjU4lKinbbmn6WTfEx17HreTzh9/ubL1lP8?=
 =?us-ascii?Q?trqMiI04md2g3H/EVOXV8pZ430spzAGo16W21IR8eryC8zlQv/iCVe4jBSu8?=
 =?us-ascii?Q?7DRYZDtsxSnLVYxuze+3wVrqm9gj1paztne0Njq66JHt0PSXBIEVCrGlvUQ4?=
 =?us-ascii?Q?V6phDv+DBKrZsXIZsXaO/mfOGbldCuzffOTa3wsWHPqazYARwqUDtobFDHL4?=
 =?us-ascii?Q?NPmbZj3t8Tm5PZBGeG22eXIcauLvsLIKf4c+TrtJh6RKXQawwtu/CLO1xdf+?=
 =?us-ascii?Q?AiUXvSPDhuLp+wyA4cgfVuxFSRGcBkiXbNNmm7QJTMi70Xt6GYIaOK8K0LAc?=
 =?us-ascii?Q?DUDUeaYn/z70eQy2p4Sesr7sJVeXYSq/v4Z8GcUrAnTC3aesfAiYdbNo5UC7?=
 =?us-ascii?Q?oZ3VSRu/IX/QY6t4To7Q/DxTQ95Wqr5r/DpRxgIVGRYkEL0/yQ5zn3RMt4MH?=
 =?us-ascii?Q?EJ/mOKMEsMj1vqBsVeAUKECSvsWubwcsdv9B/hA0Dnl4GEVIbtHDDm/IyJGL?=
 =?us-ascii?Q?CaOfOxGApS7q7PGbJ25GTA7/vdot35+QfZFMCySlhu7aCxrG7RtsQZ0o9KdY?=
 =?us-ascii?Q?7VSHdenHZ8KbE7jDDWryANY82iYrcxpEpLoZtXEnP/+RneMI7diCOCiCaQHr?=
 =?us-ascii?Q?qUE81tWpVJQSVN7ciIJ8W/a4nA8/ofXbB0DOTiWgBBPAcPTkydjF3pcetSU5?=
 =?us-ascii?Q?BFRk5C+43HKHvdoauP1WbqSif/gBvNQdlzsqnT6z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d310819-0ed0-4ab3-fc8b-08db54807e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2023 13:38:25.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLFjvu516pmDuwCntXs0u71VGTXiOHSKNWl1CFWQuT+zKNCFl8OdoQnuOm35iLw1Zw2z4Mji0nV2I6RjfPWrfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6883
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Paul E. McKenney <paulmck@kernel.org>
> ...
> > > Here is one way to script this, where "SHA" identifies the commit to
> > > be checked and PATHS the affected pathnames:
> > >
> > > 	git checkout SHA^
> > > 	git show SHA | git apply -
> > > 	git blame -M PATHS | grep '^0* '
> >
> > Cool ~. Thank you, Paul.
> > I took them and made them into a script below for future use ;-)
>=20
> Nice!!!
>=20
> > #!/bin/bash
> >
> > SHA=3D$1
> >
> > if [ -z "$SHA" ]; then
> >     echo "Usage: $0 <commit-id>"
> >     exit 1
> > fi
> >
> > if ! git cat-file -t "$SHA" &> /dev/null; then
> >         echo "$SHA does not exist in the repository"
> >         exit 1
> > fi
>=20
> You might want to record the current position so that you can return to i=
t
> automatically.  One approach is to parse the output of "git status".
>=20
> > git checkout ${SHA}^ &> /dev/null
> > git show ${SHA} | git apply - &> /dev/null
> >
> > PATHS=3D`git status| grep "modified:" | cut -d: -f2 | xargs`
>=20
> The '--porcelain' argument makes 'git status' is a bit easier to parse ro=
bustly.
>=20
> > for P in ${PATHS}; do
> >         R=3D`git blame -M $P | grep '^0* '`
>=20
> You can avoid any bash-variable length limitations by using 'grep -q' and
> capturing the exit status using "$?".
>=20

Thank you, Paul, for all the enhancement suggestions. ;-)

> 							Thanx, Paul
>=20
> ...
