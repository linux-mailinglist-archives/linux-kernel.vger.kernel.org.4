Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680736D8990
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjDEVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDEVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2071FD2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1589664141
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 21:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27424C433EF;
        Wed,  5 Apr 2023 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680730252;
        bh=DoAA4QeuAcXT2sNQcBM6cZkLexrVga6BuN+zV8dHNJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txieKtMxOmvkixgR3K/pMzlS4f6OUzElwKipWSe0reJL0hvSHARpEUSy35KfqyiSM
         SoLiWPe+PP30Xd/vQb+qZyemssTx27ncs8N7+48TZHcm5JKNtIP8OoULn85pD2aC0B
         7Wz5XwlXgrF6B+qRYx7r7zhC2PMe3K00kqI1th08MMaVnwBWG3oinEUfajbEdjG6wH
         Gr0qVh5nY6houMXG9KFGSClyYa9KJm0aAmuJATP5GXJzvO1bRWHzyBSFqkKJ5FSy1n
         ipRrHkskw730rASTOsTdG3ZQ9ofGrNMtrv6YQB59SCN23sXRN0q/ozo9kng9QOOI3R
         mLlYd3FPY6egA==
Date:   Wed, 5 Apr 2023 15:30:49 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Nate Thornton <nate.thornton@samsung.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: nvme: Incorrect Async Event Trace string
Message-ID: <ZC3oiQXd0EgtkD/U@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230405204637uscas1p2fb449663414a31f130fd5b02caac3340@uscas1p2.samsung.com>
 <6f4a7ffad0c7495391116b8b983882b3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4a7ffad0c7495391116b8b983882b3@samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 08:46:36PM +0000, Nate Thornton wrote:
> Hi Keith,
> 
> With NVMe Asynchronous Event kernel debug tracing, there are duplicate entries in the symbolic table that cause the decoded event string to be incorrect for certain events. This is easily observed by enabling SMART / Health events, then lowering the temperature threshold so the drive will generate an event. I observed the issue on the 5.15 kernel and the trace macro remains the same in 6.x
> 
> I am using a Samsung PM173X drive in my testing, but any drive that supports asynchronous events and temperature readings should suffice.
> 
> e.g.
> # Enable NVMe Async Event debug tracing
> $ echo 1 > /sys/kernel/debug/tracing/events/nvme/nvme_async_event/enable
> 
> # Enable Asynchronous Event Notification for SMART / Critical Health Warnings (bits 0:7)
> $ nvme set-feature /dev/nvme0 --feature-id=0xB --value=0xF
> set-feature:0x0b (Async Event Configuration), value:0x0000000f, cdw12:00000000, save:0
> 
> # Reduce Temperature Threshold to 64 Kelvin, thus triggering an event (unless it's cold)
> $ nvme set-feature /dev/nvme0 --feature-id=0x4 --value=0x40
> 
> # Observe that the Asynchronous Event Notification (AEN) is 0x000001. This corresponds to a SMART / Health status
> # but is labeled as NVME_AER_NOTICE_FW_ACT_STARTING
> $ cat /sys/kernel/debug/tracing/trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 1/1   #P:20
> #
> #                                _-----=> irqs-off
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>           <idle>-0       [017] d.h..   745.082580: nvme_async_event: nvme0: NVME_AEN=0x000001 [NVME_AER_NOTICE_FW_ACT_STARTING]
> 
> 
> 
> The AER name duplications are in drivers/nvme/host/trace.h where it tries to combine the Asynchronous Event Type, and types specific to the Notice event type. In my case, I should be seeing NVME_AER_SMART.
> 		aer_name(NVME_AER_NOTICE_NS_CHANGED),		// 0
> 		aer_name(NVME_AER_NOTICE_ANA),			// 3
> 		aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),	// 1
> 		aer_name(NVME_AER_NOTICE_DISC_CHANGED),		// 0xF0
> 		aer_name(NVME_AER_ERROR),				// 0
> 		aer_name(NVME_AER_SMART),				// 1
> 		aer_name(NVME_AER_CSS),					// 6
> 		aer_name(NVME_AER_VS))					// 7
> 	
> 
> Referring to NVM Express Base Specification, Revision 2.0c, 5.2.1 Command Completion: The Event Type is in the lower bits 0:3 of Dword 0. The Event Type then describes specific Event Information in bits 8:15. (Note that two Event Types are missing: NVME_AER_NOTICE (2) and NVME_AER_IMMEDIATE (3). The other values, 4 and 5, are marked as Reserved in the spec. For completeness, we may want to add the missing definitions.)
> 
> In nvme_handle_aen_notice it is decoding bits 8:15 and passing that into the trace. That maybe explains why the NVME_AER_NOTICE_* entries were added to the symbolic names. If this is still desired, it may require a second TRACE_EVENT definition specific to notice events.
> 
> Although I am new to the kernel, I am happy to help with a patch if you can describe the desired behavior.

Thanks for the notice, you are correct that the tracing is wrong. I'll get a
fix together shortly. Must have been a mistake to mix the Event Info along with
the Event Type decoding.
