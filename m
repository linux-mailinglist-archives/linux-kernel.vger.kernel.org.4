Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47165B8613
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiINKSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiINKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:18:20 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E577EB0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:18:18 -0700 (PDT)
Date:   Wed, 14 Sep 2022 11:18:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663150696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nMKA0IeYCnijNLDCCrrWwYaka5FqI4PW0qFMb2bkwkg=;
        b=seMDWTaHhuJbmBcNRlevf6TUx1KEhYjBVkFUP9tYpVAw6j10WSJOu8ERQgG70mMOP2m8sT
        2NhGVmGnAR1NxkuGr/q/4era68gl8t5mbw8Fq9x1xPbye2aKVXX7DEWyEGdoe76e+zroZm
        3uiSfe12XACZnXJzUm76u+K3U31ajo0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Kunkun Jiang <jiangkunkun@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clocksource/drivers/arm_arch_timer: Fix handling of
 ARM erratum 858921
Message-ID: <YyGqZmO9vibRmd8n@google.com>
References: <20220914061424.1260-1-jiangkunkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914061424.1260-1-jiangkunkun@huawei.com>
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

On Wed, Sep 14, 2022 at 02:14:24PM +0800, Kunkun Jiang wrote:
> The commit a38b71b0833e ("clocksource/drivers/arm_arch_timer:
> Move system register timer programming over to CVAL") moves the
> programming of the timers from the countdown timer (TVAL) over
> to the comparator (CVAL). This makes it necessary to read the
> counter when programming next event. However, the workaround of
> Cortex-A73 erratum 858921 does not set the corresponding
> set_next_event_phys and set_next_event_virt.
> 
> Add the appropriate hooks to apply the erratum mitigation when
> programming the next timer event.
> 
> Fixes: a38b71b0833e ("clocksource/drivers/arm_arch_timer: Move system register timer programming over to CVAL")
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Acked-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

--
Thanks,
Oliver
