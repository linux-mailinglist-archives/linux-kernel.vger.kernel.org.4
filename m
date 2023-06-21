Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF267381FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjFUKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjFUKwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:52:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A819A9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72024614FB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546E5C433C0;
        Wed, 21 Jun 2023 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687344679;
        bh=1kZA/ZWjzG5usQ5GqlzqPsiXwNKPSaidlzP7qa/Trt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUgkeL9ADvrwRmG0xIOAbOBTHSY5srqR+zFdZHjCl34eFkP1h3JnJPvGGqDe+tpz6
         bfbv+DHE625NBP3H4mgXPizSn3ZsUZ9+mKHk2biaze2QJ9X1vD4qSuO74cO/ZcJMAc
         XLQDnkVl/NOYKcfFF8SBVL0xC9BvCHNfSoVlXnBoNR8QLWQnVC5zZu75ZW6ooPA+fb
         TiGx55frIkJxLoUMvqL+iFj+sz+h4frJbTuAJMiFZJEcBDJzofzgCDdZo9YjzmTSwu
         Vh/zT/eaQaOxS/FsBK503iQPG7CwKfK1UAwDb/c98cB9BLZraA5J/Mrpbd6CEJYmby
         6/GtIWhjqFjYQ==
Date:   Wed, 21 Jun 2023 16:21:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel_ace2x: fix SND_SOC_SOF_HDA_MLINK
 dependency
Message-ID: <ZJLWIw5nMhFcaoSe@matsya>
References: <20230616090932.2714714-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616090932.2714714-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-23, 11:09, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ace2x driver can be build with or without mlink support, but
> when SND_SOC_SOF_HDA_MLINK is set to =m and soundwire is built-in,
> it fails with a link error:
> 
> ld.lld: error: undefined symbol: hdac_bus_eml_sdw_wait_syncpu_unlocked
> >>> referenced by intel_ace2x.c
> >>>               drivers/soundwire/intel_ace2x.o:(intel_link_power_up) in archive vmlinux.a
> 
> ld.lld: error: undefined symbol: hdac_bus_eml_sdw_sync_arm_unlocked
> >>> referenced by intel_ace2x.c
> >>>               drivers/soundwire/intel_ace2x.o:(intel_sync_arm) in archive vmlinux.a
> 
> Add a Kconfig dependency that prevents that broken configuration but
> still allows soundwire to be a loadable module instead.

Applied, thanks

-- 
~Vinod
