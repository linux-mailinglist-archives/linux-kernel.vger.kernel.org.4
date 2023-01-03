Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AEE65C462
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjACQ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjACQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:59:04 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C08C5B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mxDcbg9196yYDc4/nWFTQPBwp/sgfGLK/oSLrLpBDOI=; b=IGa6eXA7tCe5Q+39nOMcg2hp9j
        4h0v2Z7M8Mpuh9jI+Ejhhzs5tTmuKOzwNU1pgJeCWtPpKJUC11fh5Jn/5YjdIqlF1X4dAsmABcdBY
        MpQKu7kITSU1HkF5iWgjJ0zJXfNMOWQnbXAljM+4YTtBsj+6cfvRofi7JwpK7JVufP2IXy54ZFps2
        oCq7DKnsX0WInHFkNpp44YFq66VL+O8EvUcHb3wHLDuIKE5NCKyhaJKQ5XV1rmhpkQwjtSbj5WTT1
        0SxDD+BuMHZHgDiE/r35nHQzsT95s346bZGQ+zCfkE3twtviIVlsXz0axlp2v4CId1TuMYNeyqdUt
        3EkVJl7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35948)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pCkcr-0005bj-B9; Tue, 03 Jan 2023 16:58:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pCkcn-0002GF-DC; Tue, 03 Jan 2023 16:58:53 +0000
Date:   Tue, 3 Jan 2023 16:58:53 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v3 0/5] Fix a whole host of nvmem registration/cleanup issues
Message-ID: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series fixes a whole host of nvmem registration/error cleanup
issues that have been identified by both Hector and myself. It is a
substantial rework of my original patch fixing the first problem.

The first most obvious problem is the race between nvmem registration
and use, which leads to sporadic failures of drivers to probe at boot
time.

While fixing this, it has been noticed that a recent fix to check the
return value of dev_set_name() introduced a new bug where wp_gpio was
not being put in that newly introduced error path.

Then there's a fix for a previous fix which itself purports to fix
another bug, but results in the allocated ID being leaked. Fix for a
fix for a fix is not good!

Then there's an error in the docbook documentation for wp_gpio (it's
listed as wp-gpio instead) but as nothing seems to set wp_gpio, we
might as well get rid of it - which also solves the issue that we
call gpiod_put() on this whether we own it or not.

Lastly, there's a fix for yet another spurious white-space in this
code, one of what seems to be a long history of past white-space
fixes.

These patches have been individually build-tested in the order of
posting, but not run-time tested except for the entire series.

 drivers/nvmem/core.c           | 51 ++++++++++++++++++------------------------
 include/linux/nvmem-provider.h |  2 --
 2 files changed, 22 insertions(+), 31 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
