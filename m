Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8915FF40F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJNTWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiJNTWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:22:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBD133333;
        Fri, 14 Oct 2022 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665775318; x=1697311318;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8vBAVv/1Gq1h/a74Yzqn5IeveyEgnMjT95bMKBJ1aEs=;
  b=E1rdjbLMyUtaVzFIZtCJHF9/QlKYjIZ5p/5J35Z4GlQmotUPmN7n23oY
   Q6BwvdCQPa1R224l5XyEHwIIBaYT6QuHSHtvw9pBaQrlFmLqe6PiJTeB0
   8okay+cZzYuI3B24tzQsEBiDUaRYex/nPL/FkgovuDEnpr04nD9WC7FKF
   +Qsk091PeClkOmZYAOvdk6U7NkufvzTD1V/tkXoxT1NasqNENtCCIAP3W
   kydSjNYEon+iHW1pBfHePdeLwfyXNcpFY+Rxniek4jgtpxBadIx6fuO6w
   ej+NYpYY+mbkQXCMtQu1sOPyBMp23XLthvDsTjsOpdjD7wFx0I3rzB2mW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="307111563"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="307111563"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 12:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="956694541"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="956694541"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2022 12:21:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 12:21:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 12:21:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 12:21:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 12:21:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kchTTimObqq3uD5ZLKG3rcvb7oKTM3qRoShDNS0SgMbH4YvY3YEu6Q9tFfKQHfNL8lxpFvBd7GICYzHlFdwkTv033ALwBoF53lrBfODI20J8eBlwrz5FQrcKtMpjqM0oQiE0HtrqGTXTGTPOM2+AVS4G0Mw+vrSpydS2iVw77gfiu5e+z+yiOMkX5DvGwlPs5hAbja/CWu0A7MdGueo7GTzkfoOhRvuZxfmLEU07GczIcinNqc+GNVO+scanLMxdQv3OcfkJs7QtIqpfZWXLJyIo7rlCBMip/iucwLQCOQZ+oP4CG173E8DASjQ9t4bfnfwR84uW2cQ+K6w4qUCxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjY2dmp6UGl8sLM4zechmRbPvau1jrlNiqPlBfwvhG8=;
 b=MJJOdKM4s5DaQ9VGtCVqxcd2B0VY0Q4cJlL2ZV6TDF++h8duD7WTv+7oy5deUeOVLj4QeK53qs0A7cFJnClh2asqijibeOXzTujDGG/lCrdmKY8CSxy9H2k54xAPtCW7TR1Y2oelmG2EbTkqE/VBPDwaJzQ6C1bN5KsPIdll3nuGNlhL6dpSSjpXVfCvIBLh2wNqKtgWs0kqM7/gRcbdRL6941eXlMfme88gATthQN3ZDe3Q8pFWhqZr6T3F909b9i02W2dnRsE+T8NLocn9ZL5a4+K7PnXwEk8rc1KVXqAzc6iJm4TW6DjXTMdzlcpxRygDYecHZf6OyfBC0nbhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 19:21:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 19:21:54 +0000
Date:   Fri, 14 Oct 2022 12:21:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [RFC V2 PATCH 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y0m2zSYTbctJgChj@iweiny-mobl>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-3-ira.weiny@intel.com>
 <20221011133920.00007945@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221011133920.00007945@huawei.com>
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: c878619a-17e3-4af9-2209-08daae195a78
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltVAlbEr1iHipRTzhl9dlbnXYRvlFXM95yEdvBgrdl1krrWB8XmnJucToMoXMeORe3hipb7R9dhDKfG1NceErjDreliGkAgS9huI4vq6NoOqPdTfV3GSD1SiHiomHU6JTmdNMUO+FKICJTpIGCoq/lD3oa2wn1zRnZAEvIKR5WC+8Y5X4KiqAMIAgvZ318+6PkqDcVWMDg1wlGkLII/cXTl8ZxCjHBONnWrKj4dP9miqbQUzvKwUB06M7LEmDVE1Co4IC7U4BYrjmd+niYD4dz7LUYkmdTMPDcIVFPb9076Ol2HJg951WlEgEclMHn1CiLL9zKo2czum/QTQfS/aOvZdyIFKlcX7cyIZX5h58aW4nrO7Ok7r+A1jaYB6TILP4ZU0rMtmzVLPZV7KUpg2H3l2Qljjml9vYm8OKW0k3uisLttX8XG05mX6CDNyqb8gXYg7Qx4nN4Hf8E1E+JFwN7DtGtJMnOqSgXUclwlEHGXKsqQbIfPYdDT15N5UitaxIAoyxaXppMU2n8e3fZbp+4lTKQjjOKiA170J25sqtd39ZAFvyRWQqOK+hMOaR+Q5K5VqE6wWOPQuZGUfC0o3Er9RWnT4oRadeLRFBJ6ucV0OEHuqQQMftFz0pvYczoaEWM6I7F/OCf7D2AOcPMG8mx5zAhavV3ttrbsQfzZOOqSprfz4DBCK+qY73/dXDvkWtltYmX3+w+U6950pmBVhpOMRSs+VjAqwT7x7o38Kv3ezm2km7K2X/ZMuD6VRlpaCwGYzP0vEnRLSVfe4MMqznA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199015)(8936002)(6486002)(54906003)(82960400001)(316002)(478600001)(33716001)(8676002)(186003)(66946007)(66556008)(66476007)(6916009)(2906002)(38100700002)(6666004)(4326008)(5660300002)(6506007)(41300700001)(26005)(30864003)(9686003)(6512007)(44832011)(86362001)(83380400001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xU8gz7AY/bGVW4NKyNrkYIR8RhGJ5AF7O1hmyZVGzx9YTa2xHnJcx9SlhoYM?=
 =?us-ascii?Q?mTCgIqlaa1PDpGqMbNSSaf6aJoovTzW18RtVsDEMsALicuYWBw+MFjyatip1?=
 =?us-ascii?Q?rqF5zVwUlp839Rx7IsF7gmpZU7uwUKFaAEFN74zHtvUedA7FGQflbyn/kQ2Y?=
 =?us-ascii?Q?wAOl40TV6CHxS4YBPTdJu9LmF/0Ix/UHpRn85JZQhU2k9H1wBO4jYkXRaVb7?=
 =?us-ascii?Q?3fIB043zh1Vh5HRjuA/IweGCv6am2Ul1lTJH+uCo42xRvnbagGhDS9MRbucj?=
 =?us-ascii?Q?sZYlx6M9isVnSio2uKFKYz52EMm3KsV/7Zu0ADEFMGYqrBXanir9eUEwbh/V?=
 =?us-ascii?Q?5GdecEuJDlHkGeJj0FEptG3M8LIAZ7YtymYiTL3Rc9SyUjxY+eF+uTmIXkc1?=
 =?us-ascii?Q?MrqT7/9EvzU6BuJW/42iIyjVGPOcfwCgCq0zcbmClff6jZET6iWjowULPPb2?=
 =?us-ascii?Q?ELlr7XHwPLANSLTjZfVk+ES7ixAN4rFxfZ/CGi2JWSxxmZqpsX8YtKven6UV?=
 =?us-ascii?Q?bzxGhfAPvA56bb2yxnlDvgyAJJ1OBTVeoKC5raNWu2uTfcwsXr4PrHt8sPo2?=
 =?us-ascii?Q?cGYQ60mfypNxe2aXoTxJfKDIQx04EW6xGSxrUpsfn3NzD0oV5K1XlxadJ0wm?=
 =?us-ascii?Q?1+SYRt3zDL1D11+LsSqxsm1aVFKSjlNyZrbmvFxgv9yA48kleBTKaX8q7J0y?=
 =?us-ascii?Q?unl35ouS7Bi47HPveerLokS7/OSCRYgEiRBMK0L2zGE26zp0I0TeamSXP+ue?=
 =?us-ascii?Q?vswVysI3GxCCouh+D0GvDv/kOaGPwMHrf5kWesCTkp2woa8ewU5dqNEUfQvA?=
 =?us-ascii?Q?059tK80QqKO3fpjIRmHo0Iz2du7Bi/UNNuXpff6d7a95JzgGM9kMAJN6VNpl?=
 =?us-ascii?Q?peCNi1HCU5vVfguUAdWKQB0vJ1q9OYE6bbYwBEY3ZFL7bvX5Hjkxgq3v9r77?=
 =?us-ascii?Q?cTPEg2BNX3ULsNUS3dXMilVEqrPnx5U6qT1DyQ8XbbxMi60bDQfoAzDYOuOu?=
 =?us-ascii?Q?XhhAIgLUL9zitC15+gj33r9qoqOJm4btl8tTbqha4LCtA3WW79V08xX85tXj?=
 =?us-ascii?Q?qwx6vrQ8GwASohJGte+Qz2Rs9V8IwfI1K7NXcziRgu0paw+WIDpXNP6iGaRF?=
 =?us-ascii?Q?B0myMP26Ee9H/zcMPq29vdN7ANRy14SzPv72Snp4ZF8a5mddZKo9sO2chrma?=
 =?us-ascii?Q?BfW20gWummrcT6O2kA7H10L652v1fNJk9r7IEUERzMuOZR7J+Jn6VNgNzw77?=
 =?us-ascii?Q?V5l1QC1jTr6jdFxQ8VoU9b3/fDdZSP+rrWAUBY8k3cUItum4rGY6GtgybGOg?=
 =?us-ascii?Q?Q7uyqRI7V3PDacrbth9S0TFVQMnPh3zYmujrHQ4Z2vJHLhjFVusP6eezHGtI?=
 =?us-ascii?Q?tlH/+roi93ue1KChVm4kEJFLOwaJAi0o/vqV7vXGRx/YMz9t6QT5bW61D8Gk?=
 =?us-ascii?Q?9IYZhlg7zz7OQjsY82iMNPIEjqxv4Vr4D0CizBzyvpjLm9R685qqjBHRlz6L?=
 =?us-ascii?Q?VpX6YUsm1dXT9qH7OhKYfppK4kpNe+VR9JsWmetR5OoMWTbRmL0b6xjyxMI+?=
 =?us-ascii?Q?+lanSgLioevkb/5KwHjwcQ8MrtS/FpQErko3zzA1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c878619a-17e3-4af9-2209-08daae195a78
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 19:21:54.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AE8W37xTBnBpciYacJ7RXD/xTCt+2VMFoXNTbU2cLmAMsYfKfTokmpYZkemE58aVK6BmQLga9WD+sN0dWvMoxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:39:20PM +0100, Jonathan Cameron wrote:
> On Mon, 10 Oct 2022 15:41:22 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Event records are defined for CXL devices.  Each record is reported in
> > one event log.  Devices are required to support the storage of at least
> > one event record in each event log type.
> > 
> > Devices track event log overflow by incrementing a counter and tracking
> > the time of the first and last overflow event seen.
> > 
> > Software queries events via the Get Event Record mailbox command; CXL
> > rev 3.0 section 8.2.9.2.2.
> > 
> > Issue the Get Event Record mailbox command on driver load.  Trace each
> > record found, as well as any overflow conditions.  Only 1 event is
> > requested for each query.  Optimization of multiple record queries is
> > deferred.
> > 
> > This patch traces a raw event record only and leaves the specific event
> > record types to subsequent patches.
> > 
> > Macros are created to use for the common CXL Event header fields.
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Hi Ira,
> 
> This looks basically fine, but I'm not convinced that it is a good
> or sustainable idea to report reserved fields from the underlying
> events in the trace events.
> If they are defined to have meaning later, we can't remove them from
> the 'reserved' field with out breaking backwards compatibility.
> So we end up with a weird mixture of some fields in both reserved and
> new entries in the TP and some not.

I removed the reserved fields from the data but I forgot the header.  I think I
had a reason they would be useful in the header but I forget now.  Which means
I was probably wrong.  ;-)

> 
> I've cc'd Mauro as he's probably more experienced in how to handle this
> sort of stuff than anyone else I know.
>

Fair enough but I agree the reserved fields should be removed.

> 
> Jonathan
> 
> > 
> > ---
> > Change from RFC:
> > 	Remove redundant error message in get event records loop
> > 	s/EVENT_RECORD_DATA_LENGTH/CXL_EVENT_RECORD_DATA_LENGTH
> > 	Use hdr_uuid for the header UUID field
> > 	Use cxl_event_log_type_str() for the trace events
> > 	Create macros for the header fields and common entries of each event
> > 	Add reserved buffer output dump
> > 	Report error if event query fails
> > 	Remove unused record_cnt variable
> > 	Steven - reorder overflow record
> > 		Remove NOTE about checkpatch
> > 	Jonathan
> > 		check for exactly 1 record
> > 		s/v3.0/rev 3.0
> > 		Use 3 byte fields for 24bit fields
> > 		Add 3.0 Maintenance Operation Class
> > 		Add Dynamic Capacity log type
> > 		Fix spelling
> > 	Dave Jiang/Dan/Alison
> > 		s/cxl-event/cxl
> > 		trace/events/cxl-events => trace/events/cxl.h
> > 		s/cxl_event_overflow/overflow
> > 		s/cxl_event/generic_event
> > ---
> 
> ... 
> 
> > +/**
> > + * cxl_mem_get_event_records - Get Event Records from the device
> > + * @cxlds: The device data for the operation
> > + *
> > + * Retrieve all event records available on the device and report them as trace
> > + * events.
> > + *
> > + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> > + */
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> > +{
> > +	enum cxl_event_log_type log_type;
> > +
> > +	dev_dbg(cxlds->dev, "Reading event logs\n");
> > +
> > +	for (log_type = CXL_EVENT_TYPE_INFO;
> 
> I'd start at 0.  To my mind that's clearer than this which
> basically says there is a contiguous range that may or may
> not be 0 based.

Ok.  But weather or not it is 0 based does not matter.

I'll change it.  It takes out a line of code!  ;-)

> 
> > +	     log_type < CXL_EVENT_TYPE_MAX; log_type++)
> > +		cxl_mem_get_records_log(cxlds, log_type);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> > +
> >  /**
> >   * cxl_mem_get_partition_info - Get partition info
> >   * @cxlds: The device data for the operation
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 88e3a8e54b6a..fa8d248fb299 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -4,6 +4,7 @@
> >  #define __CXL_MEM_H__
> >  #include <uapi/linux/cxl_mem.h>
> >  #include <linux/cdev.h>
> > +#include <linux/uuid.h>
> >  #include "cxl.h"
> >  
> >  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> > @@ -253,6 +254,7 @@ struct cxl_dev_state {
> >  enum cxl_opcode {
> >  	CXL_MBOX_OP_INVALID		= 0x0000,
> >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > @@ -322,6 +324,78 @@ struct cxl_mbox_identify {
> >  	u8 qos_telemetry_caps;
> >  } __packed;
> >  
> > +/*
> > + * Common Event Record Format
> > + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> > + */
> > +#define CXL_EVENT_REC_HDR_RES_LEN 0xf
> > +struct cxl_event_record_hdr {
> > +	uuid_t id;
> > +	u8 length;
> > +	u8 flags[3];
> > +	__le16 handle;
> > +	__le16 related_handle;
> > +	__le64 timestamp;
> > +	u8 maint_op_class;
> > +	u8 reserved[CXL_EVENT_REC_HDR_RES_LEN];
> > +} __packed;
> > +
> > +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> > +struct cxl_event_record_raw {
> 
> I'd like some comments here on 'why' this makes sense.
> Is expectation that it's here for future CXL spec definitions
> or is it intended to allow some reporting of vendor defined
> records?  Actually maybe a comment down at the TP would make more
> sense than here.  Either way comment somewhere :)

This comes from a discussion I had with Dan a while back where we decided that
any unknown record would just be dumped to user space as data.  The idea was
based on the kernel ignoring vendor specified events but does allow for some
future CXL spec definitios to get through.

This may cause similar confusion to the reserved fields but I don't think it is
quite the same.

I'll add a comment.

> 
> > +	struct cxl_event_record_hdr hdr;
> > +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> > +} __packed;
> > +
> 
> 
> > +static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
> > +{
> > +	switch (type) {
> > +	case CXL_EVENT_TYPE_INFO:
> > +		return "Informational";
> > +	case CXL_EVENT_TYPE_WARN:
> > +		return "Warning";
> > +	case CXL_EVENT_TYPE_FAIL:
> > +		return "Failure";
> > +	case CXL_EVENT_TYPE_FATAL:
> > +		return "Fatal";
> > +	case CXL_EVENT_TYPE_DYNAMIC_CAP:
> > +		return "Dynamic Capacity";
> Array of const char * that you pick from (with limit check) maybe rather than a switch?
> Doesn't matter that much though.

I've seen it both ways.  This forces users to use the helper.  And I don't
think there is much concern about the speed of the lookup.

> 
> > +	default:
> > +		break;
> > +	}
> > +	return "<unknown>";
> > +}
> > +
> >  struct cxl_mbox_get_partition_info {
> >  	__le64 active_volatile_cap;
> >  	__le64 active_persistent_cap;
> > @@ -381,6 +455,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> >  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> >  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
> >  #ifdef CONFIG_CXL_SUSPEND
> >  void cxl_mem_active_inc(void);
> >  void cxl_mem_active_dec(void);
> > diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> > new file mode 100644
> > index 000000000000..318ba5fe046e
> > --- /dev/null
> > +++ b/include/trace/events/cxl.h
> > @@ -0,0 +1,130 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM cxl
> > +
> > +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> > +#define _CXL_TRACE_EVENTS_H
> > +
> > +#include <asm-generic/unaligned.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(overflow,
> > +
> > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > +		 struct cxl_get_event_payload *payload),
> > +
> > +	TP_ARGS(dev_name, log, payload),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(dev_name, dev_name)
> > +		__field(int, log)
> > +		__field(u64, first)
> 
> first_ts maybe?  first alone is a bit vague.

Agreed.  Changed to first_ts and last_ts.

> 
> > +		__field(u64, last)
> > +		__field(u16, count)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(dev_name, dev_name);
> > +		__entry->log = log;
> > +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> > +		__entry->first = le64_to_cpu(payload->first_overflow_timestamp);
> > +		__entry->last = le64_to_cpu(payload->last_overflow_timestamp);
> > +	),
> > +
> > +	TP_printk("%s: EVENT LOG OVERFLOW log=%s : %u records from %llu to %llu",
> > +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
> 
> So we have a potential header include ordering issue given this header doesn't
> include the definition of cxl_event_log_type_str()?

The RFC had a __print_symbolic() conversion which was redundant.  I really
don't like having 2 conversion routines for this string.  I think it will
result in maintenance issues down the line.

I'll try and resolve it.  Nothing I have tried this morning seems to work.  I
may just go back to what I had.  I need to double check the user space code
too.

> 
> > +		__entry->count, __entry->first, __entry->last)
> > +
> > +);
> > +
> > +/*
> > + * Common Event Record Format
> > + * CXL 3.0 section 8.2.9.2.1; Table 8-42
> > + */
> > +#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
> > +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
> > +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
> > +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> > +#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
> > +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"Permanent Condition"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"Maintenance Needed"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> > +)
> > +
> > +/*
> > + * Define macros for the common header of each CXL event.
> > + *
> > + * Tracepoints using these macros must do 3 things:
> > + *
> > + *	1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
> > + *	2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
> > + *	   pass the dev_name, log, and CXL event header
> > + *	3) Use CXL_EVT_TP_printk() instead of TP_printk()
> > + *
> > + * See the generic_event tracepoint as an example.
> > + */
> > +#define CXL_EVT_TP_entry					\
> > +	__string(dev_name, dev_name)				\
> > +	__field(int, log)					\
> > +	__array(u8, hdr_uuid, UUID_SIZE)			\
> > +	__field(u32, hdr_flags)					\
> > +	__field(u16, hdr_handle)				\
> > +	__field(u16, hdr_related_handle)			\
> > +	__field(u64, hdr_timestamp)				\
> > +	__array(u8, hdr_res, CXL_EVENT_REC_HDR_RES_LEN)		\
> > +	__field(u8, hdr_length)					\
> > +	__field(u8, hdr_maint_op_class)
> > +
> > +#define CXL_EVT_TP_fast_assign(dname, l, hdr)					\
> > +	__assign_str(dev_name, (dname));					\
> > +	__entry->log = (l);							\
> > +	memcpy(__entry->hdr_uuid, &(hdr).id, UUID_SIZE);			\
> > +	__entry->hdr_length = (hdr).length;					\
> > +	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> > +	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> > +	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> > +	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> > +	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
> > +	memcpy(__entry->hdr_res, &(hdr).reserved,				\
> > +		CXL_EVENT_REC_HDR_RES_LEN)
> 
> What's the logic behind having the reserved fields here?

I forget.

> How does that change when a future spec defines them as used? Do we have
> to keep whatever was in the previously reserved fields for ever in order to
> maintain backwards compatibility even though we've added the same data to the end
> of the trace point?

I don't expect the header to change as much as the records themselves.  So I'm
ok removing the reserved fields.

> 
> I don't think they should be here at all. Given a userspace stack has to cope with
> out knowing the contents of those fields as userspace might not be up to date, 
> I see no problem with requiring a newer kernel to support stuff added in future
> specs.
> 
> Steven, Mauro, you probably have a better idea of history of similar cases.  How
> have other people handled reserved fields in underlying hardware reports that
> may become used in later revisions?
> 
> Also, probably makes sense to cc linux-edac on v3 of this series as the experts
> in these flows tend to read that list.  Obviously intent so far is not to pass
> these into the edac subsystem, but I'd still let them know this work is going on.
>

Sounds good.

The struggle I'm having is in how flexible these records are compared to the
other RAS trace events.

I'll drop the reserved fields.
Ira
