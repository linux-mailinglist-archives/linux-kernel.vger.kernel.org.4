Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45167171A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjE3X04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjE3X0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:26:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8FAA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:26:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso248371a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685489211; x=1688081211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20rREOO4ExsqpWtT25NbGtwxcNpitkrMts/CeDpG8is=;
        b=IOWJwO8cd4O72NmvBwHdGvQP3i7cqRoptJr1wMnEgtq33n37I4cIwcDx5x2FfX8XNk
         D9rBNzdr6Dpl7jXKPEzy/bLZQzu8npHnbDZh4qVObIkn6hJIWIcE8RRob8BYMAzARfGF
         H+KSnPUhh3BMrwv8YiDDXFpVabX4uDaPA6TjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685489211; x=1688081211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20rREOO4ExsqpWtT25NbGtwxcNpitkrMts/CeDpG8is=;
        b=k3dTaQp3H1g5qbE771Ys/Gzoi85YfBatgeUbNHNw8a3qf16zcWH7OL2oF7D4CBEj/X
         JLyRiyKv7lxXri2MSIN4/QTfm70+s9rMosi6PERQX1cRnHogPa8EjnP/EdqJxD294CWc
         UeXznjk2yNETKklnMKXYVDmWM7ZZ9ddrQHNSTmjun7HCl6fI0UdFTTMlIHYt2nXoSi6i
         o+e3HcCGGbULffeU0XjNZIKdcR3mxBWyiXNuewMsUz6Q4nFrR8jhAwQldgRABO2IeOQX
         l4vKhZolvgQSIslfiqirawB1KOHBxaY3MShWXv2jtCBaZj15yJ3dTMyxMsfb1e1cTSxw
         dQzw==
X-Gm-Message-State: AC+VfDz1Y3L0onjOYiuhrmvbTCr3X5MBEguNJJEcDTPkVBEIfMMsKYM2
        DBbvGaAc43Q9arrSGF6Ly5RptmOrC08M6WF86ns=
X-Google-Smtp-Source: ACHHUZ56FhVbFo+v/5QxJUxv9fOE+OkJsRH4Zi6ieowA+/ZNuWZvCGbZ7Trr9unf0U8xPAu9NSLSdA==
X-Received: by 2002:a17:903:2350:b0:1a6:f93a:a136 with SMTP id c16-20020a170903235000b001a6f93aa136mr13179454plh.22.1685489211573;
        Tue, 30 May 2023 16:26:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902b71400b001a4edbabad3sm10817628pls.230.2023.05.30.16.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:26:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     tglx@linutronix.de, jstultz@google.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] clocksource: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:26:49 -0700
Message-Id: <168548920884.1352363.14399780018411204130.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530163546.986188-1-azeemshaikh38@gmail.com>
References: <20230530163546.986188-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 16:35:46 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] clocksource: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/40932d192ec8

-- 
Kees Cook

