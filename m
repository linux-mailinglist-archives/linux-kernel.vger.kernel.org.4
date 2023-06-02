Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1B7203B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjFBNuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFBNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF370136
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C27B6509F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBB5C433EF;
        Fri,  2 Jun 2023 13:49:53 +0000 (UTC)
Date:   Fri, 2 Jun 2023 14:49:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] KVM: arm64: initialize HCRX_EL2
Message-ID: <ZHnzfhi2KCMPucQJ@arm.com>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
 <20230509142235.3284028-2-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509142235.3284028-2-kristina.martsenko@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 03:22:25PM +0100, Kristina Martsenko wrote:
> ARMv8.7/9.2 adds a new hypervisor configuration register HCRX_EL2.
> Initialize the register to a safe value (all fields 0), to be robust
> against firmware that has not initialized it. This is also needed to
> ensure that the register is reinitialized after a kexec by a future
> kernel.
> 
> In addition, move SMPME setup over to the new flags, as it would
> otherwise get overridden. It is safe to set the bit even if SME is not
> (uniformly) supported, as it will write to a RES0 bit (having no
> effect), and SME will be disabled by the cpufeature framework.
> (Similar to how e.g. the API bit is handled in HCR_HOST_NVHE_FLAGS.)

This looks fine to me but I may have lost track of the VHE/nVHE code
initialisation paths.

Marc/Oliver, are you ok with this patch (or this series in general)? I'd
like to merge it through the arm64 tree.

Thanks.

-- 
Catalin
