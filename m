Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501B56E759E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjDSIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjDSIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:48:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 913691A4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:48:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F13A6143D;
        Wed, 19 Apr 2023 01:48:43 -0700 (PDT)
Received: from bogus (unknown [10.57.57.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 031EB3F587;
        Wed, 19 Apr 2023 01:47:58 -0700 (PDT)
Date:   Wed, 19 Apr 2023 09:47:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ayan Kumar Halder <ayankuma@amd.com>
Cc:     mark.rutland@arm.com, lpieralisi@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: SMP enablement on Cortex-R52 (using PSCI ?)
Message-ID: <20230419084756.3gypfyuuezjj7tyd@bogus>
References: <1cb7d428-c047-1485-e39d-465806f6ef0b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb7d428-c047-1485-e39d-465806f6ef0b@amd.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

On Fri, Apr 14, 2023 at 12:24:38PM +0100, Ayan Kumar Halder wrote:
> Hi PSCI developers,
> 
> We have a SoC where there are 4 Cortex-R52 which is distributed in two
> clusters. So we have 2 Cortex-R52 in one cluster and 2 Cortex-R52 in another
> cluster.
> 
> We wish to enable SMP on the 2 R52 within a cluster with Xen hypervisor (EL2
> software) running on them.
> 
> We are trying to explore if we can use PSCI for booting the secondary cores.
> 
> Refer Cortex-R52 TRM
> (https://developer.arm.com/documentation/100026/0101/?lang=en ), it
> specifies the following :-
> 
> Page 24 - Section 1.4.1
> 
> "Support for Exception levels, EL0, EL1, and EL2."
> 
> Page 30 - Section 2.1.6
> 
> "The Cortex-R52 processor does not implement TrustZone® technology. It does
> not support the ability to distinguish between secure and non-secure
> physical memories."
> 
> Thus, there is no EL3 and secure world in Cortex-R52. It implements
> AArch32-V8R architecture.
>

KVM hypervisor use PSCI to bring up secondaries in the VMs. So I am sure we
must be able to use the interface on Cortex-R52 without EL3.

> 
> Refer PSCI design document,
> https://developer.arm.com/documentation/den0022/e/?lang=en
> 
> Page 18 -
> "The PSCI specification focuses on the interface between Security states for
> power management. It provides a method for issuing power management
> requests. To deal with the requests, the PPF must include a PSCI
> implementation. A PSCI implementation might require communication between
> the PPF and a Trusted OS or SP."
> 
> Page 17 - Privileged Platform Firmware (PPF)
> 
> "For Armv7 systems, or Armv8 systems using AArch32 at EL3, PPF executes in
> EL3."
> 
> From the above two statements, I infer that PSCI requires a PPF (running at
> EL3) and a Trusted OS (running at secure EL2). If this is correct, then R52 
> cannot support PSCI. Please correct me if I am mistaken.
> 
> I wish to know how do we wake up the secondary core if PSCI is not
> supported.
>

I will check with the authors if EL3 is a must for PSCI implementation, but
IMO it must not be though every aspects described in the spec may not apply
when used across EL2/EL1 boundaries especially when EL3 is not implemented
in the hardware.

-- 
Regards,
Sudeep
