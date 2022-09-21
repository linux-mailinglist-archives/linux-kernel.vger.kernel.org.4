Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366015BF986
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIUIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiIUIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:41:09 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAF489816
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:41:03 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AC06560005;
        Wed, 21 Sep 2022 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663749662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FYPd921wCb3Hw0Gw1AMiPwfquvJ657TAicyT/amlsM=;
        b=V5ajdX3t9nScn5SLkWX2VQarBba4dA3IC5uxkeGCspmBqi23+lPs053yKBZTkjoFKOfEBa
        MDlNEQLrhKtvRhMU5ONaspeUXTRUxgIKH8ELvgc3HgxTfLIEo37Wc0A+/Mw91o071xhWgw
        vCeS8h19IqUhpXQPP+9FksrBRCNFI/pGeq+trVC/VZEka7mLgnX1Iw0icrZ/LQopNBCrWo
        0IOpMi9AnbWH8v/2/Y6DIKfQmsXn4THgNF2cvzb2hzzmoMuDVgtvttWWJyWrecctxjLyU4
        O2nWIkwTloEnDcrc6EELlHOtrFbc8Bff6ZtAAV0tVq4cA6OTJEtbh+eX34PiRQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] mtd: add ECC error accounting for each read request
Date:   Wed, 21 Sep 2022 10:40:57 +0200
Message-Id: <20220921084057.733270-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629125737.14418-4-kernel@kempniu.pl>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'7bea6056927727f98f4efdd338f112f7517f05b5'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-29 at 12:57:36 UTC, =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= wrote:
> Extend struct mtd_req_stats with two new fields holding the number of
> corrected bitflips and uncorrectable errors detected during a read
> operation.  This is a prerequisite for ultimately passing those counters
> to user space, where they can be useful to applications for making
> better-informed choices about moving data around.
> 
> Unlike 'max_bitflips' (which is set - in a common code path - to the
> return value of a function called while the MTD device's mutex is held),
> these counters have to be maintained in each MTD driver which defines
> the '_read_oob' callback because the statistics need to be calculated
> while the MTD device's mutex is held.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
