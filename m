Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB8750A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjGLOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjGLOOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:14:06 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE781FD8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:14:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22ADB20004;
        Wed, 12 Jul 2023 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96l5dWY2XgZDWnI8IDxHvnBqzk3+/RUBHU+MFz1dRt4=;
        b=PRAbtWrdUq/Mti6nxMq7mDuzDVc+9/2rqLd7Rd8TjhkB2ZXw2JpsondFaCTrKd+RqHXdWf
        iRE+Y495CG5s7LhqSWy3Ef+NM3cK/TMim6ykh9k4cfKW+7Prgno4n6C3ORhqcSheMK+lNg
        guVe0NmQ6VwgI6tk9mRYmLAo2flY/8t5u3bQiu4l2evMkPN0tCrhd2kkfzlYNOWc89b4mF
        xiYlddJhXjqu7QzPhJmTQy9+RqL5vrwix2oy3bLYW4+SzisV0gBuyZEGm1tcQdp2QD27Ab
        XG3dsrac94ptKE0bll3rwwmikNxhdNRh0Q2zCz2HvMQDPfioeiPmgDiD0qSTOg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] mtd: call external _get and _put in right order
Date:   Wed, 12 Jul 2023 16:13:45 +0200
Message-Id: <20230712141345.354928-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620131905.648089-3-alexander.usyskin@intel.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'79c4a56250216991f1d965ee26dcd273376e4e91'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-20 at 13:19:05 UTC, Alexander Usyskin wrote:
> MTD provider provides mtd_info object to mtd subsystem.
> With kref patch the mtd_info object can be alive after
> provider released mtd device.
> Fix calling order in _get and _put functions to allow
> mtd provider to safely alloc and release mtd object.
> 
> Execute:
> 1) call external _get
> 2) get_module
> 3) add internal kref
> in the get function and opposite order in the put one.
> 
> The _put_device callback should be the last in put
> as the master struct memory may be freed in this callback.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
