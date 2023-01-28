Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDED967F9C9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjA1RTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjA1RTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:19:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E5E2C64E;
        Sat, 28 Jan 2023 09:19:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6CC5B803F3;
        Sat, 28 Jan 2023 17:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBECC433EF;
        Sat, 28 Jan 2023 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674926344;
        bh=N0glHYJdj+5T+1YNL1gh0yWBCL6N2qAkW+ZtMHZgb9I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q1SVrzJ8HzYdGRpivt7Yh/fORbR7VNaeZqjKZ/AEEQXYkrLWBhJ47HCqSe5AXesZf
         fvWNpy0b2fRjahz6OoOs0tWVQm98m5dREaiem7cdByPAmLeJW7CPctRfVvRblVBSOR
         KHnbEZ1a82Gf4ntyZThx1METl2GC0EXv+XKsMYYiA4OOIySf+YYSkPql8xZ65bRHmW
         jhzLpyHPBas7Xwg0WmyGKdJ0vjuZfBx4bfBQIIkH9SB7UWyYLGyPbUXAjnJaEyrNAm
         qhYoYdNsfNliyqw8N+Y+h1t6HPVU6rdZMzTj+Wryi0r38qBoLivxLh/D5XgzdgCZtP
         29cbVxXVuCRGA==
From:   Mark Brown <broonie@kernel.org>
To:     Javier Martinez Canillas <javier@dowhile0.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20230127225203.never.864-kees@kernel.org>
References: <20230127225203.never.864-kees@kernel.org>
Subject: Re: [PATCH] regulator: max77802: Bounds check regulator id against
 opmode
Message-Id: <167492634199.2479258.14097870833222078553.b4-ty@kernel.org>
Date:   Sat, 28 Jan 2023 17:19:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 14:52:07 -0800, Kees Cook wrote:
> Explicitly bounds-check the id before accessing the opmode array. Seen
> with GCC 13:
> 
> ../drivers/regulator/max77802-regulator.c: In function 'max77802_enable':
> ../drivers/regulator/max77802-regulator.c:217:29: warning: array subscript [0, 41] is outside array bounds of 'unsigned int[42]' [-Warray-bounds=]
>   217 |         if (max77802->opmode[id] == MAX77802_OFF_PWRREQ)
>       |             ~~~~~~~~~~~~~~~~^~~~
> ../drivers/regulator/max77802-regulator.c:62:22: note: while referencing 'opmode'
>    62 |         unsigned int opmode[MAX77802_REG_MAX];
>       |                      ^~~~~~
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: max77802: Bounds check regulator id against opmode
      commit: 4fd8bcec5fd7c0d586206fa2f42bd67b06cdaa7e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

