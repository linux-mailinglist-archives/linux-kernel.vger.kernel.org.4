Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E891F7420C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjF2HHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjF2HHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:07:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D52116;
        Thu, 29 Jun 2023 00:07:43 -0700 (PDT)
Message-ID: <b64dc5c7-600c-66db-d125-2d747a21c1d8@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688022461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYKNMkC/e+EOiXeiis2Yv6NPhSLq1jyIWmFHBR4MTyo=;
        b=rCwVstUWg5fN/FdCzmGYqSASXpxhRHT+gCl5DHf9/rhTbngXszmfvJwWfcvL1zrCCc2Ejk
        ZwmVkxUh3PJC0ESM7DWY7IKrcAclzBFMp50cKHsQDF7J53hd4l+fa37ySK71rRuWtBYz2f
        avwejKEusPI5faNbTQN8FqCTdDO6Jm31WmFhG1+7KJeGQxt6oZJPTo12S6KZeJz71giBB/
        eEvAMIi+2vvxFNGEfPlx8Bi0vveNvvE9IQHwp7SZwPnggLf/ahmrY9chZIGFOfWWs5EBYQ
        q6DiQoOribKDkJKtZbf46MAT+c3QYrsWHRByk6ijYsC0irH+CbiRKiD4nWUDqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688022461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYKNMkC/e+EOiXeiis2Yv6NPhSLq1jyIWmFHBR4MTyo=;
        b=+Ot956sT7XnMLaiu4aDJD905nJStIalGNQcLZn7ixdjhgopMiyA1f+LMH57VaK5VGYSaBT
        sXtukp/7Sn7gsSAw==
Date:   Thu, 29 Jun 2023 09:07:40 +0200
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH net v2] igc: Prevent garbled TX queue
 with XDP ZEROCOPY
Content-Language: en-US
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
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
References: <20230628091148.62256-1-florian.kauer@linutronix.de>
 <87a5wjqnjk.fsf@intel.com>
From:   Florian Kauer <florian.kauer@linutronix.de>
In-Reply-To: <87a5wjqnjk.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinicius,

On 28.06.23 23:34, Vinicius Costa Gomes wrote:
> Florian Kauer <florian.kauer@linutronix.de> writes:
> 
>> In normal operation, each populated queue item has
>> next_to_watch pointing to the last TX desc of the packet,
>> while each cleaned item has it set to 0. In particular,
>> next_to_use that points to the next (necessarily clean)
>> item to use has next_to_watch set to 0.
>>
>> When the TX queue is used both by an application using
>> AF_XDP with ZEROCOPY as well as a second non-XDP application
>> generating high traffic, the queue pointers can get in
>> an invalid state where next_to_use points to an item
>> where next_to_watch is NOT set to 0.
>>
>> However, the implementation assumes at several places
>> that this is never the case, so if it does hold,
>> bad things happen. In particular, within the loop inside
>> of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
>> Finally, this prevents any further transmission via
>> this queue and it never gets unblocked or signaled.
>> Secondly, if the queue is in this garbled state,
>> the inner loop of igc_clean_tx_ring() will never terminate,
>> completely hogging a CPU core.
>>
>> The reason is that igc_xdp_xmit_zc() reads next_to_use
>> before acquiring the lock, and writing it back
>> (potentially unmodified) later. If it got modified
>> before locking, the outdated next_to_use is written
>> pointing to an item that was already used elsewhere
>> (and thus next_to_watch got written).
>>
>> Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
>> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>> Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
> 
> This patch doesn't directly apply because there's a small conflict with
> commit 95b681485563 ("igc: Avoid transmit queue timeout for XDP"),
> but really easy to solve.
> 
> Anyway, good catch:
> 
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

I am sorry, that was bad timing. I prepared the initial patch on Friday and overlooked the merge.
Shall I send a v3 or will someone else take care of the conflict resolution?

Greetings,
Florian
