Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91DF728A76
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjFHVzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFHVzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9B61FE9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 14:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51E5A65130
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92874C433D2;
        Thu,  8 Jun 2023 21:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686261331;
        bh=jLLIY+6XSJEnROaCzPa2cWfvfUfImfLErJ0cuoIYyGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PY2OcR2XIqmjOkJa9pEgbQUEQtTTesBr8kBDccpp+O9oUuJZarlgUG2A/BKmmrYfZ
         a42HZQ0ESa5M2JKbDiQ40tREnJzfUk9mKKZbkyoLKHYuN2YiVBBdJmSWemmmuvzvG9
         ZNHfAwdY9gtdTLkSRfbeHkDukF87wFfCe1Aya3mPo6sfgChzHDJRxrRJ3bCb09AYTQ
         SDNsT2KXlyU1rm9xCFQ2qW9nSyS4/lz3x3oCQ6O5fcfNwrrHEPc67d/V2x2stK7m6k
         nmWyp1PDWfA7yrZzWIz+ZazhJhIFmeggvTNA3Z0q2jdXEoL6SDG32yhz4tPIoEtIZ0
         6gNggbFSCE1lQ==
Date:   Thu, 8 Jun 2023 22:55:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Mostafa Saleh <smostafa@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, tabba@google.com,
        kaleshsingh@google.com, catalin.marinas@arm.com,
        yuzenghui@huawei.com, suzuki.poulose@arm.com, james.morse@arm.com
Subject: Re: [PATCH] KVM: arm64: Use different pointer authentication keys
 for pKVM
Message-ID: <20230608215525.GA2742@willie-the-truck>
References: <20230516141531.791492-1-smostafa@google.com>
 <ZHEa+HAixbYijQTA@linux.dev>
 <ZHSJ38WATzgJF7SR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHSJ38WATzgJF7SR@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:17:51AM +0000, Mostafa Saleh wrote:
> On Fri, May 26, 2023 at 08:47:52PM +0000, Oliver Upton wrote:
> > On Tue, May 16, 2023 at 02:15:31PM +0000, Mostafa Saleh wrote:
> > > When the kernel is compiled with CONFIG_ARM64_PTR_AUTH_KERNEL, it
> > > uses Armv8.3-Pauth for return address protection for the kernel code
> > > including nvhe code in EL2.
> > > 
> > > Same keys are used in both kernel(EL1) and nvhe code(EL2), this is
> > > fine for nvhe but not when running in protected mode(pKVM) as the host
> > > can't be trusted.
> > 
> > But we trust it enough to hand pKVM a fresh set of keys before firing
> > off? I understand there is some degree of initialization required to get
> > pKVM off the ground, but I question in this case if key handoff is
> > strictly necessary.
> >
> > There are potentially other sources of random directly available at EL2,
> > such as the SMCCC TRNG ABI or FEAT_RNG. Should pKVM prefer one of these
> > random implementations and only fall back to host-provided keys if
> > absolutely necessary?
> > 
> According to my understanding, the kernel is still completely trusted at
> this point (it sets the initial page table for the hypervisor), so I
> believe it should be fine to trust it for ptrauth keys. However, I agree,
> it would be better if the hypervisor can get its own keys through
> firmware/hardware if supported. I will add this in V2.

I appreciate the sentiment, but I think we should avoid adding additional
complexity here if it adds no security benefit. If nothing else, it adds
pointless overhead, but beyond that it gives the false illusion of a
security boundary.

Prior to deprivilege, the kernel can write to the hypervisor text, modify
its stage-1 page-table and change its data values. I think the pointer
auth keys are the least of our worries if it's compromised...

Will
