Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A3693726
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBLMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 07:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBLMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 07:08:46 -0500
X-Greylist: delayed 67838 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Feb 2023 04:08:44 PST
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FEBE383
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 04:08:44 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PF5pw3TBgz9scG;
        Sun, 12 Feb 2023 13:08:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1676203720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B05YiRdcBvqwty9QnLiifB3HgSAbyHH2GODfXEZv2EU=;
        b=m1IKBXwAOloKJlMLqn1MZ2drjnzx7aW1qLDobF2YqHSayxCXKqvmDggepbmQnUHU1usHRY
        S8cA83BxKPocqm/AC9ieyvQhp4jhseieIkWesUxZH1n1CU0sTHm/4KgoJU5DZDmOW4OPau
        sQClzbUOh+0jvd8K6KVX//kZ9XzKoJ35etaYTZ9YZQ9w8hBO8z7PN7ZgqN7oPBcGeSP50w
        AZs3XugU72UaWrgglpIIDdJGIBvEe8OIubdouPktbUmTbIaQ+UqzemhjrMDCoJnDwsFvPM
        MXTB/0KN+BDHkJye/w65tGS2APbI9ODMWC5B1Ag7G83pW/IFNwjlUSzLWJndxg==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Frank Oltmanns <frank@oltmanns.dev>
Subject: [PATCH 0/1] drm/panel: st7703: Fix resume of XBD599 panel
Date:   Sun, 12 Feb 2023 13:08:28 +0100
Message-Id: <20230212120830.46880-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes flickering after resume from sleep on panel
xingbangda,xbd599 (e.g. used in PinePhone).

It was originally submitted by Ondrej Jirman in July 2020:
https://lore.kernel.org/all/20200716123753.3552425-1-megous@megous.com/

The original patchset contained two patches. This submission fixes the
patch that broke handling of the JH057N panel of the Purism Librem 5.

In essence, it does not change any behavior towards the JH057N panel,
but only affects the XDB599.

The patch is just a refactoring of Ondřej's original patch, that is
already used today by PinePhone distributions like PostmarketOS.

I was torn between using function pointers and just calling msleep()
with device specific delays. I decided to go with function pointers,
because my understanding is that calling msleep(0), which would be
required for waiting for the JH057N display to discharge, still results
in a delay. The empty function I used has no side effect on that panel.

The patch is based on drm-next.

Ondřej, since this is just a refactoring, I would gladly add your SoB,
if you wish so.

Thanks,
  Frank

Frank Oltmanns (1):
  drm/panel: st7703: Fix resume of XBD599 panel

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 40 ++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

-- 
2.39.1

