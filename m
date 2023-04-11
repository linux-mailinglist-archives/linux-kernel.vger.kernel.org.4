Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD966DDD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjDKOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDKOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200815590
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E6361DB6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76958C4339B;
        Tue, 11 Apr 2023 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681222744;
        bh=CRz1qKpKwD8iOnTccK2DJ8nejiS+LrBWdZansG+v2EA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ts4sT5p2+hBzUiZXcfVFsOx79tgIGcMH1lo+o6Rs1Ct7XWGHd/ynTuAWO1yazDV8h
         m73m6+/csj4UjqarwfQ76oOBMoCF40nOdoTe3dtlgHJOH2fAiQ7n+v6hrdYs9mqlW3
         5HIQSZRaerGGJFiwwOq+EAjY/UqVDLKoKjbPdth1fomaiHyG887M0vEtOZye6hcUrQ
         JjMUBDv0SAnvEfUumaO+aO+Q+wtuX7u5MdbwHPdgCv8lazawaxFMSM67bBzHv9oUlH
         8YK00fregUCzwove319mBVhj26tc8L5x0OnIEOgbsOZO0WpHV5YYpIPgj1IoKZpdyy
         wGhtVG2+lfvzw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>,
        Aashish Sharma <shraash@google.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <20230411003431.4048700-1-shraash@google.com>
References: <20230411003431.4048700-1-shraash@google.com>
Subject: Re: [PATCH] ASoC: mediatek: common: Fix refcount leak in
 parse_dai_link_info
Message-Id: <168122274119.54453.4476599786792187877.b4-ty@kernel.org>
Date:   Tue, 11 Apr 2023 15:19:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 06:04:31 +0530, Aashish Sharma wrote:
> Add missing of_node_put()s before the returns to balance
> of_node_get()s and of_node_put()s, which may get unbalanced
> in case the for loop 'for_each_available_child_of_node' returns
> early.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: common: Fix refcount leak in parse_dai_link_info
      commit: beed115c2ce78f990222a29abed042582df4e87c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

