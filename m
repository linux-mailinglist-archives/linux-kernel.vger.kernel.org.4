Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3298B66195A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjAHUdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjAHUdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:33:11 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97387274;
        Sun,  8 Jan 2023 12:33:10 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fc4so15402276ejc.12;
        Sun, 08 Jan 2023 12:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxqpBxInus76UY+mNqRVLlOQOHf/+MnvHAEydqm6xJw=;
        b=WocRiw/Xz+Oj42QiFtpqh/UWGt/5rvqllQOF+T7b86NPRYH9pmNp8T9u5uzHG65Ybp
         rgn7av58yQB7GZhrmX9BG995Gag6M+xpg18y7o2+fwyLShFw2IlDVv+ACTNZ6Zvyj9ic
         QXyC6cfuiQVKE+CzxdgjN6zBERUEFUdowzakowZUZwic9uBJDyNTQSCk9LgCafEQ2q6x
         WeIs5mp86VtHNIj9to/lPbU3K/GWpS0YHxhCh2R43J5wAqRrXbYgRlYcbgR2+swmK3t6
         IENAbF8YQFNSo2RdTzoAHdFsPqhHK3pt6rjheG0TdVV+E8hI0bSTtV+X0qxu0TbFYXQm
         OGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxqpBxInus76UY+mNqRVLlOQOHf/+MnvHAEydqm6xJw=;
        b=F1Qykla6AqP955SYBFfdIMsOc4VQ0gXYk/ZYHIaph0UojDpF8BsJvLDMsZPpwe5QgU
         7EuAIWuZNwgTp3BBuawrOJg1DkbwIsAJYpGm3+08DKRut3dt++y0CIpVeUP3zbuKO+lK
         SoyKSxPdIoPp6BX5RCtQpAEK++w2yebssTDglLJuoS+5EWTm3Go2jr/tVy8vg3o5yMCN
         6AxPVhwoMUuKeRzpkw99nAv112+gT+emACBbrYyBMHPER4MV8e2RJiWmGyGV0ZKiKLpC
         bBsctztqbK2usJqRzonYnCweCUB3NfsoS5OAupKPy4/hU91xXzB06t/CkeilwSP1CBLK
         z7rw==
X-Gm-Message-State: AFqh2kprMWx3i1354TmyHZUlLuceasgZ0/VJZ3P7jpTMk1Kk5UqXcJTW
        ie0CGVVlBNXRnJB2esZpwGrQ+6GQ7fApZw==
X-Google-Smtp-Source: AMrXdXv4KLJRE9AtoPFiR0UiEn1SjFROcCuGWnf7Jm/2HQca8i2D91GCYeOHICAhjLm5cFdPObKJ6w==
X-Received: by 2002:a17:907:b9d5:b0:81e:8dd4:51c3 with SMTP id xa21-20020a170907b9d500b0081e8dd451c3mr53420692ejc.76.1673209989197;
        Sun, 08 Jan 2023 12:33:09 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906184d00b00838e7e0354asm2815937eje.85.2023.01.08.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 12:33:08 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: fix ccu_mmc_timing.c kernel-doc issues
Date:   Sun, 08 Jan 2023 21:33:07 +0100
Message-ID: <8201791.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20221122184844.6794-1-rdunlap@infradead.org>
References: <20221122184844.6794-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 22. november 2022 ob 19:48:44 CET je Randy Dunlap napisal(a):
> Use '-' to separate the function name and its description.
> Use '%' on constants in kernel-doc notation.
> Use the kernel-doc Return: format for function return values.
> 
> Fixes this warning:
> ccu_mmc_timing.c:21: warning: No description found for return value of
> 'sunxi_ccu_set_mmc_timing_mode'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yang Li <yang.lee@linux.alibaba.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org

Applied, thanks!

Best regards,
Jernej


