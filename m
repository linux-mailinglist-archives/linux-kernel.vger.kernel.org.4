Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88BE65C936
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjACWLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjACWLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:11:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C64F71;
        Tue,  3 Jan 2023 14:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672783900; x=1704319900;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l0hXQzVKljrv4MTtgDpTbqtBAy5mBpl95EbCsh/Eb7M=;
  b=GJZ1bLKHvT6Qikk04NWZZT2tmuRYCe62Rs1x1jkK4+1FyPwUmBaA9mkp
   vld1DIBE+pEx70qMZHAWfD9uZ0gc6CoNiugiw75kxQbGGu93RszYzc+G8
   Jof815pJaUaEJonRI4+hWXgoo+fq1CZfJwxmQKc9LJ6Lau6HRM6tPJFQD
   ua9Z/4dPXmXvVJ6MjhS8V4QYaLj181qwM9SdvgeCVjim7dZ9ZJUD6HLOv
   7tqCOwwLlYl8H0jmQYQgQiNqr4KQZUAx757yUZLCpD2vdeJGs1+LzGwNb
   6gGFWsGnTJ9ORlmp9uE2VzKR2zjBinGZTF1ktNnJyPt1CcH0LPFGizhht
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="321837467"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="321837467"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 14:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="687321323"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="687321323"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 03 Jan 2023 14:11:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 14:11:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 14:11:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 14:11:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 14:11:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COp4YzgE3ncAoCGoDJ+3BRGhpUqU4GcUHDO+KQIJJgcWd798kfZt7Y13zG8D3MMiMHpxRz4/z6aanCNUVl1yyL9v6R1Fntj9c+Fn96pyLJNwGH/LyHNUNLWU+Hy8AJuKEG9zI7Ie0i+7j1cBiEW9CVurCNkCKsTETo011qKCGtm7JhSoEkcHeR5DoWoVzCNVnYx1Fuh8iJ7OqccVrS8N6WklzL+hUXEoWs3NZKRR8Q3KuAAhFnyBYNHgNB14/tSrzGc8+vaNchhOxW4e2URoLOTc960dk3b6GG3UZ8X02EBXMlTGd3/Toz6fZEiQnz09BSmXYHtav3mFWktml3kE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0c5IOWRUOBv3wEuv1Zn78O4taepMSxiR1F4uiydcOw=;
 b=CdoOT3ZjDB2bZNIe0mXD6Xk0D1v9nH/u9AuMb4lmCn7RdWOo1UMB9bBZMH9l8boUeJnv5sudfh/aXyZ3NVOLXG6ZQ/pD95cQTrF3Fd3x6AZ/A8i1TfUF7TNkYuHx+WYG7MC4c/fb45qj97d9GI2b1/EHz9uBXN1y8jYxJaRWWDjigPl4+e5CdjcsyYzwu0n11Ykn3YJAs8YflfZ0CJOoo9gxsLZaRoCyd6kE/fsYpiPAdd9NF8q7BATzYum+k8gCslloEu6GNQzVjSZUvaq4vYfI6R0TvJT0g69FPzs+Z05T1uOM4OauHEomdcvCU3voLqwotjHD6JS//qkylUJ+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 22:11:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 22:11:35 +0000
Date:   Tue, 3 Jan 2023 14:11:33 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/mbox: Fix Payload Length check for Get Log command
Message-ID: <63b4a8153d6b6_517412948a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230103205937.1126626-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230103205937.1126626-1-rrichter@amd.com>
X-ClientProxiedBy: BY3PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:a03:255::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbb5bff-3061-4f73-74c9-08daedd77a63
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tc1+NIupNaXfogKef5shP8cqxOIu84MNRKPLifBM5RQMFSXlkrf+yhDQ3LIZoQ4maXlN5mDESIki51gpZKEYNDBoYLpWO2Az9436MdZM5aLbzGFxE3Tcgl8jyJ4vH7Ot6R6lGIFi+RByxpjnWndpd0avNIPflB5/N77rG7tGCGQWR+vrWdLcYnbv4JDW4tDYFIkakkBMMzPSOKoiK19iklAbnsU/6zkqUuQZg/gCvoVBXhMYeFH3BkbuQWr2egddUJ8qkFZ51+b/MVoYfyMgrUoD0MK4H7yfQfsxq3WJLZTA6qFSYgsrCrvOmKWtMDEtp/R5DRMfmK2WcymkhFYzMB6qjsYE/a2STQ0q/wgi1xa081pKtBlKvY7zUa46YUZWlew9EWiLlpe9lgsKO5qXrZpY1fDEqMdsTECmqKhL2leMCXRoT6zx1sfdpQ7HVRJDy+Am05NfZ4ZXhpRmqjHmwm8Ik5WXEU8X+Kc3/WjeIpzUL2X/oCZCZ6ydFsH7WdSDCtt9v49N6ECFOpQAocU1NNCyRboQb4TfKAdALAWRVIPGnNhAe+crBxmZ/8OVYq79XjJ9hFoLejmk6jbQYbv42SvVPEEhfBTr0dCPDViLjso6VAiBKGVlrUvM/bSKq4n/uFW1xjehqj0aCpQayJdq1Z6si5lcMJY2T7eUluYmV5l/qK5s83NZJGQP7bO93U0q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(83380400001)(26005)(9686003)(6512007)(186003)(6506007)(86362001)(38100700002)(82960400001)(41300700001)(8676002)(4326008)(2906002)(5660300002)(8936002)(6486002)(478600001)(66476007)(66946007)(316002)(66556008)(6636002)(110136005)(22166009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2ueeX7E2yVIQXxR7mvDLPGbWaC91VrO4dba9QjS2iE1ZuePx7hl+Q4JDu/F?=
 =?us-ascii?Q?8oG2rWS8gM32evidwXtaoKgWz3q/SqgUxEdZR4bFb84GMLXebt45vd+N2Ui5?=
 =?us-ascii?Q?goqg933AsRci2U7yDaXIHB1oNSk397jOC8ML4Uw1620FdknaDNF9J7DOpM4M?=
 =?us-ascii?Q?s2D/K14TR+FjmKBNEKKWbre910CA+lroSPMd974PTQb3btRgP0DtWM1swEle?=
 =?us-ascii?Q?s40ZOyzYgbXRQxPXne/3rGWEPSowc/NEOzkyh2gldVfV9e6Pkw7VOk8fyULW?=
 =?us-ascii?Q?HFCEGGenPL8VYg67aB2Wl+dQMmHb+9GxhaReXc7f5QMBrxav1uFOIm4BiR7G?=
 =?us-ascii?Q?NR/1vcC2fCieVQV5y5zlnSJie+eOuTtsSe7DuCFpJHbK8GtTuxCyuk02q1L5?=
 =?us-ascii?Q?PW2POpXen103dE6b97+8Kam9DFErZwBzdZVJOGAuzAJ1N2XtCfgOTQCvgqQg?=
 =?us-ascii?Q?DU88nOruBdoK+ktLD98KX1hMutaz+MEYeYoIeuxwP7O3ZvJhfT3100tetwYq?=
 =?us-ascii?Q?njWLha66tzpDWBhWxK2Tm2Hgh91UQ71aA1QEr2f7bnuuhtuH8pUNzki0/e/y?=
 =?us-ascii?Q?3yEF5lWtq7a4pMr9T/U5HJzbhiM0tbKQiZug2GBywT5mLn/fsd2NYE6w/yQQ?=
 =?us-ascii?Q?h35a2pyB+gChBeX+sDyZQkdDYjV3oR4iXHf+YsmPhDeGBnmyVMJ788aQC3ac?=
 =?us-ascii?Q?RhHUUhclj1U10VMP47m6R/FWid8D3F7NaCQN6noWacgb6agMN/hiOvz2BhGk?=
 =?us-ascii?Q?opoQlfWzuBOaMeLWXWrA2BGdy3kevJLtAo/feGZv2YxJ1zA0h8YRp7rs+xcb?=
 =?us-ascii?Q?aShINJ30wNDdoKw38XHz6aXtywr3ysG45feVdNaITTddW9XuU1b+hN0F1Uca?=
 =?us-ascii?Q?rg8CkTaP1U7AvmP+GmL2fMC4K7OhL0c5FmWPjJaPOye1DNZnfum0y5J9qC/a?=
 =?us-ascii?Q?ZlIet6XkFathI7WUHw2sya1n5Yc74gVnSq3Jnb0LhcCGipy26LrkLrxRtXmu?=
 =?us-ascii?Q?kJT9PTAtJAcF8elfp5beo9la5b+YikW9w/dRhmHmOlacjz0VDWXwU/g6MSsg?=
 =?us-ascii?Q?AGYdq75xIT9aMtQvdzUq/rDTNxm/nGpOvEicdslSt4FyErvris8tbX/JT3ix?=
 =?us-ascii?Q?RWl0tMifuS1FSN0Wxm22fUb4WKvPCt/f8s5DSz+dzkJJlIuEr5tLREemgCNX?=
 =?us-ascii?Q?MOsOIss2SsaHWeJDUJjqx9pgq6o+UqINiPCTcAqt5KNtwJnGGSHz+KfveYlq?=
 =?us-ascii?Q?d9vASXpaDfXmgS74091FH4ZevKUVu6XwuoyUZEvnJS19WfJnLsQfgsBmFpgI?=
 =?us-ascii?Q?OXXgc82PA1+Fog4Fu+DNhwP8l8m6GABxR9xCIY7NOpqhO8DJrIbT2S+cEPQW?=
 =?us-ascii?Q?jc2KTDqIzCAzblTyKgbzjx+lZn5ZqOiGBRP+p7TJWCt9LflC7XVH4C4LQ6S0?=
 =?us-ascii?Q?zSmF6//tYZd3soCvflmio9o1C9xAJ24VA3tF+R+15x1JKnC4+cnKjcWvygLY?=
 =?us-ascii?Q?2e2cT9jl2iCV8BnmpVrLllbilwLbvR0U+1qqJ+hWZ9NjJ4WocErauwj1uHw2?=
 =?us-ascii?Q?zEfQ4eH/VaPjJRAFBtYLCVhGA9ZPtorjtjqSRY16e3AeK2CZio8Hv1mY6UP9?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbb5bff-3061-4f73-74c9-08daedd77a63
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 22:11:35.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVabQFp6D1qXdimmJSgAaTU2A9HyG5PNr/FJkfnj+Z3EIr/VRN/O7gtfRz7WZDCU9mGQHprdmuSA2gFDcG30UMGVEmXAgeZx5U6+WRYqZkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7608
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Commit 2aeaf663b85e introduced strict checking for variable length
> payload size validation. The payload length of received data must
> match the size of the requested data by the caller except for the case
> where the min_out value is set.
> 
> The Get Log command does not have a header with a length field set.
> The Log size is determined by the Get Supported Logs command (CXL 3.0,
> 8.2.9.5.1). However, the actual size can be smaller and the number of
> valid bytes in the payload output must be determined reading the
> Payload Length field (CXL 3.0, Table 8-36, Note 2).
> 
> Two issues arise: The command can successfully complete with a payload
> length of zero. And, the valid payload length must then also be
> consumed by the caller.

Perhaps this is confusion about what the "Log Size" field of Get
Supported Logs means? My reading is that the "Log Size" field indicates
the data "currently available" in the log. Correct me if I am wrong, but
it seems your reading is that it is the "possibly available" data and
software can not assume anything is available until it actually goes to
read the log.

The spec does feel ambiguous here as it could have left off the word
"maximum" to make it clearer it is the data currently pending value, or
leave off the word "available" to make it clear that this value is the
max that will ever be valid for one retrieval, but not necessarily
currently. I do not think "CXL 3.0, Table 8-36, Note 2" helps to clear
this up either as that does not answer what expectations software can
assume about Get Log::Log Size.

Are you sure that this is not a device-side implementation issue where
it needs to make sure that Get Supported Logs indicates what Get Log can
expect?

Table 8-94 "Identify Memory Device Output Payload" specifies the
*possible* data that can be made available in a log.

> 
> Change cxl_xfer_log() to pass the number of payload bytes back to the
> caller to determine the number of log entries.
> 
> Logs can be bigger than the maximum payload length and multiple Get
> Log commands can be issued. If the received payload size is smaller
> than the maximum payload size we can assume all valid bytes have been
> fetched. Stop sending further Get Log commands then.
> 
> Also, implement CXL_NO_PAYLOAD_SIZE_VALIDATION as special value to
> @min_out to skip the payload size validation check. A value of zero
> for @min_out is already widespread in use as default if the size must
> match @size_out. Thus, zero can not be passed to allow zero length
> variable payloads, CXL_NO_PAYLOAD_SIZE_VALIDATION should be used
> instead for this case.
> 
> On that occasion, change debug messages to also report supported
> opcodes.
> 
> There could be other variable payloads commands affected by this
> strict check, the implementation of GET_LSA and SET_LSA in this kernel
> could possibly be broken too. A fix of this is not scope of this
> patch.

SET_LSA cannot be broken because SET_LSA does not return an output
payload, and GET_LSA never expects short reads.

Now, if short reads need to be supported on production devices for any
variable length output payload command, I would rather see that handled
as a cxl_internal_send_cmd() special case where mbox_cmd->size_out is
consulted when cxl_internal_send_cmd() returns -EIO.

> 
> Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/mbox.c | 41 ++++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxlmem.h    |  5 +++++
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..0c2056ae8aff 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -183,11 +183,16 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>  	 * Variable sized output needs to at least satisfy the caller's
>  	 * minimum if not the fully requested size.
>  	 */
> +
> +	if (min_out == CXL_NO_PAYLOAD_SIZE_VALIDATION)
> +		return 0;
> +
>  	if (min_out == 0)
>  		min_out = out_size;
>  
>  	if (mbox_cmd->size_out < min_out)
>  		return -EIO;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_internal_send_cmd, CXL);
> @@ -554,6 +559,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  {
>  	u32 remaining = size;
>  	u32 offset = 0;
> +	u32 size_out;
>  
>  	while (remaining) {
>  		u32 xfer_size = min_t(u32, remaining, cxlds->payload_size);
> @@ -572,6 +578,8 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  			.size_in = sizeof(log),
>  			.payload_in = &log,
>  			.size_out = xfer_size,
> +			/* Any size is allowed (CXL 3.0, Table 8-36). */
> +			.min_out = CXL_NO_PAYLOAD_SIZE_VALIDATION,
>  			.payload_out = out,
>  		};
>  
> @@ -579,12 +587,24 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  		if (rc < 0)
>  			return rc;
>  
> -		out += xfer_size;
> -		remaining -= xfer_size;
> -		offset += xfer_size;
> +		size_out = mbox_cmd.size_out;
> +		if (size_out > xfer_size)
> +			return -ENXIO;
> +
> +		out += size_out;
> +		remaining -= size_out;
> +		offset += size_out;
> +
> +		/*
> +		 * A smaller output payload length indicates all valid
> +		 * bytes have been fetched.
> +		 */
> +		if (size_out < xfer_size)
> +			break;
>  	}
>  
> -	return 0;
> +	/* Total number of bytes fetched. */
> +	return offset;
>  }
>  
>  /**
> @@ -608,13 +628,11 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
> -		if (!cmd) {
> -			dev_dbg(cxlds->dev,
> -				"Opcode 0x%04x unsupported by driver", opcode);
> -			continue;
> -		}
> +		if (cmd)
> +			set_bit(cmd->info.id, cxlds->enabled_cmds);
>  
> -		set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x %ssupported by driver",
> +			opcode, cmd ? "" : "un");
>  	}
>  }
>  
> @@ -695,11 +713,12 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  		}
>  
>  		rc = cxl_xfer_log(cxlds, &uuid, size, log);
> -		if (rc) {
> +		if (rc < 0) {
>  			kvfree(log);
>  			goto out;
>  		}
>  
> +		size = (u32)rc;
>  		cxl_walk_cel(cxlds, size, log);
>  		kvfree(log);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..2db24b062913 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -102,6 +102,10 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   *            variable sized output commands, it tells the exact number of bytes
>   *            written.
>   * @min_out: (input) internal command output payload size validation
> + *  * %0:   Payload size must match @size_out.
> + *  * %>0:  Minimum payload size.
> + *  * %CXL_NO_PAYLOAD_SIZE_VALIDATION: Skip payload size validation check.
> + *
>   * @return_code: (output) Error code returned from hardware.
>   *
>   * This is the primary mechanism used to send commands to the hardware.
> @@ -117,6 +121,7 @@ struct cxl_mbox_cmd {
>  	size_t size_in;
>  	size_t size_out;
>  	size_t min_out;
> +#define CXL_NO_PAYLOAD_SIZE_VALIDATION	SIZE_MAX
>  	u16 return_code;
>  };
>  
> -- 
> 2.30.2
> 


