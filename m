Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA50A73308A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjFPL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbjFPL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7AE4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92E33626D0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D832FC433C8;
        Fri, 16 Jun 2023 11:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686916624;
        bh=V0DRlFK3AQHSP+IaBlA3ARM+1W62ukpytdibQSonB2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rDKWC8U/o+bXGYc3MVuzAecbQgCr1fYHSKD0YOnGoa3pglmUWNCBxsIiZWUfuZE/I
         300rlTPfAGuH0O/0+xPpJuuXw/Tef07d29GpVv5AnsEAyCRV4Z/YavHjFaltV/YTv0
         mTzeoiveyYpNSGKrPUEBc67mTLtvm9ot4aP7yHu89WejplBRNYqrA5aNUJF7dUOT5l
         obuAUuRMDEHZniFVk1lb6znNTsnqchyzRBZ+Ieqo5PPwWf8MPCKZ6oGf3pvvCX85Qo
         F1irHTyLPQLPiDjP0jMhdKEUR0qMPdAziYp/oZtDlJzmwaRs7MlKjObhuMCrO8a0le
         RUVXwxAkdCOGQ==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qA84c-005sXh-M3;
        Fri, 16 Jun 2023 12:57:02 +0100
MIME-Version: 1.0
Date:   Fri, 16 Jun 2023 12:57:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Reiji Watanabe <reijiw@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] perf/core: Drop __weak attribute from
 arch_perf_update_userpage() prototype
In-Reply-To: <20230616114831.3186980-1-maz@kernel.org>
References: <20230616114831.3186980-1-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c0749f348a362ce54e466b7ce02c06a9@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, reijiw@google.com, mark.rutland@arm.com, peterz@infradead.org, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-16 12:48, Marc Zyngier wrote:
> Reiji reports that the arm64 implementation of 
> arch_perf_update_userpage()
> is now ignored and replaced by the dummy stub in core code.
> This seems to happen since the PMUv3 driver was moved to driver/perf.
> 
> As it turns out, dropping the __weak attribute from the *prototype*
> of the function solves the problem. You're right, this doesn't seem
> to make much sense. And yet... It appears that both symbols get
> flagged as weak, and that the first one to appear in the link order
> wins:
> 
> $ nm drivers/perf/arm_pmuv3.o|grep arch_perf_update_userpage
> 0000000000001db0 W arch_perf_update_userpage
> 
> Dropping the attribute from the prototype restores the expected
> behaviour, and arm64 is able to enjoy arch_perf_update_userpage()
> again.
> 
> Fixes: 7755cec63ade ("arm64: perf: Move PMUv3 driver to drivers/perf")
> Fixes: f1ec3a517b43 ("kernel/events: Add a missing prototype for
> arch_perf_update_userpage()")
> Reported-by: Reiji Watanabe <reijiw@google.com>
> Tested-by: Reiji Watanabe <reijiw@google.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>

And of course I forgot to pass --notes to git-send-email...

     v2: Added fixes tags, both for the commit that introduce the 
breakage
         on arm64, and for the commit introducing the offending 
prototype.
         I did not Cc stable on purpose, as nothing appears to be broken
         in other architectures.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
