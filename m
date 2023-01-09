Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A63662AC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbjAIQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjAIQEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:04:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941911C41F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:04:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CF34B80E2A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC61C433F0;
        Mon,  9 Jan 2023 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673280251;
        bh=nC+zu23SLcFaISxH4vAQngXlax29OJipYbg1EhlYNpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SkpyqOUAa09AuTie9kZS7sHMraNnh15/nx0txMROb4VZqnejwDxSApQAp/vSFBnxw
         N2iz1UkjvSUf80eEEZucj5JynkFOCjRtiOPQFDRbrTjlXyBzb/8o7FXZzkiia8ETj2
         hsFT+gCUDcwPRJw9PKzUKG5zYvowvI8H+T0dJDkAIdBW6Eed5ICC3PxwTJ4vYTxbKB
         4q3jT2aKtbQCWcI/WdjIUuJVD5dE8+9Yg4VJnSWjaLIrb81Zd5Z2qcDP/f6Cnleh0V
         kyE33RbS0/6WY+GRw9kOJ7yp1iysgziaWcVMkXGDiPcBh1bX7KisvPDjmduUQIvIkl
         aovvReV2aH+5w==
Date:   Mon, 9 Jan 2023 21:34:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: remove DAI startup/shutdown
Message-ID: <Y7w6+HMSn8M1OwHt@matsya>
References: <20221215085436.2001568-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215085436.2001568-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-12-22, 16:54, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The only thing these DAI startup/shutdown callbacks do is play with
> pm_runtime reference counts.
> 
> This is not wrong, but it's not necessary at all. At the ASoC core level,
> only the component matters for pm_runtime. The ASoC core already calls
> pm_runtime_get_sync() in snd_soc_pcm_component_pm_runtime_get(),
> before the DAI startup callback is invoked.
> 
> None of the SoundWire codec drivers rely on pm_runtime helpers in
> their DAI startup/shutdown either. This adds to the evidence that only
> the component, or more precisely the device specified when registering
> a component, should deal with pm_runtime transitions.
> 
> Beyond the code cleanup, this move prepares for the addition of link
> power management in the auxiliary device startup/resume/suspend
> callbacks. The DAI callbacks can by-design assume that the device is
> already pm_runtime active.

Applied, thanks

-- 
~Vinod
