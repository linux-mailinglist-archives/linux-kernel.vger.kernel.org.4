Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4762BF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiKPNOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiKPNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:14:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C331225
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:14:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B39FDB81D54
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0623AC433C1;
        Wed, 16 Nov 2022 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668604449;
        bh=ucd5lfEzQabKMvcHK4jf0v8ok9b876G+oG77ASjmgX4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Uqi0rxRW9OvAKhHdWONzo57F9/AH9fyfN/5OBZCt3Dw7+RU0NTFMSwLqNwCaHh0wq
         Abph1MCOc6FWsthXsgJeu6ZSOlYpcUkZ440W1YXuyKtBSjFZO/Q25VpMMdWjpOcxWK
         hNyGu8d7baGoWF5fPVkUYXbwlSEmJGZcS0JxDieImnnchb3KhfxcnyhY/ruvWbHj72
         v0Fpvpq2TqpIwZZ3hbUPDSSXOZnbMhX2p2z31CWHYX3Ue7kzS32hl8I3Xz5RIrsfWo
         LYxQaoxZaYMzgoLnlGvSmyS6SGDK3kkJUcXEQJn7PWbesZ8IxvETmX9lwuscnpAjbN
         0ZYo8L1c5xFDA==
From:   Mark Brown <broonie@kernel.org>
To:     mirq-linux@rere.qmqm.pl, vz@mleia.com, lgirdwood@gmail.com,
        Zeng Heng <zengheng4@huawei.com>
Cc:     liwei391@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20221116074339.1024240-1-zengheng4@huawei.com>
References: <20221116074339.1024240-1-zengheng4@huawei.com>
Subject: Re: [PATCH v2] regulator: core: fix kobject release warning and memory leak in regulator_register()
Message-Id: <166860444722.370809.11947195278889247340.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 13:14:07 +0000
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

On Wed, 16 Nov 2022 15:43:39 +0800, Zeng Heng wrote:
> Here is a warning report about lack of registered release()
> from kobject lib:
> 
> Device '(null)' does not have a release() function, it is broken and must be fixed.
> WARNING: CPU: 0 PID: 48430 at drivers/base/core.c:2332 device_release+0x104/0x120
> Call Trace:
>  kobject_put+0xdc/0x180
>  put_device+0x1b/0x30
>  regulator_register+0x651/0x1170
>  devm_regulator_register+0x4f/0xb0
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: fix kobject release warning and memory leak in regulator_register()
      commit: 5f4b204b6b8153923d5be8002c5f7082985d153f

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
