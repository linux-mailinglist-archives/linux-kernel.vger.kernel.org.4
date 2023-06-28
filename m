Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB0741B06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjF1VeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjF1VeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:34:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B671FE4;
        Wed, 28 Jun 2023 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687988049; x=1719524049;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2zFRPcPqSdw/rQupEM6m4agW4/QKfyjYyUa1kit0f1s=;
  b=UIa1fHs2Zs9fdB87YCNRFAuxiWbmg/365ZNADpyUTOAtzHvLgfO5lBUK
   wxw67CFmygXg+ogUUMNSmnnNLywwAJ0Au4bjzmidC/nbeyA6beV653ui/
   lSYP1SiJBy5+Qb4mDjF7U7L2U0i/tqr98wyd7l0MXuKC+xLb3kZz6wVk/
   4nCnAFdauRuLIoNlwLs9RgXmrPzHLU9plxZuBFcUBTmly0A3B2lUc86t9
   D2mOHA42J2FRRrzQU0rztrUyjmIDZ8kycv95abvSgM7JDW6P8UmVR+wzU
   xTd3Fit49RtYOAk49V48l7GcxjvapcCmElyyuz4oLkqLm/WUSy1+cpXET
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="351758361"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="351758361"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 14:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="787172958"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="787172958"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.17])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 14:34:07 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Florian Kauer <florian.kauer@linutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, kurt@linutronix.de,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net v2] igc: Prevent garbled TX queue
 with XDP ZEROCOPY
In-Reply-To: <20230628091148.62256-1-florian.kauer@linutronix.de>
References: <20230628091148.62256-1-florian.kauer@linutronix.de>
Date:   Wed, 28 Jun 2023 14:34:07 -0700
Message-ID: <87a5wjqnjk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Kauer <florian.kauer@linutronix.de> writes:

> In normal operation, each populated queue item has
> next_to_watch pointing to the last TX desc of the packet,
> while each cleaned item has it set to 0. In particular,
> next_to_use that points to the next (necessarily clean)
> item to use has next_to_watch set to 0.
>
> When the TX queue is used both by an application using
> AF_XDP with ZEROCOPY as well as a second non-XDP application
> generating high traffic, the queue pointers can get in
> an invalid state where next_to_use points to an item
> where next_to_watch is NOT set to 0.
>
> However, the implementation assumes at several places
> that this is never the case, so if it does hold,
> bad things happen. In particular, within the loop inside
> of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
> Finally, this prevents any further transmission via
> this queue and it never gets unblocked or signaled.
> Secondly, if the queue is in this garbled state,
> the inner loop of igc_clean_tx_ring() will never terminate,
> completely hogging a CPU core.
>
> The reason is that igc_xdp_xmit_zc() reads next_to_use
> before acquiring the lock, and writing it back
> (potentially unmodified) later. If it got modified
> before locking, the outdated next_to_use is written
> pointing to an item that was already used elsewhere
> (and thus next_to_watch got written).
>
> Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---

This patch doesn't directly apply because there's a small conflict with
commit 95b681485563 ("igc: Avoid transmit queue timeout for XDP"),
but really easy to solve.

Anyway, good catch:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
