Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0EC6F13DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345433AbjD1JIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjD1JIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:08:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EDA468C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682672876; x=1714208876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6TJUkTvdrEYkbGsK6S0/HtOdmSBnybS0AaWaNHFMuvU=;
  b=jOG0kANjFvhACMNIvlDe+VeKT9WLDHVZWSrDlXtKuNcnXHIat/yAnRh6
   p6hcK6aoq2BJmhMD80Ukn7ePRPT5Ej85FtBthSMYhEmIbAScDMtKVt92v
   34A3HC1gt1zORK2OwYSOjiugHcYw8Rv6WQ60miQl8T+cXc1Bv/kBYcvpG
   r7bGw4A7dp/cx4DTOdrCYizlBrxHBTp2LkRa+tfjIkaZrx5NMtYfeXwHI
   B37WIqPIIPlIwXCBqNszfREl3u3eYO/mwuG13Cez4qD3Pd1Pe9KXcV13z
   vayvY9jfSq4iczLS1T7GpEWbnF7cFya9aOO/6sRPyGUsrybkoUyuBb6Nz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="332001158"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="332001158"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="727464277"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="727464277"
Received: from ahermans-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.35.91])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:07:46 -0700
Date:   Fri, 28 Apr 2023 11:07:43 +0200
From:   Andi Shyti <andi.shyti@intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [Intel-gfx] [PATCH v8 2/2] drm/i915: Use correct huge page
 manager for MTL
Message-ID: <ZEuM33M1J2SlDuTp@ashyti-mobl2.lan>
References: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
 <20230425-hugepage-migrate-v8-2-7868d54eaa27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425-hugepage-migrate-v8-2-7868d54eaa27@intel.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

> MTL currently uses gen8_ppgtt_insert_huge when managing huge pages.
> This is because MTL reports as not supporting 64K pages, or more
> accurately, the system that reports whether a platform has 64K pages
> reports false for MTL.  This is only half correct, as the 64K page support
> reporting system only cares about 64K page support for LMEM, which MTL
> doesn't have.
> 
> MTL should be using xehpsdv_ppgtt_insert_huge.  However, simply changing
> over to using that manager doesn't resolve the issue because MTL is
> expecting the virtual address space for the page table to be flushed after
> initialization, so we must also add a flush statement there.
> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
