Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6264C18F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiLNA7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiLNA71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:59:27 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE26521894
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:59:24 -0800 (PST)
Date:   Wed, 14 Dec 2022 00:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670979562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbKxRIPYAhQPs9JSjFRsJUAAmMT3SmynUTp6Kob5aSA=;
        b=BJmn8mmJMMe4GC4cqN0JMmdIVim+izlQOZFM7XZq1llY0jN+dMVlj1H4EP4eIBEmXp8lYK
        MXbZuomcvx54TXdefIJEo1RVkbTUFi+HJtKiWnQoFfOhiWeNG5+ZIYpfylkQgVG/nu5OMS
        hIMZmFyTmHWQIDkc9Qi42jOvL1qPC/g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 0/3] KVM: arm64: Normalize cache configuration
Message-ID: <Y5kf5XDUb5En00BZ@google.com>
References: <20221211051700.275761-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211051700.275761-1-akihiko.odaki@daynix.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akihiko,

On Sun, Dec 11, 2022 at 02:16:57PM +0900, Akihiko Odaki wrote:
> Before this change, the cache configuration of the physical CPU was
> exposed to vcpus. This is problematic because the cache configuration a
> vcpu sees varies when it migrates between vcpus with different cache
> configurations.
> 
> Fabricate cache configuration from arm64_ftr_reg_ctrel0.sys_val, which
> holds the CTR_EL0 value the userspace sees regardless of which physical
> CPU it resides on.
> 
> HCR_TID2 is now always set as it is troublesome to detect the difference
> of cache configurations among physical CPUs.
> 
> CSSELR_EL1 is now held in the memory instead of the corresponding
> phyisccal register as the fabricated cache configuration may have a
> cache level which does not exist in the physical CPU, and setting the
> physical CSSELR_EL1 for the level results in an UNKNOWN behavior.
> 
> CLIDR_EL1 and CCSIDR_EL1 are now writable from the userspace so that
> the VMM can restore the values saved with the old kernel.
> 
> Akihiko Odaki (3):
>   arm64/sysreg: Add CCSIDR2_EL1
>   arm64/cache: Move CLIDR macro definitions
>   KVM: arm64: Normalize cache configuration

Next time you do a respin can you please bump the version number? I.e.
the next version should be v3.

Additionally, it is tremendously helpful to reviewers if you can provide
(1) a summary of what has changed in the current revision and (2) a
lore.kernel.org link to the last series you mailed out.

--
Thanks,
Oliver
