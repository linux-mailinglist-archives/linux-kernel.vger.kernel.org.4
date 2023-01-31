Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E263682D00
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjAaMvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjAaMvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:51:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E548745F43
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D39B614EC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4B3C433D2;
        Tue, 31 Jan 2023 12:51:36 +0000 (UTC)
Date:   Tue, 31 Jan 2023 12:51:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64/signal: Signal handling cleanups
Message-ID: <Y9kO1egKjKNqE0zg@arm.com>
References: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jan 03, 2023 at 08:25:15PM +0000, Mark Brown wrote:
> This series collects a number of small cleanups to the signal handling
> code which removes redundant validation of size information and avoids
> reading the same data from userspace twice.
> 
> There are some overlaps with both the TPIDR2 signal handling and SME2
> serieses which are also in flight, applying this will require
> adjustments in those serieses and vice versa.
[...]
> Mark Brown (6):
>       arm64/signal: Don't redundantly verify FPSIMD magic
>       arm64/signal: Remove redundant size validation from parse_user_sigframe()
>       arm64/signal: Make interface for restore_fpsimd_context() consistent

I'm fine with the first three patches, they seem correct and make the
frame checking more consistent.

>       arm64/signal: Avoid rereading context frame sizes
>       arm64/signal: Only read new data when parsing the SVE context
>       arm64/signal: Only read new data when parsing the ZA context

I'm not sure these add much to the code readability (and the performance
improvement I guess is negligible). We avoid some copy_from_user() into
the context structures but rely on data read previously or some
get_user() into local variables. Personally I'd make the
restore_fpsimd_context() also do a copy_from_user() for consistency with
the current sve and za frames restoring.

Personal preference, not sure whether Will has the same view.

-- 
Catalin
