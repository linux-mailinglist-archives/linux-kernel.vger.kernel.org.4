Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549486A4A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjB0S70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjB0S7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:59:20 -0500
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B15A5C8;
        Mon, 27 Feb 2023 10:59:17 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id E211DC800A7;
        Mon, 27 Feb 2023 19:59:12 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1677524352; x=1679338753; bh=nBz34ACq5CJwHJFmAsB91rfv
        +TmJgEQphaitfGtZ8/0=; b=u5xxWT2Zj5wdqi8DJ+iRwtx2zv2zEwCkOfRlMgus
        shety8ctq5XsWNgCQrb3X7g+YGvv8Cbvb3upoz02G7koM2/nCwgQcwMTwAoity+Z
        Utx1DKRAKV1qyCWkmwZO/TfMDru91YPtmb4vLYdFQcD3qkjLlDuLZ/d0wkkErJKl
        VRI=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id LJE1ZUQxhYE4; Mon, 27 Feb 2023 19:59:12 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 3D08DC800A1;
        Mon, 27 Feb 2023 19:59:12 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, wse@tuxedocomputers.com,
        swboyd@chromium.org, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, wsa+renesas@sang-engineering.com,
        tiwai@suse.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix "Input: i8042 - add TUXEDO devices to i8042 quirk tables for partial fix"
Date:   Mon, 27 Feb 2023 19:59:05 +0100
Message-Id: <20230227185907.569154-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of
https://lore.kernel.org/linux-input/20220708161005.1251929-3-wse@tuxedocomputers.com/

That fix did fix the keyboard not responding at all sometimes after resume,
but at the price of it being laggy for some time after boot. Additionally
setting atkbd.reset removes that lag.

This patch comes in 2 parts: The first one adds a quirk to atkbd to set
atkbd.reset and the second one then applies that and the i8042 quirks to
the affected devices.


