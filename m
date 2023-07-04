Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B057C747285
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGDNSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjGDNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2205C171C;
        Tue,  4 Jul 2023 06:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D5A61251;
        Tue,  4 Jul 2023 13:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE4AC433C7;
        Tue,  4 Jul 2023 13:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688476664;
        bh=UTpMzzey7UkJhz14eKdj2JT9MkTg/zyYKLbQdg852ZY=;
        h=From:To:Cc:Subject:Date:From;
        b=Iqtfxx7JRJgfEXsDkjC6/o1KGO9ymffyCRPQ+aAko//FJZtwQmdMOQfdWRDl0+3G2
         v0i2hy/SMnipPYl3H0qjOaaeOabB6eTAXWb8pbtB2+I11oF06vajXDDcE8vv5J3QT/
         4hNujCZUjQu7X+g636JJ2hnq9Q0otfFAkyNodgn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-hwmon@vger.kernel.org
Cc:     linux@roeck-us.net, samsagax@gmail.com,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/3] driver core: remove final user of devm_device_add_groups()
Date:   Tue,  4 Jul 2023 14:17:16 +0100
Message-ID: <20230704131715.44454-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=gregkh@linuxfoundation.org; h=from:subject; bh=UTpMzzey7UkJhz14eKdj2JT9MkTg/zyYKLbQdg852ZY=; b=owGbwMvMwCRo6H6F97bub03G02pJDClLpG/HrH7t6eTvWPwpx6m6Rv3GPeOZN0svR87gNvb48 6ujdfmsjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjI7dkMczj5rDdJTTj36dUz gT95E6VdDr37uY5hFlPD8m29qZv2FZ89Oo3xTPXplTerJgIA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the 6.5-rc1 merge window, a new user of devm_device_add_groups()
snuck in before I had a chance to remove it from the tree.  This series
removes that user (and cleans up a global variable in the oxp-sensor
driver), and removes the call from the tree entirely.

Guenter, feel free to take these through your hwmon tree, or I can take
them through my driver-core tree if you want me to.

Greg Kroah-Hartman (3):
  hwmon: (oxp-sensors): remove static board variable
  hwmon: (oxp-sensors): move to use dev_groups from platform device
  driver core: remove devm_device_add_groups()

 drivers/base/core.c         | 45 --------------------
 drivers/hwmon/oxp-sensors.c | 82 +++++++++++++++++++++----------------
 include/linux/device.h      |  2 -
 3 files changed, 47 insertions(+), 82 deletions(-)

-- 
2.41.0

