Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54E3729E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbjFIP0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbjFIPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:25:33 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB23AA5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:25:19 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686324318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=306gdX49aWRqWTeObBTGrv9siCZ4NYBUNF2h3Edi8a8=;
        b=UW5B1xcsQjBCPoDeLLyWxC/PK78c8UNY3/pR7Lq6fvrSlAA1M6p7iVb9brGZDl4kM5vlc6
        CKJVV5euqlCbTF/RWIk1+XIG2z4PeA9MFVbmnvxYBpUdaQH3RmipHWEB3ApsOd14/7QMpS
        SQx7r7iHAvkYi9w9ui2ax8ZO0+AVwYYBYFl6bx0l6s52Cwwgv9AFLLJTah8FBdgrpiPd73
        rLvCSDOV+wkTqm1g7+1Qa7TDK66Wl1jngMmudthHZcJPgCMNnRyUyqjbvEhuIGMoITcvei
        IglIZRZaFX/AIddA+kAA5XPzPN3pU+E3/OYAaOChHi+aNlGJ6R8fs1LOSI7FfQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D671FFF80D;
        Fri,  9 Jun 2023 15:25:17 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH] Revert "mtd: rawnand: arasan: Prevent an unsupported configuration"
Date:   Fri,  9 Jun 2023 17:25:17 +0200
Message-Id: <20230609152517.1187095-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607053936.14306-1-amit.kumar-mahapatra@amd.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'21962132044653f42ff8bbb37127c2557d6c39c2'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-07 at 05:39:36 UTC, Amit Kumar Mahapatra wrote:
> This reverts commit fc9e18f9e987ad46722dad53adab1c12148c213c.
> 
> This patch was a work around to fix timeout issue while operating in NVDDR
> mode with software ECC engine. This patch prevents the Arasan NAND driver
> from operating in NVDDR mode with software ECC engine resulting in a
> significant performance degradation with SW-ECC.
> 'commit 7499bfeedb47 ("mtd: rawnand: arasan: Update NAND bus clock instead
> of system clock")' and 'commit e16eceea863b ("mtd: rawnand: arasan: Fix
> clock rate in NV-DDR")'
> fixes the timeout issue in NVDDR mode with SW-ECC so, reverting the changes
> as this work around is no longer required.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
