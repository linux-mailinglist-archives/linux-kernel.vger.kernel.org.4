Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C516463FDBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiLBBju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiLBBja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:39:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B558FD3A09;
        Thu,  1 Dec 2022 17:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669945164; x=1701481164;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QpgttZDf6AcVlabcC+CSs1SdVqadWIJ4w6m258BM/7M=;
  b=DORC+bhfpSpzZ96XB5XjDeVsWk76E7yruz/tVt873cVq9iJTrQZdGSF8
   yjh1MfmbHzqgAO9Gf4oyqw390sAe9gM7I7zkk0NHkHfyk6nPHVRv1I139
   oiIl/sxqweM21K9Qvusmt0YMFrV4rUBRZMnfE2bgEovecdxafGrJcXpqK
   wgHVxzZAub+k6WxBHTrhojyhylbTsOQiPzPRc8H1uBRk0LsoOF1EwVgNw
   zi/DPzYc/g1yV5aK/2BfJ5Kz/ouPr35Gt7vYVuHITxphocGFCwUBrMrl1
   P4iL1y1u6H9KRSLpe2t3JcoSegzFXh5/+uNFk03ElwVDvUXZK4vB3MMbl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314548445"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="314548445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 17:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="787110174"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="787110174"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2022 17:39:24 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 17:39:23 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 17:39:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 17:39:23 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 17:39:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJfbjeH1f4Piox75pOUu/EsOC6iypGVXYpq7qnm9hb+oJmCsPS7W5nrFVj8Kp4uVuzDUgUM/8i0GSbtC+tBTBYhIfsNb8NBO2NovZzVQG0YaWJS2QAqXFjAyJEfQgfJ4Rjl743s7s7cJXFIoGZlIXt0wMRJBrhZ0k3UxKMKqYZMbeP4YftjMgKSJ+dnfrm5fK2Cv9hPP987nTbgvO1foCKc+GRB1kH9BdHpfgQurTNgmQH8A0DIZuZhmQkdfM0YzrEDNPGNAi53VKZMbKI1hYwrNSzyoSMw35yn5mkmvMvoqnCY03HcjBTXFykPkyF78SJlQF1uWgf6pnk6uoeOYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dywyvk0P74TpiN0SUnLkdAu04fxZceHBU8Vy7308oJo=;
 b=UaR+pmzYrVPGp9lmdoRHF7J+/RHmHZGxRYe43jdsiCxUCB3tHdtRql1hOfKlYdAdrLKyvs83vGZhJpOu5iUidHkozBcO7f5J7XjDcrKTM82mbCPZc0HJq2jBTl7egVffWOpyfSzcvwQVwWiVi+LQQmU0+D89bu37uoNxcAaa6qAOzRybYRIUV7s+WX8PvQzAy77pbAyp0pRtA1KYLMNI0AcOddFgxqIKjyPV0oM4Ts/rTNebDyVjBmfBOzeY0p9kjk7I/+RRAu/B8bbwfFVnamYUJ8YVkai1Gek4ONq6SZyH9gCqIK2jbFZZZusfgeqNuJ7Z7SxlQXLilqf9gqQ7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4513.namprd11.prod.outlook.com
 (2603:10b6:5:2a2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 01:39:20 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 01:39:20 +0000
Date:   Thu, 1 Dec 2022 17:39:12 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <6389573ff3b7e_3cbe029460@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-3-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-3-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM6PR11MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: dc30d325-c19b-4974-8626-08dad406081c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+G3cS3n0hHsTH9nWWFFKb5p99SkmRdjUwk9kBle6NU0QIwDQyw6/a6uzPUqRhMF10B6Tyfd7MNx6TQ7n8blZxt/cnv02WNYJm01hy72UHQMMpU5kAD0ffD7wc4pwYBMg1xjt8PDiAQzmjzA9x2yDFjCf4JZoNOaB88HKYd7/kfYxfKaFIc4MbhWo1CQRFDFW4F8lVsH5pTFjjLEla0vkeMGxR0wCuATjZL+dq9uYpBRdP35W/cYC498ARF4kEg3HOWRBx+t43epW0e6/FLMYqk7bOOI7jJRDqj3yXqaBA2dkDsMowRwcfccqFXE7EdLzu/j09Ut21YLQGTyfPCEhVyjq+WZ3e0rC3RSlJUuPEFZMbVWhigaSdr9o3yCFDu4QKqf+S5lY/DUuBnOFH8l46KNi/lHTu/ZHfOGzWT9OA60XbOaGkLQIpE3jccDzhLK795zWYdJuV5qcQy5uy2oNFvKsnlGBMM0DyHze2p1KQj66hG67fObrTK672FxUqYZ93JFgShvdETVPmcoGaxD+zj0uQkwT+N8uLaaFyQ0bNi1Qqsuw6RP7EXuBuWT7lWI0LLkkm+fVpRDHuUDgJjNFThEWk5keoZnxPkplqK2qFbGLf/xxae2iPC7bF99lH8JLkUlCftBUQ12KEKEzJ5puzCswkTJW6Yq75K39RS8xUsKmf0MdQ5YXVZcvchRGkj3SkTX4PgJuwWVCJW+A50QhwMqM7X8QPYosm6pV5IqQyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(6200100001)(83380400001)(6512007)(26005)(186003)(9686003)(6506007)(41300700001)(66946007)(4326008)(66556008)(316002)(8676002)(6486002)(6666004)(86362001)(66476007)(38100700002)(478600001)(966005)(82960400001)(54906003)(2906002)(6862004)(30864003)(5660300002)(8936002)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FKkx0iUshYXmgHG8615GxeoLfOs9AVEgqx1Bw+HD0KD2fUf5R5jI2/g29FUq?=
 =?us-ascii?Q?u6tJHkUADSKlfVNi3tvzzRfib9PH9fPDFK6lGWrfLTrvSybumq/L0UpiQiBc?=
 =?us-ascii?Q?MEwYfFPvjmXE20BwT+Y84RFyHQtZ3KMjwIhi+EOVcESwQGa1iaj+pj1/KtjZ?=
 =?us-ascii?Q?rkofYZQAGJL/dw1J57CVVNSmG5xIvzEaxn//oOIuMhGIjaa6muaFroJxErUs?=
 =?us-ascii?Q?6r87LPwpm4I89q7UvDQ4nsoe97K10Cv9wuq8siM/7XwgoimH9udJf6Db/gYe?=
 =?us-ascii?Q?GJyqX+V7SYwyLZs5zpWA8fON0oUmKSSxAPoLBRGaVDJOvZ0bWqjXbVhdBQCP?=
 =?us-ascii?Q?PT0fW0Ewuv0NVMDMyw+g+VhvMPCgwihvuEMpM3RMqjmO6cfHCkNk9I6bLEZJ?=
 =?us-ascii?Q?fcFW0DKZbWwg9tXsYaPZaVuQRowv1LeIeLUaYdTSugqbxRPRvq908d3PT5HD?=
 =?us-ascii?Q?UjUdOht9gjeMtMFGQpOmWh6zHHozGeGdcc9rUV1XKXb/93tjExeSNXiXAuDt?=
 =?us-ascii?Q?St/dothIZqBLFBfJEU5ZW5vbT9N6qru1vBNfQddBXq0/b04+qR0krp8HD+hH?=
 =?us-ascii?Q?idNGM1XcFBWHit7z7d2CPA4HUxy882xt3WpC6DcTqfJfBdSCpeBxIFJczNuF?=
 =?us-ascii?Q?QGQGgQXJyPHl/G4GzsbX47ODvQp/QJl4/ti3W/xb+LKq7EWg2TC7jb+MlmX8?=
 =?us-ascii?Q?KTFSNIpCeP9fEN9a+X06SX/Bf+DczBASX94r7UDApnCclftjDHWofjUiWvOM?=
 =?us-ascii?Q?+ojje9v9Dg+9Jg9ZW7e9TbjkByV3ru27QBht6dsTtvGqcYyb9bGuhCLlnvVv?=
 =?us-ascii?Q?1Tbl25KaxnBzTCmbAerJEXOM2X8FByxBPNvGWgwY4J5iV4zsxFlTUbkNIjWe?=
 =?us-ascii?Q?J+vVBFhb139DXZjIJHyUXBuShJrTWwSZ/AxRxBx7hVmDxRMy5Lt4T5Ew8FEo?=
 =?us-ascii?Q?XU7QPYV8wPzhmsKHJGCNuUIXtG+cf2BgwXU/qE68yTUYHW1OECRHgrZhWDcA?=
 =?us-ascii?Q?/9Q2HjkRw5Rv/5rNkAyhikkxqVKrOCZ46RJbU8dI1c9Uzf7uNSB1QLOfEz7u?=
 =?us-ascii?Q?Xxc02qrz2AqYTVOJTirh/tvf0vPxAkZtOwCy4I+vNojE5x7BiKWgdFmZfYRu?=
 =?us-ascii?Q?vir7jDmGrQ+p3fDT5WgVwMYTMcgF+u5rxqR+HInw+x7G/D/pocar7SLa4oN0?=
 =?us-ascii?Q?fIKCbpYGw5hrubxpct4ama5qxXUkyZ0kypWHZby01AlndZWfqcuaFk/7oaeD?=
 =?us-ascii?Q?l/sf287Xe9hQeaVE+5s/qxci/I5VGRnXSUF2gG/4D330qwEzgQrVIc+/P9Mt?=
 =?us-ascii?Q?2ekiFvct1d9SQkEeVYPKVwR/wRvVdl26+LFwxPmR8908psSAN0cSwA2ibCOt?=
 =?us-ascii?Q?Cw8jVOy241IiXPcwzHRs7iF8WiV5v9t9Tc7PQn8VsQJGyaGKjyDmfUn0Cc+I?=
 =?us-ascii?Q?qax59tfw2brFMEeZWEql8wQqHcQHkWBJtY6oC0xxpxTP3xA9mUu/kKFPHUSN?=
 =?us-ascii?Q?b/3Mly3RCtmP+Z0aWdqekhXkG4WhK9MjUkNZvPcrRe4fVoLYOS3CLnPeXcXQ?=
 =?us-ascii?Q?9pyGMGyc/21ST9w1mhy1DBXdLFsDOzPPOEIg6JLIr/CTdykPliiQL6qlZUtg?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc30d325-c19b-4974-8626-08dad406081c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 01:39:19.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pYtA9dwYnZN9hydro+YT9anApmTZmdulLx9QX9mm64E8wB3AbJmg3gvet/2M4q63rOWtMNSBaD4Qqw6kALWJhcfblKoQD6N4BxN3tc/dRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL devices have multiple event logs which can be queried for CXL event
> records.  Devices are required to support the storage of at least one
> event record in each event log type.
> 
> Devices track event log overflow by incrementing a counter and tracking
> the time of the first and last overflow event seen.
> 
> Software queries events via the Get Event Record mailbox command; CXL
> rev 3.0 section 8.2.9.2.2.
> 
> Issue the Get Event Record mailbox command on driver load.  Trace each
> record found with a generic record trace.  Trace any overflow
> conditions.
> 
> The device can return up to 1MB worth of event records per query.
> Allocate a shared large buffer to handle the max number of records based
> on the mailbox payload size.
> 
> This patch traces a raw event record only and leaves the specific event
> record types to subsequent patches.
> 
> Macros are created to use for tracing the common CXL Event header
> fields.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Change from V1:
> 	Ignore useless More Event Flag
> 	defer DCD support
> 	Jonathan
> 		delete extra blank line
> 		Use all caps for flags
> 	Jonathan/Dan/Ira
> 		Allocate event MB buffer on start up.
> 	Alison
> 		s/pl_nr/nr_pl
> 
> Change from RFC v2:
> 	Support reading 3 events at once.
> 	Reverse Jonathan's suggestion and check for positive number of
> 		records.  Because the record count may have been
> 		returned as something > 3 based on what the device
> 		thinks it can send back even though the core Linux mbox
> 		processing truncates the data.
> 	Alison and Dave Jiang
> 		Change header uuid type to uuid_t for better user space
> 		processing
> 	Smita
> 		Check status reg before reading log.
> 	Steven
> 		Prefix all trace points with 'cxl_'
> 		Use static branch <trace>_enabled() calls
> 	Jonathan
> 		s/CXL_EVENT_TYPE_INFO/0
> 		s/{first,last}/{first,last}_ts
> 		Remove Reserved field from header
> 		Fix header issue for cxl_event_log_type_str()
> 
> Change from RFC:
> 	Remove redundant error message in get event records loop
> 	s/EVENT_RECORD_DATA_LENGTH/CXL_EVENT_RECORD_DATA_LENGTH
> 	Use hdr_uuid for the header UUID field
> 	Use cxl_event_log_type_str() for the trace events
> 	Create macros for the header fields and common entries of each event
> 	Add reserved buffer output dump
> 	Report error if event query fails
> 	Remove unused record_cnt variable
> 	Steven - reorder overflow record
> 		Remove NOTE about checkpatch
> 	Jonathan
> 		check for exactly 1 record
> 		s/v3.0/rev 3.0
> 		Use 3 byte fields for 24bit fields
> 		Add 3.0 Maintenance Operation Class
> 		Add Dynamic Capacity log type
> 		Fix spelling
> 	Dave Jiang/Dan/Alison
> 		s/cxl-event/cxl
> 		trace/events/cxl-events => trace/events/cxl.h
> 		s/cxl_event_overflow/overflow
> 		s/cxl_event/generic_event
> ---
>  MAINTAINERS                  |   1 +
>  drivers/cxl/core/mbox.c      | 105 +++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h            |   7 ++
>  drivers/cxl/cxlmem.h         |  72 ++++++++++++++++++++
>  include/trace/events/cxl.h   | 126 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h |   1 +
>  6 files changed, 312 insertions(+)
>  create mode 100644 include/trace/events/cxl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca063a504026..4b7c6e3055c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5223,6 +5223,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
> +F:	include/trace/events/cxl.h
>  F:	include/uapi/linux/cxl_mem.h
>  
>  CONEXANT ACCESSRUNNER USB DRIVER
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 16176b9278b4..70b681027a3d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -7,6 +7,9 @@
>  #include <cxlmem.h>
>  #include <cxl.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/cxl.h>
> +
>  #include "core.h"
>  
>  static bool cxl_raw_allow_all;
> @@ -48,6 +51,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
>  #endif
>  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> +	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
>  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
>  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),

Similar to this patch:

https://lore.kernel.org/linux-cxl/166993221008.1995348.11651567302609703175.stgit@dwillia2-xfh.jf.intel.com/

CXL_MEM_COMMAND_ID_GET_EVENT_RECORD, should be added to the "always
kernel" / cxlds->exclusive_cmds mask.

> @@ -704,6 +708,106 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +				    enum cxl_event_log_type type)
> +{
> +	struct cxl_get_event_payload *payload;
> +	u16 nr_rec;
> +
> +	mutex_lock(&cxlds->event_buf_lock);
> +
> +	payload = cxlds->event_buf;
> +
> +	do {
> +		u8 log_type = type;
> +		int rc;
> +
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> +				       &log_type, sizeof(log_type),
> +				       payload, cxlds->payload_size);
> +		if (rc) {
> +			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
> +				cxl_event_log_type_str(type), rc);
> +			goto unlock_buffer;
> +		}
> +
> +		nr_rec = le16_to_cpu(payload->record_count);
> +		if (trace_cxl_generic_event_enabled()) {

This feels like a premature micro-optimization as none of this code is
fast path and it is dwarfed by the cost of executing the mailbox
command. I started with trying to reduce the 80 column collision
pressure, but then stepped back even further and asked, why?

> +			int i;
> +
> +			for (i = 0; i < nr_rec; i++)
> +				trace_cxl_generic_event(dev_name(cxlds->dev),
> +							type,
> +							&payload->records[i]);

As far as I can tell trace_cxl_generic_event() always expects a
device-name as its first argument. So why not enforce that with
type-safety?  I.e. I think trace_cxl_generic_event() should take a
"struct device *", not a string unless it is really the case that any
old string will do as the first argument to the trace event. Otherwise
the trace point can do "__string(dev_name, dev_name(dev))", and mandate
that callers pass devices.

> +		}
> +
> +		if (trace_cxl_overflow_enabled() &&
> +		    (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW))
> +			trace_cxl_overflow(dev_name(cxlds->dev), type, payload);
> +
> +	} while (nr_rec);
> +
> +unlock_buffer:
> +	mutex_unlock(&cxlds->event_buf_lock);
> +}
> +
> +static void cxl_mem_free_event_buffer(void *data)
> +{
> +	struct cxl_dev_state *cxlds = data;
> +
> +	kvfree(cxlds->event_buf);
> +}
> +
> +/*
> + * There is a single buffer for reading event logs from the mailbox.  All logs
> + * share this buffer protected by the cxlds->event_buf_lock.
> + */
> +static struct cxl_get_event_payload *alloc_event_buf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_get_event_payload *buf;
> +
> +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> +		cxlds->payload_size);
> +
> +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (buf && devm_add_action_or_reset(cxlds->dev,
> +			cxl_mem_free_event_buffer, cxlds))
> +		return NULL;
> +	return buf;
> +}
> +
> +/**
> + * cxl_mem_get_event_records - Get Event Records from the device
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve all event records available on the device and report them as trace
> + * events.
> + *
> + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> + */
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> +{
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +
> +	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> +
> +	if (!cxlds->event_buf) {
> +		cxlds->event_buf = alloc_event_buf(cxlds);
> +		if (WARN_ON_ONCE(!cxlds->event_buf))
> +			return;
> +	}

What's the point of having an event_buf_lock if event_buf is reallocated
every call?

Just allocate event_buf once at the beginning of time during init if the
device supports event log retrieval, and fail the driver load if that
allocation fails. No runtime WARN() for memory allocation.

I notice this patch does not clear events, I trust that comes later in
the series, but I think it belongs here to make this patch a complete
standalone thought.

> +	if (status & CXLDEV_EVENT_STATUS_INFO)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +	if (status & CXLDEV_EVENT_STATUS_WARN)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +	if (status & CXLDEV_EVENT_STATUS_FAIL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> +	if (status & CXLDEV_EVENT_STATUS_FATAL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);

This retrieval order should be flipped. If there is a FATAL pending I
expect a monitor wants that first and would be happy to parse the INFO
later. I would go so far as to say that if the INFO logger is looping
and a FATAL comes in the driver should get that out first before going
back for more INFO logs. That would mean executing Clear Events and
looping through the logs by priority until all the status bits fall
silent inside cxl_mem_get_records_log().

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> @@ -846,6 +950,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
> +	mutex_init(&cxlds->event_buf_lock);
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..d4baae74cd97 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -132,6 +132,13 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
>  #define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
>  #define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
>  
> +/* CXL 3.0 8.2.8.3.1 Event Status Register */
> +#define CXLDEV_DEV_EVENT_STATUS_OFFSET		0x00
> +#define CXLDEV_EVENT_STATUS_INFO		BIT(0)
> +#define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> +#define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> +#define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index cd35f43fedd4..55d57f5a64bc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -4,6 +4,7 @@
>  #define __CXL_MEM_H__
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
> +#include <linux/uuid.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -250,12 +251,16 @@ struct cxl_dev_state {
>  
>  	bool msi_enabled;
>  
> +	struct cxl_get_event_payload *event_buf;
> +	struct mutex event_buf_lock;
> +

Missing kdoc.

>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -325,6 +330,72 @@ struct cxl_mbox_identify {
>  	u8 qos_telemetry_caps;
>  } __packed;
>  
> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +struct cxl_event_record_hdr {
> +	uuid_t id;
> +	u8 length;
> +	u8 flags[3];
> +	__le16 handle;
> +	__le16 related_handle;
> +	__le64 timestamp;
> +	u8 maint_op_class;
> +	u8 reserved[0xf];

Nit, but lets not copy the spec here and just make all the field sizes
decimal. It even saves a character to write 15 instead of 0xf, and @flags
is also decimal.

> +} __packed;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {
> +	struct cxl_event_record_hdr hdr;
> +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} __packed;
> +
> +/*
> + * Get Event Records output payload
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS		BIT(1)
> +struct cxl_get_event_payload {
> +	u8 flags;
> +	u8 reserved1;
> +	__le16 overflow_err_count;
> +	__le64 first_overflow_timestamp;
> +	__le64 last_overflow_timestamp;
> +	__le16 record_count;
> +	u8 reserved2[0xa];

Same nit.

> +	struct cxl_event_record_raw records[];
> +} __packed;
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> + */
> +enum cxl_event_log_type {
> +	CXL_EVENT_TYPE_INFO = 0x00,
> +	CXL_EVENT_TYPE_WARN,
> +	CXL_EVENT_TYPE_FAIL,
> +	CXL_EVENT_TYPE_FATAL,
> +	CXL_EVENT_TYPE_MAX
> +};
> +
> +static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
> +{
> +	switch (type) {
> +	case CXL_EVENT_TYPE_INFO:
> +		return "Informational";
> +	case CXL_EVENT_TYPE_WARN:
> +		return "Warning";
> +	case CXL_EVENT_TYPE_FAIL:
> +		return "Failure";
> +	case CXL_EVENT_TYPE_FATAL:
> +		return "Fatal";
> +	default:
> +		break;
> +	}
> +	return "<unknown>";
> +}
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> @@ -384,6 +455,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..c03a1a894af8
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_TRACE_EVENTS_H
> +
> +#include <asm-generic/unaligned.h>
> +#include <linux/tracepoint.h>
> +#include <cxlmem.h>
> +
> +TRACE_EVENT(cxl_overflow,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_get_event_payload *payload),
> +
> +	TP_ARGS(dev_name, log, payload),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(int, log)
> +		__field(u64, first_ts)
> +		__field(u64, last_ts)
> +		__field(u16, count)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		__entry->log = log;
> +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> +		__entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
> +		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
> +	),
> +
> +	TP_printk("%s: EVENT LOG OVERFLOW log=%s : %u records from %llu to %llu",
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
> +		__entry->count, __entry->first_ts, __entry->last_ts)
> +
> +);
> +
> +/*
> + * Common Event Record Format
> + * CXL 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
> +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
> +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
> +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> +#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
> +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \
> +)
> +
> +/*
> + * Define macros for the common header of each CXL event.
> + *
> + * Tracepoints using these macros must do 3 things:
> + *
> + *	1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
> + *	2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
> + *	   pass the dev_name, log, and CXL event header
> + *	3) Use CXL_EVT_TP_printk() instead of TP_printk()
> + *
> + * See the generic_event tracepoint as an example.
> + */
> +#define CXL_EVT_TP_entry					\
> +	__string(dev_name, dev_name)				\
> +	__field(int, log)					\
> +	__field_struct(uuid_t, hdr_uuid)			\
> +	__field(u32, hdr_flags)					\
> +	__field(u16, hdr_handle)				\
> +	__field(u16, hdr_related_handle)			\
> +	__field(u64, hdr_timestamp)				\
> +	__field(u8, hdr_length)					\
> +	__field(u8, hdr_maint_op_class)
> +
> +#define CXL_EVT_TP_fast_assign(dname, l, hdr)					\
> +	__assign_str(dev_name, (dname));					\
> +	__entry->log = (l);							\
> +	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> +	__entry->hdr_length = (hdr).length;					\
> +	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> +	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> +	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> +	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> +	__entry->hdr_maint_op_class = (hdr).maint_op_class
> +
> +#define CXL_EVT_TP_printk(fmt, ...) \
> +	TP_printk("%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "		\
> +		"handle=%x related_handle=%x maint_op_class=%u"			\
> +		" : " fmt,							\
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
> +		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> +		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
> +		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> +		##__VA_ARGS__)
> +
> +TRACE_EVENT(cxl_generic_event,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_record_raw *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
> +	),
> +
> +	CXL_EVT_TP_printk("%s",
> +		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> +);
> +
> +#endif /* _CXL_TRACE_EVENTS_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl
> +#include <trace/define_trace.h>
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..70459be5bdd4 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -24,6 +24,7 @@
>  	___C(IDENTIFY, "Identify Command"),                               \
>  	___C(RAW, "Raw device command"),                                  \
>  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
> +	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
>  	___C(GET_FW_INFO, "Get FW Info"),                                 \
>  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
>  	___C(GET_LSA, "Get Label Storage Area"),                          \

Yikes, no, this is an enum. New commands need to come at the end
otherwise different kernels will disagree about the command numbering.
Likely needs a comment here alerting future devs about the ABI breakage
danger here.
