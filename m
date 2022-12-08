Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51C646800
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLHDrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLHDrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:47:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7839BF48;
        Wed,  7 Dec 2022 19:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670471257; x=1702007257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rK8J3bc+OBp75ihGNvVIlZln4+9cNadZcCz8MTxE/l8=;
  b=SxQ4pHJzd+k6cxLrsSejRzdgQbIvBnH6ssdDOp58pkdJtCr8FSYo+0iq
   Wlf9mAEuPZt4l5KHuaY1jTUgZoXIGsFVpRAL/QLMeJ+pekACtGD06ui4i
   IP6UqUZ1Hh9YDdAoXyIindAa7ks2I6uyedS/y3Yw53WXsINU3pkRTbUH5
   KqA4bTCfghLfoPyoH6Php0X68kAG7XoxV1iZmzJE8eaTra3LIe6Gt9gni
   g7tIUMZilLanxB/JWsiNW8ujEhI0dQD55MpQpQ1g6Zv02CF2KozMfaqze
   dNYzWfKkBg0NH1+nDx2HaiVNSieGDnpji7BMc4L8o+Z2DzwA2j++jCgn7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="296759120"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="296759120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 19:47:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="789143584"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="789143584"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.198.95])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 19:47:36 -0800
Date:   Wed, 7 Dec 2022 19:47:35 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <Y5FeVySReYXU6E2p@aschofie-mobl2>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
 <638ffd5eaa3a7_c95729426@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y5C7EYz1VrG2H7jh@aschofie-mobl2>
 <6391082ed3374_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6391082ed3374_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 01:39:58PM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > On Tue, Dec 06, 2022 at 06:41:34PM -0800, Dan Williams wrote:
> > > alison.schofield@ wrote:
> [..]
> > > > +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > > > +		       struct cxl_region *cxlr)
> > > > +{
> > > > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > > +	const char *memdev_name = dev_name(&cxlmd->dev);
> > > > +	const char *pcidev_name = dev_name(cxlds->dev);
> > > > +	struct cxl_mbox_poison_payload_out *po;
> > > > +	struct cxl_mbox_poison_payload_in pi;
> > > > +	int nr_records = 0;
> > > > +	int rc;
> > > > +
> > > > +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > > > +	if (!po)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	pi.offset = cpu_to_le64(offset);
> > > > +	pi.length = cpu_to_le64(len);
> > > > +
> > > > +	rc = mutex_lock_interruptible(&cxlds->poison_list_mutex);
> > > 
> > > So I do not know what this mutex is protecting if there is an allocation
> > > per cxl_mem_get_poison() invocation. Although I suspect that's somewhat
> > > wasteful. Just allocate one buffer at the beginning of time and then use
> > > the lock to protect that buffer.
> > 
> > Intent was a single lock on the device to protect the state of the
> > poison list retrieval - do not allow > 1 reader. With > 1 reader
> > software may not know if it retrieved the complete list.
> > 
> > I'm not understanding about protecting a buffer, instead of protecting
> > the state. Here I try to protect the state.
> 
> Ah, sorry I read cxlds->poison_list_mutex and assumed it was serializing
> access to the buffer, not a state machine. I do think it would be
> worthwhile to make this a self contained structure with its own kdoc to
> explain what is going on, something like:
> 

OK thanks, it's getting through to me now. 
Will do !

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..02697d1d951c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -193,6 +193,19 @@ struct cxl_endpoint_dvsec_info {
>         struct range dvsec_range[2];
>  };
>  
> +/**
> + * struct cxl_poison_state - summary
> + * @payload: ...
> + * @lock: ...
> + *
> + * A bit more description of why state needs to be held over successive
> + * mbox commands...
> + */
> +struct cxl_poison_state {
> +       void *payload;
> +       struct mutex lock;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -210,6 +223,7 @@ struct cxl_endpoint_dvsec_info {
>   * @lsa_size: Size of Label Storage Area
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>   * @mbox_mutex: Mutex to synchronize mailbox access.
> + * @poison: Poison list retrieval and tracing
>   * @firmware_version: Firmware version for the memory device.
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
> @@ -244,6 +258,7 @@ struct cxl_dev_state {
>         size_t payload_size;
>         size_t lsa_size;
>         struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> +       struct cxl_poison_state poison;
>         char firmware_version[0x10];
>         DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>         DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
