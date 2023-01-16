Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7D66BF89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAPNSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjAPNRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:17:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B1F1EFE3;
        Mon, 16 Jan 2023 05:16:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE7CAB80D31;
        Mon, 16 Jan 2023 13:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB12C433EF;
        Mon, 16 Jan 2023 13:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673874968;
        bh=5Y3OayCpNahHzw9Xu2OoIo50BHoizMUaQvkXJFa58jc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ji7hoiqffDLLiyyHf0MQuVT4t+x2VkeKFh2OvBxm6GGBp1tBuMO3b6X9fpD2WOY1H
         VUKulXpprZWegUh/ActP4x8MtUal3gP5W1zJUfFNUI/TTyX2fBWz+7rNmtkZeeo+Ks
         YmNXMQ6OIABQdK2Vyy+9wy8UPNh0uDH/r8AFXuXAAWGdcEQH/bcLju5LIj5/OHMrZm
         lg6x6aUaQlpHyUYZ6Ckwy8cQkuWOBZ54LuZwImESBmSfVeklfwL2lmFcfkRbu722V/
         0QxZX8HURk0cFoKUG9MF/Bg/SHdRKSaydaKSGiKJfE1Vhj8lCoVx9lWfLbidzXmypJ
         IeoDqHksqQWkA==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Nazarov <Sergey.Nazarov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230113185942.2516-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113185942.2516-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2] spi: dw: Fix wrong FIFO level setting for long xfers
Message-Id: <167387496509.317866.16090598149927325020.b4-ty@kernel.org>
Date:   Mon, 16 Jan 2023 13:16:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 21:59:42 +0300, Serge Semin wrote:
> Due to using the u16 type in the min_t() macros the SPI transfer length
> will be cast to word before participating in the conditional statement
> implied by the macro. Thus if the transfer length is greater than 64KB the
> Tx/Rx FIFO threshold level value will be determined by the leftover of the
> truncated after the type-case length. In the worst case it will cause the
> dramatical performance drop due to the "Tx FIFO Empty" or "Rx FIFO Full"
> interrupts triggered on each xfer word sent/received to/from the bus.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Fix wrong FIFO level setting for long xfers
      commit: 9ef7b7b43eb708c114bb3ce6c0acadd74065bf4e

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
