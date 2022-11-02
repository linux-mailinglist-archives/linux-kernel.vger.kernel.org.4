Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9677615FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKBJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961210E2;
        Wed,  2 Nov 2022 02:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3D9618C4;
        Wed,  2 Nov 2022 09:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6ABC433C1;
        Wed,  2 Nov 2022 09:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667381471;
        bh=Gg/fPN5aJjIxWUU4f2lqbCwhG9+mABQUoLO1LEyugvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VA9kqUgFzHW7TNNVFU0PUVwRSgugIQCwLDDSfTZD2GL2XxifBiQZCkHerKlJKxwKk
         36kvIAXAXK1hOwjS1jaxYUKTxJQk7ngM4NiLMhq1NdjL2UMrAuQKeHvbnMLgppjteZ
         AXvP/1y6CiiQv46HYtuDYqLXjU879ewH68iKsMWoFMZ+gnUcC2JQlDVZvfLS46/tKJ
         0qtz+1tbUIw+rdzWFs19fqtGsOG/Rj/IR/O3Q3dHFyXpq0bVfeVaC66fWnbxCY4eHG
         Q8fw64tP8w/G1HbUSZe3sn2sb7Q4kVUNmPgEKIZqQcazF5PPB2BFui3kIZUq7FGkS0
         VAxKq7ffmvGrQ==
Date:   Wed, 2 Nov 2022 10:31:03 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>, rafael@kernel.org,
        lenb@kernel.org, guohanjun@huawei.com, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Message-ID: <Y2I411GOEkiqlCBg@lpieralisi>
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
 <20221014105938.fyy6jns5fsu5xd7q@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014105938.fyy6jns5fsu5xd7q@bogus>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Hi Catalin, Will,

would you mind picking this patch up for v6.2 please ?

Thank you very much.

Lorenzo
