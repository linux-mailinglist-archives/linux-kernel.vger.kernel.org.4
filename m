Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED3762978B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKOLft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKOLfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:35:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16EB6A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:35:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF813616B5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4BCC433C1;
        Tue, 15 Nov 2022 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668512142;
        bh=VOPeJ0j9VIyXwCI3mSLKT1Md2S2rdwFhDgZqauLatm4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L7thW5f6d5ssT7ZpCLSjHAOdetxUwgjO248W9AKBc4Gg++fB4IoHbyqdjTdMu5hZk
         4zQgRtkLP/AQXKBlEeCiiBzbcKXXnsbb5wYsKII/f378+k3rUduWdlI0Sy3QXU9Qce
         ZbZEWWzTrEFGjS/PePYQTrwMX6MNuKNXqsphEepa0zHqQMJr+i3DwPPm5/MnL+9X7a
         T4C1bIGUjxOt0Py9GSxSMvc6FDglAbHRJnB5WJ1EAHFoDTvK7rDGrZimQDv4+TWyMD
         JhoN1FffqNm6Mt75Tbu4Faw+jEYSa79wJ2r1R30gaqEEiyo27kX2U++vsiEuACY2Lk
         HV9dW2St9eiiQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com
In-Reply-To: <20221115091508.900752-1-yangyingliang@huawei.com>
References: <20221115091508.900752-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] regulator: core: fix unbalanced of node refcount in regulator_dev_lookup()
Message-Id: <166851213934.149212.10775052290535779863.b4-ty@kernel.org>
Date:   Tue, 15 Nov 2022 11:35:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 17:15:08 +0800, Yang Yingliang wrote:
> I got the the following report:
> 
>   OF: ERROR: memory leak, expected refcount 1 instead of 2,
>   of_node_get()/of_node_put() unbalanced - destroy cset entry:
>   attach overlay node /i2c/pmic@62/regulators/exten
> 
> In of_get_regulator(), the node is returned from of_parse_phandle()
> with refcount incremented, after using it, of_node_put() need be called.
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: fix unbalanced of node refcount in regulator_dev_lookup()
      commit: f2b41b748c19962b82709d9f23c6b2b0ce9d2f91

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
