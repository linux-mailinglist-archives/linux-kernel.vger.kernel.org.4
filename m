Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC2737824
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFUARq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUARp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:17:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DA1A8;
        Tue, 20 Jun 2023 17:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687306663; x=1718842663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t/TwYr9S8Qp6JmtnxbvlfSIXlf4SrZFQWOR0SF8Ggjg=;
  b=MgLUktgBu/xazxEynwBaMhcEGGeA1ZH0E73Wl2uiPlon+bqePMf1pVTF
   HeLF3ejPmUKJnbymvt1D1RtoOz+lsNATOuarLxzS1PSlN3l6AKuqIz/9w
   c3KJrWkz7Xm+G7VaT2/sh4cq6G44gt6c0xyeNFTZ40XJ40XZL1Iy/6X6N
   daGOxIm/OmPynVaO+aN7ck0cTobBX7StHm8qevbidT7fdRBLZsFVqcBz1
   bkKljU/XwL10AYhI/nTOn9PsV0Z5+I7atY/qbhwe3BcKp2nKrC7T2/bZk
   rRhz5YrWkHPsJ0cp3bdcPeLorPa4d+mmrLEZeJg60A2foz4Tiug0jlLYx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357514222"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="357514222"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 17:17:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="858773695"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="858773695"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2023 17:17:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 17:17:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 17:17:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 17:17:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 17:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+K8MRu3So7J7AFA9jMjJI6UcmR0hKzJv83WZiMVo6za3Nj9H2E8p/38LQ0ZBWCuI53CKkflYNR77jiByb3xSMrxeC4vzQjlwDySgpluOfpccJwq7e1ruILhuQUpeeHwFqv4qt5B+cuUWBaTpdpAxg7UQkcS4SDJEKJqZdCjeytiSa69xMywVG5EYDhCqAJG9L/vlxuGeO4nW9hqZktQnSQMUsP6F2w91tYWU2HEYhOC5sa9fJImGh5tYNWoUg7S3kEanF8EmocisGVMHkgvKlU8dEvfxW9GfVlkIS6Fik1rwdjrszjaxKXb6xZ26laOKOvaMhKeBUE/UQhXU3RtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKjFggRmr6wGKEqn2XKZTS2yyvcQIx1OO72ZstCcvX8=;
 b=lZb7QsEsxOj/HVyED5p7S7wdb/MR0IBZ23yC0tAXMimzRBAFVqqhU3Ec7gvRtOp7jq3hBPQsjHkPx6zmMrjjh2BvND7ZCh6+LpyDoBKzZqwMsv0LMesmyfEEdqvQVJ5Vul0gf3xmVP7soiWFrRMCn0JiGn7v63yweN5RD7WdeTSO3zREQ/wpUCJywSH3y9IEc6krrZEkKKVlcKDsYOvTH4QutKzOqPsUKBAbW2kU+wkDUooHvivv9Ve86ADjU/9ZZm/eQw1mUIgcCQyrYYSVyCGwimf1wSjpAJ4Sn1S1p2G+EaN0Ahy0mrZz5NwHq1UbsA60wNuUfgwYCZw2IDPAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by SJ0PR11MB4781.namprd11.prod.outlook.com (2603:10b6:a03:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 00:17:40 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::dfd2:5a47:bfeb:aa2e]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::dfd2:5a47:bfeb:aa2e%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 00:17:40 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Florian Kauer <florian.kauer@linutronix.de>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Tan Tee Min" <tee.min.tan@linux.intel.com>,
        "Gunasekaran, Aravindhan" <aravindhan.gunasekaran@intel.com>,
        "Chilakala, Mallikarjuna" <mallikarjuna.chilakala@intel.com>
CC:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurt@linutronix.de" <kurt@linutronix.de>
Subject: RE: [PATCH net v2 0/6] igc: Fix corner cases for TSN offload
Thread-Topic: [PATCH net v2 0/6] igc: Fix corner cases for TSN offload
Thread-Index: AQHZopYumKxF3D6ER0CT+ezDVm3HE6+UZkjQ
Date:   Wed, 21 Jun 2023 00:17:40 +0000
Message-ID: <SJ1PR11MB6180E6EA9A7A3541F341FA9AB85DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230619100858.116286-1-florian.kauer@linutronix.de>
In-Reply-To: <20230619100858.116286-1-florian.kauer@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|SJ0PR11MB4781:EE_
x-ms-office365-filtering-correlation-id: 8cc58ea1-fd71-4150-494f-08db71ececc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NiuGAD/AI/Thxxix80BhE5dz6L7/cYZtw/sIOHmo1GVuwpvONJMLr1BJqaJUbCRRTnkedpjmhKiUvpaNjKiuSxAsv+ps+9+VAMOMtTl8DyoJvxzFyAoS1JcCxn9hve+O32gUCo3Am1hNGzCNidNGr+T5BY1XuujMeMqfjoGqOCRLZFf5iunPYgZ4nwceP0crJJ3XX9c6oC4nAZPW20wA8xJiwV9X8wrIrAsN5Z4Kk96QkzR7+r1FT584A/sTHbLmeMumpLCIUgBDUrGgWgqC2+ebaLMiwDwaYgWS4fffJn7SGnY/+j6eDURRf9ZxGS8YwuWiKwohOEDn/zYlSyRAPiMZxJ/2tf+8Vq3Uo11AnQeyerKvyFkvqfDjmZXIQtCLKN4p9kkRykhmWKI76y70bciJVA4jN92wWiJvwpw4bzO/pMM0m4Qxrs+cUKRXG9g797jUYo6QtP64hC43sSdjAd/tjIFnWs6zWTc9W6DzLHHbiDjV2d7RJY2gtWZdHvevqVJ3wHAbmbL0veIIek2M+ptkfSN4SUQ24efUX/mB3Pz1n2Zae4OGCTm7TqUT6YZWi3zZZByQu1ilzA6EhRB3KOUGoMBDpRS05EhlqJeWb4r2aOJMXVXIRsJnWdIbO5s6Ha8aKLin6UZ1K3K4Io7Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(110136005)(478600001)(53546011)(26005)(9686003)(6506007)(186003)(86362001)(71200400001)(316002)(54906003)(38100700002)(82960400001)(83380400001)(122000001)(7696005)(64756008)(921005)(66446008)(66556008)(66476007)(4326008)(66946007)(6636002)(76116006)(41300700001)(7416002)(52536014)(5660300002)(8676002)(8936002)(38070700005)(2906002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o2kXuOgxhQ+jlecKJE/AfKfN9xNQuC7yujOsocstjMI7htZohVtI+ETUdbAH?=
 =?us-ascii?Q?5wzHap/jE0XYx/2gSBIVTPp+An164wRuDSVWtR7RFw5+Kr1tKwjzoOYCw3uo?=
 =?us-ascii?Q?wjvBAaI5I01t+lm/g/QsmuX5OL1lhrbjArJeZtHXih45Qz1gqk2ONMww84im?=
 =?us-ascii?Q?mYBQQxGsHkrHZmMo53qf4ufuEqLEuJsN2I3T/fPI4b0JiXnDMmAJ/57IXyRJ?=
 =?us-ascii?Q?7eMgF+d/J6UqQF/QK/N87G/Yxjh1MtV33ueBj5fyV2KU5VuNTQY2GFZBEblN?=
 =?us-ascii?Q?CfFSOHQdGKsK9ssG/zbFfdcwYXZE6hp0dAGbhGfEtnMkUVzwAjrmGMsNyC9w?=
 =?us-ascii?Q?yl7hAtTMz7iSuEttgbyMA6RwWF2ncAB02w3k+iR9RhAwJZZpvCGDYpoTPNFS?=
 =?us-ascii?Q?sumhB6cSxA+YUiQf6utC9sn1VVc7C/qtQmYGHphe7SsoiRvXXMtw5fiwvtOz?=
 =?us-ascii?Q?BK2ATfcm2N4fLAZI1IF6YoB8ulXZKbTix3R9eg1Gy9DZ4GlfLJ9ydZK/Ls4u?=
 =?us-ascii?Q?IiV39wH6KaL/KMXbVh+Dyexb4pi7b+0G7+IwgawlW5mRt2Qg6MmG6hg52MLb?=
 =?us-ascii?Q?XYLicuwDmCRvr62oAtJDrNX1H3Wgp14F+1xLpsnmN0i9otfdpUcXor6sOx+4?=
 =?us-ascii?Q?/Qlc8FmKcunhXBCFUsUog3PSvX/pmhvZpCcwUgq0745FK2rzs/UelBIIUlHM?=
 =?us-ascii?Q?JjTU0j4p0enj71JVbWMLe3VBT3SSpR1YucFLTvZSUuOXm505581gXrMRlQZx?=
 =?us-ascii?Q?vII3ZOmB7h7TRJ+Vz1Q/AC/ygBioNSNKAYleb0ipWmTseNqM9+CYLbFXSwTw?=
 =?us-ascii?Q?4oR2NRuF5iOIyrEzvKIFJaQeBPD9uUSwaqn1D9Y29kAybPraLDiAvR/KVs1T?=
 =?us-ascii?Q?5n82kNMM3jlZZs+EQBjbSzT49+WwPK45VUifBpxKQKkMqDoXGR9wqf0f4AN5?=
 =?us-ascii?Q?ZZnlBatGUHU2CTkBgLJIyCHFRse5itt1Smc9mu/aJGKuUwD7+gL6pmfjMcJ/?=
 =?us-ascii?Q?QxSA36ZL8IMwp7+wTAEeKMzR8Z8XwvDAOMbE/TdswozKabMQVVinCu3G8LcZ?=
 =?us-ascii?Q?2W1B+MgNChKFeu2P6bngWb8mcHRNUwB6iFxCWn81FnXDxfV4o8bWrQZmMoKZ?=
 =?us-ascii?Q?zuV2qKyRNWCqXVDggB6c50T1T55TVp6pSElLNbBpc7iZdPJi6yLz/bJp8/pJ?=
 =?us-ascii?Q?xTwqEh47quNWP+alAU8adHjMIg6CFtH47iprkUeVrCBeyYYNZj1bmbQxNHlf?=
 =?us-ascii?Q?x57eXDVLgaTvU/gzeO/kW4seELpZJxlDg168PXGwpRHK+9Xa0FyxbcjcPVI/?=
 =?us-ascii?Q?LlM9OnAZGcKsik8e3OOTHW4ZpXwxTnVG634vQRD2liWuobTp0JKdjJ/xO0nn?=
 =?us-ascii?Q?/7BaG+12WeEIoFhTj++O4qGpc4kdWjfpk6Xqj5z2PStKcGAaUZAjda70vN5T?=
 =?us-ascii?Q?1qeOXUJ8T6m5PdN0Nvzv1gClgEuGRiw5uf6Wb8pUQGUGCvRVDFr/fFXlS/u8?=
 =?us-ascii?Q?T81nHpin3qMylhq4WH0GuHjrmIuRal/iOFeDwf4hgy0axmfU3g2v9LXEYlYL?=
 =?us-ascii?Q?F4bMtg8b9CNgsrA0G6GSrX6Vz7Ho0vI/Dz1s3SiMJXPTMur/UY7oVaOMY+LG?=
 =?us-ascii?Q?ATKyc0rTEPJsE8Pe4ZmXdts=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc58ea1-fd71-4150-494f-08db71ececc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 00:17:40.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zw72D/q/0nHbb+jdeO+vvu4WBlNr3E0mAKqTmXtGTb4pGqgRISDXoX7AwGLxiATyEy6vzaBHZMCMqvngeJS83MsCImMoqlchpBpXjFxpyXofebbi5ewYVeiG4SB7nG5b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4781
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Florian Kauer <florian.kauer@linutronix.de>
> Sent: Monday, 19 June, 2023 6:09 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Gomes, Vinicius
> <vinicius.gomes@intel.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Tan Tee Min
> <tee.min.tan@linux.intel.com>; Zulkifli, Muhammad Husaini
> <muhammad.husaini.zulkifli@intel.com>; Gunasekaran, Aravindhan
> <aravindhan.gunasekaran@intel.com>; Chilakala, Mallikarjuna
> <mallikarjuna.chilakala@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; kurt@linutronix.de; florian.kauer@linutronix.de
> Subject: [PATCH net v2 0/6] igc: Fix corner cases for TSN offload
>=20
> The igc driver supports several different offloading capabilities relevan=
t in the
> TSN context. Recent patches in this area introduced regressions for certa=
in
> corner cases that are fixed in this series.
>=20
> Each of the patches (except the first one) addresses a different regressi=
on
> that can be separately reproduced. Still, they have overlapping code chan=
ges
> so they should not be separately applied.
>=20
> Especially #4 and #6 address the same observation, but both need to be
> applied to avoid TX hang occurrences in the scenario described in the
> patches.
>=20
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>=20
> ---
>=20
> v2: - Rebased onto net. #1-#2 needed adaptations, others unmodified.
>     - Extend #3 commit message that it only regards i225.
>=20
> ---
>=20
> Florian Kauer (6):
>   igc: Rename qbv_enable to taprio_offload_enable
>   igc: Do not enable taprio offload for invalid arguments
>   igc: Handle already enabled taprio offload for basetime 0
>   igc: No strict mode in pure launchtime/CBS offload
>   igc: Fix launchtime before start of cycle
>   igc: Fix inserting of empty frame for launchtime

Thanks!

Reviewed-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com=
>

>=20
>  drivers/net/ethernet/intel/igc/igc.h      |  2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c | 10 ++++-----
> drivers/net/ethernet/intel/igc/igc_tsn.c  | 26 ++++++++++++++++++++---
>  3 files changed, 29 insertions(+), 9 deletions(-)
>=20
> --
> 2.39.2

