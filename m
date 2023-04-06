Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487B26D9A76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbjDFOfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbjDFOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C5C17B;
        Thu,  6 Apr 2023 07:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE76A648A7;
        Thu,  6 Apr 2023 14:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E99EC433EF;
        Thu,  6 Apr 2023 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680791500;
        bh=OJh4zaYpUGmBGJnTjRe4Hscxo/UtXSa7youeXVGyH7A=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=G7/UhM9cEX9Za3QvbGgTPXOvOjIGcfMCjLue5/uYMJ+G5P90iTGM0dVm/J5P8g518
         chLyN+8N3CvTfp7898/skBl048pW06ruR+9MNHp8feRxZX8t7MEmg6jETIgQLULPLa
         wHMHA62pDNMH5bGsPWVzyY5rNXflfwC2m6aW/OLM01cKX8lAA61BhtuefUJGcr0uyv
         Xo7uvBgQCrWJM2Nn2SF95X9iWtyQTpIpUTcbWtezTJq+PGMWBQzZrou0pfiTAozpsq
         vmdolafEqNZNH4gQ/c/kvHyLx24v0SYqC9akMzL1blGYPa/x/WJNoKbHaio65LvpPx
         F1lIXnHYpTyJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id EFCA6C77B6F;
        Thu,  6 Apr 2023 14:31:39 +0000 (UTC)
From:   Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>
Subject: [PATCH RFC 0/4] media: v4l2-ctrls: add controls for complex lens
 controller devices
Date:   Thu, 06 Apr 2023 16:31:09 +0200
Message-Id: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK3XLmQC/1XNQQrCMBCF4auUWTsYm0TFreAB3IqLJJ3aQEnKT
 C2F0rubihuXP7yPt4AQRxK4VAswTVFiTiUOuwpC59KLMDaloVa1VkYdsSU3vpkw5DRy7gV7SoL
 +bO3JNtoY7aBY74TQs0uh2/QP7f/QthuY2jh//x9wv13hua4fXIphSJQAAAA=
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680791498; l=3101;
 i=michael.riesch@wolfvision.net; s=20230406; h=from:subject:message-id;
 bh=OJh4zaYpUGmBGJnTjRe4Hscxo/UtXSa7youeXVGyH7A=;
 b=6fXSMiSHAibecfHaIrXad2RhBLfWutwmqZTdnbta4uPO56oUCRTsDHvu1zXs4G8HVvItbgfTB
 rR/pb1r9qehDeEVBAjQrMlQ8BFuiowDdBdmHHo7YYKhWXdXYOiA9T/n
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=G03kuYHL670EcdsWaNfVA7KnHWmkSpj98XziQm/hjbk=
X-Endpoint-Received: by B4 Relay for michael.riesch@wolfvision.net/20230406 with auth_id=38
X-Original-From: Michael Riesch <michael.riesch@wolfvision.net>
Reply-To: <michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series aims to add support for complex lens controllers in V4L2.
Complex lens controllers usually feature one focus lens and one (or more)
zoom lens(es), which are driven by stepper motors. As a consequence, a few
crucial differences to simple lens controllers (such as voice coil motor
(VCM) drivers, which are already well supported in V4L2) arise:

 - Focus and zoom are slow.

Compared to a simple VCM driver, which reacts almost instantaneously, the
stepper motors that control the lens groups may require some time to reach
their target position. Therefore, the control process in user space needs
to receive feedback on the current status of each lens group, such as the
current position and whether or not the lens group is moving. Patch 1/4
adds volatile and read-only status controls for each lens group.

 - The velocity of focus and zoom can be selected.

In contrast to a simple VCM driver, the stepper motors can move at
different velocities. Since the produced noise depends on the velocity, the
control process may want to optimize the chosen velocity. Also, some auto
focus algorithms use different velocities in different phases (e.g., a
coarse and fast scan vs. a slow and precise scan). Patch 2/4 adds speed
controls for the focus lens group and the zoom lens group.

 - Calibration may be required.

Since moving mechanical parts are involved, calibration is most likely
necessary. Patch 3/4 introduces controls to control calibration procedures.

In the scope of calibration, the relation between the lens positions may be
fine-tuned. This requires the ability to control the individual lenses and
gather feedback on their current status. Patch 4/4 introduces a pair of
controls for five zoom lenses. (Five is a placeholder here. The most
complex objective we had at hand happened to feature five zoom lenses.)

On the user space side, it is envisaged that libcamera operates the newly
introduced controls. Please note that no tests with libcamera have been
carried out yet, the integration will be discussed after the first round of
feedback to this RFC.

Looking forward to your comments!

---
Michael Riesch (4):
      media: v4l2-ctrls: add lens group status controls for zoom and focus
      media: v4l2-ctrls: add lens group speed controls for zoom and focus
      media: v4l2-ctrls: add lens calibration controls
      media: v4l2-ctrls: add controls for individual zoom lenses

 .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 105 +++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |   9 ++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  30 ++++++
 include/media/v4l2-ctrls.h                         |   2 +
 include/uapi/linux/v4l2-controls.h                 |  39 ++++++++
 include/uapi/linux/videodev2.h                     |   2 +
 6 files changed, 187 insertions(+)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230406-feature-controls-lens-b85575d3443a

Best regards,
-- 
Michael Riesch <michael.riesch@wolfvision.net>

