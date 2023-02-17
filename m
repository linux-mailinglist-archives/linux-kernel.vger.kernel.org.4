Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FBE69ACA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBQNlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBQNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:41:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57C66066;
        Fri, 17 Feb 2023 05:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676641279; x=1708177279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t4Ey/p9EDIWkng1aNSRpT0iEnvdw8bCXcQ1HC5gCP9Q=;
  b=mXFJ/NAIrKVsPkqAdupwS4PnvpQ3FubY0UQawwQbHMcu3u77Pnf2KSjF
   FSuO2FL7FY4kQq2d54ZVSp6dDzi0LI4Dui37F3sCa11UY1g2TQoSo4aw4
   1wLzGYx0lsP+YmHcI3sNQm2UucdMQNrE6A2p7UhbSlgkfNuYzg7trAm/D
   dZdy3go9b9gwFmRVAh50mQBFBFLY3soqo7WryY6ix//5mgbbS4fEFnXCg
   3l01pgnJnnrUx/WMSDCC6zuSBdQCY3XYVcoE8STi9MVb7BZlOoFxvpeZY
   8rPiujuFD+Z1AD3fNU3uxZE5/Dgm+S1OLtxQL40N0LCSiOiHiNLPTJh2n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="396662533"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="396662533"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 05:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="813377249"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="813377249"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2023 05:41:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C8F211C5; Fri, 17 Feb 2023 15:41:56 +0200 (EET)
Date:   Fri, 17 Feb 2023 15:41:56 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Natalia Petrova <n.petrova@fintech.ru>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] thunderbolt_tb: add check for return value of
 'tb_switch_find_port'
Message-ID: <Y++EJArOnOenkZxw@black.fi.intel.com>
References: <20230217132432.487106-1-n.petrova@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230217132432.487106-1-n.petrova@fintech.ru>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 17, 2023 at 04:24:32PM +0300, Natalia Petrova wrote:
> Return value of 'tb_switch_find_port' has to be checked to avoid
> null pointer dereferences in functions tb_tunnel_alloc_dma() and

NULL

> tb_port_info().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 386e5e29d81c ("thunderbolt: Make tb_find_port() available to other files")
> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
> ---
>  drivers/thunderbolt/tb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 9853f6c7e81d..5d6cded68d46 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -1156,6 +1156,8 @@ static int tb_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd,
>  	sw = tb_to_switch(xd->dev.parent);
>  	dst_port = tb_port_at(xd->route, sw);
>  	nhi_port = tb_switch_find_port(tb->root_switch, TB_TYPE_NHI);
> +	if (!nhi_port)

This really cannot happen in real life. All host routers must have a
host interface adapter so I'm not sure if adding these checks do
anything else than adding dead code.

> +		return -EIO;
>  
>  	mutex_lock(&tb->lock);
>  	tunnel = tb_tunnel_alloc_dma(tb, nhi_port, dst_port, transmit_path,
> -- 
> 2.34.1
