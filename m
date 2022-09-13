Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3575B6C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiIML0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiIML0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:26:17 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573D140D5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:26:13 -0700 (PDT)
Date:   Tue, 13 Sep 2022 12:26:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663068372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WnJ7iBg3M95g4UxL74wu6Oc05BoA+yNNygAHJybcFs8=;
        b=Fm3VFtCCfQqW9sjPYoscFhTrIGnCxUXDH/ciu+YRcKAXP7uW5OtpmLVRqTb/DsL4JnzQu2
        FR+O/PFlZnJzNslXx0gRpwgtDE2nlnGZKtlh2CZYyCjrepwroB1AvKZM7y2O5TgGxIJJdY
        Jmi7h0az1ofKpcVpjFCFraMCyBYnJOQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Kunkun Jiang <jiangkunkun@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: arch_timer: Fix the lack of set_next_event* for
 workaround of Cortex-A73 erratum 858921
Message-ID: <YyBo0SPalTLsqYbS@google.com>
References: <20220913104723.332-1-jiangkunkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913104723.332-1-jiangkunkun@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 06:47:23PM +0800, Kunkun Jiang wrote:
> The patch a38b71b0833e moves the programming of the timers from

Please check your patch with scripts/checkpatch.pl next time.
Use this pattern when referring to a commit in the changelog:

commit a38b71b0833e ("clocksource/drivers/arm_arch_timer: Move
system register timer programming over to CVAL") moved the
programming...

> the countdown timer (TVAL) over to the comparator (CVAL). This
> makes it necessary to read the counter when setting next event.
> However, the workaround of Cortex-A73 erratum 858921 does not
> set the corresponding set_next_event_phys and set_next_event_virt.
> This patch fixes it.

Avoid referring to 'this patch', and just state imperatively what the
change does, perhaps:

Add the appropriate hooks to apply the erratum mitigation when
programming the next timer event.

Thanks for catching this!

--
Best,
Oliver
