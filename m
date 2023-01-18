Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704E467238D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjARQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjARQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:37:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4004941B5F;
        Wed, 18 Jan 2023 08:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674059861; x=1705595861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qF/D9r3OR/eftaZO6Gfh65ZN8l2WCSpiFYobCHvIkYs=;
  b=C5AlqfPuaM3A6Z0ueR2zA458pPYdJM3FEkqCu1SzqQyc4zTUsN6bM4fW
   Z9GKLSOoZgKZhjPX7Qisaq3MnmRbcIPhCsmWD8iqQISsRUyNlv/u48/zx
   P7g4cN3k7XqjbXl6M+uNPHL8267Ka2WsR5Wj0+7Sd26m/J2ug2pncXwJt
   3rr4CfxdXb79xlUTw3DC+t+4k5OmaM9dNqY0m4iTORzHGKfPDgLLWdTvI
   qEE7ZH50W7xTzoAVxzFiZlee9mqDDf1oLERJz0hX5KGwjt+roS89MSFor
   WulwjznK3OUDZ/rvDUp9YfSP1N/zJOcJGMG/gSJdwdUHQDjJ30hLJJBYH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411264805"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="411264805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 08:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="802255575"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="802255575"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2023 08:37:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 08:37:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 08:37:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 08:37:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 08:37:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGfvjTJ7Lllj3m3PUmMFd4x4Ohtd7d9SDXnMl2ygLu2v4Ad+EoIOS2zRZl2ol6JNNItzHrjgzD41wksXt1ytVQiOza1w7jqX60I5rJK9aub1HwUEUQ31kCk0qS1rigP7SL/8aMKQPUIaC1d8gph+T8e7oQLMAFAmFcHcIvpPltVG2fp2/FF7+U1ddbxVUATGOgWySsSDOMjknYlrZhlQaXZ5ud/URYZ3r1nyuN83Xym3mCoTVqhvADk3351hO395XevnP+H147Ap/eTxznMPV9hw8NMwB4KPAKtfsNalXBJUvUGLREQ4prMuLPSYFA0L+kMfccN8RWrRHgU0X6kwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF/D9r3OR/eftaZO6Gfh65ZN8l2WCSpiFYobCHvIkYs=;
 b=Kg8iTdBBkLqoFRiz6AF/RiAYk6zgtIUQ/6Ez6IyVoR8W6yPsRVD/XReH5P7OejwA+gY2XQBogOWk1MrEGCumlsFskjYsoYnVt2Ut3AIGpEKpnKoiyNeWTmqFuzTnvapA+3sJ0p7xlSh3hTVwwjH8sCg4EmW9f5PAzSzW/fFGf2Nhp0k9yiMzXFzPKtysoECiFIisMjb0VKcg9FHxILIjziHUvnDKUa6NB8cGwCaTk5S5uImWgWwEOG59bXeqYIhCZpHZquUmgEy3s6KKYiJly7Vf0ooMTXb4BRJCpfMiEvuqUC8OjY0k3eQ2KcujbQw6RpZiuLP6u7GnII+cIhc35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 16:37:36 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%8]) with mapi id 15.20.5986.021; Wed, 18 Jan 2023
 16:37:36 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH] ACPI: APEI: EINJ: Limit error type to 32-bit width
Thread-Topic: [PATCH] ACPI: APEI: EINJ: Limit error type to 32-bit width
Thread-Index: AQHZKwcM54vHI8eAJkCF201Kg9CrSa6kX+dQ
Date:   Wed, 18 Jan 2023 16:37:36 +0000
Message-ID: <SJ1PR11MB60831C602B33D51DC6E604E6FCC79@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230118063504.58026-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20230118063504.58026-1-xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7418:EE_
x-ms-office365-filtering-correlation-id: 0088bf54-da98-41ac-0140-08daf9724e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Gfnd+I3XXtOMbcfBXOmMw5yBhbXWm4IEDgltEUpV1lh/OiQTc8occTgN109nDaZe5+0DlIKMo92H8oPEA5pwGn04NEVWWXaMIB46BF5Mel6TEBKubnQyCp6fa0vLjcK6TKLpMllHkVcBsQvMpjl3lqOP/Y50amYawQWRB0OFjIjLBmZKYERZcw0WJi71u8w4g6V/jl8vyumrcnMmxJ3RwAK3UcUwuK+og6NO7YqjBwGLzSbN6p1Pm80Z7zT0ahWCD2lXgcvIleEKyco4y1D7H6lJhQ/RMswtV6IqxQo4vI4gL7Nlu+xMdM0YCxRrJ1YoyehopLW33RebQAlJYkpsnK9ZK/aAvtDntpaVcRACRVDOzMrfdpZ2B7BQoEJ1z8O5HWalv+osDNe4VWOBCif5BZupPpM2K/qFPwSwxCi+E+xNHyLw38P5t1zMm4bHTwiDeAQoTolml7bjNwtM0rKH3Wh6ls2dfhYufaNX6ICp0prgXVFS+xLH5Efof6z1wALIIGM0pnEC7CD/c3lFgJQmohrIehC9UWVyI+vB6tgk1LycgLzaAve5zJ1W/e34IPqksz5PIr7m3arX0Z1H4jvoFAH2xI0u8CYc3mSji6NxfnG8Bug5v24pafKGdWp4pUoNQneSxEalT1402WJ1eRYVBDW+XSkqdnjT2MtDUvhpy1na5qqqc9/ygzLv0YMnQ6lRKO3VbnlqnaByfMqibBAaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199015)(71200400001)(54906003)(110136005)(7696005)(4326008)(66556008)(9686003)(186003)(76116006)(66446008)(66476007)(64756008)(66946007)(478600001)(26005)(8676002)(52536014)(8936002)(5660300002)(2906002)(7416002)(41300700001)(6506007)(316002)(122000001)(82960400001)(33656002)(558084003)(38070700005)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lx34H5CYFoEa08rnRSMO69/UqbKqQIS32aigBQBqqnWH7+NM2ZNYCSSLo+/d?=
 =?us-ascii?Q?9GG3LSlhrzjYRVtQqpkpizWwcNBsTB9v1VJv/KWgkwu3+qZXsEsaJwgPifPN?=
 =?us-ascii?Q?Jy7tFBv2ShEwuUV32Dm2W4z/MsSqDX7g7P+GwhauXPfUxxZeYEeA/fAVpOe6?=
 =?us-ascii?Q?wNY1BDQ8mAhrwwEoQh/FJG7XK/5znxu2Kw8HSxPQReIyN4pEbBpwNzi6X2Vt?=
 =?us-ascii?Q?o0faUhwakhoAi2isQHXtOC+10A+JM18qpZWTKct9iQFef3IXEW+DGvwPd+S2?=
 =?us-ascii?Q?nnbxzQ51tu2qS3BOggETDghmw73/GrGJ506yVLc21RSe/jFq5ABrKvVlXz4q?=
 =?us-ascii?Q?45PUnaCAf3QFBxWUYMoQTXiHof/1DJtzHPImdw0cw77EnCznjqqgETPzyss/?=
 =?us-ascii?Q?lHVwDvvU2L/7OwsICh9mKqBWrWnbOLFYeq8+kM3vOgA4gWsjJFWJDmelpd19?=
 =?us-ascii?Q?t0UmIPcwUVqkiz3FmC15TvcmC+JNizuXR+yKaY7KfqI29s9b4SedepfXmz9O?=
 =?us-ascii?Q?WEwIk4LOgLVOIopTe5ZimPX9KIESwH6I/tZMifM1xqxi+kDSSxJmBh68+JWU?=
 =?us-ascii?Q?iv/Dq3Wk+VwF8wD3qz3u6KFLCtN/Sw3zube7KeI+E2dnAen59lY/sNrliP1A?=
 =?us-ascii?Q?hwCdwN6u7c41bfLMbyrhHw6OEEdY8j4/jSizBl1WrtJe+eb3OiFfLHT8Eu18?=
 =?us-ascii?Q?PPB9cm0GILrgT0OTcokwHq1FeXsu/UB2uiDyTsaVNTsVM5eib81y2PyQqKhu?=
 =?us-ascii?Q?WwM+XUXLhn4IPktrlVgeTwARsTEtflPgObMenIKPvawd6CyiwhIZ7oX8rk1w?=
 =?us-ascii?Q?FrCl5H+YHEfr3ISvmVr+6EsUn7PntG5+afrWIa3zK2sUr1bt3biQfYIetAqu?=
 =?us-ascii?Q?BOhhG2/sEnzLLb0Bhj7GQK9vHSRaDa/afZzbq01fOiMSw/OmXjqcoSRL2+eY?=
 =?us-ascii?Q?y5oy8mPrSUU380/mvydIiknK8DNAMUUBZArUXnkvCn8mQ+CWOYb0PczHOkp6?=
 =?us-ascii?Q?DpJmtu0UV6KbBjHyKsu6ftLe89YZOl7km/qt0F7Ra6+Yg/m7Nu0/ueRMdL02?=
 =?us-ascii?Q?uILzKPJDD/Uj7loES0rVuYdTq/1Nio+CFnuB3VB0two+aUgXFBhV5HjjqZGO?=
 =?us-ascii?Q?/u/hg+hcsHqNNcOC/E57xw/itNFE0qwu/uTuhdxUzLVFv62x/Ka+ro5sWcgb?=
 =?us-ascii?Q?wysC9eo0WE9Ve/eAMgnLAuB6b7YOOI0LDBbOs1/33GK1RB31mJy/pahZcEnt?=
 =?us-ascii?Q?x8Kh06vxa38mO1gmeBC8oKSL7XTzNVR4SWd2mgw/E0uAjVWsik0KbXSZX7my?=
 =?us-ascii?Q?Mxfh+qg8O+Eq4gXDHg1JbP7sYPg2Nx5suk/uzfm4d13YkIpAVhAZFomzcAKx?=
 =?us-ascii?Q?ufx7FnOy63sgyq6688LCg5LxykzHXfVHPz1NmfXgw3+7gE1aXHdEZHHFJRZk?=
 =?us-ascii?Q?5XJKiMy8sXc0Js+AQ0iaFehkcfoWDhmJ1KlDZYOFnkM4KYj1XqcHBftOXp3X?=
 =?us-ascii?Q?SLmqGM4HNjUUQfzEomuigwcWY9bmL+wBv6lom9TiP3d8vaGoCx+YD+HynG9O?=
 =?us-ascii?Q?MFHsqoy+vt39YRQMhphlpWz4gxMiN+J5mjpyR+MI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0088bf54-da98-41ac-0140-08daf9724e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 16:37:36.3272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 926AQsfzrFCUADwuVOXWC5LzDLd9MuohBwXcpphrfAEYWWXRi1pHV6Tu5hqmpd/7tzmxqri3UQCzy5tcboY0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The bit map of error types to inject is 32-bit width[1]. Add parameter
> check to reflect the fact.
>
> [1] ACPI Specification 6.4, Section 18.6.4. Error Types
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

