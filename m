Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407A06DF177
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDLKDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLKDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F66A6E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57F256111E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38537C433EF;
        Wed, 12 Apr 2023 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293796;
        bh=orE2O/zMsVFBriViH8enOqSC4BSUkPwPs4na+wpil/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vD8ctv5vHUXhXwPYclZbTLkfZC5IuRcYtwzRJApLNXhQwkzxBut9x9KCPT/jUTT4V
         oiIvMccrumVHSoH+CRYQ1qZL2r/LN/ae0K95zMF8rrhvxtqagRiEDG7ll+BNsb+Ee7
         D/mQiwWcexV2kKBQjC5UwaHGaqYcf3dLOT4q/qqziwP2pRYf6V07aXIIo4ljkHWwYX
         7LomUPi2BY6L+6PJkGycjrglHlTdDN2fED63eCbHVRFEt0cxEARdu541Vrh3/GetnQ
         tDVYWLgD9tikGIiTVTxpZqco1iD4skLkqo7ocJ2pAMJ6fpK+W+0RfxKOxHAxaA6KPC
         lkRcBE6GYYxTw==
Date:   Wed, 12 Apr 2023 15:33:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: don't save hw_params for use in prepare
Message-ID: <ZDaB4Nea32pNWpeN@matsya>
References: <20230321022642.1426611-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321022642.1426611-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-23, 10:26, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The existing code copies the hw_params pointer and reuses it later in
> .prepare, specifically to re-initialize the ALH DMA channel
> information that's lost in suspend-resume cycles.
> 
> This is not needed, we can directly access the information from the
> substream/rtd - as done for the HDAudio DAIs in
> sound/soc/sof/intel/hda-dai.c
> 
> In addition, using the saved pointer causes the suspend-resume test
> cases to fail on specific platforms, depending on which version of GCC
> is used. Péter Ujfalusi and I have spent long hours to root-cause this
> problem that was reported by the Intel CI first with 6.2-rc1 and again
> v6.3-rc1. In the latter case we were lucky that the problem was 100%
> reproducible on local test devices, and found out that adding a
> dev_dbg() or adding a call to usleep_range() just before accessing the
> saved pointer "fixed" the issue. With errors appearing just by
> changing the compiler version or minor changes in the code generated,
> clearly we have a memory management Heisenbug.
> 
> The root-cause seems to be that the hw_params pointer is not
> persistent. The soc-pcm code allocates the hw_params structure on the
> stack, and passes it to the BE dailink hw_params and DAIs
> hw_params. Saving such a pointer and reusing it later during the
> .prepare stage cannot possibly work reliably, it's broken-by-design
> since v5.10. It's astonishing that the problem was not seen earlier.
> 
> This simple fix will have to be back-ported to -stable, due to changes
> to avoid the use of the get/set_dmadata routines this patch will only
> apply on kernels older than v6.1.

Applied, thanks

-- 
~Vinod
