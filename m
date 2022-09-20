Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4D5BDFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiITIT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiITITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:08 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A065803
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:15:50 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 62124200010;
        Tue, 20 Sep 2022 08:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVLy22muNBEbzcIbHIu1IOkDAC7wNvhUFUf+W0Hkpoo=;
        b=ZP9Xgwf9F1ZvG8cr4gEN9kc8KMHfsjkM6tHa3vZb0ElkPAlFFJ3Z7PofV6bz6KxvveYbkH
        dRaixZL++53s5IMFW/9aCWmP90lndia4xK3BRFXG79qiVKxBw1XyWyUkrrvnw5wahHshRO
        O0ssuFyYguQD8pFkpg9DKCmRx/mdogzDkmnWaFP6ecpPHoPQ4gX7tDwoCzq1MSaV71J4+E
        wE8OyUjCubzW0RIPrliSCRZYeUmyX9WEajciMC31GDjmq0lAwT6s34QSnWTVpm/icLqAy4
        vyWgtQw9hsOfklIEoTDQi8eehLvXV8GOY8WJt5O0AuMizrb45gh1Lvc88yYfaA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fsl_elbc: Fix none ECC mode
Date:   Tue, 20 Sep 2022 10:15:46 +0200
Message-Id: <20220920081547.597617-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707184328.3845-1-pali@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'049e43b9fd8fd2966940485da163d67e96ee3fea'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-07 at 18:43:28 UTC, =?utf-8?q?Pali_Roh=C3=A1r?= wrote:
> Commit f6424c22aa36 ("mtd: rawnand: fsl_elbc: Make SW ECC work") added
> support for specifying ECC mode via DTS and skipping autodetection.
> 
> But it broke explicit specification of HW ECC mode in DTS as correct
> settings for HW ECC mode are applied only when NONE mode or nothing was
> specified in DTS file.
> 
> Also it started aliasing NONE mode to be same as when ECC mode was not
> specified and disallowed usage of ON_DIE mode.
> 
> Fix all these issues. Use autodetection of ECC mode only in case when mode
> was really not specified in DTS file by checking that ecc value is invalid.
> Set HW ECC settings either when HW ECC was specified in DTS or it was
> autodetected. And do not fail when ON_DIE mode is set.
> 
> Fixes: f6424c22aa36 ("mtd: rawnand: fsl_elbc: Make SW ECC work")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
