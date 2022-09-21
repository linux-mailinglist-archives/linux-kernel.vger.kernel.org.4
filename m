Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153F75C00C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiIUPIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIUPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:08:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010501403C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8951CCE1CB6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BB7C433B5;
        Wed, 21 Sep 2022 15:08:23 +0000 (UTC)
Date:   Wed, 21 Sep 2022 16:08:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/1] arm64: defconfig: Add Coresight as module
Message-ID: <Yyso42iP40niLTxO@arm.com>
References: <20220921140535.152627-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921140535.152627-1-james.clark@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 03:05:34PM +0100, James Clark wrote:
> As suggested by Catalin here's the change to add Coresight to defconfig.
> 
> Unfortunately I don't think we should add CONFIG_CORESIGHT_SOURCE_ETM4X
> which builds a few files until [1] is merged because of the overhead
> of CONFIG_PID_IN_CONTEXTIDR.
> 
> [1]: https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/T/

I thought the overhead wasn't the problem, it's mostly negligible. We
can probably save a few more cycles on the __switch_to() path by
replacing several isb()s in those functions with a single one just
before cpu_switch_to().

IIRC the issue is that unless a process runs in the root pid namespace,
the actual pid written to contextidr is meaningless.

Now that you reminded me of that thread, I see three options (sorry, not
entirely related to the defconfig updates):

1. Remove CONFIG_PID_IN_CONTEXTIDR and corresponding code completely,
   find other events to correlate the task with the trace.

2. Always on CONFIG_PID_IN_CONTEXTIDR (we might as well remove the
   Kconfig entry). This would write the root pid namespace value
   (task_pid_nr()).

3. Similar to (2) but instead write task_pid_nr_ns(). An alternative
   here is to write -1 if the task is not in the root pid namespace.

Strong preference for (1).

-- 
Catalin
