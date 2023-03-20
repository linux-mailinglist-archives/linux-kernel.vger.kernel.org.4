Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B16C0D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCTJfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCTJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:34:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E280D1C590;
        Mon, 20 Mar 2023 02:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F1F9B80DB3;
        Mon, 20 Mar 2023 09:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3784C433EF;
        Mon, 20 Mar 2023 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679304894;
        bh=ag2c2dcaduyuiuxSCK0A5eBY3Oxo/0SPlIjrrZ08ayU=;
        h=From:To:Cc:Subject:Date:From;
        b=rnET9Zz5m3Pgm87+POpjApopr1BleYlIHihy5entbvC7LhqG1ZXCZbpZjVa0unVUx
         sRRBKns0FaTFG+Qb3mdfA1/gFTazZpiIfsCo/phQCtAVVkIWn/r8ArjToreFtvQVvG
         7YriPF8jORuAnb5sdUm2GP3x74plLmWyOhRRhcC1iS4u7AWBod6QANvmgb66QXyQo9
         Dkq+0NzxHqj8dgA9cQoGhk7j+UMnhotk6FbXXyklE5QJcpOjm67CUdgRMES9Mun9oG
         JxxCIe000s5UgGsgMj+XwhZdL/L8PRoyLAox/H1CSEBr4xa7f95Vv/A6f0UZGNFYxl
         PTZJr5bXgkSXA==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, vigneshr@ti.com, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [RFC PATCH 0/2] usb: dwc3: Support wake-up from USB suspend.
Date:   Mon, 20 Mar 2023 11:34:45 +0200
Message-Id: <20230320093447.32105-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current USB gadget driver behaviour is to stop the controller
and disconnect from the bus during System sleep.

This series introduces a new DT property that will change this
behaviour and keep the controller active and connected
to the bus during System sleep. This is useful for applications
that want to enter a low power state when USB is suspended but
remain connected so they can resume activity on USB resume.

This feature introduces a new constraint if Gadget driver is connected
to USB host: i.e.  the gadget must be in USB suspend state to allow
a System sleep as we cannot process any USB transactions
when in System sleep.

The system hardware is responsible to detect the end of USB suspend
and wake up the system so we can begin processing the USB transactions
as soon as possible.

Some prior discussion about System suspend vs USB suspend can be found
at [1]

[1] - https://marc.info/?l=linux-usb&m=167645398109860&w=2

cheers,
-roger

Roger Quadros (2):
  dt-bindings: usb: snps,dwc3: Add 'snps,gadget-keep-connect-sys-sleep'
  usb: dwc3: Support 'snps,gadget-keep-connect-sys-sleep' feature

 .../devicetree/bindings/usb/snps,dwc3.yaml    |  5 ++++
 drivers/usb/dwc3/core.c                       | 25 ++++++++++++++-----
 drivers/usb/dwc3/core.h                       |  2 ++
 drivers/usb/dwc3/gadget.c                     | 25 +++++++++++++++++--
 4 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.34.1

