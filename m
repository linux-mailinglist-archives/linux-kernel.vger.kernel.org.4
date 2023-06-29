Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771C742AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjF2QZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjF2QZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:25:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1E30C5;
        Thu, 29 Jun 2023 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688055946; x=1719591946;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GMipEncNpFuzbp3Y+IWzNKkgCXn6RBM75OjxnGRggWw=;
  b=NrPWlEWiIdpeni7tO1fYdsoTPccIGc/5658ie7TTX66Cab2seFiCcs/v
   XWT19BaAoLCq2Z0KAPWqyEDZQkk3bVYA0Ywo57C6AjsjCoA8oPe60meyu
   TdGk3wqn/tCvxX3ayeyTaSs69oQBgp5OSh50puV1hAQV7hcDPwFrO9Siy
   2GFQBxyURt8WPdy1yIheJofxgqjDxIm065sEuqbTu8gIA1dJFDoxsMimF
   ERn5VheCu8rtfgCd3+JoXGb70wpOavIAFIjss5eEhuhTQDOx8OMsdatgQ
   2qIUuyenYhte9vVzB0mk+ihXZKYGAH7Xu1qeULFdmhXx3zOvmeTHOYMI+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="448535718"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="448535718"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 09:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="752704992"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="752704992"
Received: from pdurugk-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.78.99])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 09:25:43 -0700
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
In-Reply-To: <b64dc5c7-600c-66db-d125-2d747a21c1d8@linutronix.de>
References: <20230628091148.62256-1-florian.kauer@linutronix.de>
 <87a5wjqnjk.fsf@intel.com>
 <b64dc5c7-600c-66db-d125-2d747a21c1d8@linutronix.de>
Date:   Thu, 29 Jun 2023 09:25:43 -0700
Message-ID: <87edlup75k.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Kauer <florian.kauer@linutronix.de> writes:

> Hi Vinicius,
>
> On 28.06.23 23:34, Vinicius Costa Gomes wrote:
>> Florian Kauer <florian.kauer@linutronix.de> writes:
>> 
>>> In normal operation, each populated queue item has
>>> next_to_watch pointing to the last TX desc of the packet,
>>> while each cleaned item has it set to 0. In particular,
>>> next_to_use that points to the next (necessarily clean)
>>> item to use has next_to_watch set to 0.
>>>
>>> When the TX queue is used both by an application using
>>> AF_XDP with ZEROCOPY as well as a second non-XDP application
>>> generating high traffic, the queue pointers can get in
>>> an invalid state where next_to_use points to an item
>>> where next_to_watch is NOT set to 0.
>>>
>>> However, the implementation assumes at several places
>>> that this is never the case, so if it does hold,
>>> bad things happen. In particular, within the loop inside
>>> of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
>>> Finally, this prevents any further transmission via
>>> this queue and it never gets unblocked or signaled.
>>> Secondly, if the queue is in this garbled state,
>>> the inner loop of igc_clean_tx_ring() will never terminate,
>>> completely hogging a CPU core.
>>>
>>> The reason is that igc_xdp_xmit_zc() reads next_to_use
>>> before acquiring the lock, and writing it back
>>> (potentially unmodified) later. If it got modified
>>> before locking, the outdated next_to_use is written
>>> pointing to an item that was already used elsewhere
>>> (and thus next_to_watch got written).
>>>
>>> Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
>>> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
>>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>>> Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
>>> ---
>> 
>> This patch doesn't directly apply because there's a small conflict with
>> commit 95b681485563 ("igc: Avoid transmit queue timeout for XDP"),
>> but really easy to solve.
>> 
>> Anyway, good catch:
>> 
>> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> I am sorry, that was bad timing. I prepared the initial patch on Friday and overlooked the merge.
> Shall I send a v3 or will someone else take care of the conflict
> resolution?

I think it's easier if you send a v3.


Cheers,
-- 
Vinicius
