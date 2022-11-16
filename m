Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C382162BF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiKPNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiKPNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:14:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04437391D4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:14:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D520BB81D47
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DDDC433D6;
        Wed, 16 Nov 2022 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668604447;
        bh=cLYTO4vzhEsQDvMU8RCQM2yBcrr1qFys1msCOJt3MaQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GKYxrTGEoXaTqBDSkiDsykuHAZ0SuoRXVXtjmB1WkqMW/yV0gL8dDAHWlWg+Di89i
         LKahkQ695UGzpLTuoTR7txmKBlWRiOW/v+UrfWAwFVlqADYUCX96SaxLo7EdL/akb/
         uz52Vb1RXTAoW2beKh7Eoj6VuwmfMEia5rJW//rM7Y3th0BiqR+9UjkN9z5o+hXFn1
         bvHya+Sc1WEK8I8HcBNRWh8rPPe0Bpf36Z4LT8o2QpiNTXe2xF2RYQ9xMrjGOFap2T
         mC91Dnbu2F8qHUPfi4WsF//Qk95Bicr/yJeMEcISykhLctQ5xsRo7LLrCwfuYwTAyl
         r6Yu6m9rUE3dw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com
In-Reply-To: <20221116092943.1668326-1-yangyingliang@huawei.com>
References: <20221116092943.1668326-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] regulator: rt5759: fix OOB in validate_desc()
Message-Id: <166860444597.370809.18015818974561170969.b4-ty@kernel.org>
Date:   Wed, 16 Nov 2022 13:14:05 +0000
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

On Wed, 16 Nov 2022 17:29:43 +0800, Yang Yingliang wrote:
> I got the following OOB report:
> 
>  BUG: KASAN: slab-out-of-bounds in validate_desc+0xba/0x109
>  Read of size 8 at addr ffff888107db8ff0 by task python3/253
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x67/0x83
>   print_report+0x178/0x4b0
>   kasan_report+0x90/0x190
>   validate_desc+0xba/0x109
>   gpiod_set_value_cansleep+0x40/0x5a
>   regulator_ena_gpio_ctrl+0x93/0xfc
>   _regulator_do_enable.cold.61+0x89/0x163
>   set_machine_constraints+0x140a/0x159c
>   regulator_register.cold.73+0x762/0x10cd
>   devm_regulator_register+0x57/0xb0
>   rt5759_probe+0x3a0/0x4ac [rt5759_regulator]
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt5759: fix OOB in validate_desc()
      commit: 7920e0fbced429ab18ad4402e3914146a6a0921b

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
