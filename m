Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8B64011A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiLBHiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiLBHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:38:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCDB900C7;
        Thu,  1 Dec 2022 23:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669966688; x=1701502688;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aOf9ZuXdWPL28bBZdFIEPij7Ue3+c5uftUt17pmDSNo=;
  b=mnbZLxzAiQajuk3YXY7QAHogcJ8/j4pIWXCWQd6iKixffG6VuFbZ3P+k
   EIWmF2qHwag+T0joN/7gUB5+J6O44kvBuqmUNq1yVzHknHq/J5/f/GRqR
   MxM7T2lnPePzbEI+Bs68Pk1vZbn15DmLi9dk2U7W7j6wrvIawNY/wMkuU
   ik9QryMPiKZ40BbH7hUZoVTfS7XaSlgsSAfI+SLB26I7Spc4qDZsTqu+U
   mpl3TLkVsewCffZxHMoqPFPfeMZ9oatKCP+k16HmFXQs9EBdUSrRhCGli
   RS1iL0LUSlGXubSV7qZnACLuQs6NGwaPCeIiYIM8bEvshfIATuipDfzjP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="317038870"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="317038870"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 23:38:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708383635"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="708383635"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 23:38:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 23:38:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 23:38:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 23:38:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 23:38:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MraSGi24bxieEVOYgt5m3UhvILwvSpdpnyFHfXhHeRBxiP+dVtBKq07v3BlKGBzPPfKCzfd8GHoMLvb7DtSBcDVTxwcxeA1yavU2Cq8n11nrqiDHLROX3VVhLxaC3STTdIHj8ehdN9aTed0iPAi98S6aM0Y//lVxSLUWBXKEDY4ff5sypBXlREPwcucmm+gCUJ+/2S2bzohc+lsL0rVHX6Od3PURFJsFp9x8v5LHDNm+6tbd4NX+zpLQ3VtrUADsoZcD1oKOK5hx1JEfVDdIwzk0GukfVS6CnWOzRL8YJjasuyJ5gqwKZzFtYjR5zmTOCZmTkehN6zOWhmCIbD5noQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bhfAeC4WJHg1daHZ35xlet8K5XQU7rAyxvcn24R4Rs=;
 b=gY5pdmrYN1wk6blK0tny+mAYVj81sD2/kca5hL4ektnSdXMoMp7uMpVOwBFhTwZ5eGbYo08LljKVjmYbHuKqnrEvbv8VqDiJSsFf3ytakuEWFiMrBsnh666r3lhS5O0mX2t2mlx7QzJYFCrEZAKzSeDWnNp8IsSqPsxERrOXeTw90L8xHFo2+VI90Rztvdx+NzivJ72gvDBWTYy5PdDIinbIwCZKsVfvlG89m++750VX8D53acyIdE61sbaOqnUG67VbfB+SlJDj6H8Mwx3Rh4phSd+nUSR96jvk+RDI7C30mGaf59XKFXfmtJAmTdLru1UgbinBIwDFRWrjvUQUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4685.namprd11.prod.outlook.com
 (2603:10b6:806:9e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 07:37:58 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 07:37:58 +0000
Date:   Thu, 1 Dec 2022 23:37:53 -0800
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
Subject: RE: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Message-ID: <6389ab5156083_c9572947c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-9-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-9-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA0PR11MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: beee3112-813f-4d6d-3c4f-08dad4382184
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EX7mlhSeFXunOMKXNjb7ruLqrLEl8DHgcaUlzPEyEUjj5PNBeV4PskvRZXGq8/B2Q+rXHwQU9dcFgPDXuSw/TzNrfSCOhIqMsUGWNC3xg2x0ApEXFtOwz1siNgR6zyAAJnfgbRQ+pDG5MwbI8xSSwYEOXxiNLezhxr9Bs1msU05oJ+6okRWqks1WVRnHryMJsKSN468sewfXZYerhutg1e8mVmmtj5wBJ4dancxMN6uKmTpdmGy4zjZ94n3peMDh4EuDvoadtT4gzHKtTkXboC0Y7T4ev0HLcgyLWir4oyfcijM1vd09vw1VI6mX5M6z2N3TmXJ7noIDEKhY+KXzuAcvVNEbeQOU5ZAfduHtft0Jmye1FyEhjfifnB3W87Bv47Idcu8ZeFe4Lp2tmSXw+OLY7GWHAClNfJ0IFD6iiFesqV/ycTB7ZS/ySPX1+Xf9Gr9w4fwzoLCy/98cEBduPUYH44k++jfyfb4vbYal98ygdfp0OW0m82Zy5tLqf7cfTET6HoAw8CWoYMerRF5ssCfDvEQT2cWmAQ6IJQ+YZUFjcNcVpxh/BQYpnJImmLOD/6MFVbwrgrrwb5wYkm494LLs/MnxplpUjuDurdep5kyapnrpQeMcyA+N/P8zwaQCRkl8D+ZVkX7lF71+hK9zMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(2906002)(83380400001)(6200100001)(41300700001)(186003)(86362001)(8936002)(26005)(54906003)(6512007)(38100700002)(6862004)(9686003)(8676002)(82960400001)(30864003)(66476007)(5660300002)(66946007)(4326008)(66556008)(6486002)(316002)(478600001)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7eUNDRG08Xf60n0iZN3rj3NuWVvo6l2Rkng1df+ZFwepgdA46WFtBTJJVX46?=
 =?us-ascii?Q?5zibMQN6KBFugtnwyZDSdES9YNvHmisvxOA+K8a3X7jZGU0RhNMg0wfJFZqB?=
 =?us-ascii?Q?6DTjSEc+vAKWCBcxk14XVmd+YrTstndahNx/qQRFlV6Q5AG3rTf7/PUQpi1w?=
 =?us-ascii?Q?lDpN09wEj0+ZXVvJ6T1shVVsRL5Bhp7XAYYa/X7nb608p8xD1GOalfOxlgQW?=
 =?us-ascii?Q?MciwWdI61IFV2bVSWCLtc3CcDQoh00dnY69DlnWJG4q3jYMMS1p0OtXIDe7g?=
 =?us-ascii?Q?XqXUm3IcKJ0iuwaiL0vKdbSm0J6LpM1OWMxa9aPuL3jSyYRxzuTyfMjB9qfT?=
 =?us-ascii?Q?B6SyQQlUO/an++EwXzEloz0bvAUyASVG55QHLzG8hp95Rm3hw89EA+MxYK1X?=
 =?us-ascii?Q?j8Ux9U9cUQrXo/JaPcVJkKEoCYHabnFr46YDjg/eJEsunM/cdyo86sGdP2ym?=
 =?us-ascii?Q?nAXywH1gequ2woso3nFYb1GN2X2Uu3R5qn1r2AAsDYWG3vxNMxEiKdbyXkm4?=
 =?us-ascii?Q?xyO1EmQtURUMKO6Xoua2IpB1r84bR7JzZ1vPDVDFWOR1SqdxoBwijwv4fNm5?=
 =?us-ascii?Q?56h8tGFjgVleTYUjwL+Vl5Ag+tVisC8D5Nta7i4ybT9mRcqDjEzjY4H2ifLx?=
 =?us-ascii?Q?uXefGpk2tI6ag+OYflJkjzLtdHhew+qbuihhCQJ84qP24627OVfJnCVg/rn0?=
 =?us-ascii?Q?ei2TD0xKUAM2Jt5niELOn4oZnVrwPlebu/MmQyL5Wo56kiDA6pqwZ4N5P0uJ?=
 =?us-ascii?Q?sa/GgBxiRbqmEGK75NGfJ6v1PBgvR5MNoP3f0NKa8u9Ejz4JnKZ3Pov/szHM?=
 =?us-ascii?Q?SLAR89m2kUr7wex5i/TcTtp2kN8TJJdAaWcjUOoiS5fc637UDnX96eheDITe?=
 =?us-ascii?Q?Og0jYUDuXa+c54OUC9c96g1+xGLJOc21HSdeTX9HZg6KDAsr8TMaIX8Mr5xp?=
 =?us-ascii?Q?zsP8SyKwSrfbg0Pg1nV1gBt9XixudwuJrEPG+bJ6bUfSY9BUXVfXbTtZ27Rd?=
 =?us-ascii?Q?w5KR1DeMS/urFh2VFGB+uhbB4Y+hmZJLTCrhNjF4TlE/N7qiwpLN0HwTMD3v?=
 =?us-ascii?Q?c1kWZpkzG1kB670AHuPwSRB9cTyyQtxzY1SZACO4fCgqSLXfd8k1tnEP8yU/?=
 =?us-ascii?Q?4J9oZWgVn8TtDepB3c6xyacYZ0v5JKFrDdbeY9cvTXf89QKDhq30mwvHclb1?=
 =?us-ascii?Q?oukTXflSDiRCL5KTwMXTdG05Hz8EPQVufEBfNsElAD6obLWzbSCsllamJWCM?=
 =?us-ascii?Q?6cH41J1M4YZ+nFEBtVY2t5qwejBh5OKYWevgeLUEOAN+prNHVeBJ6qWkz9RN?=
 =?us-ascii?Q?DTHXEkXw4w2jpw0a0gZa/pVIceSJR+cKu9wCedIXyHqnM3PCjfWHZXMUpUs9?=
 =?us-ascii?Q?Te4jhdrR7wD6hnz45iQkgxeTz1vRavHD/kQwp9RzPhqIHFRjKBARZQTJNyEZ?=
 =?us-ascii?Q?dhk73eni/ivSG1KiTb3P4pN3M9jUUPARjRhAkfwVztDg1Ap3ZtDFjBTMYIhr?=
 =?us-ascii?Q?/z0spFhssUXAFKZD9xdkxCS99QrS+nQ29NxC4ZNkW8Ytab/5e36H6chK1O9l?=
 =?us-ascii?Q?t1JUKjB/HLceXqXn+3XlaTCRMwzYs6tMlyGTyNsDz9G6uL9MJBfzkvCPK7HB?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: beee3112-813f-4d6d-3c4f-08dad4382184
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:37:58.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeAKKHLQ6NTXWFomCjDDKy1ktaD6uqLHMHjnPOEmwvlpYR0eEfsju16AoJhHfg/KgqYQChtJzkjsN6lvEIoW4i6IDKJfRELpLT5OzkAcWnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL device events are signaled via interrupts.  Each event log may have
> a different interrupt message number.  These message numbers are
> reported in the Get Event Interrupt Policy mailbox command.
> 
> Add interrupt support for event logs.  Interrupts are allocated as
> shared interrupts.  Therefore, all or some event logs can share the same
> message number.

Definitely squash patch1 with this one, especially because this shows
that the ->msi_enabled portion of patch1 was unnecessary, see below.

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V1:
> 	Remove unneeded evt_int_policy from struct cxl_dev_state
> 	defer Dynamic Capacity support
> 	Dave Jiang
> 		s/irq/rc
> 		use IRQ_NONE to signal the irq was not for us.
> 	Jonathan
> 		use msi_enabled rather than nr_irq_vec
> 		On failure explicitly set CXL_INT_NONE
> 		Add comment for Get Event Interrupt Policy
> 		use devm_request_threaded_irq()
> 		Use individual handler/thread functions for each of the
> 		logs rather than struct cxl_event_irq_id.
> 
> Changes from RFC v2
> 	Adjust to new irq 16 vector allocation
> 	Jonathan
> 		Remove CXL_INT_RES
> 	Use irq threads to ensure mailbox commands are executed outside irq context
> 	Adjust for optional Dynamic Capacity log
> ---
>  drivers/cxl/core/mbox.c      |  44 +++++++++++-
>  drivers/cxl/cxlmem.h         |  30 ++++++++
>  drivers/cxl/pci.c            | 130 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h |   2 +
>  4 files changed, 204 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 30840b711381..1e00b49d8b06 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -53,6 +53,8 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
>  	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(CLEAR_EVENT_RECORD, CXL_VARIABLE_PAYLOAD, 0, 0),
> +	CXL_CMD(GET_EVT_INT_POLICY, 0, 0x5, 0),
> +	CXL_CMD(SET_EVT_INT_POLICY, 0x5, 0, 0),
>  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
>  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
>  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> @@ -806,8 +808,8 @@ static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> -static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> -				    enum cxl_event_log_type type)
> +void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +			     enum cxl_event_log_type type)
>  {
>  	struct cxl_get_event_payload *payload;
>  	u16 nr_rec;
> @@ -857,6 +859,7 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  unlock_buffer:
>  	mutex_unlock(&cxlds->event_buf_lock);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_records_log, CXL);
>  
>  static void cxl_mem_free_event_buffer(void *data)
>  {
> @@ -916,6 +919,43 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>  
> +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> +			     struct cxl_event_interrupt_policy *policy)
> +{
> +	int rc;
> +
> +	policy->info_settings = CXL_INT_MSI_MSIX;
> +	policy->warn_settings = CXL_INT_MSI_MSIX;
> +	policy->failure_settings = CXL_INT_MSI_MSIX;
> +	policy->fatal_settings = CXL_INT_MSI_MSIX;

I think this needs to be careful not to undo events that the BIOS
steered to itself in firmware-first mode, which raises another question,
does firmware-first mean more the OS needs to backoff on some event-log
handling as well?

> +
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_EVT_INT_POLICY,
> +			       policy, sizeof(*policy), NULL, 0);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
> +			rc);
> +
> +		policy->info_settings = CXL_INT_NONE;
> +		policy->warn_settings = CXL_INT_NONE;
> +		policy->failure_settings = CXL_INT_NONE;
> +		policy->fatal_settings = CXL_INT_NONE;
> +
> +		return rc;
> +	}
> +
> +	/* Retrieve interrupt message numbers */
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVT_INT_POLICY, NULL, 0,
> +			       policy, sizeof(*policy));
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> +			rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_event_config_msgnums, CXL);
> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 450b410f29f6..2d384b0fc2b3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -179,6 +179,30 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> +/**
> + * Event Interrupt Policy
> + *
> + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> + */
> +enum cxl_event_int_mode {
> +	CXL_INT_NONE		= 0x00,
> +	CXL_INT_MSI_MSIX	= 0x01,
> +	CXL_INT_FW		= 0x02
> +};
> +#define CXL_EVENT_INT_MODE_MASK 0x3
> +#define CXL_EVENT_INT_MSGNUM(setting) (((setting) & 0xf0) >> 4)
> +struct cxl_event_interrupt_policy {
> +	u8 info_settings;
> +	u8 warn_settings;
> +	u8 failure_settings;
> +	u8 fatal_settings;
> +} __packed;
> +
> +static inline bool cxl_evt_int_is_msi(u8 setting)
> +{
> +	return CXL_INT_MSI_MSIX == (setting & CXL_EVENT_INT_MODE_MASK);
> +}
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -262,6 +286,8 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -537,7 +563,11 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +			     enum cxl_event_log_type type);
>  void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
> +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> +			     struct cxl_event_interrupt_policy *policy);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 11e95a95195a..3c0b9199f11a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -449,6 +449,134 @@ static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
>  	cxlds->msi_enabled = true;
>  }
>  
> +static irqreturn_t cxl_event_info_thread(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t cxl_event_info_handler(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +
> +	if (CXLDEV_EVENT_STATUS_INFO & status)
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t cxl_event_warn_thread(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t cxl_event_warn_handler(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +
> +	if (CXLDEV_EVENT_STATUS_WARN & status)
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t cxl_event_failure_thread(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> +	return IRQ_HANDLED;
> +}

So I think one of the nice side effects of moving log priorty handling
inside of cxl_mem_get_records_log() and looping through all log types in
priority order until all status is clear is that an INFO interrupt also
triggers a check of the FATAL status for free.

You likely do not even need to do the status read in hardirq part of the
handler, just unconditionally wake the event handler thread. I.e. just
pass NULL for @handler to devm_request_threaded_irq() and let the
thread_fn figure it all out in priority order.

> +
> +static irqreturn_t cxl_event_failure_handler(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +
> +	if (CXLDEV_EVENT_STATUS_FAIL & status)
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t cxl_event_fatal_thread(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t cxl_event_fatal_handler(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +
> +	if (CXLDEV_EVENT_STATUS_FATAL & status)
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_NONE;
> +}
> +
> +static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_event_interrupt_policy policy;
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u8 setting;
> +	int rc;
> +
> +	if (cxl_event_config_msgnums(cxlds, &policy))
> +		return;
> +
> +	setting = policy.info_settings;
> +	if (cxl_evt_int_is_msi(setting)) {

So pci_irq_vector() automatically handles checking if msi is enabled and
will return a failure if either MSI is not enabled, or the message
number did not get a vector.

With that insight I would do something like this (untested):

@@ -521,7 +521,14 @@ static irqreturn_t cxl_event_fatal_handler(int irq, void *id)
        return IRQ_NONE;
 }
 
-static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
+static int cxl_evt_irq(struct pci_dev *pdev, u8 setting)
+{
+       if ((setting & CXL_EVENT_INT_MODE_MASK) != CXL_INT_MSI_MSIX)
+               return -ENXIO;
+       return pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting));
+}
+
+static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
 {
        struct cxl_event_interrupt_policy policy;
        struct device *dev = cxlds->dev;
@@ -529,18 +536,17 @@ static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
        u8 setting;
        int rc;
 
-       if (cxl_event_config_msgnums(cxlds, &policy))
-               return;
+       rc = cxl_event_config_msgnums(cxlds, &policy);
+       if (rc)
+               return rc;
 
-       setting = policy.info_settings;
-       if (cxl_evt_int_is_msi(setting)) {
-               rc = devm_request_threaded_irq(dev,
-                               pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
-                               cxl_event_info_handler, cxl_event_info_thread,
-                               IRQF_SHARED, NULL, cxlds);
-               if (rc)
-                       dev_err(dev, "Failed to get interrupt for %s event log\n",
-                               cxl_event_log_type_str(CXL_EVENT_TYPE_INFO));
+       rc = devm_request_threaded_irq(dev,
+                                      cxl_evt_irq(pdev, policy.info_settings),
+                                      NULL, cxl_event_info_thread, IRQF_SHARED,
+                                      NULL, cxlds);
+       if (rc) {
+               dev_err(dev, "Failed to get interrupt for INFO event log\n");
+               return rc;
        }
 
        setting = policy.warn_settings;



> +		rc = devm_request_threaded_irq(dev,
> +				pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
> +				cxl_event_info_handler, cxl_event_info_thread,
> +				IRQF_SHARED, NULL, cxlds);
> +		if (rc)
> +			dev_err(dev, "Failed to get interrupt for %s event log\n",
> +				cxl_event_log_type_str(CXL_EVENT_TYPE_INFO));

Per above, no need to use cxl_event_log_type_str() in these.

> +	}
> +
> +	setting = policy.warn_settings;
> +	if (cxl_evt_int_is_msi(setting)) {
> +		rc = devm_request_threaded_irq(dev,
> +				pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
> +				cxl_event_warn_handler, cxl_event_warn_thread,
> +				IRQF_SHARED, NULL, cxlds);
> +		if (rc)
> +			dev_err(dev, "Failed to get interrupt for %s event log\n",
> +				cxl_event_log_type_str(CXL_EVENT_TYPE_WARN));
> +	}
> +
> +	setting = policy.failure_settings;
> +	if (cxl_evt_int_is_msi(setting)) {
> +		rc = devm_request_threaded_irq(dev,
> +				pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
> +				cxl_event_failure_handler, cxl_event_failure_thread,
> +				IRQF_SHARED, NULL, cxlds);
> +		if (rc)
> +			dev_err(dev, "Failed to get interrupt for %s event log\n",
> +				cxl_event_log_type_str(CXL_EVENT_TYPE_FAIL));
> +	}
> +
> +	setting = policy.fatal_settings;
> +	if (cxl_evt_int_is_msi(setting)) {
> +		rc = devm_request_threaded_irq(dev,
> +				pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting)),
> +				cxl_event_fatal_handler, cxl_event_fatal_thread,
> +				IRQF_SHARED, NULL, cxlds);
> +		if (rc)
> +			dev_err(dev, "Failed to get interrupt for %s event log\n",
> +				cxl_event_log_type_str(CXL_EVENT_TYPE_FATAL));
> +	}
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -516,6 +644,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  
>  	cxl_pci_alloc_irq_vectors(cxlds);

There should be fail return here, or a comment why this can be skipped,
especially if the device claims to support events.

> +	if (cxlds->msi_enabled)
> +		cxl_event_irqsetup(cxlds);

Per above, do this unconditionally.

>  
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 7c1ad8062792..a8204802fcca 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -26,6 +26,8 @@
>  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
>  	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
>  	___C(CLEAR_EVENT_RECORD, "Clear Event Record"),                   \
> +	___C(GET_EVT_INT_POLICY, "Get Event Interrupt Policy"),           \
> +	___C(SET_EVT_INT_POLICY, "Set Event Interrupt Policy"),           \
>  	___C(GET_FW_INFO, "Get FW Info"),                                 \
>  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
>  	___C(GET_LSA, "Get Label Storage Area"),                          \

Same, "at the end" comment.
