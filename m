Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11C6E8E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjDTJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjDTJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:51:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 749131FD2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:51:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9C701480;
        Thu, 20 Apr 2023 02:52:09 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7A8E3F587;
        Thu, 20 Apr 2023 02:51:24 -0700 (PDT)
Date:   Thu, 20 Apr 2023 10:51:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ayan Kumar Halder <ayankuma@amd.com>, mark.rutland@arm.com,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: SMP enablement on Cortex-R52 (using PSCI ?)
Message-ID: <20230420095122.chw527nozzwkopnx@bogus>
References: <1cb7d428-c047-1485-e39d-465806f6ef0b@amd.com>
 <20230419084756.3gypfyuuezjj7tyd@bogus>
 <ee7095b4-0bab-d98e-0f7e-633672458b50@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee7095b4-0bab-d98e-0f7e-633672458b50@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 06:50:26PM +0100, Robin Murphy wrote:
> On 19/04/2023 9:47 am, Sudeep Holla wrote:
> > 
> > I will check with the authors if EL3 is a must for PSCI implementation, but
> > IMO it must not be though every aspects described in the spec may not apply
> > when used across EL2/EL1 boundaries especially when EL3 is not implemented
> > in the hardware.
> 
> Xen could provide PSCI to EL1 guests using the HVC conduit. However if EL2
> is the highest implemented EL, then Xen is the most privileged software in
> the system - it would have to own the EL2 exception vectors, and it would
> have to own the low-level CPU bringup code. At that point it just wouldn't
> make much sense to HVC *itself* via the PSCI protocol when it could simply
> call the function directly.
>

Agreed, I was focussing to much just on EL2/EL1. I don't know details on how
power management responsibilities are split between Dom0 and hypervisor, but
I am more interested in understanding how cpuidle/suspend would be structured
with the direct function calls.

-- 
Regards,
Sudeep
