Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1A6AE719
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCGQq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjCGQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:46:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2303F96C24;
        Tue,  7 Mar 2023 08:43:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFCD6614D0;
        Tue,  7 Mar 2023 16:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A03C433EF;
        Tue,  7 Mar 2023 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207417;
        bh=/wCzZzW2/yX+S5Q2Jws0Te+1469cW0yfUpj6G9fEMgw=;
        h=From:To:Cc:Subject:Date:From;
        b=fZZKakMeNyA7vBG7KIRsV5Nxp99JFYUHhpbyKacVPLYuF2c8RIhgWxmhtnrnzWEBG
         BXFCdiut0UjjQK/jHCw+4mnkwTH8v+OEAOEInZu056nveKGBVahgd6xDO1sUSDCoLx
         YgqGpOGvWVRfOVmAXovlwPc2AOMRhpojhQpcxUcTvfHrr1fFX8FUjSzA+juVQnjtxR
         XxT2+Grq/f5B50uIzmB4q1BxaETSbi4+iBaV2W+rirvtpvrx8YgvNQc8VPmpgAd0wo
         OVV451ZZl2S9W9q0CkLA5j1GiqQarrpsdGojYcA4kJB8waen/LAO2Hsgs4YGgB8swX
         stG8zubplE3bA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZaQG-0003ho-4E; Tue, 07 Mar 2023 17:44:20 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
Date:   Tue,  7 Mar 2023 17:44:01 +0100
Message-Id: <20230307164405.14218-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some of the fallout after a recent series adding
support for DMA transfers to the Qualcomm geni serial driver.

Most importantly it fixes a hang during reboot when using a serial
console and the getty is stopped during reboot.

Doug just posted an equivalent fix here:

	https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid

but the commit message only mentions the regression with respect to
kgdb, which is not as widely used serial consoles generally, so I
figured I'd post my version for completeness.

Either version of that fix should address the immediate regression, but
fixing the underlying problems which have been there since the driver
was first merged is going to be a bit more involved.

The rest of the series fixes a few bugs in the new DMA support that I
found while investigating the console regression.

Johan


Johan Hovold (4):
  serial: qcom-geni: fix console shutdown hang
  serial: qcom-geni: fix DMA mapping leak on shutdown
  serial: qcom-geni: fix mapping of empty DMA buffer
  serial: qcom-geni: drop bogus uart_write_wakeup()

 drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.39.2

