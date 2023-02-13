Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4941E693D58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBMEP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBMEPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:15:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649CC9EC7;
        Sun, 12 Feb 2023 20:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uc5eX4dFFg74AyHfpZSyTpfc51uu3xIC4eapilJHTQU=; b=uwwH3jyQkKxjt1bK0QJr3Nf6ur
        etHQoHk294FI9CDkUXqquano90BjVr1BKrEQVwmx5CohBcG8VMkrC9OrF2kDnzd1Xe7W5c6s+R/S6
        CDxyuwOLXyKK5P4wlmgY/al3W1aZ2rF0LZSkgCA1okE1Wi2ZQcXM0q0EjhELz4XZaLbymVh+/BQbv
        GPhya0ZVNr9OPHK2qUcKvi+5DSX5Mktjewp4Kd6P/yrCUyxUG2BzzKwUodmBwiAj/Tu3QjVattSxJ
        +bpHcvG84BmfAaWyIQpWYolvVtGFiL8mHnp1+dp0mtXwUhkOW5umccj5BzSJenPExO1HfDQqhLWk+
        tJt8rXEg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRQFf-00D56G-2j; Mon, 13 Feb 2023 04:15:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Donggeun Kim <dg77.kim@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] IRQ_DOMAIN: remove all "depends on", use only "select"
Date:   Sun, 12 Feb 2023 20:15:32 -0800
Message-Id: <20230213041535.12083-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
it directly thru "make *config", so drivers should select it instead
of depending on it if they need it.
Relying on it being set for a dependency is risky.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

IRQ_DOMAIN is selected 109 times and is depended on 3 times in
current linux-next. Eliminate the uses of "depends on" by
converting them to "select".

 [PATCH 1/3] extcon: max8997: select IRQ_DOMAIN instead of depending on it
 [PATCH 2/3] of: OF_IRQ: select IRQ_DOMAIN instead of depending on it
 [PATCH 3/3] rtc: mt6397: select IRQ_DOMAIN instead of depending on it

diffstat:
 drivers/extcon/Kconfig |    3 ++-
 drivers/of/Kconfig     |    3 ++-
 drivers/rtc/Kconfig    |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Donggeun Kim <dg77.kim@samsung.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Rosin <peda@axentia.se>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Eddie Huang <eddie.huang@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
