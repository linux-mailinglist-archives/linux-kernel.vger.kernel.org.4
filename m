Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F2A709451
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjESJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjESJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C1F0;
        Fri, 19 May 2023 02:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD353651D1;
        Fri, 19 May 2023 09:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB74C433EF;
        Fri, 19 May 2023 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684490341;
        bh=taTIMr9jPK+Zd1lo1YW0K1V/3LreLJi90/XQv9VeWNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhipDJV3vV83zOz7U/RIXoYuXntR94cX5UeqHVLKlmLji3xn+RF9nTQjFTqCFIrDY
         8Ak3q+Orf96kdndVtUawZmT2HEGxAno4Tz7T6Yg5gPR4L5VU/A4n7vbFxy+qkIT6Dx
         ibAqhY/1AU0VrfON4S2E85WYod4DGgsoWSnQifcnVk2vn9iqG1RdfU4CLSJ3vQMr5c
         buDcyO99VhH6VFJ/Ttuj3HWB62sRJWiEXUEdSSYy5QMOiHIozXNVHWh6a5X8Ggtvu9
         XJEHj18zLrIFF5EWgpaI2VmN7oWqpUIBlPSSc/bxBU5zb5/LldX21hz8xyXYwYfG89
         m5qDzsiYZ80UQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: remove redundant initialization to pointer cb_sb_start
Date:   Fri, 19 May 2023 11:58:53 +0200
Message-Id: <20230519-simulation-eingibt-65cd144d8b8d@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418153607.3125704-1-colin.i.king@gmail.com>
References: <20230418153607.3125704-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=brauner@kernel.org; h=from:subject:message-id; bh=taTIMr9jPK+Zd1lo1YW0K1V/3LreLJi90/XQv9VeWNg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSkewRMkU171bn2EMNHm8ev/GWS9lx8+V9wyvKffFmqT5+4 P7a73VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARywmMDC8nLfvsqisQmcisuH6rYk GlrM9M+9M87udmtJzjem7//ybD/6SNq2Lt9v68EibBsrI/c7/45tjCqEsbTr1pO5T/PHbpWi4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 16:36:07 +0100, Colin Ian King wrote:
> The pointer cb_sb_start is being initialized with a value that is never
> read, it is being re-assigned the same value later on when it is first
> being used. The initialization is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> fs/ntfs/compress.c:164:6: warning: Value stored to 'cb_sb_start' during its initialization is never read [deadcode.DeadStores]
>         u8 *cb_sb_start = cb;   /* Beginning of the current sb in the cb. */
> 
> [...]

Applied to the fs.ntfs branch of the vfs/vfs.git tree.
Patches in the fs.ntfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: fs.ntfs

[1/1] ntfs: remove redundant initialization to pointer cb_sb_start
      https://git.kernel.org/vfs/vfs/c/04faa6cfd449
