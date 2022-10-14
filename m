Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64045FF311
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJNRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJNRlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:41:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5BB1D2B49
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:41:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i6so5362736pli.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOC+xHYuX6W+KOmshd4JSnFJlOTjVCLIEXgKnl4k+4s=;
        b=hfaIipO/baHMJMPjFiSvwJFoBsNlcO1imRprhRVa7QG+jN8mhguoc6G4DG4wB+FyTd
         kspUH/mm6cpWWj7j83zuBHwZe0bOPWVDWg5+wbxW4O/hnfceEjYL4Z+aJ57eLv3nsEqq
         msVKp8ghsd/F4ElVvP3pbleCypsye39cna6AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOC+xHYuX6W+KOmshd4JSnFJlOTjVCLIEXgKnl4k+4s=;
        b=MyvS2Eel9mRXYx+xHwWTDbrFxzz1bCj31lPrNM1vkXi5sn9Yaqa6MfPkTDKRgGJwNK
         9lnDSrNBbJfoCbE0msc4RnyzdepZ3hSN3YTSTjVyBhEPsd/N6/wbW+8j49BSaRzQfOCH
         QnsE+dDotVqwNxHGP6A7z2kf51Y+abpuGseKSr3hNOfbP/GuH0ftuTXLcAQn7/SaVyi4
         mvNsAyHOUYeuiZyFBkQwbBtgTeknBSLNX7AGEOxrbYIF/JOxh90+6j8YmoWWjbhq4gMO
         neCr6hOybWQP8MilrV30lAEr1HP6ItTVKN4iojuzcmoKNlIiMPLbSIe29pctW5TcC7aZ
         m1Og==
X-Gm-Message-State: ACrzQf1yDUWaJAY7qCLQ+aAUYK4pBJMCWFUleJ40o9I6QoT9CpV/pebD
        0zpgBb9nDz2twT7GHlr2T1yYlQ==
X-Google-Smtp-Source: AMsMyM7roIaugHYLE6W6vheoOGrg5XP+nuDFFDbA/DUCTMRLryn3cHjOCRGpJVSwCUxn6QaGKf6GNg==
X-Received: by 2002:a17:902:8215:b0:178:6946:a282 with SMTP id x21-20020a170902821500b001786946a282mr6548332pln.162.1665769273658;
        Fri, 14 Oct 2022 10:41:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r10-20020aa7988a000000b0054cd16c9f6bsm1976110pfl.200.2022.10.14.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:41:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     gpiccoli@igalia.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, ardb@kernel.org,
        linux-efi@vger.kernel.org, anton@enomsg.org,
        Tony Luck <tony.luck@intel.com>, ccross@android.com,
        kernel-dev@igalia.com, kernel@gpiccoli.net
Subject: Re: (subset) [PATCH 7/8] efi: pstore: Follow convention for the efi-pstore backend name
Date:   Fri, 14 Oct 2022 10:41:04 -0700
Message-Id: <166576925933.1456464.15444113469951956884.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006224212.569555-8-gpiccoli@igalia.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-8-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 19:42:11 -0300, Guilherme G. Piccoli wrote:
> For some reason, the efi-pstore backend name (exposed through the
> pstore infrastructure) is hardcoded as "efi", whereas all the other
> backends follow a kind of convention in using the module name.
> 
> Let's do it here as well, to make user's life easier (they might
> use this info for unloading the module backend, for example).
> 
> [...]

Applied to for-next/pstore, thanks!

[7/8] efi: pstore: Follow convention for the efi-pstore backend name
      https://git.kernel.org/kees/c/39bae0ee0656

-- 
Kees Cook

