Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE587284B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjFHQUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjFHQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:20:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E8D193
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686241228; x=1717777228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c0Fiiq8Cl9E03VMKBvQ/tljIKNYXXnNiWWG+1SVxNjY=;
  b=IuF+9Mqv72GX505e1J0s8DAqvOfaib4T1a0wvjGyom4nTJu/SA8gQjVI
   ZSwl+r5ftd/pZf2oZfAnRPdDfn2iZQGO+L0eRm9E2uNlp/v5DM6l/+iUz
   FgoxIAlaGLc7rCbbFuJqqIsd8fnxpDMSsOLyPHPgTsuES2HrHV0Q9BpXi
   d95Nodv/gL4EaADzm0NA7TufO9sYbQJ4zVY3CZB6SJct8xxWyIHsI1lnv
   QlHbKpCXZ2FD8wDH2Emq7ALKc2Xi2qwG/JuI5oxzSywXV2yovAywPc7Nh
   VaEHeAFc1mnXwoDKh7sArAw8tgRUDdj2UEzKW8jJFfoO/VV6UOhMQLmF0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337712115"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="337712115"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 09:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="687418986"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="687418986"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2023 09:20:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 09:20:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 09:20:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 09:20:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 09:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAithOHFvx7sH3miko2OzWpVPxy601n09paBo/UpTS8UziLjxhx3N2fXYi4RusWc9PzGdJkQd5Mr9J8NhtYyfH1GlswFYOHmRcC68+IoCygUgpL/FX89ro9sR2K80FDU8SMahKg8pUd2ZgyI7G21/ymCibW0Q2SgbgXrJ2s18w6xWVylTBM2l9qzY1DyM0lpUtU0BxaiT6XlIRa54GycKcMh3FJ/MiAXkAGVc1SlmVKMClC3BK+6OADrG58mBKPXc05NETPtfMmQe3HJ/cUZ10CHg+AJyW0NYD/NdJHKG7CIg8egSfpqmre+/oDmsTuVZUljYEUCaapfBZs2C5RiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAqdHLQv9GpvZCgwby1Hd52kwebuMls6benPye1Th28=;
 b=jkrVaxmmUQDEKBYuNL4LNwvzgSB3o9/XmAeq6FPb66zIZI76bc3oneUWbC7+sOBpYxz2522LSOSDM9NJGH08geW6dAJcpwinNXdn7wZl0yWvfRGKCPknguE8jLlFXk1mKPJ+AnVe4Byhnrl+isxq1tKtqRrUKJBtns4SCCF8OtgCXH/Zuggtq9RlaZ1QivI+UmZWmTC8bQj7gUoY1cxV8CxR5qyf5NRubiLbF8ia7RxzNmhfpLw14XBSUB+Gio/jACwHgPHP1OBhQSKL8BYq4a7DbCbiDrQFhjVk3VHjWD5loCrzzwdkYF3SoNLpZcAAgSXxeBaS5VLtyCtfbg1eBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7259.namprd11.prod.outlook.com (2603:10b6:208:43c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 16:20:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 16:20:22 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "alexey.v.bayduraev@linux.intel.com" 
        <alexey.v.bayduraev@linux.intel.com>,
        "Zhang, Tinghao" <tinghao.zhang@intel.com>
Subject: RE: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Thread-Topic: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Thread-Index: AQHZjOvilcELal0kyUWRoqbVSrXbL69/9d7QgACkxQCAAI7l0A==
Date:   Thu, 8 Jun 2023 16:20:22 +0000
Message-ID: <SJ1PR11MB608366EC800DBE389EE75E0CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
 <SJ1PR11MB608367DC5D25856073C86FCFFC53A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230608072420.GB998233@hirez.programming.kicks-ass.net>
In-Reply-To: <20230608072420.GB998233@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7259:EE_
x-ms-office365-filtering-correlation-id: 6a9cdf2d-a40a-48d5-baba-08db683c429c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +scySoyFXXJ6B6uasxq4rIc1mBQKenF27qkBbGQtHbMQ9nxBf+1ipc31mm1ON3GZ9jeQaCdcFGa+jbWbWTxp8dHD7+5hwtXV6rTS4XOBJLeErLTjPr5yLieJOofs+ECULaLNloA3Sl82UuLK/0Sr5DXKnaqZzV+Gfnr6lDpq81Ok4/jZQuv3rKVznuPCPy5trhmnoET+G5jAw1JzvLIbSGMmlqnd9kYvMMSy/bs3L33ObGnPiZr7MNh1F1mvJYHXmvyVM/KDA6+HdEPbctSL8PuR6iyDwatdwwq9XdLut4y8QhkdCvQOO2URuBeV/gIxI18kepDMzohYeA+xKSxE2EGaoncJrIUY9UWugGmvnNoAftcIIoa4Mh+DZWFriQI1fbjiFPB097HX+FMegnwZ/ZnMOUiBr6MmTHuYYKDzBRYP3fR2lGTTe92MrEkXchEPLUiQv1OwtXqEmNmpXmntEzdAfTbql1+3TZ3c2Izs764JfvIhw41ByiEtmoi+YF5VOyRbFoWAnxyYSNCCs6Ij8FDlzfvSMwzNfdky1qGSm5KbLP1P1hrDFlfLDliLwxVZrepm6uH1KWhHK2p05AfuCS0SJBu0FLYfhUTQ1ErVzlPVNgPqHEnW7PQH5FF/Jjt5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(71200400001)(7696005)(4744005)(82960400001)(66946007)(2906002)(66446008)(76116006)(122000001)(66556008)(66476007)(54906003)(7416002)(52536014)(8676002)(38070700005)(86362001)(5660300002)(38100700002)(8936002)(33656002)(6916009)(316002)(4326008)(478600001)(55016003)(41300700001)(64756008)(26005)(6506007)(9686003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CCxRR5aIVzSII0MVGM5q3Lmc9F3F7p0xRkib2bpThPyaxFvN6w6uBQ2cSVTB?=
 =?us-ascii?Q?ulLnJtEGYPic84HTqiIFdg4SyFAm2kAQSMPpyiTILDVmPKIyUQgu4GSo3+nA?=
 =?us-ascii?Q?x957kL/zhqyBypVY6vN9CWMj9HUSsLCZQXc2sxRZ9p7iJFhxfYFcpwwJvURy?=
 =?us-ascii?Q?cKFYTcXlPO48c1ka9GoZskaJVeugokwQp61Db7EJKUukfQgzndGItAkFCuh/?=
 =?us-ascii?Q?9a39Dv1Ux1WuYFsNAABT4g47QSailJP8sZZiM/eND081OkdPuwSc+wqg6dyL?=
 =?us-ascii?Q?aglcnEAZkzemmZAgWJ38YPnnhvLTeTjgrlH5vZw51VaFBJLJATPPHIoQk2/L?=
 =?us-ascii?Q?Mfiuob5zXaF9XFwLq14dnY4eP2ybj6Dg/wzy3nqk1lWXbSfj53hLltcXJp8F?=
 =?us-ascii?Q?sO6VnwNoAWvtNPSEKDak2htBdbGqKCW7SKQrjY9IO1uf3rVK0Lr4KDVAOwcM?=
 =?us-ascii?Q?QYPQUL5BbdCfGTPR6Nv9c1CNtL23i9PGx4tkMUxXJDQ+PhI+ZsrP6cZfvsVd?=
 =?us-ascii?Q?JujUdaZZypRC8YXQHY283IsboK6jTKmHzkyjD1Ons4bTWyOXKt/33DBDQbId?=
 =?us-ascii?Q?Sn+FAQW+NtIskmnSHaQdfT+XiIC2afjEYA7G+kuGvr8VrVb+YBI9etuedqzS?=
 =?us-ascii?Q?Km8eotd2k72bcV18VrLzM81GDLX6g/xwDrmYQ5FW0cQLWQOPnzyh/Z8XL4nY?=
 =?us-ascii?Q?yb4FEQZ7Mw2sgIks0ZlOhhnCqKAynpVzuHSwpeFUBun8s2roCczTtJqcWET0?=
 =?us-ascii?Q?qPyfIB6pY+poV6nVpQF/SsA3B0HdzxGe48IHQFjYJYiLczf/W2JF9cKooc9r?=
 =?us-ascii?Q?Ut2JBwpF2TC2lowK27Ywve2XF8/zOkEcwvBgOA7jQnV2kYDfqxHyXqrLy19q?=
 =?us-ascii?Q?eMnszzdUPFM9W56FTP983ec0m5KygsuXA4mwoVItfuOINcbUUmSfAe18F4td?=
 =?us-ascii?Q?EyNENkx7dZcAxVHDMlBceLA4iBQ2omKpS+Np4/KAuhvV8qGki5pEn6k5MnrM?=
 =?us-ascii?Q?RqR47RfNeIKNSFGTizZOuvn1jqmHOkmok/KbBBstaNHmCFXaX/XPJ/ZTuvhI?=
 =?us-ascii?Q?lBW/OlGrAuAcji54sm3TbS8RzXdWT07z7dMk5u7zwh8HnCuv5YzU9+SlEfUj?=
 =?us-ascii?Q?4CZeLH9ua+VKOcayRVbfORJM0sOyCtRlHeVyZW+WfaYavY9pK1ngPJUFQYA7?=
 =?us-ascii?Q?6QvRhB7AeEJuCmrz82/wTwv71Ozw/IMw/vgmpcaXkEDIDGoryHp5XDTgeLiz?=
 =?us-ascii?Q?C7BhQdH+z8V0tJyHx0Ao578N9Kz/+37q6Iv3j9sFPBLzPOAd/IKxv6Pm9uyf?=
 =?us-ascii?Q?OoxKdfm1o0TnW312XvPxR8jHjP4d8wWAq4VoGAWAsL59odgUCmzqNqdqY36U?=
 =?us-ascii?Q?Csn4mH+TZdwDTJ/Jx2Kpt3AFoC1D8V0HjaWEFjgraPS7h0/einouYjOMhyk3?=
 =?us-ascii?Q?0CjmixEAOBAprMQhxnewJTpi1ldqDwMhM690vV8eOFAlFxPPLYIJIIeZdgkM?=
 =?us-ascii?Q?QokvSJF0gcO0enr0EN4qnvPLLuITDdZDy8oOMQANgO0gXQXseRlnptsBX7Tx?=
 =?us-ascii?Q?DtCPJ3/CQJe6MdcWH7Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9cdf2d-a40a-48d5-baba-08db683c429c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 16:20:22.7611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w26ok2YbqvpYEQbYJsKbwMgXps1sK3IN0zDy96P/KOI15EmElBSazvAkGgC8131jICf3S9bIatqBzlawUJng7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7259
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

> Then I'm hoping their take-away is that random gibberish names don't
> help anybody. The whole Intel naming scheme is impenetrable crap.

> > +#define INTEL_FAM6_ATOM_CRESTMONT_X  0xAF /* Sierra Forest */
> > +#define INTEL_FAM6_ATOM_CRESTMONT    0xB6 /* Grand Ridge */

This just adds another layer of confusion. Sure, these two models are based
on the same core. But giving the illusion that they are somehow the same wi=
ll
lead to tears before bedtime:

1) They each took a snapshot of that core design on different dates, so the=
re
   are logic differences.
2) Feature fuses will be different
3) Microcode will be different
4) BIOS will be different
5) "uncore" is different, so anything implemented outside of the core
    will be different.

-Tony


