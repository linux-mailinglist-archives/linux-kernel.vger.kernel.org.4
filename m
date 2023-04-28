Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69E6F136E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbjD1IqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD1IqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:46:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2072D2728
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682671579; x=1714207579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MiIRPSbnyPcNBtaIyN1Mx4srv0050xqGX02MVcrejCc=;
  b=i+pWaa7+C+SMFE5YaDGDKHilbyWmgsuDhCjNMQ7Pv9lcml8YQj8GHU20
   4Q1mAjE/96lfEps+vAXPnp0hvKBdizwQAa4xv8E8FeJxzUI0XH2hsj78c
   rjd3/UmY5bveGUfe4Y7QjMUMYcU3JkswwxDw75k5RfVEq7Zo+dTrX/AsX
   ChMxgSBwKWbi5RSP8bbDf5b3H0141Nd9dJTjeBkj/2/wWwn++dLIE2PoW
   45Vws9HiRyC/nwYPUBdDybzWb8AFPtmO125dtjTbK27f68+rGTXc6J/xX
   cZFAWEB88kp5kHRJTSLFIGQE7b2lV0ZmbxLqPMRkWpfAIbUwCUDc5Lcsq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331994903"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="331994903"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 01:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="694730918"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="694730918"
Received: from ahermans-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.35.91])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 01:46:17 -0700
Date:   Fri, 28 Apr 2023 10:46:14 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [Intel-gfx] [PATCH v8 1/2] drm/i915: Migrate platform-dependent
 mock hugepage selftests to live
Message-ID: <ZEuH1i5ZEbjHcYEK@ashyti-mobl2.lan>
References: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
 <20230425-hugepage-migrate-v8-1-7868d54eaa27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425-hugepage-migrate-v8-1-7868d54eaa27@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Wed, Apr 26, 2023 at 11:28:48PM +0200, Andrzej Hajda wrote:
> From: Jonathan Cavitt <jonathan.cavitt@intel.com>
> 
> Convert the igt_mock_ppgtt_huge_fill and igt_mock_ppgtt_64K mock selftests
> into live selftests as their requirements have recently become
> platform-dependent. Additionally, apply necessary platform dependency
> checks to these tests.
> 
> v8:
> - handle properly 64K and 2M pages
> v9:
> - do not expect 64K pages if 2M are present
> - fix hex printing
> - obey commit message line limit
> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Co-developed-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
