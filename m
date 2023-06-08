Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442B728655
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjFHR1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbjFHR1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB72D56
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7501564FF4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C4CC4339C;
        Thu,  8 Jun 2023 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686245224;
        bh=nOqZblan5c5tTtOJCM+nEcD7kzkArHJjMVIRKk2SO90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLrmcXZzHFoldfmbo/NvgkBX1vpwL6vrcwjMTfcwyd/e0RqBFqn48AVPRv9gAp1am
         owwWRYtL/c5YdjLWEGRC5DnGA9xLEQk1/h4NPKMj0RNQdU4IKpVtAMbppcPU2JNbkx
         aDGt4cAYAlaRFb0NNNmmGOTxrXYPJzD0oRxaEag+TJkSjwERtdm9VKJXp8as47G9g3
         JUHm9urC/uLmwrO65WGgicbLPIQBxzcbzleW1+oy6B5qpqlskdKNoj5c/7ozP//4X9
         T+Kpez3QOgiYrANvmOMs9PLZCrhNvEKNDjXx3k9FDlUA4goT3wuwQUcoXx2Paz6T5a
         r+UG4KAfONcVA==
Date:   Thu, 8 Jun 2023 18:26:58 +0100
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
Message-ID: <20230608172656.GB1606@willie-the-truck>
References: <20230525025555.24104-1-songshuaishuai@tinylab.org>
 <20230525025555.24104-3-songshuaishuai@tinylab.org>
 <20230605142857.GE21212@willie-the-truck>
 <A8B3B45A0174F0B8+98d9d1e1-fe9f-9173-e5a7-b31113da861a@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A8B3B45A0174F0B8+98d9d1e1-fe9f-9173-e5a7-b31113da861a@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 11:00:08AM +0800, Song Shuai wrote:
> 
> 
> 在 2023/6/5 22:28, Will Deacon 写道:
> > On Thu, May 25, 2023 at 10:55:53AM +0800, Song Shuai wrote:
> > > During hibernation or restoration, freeze_secondary_cpus
> > > checks num_online_cpus via BUG_ON, and the subsequent
> > > save_processor_state also does the checking with WARN_ON.
> > > 
> > > So remove the unnecessary checking in save_processor_state.
> > 
> > This is a very terse summary of why this is safe.
> > 
> > Looking at the code, freeze_secondary_cpus() does indeed check
> > num_online_cpus(), or it returns an error which then causes the hibernation
> > to fail. However, this is all in the CONFIG_PM_SLEEP_SMP=y case and it's
> > far less clear whether your assertion is true if that option is disabled.
> > 
> > Please can you describe your reasoning in more detail, and cover the case
> > where CONFIG_PM_SLEEP_SMP=n as well, please?
> 
> With HIBERNATION enabled, the sole possible condition to disable
> CONFIG_PM_SLEEP_SMP
> is !SMP where num_online_cpus is always 1. We also don't have to check it in
> save_processor_state.

Thanks. Please add that to the commit message.

Will
