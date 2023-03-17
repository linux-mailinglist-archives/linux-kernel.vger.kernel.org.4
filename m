Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68686BF633
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCQXYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09830B0F;
        Fri, 17 Mar 2023 16:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE52060B5C;
        Fri, 17 Mar 2023 23:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C00C433EF;
        Fri, 17 Mar 2023 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679095440;
        bh=4Yw10iXA3NoEkVqayhQQ1JuzywOyCVtcyLkwaw2zmhE=;
        h=From:To:Cc:Subject:Date:From;
        b=BbLp5kHCIK6GwfvSIOqpcLdY11l4T3yskCPHCkNzYE56Hd0o5jd1alqnuQV5k23KR
         TDfx0RrIYJZ/5ogVLr5qhtPbF36IRgSgOtxiVO8yc2t8M6c38dGkIKc7wnfiwa4NUz
         20SEtDb+vUESCxxjb4c/8H644ZYhUDvZGA7A58J6DJdKuRwswC2GVx2plOZsQiQ0Wo
         b3YvSCh3OS1fNZjsiGZcRJoPup2a7FlOJgzrKM4zh5tvzrX8ST7lJLbcRPEvg7e8mR
         EFNduRS1cBcO9IUOBY8Vf0xZ3uyBQd2ZP3QJ7rAx9HpL3TkDGiRMnfZ7ocVovmQoez
         H8VQxbbrb2tHA==
Received: by mercury (Postfix, from userid 1000)
        id D8C1310620FE; Sat, 18 Mar 2023 00:23:57 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 0/7] Add Inanbo T28CP45TN89 panel support
Date:   Sat, 18 Mar 2023 00:23:48 +0100
Message-Id: <20230317232355.1554980-1-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
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

This adds panel support for Inanbo T28CP45TN89, which I found inside of a
handheld thermal camera. The panel is based on the st7789v controller. All
information is based on reverse engineering.

The series conflicts with [0] ("Add timing override to sitronix,st7789v").
I can rebase, but did not want to delay getting some review feedback :)

[0] https://lore.kernel.org/all/20230314115644.3775169-1-gerald.loacker@wolfvision.net/

-- Sebastian

Sebastian Reichel (7):
  dt-bindings: vendor-prefixes: add Inanbo
  dt-bindings: display: st7789v: add Inanbo T28CP45TN89
  drm/panel: sitronix-st7789v: add SPI ID table
  drm/panel: sitronix-st7789v: remove unused constants
  drm/panel: sitronix-st7789v: make reset GPIO optional
  drm/panel: sitronix-st7789v: prepare for additional panels
  drm/panel: sitronix-st7789v: add Inanbo T28CP45TN89 support

 .../display/panel/sitronix,st7789v.yaml       |   5 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../gpu/drm/panel/panel-sitronix-st7789v.c    | 251 +++++++++++++++---
 3 files changed, 213 insertions(+), 45 deletions(-)

-- 
2.39.2

