Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6812B647158
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLHOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHOJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:09:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD58314;
        Thu,  8 Dec 2022 06:09:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E11661F4C;
        Thu,  8 Dec 2022 14:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8CAC433C1;
        Thu,  8 Dec 2022 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670508550;
        bh=TjT5PUNaNbGlUXOnw89bI4x13NlHeMqj/JZXmYi1AAk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oJlNQ4XNnq456CSrH1v2scCD1AZykmpEWYi9ZpCSEBMCDccShg8hkBW1oplSPKF4m
         2EFXgqonaDWDJSv9HKGQ92njZyKK2284lOPCYn1oXPWWRtwQGtrWyw9ugyczYW5dlq
         5+DkWKiAmUL14HIDtTYj+wmGd8txWjwGspyHO+eX5vJBKG1BC1eIvwHauFfn1hQc/A
         vHdyuEC9N4jglHWI8/SmZLaAtyLQ2AoLUx9w97AFXCP7Y+zIKT853dmiHxHJx/XYmV
         ZFSz4PAs5cem8w0BkR7wWJUnEIqEmsSOLnUxNXRFOulRH/41TxMQli5XGNUplNyQ1B
         BqxPTpelfGsww==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     djrscally@gmail.com, hdegoede@redhat.com, markgross@kernel.org,
        lgirdwood@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, yangyingliang@huawei.com,
        gene_chen@richtek.com, chiaen_wu@richtek.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
In-Reply-To: <1670311341-32664-1-git-send-email-u0084500@gmail.com>
References: <1670311341-32664-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH v2] regulator: core: Use different devices for resource
 allocation and DT lookup
Message-Id: <167050854689.183709.17486516496456151482.b4-ty@kernel.org>
Date:   Thu, 08 Dec 2022 14:09:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-76d0b
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022 15:22:21 +0800, cy_huang wrote:
> Following by the below discussion, there's the potential UAF issue
> between regulator and mfd.
> https://lore.kernel.org/all/20221128143601.1698148-1-yangyingliang@huawei.com/
> 
> From the analysis of Yingliang
> 
> CPU A				|CPU B
> mt6370_probe()			|
>   devm_mfd_add_devices()	|
> 				|mt6370_regulator_probe()
> 				|  regulator_register()
> 				|    //allocate init_data and add it to devres
> 				|    regulator_of_get_init_data()
> i2c_unregister_device()		|
>   device_del()			|
>     devres_release_all()	|
>       // init_data is freed	|
>       release_nodes()		|
> 				|  // using init_data causes UAF
> 				|  regulator_register()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Use different devices for resource allocation and DT lookup
      commit: 8f3cbcd6b440032ebc7f7d48a1689dcc70a4eb98

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
