Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB41B722B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjFEPml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjFEPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:42:26 -0400
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [IPv6:2001:41d0:203:375::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E941A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:42:03 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:41:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685979676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GoZGAOTBvlr1nlPErXnetSaPgiXMcLx2bMeCqDLA1dk=;
        b=PivUa3rReYTnWwK9qzsAl7TVQSXztMg4Tj2jSXkRklNXzzHrH9eEHLzBq1b1cu/7VjtJAQ
        r3iniQ+ra6KyqjFwT2g0zigWYeRj+dReKT6T78yu35CWbJtDe0fLF7Qt64ZoPF9/0vbLKn
        ibqWLX433iGoUtvLnqtuA/o+6gp4rm8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] KVM: arm64: initialize HCRX_EL2
Message-ID: <ZH4CFmwo+BBPMWiY@linux.dev>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
 <20230509142235.3284028-2-kristina.martsenko@arm.com>
 <ZHnzfhi2KCMPucQJ@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHnzfhi2KCMPucQJ@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 02:49:50PM +0100, Catalin Marinas wrote:
> On Tue, May 09, 2023 at 03:22:25PM +0100, Kristina Martsenko wrote:
> > ARMv8.7/9.2 adds a new hypervisor configuration register HCRX_EL2.
> > Initialize the register to a safe value (all fields 0), to be robust
> > against firmware that has not initialized it. This is also needed to
> > ensure that the register is reinitialized after a kexec by a future
> > kernel.
> > 
> > In addition, move SMPME setup over to the new flags, as it would
> > otherwise get overridden. It is safe to set the bit even if SME is not
> > (uniformly) supported, as it will write to a RES0 bit (having no
> > effect), and SME will be disabled by the cpufeature framework.
> > (Similar to how e.g. the API bit is handled in HCR_HOST_NVHE_FLAGS.)
> 
> This looks fine to me but I may have lost track of the VHE/nVHE code
> initialisation paths.
> 
> Marc/Oliver, are you ok with this patch (or this series in general)? I'd
> like to merge it through the arm64 tree.

Acked-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver
