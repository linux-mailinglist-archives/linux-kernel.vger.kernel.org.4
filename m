Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E752D7270AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFGVoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFGVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:44:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63413E4A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686174242; x=1717710242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aR0DH2sfsEXSUdSPNAHjRH0364GzGC4nCmOqVUpEPBs=;
  b=IMgKsIFxjmOjQNJFJ7vTqTpdLIj7tUTIFs8GYJ2R2P3/0Rr4mjev8/Oy
   OffRJhsW3W+VeT3wDquUsaR0gCqP8e1FIL8XoRDU+b/Ex7jt5/IZquu2E
   evhYOGKo6UT3Vubt4918fAGVozj35S76Y1OdyNdDM6K2P/yK4O4K+jyUc
   VmQGVmuZFUbm9wtqi5DUTL50YHXZ9ydiRSDQJz1t5rFYj7K487Hhin8op
   ZMdSl1grldPaPnR5Rb7VHPztiNEksfAmTPDLulvQYP6aORi5eJLLXIH0c
   nLQgPu82HXlxkwqxKrX6wKHbwuy0JbIH36zAJlS6Di4DymQC7u5mQnpYB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="357128841"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="357128841"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 14:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687136984"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="687136984"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 14:44:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 14:44:00 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 14:44:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 14:44:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 14:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtIp0s6NfsAMTe9VupdI55v84bDjzVKTWE0kA6t2NUWBfNeCd1+JoypfZLeSma+Qjrw7Yb54xpXau87HVNHX7Jz91mbldC4act/WpMCa3B8VdT8A5L+7bzuHhLm/H1Sg+ikfz9g8ZmDApzPaQzWDiAyqts+hXk30kBochQbOe1CROHGjHxTsSYjKvUe0k4iYgLZLViqE8sPy1VQZ8IHJbRS/JOb0rlJsZ9SHnvm+OMqOwE3LJ7pbTA6yE8RcucdhJYFaOD4UywxaqIPfQBytqxkY7hCiU9DrlyxsmJk3v8uSH+nFaCTx5PYuaHFP7pWUzFSesPOeoZQYQmDl9Siq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQ0ErgKdjC2sXl8+8cnMQnVOnIm0MOF579wj6d+t/Gs=;
 b=RJifg3OIjkb/P1RhWFiDqU84AP1uQl4eUQtAS5jswuDI+UNlfeuL4SFm9Khd/fSoq9C5OeGqG5A8MyOH3fczmZaXexf3Dpi+ybLGqNlqZYGO4GpjLK0yaghYyNwp/7PJCiXw/JRZRmX0bXleG8QpoqHySGldWxG7cxVy4BzN/V7LOKmaC7TCl4+iw1tC04wuZzgqQjCApdm/OXZkZ2VsjpJ4UzKThmXbdUBgvrsQhS7b9y8VGwI5xPKxU5bNprSBUbGUUpqaeRtKr2mnvMSMiOYdHX1lHXhXTybecDq3oiI4+Wm6Y8tUHTnzZbgU/9u0lz1jifL603DR1EbBY25BCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 21:43:57 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 21:43:57 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
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
Thread-Index: AQHZjOvilcELal0kyUWRoqbVSrXbL69/9d7Q
Date:   Wed, 7 Jun 2023 21:43:57 +0000
Message-ID: <SJ1PR11MB608367DC5D25856073C86FCFFC53A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
In-Reply-To: <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8447:EE_
x-ms-office365-filtering-correlation-id: 7e847819-97fe-4dbe-a535-08db67a04c2b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8ADv4hHugd2sKF1Pawk1yIWxeDHru3ji0E6YDOQtnejAj9FhhR1tnSAVFGZW9dNBDzfJStIdD3gTczdMsHv8zCX9qGEP587h1WaCI72Axh7YzpM5iWzks2KqMJ6AD9MTEqFe/BRmsSDol2fOcJwBiDFD45GRZVwnrq+kpKH+T9vFvxvQU19FY0FfQd8a2y5B0NVyaWJZmVczGv1rXOYcICCIwnQcgoCKKKnp53RGd2SHUtbj+j+b3hNkhKh2JClAwWFA/XuXRgHZhhkMotp0PwOtnkvZCYA8IdD7KE1YJs2Md+GeqCHmSQXeqcBbf9Yq3AkElVxBYjw4Z3ofvZacD05OfTFF196SFgNUxE4AWavGVrq2finbaRZwN9UqZw2n2iO5saZPDgqI6nGyJTaXeVO6mTLflzJ4nUXJIRZlsOStq6d8rGrIJb+xbeaEnoFcza8Xw5fXsHcr9VC/tkrP68uV1+NHIXhw4yMh8adABI5awSDGXi2LsfznkpB/4TRCLR2CoF5+eQhbbMUFwizlcFLoRKCBxJYhNtBKHQkGBz0Vlgjhla7P0axu1TxEZYlUkZCL8+CTXNLVZzSFc3qGMXH4UxbR/RLFctLjn0TD0BRBpIqIlVUnlEcDF4/By8C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(186003)(26005)(6506007)(9686003)(83380400001)(7416002)(7696005)(71200400001)(2906002)(4744005)(8676002)(8936002)(82960400001)(110136005)(54906003)(478600001)(55016003)(33656002)(38100700002)(122000001)(41300700001)(4326008)(86362001)(5660300002)(38070700005)(64756008)(66446008)(52536014)(66476007)(66556008)(316002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?enkMniU7NgRL3iQz36gBBDv46E8bVZdM6tMF46CLKK0ZLZHwSc4W7m9vzz8E?=
 =?us-ascii?Q?jYV4CyFBXgwOCg1nKRum3t5ZAP/iIEE5e+cANMecNKcFgc0IyswzkmJDG4Kq?=
 =?us-ascii?Q?ffcmQ0w6OzipCOyjHG9hOiPad9qhsTxH4fOvUCAe+0sWGj5KsTPslLgk181w?=
 =?us-ascii?Q?K6bhEwszAXb2tIWijVA9kba2noRzWUf40ImF9va1cYXMawQ9m2enTdAEJEyY?=
 =?us-ascii?Q?eVQPyUsT0ZNNXuz62HJ37w7JpoOSeX+ggdSQ4B9M0OX6WiVAx3vX/goD11yP?=
 =?us-ascii?Q?QP/BETGn6MTow2Fz6IRh6XlL2oioEYBtQFPvU/oSzMINyfGIpXIVPQzE+kI/?=
 =?us-ascii?Q?XwM2yy92ocYWN4S81rGSAjefL/hi3VWj2CK567gZv6YxZdW4jLfawhgP23xq?=
 =?us-ascii?Q?DiLjJlsHWzqUbcO3+aR1oNz8zsFJkFgyLLQofzIJYNFK3cFx44AOice76CsK?=
 =?us-ascii?Q?fSH9VU6l4t8JyZ03xvkFHaTX1AFYWWqkcLSAj3ghBGbd9VAmiRUclC3QE8CB?=
 =?us-ascii?Q?khEU09UylW6DAA0mOJSETdrQ3yW6qI/YWAH7fmcq8DO3zLYQlexoPSC5qRHt?=
 =?us-ascii?Q?dI1Jjz7/pEV36gbisdZq5Q6iRzRvqkfMUne6O3a/uGmp5n7Q2/K1HOhzyvpz?=
 =?us-ascii?Q?219uN3GWEaWqyQGL5kA0/IH8YhY83LQbYczGc7qS3iLv/ll0+DNSRJNxk2Nw?=
 =?us-ascii?Q?DatfyJL0HpB4Fc9t7HXjOg6FcLtvRRlXDO5IsJAE7hgSar17oFT1eQWyoxaY?=
 =?us-ascii?Q?GRYDVxYJVu+qmgfGr4mCGDeuUKMWXJbq56sZj0hCuWS13wTybkFHGowwVIlJ?=
 =?us-ascii?Q?VPLc1IICNeMzzeifdBaP1bcTJehwTnTn2+RpX4Wb/yaSlvFZikuMm+n/CvC+?=
 =?us-ascii?Q?QLPOqVYCTggP8SucdyiYZ6crd5xpDwMSbgX5+JojJ1Anh4FQNJ45IiWAaU4H?=
 =?us-ascii?Q?Reiz0TKVD4HhWRgWA2ivwrGp8PQg+oR2SSlRgQUqOycbpWbiiJAw0KPvVE9P?=
 =?us-ascii?Q?l9i2VPXFejFIpTqwlfuT5caU/MyHKCeaGKJ3Aw/NbDs3fi7Y2PZdhglxybEB?=
 =?us-ascii?Q?ZqjjCzHkaJh+RGEasYfjvJShchtPiZT2IvxDB8oHss3FL8o3J4JmasYEMYri?=
 =?us-ascii?Q?vR7LqV+iFBpJl0QkVbx4r6EBUX1sd9/6gOWjttw3rUW1KnrsFoQWpaphQZO9?=
 =?us-ascii?Q?FdpN8WPrYKF7RJcYU5anG99YLcgkw80/VX8j55mIVExcNSsS0VQyrPdW23C2?=
 =?us-ascii?Q?njK6tLcO7pdEEIz2yyNT4KnaNNbq+KZu+BXgpQX77vs/vWnRm1/R+WloFxGE?=
 =?us-ascii?Q?ck6ivBwrJg8A64TXEBFj5esAIxx+4L//H66n3xdDBrvO1i4i9YP1whpU6eZI?=
 =?us-ascii?Q?OA0zSaN9nQZBhFnSXa8GcMvXKWCvJcbCHju8kEfa3jOZDzFrem/FLGhGLZPx?=
 =?us-ascii?Q?7UPeU0M4MYVYIZ83LH/SnUQyLi6I1uyYIwsP+wYn6V8icSb6erTHltipdmnL?=
 =?us-ascii?Q?W9qG+bxGXoRiJ6aYX5Ax/2lYDTfGTnueOQoyJzZIV8bByvjrb/UZrR4pzngc?=
 =?us-ascii?Q?9xaomb7SYFMbvCSA2b8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e847819-97fe-4dbe-a535-08db67a04c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 21:43:57.2854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8C1k4giPFSO/kcwRWZQav6aevoM1S7tlXF+7OyGqr6Q+Kq79/1evWft9T+4EHv9TttylB/nj41chBd8coeR2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
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

> > Create a non-hybrid PMU setup for Grand Ridge and Sierra Forest.
>
> Moo... Tony, did you sneak product names instead of uarch names in the
> intel-family thing again?
>
> That is; I'm thinking we want the below, no?
>
> -#define INTEL_FAM6_SIERRAFOREST_X    0xAF
> -
> -#define INTEL_FAM6_GRANDRIDGE                0xB6
> +#define INTEL_FAM6_ATOM_CRESTMONT_X  0xAF /* Sierra Forest */
> +#define INTEL_FAM6_ATOM_CRESTMONT    0xB6 /* Grand Ridge */

I don't think that's really any more helpful.

Using the code name of the model makes it easy to look things
up in ark.intel.com. Using the "core" name doesn't even work for
hybrid CPU models which have more than one core type.
So I'd like to keep it as it is.

But if you want to change to the core name, then please just
do it now.

There are folks internally worried that all upstream work for
these two CPU models is going to be blocked while this
is discussed.

-Tony
