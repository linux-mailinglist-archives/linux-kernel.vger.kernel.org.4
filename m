Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47763651730
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiLTAc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiLTAc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:32:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B362BF4;
        Mon, 19 Dec 2022 16:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671496345; x=1703032345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R/uzphavhSQSIWbzG/xCwndY98KJlisNd7cfXoLPDsM=;
  b=Od8sjl20FCAorZd4HtRPxnDHuOF+57jpkaaKaOgQCjjtGiRuZKF6kQ4l
   Fzp/ZXxBVjJoHHKtV8/VW7AQSqq1zuTjQ6pabAyLdPt/Za3eS7oDEEV4L
   4r7gO7ak1epIYcCgCjBZCX+XoT725SLO5gYXRC6fhpdfbywzL+h3StCWA
   VPb0huDYM/AaWLYv1oojyqtMya9Kd+dQMyKwKZmJ7oytWu8mXWBiiWjg6
   YjSDQppbGftdtK6iokOWiWMAC7df/yAea2dLh/D18MMTlftWUfLHNItJn
   J//c6xvt7BwjzeOWl6Ciudh+Nta9gLS88LQPPrXDteXGX81UDRxjxUd7/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="318184534"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="318184534"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 16:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="681438047"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="681438047"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2022 16:32:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 19 Dec 2022 16:32:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 19 Dec 2022 16:32:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 19 Dec 2022 16:32:21 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 19 Dec 2022 16:32:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuaPsrHyXJTww4bSa0HRfStsBH/k1vLZVP0rMM/JTghUDHVP8Cd/BnEvC5g/05/IcZPcR7hon/dEf6SpcBUMWO5rZyqobAaOX4veRmkSkZftmsxRB0jpNOfNqiNwKWGAOrKbQ6ZiOoK4mfZWB76HBrplY+hShLVNV1q2c6vzAgHrUqKC9KD6IN9iHmS8Gou/qFayJPcaWKx5fVY15mSuViycR63KJvAo0uCHd7P3xBMw5yihB/sRbtGIfq0l6Hph0aRuJrn03aa1hT5kZCyQ7LNHSgGhdj0pqMkzi60S0P9oVfBV7DvhBPwj/btaIstBxD6KykByzt2Jm2UQDLaGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfaG6e23xBBvby/iFzIe2ycTLeK1oJiAoh9nbgjYfWw=;
 b=XlB0GP7sPyfIahGzMTV2WtYHIjPLU4kw5mOZg6RhTyDCLPz7ycjqlj8781eC2BDQzBO5vkrxc9fpCXIyD7J5+YqohTyXdciBKUSL1ByINVpkwY8IW0NtYGxc7K84wG1zHWHaV5fRTizN80bgo8wdzFtino9JGuUXUKeYkIva7CYLFO1WL811DlexILe3Thajp35aUpRAE3pk2bWGnJHVh3ymnmmsSsMbcxssC0C3TO8hP827LfPC1PhMBUfcgG4ewklf/E89LSs5isWCeN8eYnh85XgRIqQ/KtG95tiTKD+zk/60h+MYHzYnOA3le4D4nqJzJ+KiksDIXlN7GhUKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB6293.namprd11.prod.outlook.com
 (2603:10b6:8:97::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 00:32:18 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 00:32:18 +0000
Date:   Mon, 19 Dec 2022 16:32:15 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <mcgrof@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl_test: require 64-bit
Message-ID: <63a1028fdbbb0_1bf229419@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221219195050.325959-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221219195050.325959-1-mcgrof@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DS7PR11MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 92de9ade-2a31-48a9-b8fb-08dae221a6b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJ9dQh7GxgL8G3iF2B3gTT6qPJH7yc7BmqH+NXf6EdX0xbQ/gYela3Lfz5lgFN4cfqhbkH2JvXkLv5vanuOqfTRZQekOUpbvNTgYNzXMpKdo8NrWOJaRfWUIWfyQMAqwtfT+baete6y22rTBXqE3fNWI+mUkEZT9Z+G7gtY0LmbKI3iZTHCsN7MFylcymEDtUMiXi7hXBQiFGaGtLMuOt1aITavGGNMMThPFKiYvz6a+izfk0gK2rUv/HUIPzvyaB2+FL8g6kYG07XRF8WQueozqBAx/nkkQ1hQTvnl1BPVcq7i8i8VTRcOI+HwlI5W/dM2hj6bxAtdpAZppxtYdASz/q5stbmVbQwft/ruwNf1eHs3aP+2LOgjfvvgtzI/nB9NUOTNtHyOa9sWeuR1xpd7mXqhlCu6Y+q9U7ZljhUgPfn3BFSkI9mRT/PAADrEDb+dVR9CMwrFQSGW9H4vuLhZ5I0dGlJb/QOuLAj5gxChcXLMwoui6hD0oz05Dr5Kv0d9VhuQpRLfAA2Khg6w597SXZGJZ0f14oMMU3UL/A5UpyPaVBs6oRHq8dZxLmm6dNtlFeI0Y5H74j1qzhhF9iKwk0DIn6hb/keBofUqTqsdqbVn6cbeEo3VX68IBaOP8kvXL7BOSyFExT8+zTjagnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(8936002)(66556008)(66946007)(41300700001)(66476007)(8676002)(4326008)(83380400001)(316002)(82960400001)(38100700002)(4744005)(5660300002)(86362001)(2906002)(6486002)(478600001)(26005)(186003)(6512007)(6666004)(6506007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHMTJXbU3fIPEhNYsp/zduaPb+q3YZuspllBWz14zGJXXDqrvBcD2qqmc67y?=
 =?us-ascii?Q?4z0T9XQhdC78dKMPRWaGn+YyQcuzdi1Dlchxj57d29uG1GOLV1zCT4okBC84?=
 =?us-ascii?Q?WvkcL10//q2U1Ku+lVhvVNqlxBJ7zifvmOtrnM79wbTtqPYC2Y6/q6Ys/b1s?=
 =?us-ascii?Q?p6JXkLO6k0kOXAk4Rzl05Adjsvu7ipuw8gTOlrmQ1lYAxuDNGWzXYDVJC0XY?=
 =?us-ascii?Q?C89QinwQnGDV6agJLdtpcoq2rDpdjX5D5e3gLvLm+Q9d02gGNRwp4JXMArCs?=
 =?us-ascii?Q?rG7T/Z+IEV6Had19+ynvLZRO53jXq1d7Xmc6znY48B/TwOOATcjCAuxbTeJM?=
 =?us-ascii?Q?9pMlp/xF7Z7DSRBaIIyg4WwiK4uNmjsXSaBZKg3/w8S5UnnzcLx0p6bp6pap?=
 =?us-ascii?Q?ut0yc5S6BZWM9Wcqb/dkvgE2z2UB27/Mo5S6lGeoBTTZfDJEIKWH2XlcQUgs?=
 =?us-ascii?Q?nq0Tg7oIIAHXE3FaRw9HJch5E9YZr0AyxwyayNO7kHOcqS9MccLxDQlwGxwq?=
 =?us-ascii?Q?y/cXnWqn9bxNNaK5hXdhS0KEI8zWTffSyJDICuPIj6jxR6CSt1JOJIfyZG7b?=
 =?us-ascii?Q?LcsWKBqwL1tVmgwwcG73e93vPShyWesFjK5XAJ0lYRmf2kkQWcXPN4HDfXNp?=
 =?us-ascii?Q?LBT0ETEtaLvDi0FzK9qqtrUOTPRR99yF1qm5pLYbGh9MxfB5r+N3z1b8qbnD?=
 =?us-ascii?Q?qOl0ejZnKWKkS41w6bAAAJR2oyDkR3Lbqt5SOWXsbtQbkrLvq5h0FzJSy48Q?=
 =?us-ascii?Q?prGS9DLxa91wvzmjVbCgqDFzB0dQTD/MM3l3JKq2DbA45NeSEjBVNWKRGvlW?=
 =?us-ascii?Q?9S6/NTSer7fCVCE2fHbIxK1EeAp/M0iF9SJy3GME7CWZWyGKdllOwUZtLHF9?=
 =?us-ascii?Q?+swinXOLEUMaXAG+thXVX21hKPx76RKuKeK1AmwTVoNZcaPIzHhwD/KYGq/d?=
 =?us-ascii?Q?HP5ZaSrvXb9jfx/FJb7aRYc0yaXW4ylmI8c4UUEsmbisI2AU2flBZrELXuRP?=
 =?us-ascii?Q?eLuoow2MJvFIzUIO+lvqo7N0rmbxzsaRN74xEsF6nwj7heBXolCM7xYPnG9b?=
 =?us-ascii?Q?SuXXZr9miZ5CiI024QMWW5a/PKvF4jUfhflGOcOUuSArf0nWCRwo4RT+r4Dn?=
 =?us-ascii?Q?WIJP8jrg6IqtM1oetWBPEvgC2r5gMEHYgBrwJ/CbmxHLlALTpnhRPlsiLVf0?=
 =?us-ascii?Q?tzzGTd7pN5TONXpl9iT/LrRx49tcmnAEN6IGu0+s+gz8gxwvCpGXycyhe84e?=
 =?us-ascii?Q?Kg3fQHl0hjm9VLj9bL9znU2en3PU9yC1CgVYaDrHzTT9sWs1EeaAkiwe7FtM?=
 =?us-ascii?Q?H9Mjl3zjzEYAQPb+eCADFZ5JOWDIk+bnVXBEMeD2EjvdWVgoXwJYHNLefixp?=
 =?us-ascii?Q?x9C4uiFZ6H4Xe3SPlKjOPQJ8o23bWVhUR2TASw/GuDHxCwTG4E97+4a6Ci5n?=
 =?us-ascii?Q?eCikf3lTUqbfDXA03k5CNzPKqqSipZGLvRcvPMDAaZ9Hw3ezXn670obeOdON?=
 =?us-ascii?Q?+VLujQkY+RSiXLsrDD0KX/j/aJzmUbYLdLC/6rTkf9ShhXcaJeg0iGjq+D4Y?=
 =?us-ascii?Q?++w/MxcjF7fd8YHLPFnes7efyVUffnvBceZYG+KRyc2kPOqKTk08zw6v6MuX?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92de9ade-2a31-48a9-b8fb-08dae221a6b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 00:32:18.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6n89WrVmDW0Zs1qzbbu0Pc1Qdula+SjA5n8qN54W4N0//KDOc+QOnYD79I8SQgE5f20IlJe3afiUaMfXZ1Z7GKzBWr5Ct5lyeY9qC74MlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> size_t is limited to 32-bits and so the gen_pool_alloc() using
> the size of SZ_64G would map to 0, triggering a low allocation
> which is not expected. Force the dependency on 64-bit for cxl_test
> as that is what it was designed for.
> 
> This issue was found by build test reports when converting this
> driver as a proper upstream driver.

Looks good to me, changed the subject to tools/testing/cxl/ and applied for 6.3.
