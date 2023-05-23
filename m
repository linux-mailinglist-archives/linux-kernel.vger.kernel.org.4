Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5965470E5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbjEWTuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbjEWTuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C7186
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB36E629C7
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10449C4339B;
        Tue, 23 May 2023 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684871409;
        bh=0kgIbzjX9fgNjWHC6MDxSyK2sgeMFDKHe414S+s4B1c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p9UHvbQk1P7RQdr3geFPkC6JG4ciBbDKkYgvIjLZqwG6fKWZTagvB9KcUWRATmT4O
         PkG1y64ukNE0H/1s89SL4xncrVlMk5ZKDGCpIk91hHmzJNeWCdDvcmu69Y6wsHaAdo
         jlZqOxJrzHgzWTyj6FihQ4vPPEkF+7d/RtuYe4s4lN9msGdSWXVj/kzCflKktTNJrP
         sHhknRlsikKxc7NDI/ISTkjNH4UI21bpdnfY0Zq7J/Ar/VO0ECYHsGrosMUvHsmO8P
         bU1S7Dn2xpxTxmT9PxWQc/9dZolMzNVvvRVcOXJnA5q+oFmQzdooi+zIibfGEieV/P
         ItCsrpnDQUWzw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Yang Li <yang.lee@linux.alibaba.com>
Cc:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230516081116.71370-1-yang.lee@linux.alibaba.com>
References: <20230516081116.71370-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: SOF: ipc4-topology: Fix an unsigned
 comparison which can never be negative
Message-Id: <168487140577.278276.4105417647413959490.b4-ty@kernel.org>
Date:   Tue, 23 May 2023 20:50:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 16:11:16 +0800, Yang Li wrote:
> The return value from the call to sof_ipc4_get_valid_bits() is int.
> However, the return value is being assigned to an unsigned
> int variable 'out_ref_valid_bits', so making it an int.
> 
> Eliminate the following warning:
> ./sound/soc/sof/ipc4-topology.c:1537:6-24: WARNING: Unsigned expression compared with zero: out_ref_valid_bits < 0
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Fix an unsigned comparison which can never be negative
      commit: fcbc3aaccfd57c7e71eac36bf1a8f063f19ceefa

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

