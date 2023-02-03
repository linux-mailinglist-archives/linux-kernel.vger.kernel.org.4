Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB568A0CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjBCRuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjBCRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:50:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A7012F0E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21AF4B82B71
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 17:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A4BC433EF;
        Fri,  3 Feb 2023 17:50:18 +0000 (UTC)
Date:   Fri, 3 Feb 2023 17:50:15 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org
Subject: Re: [PATCH v2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y91JV7wNu1QQh1Ag@arm.com>
References: <20230203075723.114538-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203075723.114538-1-bhe@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 03:57:23PM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crossing 4G boudary of crashkernel high region will bring issues:
> 
> 1) For crashkernel=x,high, if getting crashkernel high region across
> 4G boudary, then user will see two memory regions under 4G, and one
> memory region above 4G. The two crashkernel low memory regions are
> confusing.

Looking at your patch, I just realised that the 4G boundary between
'low' and 'high' reservations is not always true. On RPi4, that would be
1GB, the limit of ZONE_DMA. Are there user-space tools that rely on this
32-bit boundary? If they do, they'd get confused on RPi4, not sure they
have the notion of the actual ZONE_DMA that the kernel has enabled. If
we do want ,high to mean always 4G or higher, we'd need to change the
logic a bit so that the search_base starts from 4G rather than
CRASH_ADDR_LOW_MAX. We could leave the latter when ,high was not
specified.

> 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> and y <= 128M, when crashkernel high region crosses 4G boudary and the
> part below 4G of crashkernel high reservation is bigger than y, the
> expected crahskernel low reservation will be skipped. But the expected
> crashkernel high reservation is shrank and could not satisfy user space
> requirement.

I guess if the user passes both high and low, we should honour that and
ignore any y <= 128M checks.

-- 
Catalin
