Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681C5713B89
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 20:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjE1SRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE1SRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 14:17:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2ECA8;
        Sun, 28 May 2023 11:17:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso16813395e9.0;
        Sun, 28 May 2023 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685297865; x=1687889865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWG6nB2NgjGQQddfrL4CH/8guhB7MB2C+knV5je6m/g=;
        b=H6aS80i4wnhyB+doX5BIrcf1n3ZOU4YkJ8NEt2a4aGkhZNVb+EtoS549BJfxKIOQVW
         pCLZQJ7fQms2PDgYuOxMFPRcxfnUfzhnQ44x79D4eQOlXFEfp9uzDfxMLAJScpnZA113
         2s+JpNAYIQbJjdQFrMdI5cMtUnCx6dj+8DG1RTDVkGWJoq2aNVUlnle+10t2HXWLqQfQ
         n/5hu5ivDBiwKxfRYFmK99LER3pV4e0WjBZyDxcbBYTfCajbMgCBvnzzYKcc6o+Pjv5o
         6MmY1pIsO5AkMQn24l4Lrd8RF3TY6WqYuKxIrukpfPmJ6soRsZsRgLuLLtkDFZOSba68
         H/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685297865; x=1687889865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWG6nB2NgjGQQddfrL4CH/8guhB7MB2C+knV5je6m/g=;
        b=BJtczxYYJvJkMtAu3uCbIMbLcPmSnUayab7lWn3Ld2l7PZm1nAm8MVmJGmknil/qVW
         32MOOKBu1H6cPgtEwfdtBH+eTYenypTLoY2QfqsunY+GE2Pgm3or+aE65/Qr8RWLmHpm
         2jkwxPOHnaC0KqTO1oq8Ofx4T1eEj6nshvM1cH2bt1Aezdo+m5B+8Qp6MjTaKHrNI8+U
         NlZ7lYCvE1Elofb1YlTZRp/O/LQWdMyyoUBZGlCWxNNqP8p7fiYlCxnk/X+IoheZyELZ
         pOi+sFap6FfwKO62cT5DfPrY9dUoI/z8WD6jErOONfEsgrqfRJAmHzgi+2D/JiEvJcy6
         kDTA==
X-Gm-Message-State: AC+VfDzxRW0doMbvaN8G1YN9gxgcWXDfFU0aJHBsBOn0BP/GcjM5j+cA
        QMyZ2R2LpTaI3Sqe8X2L4+Y=
X-Google-Smtp-Source: ACHHUZ6xsmJ1CrGjsEW0lipHfZD7qf0IW28Al2vz0S6vcIwSb/Z3txBItIb5/e0kirLW8VLEFSE+3g==
X-Received: by 2002:a7b:c4d9:0:b0:3f6:244:55e3 with SMTP id g25-20020a7bc4d9000000b003f6024455e3mr7250659wmk.35.1685297864820;
        Sun, 28 May 2023 11:17:44 -0700 (PDT)
Received: from solport.. (203.red-83-43-24.dynamicip.rima-tde.net. [83.43.24.203])
        by smtp.gmail.com with ESMTPSA id u4-20020a7bc044000000b003f6f6a6e760sm5277502wmc.32.2023.05.28.11.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 11:17:44 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: build error while building arch/x86/purgatory/sha256.o: invalid 'asm': operand is not a condition code [...]
Date:   Sun, 28 May 2023 18:17:37 +0000
Message-Id: <20230528181737.388171-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164031.266590-1-joanbrugueram@gmail.com>
References: <20230528164031.266590-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding `-fstrict-flex-arrays=3` to `PURGATORY_CFLAGS_REMOVE` in
`arch/x86/purgatory/Makefile` fixes the build, through I don't know if
that's the best solution.
