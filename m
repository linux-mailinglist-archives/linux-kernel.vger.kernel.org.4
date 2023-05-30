Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB486716F80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjE3VPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjE3VPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:15:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5C610A;
        Tue, 30 May 2023 14:14:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af28303127so53953691fa.3;
        Tue, 30 May 2023 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685481289; x=1688073289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0LSy01sHYJxxE1AtLBRvzTpCz53ru09V7VWEP7uwk4=;
        b=K4d2Gj571V9Oj5Ks2nntTsiNLnvBnGq+TzlAeA3dlE/xsyZ73kAYMHnDJUfPG1MJDh
         m8mfwNKj2iryPqEiWHPo53ZW7CwrxOFiz2f50GDdIlXyidKvhoubKGe9Wc/V4kcvDREj
         LkSnjnWC9IIt37iMWxh3kgS3WROw/6zjBxvgHk8juxKbBB+rm5kkBuBchA1ZiRHOcRmY
         AXlvWK1rR9mRuSa3p+ktxQeFLkEUywuP1WpnCd0OY5H3tkeQdJhhI4KLSnWmyqQo1fWK
         jyhGC4CM3V+JnCXpP4bFyEhUALScSQbpAamPgIw4Bo3IvXRWNXstYkHwSIhHcfaytft0
         2iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685481289; x=1688073289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0LSy01sHYJxxE1AtLBRvzTpCz53ru09V7VWEP7uwk4=;
        b=jvq4rupuywynB1aH71S1tJMFgEobNCIQOBuMfpbKbxe9h3OrByUzByVpRXnor840yu
         ds71fw+mSZJSu9DwA2uWAG9GiQrgzBEn8KV5ll/n0SZt84fR5/I5t3PMDGh9VBQ/Els7
         Lo3sEI7t32jl01/cICI+xMB/wXz7o4SDrESJubXVcJJZuvCwBi0jAXPpzKv7Gi4frK2Q
         zm3gvHPGisQscjfVTOtTMlV9U1izDYxsVwDV19ueQaHxsHv+jkYXpKc+rOjBvJx6drzR
         IMNU5fNHBtw5N8zdQN/E5RpiLurYzlitTmctV8+9HNtkSFE5mnbhmZ+fbDZ01PMwaoUX
         j5TQ==
X-Gm-Message-State: AC+VfDwTX/t8SPOvN6ekW3mKDSbZYWCNiuwCED8UcVlVkPTT5cUWcqq/
        oy6Ag3vi22jNBe8lfo70qUw=
X-Google-Smtp-Source: ACHHUZ7oFYuV7HABQib1VVR2z87xxqeEv6HUPYqQW5XLO8UlcksIUV2fzSUlgEr8omI7ODTYxRDXCg==
X-Received: by 2002:a2e:8716:0:b0:2a8:b27f:b721 with SMTP id m22-20020a2e8716000000b002a8b27fb721mr1460220lji.29.1685481288819;
        Tue, 30 May 2023 14:14:48 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id o20-20020a2e90d4000000b002aecfa8c58bsm3004716ljg.40.2023.05.30.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:14:48 -0700 (PDT)
Date:   Wed, 31 May 2023 00:14:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Osama Muhammad <osmtendev@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi-dw-core.c: Fix error checking for
 debugfs_create_dir
Message-ID: <20230530211446.foqpcfha6hjruhow@mobilestation>
References: <20230520224025.14928-1-osmtendev@gmail.com>
 <168546845148.691057.9965315836245052581.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168546845148.691057.9965315836245052581.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, May 30, 2023 at 06:40:51PM +0100, Mark Brown wrote:
> On Sun, 21 May 2023 03:40:25 +0500, Osama Muhammad wrote:
> > This patch fixes the error checking in spi-dw-core.c in
> > debugfs_create_dir. The DebugFS kernel API is developed in
> > a way that the caller can safely ignore the errors that
> > occur during the creation of DebugFS nodes.
> > 
> > 
> 

> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi-dw-core.c: Fix error checking for debugfs_create_dir
>       commit: 0178f1e5d9845a31024eddd37e93a182e2dbab5d

Oh, thanks. I've absolutely missed the respinned version of the patch
(it should have been marked as v2 though). Anyway the change looks
good except it introduces a redundant empty line at the tail of the
dw_spi_debugfs_init() function. Is it possible to rebase the branch
and drop the line it? If it's not I'll send an incremental cleanup
patch then.

-Serge(y)

> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
