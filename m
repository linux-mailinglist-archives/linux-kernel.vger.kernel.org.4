Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A951B7233BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjFEXkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjFEXkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08667CD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B606223C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0CE7C4339B;
        Mon,  5 Jun 2023 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686008420;
        bh=nXb7mtrwpoQ9S7IxoV+MpDyHRELn3TsApNXMTCtdUOs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LOzHFmHTlO7zjJ73OQkXKClljFGZ58nyfv1umutEQJn0cFXweJNMl6zzgHAb90VjG
         6XL0hVUcGdYN9yImS4Rc3cfpsBsxerUzm2tkoBTV2qEmjWXe8U1icUyK34E/v7pn//
         RAXT0l1QNTNY1sfe2jIcPG7kB2fkjI995KM6aZbNuvZkrktBNqBZgTNwGAsgryRMZz
         VjzkotgKbwMwwWtaYQt7h7jjjbHFOG5yrq6+4GlzL05GnP85ccdMg/1hCraZU3vzs6
         3QL3MOsO1ky4XGO9OIWimlhvrwO7OdbIrjxoCwRzGkatpFHaCD8E1sea5LIKzwZaLv
         5Umhu+84DhRaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9712E4F0A7;
        Mon,  5 Jun 2023 23:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Add missing selftests kconfig options
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168600841975.14340.2367835892708005381.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 23:40:19 +0000
References: <20230602140108.1177900-1-void@manifault.com>
In-Reply-To: <20230602140108.1177900-1-void@manifault.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  2 Jun 2023 09:01:08 -0500 you wrote:
> Our selftests of course rely on the kernel being built with
> CONFIG_DEBUG_INFO_BTF=y, though this (nor its dependencies of
> CONFIG_DEBUG_INFO=y and CONFIG_DEBUG_INFO_DWARF4=y) are not specified.
> This causes the wrong kernel to be built, and selftests to similarly
> fail to build.
> 
> Additionally, in the BPF selftests kconfig file,
> CONFIG_NF_CONNTRACK_MARK=y is specified, so that the 'u_int32_t mark'
> field will be present in the definition of struct nf_conn.  While a
> dependency of CONFIG_NF_CONNTRACK_MARK=y, CONFIG_NETFILTER_ADVANCED=y,
> should be enabled by default, I've run into instances of
> CONFIG_NF_CONNTRACK_MARK not being set because CONFIG_NETFILTER_ADVANCED
> isn't set, and have to manually enable them with make menuconfig.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Add missing selftests kconfig options
    https://git.kernel.org/bpf/bpf-next/c/3d272c2fa804

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


