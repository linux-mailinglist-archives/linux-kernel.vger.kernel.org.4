Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F00726998
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjFGTTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFGTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:19:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29911B0;
        Wed,  7 Jun 2023 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686165538; x=1717701538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ebd/5EJZnMmscD9/Cb26uNOTuFkdf4ba2XYKYT0ut5A=;
  b=CnI6y377SGSgZVjWME/t6cfeC4iFnmXnWPWFY2Emj+IP7CkN9dv5y8uV
   TA5POn6b/vPfZKLI/QfmhPNR2c9s+gdTGHJ8AnVJcKjMl3QCbgc/VMWbW
   uytCBzg+9PQjhwf2PTXETzLl6TkLXtgxcW3cEmfuq+7fQQixtkHvjUpQ1
   uMEfBkgBSWmx0SO0Ed7FkVAnczpbnFUUae0ilBcl1YPdDrrn+engLf3qv
   zOiXvW03ENgw5XKMlIN4fpCqCose7xqP756uPWGFqPNJXEGWBNyALdzJy
   rn0e0UXfETkjnhXVCbCaMcwrxFehAM6yPuNC6XwADvvg7eB8wkS2d+ADd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337447801"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="337447801"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="1039804709"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="1039804709"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.21.116])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:18:57 -0700
Date:   Wed, 7 Jun 2023 12:18:55 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 2/4] tools/testing/cxl: Fix command effects for
 inject/clear poison
Message-ID: <ZIDYHzw3sVTiOjeX@aschofie-mobl2>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
 <20230602-vv-fw_update-v2-2-e9e5cd5adb44@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602-vv-fw_update-v2-2-e9e5cd5adb44@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 02:20:23PM -0600, Vishal Verma wrote:
> The CXL spec (3.0, section 8.2.9.8.4) Lists Inject Poison and Clear
> Poison as having the effects of "Immediate Data Change". Fix this in the
> mock driver so that the command effect log is populated correctly.
> 
> Fixes: 371c16101ee8 ("tools/testing/cxl: Mock the Inject Poison mailbox command")
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Hi Vishal,
I took a look at this, wondering if we should promote it as a 6.4 fix.
I came up with a no. It has no user impact of inject/clear usage in the
mock driver environment.

Thanks for fixing!
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
>  tools/testing/cxl/test/mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 34b48027b3de..403cd3608772 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -52,11 +52,11 @@ static struct cxl_cel_entry mock_cel[] = {
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> -		.effect = cpu_to_le16(0),
> +		.effect = cpu_to_le16(EFFECT(2)),
>  	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
> -		.effect = cpu_to_le16(0),
> +		.effect = cpu_to_le16(EFFECT(2)),
>  	},
>  };
>  
> 
> -- 
> 2.40.1
> 
