Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85E708E10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjESC6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjESC6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:58:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3881310CF;
        Thu, 18 May 2023 19:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684465098; x=1716001098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lVYvIVW2ijHM6EU94P3MyA9Xq/oENLK2H4Zfidz0kJY=;
  b=C/fkMVsexM1waDx3rMN9i34szfwTGBDqGQjTGaze3g+zhUN74/JiNZK7
   7OSxTs9slGtAXjNBYaVogRkV1TySZR1oAwjm6tbvyQUCYGpVQyj8VqnP1
   pxW9Y9BLcoIivjNZzSBvaJprIVb36Wm+u34JBC0mBUlk77yccZq/YlgLg
   drEgiohqVXvFIzerwCuw2K4zOPOQTpcUWLKSCBfRIRQmY7AySKPEjoYcL
   fBu9qWhNGnuc4ONBfpCfj3CgIpG0t7ACTJM0B6/+JAftWmYRJVFojNx2B
   1wwBIMD1Q1ti4sN5oWV2Eb3Z+tj3XOa0xDhzoHTebCF25X3pGyCvzz2Vf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="417953843"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="417953843"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="696552248"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="696552248"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.20.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:58:16 -0700
Date:   Thu, 18 May 2023 19:58:15 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 3/4] cxl: add a firmware update mechanism using the sysfs
 firmware loader
Message-ID: <ZGblx0pCpJPvCS7M@aschofie-mobl2>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
 <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 09:09:27PM -0600, Vishal Verma wrote:
> The sysfs based firmware loader mechanism was created to easily allow
> userspace to upload firmware images to FPGA cards. This also happens to
> be pretty suitable to create a user-initiated but kernel-controlled
> firmware update mechanism for CXL devices, using the CXL specified
> mailbox commands.
> 
> Since firmware update commands can be long-running, and can be processed
> in the background by the endpoint device, it is desirable to have the
> ability to chunk the firmware transfer down to smaller pieces, so that
> one operation does not monopolize the mailbox, locking out any other
> long running background commands entirely - e.g. security commands like
> 'sanitize' or poison scanning operations.
> 
> The firmware loader mechanism allows a natural way to perform this
> chunking, as after each mailbox command, that is restricted to the
> maximum mailbox payload size, the cxl memdev driver relinquishes control
> back to the fw_loader system and awaits the next chunk of data to
> transfer. This opens opportunities for other background commands to
> access the mailbox and send their own slices of background commands.
> 
> Add the necessary helpers and state tracking to be able to perform the
> 'Get FW Info', 'Transfer FW', and 'Activate FW' mailbox commands as
> described in the CXL spec. Wire these up to the firmware loader
> callbacks, and register with that system to create the memX/firmware/
> sysfs ABI.

I just have a quick drive-by comment for you....

> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/cxl/cxlmem.h                    |  79 ++++++++
>  drivers/cxl/core/mbox.c                 |   1 +
>  drivers/cxl/core/memdev.c               | 324 ++++++++++++++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
>  drivers/cxl/Kconfig                     |   1 +
>  5 files changed, 416 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8c3302fc7738..0ecee5b558f4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

snip

> + * Get Firmware Info
> + * CXL rev 3.0 section 8.2.9.3.1; Table 8-56
> + */
> +struct cxl_mbox_get_fw_info {
> +	u8 num_slots;
> +	u8 slot_info;
> +	u8 activation_cap;
> +	u8 reserved[13];
> +	char slot_1_revision[0x10];
> +	char slot_2_revision[0x10];
> +	char slot_3_revision[0x10];
> +	char slot_4_revision[0x10];

The practice here is to use decimals [16]

> +} __packed;
> +

snip

> + * Transfer Firmware Input Payload
> + * CXL rev 3.0 section 8.2.9.3.2; Table 8-57
> + */
> +struct cxl_mbox_transfer_fw {
> +	u8 action;
> +	u8 slot;
> +	u8 reserved[2];
> +	__le32 offset;
> +	u8 reserved2[0x78];

Here too.

That's all for now.

