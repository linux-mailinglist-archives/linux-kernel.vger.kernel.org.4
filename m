Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54160619B30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiKDPPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDPPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:15:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCC5710D9;
        Fri,  4 Nov 2022 08:15:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACD4F1FB;
        Fri,  4 Nov 2022 08:15:40 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E331F3F703;
        Fri,  4 Nov 2022 08:15:32 -0700 (PDT)
Date:   Fri, 4 Nov 2022 15:15:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Robbie King <robbiek@xsightlabs.com>
Cc:     "lihuisong (C)" <lihuisong@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        huangdaode@huawei.com, tanxiaofei@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
Message-ID: <20221104151530.44sms3fnarqnvvsl@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221027155323.7xmpjfrh7qmil6o3@bogus>
 <f0c408a6-cd94-4963-d4d7-e7d08b6150be@huawei.com>
 <20221031104036.bv6a7i6hxrmtpj23@bogus>
 <925f360d-e6b3-6004-de22-f39eaa86a750@huawei.com>
 <d0b178d3-a036-399f-fb0c-bb7f8c52995c@xsightlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b178d3-a036-399f-fb0c-bb7f8c52995c@xsightlabs.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:04:22AM -0400, Robbie King wrote:
> Hello Huisong, your raising of the shared interrupt issue is very timely, I
> am working to implement "Extended PCC subspaces (types 3 and 4)" using PCC
> on the ARM RDN2 reference platform as a proof of concept, and encountered
> this issue as well.  FWIW, I am currently testing using Sudeep's patch with
> the "chan_in_use" flag removed, and so far have not encountered any issues.
>

Interesting, do you mean the patch I post in this thread but without the
whole chan_in_use flag ?

> I think the RDN2 may provide an example of a write only interrupt
> acknowledge mechanism mentioned by Sudeep.
>

Yes.

> The RDN2 reference design uses the MHUv2 IP for the doorbell mechanism.  If
> my implementation is correct (and it quite possibly is not), acknowledging
> the DB interrupt from the platform is accomplished by writing a 1 to the
> appropriate bit in the receiver channel window CH_CLR register, which is
> documented as:
>
>   Channel flag clear.
>   Write 0b1 to a bit clears the corresponding bit in the CH_ST and CH_ST_MSK.
>   Writing 0b0 has no effect.
>   Each bit always reads as 0b0.
>

Correct, on this MHUv[1-2], it is write only register and it reads zero.
So basically you will ignore the interrupt if we apply the logic Huisong
proposed initially.

> in the "Arm Corstone SSE-700 Subsystem Technical Reference Manual".
>
> Apologies if I am off in the weeds here as I have only been working with
> PCC/SCMI for a very short period of time.

Good to know info :).

-- 
Regards,
Sudeep
