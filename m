Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA272CF0B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbjFLTNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjFLTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:13:48 -0400
Received: from out-2.mta1.migadu.com (out-2.mta1.migadu.com [IPv6:2001:41d0:203:375::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724AC0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:13:46 -0700 (PDT)
Date:   Mon, 12 Jun 2023 21:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686597223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HxGQvsB7fcRIz73MLbhBAve1ENUGJm6b0AdpqTHIpqE=;
        b=BmixyGpow9WXKsKoIICxCywoB6nARvJSBuFSil9BVrJYhdu91Q1xEeah/tdb+1jAUSeLgA
        DJoR3p3DSTGXOA+gOefFf1+2ulTBBQGN6Q17ici9wHaPMcpuH6yrGJ1g1JgJUfc7Lz4s/l
        2oaw+m2SXoKHlR5EDs3BwZxhcmhGBvM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mostafa Saleh <smostafa@google.com>
Cc:     Will Deacon <will@kernel.org>, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, tabba@google.com,
        kaleshsingh@google.com, catalin.marinas@arm.com,
        yuzenghui@huawei.com, suzuki.poulose@arm.com, james.morse@arm.com
Subject: Re: [PATCH] KVM: arm64: Use different pointer authentication keys
 for pKVM
Message-ID: <ZIduZcSpeA5xw3Yn@linux.dev>
References: <20230516141531.791492-1-smostafa@google.com>
 <ZHEa+HAixbYijQTA@linux.dev>
 <ZHSJ38WATzgJF7SR@google.com>
 <20230608215525.GA2742@willie-the-truck>
 <ZIbjULC2p5aTZu8w@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIbjULC2p5aTZu8w@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mostafa,

Thank you for bumping this, I didn't see Will's reply.

On Mon, Jun 12, 2023 at 09:20:16AM +0000, Mostafa Saleh wrote:
> On Thu, Jun 08, 2023 at 10:55:26PM +0100, Will Deacon wrote:
> > I appreciate the sentiment, but I think we should avoid adding additional
> > complexity here if it adds no security benefit. If nothing else, it adds
> > pointless overhead, but beyond that it gives the false illusion of a
> > security boundary.
> > 
> > Prior to deprivilege, the kernel can write to the hypervisor text, modify
> > its stage-1 page-table and change its data values. I think the pointer
> > auth keys are the least of our worries if it's compromised...

Ack -- well aware of the other issues there :) My whining as it relates
to security was more focused at the changelog than the diff of the
patch.

My tilt in terms of the functionality is more aimed at limiting the
interactions between pKVM and the host before it deprivilege. Longer
term, it'd be interesting to have pKVM capable of bootstrapping itself,
such that it can possibly be used in other contexts. So, when I saw the
patch I had questioned whether or not the dependency was strictly
necessary.

No reason to boil the ocean as part of this otherwise isolated change.

Tangent: Will you folks need random in EL2 at runtime?

> Thanks a lot Will for explaining this.
> 
> Oliver, what do you think for V2, about it including FEAT_RNG/TRNG in EL2?

The patch itself looks good to me. May I suggest something along these
lines for the changelog? I can do it myself to avoid the need for a v2:

"""
When the use of pointer authentication is enabled in the kernel it
applies to both the kernel itself as well as KVM's nVHE hypervisor. The
same keys are used for both the kernel and the nVHE hypervisor, which is
less than desirable for pKVM as the host is not trusted at runtime.

Naturally, the fix is to use a different set of keys for the hypervisor
when running in protected mode. Have the host generate a new set of keys
for the hypervisor before deprivileging the kernel. While there might be
other sources of random directly available at EL2, this keeps the
implementation simple, and the host is trusted anyways until it is
deprivileged.

Since the host and hypervisor no longer share a set of pointer
authentication keys, start context switching them on the host entry/exit
path exactly as we do for guest entry/exit. There is no need to handle
CPU migration as the nVHE code is not migratable in the first place.
"""

--
Thanks,
Oliver
