Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138BB6028DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJRJ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiJRJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:56:18 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC9B1B8F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:56:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9564824000A;
        Tue, 18 Oct 2022 09:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666086975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bDvagrwwNd40Q5o2uBnuXvgnDyFVN7WFGLk79IsNyow=;
        b=eZIaR+c78n6KsifSckfRH4rwD4d0b+KCLHb/yfY8+PksaYWiUcILVTgx9XTor5nUpAuXHl
        VRXbyhvLNVRGoZQXx420PSUTdseIYg4Oeo45BPSae9eP2+EjjjcvGrWU86iID/fXiZULOo
        I8Tye6YNbh6cAIduUStxSQzIXfpwyQrOaib1Ug2UaSBxr6E4YBC8HIHQ7RyZrTq5AOiTOY
        unV4QnsByGK59ImWw3Vkto9YfYbrfI368DCas2mQhoN+T4x30e0dgFP5KXDbAitftr08sJ
        +NeRjn52vEg97z66BL4jW27TRRZM0/0EGif9oHDQr2IBX4JbXcj1yRnT4b5g9A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ray Zhang <sgzhang@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mtd: mtdoops: panic caused mtdoops to call mtdoops_erase function immediately
Date:   Tue, 18 Oct 2022 11:56:13 +0200
Message-Id: <20221018095613.543231-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010045549.2221965-4-sgzhang@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ade5011442eb7a9fa16e548341230b326cf11a86'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-10 at 04:55:49 UTC, Ray Zhang wrote:
> The panic function disables the local interrupts, preemption, and all
> other processors. When the invoked mtdoops needs to erase a used page,
> calling schedule_work() to do it will not work. Instead, just call
> mtdoops_erase function immediately.
> 
> Tested:
> ~# echo c > /proc/sysrq-trigger
> [  171.654759] sysrq: Trigger a crash
> [  171.658325] Kernel panic - not syncing: sysrq triggered crash
> ......
> [  172.406423] mtdoops: not ready 34, 35 (erase immediately)
> [  172.432285] mtdoops: ready 34, 35
> [  172.435633] Rebooting in 10 seconds..
> 
> Signed-off-by: Ray Zhang <sgzhang@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
