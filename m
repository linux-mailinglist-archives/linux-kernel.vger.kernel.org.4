Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0E66A6E1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjAMXRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjAMXRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:17:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D769F8790E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:17:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bj3so20651372pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdsIIIWmnrAMixIISBlpoonATCB8KyPznTYLn8925xQ=;
        b=mGBAczYsAJy+adnMAbHNwiVeIccSgtfej3hYXu4t8vQ5cWwvI+KY4cabHxROgQCJF8
         /Tv507b65r8jcUIdMQG2W/X0ixqBcO18jVkVskcAHN269V3viF5D4/IogE/F44xFkb/5
         w27pIKt0QRZPNLsnhhipTjrNF+7HKtD7SbWMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdsIIIWmnrAMixIISBlpoonATCB8KyPznTYLn8925xQ=;
        b=H/eyzw/5syahG2vh7rfpYrYWfeQky3A52eja86z5YI1rGSNFgSaAr80vax1sa8A2MS
         5jRYvk9O3TSFtF6B3/X2ST2LIFfBfebHEVCvnTgq5zU4MPM5qXnlo0XpKPCQbVz1Hjmz
         SHgZAGTkQCMFRfAKRI9bVD9YGKRsLxUEfTccXdTNiN3lK29Ox9n5DRw/nw9t9fSq1Umo
         iwgzEmeU+bBofXex6iqFtpRWMwXg7mxFYdqQjMfcjnEIYRnl/1y1E3NYy7pDd+SZrC71
         OkJRaVrc1ViImJuXDtvqesILACvQDjm7UN332HMHWdEpYU+vQ03GFQots+8k9U/E7Kcy
         7Y1Q==
X-Gm-Message-State: AFqh2kr14H19xlSMIpm9xvQLa4czIgLJ0eQaGgGOIUZAf5weqYWLoOu9
        H9ovtbsZH1FSiDT6z5+M4OosvQ==
X-Google-Smtp-Source: AMrXdXtPUWlNOIlj3oFIw0xfjxn2p+cM+dcDInfA4JSp4huBKlOyhN6ncFOKTB5hYLOeV0bGVtSSFg==
X-Received: by 2002:a17:902:bcc5:b0:192:ce7c:dc40 with SMTP id o5-20020a170902bcc500b00192ce7cdc40mr43176867pls.4.1673651832393;
        Fri, 13 Jan 2023 15:17:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001928d49bf84sm14616620plb.191.2023.01.13.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:17:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     palmer@rivosinc.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux@rivosinc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Fix build for upcoming GCC release
Date:   Fri, 13 Jan 2023 15:17:08 -0800
Message-Id: <167365182646.590977.1702710920825091992.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113173033.4380-1-palmer@rivosinc.com>
References: <20230113173033.4380-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 09:30:33 -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The upcoming GCC release has refactored the gimple plugin interface a
> bit and unless gimple-iterator.h is included before gimple-fold.h I end
> up with a bunch of missing declarations when building the stack
> protector plugin.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: Fix build for upcoming GCC release
      https://git.kernel.org/kees/c/6d778f2045c7

-- 
Kees Cook

