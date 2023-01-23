Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1EA678642
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjAWT1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjAWT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:26:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A052684;
        Mon, 23 Jan 2023 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674502018; x=1706038018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eK0m1r7rcSY+J7AzBLR9qXrpS2jUjHhJVcTqGo7GT9Q=;
  b=gXonmIQbaEvrUfLqJPxOAKlOxmtONrRDdpjMX2wic5CdtGnJS+cWqlrb
   anWzdS5Qq5avfhoNaXEB7XDjvVEhMGNgvEgHCsaaQ5QIfAqJFkH8m2AUg
   Gmmgoo6dJNcN1cznp9MUMkjf/zNZEzl7/3xFOtgEXdxzyStR5ng6O/CEr
   P38fcUJQc/lwAOjCXPHHma0ah5F6dgJVAFl3AuuBjBR9J9Jhu1Ym/XSrU
   cF6dHs1mOa9pMkIc/iyxv5Y6GHa3qUG8zuhdlpm4GpjcbrI5kIuulsgF2
   O7yUfTR6BYBdt1JnewhJFKo3kTR5eARncnKmSGMXBceg5kX9iYW7xq0Xb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328215458"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328215458"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:26:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="750549993"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="750549993"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.2.84])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:26:57 -0800
Date:   Mon, 23 Jan 2023 11:26:55 -0800
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
Message-ID: <Y87ff+zqVKf4oOJ/@aschofie-mobl2>
References: <20230119130450.107519-1-rrichter@amd.com>
 <Y84dleBbsQhE0Dic@aschofie-mobl2>
 <Y85+dwjO9JjtFtGa@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y85+dwjO9JjtFtGa@rric.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:32:55PM +0100, Robert Richter wrote:
> Hi Alison,
> 
> On 22.01.23 21:39:33, Alison Schofield wrote:
> > On Thu, Jan 19, 2023 at 02:04:50PM +0100, Robert Richter wrote:
> > > Only unsupported mailbox commands are reported in debug messages. A
> > > list of supported commands is useful too. Change debug messages to
> > > also report the opcodes of supported commands.
> > 
> > Hi Robert,
> > I wonder if you can get this info another way. When I try this 
> > loading cxl_test today, I get 99 new messages. Is this going to
> > create too much noise with debug kernels?
> 
> There are 26 commands supported by the driver, so I assume there are
> at least 4 cards in your system? To me the number of messages looks ok
> for a debug kernel. And, most kernels have dyndbg enabled allowing to
> enable only messages of interest? Esp. if card initialization fails
> there is no way to get this information from userland. The list of
> unsupported commands is of less use than the one for supported. That
> is the intention for the change.

cxl_walk_cel() job is to create the enabled_cmds list for the device.
How about we use that language in the message, like:

		set_bit(cmd->info.id, cxlds->enabled_cmds);
-               dev_dbg(cxlds->dev, "Opcode 0x%04x supported by driver\n", opcode);
+               dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);

Because when we say, "Opcode 0x%04x supported by driver\n", that comes
with the assumption that the device supported it too. By saying
'enabled', it's clear device and driver are aligned.

> 
> Thanks,
> 
> -Robert
