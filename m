Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C55F85E9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJHPkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHPj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:39:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE9614D33
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDA25B80B71
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 15:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3E1C433D6;
        Sat,  8 Oct 2022 15:39:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EpZkVZPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665243589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEsrKHB7ZL/ozfM6RmFepWbc/0ZZRtDIuc+SK7aEwrk=;
        b=EpZkVZPgUQmJcgqy6jegWs8vbvOd7Ef3vb/Mj95J+XoH8x1cQsLurV53ct9Tns7o9gCmyt
        RbyTx4qGnJcNBS2xaS7rHbdExyBE4zkc58qyOA/60UyL+ndzpPBoVsoLgLnt9WfA2WReY4
        0Z8nmyiXvn9qXch4Wr3jgRnftXxS5F0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e701f4ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 8 Oct 2022 15:39:49 +0000 (UTC)
Date:   Sat, 8 Oct 2022 09:39:46 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] MFD for v6.1
Message-ID: <Y0GZwkDwnak2ReTt@zx2c4.com>
References: <Yz6Zi7B2RS16sXhT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz6Zi7B2RS16sXhT@google.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee, Andy,

On Thu, Oct 06, 2022 at 10:02:03AM +0100, Lee Jones wrote:
>    - Remove legacy / unused code; stmpe, intel_soc_pmic_crc, syscon
> Andy Shevchenko (13):
>       mfd: syscon: Remove repetition of the regmap_get_val_endian()
>  drivers/mfd/syscon.c                               |    8 -

72a95859728a ("mfd: syscon: Remove repetition of the
regmap_get_val_endian()") broke reboot on big endian MIPS VMs. Scroll to
the bottom of
https://build.wireguard.com/linux/e8bc52cb8df80c31c73c726ab58ea9746e9ff734/mips.log
to see:

[  243.154570] reboot: Restarting system
[  244.157414] Unable to restart system
[  245.159851] Reboot failed -- System halted

Jason
