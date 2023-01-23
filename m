Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6658D6774FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 06:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjAWFjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 00:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWFjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 00:39:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BAA12051;
        Sun, 22 Jan 2023 21:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674452376; x=1705988376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zdyocXy2oYdV9XjxoMErRIbQkEh52w7mmJ9HtzKXpK8=;
  b=gg/PwBajstDB9vyN2SC6dtGiy/p1RxWe9GMmoNjDGLBzaLW3S1igOsi3
   ey6zsFDNPmK1cjd2Uq94CN73eFVe97RzeICuSOq0UtcbW+5p6IFZX7Ec7
   yKtpjGUcY8eij/KSvqax5KdySYBcJll4HAfLJenFvCI8AdQ9/GiGdvsOJ
   LX9yVYocXyZM5SvEEhKz7PdqxnKo4mdf6gxN2qWpkEW/U2fvfS6gEDqpY
   os7A9p2GI2kL0YHaaoIB5AwHy0KvBIKRJqnWdVX4+ONGHUHnAyCydPLvx
   akTaVvs+QVCTleZM+Ta2Pf82N2PQJzzjX6OGJFRwwcmH5/bs6W5rXxQU0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="327238307"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="327238307"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 21:39:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="906860472"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="906860472"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.11.175])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 21:39:35 -0800
Date:   Sun, 22 Jan 2023 21:39:33 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Robert Richter <rrichter@amd.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Add debug messages for supported mailbox
 commands
Message-ID: <Y84dleBbsQhE0Dic@aschofie-mobl2>
References: <20230119130450.107519-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119130450.107519-1-rrichter@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:04:50PM +0100, Robert Richter wrote:
> Only unsupported mailbox commands are reported in debug messages. A
> list of supported commands is useful too. Change debug messages to
> also report the opcodes of supported commands.

Hi Robert,
I wonder if you can get this info another way. When I try this 
loading cxl_test today, I get 99 new messages. Is this going to
create too much noise with debug kernels?
Alison

> 
> On that occasion also add missing trailing newlines.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a48ade466d6a..ffa9f84c2dce 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -629,11 +629,12 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  
>  		if (!cmd) {
>  			dev_dbg(cxlds->dev,
> -				"Opcode 0x%04x unsupported by driver", opcode);
> +				"Opcode 0x%04x unsupported by driver\n", opcode);
>  			continue;
>  		}
>  
>  		set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x supported by driver\n", opcode);
>  	}
>  }
>  
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> -- 
> 2.30.2
> 
