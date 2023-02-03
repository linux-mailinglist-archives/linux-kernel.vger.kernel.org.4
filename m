Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E236688FC3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjBCGn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBCGlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:41:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37409030;
        Thu,  2 Feb 2023 22:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675406290; x=1706942290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j73Dgq8PdWH+zsMOJ1dmDKzKShJgfKNoP7Dg8R8FjBs=;
  b=n9Lsr53u3tbK6aYFEKvhNjRB1ql3dP8QQN4drkEaTVR+xc7G9RqNSfOs
   pZkPBNNPMnqfOF7HvQ03VmBaGSHMTayrKfs1qFMo5jd2/D3XrgLkV1RZi
   vfvJACKK7YnNEKXwq5LVNbq4UfSVp9XqMnwwJkCThL4pU3vS4/q8YkMB8
   rByfS9GQCqC6jeLbRBcxlGpnG4CtlqBosg8PavI7ex5YMali3IEImJAf0
   Z9QS7J1PiTxeNG7Ao5MskyfWRkusIzZPFVHjbxiuihTEbBHfvhocCOn7X
   BbVQOhIl+3nAxWoPEGfoFbVXEn4NXJXD7B3buKv50k//S6I0cyWKCElo+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="308314460"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="308314460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 22:38:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="774193283"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="774193283"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2023 22:38:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 22:38:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 22:38:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 22:38:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 22:38:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzPF2/LEw32pIndW4431mwabSlUsqlpqWgcwhVuKyS1bniseYKg1DxtcKQ6gLikwuxPRRfz3hjZsfBuHe18EbmmG0Tcvsody7Q+MecqWMZk2/S43k4A5ewQFBJo+wQC1vya843zdBRlUJdw/C+6zMiGB+XX7MGA0YV/gltuT3zXdxq6n84N83bSPFyceuTGMJC10CWOZLGco1FRvSz/j3BgjJbk//SF342ZdKUaLdYaJDZdCHe+G/0JNsRC38Rvyz9mxC6zD7hXReGInJBfBogGGOLYakYFCjnFM4BqvJ/2yu8d/kr3JoeRLe4igI9pJ/mzokhe7XQJmv35w9YnckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4goPH1/HtxoBgxg0joDLMT1sW3FbH5L6YMdPAUjlSQ=;
 b=bcND/m0LisDBuZRU2BY0U/VwaDSvmQHhWN1VD71t4opqlkIWMg+s3dkCsARXaEKvLTcWGkDTb8h9AJUrgvhKxOXKIF76ElQJ/SzhxNjttpLKNNHd5Z5qSmeFwyetNisEBdQ8oaFmUBmnq+VpYdkxMVJF8YqcwMqIOHhc7SeCG00TFTaddowS8yQaCtWC4mZPGBcoHSjEHc+0oG7qrGFaskXc/W8zAcEoH9LH2lvkHUIBtmud+6wtDYkyf++M8HCwHnxARloKfnPlJCMaWZ8+33j7LuwqCS/0/fO61foUuHJ37sj3pP4uw7LRt8uTHGdiGrirnGZa5ur+uppWGD7u5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB6142.namprd11.prod.outlook.com (2603:10b6:8:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 06:38:07 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 06:38:07 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
Thread-Topic: [PATCH v3] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
Thread-Index: AQHZN2/UL1txlbJjvEezXlvE3XxcLK68xM7g
Date:   Fri, 3 Feb 2023 06:38:07 +0000
Message-ID: <PH0PR11MB5880EE5E5653216772BF1047DAD79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230203014021.3408798-1-qiang1.zhang@intel.com>
In-Reply-To: <20230203014021.3408798-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB6142:EE_
x-ms-office365-filtering-correlation-id: 4e0d727e-b108-4de6-87b5-08db05b135ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2q17K8iqKxNHRtkjP/D0w6Nu8VQ8alnporIRT31MI4hNqXi3uADa7/o4qhTjwmqdHHi4copnMO0DGzqPfrnfJtlPMGM1bGy2bbHl4OOkPdS/QnyH7/5uuLshOr46x42VX8vtIcpJ0UySNfyX/PshJdzerkb4tO/+d4JPql1dx/y143FWB2Ux0gSSDdxGnJwWyRDjP5tWqJYPp5sabquaMcVLb8qVca9Q2m+EdV/erfMCuxaaxhaf/LCBrGg6v0owAMnoG2cDfoilfPzjJ1oEbATlryQu3fPdssgCfOxyzC6zEtU3mCxjQs8gSWMTQMVioRLyfCQrmL3CCxUGHPf+bLbdZ4P/fR+PuuW52DHSMvfAspOtahUb2BuJYC4J+tCkmcbyReWEc2Zo1CEa3tCPmNHXA/rNTxKn6rwDgexwY9zvzvH0cSf8FGnRj3Z/cKujo+b0ZfpTvA4WARF45JqQAD9OnTVi70Ld6gu2htMWYyHAd+OoncbzWCC+2cQdQGYRI9Md/mBzp13qMtdHBWlvHl0nJxNRmEQ3OwNGS7JK+ZqTP6FbtLlqUrCDUzk36z+lhCY3xCvQhRndNqHWjJS4FdSuLsjjcO4ZBNviQrptX3Bsbtgw5RYEG4NR87MXG/c2r3RCJRqpVXuNdszkxVRu32xa5s6hMhwf7kxjwRlBuexUf9dge4hylt35M0vAn53oW5ams8L3RmQAMoDacIVeuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(76116006)(66446008)(66556008)(66946007)(38100700002)(83380400001)(64756008)(8676002)(4326008)(316002)(54906003)(110136005)(122000001)(66476007)(71200400001)(478600001)(186003)(26005)(6506007)(9686003)(33656002)(5660300002)(86362001)(41300700001)(52536014)(38070700005)(55016003)(82960400001)(7696005)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NbdH/Q+dsSkhRo3fr4uL8wS9KyqBxsu0CHdOzWCsoTr8FZq1TYkAWumIYXss?=
 =?us-ascii?Q?PgQCqML2gkYvQaUD1SHTgTM9TOyFBUGrS+xfuqLQx2MjUcvzEWAoedYk7AWU?=
 =?us-ascii?Q?YqaFaqUsZ9qXXvFu/pwVaajisAXI3U8yFm1pmJVzyBdgNTokjr8Z/KhzT8Ed?=
 =?us-ascii?Q?M0I71tO2tP685Hn5tIYcqBdTv3wbD2i2tREt3s6LTOxt5eegmoDiij2Z5g+C?=
 =?us-ascii?Q?w//ZjD+hmnZh/vZBEL7EGbZNhr5+lwoQxgZKI9YGkX863xrYUZ1jKiNNuGFs?=
 =?us-ascii?Q?mlvMZlXvvS3e0UtdzN4yx4kUFr93kNfG1RP157h7+J4Mzg9iDa6RUkDnVg7o?=
 =?us-ascii?Q?/MnpnbbfFGnJVdUG6/0ifeCi9kcKKaAPJlAxnWl0BQOLBxGB52yA9WTFrq3g?=
 =?us-ascii?Q?sNm4kw2QzCqud8luXO4PWeSRIbwIVd2MuLkNL5cSpXV2yOtqwaJF0PlmdLOx?=
 =?us-ascii?Q?MyTAzsHTbWz5noRqxfFEBGXQ2RM1MEzIU06bs4aqTWJHcgLWyJ4rHzc8Lj71?=
 =?us-ascii?Q?DoEr+smrjLe5g+IdksKniDtkunDCEj5gUv+mZU8MAPbmr41E+dfTER8FsF82?=
 =?us-ascii?Q?VAeM+wrKQeVshO9vPd6xoUf5CGID8AgtZaaHnIwY7/EPdQ8U/w9RfV/h+sHC?=
 =?us-ascii?Q?rgRDbEToInrind0YTVF+0gVp74fEKuTJSBHLwtUOWaQBt0UWmTspW42ZpapT?=
 =?us-ascii?Q?/mOoGdgzDw1jYMsN5b5Upwfv4ajhXWKs2CzSQQuXnVLtyYC+Ctq/WGAJgDRc?=
 =?us-ascii?Q?ZT6L2hEamIXoMaPwuX6wzDaIwaTnFuawzih29pibUr0DQTR0mM3LCTsoknTx?=
 =?us-ascii?Q?etfkzVGBhgYMvZIylQ+mYmI34pzB5rrRG2GS66LJY0mYFSUeZxZGKvZMLkke?=
 =?us-ascii?Q?wURIPDFzjWNeCUcRjaKloZLORteUlF30FzM9BbZwgIftMu8xwipwZqmlBaZf?=
 =?us-ascii?Q?WcsqJYWTT6DgFRr2fq7LVH0WIemAmC1RlLSPodx+tcqEm/SFpznPaQ1U8yQS?=
 =?us-ascii?Q?qbc7PZ43/v5815Wv8acEA4mJCz8aIgkr+ppg587PgmFxKKOpI/c8qhIGoUlu?=
 =?us-ascii?Q?HmI5MQGZ7Ns+wWZws9U/2K6nuTCj2k/i/xSyEymGC5MEp4kiEyuUDySP48YT?=
 =?us-ascii?Q?eBpGrmcP6rINUwIS2wzrM8kCaQUm4hhUWmrC5fIzFu1w9sDK/PGnfwkBqX0X?=
 =?us-ascii?Q?3Pfko2HP3gW/CF3AEGUf615smxUYhWdTzfjlF0VfVMskmOJ5fyXJWg7nubF+?=
 =?us-ascii?Q?WXgSx4eFZvyBzjBj7EhE0x0DLssVuLT7qkhTarCdw3w7dc0qjl2iSsTh/ko7?=
 =?us-ascii?Q?tSvFx1WNeHhDHIeeegBJ93YkI93TSxv7lEzGdK7LozmZb+yThVp4XzLCRBHg?=
 =?us-ascii?Q?yY3DSWLCz4WFzoxFz6PSZhZ+AKAeAYHJkTJv77RaYoZIGbAeJRcq3eBOlNG7?=
 =?us-ascii?Q?aEhssGOJOXvGVnHCF35LWqe50HNIcYeuVIsCj2Iyw4+y0cOVLM3hAmYM2g6J?=
 =?us-ascii?Q?VxGuZdX6zWccFmuNAJpeB7t7um4UItrOzDzaZbsJh1VB1LJ2pzp5Md10KNTn?=
 =?us-ascii?Q?lLQGXIBQN1wfBb4FxuhALLUiOPx3CvAeb383hnUt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0d727e-b108-4de6-87b5-08db05b135ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 06:38:07.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggIoOec3bw5uGRfzD3wdIQ3q7zHxXzXwtJehlGf2+GGk1nveDtK98nY6aB0bPeivWptkFjMK+9qkri1Q5oVOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6142
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>When setting nocbs_nthreads to start rcutorture test with a non-zero value=
,
>the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()
>to toggle CPU's callback-offload state, but for CONFIG_RCU_NOCB_CPU=3Dn
>kernel, the rcu_nocb_cpu_offload/deoffload() is a no-op and this is also
>meaningless for torture_type is non-rcu.
>
>This commit therefore add member can_nocbs_toggle to rcu_torture_ops
>structure to avoid unnecessary nocb tasks creation.

Will change commit log next version.

Thanks
Zqiang

>
>Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>---
> kernel/rcu/rcutorture.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>index 297da28ce92d..d01127e0e8cd 100644
>--- a/kernel/rcu/rcutorture.c
>+++ b/kernel/rcu/rcutorture.c
>@@ -3708,6 +3708,12 @@ rcu_torture_init(void)
> 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabl=
ed.\n");
> 		fqs_duration =3D 0;
> 	}
>+	if (nocbs_nthreads !=3D 0 && (cur_ops !=3D &rcu_ops ||
>+					!IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
>+		pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=3D%d, nocb togg=
le disabled.\n",
>+				cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
>+		nocbs_nthreads =3D 0;
>+	}
> 	if (cur_ops->init)
> 		cur_ops->init();
>=20
>--=20
>2.25.1

