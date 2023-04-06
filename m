Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4D6D8BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjDFAXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjDFAXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:23:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB47783C0;
        Wed,  5 Apr 2023 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680740588; x=1712276588;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LnXsjIw/LatY8rO2LyCkG/EA5DLhZD0G466jozE5lM8=;
  b=LlujbUsWJrH2rO0Jd6+YTvLzwF3PBDkaxD92e8m7z7lJMikvla/mi64+
   GjazEEYjzHuW7q0S5ZwE8J41aVh6Q0KtsPflHljFh5dEDqwTWtD/C7tUC
   KBoZjwfpUErESrUStgmF1YLa+3He0aXH0uOqNLpcexg8e2EJv5XOHidel
   BuET8FvcrJiSogAPq1Gzw3T0a2CUWc228rNelylFF9ktS67YZQR7ObCgB
   4KvVz74ZB2Hn27stMV0W+mDVt4rR20xZ2z6p8Sz9mN1ly7gPV9NcXMYwM
   KGL7ok6zyOJnLh6x+sLEot1Si/wZJcjgJDQZnjcBvvUUDxpM9cVL6tCg2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="344334361"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="344334361"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 17:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="751446572"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="751446572"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2023 17:23:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 17:23:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 17:23:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 17:23:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 17:23:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8wka9LZeMoNmR10nfi627Imx3YCmAEndpW1UUGwiBbmr28yG7jvsuGH70yYYe1wgOhJAx/y7dE0XPB73r/6oc+gjkBeRrxCRqdWH+BNzvScWU8eWqUWCxCB2+t272wcZgNMEB0ZL0ZtAx7Z01ChrGlSJ01Jws8NlfNQy9CXFN++gJok+ROF7lDFqWo3gNC61OrMUSs7SwS9+TW8gdZzg9fgVplaX/V6ympd9UNEwYhzss+3K/H+idduYn5+VdBs7BZeEA81AScde8GndBhUzo1gHD6MotbppZSaRxAFAbrd5NKZ3dR7eKTm4qhfe4jxMVJDWLrluLqrlf/eacW4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqqtIo2CNwgd0PIqWB4ZycEwoKh9XI23iJPivatr4vo=;
 b=ase3hzhIvXpN1RkzSfVPNHHWRnsMpZSM1zbW7+JNJn48ekDZZPQOJfj515LihUmF0c++QBMwsc7G7P24ZZCP+K8iT6QDOOoDpdT7ZDvSoqfYGwSoMzXSsoF4SnfDDx3scVRaQ+o1/RW+GNL8T+fTCeWzso7Gp/RYNT9G+PFV5P+4ILJWX4Fx6BRM+WbVDYaglmobhjt7mbXAbGDGltEAvpOwJqYupbfFL2oTZE1QkmMtEwoAULdVQvBuVHj63Mm9HDDGDUhyiAyOre1iTxck6d4V5QIes5v/gCDY0ppQ84ldzEPUxRRD4uBkFH/iUiZfzOo0wrx4/dhgrp5WTGSMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7883.namprd11.prod.outlook.com (2603:10b6:208:3de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 00:22:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Thu, 6 Apr 2023
 00:22:58 +0000
Date:   Wed, 5 Apr 2023 17:22:55 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>,
        Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH 22/32] ACPICA: actbl2: Replace 1-element arrays with
 flexible arrays
Message-ID: <642e10dfc46d8_21a829451@dwillia2-xfh.jf.intel.com.notmuch>
References: <4845957.31r3eYUQgx@kreacher>
 <14903668.tv2OnDr8pf@kreacher>
 <642e00331b335_29cc294b0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <642e00331b335_29cc294b0@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 25710e71-feb2-47ce-fe06-08db363512d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l57ujTjdf2CrYtAccvi4ES/Q89c7zkrCM8UtZPgwgvImr4PkWbv4yxl3U2eyYWyE/q7y9SC7FscCYE8VEYO+6ylrjcQhqLAmn6s4fMchA42Xo81HVuGttWSpK+2nmKoWr4O/cND5/7tpgwLQMRMNcUKQ72zu/KJSF9SrPPMmtseC9E9Nt1aWL1He7WirucANC3ZkEattQir8LqyQ5cVCHJhJDJEssa/tF+Dg/IVYTPffw5KZLX0pAvsJa7FjzL7KY+1izeyE3kr3h02IdDY3e+y9saPSkQXTZGi3mYDPHDZSbFTsKon1IIckEhN533pFGCYXMWO5y/vvBlkYgnVOrcrQTkX/vzhQNFjHgjbRfxz8hTln5NnLnXZV8ZDDEIBC8SWkczn2YdJvkuEQtzQ75z/jfkamxFELB/eW51/ET+pGTCGPlnCXnWt/6Mi5YK0ygXqr2vaOKFaka+r5gi9hnTPermQYZXtezzxz4jfbDbe8c0B+vyKiMEn75CQfWF6HGfxl98jN3wiUUbXgkJkSs5Ly/cDNce7Z1X18IadPp/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(66556008)(66476007)(8676002)(66946007)(4326008)(54906003)(186003)(110136005)(316002)(5660300002)(41300700001)(478600001)(8936002)(6486002)(966005)(2906002)(38100700002)(107886003)(6666004)(26005)(6512007)(6506007)(9686003)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Ph6iTX+Q63rrjspLKwMaRDOjQwAi8Qp68LZqZu81z9LTbthXqWQ5Bvm0IRp?=
 =?us-ascii?Q?cF8zyEj7m2aqWxZXTVojMTlk0B8gBLe7BflT1eYYXBHPYSYuPKlzEJo7SiVm?=
 =?us-ascii?Q?Eig4h2nV3uf5cEDwBijNv0ni0fgU5ApjFSlE6pgDJbIkdvvaDJ/Fs8hLkfaK?=
 =?us-ascii?Q?vQ0JgyHY52DpSXSPCCJ3+VHXhTWqwgRkML/CQ4vTGFlvWFm7mlpz6HkdrAIk?=
 =?us-ascii?Q?ATJrqeIkT5NQn2zbyzSEImSkq+v7PI5folqXu61+Xnnewl5FI7RFvUfZlO6Q?=
 =?us-ascii?Q?knWTjL4j19NUUlUFq1WdxfAPNBPW/o73iIZ3XdP5K2meAX3Lf+WELs7riZIJ?=
 =?us-ascii?Q?8U+SM/aKaVgofgdbbo648elmPNSG6PDxies3LLYookhP+0T6CRisen7cBOZX?=
 =?us-ascii?Q?wyLVlsrP3V41Idk7an7od6NBSQMgSmY0CzZS6l4PJX9U8h3lMkolTYhdnyS2?=
 =?us-ascii?Q?/Vxu0S2+zxdjiTeui4d/yC9ynHeF+DMEFfacTMaujhp9ZVITJemlawETXBVN?=
 =?us-ascii?Q?PZvI2MXsFXtk7b0t6MLVORYZdg2WGh5fcQ/AayOqbJOt1l2sukp5BnxDncob?=
 =?us-ascii?Q?xoFJw/7attq4nTreLXpreT9oY2lBtE5PzOFbxddCJNASt1y52vdU6iGUAHo+?=
 =?us-ascii?Q?ZjRky7RDNlK6pvlctCLS8OuZ6ub0BYYFm7qVShv1D/LmPiBJGlhX12ftx5+F?=
 =?us-ascii?Q?t7IK8aZZibHz71S3COPiJxO0znXHJBPWN/2lQZbihGNapJJEKduC9jkhjvgd?=
 =?us-ascii?Q?hMcg66KcO/ocDtmrmpL1wYYIzMN2U9chUEtdEAO1/jqdcn+eOY9oFeQcGw7D?=
 =?us-ascii?Q?RjXGLANQ7cgNH2LxX4BMm0tX5VYqrOaabBCJ3gnXIAbwdtEc8x++PAF2vqLE?=
 =?us-ascii?Q?2+7mdb4Kg6yjBiuikYucnUKgnmV4uaRc4P86vr12PhietYRlfkK68h3wVLq4?=
 =?us-ascii?Q?EgORomffFL1tyL/VCSb+WRuEvap+cM9XyKMDW3vBPSE5LiQBtOfzQy0rku7M?=
 =?us-ascii?Q?8OvF1F6SqNKUUg9pW4BTAhtbOvPbVYTaX2BCEEVnLQj9KN9/YrggASZ42wzg?=
 =?us-ascii?Q?Am2XhrAeUOp6BtXrx2k4Y/ghGy8TH/4F9Zw/HuoNJxWmP/b0wEYL3ESshX1a?=
 =?us-ascii?Q?AyPSVPGQBPUyUYwkKTVk7MoORLaal9AlfaJF5VSmZQsdNgkBFCAQr/3K66uk?=
 =?us-ascii?Q?fDTzgrrxu3BD4VhGusW69wVg5yxjdBZxMk4qM3RPPCrDVPwHwaLnx5QXYGuW?=
 =?us-ascii?Q?x/JQ2nANVNJG9ghr3FRY5UoTDfNTfvyaoAAPogVsPPq1yjWqBdysSvTj9k6J?=
 =?us-ascii?Q?q5fzq+P/yTDCneGDY17COxqzh1E0Kt6HEI7D9wykOqQeVq9Y76SaHB12PqRv?=
 =?us-ascii?Q?QjTyUybldpo6eKbUFvhIaLO9kBO/tPb40tR+rpEapzZbbWbJanZH1G6N5b6q?=
 =?us-ascii?Q?fTebZi9tQcY6FtEzDkdGcP8iD6GiCVtf2houVJNc4E0z655wwPbnmSGhOTku?=
 =?us-ascii?Q?kYU3xVp8DVluFUl0/xww0rzAqtZYslW/osfVcNHKvPtLFGso1JA61+xb6H/X?=
 =?us-ascii?Q?Zx7ML+fboJTBGoS6K/58Gw6MQDh7T/OFbyJ8wLM8sDNu5K+ywPpiYbTD58iM?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25710e71-feb2-47ce-fe06-08db363512d2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 00:22:58.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTouVSRdWLyPiFow98+stG8WxGo5brfL2mNU0rwAyIP4YvHRqKhQ/p/QcoMxM+adIDFo3k2BpnXbT0Cx6lvLRPhV5nM+dm4tpBE/VULCuLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7883
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Rafael J. Wysocki wrote:
> > From: Kees Cook <kees@outflux.net>
> > 
> > ACPICA commit 44f1af0664599e87bebc3a1260692baa27b2f264
> > 
> > Similar to "Replace one-element array with flexible-array", replace the
> > 1-element array with a proper flexible array member as defined by C99.
> > 
> > This allows the code to operate without tripping compile-time and run-
> > time bounds checkers (e.g. via __builtin_object_size(), -fsanitize=bounds,
> > and/or -fstrict-flex-arrays=3).
> > 
> > The sizeof() uses with struct acpi_nfit_flush_address and struct
> > acpi_nfit_smbios have been adjusted to drop the open-coded subtraction
> > of the trailing single element. The result is no binary differences in
> > .text nor .data sections.
> > 
> > Link: https://github.com/acpica/acpica/commit/44f1af06
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Unit tests say NAK, though.

This causes a regression, but I think I see where. Will send a fixed
patch in a bit.
