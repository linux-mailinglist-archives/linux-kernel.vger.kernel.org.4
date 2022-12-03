Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDC641942
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 22:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiLCVeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 16:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 16:34:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D774A140E4;
        Sat,  3 Dec 2022 13:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670103238; x=1701639238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uVJ3cq8G4r92h3nEPyfV6VjKibNfXbnFeRioXQ2kCHQ=;
  b=d/x+YQ+6b0ldVuy6fxNfrzKT6zUL2n76YTIMUceEGhWh6oz1YABkXScM
   H6BFsNR2OkPh5CKr9xBxB6JL7+uNneTOZz2aSoyH4ORTa1RZ6JYBylYd/
   Zy7askuSgSVckrlG+qcDcbwEivUk5vCnY9sCb3l9Ms/gU+QNzPWpAq9NM
   C0tzbiOCI4l7d9VWfYc94H+06WymEb8ITTX6lwf7/bdTV5XiDQ2SwNOVw
   2zu3yJ1/l2xUUZzYrpW+7XMYFHEJu+C6i4dPEhmU+0SrAPPgX8/eB+UjT
   97F4YgrJkyoecpIhzmkzlqeh09RuLPHRPGAMGjkf8hYzji14YUIcFObkE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="380439084"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="380439084"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 13:33:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="734172818"
X-IronPort-AV: E=Sophos;i="5.96,216,1665471600"; 
   d="scan'208";a="734172818"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2022 13:33:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 13:33:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 13:33:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 3 Dec 2022 13:33:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 3 Dec 2022 13:33:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+vcNzBiZgY+HsmQGfxpcfI1lQd1p0fx29nz7+IpyOREkW9hMZQEZsPyAo92Sf7tFHefElRXyPJytWMOLR6E3bjJrTPrVcgVC5eC2qysR4BuziAqW8cNBIZa0JnUTl5EWPXusJGTyDv/9fbusVjTX6yyZtwVAje7U1J+d4o7wDbj9D0fkiMuJ+pDhW7lmqlTCzU7qZd9Yy0eq3kQYtDk+2VihdkjqExTwSz365YP2CGCeS0IhEu7r2lYlVaRx+zaP80sYLmT4edZF0ercVx/2FfIUCWmwkkOrvdYNq6iVkHyywmL7na1WQB3yyLJRXtNXOaG7bedCMUskfJFkkbO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYlJbkR8TdUmew/4d5SjV2iyBZ68f9742hn1LHjCviM=;
 b=AfBwUNLiKRBtC62Z6yV5/+UqcwVnWncRDXDWfzTUqtJpQzvwGfxg3UthYu/zI7jy4hPMUYrLWYNMLbaTJLJxjmOiU/CknSofcUIeTRuWHXZnI9q6lFQWZ8IlUNvfp0EL9hqNeBctyBsi/iqgQqfYX3oW/JfCoHflGxD8TcNKmm1pE066ZCBS/5u2WW8Cqncep5ASiGOeIbzsDq+/brDR+MxEvvBe+bYCcLwqWBPs9M6492+zdvseG9Suff3UGXJyAcVOZPlQX7d2LNEQ+TgXGu45dDVYveFKZjJYBoGMzmo22FOH8yDgz8g9VtMF94E/0K2OTkDwbt1+M2iAYry+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB4912.namprd11.prod.outlook.com
 (2603:10b6:a03:2ae::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 21:33:54 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 21:33:53 +0000
Date:   Sat, 3 Dec 2022 13:33:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <638bc0b71b5b_18fe029412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-3-ira.weiny@intel.com>
 <6389573ff3b7e_3cbe029460@dwillia2-xfh.jf.intel.com.notmuch>
 <Y4pyYvbaSF5DpFGG@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4pyYvbaSF5DpFGG@iweiny-desk3>
X-ClientProxiedBy: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 489cd676-a38b-487d-48b0-08dad5761349
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crWUg6BTDtGDmMosiY64/RCTuKZBV6zFebJePlIEJ9bkAAs6QJeWQBuhg6aAGW5N0VJUza4aFZEV1bgCh6GZjcbd9Es2Ingg7UX1pI7oPRg0z1cKrZFMtDBR2JEybaP1d1nRTvmeXp6iqzxS4xa3HwZ+zRJh9VVWafgGAkTveNvlhmuKciYCynORDm266fAVZMbRzKHlfGwMPHdNMCRinTFXqjxCTSP/VKrxTgpKS53iKZHIML8N+BCz9Z29NHhiz5ieqpCMmHFxlxf994uy4XcFufKrF8jEMVPfJU0Se1vb2lSVrWk96PNQngYrNIAuMvrtdSQwyM8nmxiIPvHWR8IzCUZ3y/0p+yVe5bFh57CJ9M8dZwo4ZTGIXvWKyMFlsHhpcPCEs3LKK1ChWNGXRO+grpaOn/bzvaEJFNE+kt7KrVb4788bLmGT5KrGsZa41prHvDgWB3Wro/JgN62oEuLSYNNEjJSoI9D/+Toc0vgkJOfKX8jyXZFgWqURyuzlB7bDRhCEZM8G6tERX/X6E/3NpM5oPnAacwwIcSSPvM6ttEgwIkT1tGTu2bwZrip8BCii0qD2+65xuCg5jvNNykdtFk0azhcBM97jy4jqR8XwORadrD2kLvpVfnp3SiegevOKbMMgYL3dWVaOK5fxExHG1vR9T7LkmBS3C1e4emdwJNORBe6sdD8tqb5swWVPV7Zeve6FnzCp1PN397xzwJyXbn74wJdkEeGYZwN5kFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199015)(83380400001)(6506007)(2906002)(316002)(66556008)(66946007)(4326008)(66476007)(8676002)(26005)(41300700001)(8936002)(5660300002)(6512007)(110136005)(86362001)(9686003)(54906003)(186003)(478600001)(6486002)(966005)(6666004)(38100700002)(82960400001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jvecZAyZ/RWm1onlw+Pds19gL8E8Oe/X1eTe6y8Jj87Xinq8ZjU/jzx3Vc9e?=
 =?us-ascii?Q?p9PZ7VlNQ26FIt2OlqVPGDHGKIsSYB9t1JJlv885aN8vYWVcsr5Qx7vOAlgD?=
 =?us-ascii?Q?z2rae5XuMfAh/Y12zfQOj1anjPyP83/fLXrljBt/u0pvAeKoAhgEWuxt55mg?=
 =?us-ascii?Q?xA08QDX2xJVLjo/T2IYu/q8rtVAkZXQPT6gshJqrzkdlp+gvZIfBufYqvSZk?=
 =?us-ascii?Q?jc2aDf4OgbWVOanMbybsA3rydCI9YY+JN4X24WRydjkDK5RaovWgrgy1EkL+?=
 =?us-ascii?Q?KWfgBNL7GaLqPxRzCkiSVgQRg0U3IvoYZWK2wZ2c1/BOXwgtONQrEyot8mh4?=
 =?us-ascii?Q?nSJeRHyTf9G3a/gKzXIru8ahJlBNKMS/E6RuDw25PY0Uy7mpyJHwyT9vJGcu?=
 =?us-ascii?Q?sW+1FwC7OfikhAKX3bgBa0C30I1INt5IPkSopBujV6+C1/xCTUKWlzQ+4UE5?=
 =?us-ascii?Q?1G3rvsLnfEx1AeRBWIhaNRtiFhPgZLOjUh53TNtq5uyWc9aG2niSrWxyhcVE?=
 =?us-ascii?Q?q2iPwf1DyT3oiWB+k2GoUB416BDXTq9dfVd6tXz1eG1D6iykHMyAYbhY7ccM?=
 =?us-ascii?Q?Sjh8eTgGi9UvzVQ0uEX2mJDwwNWMt9Pg89vwTkp1C0+xidkY6QZBPYBDBY86?=
 =?us-ascii?Q?g7T7M00GPF2CQfxmpCOJlytadZNoHmyjnZJl7jAVfIYzy2lRQaqMBlQ+RPGT?=
 =?us-ascii?Q?mLPdLNdmlLC5FexmBr6mtzkIdSTRm6hR3uhi/jOE4FkYYGig5ckuKuhANvW0?=
 =?us-ascii?Q?W92BbP7L3AYRr76+cJSajJxXvE5gbJmUFLM62sWfPFgJIlg3GH7hrHfDOhEE?=
 =?us-ascii?Q?YUxUjg0KHOOXuQIjlfEjQwTj72DyW1qgVAMaczu5TFpnwOqs+CufEQnKoP90?=
 =?us-ascii?Q?/OqXStmhVTuUYjGxNL0D5TWPbQNfmpVvrv/3ytai+Q5JVLz/+9jfMgb+HbWR?=
 =?us-ascii?Q?LfXs4n9lU5OkIy8ERMrRHqvBITBUGwSr8IGSx0OdCDgYXw5aCWXO6eg9IRtV?=
 =?us-ascii?Q?icRxw2jI4dTJFPnvaH+4x4RWFpvTnOvdB3a6XUGhqMF8NPuoba+o+k6ipQ7n?=
 =?us-ascii?Q?U14c8tjxXNlrmBteSv+VOUdVGwsYpfeGNjnd3On+V7HlCbSIQeG79a5PV97L?=
 =?us-ascii?Q?zt6mT1uaRquX2mhXi7hX9RQUv0hyFGd7SbVD38F2jMlX3N0MonozAIwEhJ9N?=
 =?us-ascii?Q?823j/neSeX8AiBCqBwI6ehYK+X0Se1OVwRW9gyKQROV4tW5+FPeHlCu3h2dw?=
 =?us-ascii?Q?kJqVKUTfa+TM+JuDqX95Iadx8T5p7+TzMaI2nYmdjt3ffbQ8ZrneyXZyEGof?=
 =?us-ascii?Q?Tmuf16K5xH4Nbt5dfgEMzrWe0CIZVpZnHVR3/0VSrOKLzTByeCEVWBLMrfhK?=
 =?us-ascii?Q?xuQD2AxDWqvyS7ak6nYw1ifkxaEZCWdlwTrpSTzfc3451gaud0RPlCbWhPff?=
 =?us-ascii?Q?SYlS9bvwvAEL0S2RMmYOsuzXXyC4/Bpi0Dt+Hg9fHR/54dA6RKVqwr463qYL?=
 =?us-ascii?Q?BHrhZFfk215+WpWP0rw5nhlhTpoSwSKwyVgD37YXyK3e24/ADdFS39yLQ0aZ?=
 =?us-ascii?Q?UA/BG8O7Fxig/tzeVFp9neDq+Du+fkYbxRYLsVVtm6Lmll8qBrihlqYC6Hxb?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 489cd676-a38b-487d-48b0-08dad5761349
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 21:33:53.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgN8vVrl7VZugtI6YDGR4G4I2n3qurFa4S1X2RIb5oeGaqz8GPYqXxAbU+46TGExqRxLYpgpBRmtFZP79oEUOB/+3JB3+R6m2iWLSm/M264=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> On Thu, Dec 01, 2022 at 05:39:12PM -0800, Dan Williams wrote:
> > ira.weiny@ wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> 
> [snip]
> 
> > >  
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/cxl.h>
> > > +
> > >  #include "core.h"
> > >  
> > >  static bool cxl_raw_allow_all;
> > > @@ -48,6 +51,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> > >  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
> > >  #endif
> > >  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> > > +	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
> > >  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
> > >  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
> > >  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> > 
> > Similar to this patch:
> > 
> > https://lore.kernel.org/linux-cxl/166993221008.1995348.11651567302609703175.stgit@dwillia2-xfh.jf.intel.com/
> > 
> > CXL_MEM_COMMAND_ID_GET_EVENT_RECORD, should be added to the "always
> > kernel" / cxlds->exclusive_cmds mask.
> 
> Done for all the commands.  I'll rebase as well before sending this out.
> 
> > 
> > > @@ -704,6 +708,106 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> > >  
> > > +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > > +				    enum cxl_event_log_type type)
> > > +{
> > > +	struct cxl_get_event_payload *payload;
> > > +	u16 nr_rec;
> > > +
> > > +	mutex_lock(&cxlds->event_buf_lock);
> > > +
> > > +	payload = cxlds->event_buf;
> > > +
> > > +	do {
> > > +		u8 log_type = type;
> > > +		int rc;
> > > +
> > > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> > > +				       &log_type, sizeof(log_type),
> > > +				       payload, cxlds->payload_size);
> > > +		if (rc) {
> > > +			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
> > > +				cxl_event_log_type_str(type), rc);
> > > +			goto unlock_buffer;
> > > +		}
> > > +
> > > +		nr_rec = le16_to_cpu(payload->record_count);
> > > +		if (trace_cxl_generic_event_enabled()) {
> > 
> > This feels like a premature micro-optimization as none of this code is
> > fast path and it is dwarfed by the cost of executing the mailbox
> > command. I started with trying to reduce the 80 column collision
> > pressure, but then stepped back even further and asked, why?
> 
> Because Steven told me to.  :-(  I should have been smarter than that.

You did the right thing, I failed to jump in sooner on this set.

> 
> > 
> > > +			int i;
> > > +
> > > +			for (i = 0; i < nr_rec; i++)
> > > +				trace_cxl_generic_event(dev_name(cxlds->dev),
> > > +							type,
> > > +							&payload->records[i]);
> > 
> > As far as I can tell trace_cxl_generic_event() always expects a
> > device-name as its first argument. So why not enforce that with
> > type-safety?  I.e. I think trace_cxl_generic_event() should take a
> > "struct device *", not a string unless it is really the case that any
> > old string will do as the first argument to the trace event. Otherwise
> > the trace point can do "__string(dev_name, dev_name(dev))", and mandate
> > that callers pass devices.
> 
> From a trace point view 'any old string' will do.  There was nothing else the
> trace needed from struct device so I skipped it.

I'd prefer more fine-grained type safety wherever possible.

> 
> [snip]
> 
> > > +
> > > +/**
> > > + * cxl_mem_get_event_records - Get Event Records from the device
> > > + * @cxlds: The device data for the operation
> > > + *
> > > + * Retrieve all event records available on the device and report them as trace
> > > + * events.
> > > + *
> > > + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> > > + */
> > > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> > > +{
> > > +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > > +
> > > +	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> > > +
> > > +	if (!cxlds->event_buf) {
> > > +		cxlds->event_buf = alloc_event_buf(cxlds);
> > > +		if (WARN_ON_ONCE(!cxlds->event_buf))
> > > +			return;
> > > +	}
> > 
> > What's the point of having an event_buf_lock if event_buf is reallocated
> > every call?
> 
> This is only called on start up.

cxl_mem_get_event_records() is called all the time. The place to
allocate buffers attached to 'struct cxl_dev_state' at start up is
cxl_dev_state_create(), or sometime after cxl_enumerate_cmds() if you
want to wait and see if the device supports events and CXL _OSC says the
driver can drive events.

> > Just allocate event_buf once at the beginning of time during init if the
> > device supports event log retrieval, and fail the driver load if that
> > allocation fails. No runtime WARN() for memory allocation.
> 
> It was.  I'll make that more clear in the next series.
> 
> > 
> > I notice this patch does not clear events, I trust that comes later in
> > the series, but I think it belongs here to make this patch a complete
> > standalone thought.
> 
> Squashed.  But it does make for a large patch.  Which I'm not a fan of for
> review.  Lucky that now we have a lot of review on the parts.
> 
> > 
> > > +	if (status & CXLDEV_EVENT_STATUS_INFO)
> > > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> > > +	if (status & CXLDEV_EVENT_STATUS_WARN)
> > > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> > > +	if (status & CXLDEV_EVENT_STATUS_FAIL)
> > > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> > > +	if (status & CXLDEV_EVENT_STATUS_FATAL)
> > > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> > 
> > This retrieval order should be flipped. If there is a FATAL pending I
> > expect a monitor wants that first and would be happy to parse the INFO
> > later. I would go so far as to say that if the INFO logger is looping
> > and a FATAL comes in the driver should get that out first before going
> > back for more INFO logs. That would mean executing Clear Events and
> > looping through the logs by priority until all the status bits fall
> > silent inside cxl_mem_get_records_log().
> 
> I'll flip them.  And determine if this is really what we want to do for the
> irq.
> 
> The issue with the irq handling calling a single function which checks all
> status is that we may end up with some odd interrupts doing nothing depending
> on racing etc.

If an event handler wakes and reads 0-status bits because another
handler did it then return IRQ_HANDLED. You'll have this problem whether
you have a central function or not, because there's only one status
register for multiple sources.
