Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE666084C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjAFU3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjAFU3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:29:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D843C734
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673036949; x=1704572949;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LEXYZ5zXmWrrA4jfWFjY3GwzRj5uU/m7JKYbcP3HoJc=;
  b=MkIB2sdJk7meE9H+f9sJ3FBS3s40xHR8h6qQULmtIOgwzd5b6UTA436P
   VazR4rt7EUXPUTJVBjp9kY2myZO19R7Y7ZEGBFJRkKW1e6QOIrt78GOXV
   GbqnOptAyNqDPtR9M6xIdxS7Mvt0PL/gsUvzUBqnXMmQhkKYyB4GPT2Bo
   1psU3ITNi/q3QZ0W404xg7N7SMwm81PR9Ur+N08XP4HBwagBT9TmIp0J/
   zGq5iubiYX66Vs61qCot03Xzhf4wtekDT8SIL8ePsBwfDaYebEel31S+L
   9UznST6KjS4DSY5+n6EgUCYzlS+my19FWW6pWlErVEIYVAv2HieZ1qlux
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="306078260"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="306078260"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 12:29:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="724532893"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="724532893"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2023 12:29:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 12:29:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 12:29:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 12:29:07 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 12:29:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2T4mLxIWcLgTw6XaJvbDvwgEqn22/Y6ioEeAHCDK0gHJ8T7uJrLzZ++wi8hszs1Gf2uFywVxAWALHdiPPcXyynCstyzhXAwKqyEjAiCRupPcNrZHL9G9h0a4ybm3Z/DXYmOSCCvN1Raj8Z2KKfbdW0pgapwyC+vsXHCDkR2D2WbbijbdGQxKlRg8RUK5IyjGa7YhmeVRm4uRHqMub7Ij/wyiL8iByhgkuNF3++hhV3SmaNozOr5zCbWxqG8ATWZJQyHgTuJbPBjK+9LhRgP6RJrlHOG5ijdLqzRW1czH9EXN+nbkwLDI2gtyVKMoGLzHecfbBtzw3ua/if/424GoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCry56yhug5W0tvKyiMyk1xbXaFh6dLGsGqgSE78PNY=;
 b=Q3WgcIedxTHILU4yfNqwX/ctu0qFwr0gxMcOd+LmfMnW1GaEIjMHZX65hFnd9pivwgdpVhQNEBWqckXZOmb2ZDwagE2ugvwOEO5UMdCxmfwBZQROiX62/8YtxYNEsSaJCQofGywXNcMTLvx6QMkn4W25IkQ71AtWumYMukiMkZkN97yPNvxIi+m1q2qHzM3A+aWo0VuE84I01Uo65Eii1qc/nqAg4jccOqkDVCsoJAfTxJsYpQw/Dp8UdF48CFAL/mdwi3iDfmOJa9qh+30r2hvgoj+MTzjeJFQ+SKkabp6xWUQnmputsufiuieVDwSYwcjT9u+ZKk1CZymyOl/iRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH7PR11MB6674.namprd11.prod.outlook.com (2603:10b6:510:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 20:29:05 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 20:29:05 +0000
Date:   Fri, 6 Jan 2023 12:29:00 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Message-ID: <Y7iEjDrXLRlwoz0W@a4bf019067fa.jf.intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-4-ashok.raj@intel.com>
 <Y7XMtWqSrs0uGkD7@zn.tnic>
 <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com>
 <Y7h8dpIQHnL93RdC@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7h8dpIQHnL93RdC@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::28) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH7PR11MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: dd76cec4-bc64-4099-357a-08daf024a7b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0nmzRLeQqnOzsjf9nqmDCy3i0zhbtKGs2n2O5XdJIFwVwu8165LB7PldjAMCfKeuwphAAtQBYUsCfSxv3NB/qyfjuQLpLxo+nF6OxGcF/tTvU0EVDObJmciaQKIgadRwD7z9e7zVyF6ai9dgMR2uxGKb5qeW5mS3ai8pbW5UEGsafBYaR/xxhdN5N5TEsK7pJ/iyT79ySSOGvAUBPSdHBnM+u6RM9lvtmLOQYkXk01kA9/29qgu8DyyLNvHjC3wmnwSYqUWJeOyUdH6oKTJvjP0O/UXc9Q1+O6aJ5ayEBhM6sxrfx1zO6MlecMKQjtYRqAoklFvp3jZ3yEhybr8XEi123xnS3DWaOp19wuplw+pKYTbixDGbVxV/VBEKE/70FG+AJn1ULWilhjsoWHirTW9PK6LnbuymRvH5jDGplWDkYUxr7Vtcp27oI48QLUfMCUOSa8fm5kjgqgLL8HQ1mK14Fhk7cZueviZ/S3+vRsLdYZKYWsVuoCrLGGOKaXJzGLo78ffHCkQA4SisttCQ89OslsXfnS8UuXcxWq1C6wY0rKq3taagcoxfnDH41a/XvyV1aaE/QjBbCRv93joC7blgi3nEBBYqO7AQCZwS17/mfGVf/tt+b/tksGtmoctBeRS9xydMiY4EgtXTmEmxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(4326008)(66946007)(82960400001)(15650500001)(8676002)(66556008)(8936002)(66476007)(5660300002)(4744005)(2906002)(44832011)(83380400001)(38100700002)(86362001)(478600001)(316002)(6916009)(54906003)(6486002)(186003)(41300700001)(6666004)(107886003)(26005)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LLDpdUcPrtPbqA40JdWVFdkqGzxCBgQuEqKHqnRdzjsZWSdOfuF9cjiR7b/r?=
 =?us-ascii?Q?z1OGXQg6aIAKRczg7FJICyxXKRGMjRcaSiBKv0gH+VnD1YuRinGbHGNTXw3s?=
 =?us-ascii?Q?jaGLYLZIqrmo2SS+PrLU2/W9R80ODg+vXvT8u0q9vBzJ/a6Ux31FWvPaaxwY?=
 =?us-ascii?Q?Ou2Nmhi6S869/Z6B/seDX1WqGAt+E64lO8spwYVp5G4TLxK3sSyskdo0VjHN?=
 =?us-ascii?Q?aup5Rou2kqvsMNKOnFSP5KOZaKyjEK0+xTfh0Kcud6tI178Uo4oOinyAeaxg?=
 =?us-ascii?Q?HJj0y8TsI4GqY70+AIX4+QGVhRgR85Np3Xaj4Yn+lT3RKyuVh5Rcme7fJNmZ?=
 =?us-ascii?Q?I/yD3wXpPlZX5KVt3NyNIErtJ4bVxaUnIVIPojX3JaUXpqsAveTRvDT8h1dt?=
 =?us-ascii?Q?xE9EeTj1E2OWrPRj7giI6hA7GWmvfZTmRWbcuTW+HwTwly1HJJnrsQttDtdB?=
 =?us-ascii?Q?wrZ4wgYwaieZhavahkCmU+tVoiRqyYlJhbA5RyfLfY1QQFIw5tgf1A/XGCJe?=
 =?us-ascii?Q?0ttYWMXVCFMYWQLdTj9g6iZqbDe7MbE4x0kBUm57HLbuduAK+lVM1fy2NEtR?=
 =?us-ascii?Q?+76k3Kh2coXnWvv+eJQKRvUxOh4pw8DJJ1rQEM1z/tAf7Ixk+d5EilhjT1cC?=
 =?us-ascii?Q?Vfx33EdhZhdlwyzybBYq/IPwoXtrcMqan94wkQ8bKOAXuGB4m5FzTBVNOl1g?=
 =?us-ascii?Q?5GeeK5m3kMfY9duA/dBuP6zdHun8+RNxS8/Vnuj5bqtDcOg4nmtbnJy7NC3e?=
 =?us-ascii?Q?SUA0hsYoO09a+PA6CWHd/kAonZUXvEqLjZos5mh0Fx5lqBhNzNVH1M3Il+uM?=
 =?us-ascii?Q?fa1cv52t66SMaY9bxEHNikfv3VAvuKvdzR66jHixnKj/70PDqdnDwzhEuCBT?=
 =?us-ascii?Q?kl8UcJmFX6qitmKftoPDyxMiJ8HXpiiT81p33Y6npQnvAWV1KSQPLUu+/GB3?=
 =?us-ascii?Q?5RQ6rYuGv6wG6OKxhQsQ3STnvOzV0q35woS3ALAfuK8M6lH58yY6NQ38NJMU?=
 =?us-ascii?Q?eAQYTPZblZz0fM7EuWLrO3MeuWaGHrkTDY9vW8IGK6VkSTri9vVZ3PFpHFwJ?=
 =?us-ascii?Q?o6N3aV00mYUJi8nvqcR5g9L+i6uDU2/e8pKvoyHoTOcAxg8mR+0zK8WBmHv3?=
 =?us-ascii?Q?eTiKQHwjsrYp4Qj+ZadnAz7k4js0WIwVkt1YQSrz7rZSvFl+kg+JVbnieQ8G?=
 =?us-ascii?Q?POfNvLoyXHUqTLDhztEvnz9IiTq7NB9Bb2Ke37b7HPo3k0W/sF8uMhaksS4X?=
 =?us-ascii?Q?77kQQsE+3mMUK//XwzMyb53fge1j0eH9cnJK3jtZB8ld2IyzfiYEyItBHc6C?=
 =?us-ascii?Q?l9RGBAxjeNE8D4QrMQn6+bTQsaoF3OmbTzCK1ymnC/281U7ICbBLR0WSPJcG?=
 =?us-ascii?Q?SEb86TlrAYxYzYP/Vz1Kd/8T5irXfX33pHjN+qepV88gL28XXFedhyaFhcGc?=
 =?us-ascii?Q?V4cAXgDVIEb1Kj/e4dCqhMUWXux52Ut93fIsBCWUnFf+n9VkW2wDfxwtGpPN?=
 =?us-ascii?Q?+L5yJDEdAfYX82Vnl398bYq2oN/P62Tep2b7rJCp6VAHLLl+tZZLA224RXuI?=
 =?us-ascii?Q?kmTn9WBlA2wDQqS+jCfyy5S/zlKiK19JdTXoOyeQQtSxvpb3iYXH9FCICO0J?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd76cec4-bc64-4099-357a-08daf024a7b2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 20:29:05.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyVEHt6xdvN025Tf1oWe87ylUWjbqLHYI1c/7vmLLu8g9BM+/+cjdizuOIASneVvTIRoW/dxxA9Cy8c+4USMzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 08:54:30PM +0100, Borislav Petkov wrote:
> On Fri, Jan 06, 2023 at 11:42:32AM -0800, Ashok Raj wrote:
> > > 9bd681251b7c ("x86/microcode: Announce reload operation's completion")
> > 
> > Thanks.. yes I can add when I resent the series.
> 
> No, you should read the commit message:
> 
> "issue a single line to dmesg after the reload ... to let the user know that a
> reload has at least been attempted."
> 
> and drop your patch.
> 
> We issue that line unconditionally to give feedback to the user that the attempt
> was actually tried. Otherwise, you don't get any feedback and you wonder whether
> it is doing anything.
> 
> The prev and next revision:
> 
> 	"microcode revision: 0x%x -> 0x%x\n",
> 
> will tell you whether something got loaded or not.

Yes, that makes sense, Do you think we can add a note that the loading
failed? since the old -> new, new is coming from new microcode rev.

Reload failed/completed ? 
