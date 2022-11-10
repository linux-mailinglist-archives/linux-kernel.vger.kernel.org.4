Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB43623A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKJDID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJDIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:08:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A542DF95;
        Wed,  9 Nov 2022 19:08:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6F9FB8205A;
        Thu, 10 Nov 2022 03:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC186C433D6;
        Thu, 10 Nov 2022 03:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668049676;
        bh=1Cf3JTsldLxJtisTZOqpdXIgbuVMW3W9Pr92K0IGKCk=;
        h=From:To:Cc:Subject:Date:From;
        b=WQi+Ug4e4Epto/QhwCN2GbfzD67WtqVm+6rZwlSRxgKyui0upcOaqgZDYH1oPWJWl
         cdLe90BHSnBeeJG8yT6IjZLgL/O9m5iGWx4RbBz8m4eubBvyBHn9gha2cz3WyQNkfq
         11KduYZB512BMpPsxr+v2r6U2CYDjVWkndVIRoXiX4WuaPi/mskongpWuBYqdPAJLw
         0cJAni8+oAlYVLNwPmWWds1bTjv8ddLYN7PvEolEM/b6gd52/cuJHOGzjtt6TxLp01
         tb5+Xia3fkR/kS/Wnm4mIp0XWjDPj7w+W/jdqkCxi3UbievgIeJGLKxfKcrPg8kcjn
         uhIGYkP67zNGA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Subject: [GIT PULL] hwspinlock updates for v6.1
Date:   Wed,  9 Nov 2022 21:07:54 -0600
Message-Id: <20221110030754.786462-1-andersson@kernel.org>
X-Mailer: git-send-email 2.37.1
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

Hi Linus,

I apparently had missed tagging and sending this set of changes out during the
6.1 merge window. But did get the associated dts changes depending on this
merged. The result is a regression in 6.1-rc on the affected, older, Qualcomm
platforms - in for form of them not booting.

So while these weren't regression fixes originally, they are now. It's not
introducing new beahavior, but simply extending the eixsting new Devicetree
model, to cover remaining platforms.

So I hope you will accept this pull request.

Regards,
Bjorn

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.1

for you to fetch changes up to c29f446108e10bb791220ffbba54d82722d60d45:

  dt-bindings: hwlock: qcom-hwspinlock: add syscon to MSM8974 (2022-10-17 17:11:17 -0500)

----------------------------------------------------------------
hwspinlock updates for v6.1

This extends the DeviceTree binding and implementation for the Qualcomm
hardware spinlock on some older platforms to follow the style of the
newer ones where the DeviceTree representation does not rely on an
intermediate syscon node.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      dt-bindings: hwlock: qcom-hwspinlock: add support for MMIO on older SoCs
      dt-bindings: hwlock: qcom-hwspinlock: correct example indentation
      hwspinlock: qcom: correct MMIO max register for newer SoCs
      hwspinlock: qcom: add support for MMIO on older SoCs
      dt-bindings: hwlock: qcom-hwspinlock: add syscon to MSM8974

 .../bindings/hwlock/qcom-hwspinlock.yaml           | 29 ++++++++++-----
 drivers/hwspinlock/qcom_hwspinlock.c               | 42 ++++++++++++++++------
 2 files changed, 53 insertions(+), 18 deletions(-)
