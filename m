Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C06B8051
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCMSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCMSVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:21:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21016A9DE;
        Mon, 13 Mar 2023 11:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F9ECB811D8;
        Mon, 13 Mar 2023 18:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB93AC433D2;
        Mon, 13 Mar 2023 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678731629;
        bh=1k+17pceWuz4rSCcRjkRFIddbKW4ybClD+tgo7no39E=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Ilby0VO8KhswP+sNBOB1Scx6AP/OGbMJswQgv6SUaOS/JihC1/IN66ytBUWIYi/L9
         jg1hnG1M4HK7pzXvCisry0+UdXjEQeyE0jEmIR9wieYbq+9hIKVXZwAh6Rb0HN2Qos
         qYwaGbi3GO1cwASGE05A+h2zZ4Dgm6K0whZdHye188J7bVITqcTeL6GjWu1bPC2RBB
         3wBN+JNxQuUglraoSEBrhIaund88t9dkv2zpiK37WJHYkx0ahbQth9HmhERlb76Egu
         fuudSeztn+3Pd45badX1HRQODgBEWpcEmqvXtYag7AYFMm6jcNNxOb1YwlY/us59uf
         Nz+oFG/J9J1aw==
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 01/16] spi: armada-3700: Drop of_match_ptr for
 ID table
Message-Id: <167873162468.102913.17330751630125213207.b4-ty@kernel.org>
Date:   Mon, 13 Mar 2023 18:20:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 23:28:42 +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).
> 
>   drivers/spi/spi-armada-3700.c:807:34: error: ‘a3700_spi_dt_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[12/16] spi: pxa2xx: Mark OF related data as maybe unused
        commit: d94df25e8b9c8deefc5d7fcd344eb5d4bd41cf7b
[13/16] spi: bcm-qspi: Mark OF related data as maybe unused
        commit: 6340fdf2e13c5f1ff3a9622f0cb3b8e9c3955a31
[14/16] spi: sh-msiof: Mark OF related data as maybe unused
        commit: d946b6b0ed01949b1a3856e03469361fc9168318
[15/16] spi: sc18is602: Mark OF related data as maybe unused
        commit: 833f43308234600e934e9c6fa70fd8b7eebc632b
[16/16] spi: rspi: Mark OF related data as maybe unused
        commit: edfa970370a759c2c6a38b2884887937b1aea552

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

