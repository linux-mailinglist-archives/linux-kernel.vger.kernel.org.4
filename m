Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2FF5FEFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJNOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiJNOPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:15:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3604DB5E;
        Fri, 14 Oct 2022 07:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1573B82356;
        Fri, 14 Oct 2022 14:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CFAC433C1;
        Fri, 14 Oct 2022 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665756908;
        bh=kceQmgdPFaemBr6NpR+rvC6uWn6wwb6RWTB1Ad7mZ2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1YyY4ykZbiYIPSKnchJGYFQEe9j4uk+R6yK3URJyLfLiMOJYpTdEKSJep0AHv5Bd
         WuC6mrzH3Ai0PD06U48B1Zg8sjUPvKdv64v+oA4exhYEv6KJ8HsiaDufBlLGbzHDw+
         4YYpbioQ7VryjzzVIRwrTYVcx99+Ii453ZNTVVWok+yfiz8gKTWW1vdXgVKX33y8f1
         Qu0rQYRwwbhjTarlhCtbGwF9VtHww81Q7g9lSMPdGXVY8ioDvf+aRtSpZUYugeXLaE
         2TUNTNgLqTqN+zWaVEipg8SSHuhVrMaDnnNg4tlEvqWBKodKA+SdLnmIzhAU/EtT3W
         L2uxhSFbb7a/w==
Date:   Fri, 14 Oct 2022 16:15:01 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>, rafael@kernel.org,
        lenb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Message-ID: <Y0lu5Vqs8pVeAfwR@lpieralisi>
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
 <20221014105938.fyy6jns5fsu5xd7q@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014105938.fyy6jns5fsu5xd7q@bogus>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please Besar update my email address according to MAINTAINERS - I missed
this thread]

On Fri, Oct 14, 2022 at 11:59:38AM +0100, Sudeep Holla wrote:
> Hi Besar,
> 
> On Wed, Sep 28, 2022 at 07:28:34PM -0500, Besar Wicaksono wrote:
> > ARM Performance Monitoring Unit Table describes the properties of PMU
> > support in ARM-based system. The APMT table contains a list of nodes,
> > each represents a PMU in the system that conforms to ARM CoreSight PMU
> > architecture. The properties of each node include information required
> > to access the PMU (e.g. MMIO base address, interrupt number) and also
> > identification. For more detailed information, please refer to the
> > specification below:
> >  * APMT: https://developer.arm.com/documentation/den0117/latest
> >  * ARM Coresight PMU:
> >         https://developer.arm.com/documentation/ihi0091/latest
> > 
> > The initial support adds the detection of APMT table and generic
> > infrastructure to create platform devices for ARM CoreSight PMUs.
> > Similar to IORT the root pointer of APMT is preserved during runtime
> > and each PMU platform device is given a pointer to the corresponding
> > APMT node.
> > 
> 
> This looks good to me know.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Hi Lorenzo,
> 
> Not sure if there are any other arm specific ACPI changes in the queue
> for v6.2. Can you please add this too ?

We should just ask Catalin/Will to pick it up for the next kernel cycle,
if there is no need to repost we can just remind them in a couple
of weeks.

This also requires Rafael's review - at least to acknowledge the
change.

Thanks,
Lorenzo
