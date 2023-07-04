Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C874754B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGDP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjGDP1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DABA1A4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F016128B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 15:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBFCC433C8;
        Tue,  4 Jul 2023 15:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688484470;
        bh=qUdWowWIkYFtnfXdxb32NHn0VbYNimiXJawRxIFxkSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s664yN5VLDy2qSr5Y2mQ2AD6gEkyBn/S9mB+USWiSd7bDDNWQs/9+6rU2ZuojzA2n
         knYf6brty31tilj4ogSVkCGlUnnbN3brUk4Y8qmosc0w6A+hqmxw+wuVQEr3t03xfz
         L7jp2GqB0JmhSDQEtkg7qWj5wI4u/qqN2WDefsmtcfhTu3x9rYx5rLJRODtL+z3lD1
         o660VJdMRmtDrIUxmhfAbvh67NXJmixBKx1MfLMpDrDS62jgdL5eamEakAPdg+7D/e
         Y2D6Y3EUiASguU06msX6SeWNzeDGYQio/nCFoUvZcwEvv/9ORgAsNifnLJ9B05MEBM
         Fzq1IYiFH7XPg==
Date:   Tue, 4 Jul 2023 17:27:45 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Hanks Chen <hanks.chen@mediatek.com>,
        Cheng-Yuh.Wu@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Message-ID: <ZKQ6ce1pbYHGVIsA@lpieralisi>
References: <20230704123436.127449-1-lpieralisi@kernel.org>
 <86ttujwxb1.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ttujwxb1.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 03:44:50PM +0100, Marc Zyngier wrote:

[...]

> > +	return !((gic_irq_in_rdist(d)) || gic_irq(d) >= 8192 ||
> > +		  cpumask_equal(irq_data_get_effective_affinity_mask(d),
> > +				cpumask_of(smp_processor_id())));
> 
> I dislike this statement for multiple reasons:
> 
> - it is written as a negation, making it harder than strictly
>   necessary to parse as it is the opposite of the comment above
> 
> - gic_irq_in_rdist() and gic_irq(d) >= 8192 are two ways of checking
>   the interrupt range -- maybe we should just do that
> 
> - cpumask_equal() is *slow* if you have more that 64 CPUs, something
>   that is increasingly common -- a better option would be to check
>   whether the current CPU is in the mask or not, which would be enough
>   as we only have a single affinity bit set
> 
> - smp_processor_id() can check for preemption, which is pointless
>   here, as we're doing things under the irq_desc raw spinlock.
> 
> I would expect something like:
> 
> 	enum gic_intid_range range = get_intid_range(d);
> 
> 	return (range == SGI_RANGE || range == ESPI_RANGE) &&
> 	       !cpumask_test_cpu(raw_smp_processor_id(),
> 				 irq_data_get_effective_affinity_mask(d));
> 

s/SGI/SPI - just noticed, for the records.

Thanks,
Lorenzo
