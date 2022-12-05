Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE91664355B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiLEUMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiLEUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:12:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BB22613B;
        Mon,  5 Dec 2022 12:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670271134; x=1701807134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U0F1aso0xhaUmZs1MZaWJ1t2Ayu+EF2apXOr6qdCf6w=;
  b=g/kHAlJUSnreGE0jIC+LOVoiE43BVP9meora2nryqSUJVIkq7JhuY3Sk
   EduYvW7bgK/xBpipYuNjq2zQ45ZosCQ+lP5u4//46DJR/NwgxUT/ItMRn
   LVEdCjy9XqOzET+OXzsr9sY+gnpeXrCtO58plZTzGnsU9HhQ7Cv64hFUG
   EWz1StrlF9VW+LiIrbuT8YwOfNg9kWjCyfca0Aa3Jlzg/FAdV/lu7IPTj
   2C0o8IgejH5ZIDZrF+DzqABWsv9Eo4wNeipJYUmvq/8tJD6GiE0NrQsLq
   R7AKcgcHfVGt6M5Kb0u4PMIMtfZw9EeWR3z/fZXUTgEjgbwW3ttXaP+rC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="299881284"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="299881284"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 12:12:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="770474375"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="770474375"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2022 12:12:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 12:12:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 12:12:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 12:12:12 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 12:12:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFC+pGuzm16myHZnLfa1MU3tI5G0/ESHQ1XXfu0D1EQc+Kmpd2vRVrd/U4mo8dvHYU0fjlstUEJAqhtbvXbIT8m0Oq/aoFMxFD8LaNfqt9vDCGJ0wxL4T9xST0uyR80ykxd9obXpU0VBoVXFdaPueVlI6xrw1HwciTMaFyP2MIsw2kqA183PiXAmPUP46M1IxS/NFQXUqdg4Y3l1BAOtU0lkqoSWrlAyEZ2mANLdDbkahkNY2ajSEYUzGwtdPTRP6AvXX+e/7GozRPmM4XcGowzghlANBU4pt/wJIZ4mbVHkVGoS9qmDwUpVejxmizExngxrwUkG7fzCnWugsHYMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RjJ2Fl/lgj9f4hHYIHrPyDvK8UwtksMDpk54SAvrh0=;
 b=nuUAfu7Hf/Cfl+VWpWtehNfmQ5ql4pCVRVYtmBfTQOzLIJj65gUcYL+Q6T2UIgv+Xt+M6FtHIhLreqkOTZfnnigbX5DubM5CcsDtLCVbryiJrkFGMkJ7Bp6US++XxuhqMuQSNHRKg4DhkvzDSUEuMUsLy2XMUk2iif4x9dc8gH1HpYPfSyO8lKi9li4yDuEukgrJzaaR5en0cX5gdZM27+aJcNV46N7bEw6aRkXrQoQ7ObPEp7xQrSLS8KD1gr17WYSXTze1zEpFzFb2yuh70TorZhNyOv9V6dNW46mvZUBSqgbmeou98Ffz/74bOOf+FHWNLarsx2JfZLBoO2C4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH8PR11MB7069.namprd11.prod.outlook.com
 (2603:10b6:510:217::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 20:12:06 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 20:12:06 +0000
Date:   Mon, 5 Dec 2022 12:12:03 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: Fix spelling mistake "memergion" ->
 "memregion"
Message-ID: <638e50936cdbb_3cbe02941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221205091819.1943564-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221205091819.1943564-1-colin.i.king@gmail.com>
X-ClientProxiedBy: BY3PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH8PR11MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eee5fef-fb93-4b7d-126e-08dad6fcfb06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLdSuiEPp0h94VLCscwiTtjiRTJxGY6YpbSZ9XGnUZuMTWQ9EIdhbtY2QeBssXPPWKHRXc6OHEEQ/lS9meUw2zpuC1cviCggf/YvqJr5DR/RjkyoCHS1qIBpCGBbe6z3lCJcmzu2mCMHbAMgZ8keMETWXZPcS5gubICVNaYbGOMMGaC8OGLo8ftBqHu6Cc3ekIUifs3+UV9xGnPf16DbTzOfUiJIznoN6lSX80ACBG2H+jIhpG02vIPaR1zyfy84+hXkKEXMmwjflchw9tB49U1tkVN43nckf4eGQfCzwFezKh3sI0g0fI4lCWOo+4rmFeS763d26ouB8v5ljB0f6HY5J9e2XDvRM49bet2XEHIb2pjknQVTpFwDnoN6Xovomg45AId+8GobsulpU2VXmHwSxMfSGEHrLGQBnd62VmT7oSvfVwFoosQfo6CxAw47QMJghVRKQtP1iH2AJAB33m59kLFzxt4cW44fkT0tqYnukM1lYHepKaaJoLcp++zRUyzUUxCINahVf1zb5j3A6LRLELbGfbfGChgvRIP+xuF8oZWWNSTwMGNKdlQ52Z65jEz+zGpXyvQv/05IPVnfE5mUV9BkGAGrxQgwLzX2JCrEoVhp44RowlMEMLMCjmybUYO7T1UjTFioH3UaNo06rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(186003)(86362001)(6506007)(478600001)(6486002)(558084003)(26005)(38100700002)(83380400001)(82960400001)(4326008)(41300700001)(5660300002)(8936002)(8676002)(6512007)(9686003)(6666004)(66946007)(66556008)(66476007)(316002)(110136005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fxVZHtzc+sZ5QICIEDM1H9RFsJx1qVnf8UplIAeQv5i9GmQwCRmXFOryS4/b?=
 =?us-ascii?Q?oWB/Nu7oQtG0780uH77kmm0ulUcd7udT3d2W1PB1Kqb5H5NYuyX7MZkwUEIk?=
 =?us-ascii?Q?O6e3aeo+TgaMdaOOXc3gUZgCUUZ5eaoWIQVS+MB1YdS4kwF/mL6wsZnzRnQy?=
 =?us-ascii?Q?HYu2aM+wjy2lYGNCsrF/hTeGPLAKdCcZ+R502T9ZlTEi1n8uMRiSJffiY31W?=
 =?us-ascii?Q?UVr4e5pRzEz7VWJBF0riVPDS1FO+yzWqPZPWwRHY77KlUcT6EoE6s6ZMC7H5?=
 =?us-ascii?Q?ZFbpeBmEYXhkuDcoyb3O1+xlNaXOqgzH2O6gWgqSWkBc57Mue8XIx97p4MM6?=
 =?us-ascii?Q?VxuAhbI2qvCM9N8BGVnZSWdXzRVDQt43WH04/7K860xBjxUN656rfcAncvwq?=
 =?us-ascii?Q?dVpIhst1IgGZMq7Qe49wHor/LOEv1JklNkYJU/O9/9UHKOSBms7INn1nS2ea?=
 =?us-ascii?Q?CYLrRbe8swz5J5/WZVVuw7LcWOWwku0D4CIxhnjWVaLawlb4e3DW5TVOJc9B?=
 =?us-ascii?Q?FO+vd6Lo5v2JKbkdZp8SKwPZBwLvsipiN2QVomUR78KjN4AowjJItu9plOm0?=
 =?us-ascii?Q?Bvwb7opCTctNX6b4VMLQmkl4hpQuL4CBW83lzdeRAkFBR1gYRXTx7xwJP3U3?=
 =?us-ascii?Q?JqwSQKQ+ADhjr3aRMNGio+kK5742zu2cIQzUAmQ2ChWFAPAEGjxtyo9bX43v?=
 =?us-ascii?Q?tjwd38q17ZaA9teg+adBCXSOu0D73GRNaznYvsnmmp934kEWXQV5qsYGBSJ3?=
 =?us-ascii?Q?qLP8RCTb86IpIjmJ0w191cUrFL7SM6/uHurZgpnl32vzv4SmAbCfQvTwfla9?=
 =?us-ascii?Q?sxjMfKqyq7vQegMsXKwAdPj9Zmr5zUeRcj2ByfWtscPqVDfEDkgs6tGk6moC?=
 =?us-ascii?Q?dwRnLJ/U58A3Ey0zRsPGiGHImSjzOPtGPl76Z+qBNSEzJXVaUP7GvnqZd5aV?=
 =?us-ascii?Q?Cnv74vVqcM+WNebbtKHLA+0ObzAz+lQyYHnto6I9GpU1WBOk+0JXeY2ml8vz?=
 =?us-ascii?Q?x51NZphCd7lRjr96ymH3RzkQDzg6I/LTp4j30RPRzDFc/vr94Kshbqx4llhh?=
 =?us-ascii?Q?ddUJqYGaJUb8s/OIavHutoeuNHPC4JSGobQyCHiUy4D/btK9c3t77qXPSfdb?=
 =?us-ascii?Q?ZiQlIBiw40/nbHO3F9oa4holsyuw2OCS/PuzHQ2ngMKZHLuIJq624T2JIu7y?=
 =?us-ascii?Q?LMEOvVjkKJ9OTm6N0xOuMMe+xA+2Vbzb+5gstINn1xAEi8Vv9JaHEx8ENPkI?=
 =?us-ascii?Q?0yfBqAoSK9b1ublTwQa7wofsiBeXHYJtTQXvUZkGeB8HXoI6q/JXMrihNPUb?=
 =?us-ascii?Q?Q8heCoUZPmBLO0IUgbzdvyllWrNjSvWKAmEWQt+A7+qWG3yHrTM3tdapZQZ3?=
 =?us-ascii?Q?T9saVhbDHnh5LFuaXbdfCf8treCDw02NxSErdgxyPTmig2g5bGbT7npq5HQD?=
 =?us-ascii?Q?YyNqdqGA1LkEw1eZL8ffhtNHC3Je4AUQLs9okkYY9qwZiC02HVMA7d8xbuBL?=
 =?us-ascii?Q?YrgdDyaP2i/Kt0XCiSpezbd2k05GoyT9L3+zvwbZSUue0WX6epJ+gftx9JmG?=
 =?us-ascii?Q?loy8u+b29JhwJCWpOLQeE7Fp9oUstsu26a5NEcwmzR8mVxmGbK+yKvM14Z6I?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eee5fef-fb93-4b7d-126e-08dad6fcfb06
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 20:12:06.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syg4UFpbdU7T/oUCvfIK0q9Wp4YM4QRH6NRZw9ohsFtk1pN3s6j/juPUbjcMb9RD6N3OgJJs73yAtqh0wsH3F8XMiEyWOYDN6yVaeuaknZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7069
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King wrote:
> There is a spelling mistake in a dev_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin, applied for-6.2/cxl-fixes
