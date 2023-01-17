Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5178166E6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjAQTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjAQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490345BC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673980157; x=1705516157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Z/vDcm0BIPR2or0OdUqP2cZb6KsgTiSU335TgQPrH4=;
  b=MGzKZhCrL8O7DInQtfsSTS/gY6K2BoreNzuTVZjb23MFYALI4bSRV2WL
   qW0FVKa+mCowWEz6BMwYxgHrJd+Vy/DEORc2D30UvkeuRcUa5Dg0SBPdw
   WG5Q1ysh9SNhe0deLjasMnzghs4qKVQtrgi7b/XZf3Lvr6un0OizMrZ8r
   tMow2Fqm5yo7GIr0VCKwPlOH0UnqT8OtD+2Qi2xkH2u4XuIc5DP/xSOR8
   sn7UqpT4K078sdRynfwwwYO94Bo5ZhYMFrYaUrf3AkIDXzgV2SkmPNML4
   9nVhhO8nqH5+V3kLhOTqTovpA1E/zZX3s4t7UHt+2kZNyqJ1axbqvuxz0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411014932"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="411014932"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="904754107"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="904754107"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2023 10:29:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 10:29:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 10:29:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZvO4VhKHIYkiukeMipsWVLsmoJPpcMNZN3XRZYka6NWQ9CRqJxIi1Hc8CWpWCfeSwK5+0MPi8WA7AR46SL2wabTqwAencdRRodj9p8HvTHaX/xkK766Y95gd/EPLOxPQCqAP+fF2AbP+//Uk1Bn/h+UfbY66yJT2FVirDCd0GAeol1yTmYBole4AGkLHzjiWnW4xzpeQ9KqrCW/vVlrUib6M6AD5HIrvr2ZvLcxzNjf7rLgmit/emAfUiznbPA7a6e3Wka2WD0b4DuqzMS4aeyUPnLHpIdz0sFIqYdUG9qVUkeidsuZ9R1HLcMgQeYmZoxZuvRtyunQRTMB0PSczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHxIIG1c4LNRUfSd/SmltKb9yjHpQB1Ejkg/8+jkM8g=;
 b=cdnxArjFVd9V1qQ3VuXCtlhSCePJVD8csT0FFQ8ikmMmI6xpicwUzc0rocn32yJLFWJ6H7ueKTQ36onfgGxpUmSVHn00rJpufZ6We7loBqB0WaR0noDJuOehVGt4wsdK97EqNf9tpVt3F3inn4wBRzN79o5XO1s2xUN0+58boOunlQzpKhh/ZKqwz2uIqBjFxhNIwShkv2jFIZOyOIsRYaVBs+730v1eqvwTlYvZrIMMiBJCuAeEVie+JUuD6GXBisG/jaKdtoN4YPusZcGpTs4muvQZ2ay/SYKT/6mAeTgcM0/PiBLFxRALc3QytlkgT1j9Vihg/UBPeKn5LNBfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 18:29:01 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%6]) with mapi id 15.20.5986.018; Tue, 17 Jan 2023
 18:29:01 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v2 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Thread-Topic: [PATCH v2 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
Thread-Index: AQHZJ3hTfsHcKvV5QEKiMypaOmSjQa6hMmlw
Date:   Tue, 17 Jan 2023 18:29:01 +0000
Message-ID: <IA1PR11MB609729461B9FF9F9BFD1DEC99BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-7-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-7-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH0PR11MB7541:EE_
x-ms-office365-filtering-correlation-id: 1e64bdfa-0314-4bfd-bfef-08daf8b8b499
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F3AtdKMrPwwnI8CgH6gy5T8xHMdGTBQx82O0TrtgFu7wV1/tiBLrQbVEPVYiuFqAmbKuZxQdHZxqwJ1GuVSTvwhfK20KYO6R+3jBllg1STH47lOnbdMHtnPk+yZYTqymUaaJx5Z9n2ta7V8BNqCf4RwZVC+EhsCoAx6k4s1M5pxH8XFLlcgDjhgo7jIKBpPPp9WD3mSggPqC49vnDcb2g/ijg//C4EXzgrtcVwP8PyaXy/wtc8hMssxN4W1fpZiarz+3MIBrh1oZgY492GxNh2DXEY3kiGwx+hxn1Oh86nszeaZNTWnbqhb72VZmzjf2oRBAgx+g0LPOhgSavmyj5ygSN8Vg/vXB4RHkjfef2COTaptC4ySO5e+7s8zSD26zFaoZ1sajF2XRlZL1Srqqy2QJ/DTo+PcVFeC/vYoX7aqGkZ40yXwShdX1D60R0jsaNmLhC34erW3ZVl7dfxcJIBO6kxvFgow+KDcHCwTyKCRS9p0KT4ipqfI88LwnpvG65lr1Shqlqc0sJilPX8GkwxQNgzZuGXujXhgUx6qlHhu8ERcZ7h5CjRHBMxTLtQbEZvPljNZmHDbedg4MqqOYbURtgJ7Oaw4Xs72d1hiNf0zS/x42+wIGoFNwmPdTGVjfzv4NTHkY20M7jhsWYeWI5/w11F80W1Nj+EJWx7pDV+j+uls5owcEgNW5SI4QRzbcNZD9KB6GjCeB1wXVm3UMkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(83380400001)(55016003)(86362001)(7416002)(38070700005)(52536014)(122000001)(82960400001)(2906002)(5660300002)(8936002)(38100700002)(316002)(8676002)(478600001)(6506007)(66476007)(9686003)(71200400001)(26005)(186003)(64756008)(66556008)(7696005)(76116006)(66446008)(4326008)(66946007)(110136005)(54906003)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/iBxW+s2gmwDXd3qIEZprfpyT0/n62HZKmf9u7P13jCc175rND4EqR4cscnG?=
 =?us-ascii?Q?WdEAgEpVQa0jVLK6/fRFbSYurtU8DznX9ZKxr2sQ0FTLAxe9VNcdz4Zq9nLB?=
 =?us-ascii?Q?AlUYnOm1JsX5NfYxkbhZjm6yppu33APZP7YMZeHlDJihX4sDdpLsqGEHHOWL?=
 =?us-ascii?Q?5tyTbkqhydlGbT5yxftA1kp3gsyH7Vf8gSqqwTNLD1Csu+f53Chd+JxYd9s7?=
 =?us-ascii?Q?FFRhxvhnb3GQc77jRM9XACCvuoABH0WY6QPxh3fZov3nlU/K2kPY6uaK5EqC?=
 =?us-ascii?Q?8WZJnmghnrenbhSY+I4ZkHu5rM6W8L2G7pjswG7Dt7Dm5u3+tkpZZIub5rVH?=
 =?us-ascii?Q?IotZWi8FPLfODp0q/2oqSHoNaiUM0aRv3alJnOR6bxiTB/L6R72/n5WEOBWv?=
 =?us-ascii?Q?hKPpteYlrn6wKKif2/n/yspixJt/w8DhW0TGFLWj++rfRGFBO0Iefjpx/se1?=
 =?us-ascii?Q?F9WxvZ9Ar3zcXue+n0qt4JJ0bJ2iH9LzvAIPRA6hlgD88qWkvmPSMCWoZq2P?=
 =?us-ascii?Q?ugD36EZKvRhbBG1+LsbQlTd+zrGMF8a1c0fQWvpIxYft0ZAR/L4hd66/jNcQ?=
 =?us-ascii?Q?HuLI+W6d1X1hYo2rd0DUuZsDM1jDt6rr2MVhs8E8Y/3ct0STXmRaUOjE5kos?=
 =?us-ascii?Q?yRMHF1z/gscAtX7eqogLs2GmPm5Xx3u2yGuM8mncFtYUKVBh+Ee0VcdNBBk3?=
 =?us-ascii?Q?d21oC3UVDGHip35GufP7AYbcTQmTFIqlJ7q0cLHRf2zSo81tJeuGTLFJFWkj?=
 =?us-ascii?Q?uLfxp62fiT5rTS5hNBsWjsWZvlYr1ibbmYJwlFvghNjLQ7YnuP7aWzQsjZm0?=
 =?us-ascii?Q?R2aVAalalZn2NaeYfI6Y61XKHKPQQU7L6Y9DeNkzCrI3YL7elflTV3zur6IK?=
 =?us-ascii?Q?R211HF2/GkCbmBdvwAWyMt8sNwJ6lQC9bfHmAuq9+ora/Z2I4yHXr8B9h3R3?=
 =?us-ascii?Q?X7f5UlJQAV/HM1Fb/0fx5pWrikG2ZkncdRu3A47io2zdz0gKcEe4R4A9BSRK?=
 =?us-ascii?Q?FoAlm/DJxStYgFmo5v1QSV2MyOm5JdAyxoler6jGZRpMTF/XigKqvsA3oR7t?=
 =?us-ascii?Q?n3Fe49HlP8lGewYu0O0vloKoAcWArS87k3Ok0DpRPDJGcNWVzVu9P3gZ11So?=
 =?us-ascii?Q?q7ajrhe/rWNO+FHp3WJyHpXlOOAqB0R330h199imC2Ar4E6vAt4VLUVBlGKB?=
 =?us-ascii?Q?dE17bf1BXrxnnZDWE980G0Wmt5C+z2nS3Y059nnYa/8Og1JZguyUNSm0nWNe?=
 =?us-ascii?Q?SXGKOSzxZNTdWWbspzNm7PhonuoZ+UTSp0LF0YAPOJzqjJeGRwsxFPYNTMk0?=
 =?us-ascii?Q?zDCiSe0UqOB5kkz11gKQVNQtDYb2rmm6nYW1rp//Yo2Gxs9l03HYWxMPLOS7?=
 =?us-ascii?Q?XkWZfw7s+pRiTQQZDVO28+M8smJF2JT1oA6ZUoHsnPkZPnX2IGshkPISNN/r?=
 =?us-ascii?Q?MXV5hiDLdfTJstvDJdwZRUmycNnNbOMh8WLgQGx5jZ1lf9BZrBtnK5+9ub0A?=
 =?us-ascii?Q?1XR7ppfDwoRPTgCaHonOWzfra/lA4HXQW/cO5MAQyQFf5DcCJEwgChIlUIGt?=
 =?us-ascii?Q?dt7R7rtEYVpgE9Nk+Y6cM6QTg8d1zwD96KSqJ27x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e64bdfa-0314-4bfd-bfef-08daf8b8b499
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 18:29:01.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLW1tB5hAF3D6S3thskpc7/gQOuRBSGNSSudNvBuvnq2XYH0bcDzWdiMg4QKOMO03Z5g3KtSVQmZGDE8OZqOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can b=
e
> used for different control groups.
>=20
> This means once a CLOSID is allocated, all its monitoring ids may still b=
e dirty,
> and held in limbo.
>=20
> Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty=
 RMID
> values. This behaviour is enabled by a kconfig option selected by the
> architecture, which avoids a pointless search for x86.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
>=20
> ---
> Changes since v1:
>  * Removed superflous IS_ENABLED().
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
> arch/x86/kernel/cpu/resctrl/monitor.c  | 31 ++++++++++++++++++++++++++
> arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 ++++++++------
>  3 files changed, 42 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 013c8fc9fd28..adae6231324f 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -509,6 +509,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup
> *rdtgrp);  void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);  st=
ruct
> rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);  int
> closids_supported(void);
> +bool resctrl_closid_is_dirty(u32 closid);
>  void closid_free(int closid);
>  int alloc_rmid(u32 closid);
>  void free_rmid(u32 closid, u32 rmid);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 347be3767241..190ac183139e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -327,6 +327,37 @@ static struct rmid_entry *resctrl_find_free_rmid(u32
> closid)
>  	return ERR_PTR(-ENOSPC);
>  }
>=20
> +/**
> + * resctrl_closid_is_dirty - Determine if clean RMID can be allocate for=
 this

s/allocate/allocated/

> + *                           CLOSID.
> + * @closid: The CLOSID that is being queried.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocate

s/allocate/allocated/

> +CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator
> +will
> + * only return clean CLOSID.
> + */
> +bool resctrl_closid_is_dirty(u32 closid) {
> +	struct rmid_entry *entry;
> +	int i;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);

It's better to move lockdep_asser_held() after if (!IS_ENABLE()).
Then compiler might optimize this function to empty on X86.

> +
> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return false;
> +
> +	for (i =3D 0; i < resctrl_arch_system_num_rmid_idx(); i++) {
> +		entry =3D &rmid_ptrs[i];
> +		if (entry->closid !=3D closid)
> +			continue;
> +
> +		if (entry->busy)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * As of now the RMIDs allocation is the same in each domain.
>   * However we keep track of which packages the RMIDs diff --git
> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ac88610a6946..e1f879e13823 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -93,7 +93,7 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>   * - Our choices on how to configure each resource become progressively =
more
>   *   limited as the number of resources grows.
>   */
> -static int closid_free_map;
> +static unsigned long closid_free_map;
>  static int closid_free_map_len;
>=20
>  int closids_supported(void)
> @@ -119,14 +119,17 @@ static void closid_init(void)
>=20
>  static int closid_alloc(void)
>  {
> -	u32 closid =3D ffs(closid_free_map);
> +	u32 closid;
>=20
> -	if (closid =3D=3D 0)
> -		return -ENOSPC;
> -	closid--;
> -	closid_free_map &=3D ~(1 << closid);
> +	for_each_set_bit(closid, &closid_free_map, closid_free_map_len) {
> +		if (resctrl_closid_is_dirty(closid))
> +			continue;
>=20
> -	return closid;
> +		clear_bit(closid, &closid_free_map);
> +		return closid;
> +	}
> +
> +	return -ENOSPC;
>  }
>=20
>  void closid_free(int closid)
> --
> 2.30.2

Thanks.

-Fenghua
