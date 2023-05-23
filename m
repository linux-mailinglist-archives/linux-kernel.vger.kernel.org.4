Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9070DDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjEWNni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjEWNnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:43:31 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7584F1A4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:43:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 002DA1BF203;
        Tue, 23 May 2023 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684849402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2LQ6U7bjWKvWknnaoUpccfU/te8/XY9Jc2ToqZSvqw=;
        b=mDOdn4Hjb+Gl3VrHcG+zat4FkwgxrDaqJF6XmMdf38Q6nUurZl9MUZGFJ5kTuX64EjIvoX
        xK6LxJFdIw9UPQQMVH96OIFXO2+u5DaaHW/6a+FVa18gBdpfTlhXKjc6Z/0hyMgdwII24v
        S6dd1crJstW6m3bWlrjiiWenLyCuNkkTXfOOjEgbRUg6dVI4RdorZR90jpFcpSXxJnXsRk
        Oqx9stbX9Lh8knzKmdsU3CyHvXqCQPFbc14QL2Y/gkeGCmeOpQTTkEEA5DK4dzUHaGmrHv
        kd7VgJwCMsW658+XKn7k7Cg6mxEFBp3rR3ZiMuR/lSRq+I3v4OTQl4C42zOFyA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: mark bits of ioctl handler noinline
Date:   Tue, 23 May 2023 15:43:19 +0200
Message-Id: <20230523134319.319149-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417205654.1982368-1-arnd@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'637ae8f2560b3c524788c491a81ded4d021d3f39'
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

On Mon, 2023-04-17 at 20:56:50 UTC, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The addition of the mtdchar_read_ioctl() function caused the stack usage
> of mtdchar_ioctl() to grow beyond the warning limit on 32-bit architectures
> with gcc-13:
> 
> drivers/mtd/mtdchar.c: In function 'mtdchar_ioctl':
> drivers/mtd/mtdchar.c:1229:1: error: the frame size of 1488 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Mark both the read and write portions as noinline_for_stack to ensure
> they don't get inlined and use separate stack slots to reduce the
> maximum usage, both in the mtdchar_ioctl() and combined with any
> of its callees.
> 
> Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Richard Weinberger <richard@nod.at>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
