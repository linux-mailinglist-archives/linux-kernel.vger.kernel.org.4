Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0D63FC8B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiLBAJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiLBAJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:09:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2493C56EC8;
        Thu,  1 Dec 2022 16:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669939767; x=1701475767;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bDt32+2hmvT0Rp4NbtQ+4pOZKS2R8b6lh+jJ38p4ROs=;
  b=T7sYvP2nylIThQA9ZjpQK1T8p15EVT90a/z47dJANwF0CmNp3o0SEQAp
   XkrlXsjnv80bzNKC9kQj6f4DKtpnKVVs/7EDdKh2irYulpHmd8PZxntNH
   OG+adp7V2z1yhXDiYlBRpJuaQ85yqdoXfVSUiDhTspKxCUuk0W8Ohk/w7
   v5sW/HyIL8Mj2hcsxczRY2Tn6K3zlgaFpRxB0lAQD01rlqb6qfMyOgF2h
   FfK7Enhj0b3qPG7mSWcyYOKx3u5nq2UJQQie/CXAYnBxfv9e+2kLqC+Kf
   oWhl8RxLEj7mVmNwMmrxVBQZxQewid1e48XZGdt2xLOOZBiTjdvFwV3xT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296184145"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="296184145"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 16:09:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="646958909"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="646958909"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2022 16:09:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 16:09:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 16:09:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 16:09:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 16:09:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEfFHGYMt1V3JeruScyWAOHgnfyVEm/ab9pQlt65+LjuaQmNsw5GtXsgU857cZNbfrDIK00/Ekjx9KL2WAKBUd7yCnO5REbsFy/nAVKvtAKotjcKlCEpoE0EMG/R0DeHHgovWWRjOg1gsYmGahMx8SeUaMgVx3YYBq6aAaHKwx+aOHFk4nFOJcd5cWrSw3CuQRFybSiB+F9yp2kXRMpze3sEwzunmu/JxZFAsTbHMvBn3Tth7iPgtn92aHEq6CXx03oyRfYn66pX51VHlpqcR9uicupzRvl/d76KnqFw+NyCm3/67SPjRkzxnfQJuXsPb0gxx580Wk2CBaeVVPJHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp51AFYAPxLHFHM4QHV09T/8DkS5TwwhIWGYmR59ho8=;
 b=CscpW+HxxfxBTl5c1IKDjO4Pzg76m2Mn60wH87dpPur30zLYMQGvOE7i2Ru/zNtqjbzvDNwqc7amgqhG1nax/siKSiWy5eXI9ifws85gsHwu3uD0jvejh2JNPlKEhoRuc7S/KclvtbFIX/N7o8qTPd8y9AU/7CfCJIQbCOIwRQ5lKdv+RkzeEG+29b7WWl22I6ykU5AeNdu6hUE24KgbLTgr5RqHtCdgXIp8G9v5MWFIriE8YuY+h7pq5Opr1GnfOJU4Uv4c4GGqVq1caymzAmz9CNhcO56Wu0K7ycUWT0kYSV31dEEZPwi5WduHl8jSt0IDp8BPFIZ567lWoBmUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 00:09:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 00:09:22 +0000
Date:   Thu, 1 Dec 2022 16:09:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y4lCLfQrjyRtLmDM@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-3-ira.weiny@intel.com>
 <20221201123849.0f7802ce@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221201123849.0f7802ce@gandalf.local.home>
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbded18-7c65-4a77-ee0e-08dad3f97720
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: It38qvFFqyOORcUvna6r8d6uNkcOxDT5GHBfLkOxh1xKBP43lhuAV2wBqRVOX6mKiUguQde47uFMptGnaAt7keO2N8FvKFB0ktsvJrSDlzf7o8mdKX6muXD659hlcHaOynQtBuRt6D62Li54lMiesMiLdRHIpJJRiyokLX6lH6PYbTTYn3zGIzc2jAREXufjrl1UyKZUYygtmVYKEXXSG6GpUHBT69D+RcOw0sSSOyQmJflDoz5ntEvTIJqNahfmCrvpsEBDjPzkuTi3WffQgvIN+dHMeP0YvXbz+xHAeQnVTWU6pvvvsosAoTgxr7x6jZmhFMp9A07ukrUdILW5BKR5lZ3d3DNmDWkjor39NQo56g//X9wDDlxCkxKR0YVfEq0mQRraxZ65jOIRya9WDbH06cUudnE63mEI5OUQR8TFPMZY8BrhXW5KGLb8Ob672p0F80IJsCteXSg7C7jjanT79DG95yik4iplXLem67wiIfh71gotEzRMkCDVp3g66/TmCYu2r1M0nNlgimCUoT3OG3M6FfM9uDJqQqW0DfVY0PrnWaWod0THqaxt8mOPbCzM9HlEzF3xSqQaPp7JHrenf0rBOSsJLVYFsU9RqmsRkPbV7WX4QZIH0lTH/+lpYWVl1m5f7WZE/ZKFfmGzAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(478600001)(6666004)(33716001)(38100700002)(82960400001)(6506007)(6486002)(86362001)(6916009)(2906002)(54906003)(8936002)(316002)(6512007)(9686003)(26005)(186003)(41300700001)(66946007)(66556008)(4326008)(8676002)(66476007)(30864003)(44832011)(5660300002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1QwdDhaYlRDaW5XUVdzVmJQV0FZbUEvaHhJY3A2NmxoTG1PNnFYRXhrN2gz?=
 =?utf-8?B?YWFlemdSZG81Mk5BQmhiRGgza2lXYUd4MGxVc2JDYzdLTXdvZFRwRkdzVTFD?=
 =?utf-8?B?RG4wSnVCdm1FejRnQXRRUTFQYjg5QTRZVzZoMVhrVTBYdXlaSkNYR3kxTFdV?=
 =?utf-8?B?QStwM1gvU3A5WHFaWmtld0hEdVBmL2F2WW5ZMENWNUNhWTFmL1lFQ0VDZy9y?=
 =?utf-8?B?WEcwc01ZWUV0S0xVZkJJN1FzVDZzN2x1VklDbE9nS0RaUk1CVXUrT3BYUXBO?=
 =?utf-8?B?NEp3MHY4WHppTkhpMUthQitkSkNCaG54QUpuZnQzNDlGb2dzOVRHdmY3WUlB?=
 =?utf-8?B?bC9RWmQwNkozVVBLbE40SjJzUkhHL3pFM280MGhNS1VsWXB3U0FHSHBuM1Zr?=
 =?utf-8?B?cHNBeXFENEMva2N4VDI2VFN4OGZ2Y0srRkpSNFJrMFZyeGxsSGRRRXorWVZj?=
 =?utf-8?B?bjZhOStFeXl6bHhLNHg1aGhubjdjdnNlLzA0VGJSTnltS0tnVkhFY0k2SnBD?=
 =?utf-8?B?OFE5RmlWQnFMUUdYS1FnVzdDYkprQXVmeTV5SnN5MmR2NjdwOXFJTFNLSnFw?=
 =?utf-8?B?YktoY0xPdFB1amJUbzdHSndGNlM5QVMzNkdDaTJtQWlkRnUvY1VLUElJN3dq?=
 =?utf-8?B?L3lKd294T09mcytTUjByV2d0aG5lVTkvOEZnZDN3d1JvN0lJbXhHUkd1WEVy?=
 =?utf-8?B?RGV1ZXNQbWYwZTJtalJNdmlwaUV1Z1U0VkxBVjZ6QlRZcThpdlJDb3Z4cFFy?=
 =?utf-8?B?RHdMcm54cjFTa2ZkQ0paT2hwVENmNjJ3VHA5bFlWaHZ2T0tFSlpRNFU4QjBC?=
 =?utf-8?B?TTByaDVDclNkSU5CcmN3UnA1SEIvTnVVODVQNE80bEpwK1VnUFdRMldVYVVS?=
 =?utf-8?B?RHI3dmRiQVFtYnBDbUhQc1l3WFhzVlEwV2lMRDdIS2dMckFsam5lb3ExUXpq?=
 =?utf-8?B?NTRCWURMcHpscGI4elRFRVE3OStmZVNSZGMxa1M4YmNVZVZsR0JwVENXcTZT?=
 =?utf-8?B?NkRZUHlRL2Z0U2RLQlpuZ1FqbnUzMHZwMHZMb01samZ2blVjMXVSQWtNMEhy?=
 =?utf-8?B?Zjh2ZVZMRExuTnp3Rm54clpoUjI5U2VwY0N6ZFYvNStXZmhNTTI5VWZldTAr?=
 =?utf-8?B?aDZrTnB6ZFpCa3hSR212TVJaenQ1WWNITURtYmtHVlcybFJaYkd6blRNUFRS?=
 =?utf-8?B?ZDNEMldkYjV0UUJ2RUdGTnIwQVFOWi9wMldDS0d1ek9hY0dtTjd6QkVtVyt0?=
 =?utf-8?B?S2ZVOGhUWDRzRW9ycTIxL2g4azh1dHNHUHNuU084VlBSbzlUeDJMbUppT3E2?=
 =?utf-8?B?RUJabDdzRC9ZVnVRcXkyaldSMWhBbGtkYkorRzN3RGhqTWVkbWttVTM3L1Ax?=
 =?utf-8?B?RXdCMi8veEl3NGpMaFk1ZGJLa0RHODBEczBsVTZMMmsyeUxMa2dyYzg1b2pn?=
 =?utf-8?B?L3Z4c3JiNFovd2xvS3c5TG5vNlFkSzB5QW1ZTXl5SnFVN1oxYnJzdVp2dml5?=
 =?utf-8?B?Q1lYbXZwZDVidHltSUcvVzlBK2pxSDdVelVxdHdUQ1Mwb1ArVVFFeG5DcC9N?=
 =?utf-8?B?TVRpQngwWEtUQTRhTjl3MWhmaEM4Nm15NjJYZGRwbnVpNys1dFBCdkFnRGFU?=
 =?utf-8?B?VGlmWjYrWkVGVG5PckVodmRkTGowb3N5TXpOeC9xTnBDdXhrVUVSaWRZQnI5?=
 =?utf-8?B?Z05TM1laek9zamtVTHhYb3hSNTJTMC9JUWpnOWtMT1RTY29aT1I1NGZrK3h6?=
 =?utf-8?B?a1ByRDJZVkF5U0xGYm13WmVyZHM5SDFwSk1yN3FTTHFucDRITnJkb2N1R1pa?=
 =?utf-8?B?Vzl6Z25rSSt0b1RpRTBUbUlqNGhHQmFpNGJ0ZERpMEY0VllzWEQzSG4za2Uw?=
 =?utf-8?B?RjJPVGV2YXdVNWI3a3FKSTArYTNlV2I5d1B6NXpteVg3c0luYjlVZUJ0dFZL?=
 =?utf-8?B?NU53YnEzazFjK0huMG9YQzlWQ2Z3Y3RHWG5TRlZubGFjeE5GNW83TFcwQkgr?=
 =?utf-8?B?dUxyU0ZtYUs3RjhYZXUzdjFPNzErUjVGamxvVFVBTlBINGhBbWNUbzhsNWY5?=
 =?utf-8?B?V1ZIdHhMOUd0ajVXdWFmY29reEUzS1VEV0V3YnIwRnV6U0V5NXNRalNodkta?=
 =?utf-8?Q?qV9hPSgZ1BiKRKY4nAL5uxyiC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbded18-7c65-4a77-ee0e-08dad3f97720
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 00:09:22.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+P1bJC0fqq2uA2PN34uc/t7zpW+U9p1rsr+Iaes2Hm9UBF3Z7JB1G0E+MF2nvLqaUP8y2UaWsKOiTMjqkQ89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 12:38:49PM -0500, Steven Rostedt wrote:
> On Wed, 30 Nov 2022 16:27:10 -0800
> ira.weiny@intel.com wrote:
> 

[snip]

> > +
> > +/*
> > + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> > + */
> > +enum cxl_event_log_type {
> > +	CXL_EVENT_TYPE_INFO = 0x00,
> > +	CXL_EVENT_TYPE_WARN,
> > +	CXL_EVENT_TYPE_FAIL,
> > +	CXL_EVENT_TYPE_FATAL,
> > +	CXL_EVENT_TYPE_MAX
> > +};
> > +
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
> > +	default:
> > +		break;
> > +	}
> > +	return "<unknown>";
> > +}
> 
> So you are using this in a TP_printk() section, which means perf and
> trace-cmd have no idea how to parse it. Can I recommend instead having:
> 
> #define cxl_event_log_type_str(type)				\
> 	__print_symbolic(type,					\
> 		{ CXL_EVENT_TYPE_INFO, "Informational" },	\
> 		{ CXL_EVENT_TYPE_WARN, "Warning" },		\
> 		{ CXL_EVENT_TYPE_FAIL, "Failure" },		\
> 		{ CXL_EVENT_TYPE_FATAL, "Fatal" })
> 
> #ifndef CREATE_TRACE_POINTS
> static inline const char *__cxl_event_log_type_str(enum cxl_event_log_type type,
> 			struct trace_print_flags *symbols)
> {
> 	for (; symbols->mask >= 0; symbols++) {
> 		if (type == symbols->mask)
> 			return symbols->name;
> 	}
> 	return "<unknown>";
> }
> #define __print_symbolic(value, symbol_array...)			\
> 	({								\
> 		static const struct trace_print_flags symbols[] =	\
> 			{ symbol_array, { -1, NULL }};			\
> 		__cxl_event_log_type_str(value, symbols);		\
> 	})
> #endif		
> 
> Note, I did not even try to compile the above. But it should be close to
> working.

Dropping that into cxlmem.h does not compile.  I've given it another go but
because I use cxl_event_log_type_str() in a file where trace points are used
CREATE_TRACE_POINTS is defined and I get the following error.

|| drivers/cxl/core/mbox.c: In function ‘cxl_mem_get_records_log’:
drivers/cxl/cxlmem.h|386 col 7| error: implicit declaration of function ‘__print_symbolic’; did you mean ‘sprint_symbol’?  [-Werror=implicit-function-declaration]                        
||   386 |       __print_symbolic(type,                            \
||       |       ^~~~~~~~~~~~~~~~

I got it to work with the patch below on top of this one.[3]  But it is kind of
ugly.  The only way I could get __print_symbolic() to be defined was to
redefine it in mbox.c.[1]  Then throw it in it's own header as in [3]

NOTE that patch [2] which I think _should_ work on top of patch [1] does not.
I can't understand why.

> 
> This way, the cxl_event_log_type_str() for trace events will be converted
> into the __print_symbolic() which can be parsed by perf and trace-cmd. For
> all other use cases, it is converted into the function above to return the
> string.

I would like to have this support.  I really tried to share this code a while
back.  What you have is seems nicer than what I remember coming up with but it
is still a bit hacky IMO.  And I'm afraid of how fragile this seems right now.

At this point I'm just going to define cxl_event_log_type_str() separate from
the __print_symbolic() in the trace code.  Comment that they should both be
updated if changed and move forward.

Thanks for the suggestion but I think it is going to be more complicated than
it is worth.  At least for mere mortals such as myself.

Ira

[1]

For mbox.c I have to have the special redefinition of __print_symbolic() in the
c file itself.  Code including cxlmem.h without CREATE_TRACE_POINTS defined
(like pci.c) works just fine with what you had.


commit 43a30047962312be2e532dff542d47a132949c08
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Thu Dec 1 13:50:14 2022 -0800

    squash: Redefine __print_symbolic to have a central define of the log string print function.

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 63ee0fd5f4c2..55938d530a21 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,12 +4,30 @@
 #include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/mutex.h>
-#include <cxlmem.h>
 #include <cxl.h>
 
 #define CREATE_TRACE_POINTS
+/* Must be after CREATE_TRACE_POINTS */
+#include <cxlmem.h>
 #include <trace/events/cxl.h>
 
+static inline const char *__cxl_event_log_type_str(enum cxl_event_log_type type,
+                      const struct trace_print_flags *symbols)
+{
+      for (; symbols->mask >= 0; symbols++) {
+              if (type == symbols->mask)
+                      return symbols->name;
+      }
+      return "<unknown>";
+}
+
+#define __print_symbolic(value, symbol_array...)			\
+      ({								\
+              static const struct trace_print_flags symbols[] =		\
+                      { symbol_array, { -1, NULL }};			\
+              __cxl_event_log_type_str(value, symbols);			\
+      })
+
 #include "core.h"
 
 static bool cxl_raw_allow_all;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a701a2e9bcba..34e7d8ae6cfd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -381,23 +381,32 @@ enum cxl_event_log_type {
 	CXL_EVENT_TYPE_MAX
 };
 
-static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
+#define cxl_event_log_type_str(type)			\
+      __print_symbolic(type,				\
+              { CXL_EVENT_TYPE_INFO, "Informational" },	\
+              { CXL_EVENT_TYPE_WARN, "Warning" },	\
+              { CXL_EVENT_TYPE_FAIL, "Failure" },	\
+              { CXL_EVENT_TYPE_FATAL, "Fatal" })
+
+#ifndef CREATE_TRACE_POINTS
+static inline const char *__cxl_event_log_type_str(enum cxl_event_log_type type,
+                      const struct trace_print_flags *symbols)
 {
-	switch (type) {
-	case CXL_EVENT_TYPE_INFO:
-		return "Informational";
-	case CXL_EVENT_TYPE_WARN:
-		return "Warning";
-	case CXL_EVENT_TYPE_FAIL:
-		return "Failure";
-	case CXL_EVENT_TYPE_FATAL:
-		return "Fatal";
-	default:
-		break;
-	}
-	return "<unknown>";
+      for (; symbols->mask >= 0; symbols++) {
+              if (type == symbols->mask)
+                      return symbols->name;
+      }
+      return "<unknown>";
 }
 
+#define __print_symbolic(value, symbol_array...)			\
+      ({								\
+              static const struct trace_print_flags symbols[] =		\
+                      { symbol_array, { -1, NULL }};			\
+              __cxl_event_log_type_str(value, symbols);			\
+      })
+#endif
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;



[2]

Why can't this work?  Why does the undef of CREATE_TRACE_POINTS not work?

I've also tried to include __cxl_event_log_type_str() and this redefintion of
__print_symbolic() in trace/events/cxl.h and that does not work.

I'm also worried this somehow breaks the support you want.  But I'm still not
sure how the trace headers and multiple passes work.

commit ad08110d2432fb24d4513fe9e75bb9be94870e6f
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Thu Dec 1 15:01:05 2022 -0800

    squash: broken!

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55938d530a21..04117afe9fbf 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -7,26 +7,10 @@
 #include <cxl.h>
 
 #define CREATE_TRACE_POINTS
-/* Must be after CREATE_TRACE_POINTS */
-#include <cxlmem.h>
 #include <trace/events/cxl.h>
 
-static inline const char *__cxl_event_log_type_str(enum cxl_event_log_type type,
-                      const struct trace_print_flags *symbols)
-{
-      for (; symbols->mask >= 0; symbols++) {
-              if (type == symbols->mask)
-                      return symbols->name;
-      }
-      return "<unknown>";
-}
-
-#define __print_symbolic(value, symbol_array...)			\
-      ({								\
-              static const struct trace_print_flags symbols[] =		\
-                      { symbol_array, { -1, NULL }};			\
-              __cxl_event_log_type_str(value, symbols);			\
-      })
+#undef CREATE_TRACE_POINTS
+#include <cxlmem.h>
 
 #include "core.h"
 



[3]

This seems to be the cleanest thing I have gotten to work.  Work == compiles
and trace points still print the strings.


commit c04f87639164737605c9ff503f8060b901c1b83a
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Thu Dec 1 13:50:14 2022 -0800

    squash: Redefine __print_symbolic to have a central define of the log string print function.

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 63ee0fd5f4c2..31a65106e93c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,12 +4,19 @@
 #include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/mutex.h>
-#include <cxlmem.h>
 #include <cxl.h>
 
 #define CREATE_TRACE_POINTS
+/* Must be after CREATE_TRACE_POINTS */
+#include <cxlmem.h>
 #include <trace/events/cxl.h>
 
+/*
+ * Must be included explicitly after trace header
+ * because CREATE_TRACE_POINTS can't be undefined for cxlmem.h???
+ */
+#include <cxl_event_log.h>
+
 #include "core.h"
 
 static bool cxl_raw_allow_all;
diff --git a/drivers/cxl/cxl_event_log.h b/drivers/cxl/cxl_event_log.h
new file mode 100644
index 000000000000..e8357bfeecdf
--- /dev/null
+++ b/drivers/cxl/cxl_event_log.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+/*
+ * Redefine __print_symbolic() from the trace code to be used in regular C code
+ * This compliments the define of cxl_event_log_type_str() in cxlmem.h
+ */
+static inline const char *__cxl_event_log_type_str(enum cxl_event_log_type type,
+                      const struct trace_print_flags *symbols)
+{
+      for (; symbols->mask >= 0; symbols++) {
+              if (type == symbols->mask)
+                      return symbols->name;
+      }
+      return "<unknown>";
+}
+
+#define __print_symbolic(value, symbol_array...)			\
+      ({								\
+              static const struct trace_print_flags symbols[] =		\
+                      { symbol_array, { -1, NULL }};			\
+              __cxl_event_log_type_str(value, symbols);			\
+      })
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a701a2e9bcba..15222a0ceb3f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -381,22 +381,16 @@ enum cxl_event_log_type {
 	CXL_EVENT_TYPE_MAX
 };
 
-static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
-{
-	switch (type) {
-	case CXL_EVENT_TYPE_INFO:
-		return "Informational";
-	case CXL_EVENT_TYPE_WARN:
-		return "Warning";
-	case CXL_EVENT_TYPE_FAIL:
-		return "Failure";
-	case CXL_EVENT_TYPE_FATAL:
-		return "Fatal";
-	default:
-		break;
-	}
-	return "<unknown>";
-}
+#define cxl_event_log_type_str(type)			\
+      __print_symbolic(type,				\
+              { CXL_EVENT_TYPE_INFO, "Informational" },	\
+              { CXL_EVENT_TYPE_WARN, "Warning" },	\
+              { CXL_EVENT_TYPE_FAIL, "Failure" },	\
+              { CXL_EVENT_TYPE_FATAL, "Fatal" })
+
+#ifndef CREATE_TRACE_POINTS
+#include "cxl_event_log.h"
+#endif
 
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
