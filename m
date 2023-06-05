Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37B27228CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjFEO3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFEO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FD9E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91DA461299
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5852C433EF;
        Mon,  5 Jun 2023 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685975345;
        bh=hZ87ZYTbpDOaTiFT09YI6BJw7NRtzjXefqSYa6e0NqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkFIZcwvKrxwZMZ4QVYNpyLfbt4KUpf5M8zr3ZdHC6RtfW7UqKbn/gNUtc0ldQK/W
         ++5AcyzPv3Ei5fshhQL5/+Dk4QFyUpsUFZ+G2TmRxCkmPQGXX+S8WJkJNS3QvmAHEG
         LoFFb9o1fCMurmj20vEZXK0lp2VCjsUW279AFo6Klr5ltnKowH4HINIh4Wq0pM1HIs
         UsevQ+8/vI9bzLRGuLet4bA5A7QhrMSZlx6C2SdEA99/gQYs45t73Kg3+0HTcSq4Hf
         ax1ETZm5L8ks2//V6Qj/How4qf0VbBOv+X1163Frad0anoZ8aIyx4D11udTTSVgg+K
         OJ8WXGnkkptOA==
Date:   Mon, 5 Jun 2023 15:28:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     catalin.marinas@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, steven.price@arm.com,
        vincenzo.frascino@arm.com, pcc@google.com, wangxiang@cdjrlc.com,
        ajones@ventanamicro.com, conor.dooley@microchip.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] arm64: hibernate: remove WARN_ON in
 save_processor_state
Message-ID: <20230605142857.GE21212@willie-the-truck>
References: <20230525025555.24104-1-songshuaishuai@tinylab.org>
 <20230525025555.24104-3-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525025555.24104-3-songshuaishuai@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:55:53AM +0800, Song Shuai wrote:
> During hibernation or restoration, freeze_secondary_cpus
> checks num_online_cpus via BUG_ON, and the subsequent
> save_processor_state also does the checking with WARN_ON.
> 
> So remove the unnecessary checking in save_processor_state.

This is a very terse summary of why this is safe.

Looking at the code, freeze_secondary_cpus() does indeed check
num_online_cpus(), or it returns an error which then causes the hibernation
to fail. However, this is all in the CONFIG_PM_SLEEP_SMP=y case and it's
far less clear whether your assertion is true if that option is disabled.

Please can you describe your reasoning in more detail, and cover the case
where CONFIG_PM_SLEEP_SMP=n as well, please?

Will
