Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BCC67B64A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjAYPwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjAYPwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:52:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2B5975A;
        Wed, 25 Jan 2023 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674661931; x=1706197931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bSl67dbnbBMzB2H2pgao0iEZT9rZMCcxV3Zm5N5Aylg=;
  b=LG5aD5kJG6gM4FSSOX4qUZpwj0YbC/bp6rmE3OzeTwsQWwb3aO/PCwgZ
   2zT67F8lXrCbd1E21wzR2ax5C5uOo0fNe8sNoHJ+bZBJIULw/VxK0BHZ2
   jdGA7lpChJmA0yeM3yuVB+ZFfW168Ige8ufqkn1NJnDbZSWRImZhxoMBA
   d33xcBQcC9t/QUViLshN3OC/pFPGPLztDJ+mpejbkoeb2mBbErK2DnIOD
   6xhptX/vgCrSKpRoK3cEyWd/WOQOQLFVr0egpq2Sg4L6l6wrinTifUaIR
   vNddbFxbEK2doThqAS065h1nVMc8ftaR8OURF7eRMiT7283udINzk3GWS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306936157"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="306936157"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:52:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="786473587"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="786473587"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.71.142])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:52:10 -0800
Date:   Wed, 25 Jan 2023 07:52:09 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Robert Richter <rrichter@amd.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Add debug messages for enabled mailbox
 commands
Message-ID: <Y9FQKdFjSaJBDPdR@aschofie-mobl2>
References: <20230125085728.234697-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125085728.234697-1-rrichter@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 09:57:28AM +0100, Robert Richter wrote:
> Only unsupported mailbox commands are reported in debug messages. A
> list of enabled commands is useful too. Change debug messages to also
> report the opcodes of enabled commands. Esp. if card initialization
> fails there is no way to get this information from userland.
> 
> On that occasion also add missing trailing newlines.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v2:
>  * Changed message to "Opcode 0x%04x enabled\n". Updated patch
>    description accordingly.

Thanks Robert,
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a48ade466d6a..202d49dd9911 100644
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
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
>  	}
>  }
>  
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> -- 
> 2.30.2
> 
