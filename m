Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6F366E32A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjAQQMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjAQQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:12:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96DA3D089
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673971945; x=1705507945;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TGe/1TbmEzKdULTaoCwsJmlGcxxOMbu9Ve0m0Ilwcac=;
  b=Nz9psQgjgt+eoYwDCg+60LF7j4EBTgjxp/dt6ktCB6OIyPFt3kbaswk+
   XeXmmWFrgv9o98/DUT8FS1A6l1xumGqHH8T7SO1JnT/3Ajb37lbxVtNQA
   iYp7fdpVaE5pXDBUJ5wr1yGbyQlE9kv7eQ0VqiSPpOUI7JE8Y6p5JumDr
   R458MC3so0hH66dUzs6UxyleqcPYnKZTbgHgauWEc44WjSmq0JE1DNfi4
   jPnGWePO8UMuUnLojwkQsPCoh+bSDu8pnPnaJro2uocQ/yChslFs30Wye
   Vi28nvdDble0WmZMG6+J3ZQDC2nr43EhhLzaNnsb9LePBA2bddyIJbvbb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324787311"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="324787311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:12:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="661338982"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="661338982"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jan 2023 08:12:24 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 08:12:24 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 08:12:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 08:12:23 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 08:12:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STxqN0FtOWPmyoOKXnMUYOq91aJkT3Wlq0wV2XYwomg54/EPLeq73lOr4orZ10dwi2Q5IFnjq4V0w6BpuO6yKUsa9tkMQibdsnCacqfe8QKNYSKnVAoK36PaS9/HzuZ25cEnNHKvnO2YM232azvugLpDPRYOJBKcX4R6ErRUg3k2ZUDoWMVFpZdbaOWTToED/nvsKkgr7Ub1y5JwkKyVZi+hHthpNw0ENrEJ414anFfBOR/SHxsDXL20GXXz3Al5z24Wa+s/YnuYyqIPoizIY3xkGTdluiWqbyQrISCrzbrBj4PXT+Hs1tGtiCxqzQVMgaZFdRehNoed3/qR2eZvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge2Zt3sCJhpEb/iZDnSAZpfXcUPdw0cM+VCpoqO2lyY=;
 b=ahJS8WAs+SNoXUcGis5YPEFONIHJ66tKGEYG9g7EjrkzfhzSE0xCXGriIq1H1yGnMokF9TFlmgjcFV8MnP5pH6L9ficmwNsp9+dIXG1yqv8rDX3yPvpXV+OVbWkjtD8mxqzKR+SkycnqSoYGq+1F4hPKN9JKUVI3eyTangVjMuvulz+AMsadASN5SbqDAio61NTWob4gEi68elrpor5109jIjq+tvfZtNbd6B2iECNmw0ZRM0fH8x34c68GBRz5Ri2Nn35iLk+CrxqlFi/BoZ9lH13j4ujVKP+97ihFbxOmhdGO90+/CnmwQF5t5gNmg1qYpcA+TawkJOGzGH4UYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 16:12:20 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 16:12:20 +0000
Date:   Tue, 17 Jan 2023 08:12:16 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8ROaoJtUtj5bPcx@zn.tnic>
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SA1PR11MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: d98757e4-ed10-4bce-7879-08daf8a59bfb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f54G33ewuq1xeivw9Yte/ijEevpWXcQDvLRr8sv3WRUTjk0H8dpp6dV+cm1WR7okRXNnySCFOtWewAy4qKdVzv0gEJ8jksIaOiWP/CvPD3WJcIKI52pbIT1gouiO1N+dfxO+k6x8QyrWyrBqdjEHHm3peNc4SVCNWxk1C4RqkiZZl2GAJHBBTUGiNxIAeNVlSa6dAS/Cbl2J6rlISu/4Po6SkciL844zETelNq0UVvVEM2g9T2H5rqn/Km8BM/pYxxr5tBpDykIomsDOhKsvY8Uw8HZAD55mhPY0UsrcT019hp1Ue0uH7I0qECrAauz75hV14jvo1Vx2BP2fc9v7XpyXifbEj5YPZfLt0j3+/15y6LbPU8ZKATMinhb279NgcSTAGdWz4nZqRP39UGopcasoSkGeFT31aYIQtM8L5sCxxWA+kYfpqeWa4u0B68qY5n9UW06aFtQHc1Mx+6XQ4/BExFfrIsdfsunOPBwaJrq0nDICLzijNSXn34ea5UyoU9Pum/cb7hK/oVv8t6/wh1f44OodJkdF+jijP18WkxCbbU7OI3GMengssfa6OhZ7XI79lpPfLgIjgBfbsfbJZ2qtg/RHDEITYKl41LrEwr1xM7x52UJTS66BSJKz2bPR61KNlmk4SDNJueNdcYltXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(2906002)(66946007)(26005)(4326008)(6916009)(8676002)(66476007)(66556008)(41300700001)(186003)(6512007)(6666004)(107886003)(6506007)(83380400001)(86362001)(316002)(54906003)(38100700002)(6486002)(478600001)(82960400001)(4744005)(8936002)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4nG7q/V0xa3WDkn3qL/gAWiZG4NkJYm+uM4+98KJOZH5wAqy107qnqg2U1WK?=
 =?us-ascii?Q?8vmvgqtDahnMYsshqBcF44GDO3F4o01BbPjbBc6N69kbnzynBPD8QEh4+H7u?=
 =?us-ascii?Q?6VNxHSybKsd2DK72ud/jj301l0noE+AbIrRTiKhdXUjMeRYQMcufXNFJQxSM?=
 =?us-ascii?Q?RmgXpXHRQ7sI/lKInmkfWQE0cWzekvUNtoM5kZ5MwmqagERartYCuC97OLyL?=
 =?us-ascii?Q?HrP0Ph2xVewxF/vd6rrOlQ7kHWpU9TSFhGxn++wSdwWeuHHyB2WbpnMKylQB?=
 =?us-ascii?Q?HSfQiJ+sPGEc4KEE6fifUiEv6CPMw/3jdCUuAWBMMZ/rx/rZqgamIhF7y3Vo?=
 =?us-ascii?Q?ryMslK80nz/7yJvpk/f+AlclGSIAShzz92lP51wPL5K48616j83TgFLTanT5?=
 =?us-ascii?Q?6xDltpmuOsyLgASpu3G3qq06s3jeA9ZwUjzJS2MlF+JxxCoaQN+Te+t2tCV6?=
 =?us-ascii?Q?Blw8qhIJ7xkWu1T9CeFngrEMieX2zDeY5y2mZyrrRZnNyvg2y6zfsqRlPlX+?=
 =?us-ascii?Q?grFkUqLwhMiBgPAgbh8EadSsSR9XyOH+iSnKm3rT77BgMudW5ZOqwliyCM8E?=
 =?us-ascii?Q?hpTEfMg5Td1PorMclc3W26Y1XjR8SLeOxAPfVQbPzKItWX34ikjjjjeG2V5+?=
 =?us-ascii?Q?34Y8mPtwQar45CkEHsT5BHiZAb13Rptrk4PvVde8nmNQtlmTDZ91wAEN0z6u?=
 =?us-ascii?Q?Vlcax8V+xOUdsVJOTg712uAXBAYah0O8kzy2iQHQnVCdwy/bXqZ/8uynSwE+?=
 =?us-ascii?Q?O0QvvzapoMBFhUIz8j9iBrRZavwiDpWT0WLRaYPj6CyUD1Z8BtUZzsfyLQ7u?=
 =?us-ascii?Q?9QPy73jFFxjYI7ahZ9AvFOCBLbhDUfCL1nGRNldwmv/GU195uQAX8Qi0wZ4i?=
 =?us-ascii?Q?Tg1qauBJ9g3PTniD0DEHub2WqD/Zk6NRapFvDaH+NqI2mUij2Z+JGQEQ6V4N?=
 =?us-ascii?Q?4uiqAQnObmBP8lps4nu4PNdimGUnmL0q+zUg4+GI3yYoKvKHw/oj9JVW9loS?=
 =?us-ascii?Q?OE35ggJclWZ2CBGzQx7apIlD+O6AVcn8P5paxhh5JUCpnMVbiBCnGqBxkRYu?=
 =?us-ascii?Q?5s+Bk4+Zj5okOrNOBjDI8BjPrvshQ9sn2tpzhRnZj11iJq9efhwOoez2CVhN?=
 =?us-ascii?Q?TeW2guW6k7IBsGLCYdosOYDxvorOeCEmfmvxbU0zOfrFXIG6xOeqPZhSpSzZ?=
 =?us-ascii?Q?z4C71BPpssF6x+uD1+rwbD2XF+RP5oa/kNNPTeVZqBBuarv364yqo4QA42g0?=
 =?us-ascii?Q?SnIfCGwDQwQoYclw512fWYbsLR1bsogIFGdcmSonfAhr92CKWrDj+Sf1B5xu?=
 =?us-ascii?Q?3LtzBgz6WKzMl6W0V4DPH7/jTAakKHyqdmM3WzRv+GVkn6dj+/m7fW1uZeyR?=
 =?us-ascii?Q?YbHAtzSHqX6e7FjkTSkaqgHmJTIskfrxnXz2LqswZMkm+gTatpcC/CMolpOu?=
 =?us-ascii?Q?NSr3GOU1+U6js//li1k6GQzFWk+TF8J8lRmhuN7BERviwUQkNgaB4bNPLYi4?=
 =?us-ascii?Q?o2GGHo6AVKzcvShZYae+ktodp7BDiMHC4raj9XrN7GR9f5iE1VgDYspjouAe?=
 =?us-ascii?Q?YNckqjy5coq22Gz8F7siMQrZvIrwiGAJ7pzgNsm1+pM2ULaMsbu5dwl0V7QP?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d98757e4-ed10-4bce-7879-08daf8a59bfb
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 16:12:19.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMxYVgxY12F6aquzav16cFPN0zgsZ4bI4TFXixAuIRqLLC/+RMh0Tas3gXld5Z01PV2JWVW2wvB5o2ybQ8JElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 08:05:14PM +0100, Borislav Petkov wrote:
> On Mon, Jan 09, 2023 at 07:35:55AM -0800, Ashok Raj wrote:
> > Currently when early microcode loading fails there is no way for the
> > user to know that the update failed.
> 
> Of course there is - there's no early update message in dmesg.

Sorry Boris, didn't comprehend. 

Without user making some additional steps to check the revision in the
default location and the current rev reported to find the update failed.

Maybe that's what you meant.
