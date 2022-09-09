Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700765B4185
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiIIVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiIIVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:36:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E4E11B030;
        Fri,  9 Sep 2022 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662759369; x=1694295369;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CSMDz4mvVzeK5IjzUy0aQNVFk6bPEpcmg6FBMe42Lcc=;
  b=eZtlZ95p8c0dvLLYjmJq73RidmYhSiBp6pv4mfgoHB5bah0ClUBKAmrm
   MIGTs6TnVBG2M9DWQEBNiQj7m6nkpEk10gg9O1p3zXLUmrFeDBat4sF/P
   kh88nYmvxqG3q4hstnhua5D+F/Zf9IMhNdSd/bKF4b06iFjy6DMhTjy7W
   niaXQYxLgtHZfiPWm2TYNQ7099OIID5OWlOZadBojz4JHufYyiRQqw7wC
   vPFO4EB1XJlq8aQoD3rU/k9EIZlvg6pkfkJ8tKJhgCaBLiXbEmLN57P35
   JFIQYqasfvMyUJIQ3pk7Jozf+QsDtmkQSrNrBrvpEgf+fJOKjcb7AP/G5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296313550"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="296313550"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="592756567"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2022 14:36:07 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 14:36:07 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 14:36:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 14:36:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 14:36:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXuUYiMtuwDSArURgDoNakjPJv/D4VD+Ynjl47NC8ZeTW+4Mn5A4f6qCA9NAL+oZhtWi5u4OT3dM1vXOXrmFR44R+svHCyO3zgtMxhThPHZjLtQfXWchxaQjf4fyMgjTOlTGTH/DNxHvQTmrt1HrwTe+uxu2rhtnSm1m/IN/xXGdh0lBWEYKmq2YjbVwLiVJzzpuf8ugGBTblnsz0iCwSTHs8iR/YWlWNwSMdurLLVdFvjom13x/RVCdc7dyAd9zcVxdU22yFRCXz0mrahO/axtKyHem04qatfGoqHiPap1aapI6kbtq+8fYg6FYg7HJ9mFbbgQbXLBQfcPQ8MzY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU9K7JvfkHLHWWXjG4iUKiRs57aJKxVOzDedtJad7zY=;
 b=dA+tpb32ySDqTFNEkI5OBBe9kNfDdxctd9U0QF+8etUbgYwdrZ32iN1A1xJsx/FEcT4fLSyTHLwmmyBJLAmx/8UfcqDsPq3pceHn06JVq1AuTcVEB34fRVR+KN+j/OK/OlhQP/c9CV0NxFaBTbnYeMYmom9DDr/5+5jiM9+jtBjGwQZlc8+IsAFT1BGxjTVCmU0Ux5mb33LKiYfTTBlmU6UIauox+JcB+AIzCegz9LVXSNJ124BT/F2Cy1qCWxW0hmjSF6Rpyy1ILe/PyJCGSrNXNd9bKNh60pJkkFxH7sicBNNSTrAUiQK25HtRIlQJ4JuAnQcIENZPp8UQsd8Qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 21:36:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::2896:319b:82a1:a4d0%6]) with mapi id 15.20.5588.012; Fri, 9 Sep 2022
 21:36:05 +0000
Date:   Fri, 9 Sep 2022 14:35:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] cxl/mem: Implement Clear Event Records command
Message-ID: <YxuxpIZ9Xh01247Y@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-3-ira.weiny@intel.com>
 <20220824165513.00000987@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220824165513.00000987@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a33396b7-a076-44f3-ea70-08da92ab4d06
X-MS-TrafficTypeDiagnostic: DM4PR11MB5520:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hIMlLcui2YP/WWVRTDEEBwLbB50IVF8JjqG28eziUAT2f56urx0i4f5ndjmiXqNo6AZTX8UKxkxZQo/IP+wSrFULS0j8oqhWv7vCilDDsfzCQe0eRWZcrBoa7VaWvqsEI0NH2/RTLCXBFwKbHFg64ELG2dJunWjrY7tPA5R0hgToXaf2vXCSKZIjblN69jBXvkWSxBtpFo7lRjWH7PEPwgcjAU8XDfcErK4oKt1mv3rPz6HlaNXbHa3DKwKjpju6NAAap3b0blqvldG8B/+/OG0Wk1arn+UaHf2/045kry++eXfVPwUouXxu51v7D1Ua+McTBSgzORTQ+bKa9wir5iPNWgZvv+k3Qc4qTIuPNyozjCOdcG2B63HvAjKcNhd2df5qFcrG1In8MV/oUdwqwTSxvS3122pUSKhy/PR6OYN1pdL0KRNpBNhY5neLCeUv9mo/IZ42s7QIYIm+ls6gyZdhpXcdX+IjvmMb4eqByMw5TuytJAYeYU4WHWHaOM/7o41OZg3gRTDVkL91YiWFYOCMQi+oHgiLyW137XZO6f4nxbmHuEUF+sgkC5S6qu90HqJtA+mV/nEx+FZ+yDWf7c7zOJPfm5QbjojCCId0FU/oBvzY+U84+Fh8eZ+68QtZwYokY/EzQW1Y8xkus6bwKQ46+Z43avm0XblGzAG/516TIVVXQl2hLWh2gSrw1Lk7wLSjI1J0T84nzjyva4Ekg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(54906003)(83380400001)(26005)(6512007)(9686003)(6666004)(478600001)(6506007)(316002)(6916009)(86362001)(33716001)(186003)(4326008)(66946007)(66476007)(66556008)(8676002)(5660300002)(2906002)(44832011)(82960400001)(8936002)(6486002)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LF3QP4ahaOooYp9SIK7mIsewwE0jKyFA2s9EAmKF+9RRM9/2JLqK2qyx0IJv?=
 =?us-ascii?Q?9g3Hu3fRxZFoYoB56+rOWhhQ7sRnZvGvR+f8tFClNnArE3OwddcZDnxnDNYi?=
 =?us-ascii?Q?NS/eU2VGaaIshrmeDKLaqElz5mfBrMMJHEL98jhZ8KcEsWvC2Nn1dWHI0JYf?=
 =?us-ascii?Q?kaQv7NMgv6L25d6ykCVxKy9W5zkn34P0U4ddjT1d3+AuwL1n80+kvsIRbSom?=
 =?us-ascii?Q?v2E4I4Sj53QOBYS8r4f35vNV4NKsgc6H2tX+E9pSKtk1nvcyoaXgFa9UIGlx?=
 =?us-ascii?Q?E0EaUXcTntEUtN4FWYQpFWcxguOtzr2uPAaXFeCNk3CkrF0EiJXBpMs0pSIL?=
 =?us-ascii?Q?Za5TZgH8cgIukTN0l6pmV5KiOayavxtMo4HwwbcnifsrLIoHpVNa/Q7wSYFK?=
 =?us-ascii?Q?xfebxiTs7fsNvaruPzPr/O+OJTV3uM5jUq2nkcwb+0a8Vd61SKjUpOFJOkVm?=
 =?us-ascii?Q?A2zcaO7bCRophI1d2CC+f0B4Wwxre+R9J3lpOJkvoFqmbz1OJsHr2gHasjYF?=
 =?us-ascii?Q?b5241Wmkco5W/YpWQY1tQq0mxmIP4OrQHk9tulbpb1A0Q0u2eQ7W7w/0gRnq?=
 =?us-ascii?Q?XKlrJumYtsHOap6Qb0mKPm2uuJ6rr9pCpU4OrE6EbwxLDiwMjYT7yaVvwEVA?=
 =?us-ascii?Q?Owxrq2u1KIKhJQFOOdKlwAcJyE3NOWLSsQ1m88LIFGsGUJoO4hqasQkA8JpJ?=
 =?us-ascii?Q?mqSC7cHCZX9HTz7WybPGvtM1JRwVEW628twpoKi8OJCfA5ELw1POxWdrwn3u?=
 =?us-ascii?Q?ZGtvujQloZbbcKdpt51lGMqlibbxBqOCWrxVog0UJpieVIQFBdRyorlOvk0y?=
 =?us-ascii?Q?ktFWuBJ3z0bZ0ZLpd63aIcX0rw2EMRCGHvAMwKHZoBvzYem8jjE9sLPxuJk+?=
 =?us-ascii?Q?wTgDwAU5B5mTaBDM5JWAfCyE8R3qTyniPT/A3frHkdUY31BI8oRUUGPFwIh9?=
 =?us-ascii?Q?j4lBsNX8JhbecPYrXtdsW+NTT45SJEjt+3uXtTsNksGQt9kggC5E3UiUtnkU?=
 =?us-ascii?Q?vkMP+0I3fyf8H44TqYvYK4sVMISRfRBRfBiBEjJJa9ver/2mxVdNfllS1izo?=
 =?us-ascii?Q?wJpSwpF6DBlPjxXWmKwPYjmDFzSCfz/Fp3D3EJW4QBeKVjEJRRAoMKMvZAMo?=
 =?us-ascii?Q?7YG1LcWWxrKUVezgnMz8H1rL6j0Wlo4NcEc4672wfH7oI7izsYOdmnoD0plg?=
 =?us-ascii?Q?ENcSv2EADp7UghfI7NwGx/JO4JSrl7S9Caz7mAyA9glELyj2GgwGjk3/y+s0?=
 =?us-ascii?Q?aaZzWnSdNyBAH+MAjZvagzHFUGN+QkXK4OYS9zEHyqKU9ckYA6R1EO2BoWjF?=
 =?us-ascii?Q?AKPF0iSdr8BY3+fQvMBPcUGvt+kgMcXr4kfDy7CZ/xmGnyzvJJLBxIJv9y+I?=
 =?us-ascii?Q?NFVSG094q/5tnqvqMrOAGzkLGhRNXeX9s1AFuh3vi+nlqXdUj/Ax7qtTOd+j?=
 =?us-ascii?Q?aCRoH/b57cvyRxi2F04oGCsd8EV/DphJ52ZvNQdVRna6hJ3Px6IraL4fMpZN?=
 =?us-ascii?Q?pFQyChOKIHCNx+pUs6IgJYiXKAEGMQdHgf+L5GUYq9NUj+tnOUOvLiZLmXU6?=
 =?us-ascii?Q?9sa40DLaCrZ0vliRcj+LvSs2KYFrE+vqfthw+Jtn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a33396b7-a076-44f3-ea70-08da92ab4d06
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:36:05.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GxQTeVnX+l78k3jtkm17R5OEslKAdvT6EIon6PLZ4987JurjgSquLlZQjOgvAUH5U5cf8+tOM2Fs5bGDaxOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:55:13PM +0100, Jonathan Cameron wrote:
> On Fri, 12 Aug 2022 22:32:36 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL v3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> > command.  After an event record is read it needs to be cleared from the
> > event log.
> > 
> > Implement cxl_clear_event_record() and call it for each record retrieved
> > from the device.
> > 
> > Each record is cleared individually.  A clear all bit is specified but
> > events could arrive between a get and the final clear all operation.
> > Therefore each event is cleared specifically.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Trivial suggestions inline, but other than that LGTM
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> 
> > ---
> >  drivers/cxl/core/mbox.c      | 31 ++++++++++++++++++++++++++++---
> >  drivers/cxl/cxlmem.h         | 15 +++++++++++++++
> >  include/uapi/linux/cxl_mem.h |  1 +
> >  3 files changed, 44 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 2cceed8608dc..493f5ceb5d1c 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -52,6 +52,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >  #endif
> >  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> >  	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
> > +	CXL_CMD(CLEAR_EVENT_RECORD, CXL_VARIABLE_PAYLOAD, 0, 0),
> >  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
> >  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
> >  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> > @@ -708,6 +709,26 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> > +				  enum cxl_event_log_type log,
> > +				  __le16 handle)
> > +{
> > +	struct cxl_mbox_clear_event_payload payload;
> > +	int rc;
> > +
> > +	memset(&payload, 0, sizeof(payload));
> 
> Could just do payload = {};
> 
> Thouch as you are setting stuff, why not just do
> 
> payload = {
> 	.event_log = log,
> 	.nr_recs = 1,
> 	.handle = handle,
> };
> and let the compiler zero anything else (I think there are no holes to complicate
> things).

Yea!  Done.

> 
> > +	payload.event_log = log;
> > +	payload.nr_recs = 1;
> > +	payload.handle = handle;
> > +
> > +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> > +			       &payload, sizeof(payload), NULL, 0);
> 
> return cxl_mbox_send_cmd() and drop rc definition.

And Done.  I've also used the return value now!  ;-)

Thanks again!
Ira
