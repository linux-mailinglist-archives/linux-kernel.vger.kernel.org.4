Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A218E640191
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiLBIH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiLBIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:07:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C720627B20;
        Fri,  2 Dec 2022 00:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669968468; x=1701504468;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=26+PJ0lr7J8DUYn8Jhl6zwHZkfVr7gJcEjFhkpj8cAY=;
  b=Lrog5DLqUHUXnFEDBj0wLz0CS9cAa2HTWfX8n43e2WVhJlgryuMaj2Tm
   VLKuhLY7OuBOgTa3w2tTVf1vI47yt8YqHRCW/PnxTQOjMx1txjyqfP3Ja
   PJW80mwFnh5VT9+teCZAkS96bS312PqHkKSlVueRMv66Neadi1cWMnlkU
   yeMOQTJfDLqmZuWFr5KrWXq9ZfwGYz5TOlCFpV/b7xh0bqK4fThxwpRTm
   YZrqVHXUBOaJt21dk1rrilE0sZVWM9O3IF7+snrBzIvKmAWE7LPllnJ7Z
   2UyIp78CY6T9eztnGjqv8LdtNR0M2HjRGPyEHjvVtSgQOm/PcX7dNnzo5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314600453"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="314600453"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 00:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="713536765"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="713536765"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 02 Dec 2022 00:07:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 00:07:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 00:07:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 00:07:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 00:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHFcvAd6a7OPcEJQVM8YBX926VejrMdhsKONFuDMwXG0X7X6BPu0jqwnfwmotowYhVohtipsioYpcdzjdcygU+2V58mWoovh0hZn/SAJL3swDEKorSe6LJO4qKQnnFm8Rg4oEywQJjW4TXecMP1/b0tt+VKxJl9Qf/v513j8Zdb2NWbmTWT/2va4bR3/ad6dOEhtXXINjt1NBGVLQkHsDORAQB9sw2ISrcOH/Ut21xSYuYUTF7fdaDXroukHPogVJsIGAqRJBu1LlSPToiuM6wzSQWFON1Lpw5AVq93ETRDURpvehruB7KOIjfBfld4tJ+mgDIWRtl5DMJ2mOGGAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYs/8rPvtlf3pHiO8VB+Rb/9/Iqtv7wqtjQlX8PDKzs=;
 b=Avib1eqqVjCfXm74vyO1ntR1zFrX+LWqgBS7Wuszw/14qMWbzuh70/jzyzSN5cjoP1SYzmKnjzgACp1znXKmY+Bzf+YkMpkQ+IH6XY4mzJGWVdccT+MdvJWqDe7QzMxkdkHcWkXTbVMLx4IFvIvdk9bfHBhmxKquJmxWeZISd4AWYNf/nlbytTNEMajEoLXfbzMuhIR0PsXs9/zeSfM48j1xlYdu4/m9Z76GvKFM7dnsxfKIjulVv7RbOGrneN+CaoLXP9Wx424NGB74dK9Jt1Aiu66tvHy8rCn1kPPv+Th9dIo9OiImYqi4ZGkugyg0ww2k0WUF1H47TptCrdXv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 08:07:42 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 08:07:42 +0000
Date:   Fri, 2 Dec 2022 00:07:39 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2 09/11] cxl/test: Add generic mock events
Message-ID: <6389b24bde3f0_c95729420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-10-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-10-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BN0PR11MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 707c815e-ae21-44dd-1ee6-08dad43c4997
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YScTTmj9DHmqiC309B+D3aBF1jb+Pz8HJJYC17b2RpHsuwcmf0NCnaheUelEpmgn15DUface4E1qmUS8mhBgD1NuIPVlc81b464PdnMUFMq6MFnhvvJ/BfYYuT5kI4urcpbSQ/YfQHkptXngqTMmSDVN/nl0gS1l9TM4r7gjqzvh7+oSk6eLSR/yifKV28NKB7w17Fp8OPK0AqOf7IkHk+aPBGSrPEzDJO5tX295LNnL4NHoJRT1NiDoLwXlA4lLGbd/ovazWHtHEeUmeoyvd+m2HNRXvmnWkcDGqFW5/JYvARRczF4tRSjk00dACwdyG1MoDt+k6QOFeIKCfs2tv/2LZN1GDlm/sHTdRVjGza3giI5GBOS/eFjFCCQ5ofTgA2OL8zyeAPItpJw8T7Q1njxRalfjhFP0DIAxjr6P9ODgmKoE2cYqEKIpd01anveZhZnmBLY+wHrTelp8cONvJtDceW6bBhI8+luzu696dKpYXMhS1mlD9LfUJdn+zGq8cGXjKUaf4YzcatxzjIohAQAcHKYqLqguJKb6RV80yEWQTiQqXTkDIT6LrA4xVYMeCzErndC+fnARnME3Lc0JI3rigfYrlV/Vs91LLvWrP7qvVLDmJav2z7z+R0WRzXd3JmSjU4NEEoJiBSCyifiql4mh1LxNKiTaOMNeHoSBV6nS2t1INWHqUG+XFqPBT+qCHprm7mT3X2QvapPo6oDrbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(83380400001)(86362001)(6200100001)(9686003)(6506007)(6512007)(6486002)(478600001)(38100700002)(82960400001)(186003)(8936002)(5660300002)(30864003)(41300700001)(6666004)(26005)(8676002)(66556008)(66476007)(66946007)(4326008)(6862004)(316002)(2906002)(54906003)(41533002)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PYd5DlWbmvQu/Z5xh6nJs+VI0OcmTIhsizxVZev+ORVFaln7675Txtn3p33+?=
 =?us-ascii?Q?YEBkHDdqlXt+w2S5Gk3YbWoFrgW2RZD46c38/bwxSeG2Bce+cLZUOzNc+ODs?=
 =?us-ascii?Q?A54Ygg1fH9y+IhVFxraF1kG3lxjQ55nnDMMvcFI/zLWDv7CfiKeOvxzJB/gx?=
 =?us-ascii?Q?LpxEWA0tQtGgz/0tyijBS7vg+tRVctvYdfA3YEcJfEyK2L8Y4VSRQankJjRA?=
 =?us-ascii?Q?o/YAVZTMikOVYbYUsDBKXt513JFSfgGKgCk3STeDKO0ebjCVk6nzaWSvMcel?=
 =?us-ascii?Q?14gMbXvkY7G966wqvYuknwQ++gQXp9x8vOmdk8KOnyD1YV82BKaUC+3v8myV?=
 =?us-ascii?Q?QrxOmNONyLiRUXwVCBd6s9YN6BlhFTYEr7U/hXd1/5qlpdYGdiCNVsaXQVEd?=
 =?us-ascii?Q?s6GQLIICDTTsFlF2daRFXJ31PVioJp3zGV4Sss6CgvQ98etC9uC2isKc0xAd?=
 =?us-ascii?Q?+oWAcMUUet/N9o0afkdHAeaV7ogA+eFI1i/WRm7MfXN/dXCEsD0yN7+rjOO1?=
 =?us-ascii?Q?oRX0KdNEx3n+nDlZfHZuC51hVM82RXEmx/7P8pstsiOCyVPo11IP0iEGE4wQ?=
 =?us-ascii?Q?fVNbHVoSlIlJGHm+BitqePefciUboMBHmoP6e6/b+wtM/kkYzMxCi2jjmYNw?=
 =?us-ascii?Q?vwvxfUBDWVEHsprEOQmG8G6M9C0bjQNn8uv87KkoJWIkSzj1Ri3f8IqZMrnL?=
 =?us-ascii?Q?VIaAEs/MK/JAU6x28/VUYtS5I5UW6BQ/6h8PEGpb7G/1uxZxaGW+174L0Clu?=
 =?us-ascii?Q?oU9p7Vfm1uXQnL0nFX0KyfgQHzneH4BU7jYTx4i5J6izz00ZSVmYP17Rp57r?=
 =?us-ascii?Q?Y7E8+Nl0rnz8a/7B33cGEfJgssLBYoy8VI+uiYyP8YBvglIO5NWspTN3XiTf?=
 =?us-ascii?Q?pvqeIgsfGs65P3OJwupJUXz4RGS/gr5u9CM0poEo+gg7OlbSQNWfXhCbc7GH?=
 =?us-ascii?Q?JEtjFroteYAmPtVlofZOJ/C5V7hdPb1YYYbMt5DXbX/w4PijlJuY26tY6oMe?=
 =?us-ascii?Q?o0rnrTwbWnw15QHQ6/ObW7foJlVWASrviLO6GVHfS9D0K9jCMokSvyUHfwxJ?=
 =?us-ascii?Q?7XJ0cQppG7iKVIGWqfZlHfoN5t350pa7qdvzTsLODry3SX4+8Jai6D4X1JPT?=
 =?us-ascii?Q?dptS3XHHct/nWQ6W2qF7I5x0ujbJ9zI86ZgV+ii6iBDyxhmoqjjnHwpEoH8L?=
 =?us-ascii?Q?Tb7WcF0FwTEQF5kyHLyvY7jeGZaVTt8yjnTVEyTcZ0aRIvZMHHEB1Na2Cg4w?=
 =?us-ascii?Q?RHHxljhgTsB1b+Q+eO03U4yiZDj98DM7jTqDIgYF/odr0OVaYS17uIBzQygc?=
 =?us-ascii?Q?kiaeV0yhe6AdP0THLqpW0khZ6KRoff8dneliZOXqpkJZY9AQdsAVvgy06OME?=
 =?us-ascii?Q?xkwTLv0GFV7c4r+7RIKZQ9iM3pSgZr14e69Ynqz4pQEU7W1/v/sKsnINfIBP?=
 =?us-ascii?Q?fA8InWhhzPbWGrPrrtpnfIt3rzspUTMm93wKm8bPAn1wbCtr3EDsHrbNtHQl?=
 =?us-ascii?Q?B3Io8hfUbnSGAFR1IXnf5RWn5qfPyaFmVyvPFvA0cC2Y9C+eAfrCb8E6m813?=
 =?us-ascii?Q?Y/mRnCC4ocLPQAkXo/hiKhhk9ZyDh5KCY3kZeKDxrGwdgMAI+SqJ4Izd3sv+?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 707c815e-ae21-44dd-1ee6-08dad43c4997
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 08:07:42.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+Bn6XIlV60NdoeyyRsKLF4/ptIlipbWLm5XUTgUSzMtqehzgduLINHNKePOiRg3pCweWC+B9f+yKiVclBUvgXL775toaN5mxkPd9yCWkg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5709
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
> Facilitate testing basic Get/Clear Event functionality by creating
> multiple logs and generic events with made up UUID's.
> 
> Data is completely made up with data patterns which should be easy to
> spot in trace output.
> 
> A single sysfs entry resets the event data and triggers collecting the
> events for testing.
> 
> Events are returned one at a time which is within the specification even
> though it does not exercise the full capabilities of what a device may
> do.
> 
> Test traces are easy to obtain with a small script such as this:
> 
> 	#!/bin/bash -x
> 
> 	devices=`find /sys/devices/platform -name cxl_mem*`
> 
> 	# Turn on tracing
> 	echo "" > /sys/kernel/tracing/trace
> 	echo 1 > /sys/kernel/tracing/events/cxl/enable
> 	echo 1 > /sys/kernel/tracing/tracing_on
> 
> 	# Generate fake interrupt
> 	for device in $devices; do
> 	        echo 1 > $device/event_trigger
> 	done
> 
> 	# Turn off tracing and report events
> 	echo 0 > /sys/kernel/tracing/tracing_on
> 	cat /sys/kernel/tracing/trace
> 

Nice, should be straightforward to copy-pasta that into a unit test
script.

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v1:
> 	Fix up for new structures
> 	Jonathan
> 		Update based on specification discussion
> 
> Changes from RFC v2:
> 	Adjust to simulate the event status register
> 
> Changes from RFC:
> 	Separate out the event code
> 	Adjust for struct changes.
> 	Clean up devm_cxl_mock_event_logs()
> 	Clean up naming and comments
> 	Jonathan
> 		Remove dynamic allocation of event logs
> 		Clean up comment
> 		Remove unneeded xarray
> 		Ensure event_trigger sysfs is valid prior to the driver
> 		going active.
> 	Dan
> 		Remove the fill/reset event sysfs as these operations
> 		can be done together
> ---
>  drivers/cxl/core/mbox.c         |  33 +++--
>  drivers/cxl/cxlmem.h            |   1 +
>  tools/testing/cxl/test/Kbuild   |   2 +-
>  tools/testing/cxl/test/events.c | 242 ++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/events.h |   9 ++
>  tools/testing/cxl/test/mem.c    |  35 ++++-
>  6 files changed, 307 insertions(+), 15 deletions(-)
>  create mode 100644 tools/testing/cxl/test/events.c
>  create mode 100644 tools/testing/cxl/test/events.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 1e00b49d8b06..17659b9a0408 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -886,20 +886,9 @@ static struct cxl_get_event_payload *alloc_event_buf(struct cxl_dev_state *cxlds
>  	return buf;
>  }
>  
> -/**
> - * cxl_mem_get_event_records - Get Event Records from the device
> - * @cxlds: The device data for the operation
> - *
> - * Retrieve all event records available on the device, report them as trace
> - * events, and clear them.
> - *
> - * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> - * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> - */
> -void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> +/* Direct call for mock testing */
> +void __cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
>  {
> -	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -
>  	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
>  
>  	if (!cxlds->event_buf) {
> @@ -917,6 +906,24 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
>  	if (status & CXLDEV_EVENT_STATUS_FATAL)
>  		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
>  }
> +EXPORT_SYMBOL_NS_GPL(__cxl_mem_get_event_records, CXL);
> +
> +/**
> + * cxl_mem_get_event_records - Get Event Records from the device
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve all event records available on the device, report them as trace
> + * events, and clear them.
> + *
> + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> + * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> + */
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> +{
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +
> +	__cxl_mem_get_event_records(cxlds, status);
> +}
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);

The unit tests should be minimally disruptive to the mainlie code, and
giving them their own private export is outside that spirit. Can you
rearrange so that the unit tests don't need their own export? Like all
callers pass the status?

>  
>  int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2d384b0fc2b3..10e3c1c893f3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -565,6 +565,7 @@ void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  			     enum cxl_event_log_type type);
> +void __cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
>  void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
>  int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
>  			     struct cxl_event_interrupt_policy *policy);
> diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
> index 4e59e2c911f6..64b14b83d8d9 100644
> --- a/tools/testing/cxl/test/Kbuild
> +++ b/tools/testing/cxl/test/Kbuild
> @@ -7,4 +7,4 @@ obj-m += cxl_mock_mem.o
>  
>  cxl_test-y := cxl.o
>  cxl_mock-y := mock.o
> -cxl_mock_mem-y := mem.o
> +cxl_mock_mem-y := mem.o events.o
> diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> new file mode 100644
> index 000000000000..a3d2ec7cc9fe
> --- /dev/null
> +++ b/tools/testing/cxl/test/events.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2022 Intel Corporation. All rights reserved.
> +
> +#include <cxlmem.h>
> +#include <trace/events/cxl.h>
> +
> +#include "events.h"
> +
> +#define CXL_TEST_EVENT_CNT_MAX 15
> +
> +/* Set a number of events to return at a time for simulation.  */
> +#define CXL_TEST_EVENT_CNT 3
> +
> +struct mock_event_log {
> +	u16 clear_idx;
> +	u16 cur_idx;
> +	u16 nr_events;
> +	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> +};
> +
> +struct mock_event_store {
> +	struct cxl_dev_state *cxlds;
> +	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
> +	u32 ev_status;
> +};
> +
> +DEFINE_XARRAY(mock_dev_event_store);
> +
> +struct mock_event_log *find_event_log(struct device *dev, int log_type)
> +{
> +	struct mock_event_store *mes = xa_load(&mock_dev_event_store,
> +					       (unsigned long)dev);
> +
> +	if (!mes || log_type >= CXL_EVENT_TYPE_MAX)
> +		return NULL;
> +	return &mes->mock_logs[log_type];
> +}
> +
> +struct cxl_event_record_raw *get_cur_event(struct mock_event_log *log)
> +{
> +	return log->events[log->cur_idx];
> +}
> +
> +void reset_event_log(struct mock_event_log *log)
> +{
> +	log->cur_idx = 0;
> +	log->clear_idx = 0;
> +}
> +
> +/* Handle can never be 0 use 1 based indexing for handle */
> +u16 get_clear_handle(struct mock_event_log *log)
> +{
> +	return log->clear_idx + 1;
> +}
> +
> +/* Handle can never be 0 use 1 based indexing for handle */
> +__le16 get_cur_event_handle(struct mock_event_log *log)
> +{
> +	u16 cur_handle = log->cur_idx + 1;
> +
> +	return cpu_to_le16(cur_handle);
> +}
> +
> +static bool log_empty(struct mock_event_log *log)
> +{
> +	return log->cur_idx == log->nr_events;
> +}
> +
> +static void event_store_add_event(struct mock_event_store *mes,
> +				  enum cxl_event_log_type log_type,
> +				  struct cxl_event_record_raw *event)
> +{
> +	struct mock_event_log *log;
> +
> +	if (WARN_ON(log_type >= CXL_EVENT_TYPE_MAX))
> +		return;
> +
> +	log = &mes->mock_logs[log_type];
> +	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
> +		return;
> +
> +	log->events[log->nr_events] = event;
> +	log->nr_events++;
> +}
> +
> +int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_get_event_payload *pl;
> +	struct mock_event_log *log;
> +	u8 log_type;
> +	int i;
> +
> +	if (cmd->size_in != sizeof(log_type))
> +		return -EINVAL;
> +
> +	if (cmd->size_out < struct_size(pl, records, CXL_TEST_EVENT_CNT))
> +		return -EINVAL;
> +
> +	log_type = *((u8 *)cmd->payload_in);
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	memset(cmd->payload_out, 0, cmd->size_out);
> +
> +	log = find_event_log(cxlds->dev, log_type);
> +	if (!log || log_empty(log))
> +		return 0;
> +
> +	pl = cmd->payload_out;
> +
> +	for (i = 0; i < CXL_TEST_EVENT_CNT && !log_empty(log); i++) {
> +		memcpy(&pl->records[i], get_cur_event(log), sizeof(pl->records[i]));
> +		pl->records[i].hdr.handle = get_cur_event_handle(log);
> +		log->cur_idx++;
> +	}
> +
> +	pl->record_count = cpu_to_le16(i);
> +	if (!log_empty(log))
> +		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mock_get_event);
> +
> +int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> +	struct mock_event_log *log;
> +	u8 log_type = pl->event_log;
> +	u16 handle;
> +	int nr;
> +
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	log = find_event_log(cxlds->dev, log_type);
> +	if (!log)
> +		return 0; /* No mock data in this log */
> +
> +	/*
> +	 * This check is technically not invalid per the specification AFAICS.
> +	 * (The host could 'guess' handles and clear them in order).
> +	 * However, this is not good behavior for the host so test it.
> +	 */
> +	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
> +		dev_err(cxlds->dev,
> +			"Attempting to clear more events than returned!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Check handle order prior to clearing events */
> +	for (nr = 0, handle = get_clear_handle(log);
> +	     nr < pl->nr_recs;
> +	     nr++, handle++) {
> +		if (handle != le16_to_cpu(pl->handle[nr])) {
> +			dev_err(cxlds->dev, "Clearing events out of order\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Clear events */
> +	log->clear_idx += pl->nr_recs;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mock_clear_event);

Why is this exported? The caller is in the same compilation unit.

> +
> +void cxl_mock_event_trigger(struct device *dev)
> +{
> +	struct mock_event_store *mes = xa_load(&mock_dev_event_store,
> +					       (unsigned long)dev);
> +	int i;
> +
> +	for (i = CXL_EVENT_TYPE_INFO; i < CXL_EVENT_TYPE_MAX; i++) {
> +		struct mock_event_log *log;
> +
> +		log = find_event_log(dev, i);
> +		if (log)
> +			reset_event_log(log);
> +	}
> +
> +	__cxl_mem_get_event_records(mes->cxlds, mes->ev_status);
> +}
> +EXPORT_SYMBOL_GPL(cxl_mock_event_trigger);

Ditto on the export question.

> +
> +struct cxl_event_record_raw maint_needed = {
> +	.hdr = {
> +		.id = UUID_INIT(0xDEADBEEF, 0xCAFE, 0xBABE,
> +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +		.length = sizeof(struct cxl_event_record_raw),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0xa5b6),
> +	},
> +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +struct cxl_event_record_raw hardware_replace = {
> +	.hdr = {
> +		.id = UUID_INIT(0xBABECAFE, 0xBEEF, 0xDEAD,
> +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +		.length = sizeof(struct cxl_event_record_raw),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0xb6a5),
> +	},
> +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct mock_event_store *mes;
> +
> +	mes = devm_kzalloc(dev, sizeof(*mes), GFP_KERNEL);
> +	if (WARN_ON(!mes))
> +		return 0;

Why a WARN? Perhaps make this return 'struct mock_event_store *' or an
ERR_PTR.


> +	mes->cxlds = cxlds;
> +
> +	if (xa_insert(&mock_dev_event_store, (unsigned long)dev, mes,
> +		      GFP_KERNEL)) {
> +		dev_err(dev, "Event store not available for %s\n",
> +			dev_name(dev));

Downgraded to a dev_err() rather than a WARN is nice, but I think this
just wants to be something that hangs off of dev_get_drvdata(). See what
Dave and I came up with for his extra variables in the security unit
test. You might want to base on the for-6.2/cxl-security branch since
there are some other conflicts with dev_groups too.

> +		return 0;
> +	}
> +
> +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
> +
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
> +
> +	return mes->ev_status;
> +}
> +EXPORT_SYMBOL_GPL(cxl_mock_add_event_logs);

Another export to remove.

> +
> +void cxl_mock_remove_event_logs(struct device *dev)

Unnecessary if cxl_mock_event_store move to dev_get_drvdata().

> +{
> +	struct mock_event_store *mes;
> +
> +	mes = xa_erase(&mock_dev_event_store, (unsigned long)dev);
> +}
> +EXPORT_SYMBOL_GPL(cxl_mock_remove_event_logs);
> diff --git a/tools/testing/cxl/test/events.h b/tools/testing/cxl/test/events.h
> new file mode 100644
> index 000000000000..5bebc6a0a01b
> --- /dev/null
> +++ b/tools/testing/cxl/test/events.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <cxlmem.h>
> +
> +int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> +int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> +u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds);
> +void cxl_mock_remove_event_logs(struct device *dev);
> +void cxl_mock_event_trigger(struct device *dev);
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index e2f5445d24ff..333fa8527a07 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -8,6 +8,7 @@
>  #include <linux/sizes.h>
>  #include <linux/bits.h>
>  #include <cxlmem.h>
> +#include "events.h"
>  
>  #define LSA_SIZE SZ_128K
>  #define DEV_SIZE SZ_2G
> @@ -224,6 +225,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_GET_PARTITION_INFO:
>  		rc = mock_partition_info(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_GET_EVENT_RECORD:
> +		rc = mock_get_event(cxlds, cmd);
> +		break;
> +	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
> +		rc = mock_clear_event(cxlds, cmd);
> +		break;
>  	case CXL_MBOX_OP_SET_LSA:
>  		rc = mock_set_lsa(cxlds, cmd);
>  		break;
> @@ -245,11 +252,27 @@ static void label_area_release(void *lsa)
>  	vfree(lsa);
>  }
>  
> +static ssize_t event_trigger_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	cxl_mock_event_trigger(dev);
> +	return count;
> +}
> +static DEVICE_ATTR_WO(event_trigger);
> +
> +static struct attribute *cxl_mock_event_attrs[] = {
> +	&dev_attr_event_trigger.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(cxl_mock_event);
> +
>  static int cxl_mock_mem_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dev_state *cxlds;
> +	u32 ev_status;
>  	void *lsa;
>  	int rc;
>  
> @@ -281,11 +304,13 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	ev_status = cxl_mock_add_event_logs(cxlds);
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> -	cxl_mem_get_event_records(cxlds);
> +	__cxl_mem_get_event_records(cxlds, ev_status);
>  
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = devm_cxl_add_nvdimm(dev, cxlmd);
> @@ -293,6 +318,12 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int cxl_mock_mem_remove(struct platform_device *pdev)

It's moot with the comment above about moving to drvdata, but I
otherwise would have expected:

devm_add_action_or_reset(dev, cxl_mock_remove_event_logs, mes);

...in the probe path. Otherwse, I just got rid of the only .revove()
handler in the CXL subsystem the for-6.2/cxl-rch branch.

> +{
> +	cxl_mock_remove_event_logs(&pdev->dev);
> +	return 0;
> +}
> +
>  static const struct platform_device_id cxl_mock_mem_ids[] = {
>  	{ .name = "cxl_mem", },
>  	{ },
> @@ -301,9 +332,11 @@ MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);
>  
>  static struct platform_driver cxl_mock_mem_driver = {
>  	.probe = cxl_mock_mem_probe,
> +	.remove = cxl_mock_mem_remove,
>  	.id_table = cxl_mock_mem_ids,
>  	.driver = {
>  		.name = KBUILD_MODNAME,
> +		.dev_groups = cxl_mock_event_groups,

Looks good, but you'll need to append yours to the ones that Dave added
for the security state machine.

>  	},
>  };
>  
> -- 
> 2.37.2
> 


