Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA50640F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiLBUwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiLBUwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:52:09 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439ACFF1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:52:04 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id l67so7476080ybl.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 12:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jf8Lci9yWicMcDRvKe2dt66Xmmfz4hAXZFNEga7Q+BE=;
        b=j3EeJQPe8r+7d6LxVmZyEntSQjmYrqZi4ehLar7qrzdbGmQZGvFKMmdcZ3eenY708z
         +nMzbkDQE3KyyTYpfHcxVNAYFEAyZoWHxT45zGgVSkz8LEsCvY6M/YuMhqf9tU2zv2gP
         5dJgKmah0O7gtXzpyYBsZDiUEwbHIxLGz/ozsdCWZ4NH3iW0SXekQ2e0DBK13Cz/4SPe
         BljQhCpkLDqtmusqAC05nzEi31JU4Ecj8ZBnA6mtSU/r9fKN11P70Qz2bGvK7A+ABhpj
         FbCXZ3TXQbI8svTZdKG32sKGPOVfkReOCjcgD4ttXfTg0Cb+JO9mSV3yopgm4fax9Twh
         mcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jf8Lci9yWicMcDRvKe2dt66Xmmfz4hAXZFNEga7Q+BE=;
        b=bG1BGjsNHLeijgCMONbszKvT8T/YxSG6Rbd6C9c9XeNZshhD6d0cNcWaqL3HWakedL
         HEs/dBlWhHvYe1bcULs+PU74koTxyyvKOPPfTmIF3cucFqtCezdMOcJN4G9C+KHIWEiy
         9gN0MDBvP3x40pnPcA2vMWsVxuYXp2CJlYmg/Tq6GSNCS7MWs3ji5daI66fNtPCh3BMQ
         nv/k+4PpCQ1na0qOw/9xLVjosQQjnMJDuYjn9kZtlfGkK4DpOYrkrLjly5VFj5sh3cQu
         j2m3X/H904sEudT6n9SKXAkbDFlpXwp+Pl+51Y8T1qBliBAteEAjk6RuV/SsamvmYVN8
         y1kg==
X-Gm-Message-State: ANoB5pmt1kfgYOgVKXnlue92TMgY7EjqwKmtXto1n2I/SIsCTaVN1Ojp
        9j+z0tjU1RtMm+aEOOVqyRdBYg0ARM2a9MvIkM13ZKyybOdDxyu3
X-Google-Smtp-Source: AA0mqf4SuZ2vonEWXHycBZ/r+Rw35V9WIPRMUQ7hr9R+wS4Q4axRCUBD/W/WcDwoWjiW0VN0dZhn8lJE40wih27quRA=
X-Received: by 2002:a25:1843:0:b0:6dc:b9ec:7c87 with SMTP id
 64-20020a251843000000b006dcb9ec7c87mr52188903yby.322.1670014323445; Fri, 02
 Dec 2022 12:52:03 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Dec 2022 21:51:52 +0100
Message-ID: <CACRpkdZZ7j3fciH+J6xu-MGHyxWMy-VK1MkXsfkHLdyy3=q4RA@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some trickling pin control fixes for v6.1, three driver fixes.
Details in the signed tag. The Intel fix looks like the most
important.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.1-5

for you to fetch changes up to 6989ea4881c8944fbf04378418bb1af63d875ef8:

  pinctrl: intel: Save and restore pins in "direct IRQ" mode
(2022-11-28 21:41:31 +0100)

----------------------------------------------------------------
Pin control fixes for the v6.1 series:

- Fix a potential divide by zero in pinctrl-singe (OMAP
  and HiSilicon)

- Disable IRQs on startup in the Mediatek driver. This
  is a classic, we should be looking out for this more.

- Save and restore pins in "direct IRQ" mode in the Intel
  driver, this works around firmware bugs.

----------------------------------------------------------------
Andy Shevchenko (1):
      pinctrl: intel: Save and restore pins in "direct IRQ" mode

Maxim Korotkov (1):
      pinctrl: single: Fix potential division by zero

Ricardo Ribalda (1):
      pinctrl: meditatek: Startup with the IRQs disabled

 drivers/pinctrl/intel/pinctrl-intel.c | 27 ++++++++++++++++++++++++++-
 drivers/pinctrl/mediatek/mtk-eint.c   |  9 ++++++---
 drivers/pinctrl/pinctrl-single.c      |  2 +-
 3 files changed, 33 insertions(+), 5 deletions(-)
