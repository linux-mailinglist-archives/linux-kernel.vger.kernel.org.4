Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64F870E0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbjEWPiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjEWPiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:38:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B3F126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:38:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d41763796so3006201b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684856302; x=1687448302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR0dClC/d+MQcOf8g2mW8T91GJrph6HVrLee0aiV96w=;
        b=LyiBqILX2ALOpawo1JADiBzbkQMbqYrhK1WVX8smq+rsbol1joXwejEreNcS3Aykb9
         /NFE1UBL34nFOBh74G0plHhdhsZO3DdJ01YYfsiR2Y9neonNG84zgwns/X5m6Qatsmj+
         J161Cpqx8aUA4t2Qq1Rmob83LMgTKPKhDq1y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684856302; x=1687448302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR0dClC/d+MQcOf8g2mW8T91GJrph6HVrLee0aiV96w=;
        b=HgOWQsWSrpXGwztCgQFt/kJXdZmAj5ngcwp7w/todPmSztzQyXPmu5tT7v1GB8gEeO
         eV0c8GpItjdt2g6WyXlOYo1olBM19lHTUl8DYFCAZRwJqniZtlAVA+qFlJHCIzgEAdz1
         5cZu4w0LQzk5gWyhW7dVOCIOnbypSj1vmXysyS3VcTOT7Pl/JPf/2Sb4LoookT8rniza
         IJ/Ytvz9wU2UwW4kKmPQITdPNLvPrGMmLCE72I//CUJ0Wz+Bfyx8kJLqNDhBlf79aNw5
         RMt6XOjVmPzndmD9svl9vlmpbPSGxmrKGgVMy27hpaZRw1jDt7ie2TCTIL7dnKzTy7sa
         iBsw==
X-Gm-Message-State: AC+VfDzZ5yRSwZm2iqZ8JzTQoMLeRDqPVC43HqVLNZGGFiLgWrlZqv2K
        iZwBroxn2n9NHa6XVNkcHs5cvHTHJwwHfgmot90=
X-Google-Smtp-Source: ACHHUZ5nj04X9vqt3U2JkgmkmWQBERjwfGP9voC7PJxlkV0JoVUphRvymaL5vxY83sDAi2OUNtvFUQ==
X-Received: by 2002:a05:6a00:1389:b0:643:b27f:6c43 with SMTP id t9-20020a056a00138900b00643b27f6c43mr21447531pfg.27.1684856301749;
        Tue, 23 May 2023 08:38:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r25-20020a62e419000000b0062d859a33d1sm5940378pfh.84.2023.05.23.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:38:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, salah.triki@gmail.com,
        Kees Cook <keescook@chromium.org>, luisbg@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] befs: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 08:38:18 -0700
Message-Id: <168485629566.2163955.5364737954441737976.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509014136.2095900-1-azeemshaikh38@gmail.com>
References: <20230509014136.2095900-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 01:41:36 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated.
> In an effort to remove strlcpy() completely, replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] befs: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/35ba10a47326

-- 
Kees Cook

