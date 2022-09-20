Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E75BE04D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiITIfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiITIeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:34:07 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E33CBD2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:34:05 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9E518240007;
        Tue, 20 Sep 2022 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663662844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNmwjDF5unVTDM5UNxn46u02tM2QIwMVA3Xc9fWBzGI=;
        b=JMBAYRZNq/7zM773ZaWmKWjTBgSbSfBfFZdMWXxN73Z0f0rg/qC/IZHCjmCXw2zJJwOZ1h
        G/uS3qFYS7vNiSAxaJqp/fpwVkG5dwXhsfGcJ6G64N9XmvJZqFZk/BOPBoOr6MCMIq97P3
        Mq7jBJ09pw6Uashme6UX0Li9Thx7vUe2Z7/Mau/PxDGwFOnKlKmuFTfn5lNVVE/HPMAuKA
        KzyzKqMPk8HDM8EQJ3Gm5ptHHh6Ptuq9hTlx3unKJf994bw6+fcxXOpTaWQ4Xu0Yesld1N
        KdBl09ApWOX7ZX3sNFNlYdWF7NGSFRAwHEXcpKaYq5QaXkPEb16L489xKC7lHg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jack Wang <jinpu.wang@ionos.com>, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 05/19] mtd: rawnand: marvell: Fix error handle regarding dma_map_sg
Date:   Tue, 20 Sep 2022 10:34:02 +0200
Message-Id: <20220920083402.601149-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-6-jinpu.wang@ionos.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'168f05327687e9d9b8345204dd97fdb0480f99a3'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 06:07:47 UTC, Jack Wang wrote:
> dma_map_sg return 0 on error, in case of error return -EIO,
> also add the dma_unmap_sg as rollback on the following error.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Christophe Kerello <christophe.kerello@foss.st.com>
> Cc: Cai Huoqing <cai.huoqing@linux.dev>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
