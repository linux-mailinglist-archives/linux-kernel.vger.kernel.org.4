Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6767221BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjFEJH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFEJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B33BD;
        Mon,  5 Jun 2023 02:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A063C611F5;
        Mon,  5 Jun 2023 09:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE45C433EF;
        Mon,  5 Jun 2023 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685956072;
        bh=CuI2tVljCJg/uTnwW/xgr7RXJ/JrsJTuWbycO8jOShI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYZI5s+5qSa/ow2tsEjjY+EvhvbFWNyH9uXWC/Y4YNuD0G7fFI6rh/nPGTFW4WE/y
         4K5acr+UcQr6LZqaWJOiusVBnruRQtDyxw8nRwCHrpobfyXlY8JelNHZy84oJPPVA9
         u8haE7I8ii50L7ruCtWAqyyEEcQ0YAZhOWrKElkjB261/EZufh6c7LuwBuI7AEx0am
         h5wfnmYmE+pndTQR3W9RwZrCxeONqh7sGhTckcWKINqEKZZgJ4pXrfPtpSplnQOAwz
         wxSl/+C2TKMDsv95uplyvePxcsb29ErZtXJJaP2mw/KrDrM/Q0yAlFBynYIJ1cIouj
         uOmK6+Hxzy/rQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q66C9-0001TD-5M; Mon, 05 Jun 2023 11:08:09 +0200
Date:   Mon, 5 Jun 2023 11:08:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, andersson@kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] soundwire: qcom: stablity fixes
Message-ID: <ZH2l-UbMyLi5Uwph@hovoldconsulting.com>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 02:38:08PM +0100, Srinivas Kandagatla wrote:
> During x13s audio testing we hit few corner cases due to issues
> in codec drivers and some obvious code bugs.
> 
> Here are the fixes for those issues, mostly the issues are around
> devices loosing the sync in between runtime pm suspend resume path.
> 
> With codec fixes along with these fixes, audio on x13s is pretty stable.
> 
> Thanks,
> Srini
> 
> Changes since v1:
> 	- dropped runtime pm changes patch as unable to reproduced it anymore
> 	- fixed clk stop flag as suggested by Pierre
> 	- rebased on top of linux-next

I tried to update to this series on my 6.4-rc5 branch for the X13s and
the above changes appear to lead to breakages again.

Specifically, with the updated clk stop flag (simple_clk_stop_capable) I
see:

[   14.789533] wcd9380-codec sdw:0:0217:010d:00:3: Slave 1 state check1: UNATTACHED, status was 1
[   14.789717] qcom-soundwire 3330000.soundwire-controller: qcom_swrm_irq_handler: SWR bus clsh detected
[   14.796164] wcd9380-codec sdw:0:0217:010d:00:3: Slave 1 state check1: UNATTACHED, status was 1

and without the runtime pm patch that you dropped in v2 I get
intermittent (e.g. twice in five boots):

[   11.527301] snd-sc8280xp sound: ASoC: adding FE link failed
[   11.527409] snd-sc8280xp sound: ASoC: topology: could not load header: -517
[   11.527557] qcom-apm gprsvc:service:2:1: tplg component load failed-517
[   11.527640] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
[   11.528079] snd-sc8280xp sound: ASoC: failed to instantiate card -22
[   11.533388] snd-sc8280xp: probe of sound failed with error -22

Again, this was with 6.4-rc5, but these problems are likely still there
also with linux-next.

Johan
