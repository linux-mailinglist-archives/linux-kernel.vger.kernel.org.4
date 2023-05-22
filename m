Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEBA70C8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjEVTkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjEVTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:40:00 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C5510C
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52caed90d17so4524993a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784392; x=1687376392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceByCrhQgy1xUUUVzV543Wg3Hs/zTuoTP3ZtYqzShtI=;
        b=Y9+znyw3UTpuwo7EhaJN8to/oNZXF2OZjOrsPlDS8BAU5YcbHs6czktV2TGVEssfjY
         mFQyXda376uK9q3UwNbvE3p+f/rW5QwBVE9Nj0LwehQToBVVw2BoZy5sO523UTw/7b9d
         F+BJivvRm5xZ60d6loAyMOROFnPCWvlQp0JNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784392; x=1687376392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceByCrhQgy1xUUUVzV543Wg3Hs/zTuoTP3ZtYqzShtI=;
        b=ZmBsIwz1b66A8tYJ1Onoa+4IBgXmME46xnCWcSuuc8W32JTzmNzIiLy5skjf/rC5yN
         QsQjD11EhTfsEUsuF5+1aDS4Gh1QVBb4y24p3mATXdQJuwN8MPjxu+WpqiwlBMmIBI8z
         EMQXOtjRvcEUbktYX3StHYySa50WDIUPQfBTB6XC47Oeo+OgwtqS530x6yQr4hzBjBd9
         YxkFe4Zo0etECOnXpDPrvsF0qEKlIUnlTe8PdT1bk+0ZKLfDGVDjZHgMeOhK1S+gZh7I
         Jsn7JADJ5CLQNgJAqwp6M1ucGYLYOEFTRDnQPWeRRMQkNXRo+EU7te1jnh6oQPSREiB2
         EZ9w==
X-Gm-Message-State: AC+VfDx6atI3hik5ZapFte5YJXgCYDPJCgW66BOdjlz6hZ6+IQi4IzZC
        bTu/g2AbnlyNNLQ96BRqFUxp0c9OAboGZdyvG+o=
X-Google-Smtp-Source: ACHHUZ4enFeof6uNQGr38VRobeFDvzOpVKl+AZWYMMe+2ttBbmcmP+tA64Za0AZigVUFPs8S+ijvwQ==
X-Received: by 2002:a17:902:bf06:b0:1ae:2e0f:1cf6 with SMTP id bi6-20020a170902bf0600b001ae2e0f1cf6mr11396208plb.36.1684784392569;
        Mon, 22 May 2023 12:39:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001ab2592ed33sm5331973plb.171.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     rostedt@goodmis.org, mhiramat@kernel.org, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:42 -0700
Message-Id: <168478437626.244538.6559937483217152450.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
References: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 14:39:56 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] tracing: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/4cb4e5158b89

-- 
Kees Cook

