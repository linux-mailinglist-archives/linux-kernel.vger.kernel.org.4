Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE80640771
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiLBNF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiLBNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:05:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2CECF7B5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:05:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4E15CE1DBE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBF5C43470;
        Fri,  2 Dec 2022 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669986350;
        bh=Hu2VkabrZDNV6nqTwUwRYNMPwdA+MLHz+S8Q086mHJU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jhsbu9jovGOxLf+qQOjw6nI0VqZJqPiIJhxMKsLJ2pxo/ii6NF1PSg4JOBZ4tl253
         mxrJBz8ukGV4PGhjR47yqJiDxbz7s13LFOTIZ60hl700ci+ZtLbnqCvuvYhuSOd+K4
         J5/+NqHQgszOjRHqRc+gcIrOlKI2s2To/JEFhtiMLDy8J8PQ5GbxAMor3m8VdAZxlx
         CRM4cX7ybR828/G+GNsvoDRKf4xvXviv8QblYcGhF/x9RDx/l6D7iyaeAh9J1AkFoW
         PjfWTa+DzGh12yVox8bsQn1P445hBgxNIcFLHPGDWEQqtGL3W2bHuDo2357Ohyw/Ik
         RMIzCuYYFUHZQ==
From:   Mark Brown <broonie@kernel.org>
To:     christian@kohlschutter.com, mirq-linux@rere.qmqm.pl,
        Yang Yingliang <yangyingliang@huawei.com>, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20221202025111.496402-1-yangyingliang@huawei.com>
References: <20221202025111.496402-1-yangyingliang@huawei.com>
Subject: Re: [PATCH resend] regulator: core: fix resource leak in regulator_register()
Message-Id: <166998634859.1153499.7791401527802899738.b4-ty@kernel.org>
Date:   Fri, 02 Dec 2022 13:05:48 +0000
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

On Fri, 2 Dec 2022 10:51:11 +0800, Yang Yingliang wrote:
> I got some resource leak reports while doing fault injection test:
> 
>   OF: ERROR: memory leak, expected refcount 1 instead of 100,
>   of_node_get()/of_node_put() unbalanced - destroy cset entry:
>   attach overlay node /i2c/pmic@64/regulators/buck1
> 
> unreferenced object 0xffff88810deea000 (size 512):
>   comm "490-i2c-rt5190a", pid 253, jiffies 4294859840 (age 5061.046s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff a0 1e 00 a1 ff ff ff ff  ................
>   backtrace:
>     [<00000000d78541e2>] kmalloc_trace+0x21/0x110
>     [<00000000b343d153>] device_private_init+0x32/0xd0
>     [<00000000be1f0c70>] device_add+0xb2d/0x1030
>     [<00000000e3e6344d>] regulator_register+0xaf2/0x12a0
>     [<00000000e2f5e754>] devm_regulator_register+0x57/0xb0
>     [<000000008b898197>] rt5190a_probe+0x52a/0x861 [rt5190a_regulator]
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: fix resource leak in regulator_register()
      commit: ba62319a42c50e6254e98b3f316464fac8e77968

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
