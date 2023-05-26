Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED7712C07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjEZRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjEZRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:45:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF82D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:45:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso974186b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685123153; x=1687715153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5DzB4Uzd4xa8xYGjieJgku2UHj5urdPOoD2PaVWUPI=;
        b=VIyL8+8258eQJQQy0ppluvuHLZmENur68RXTIL9ksZLnAGLcJwxmysELDt/qFMwiBo
         Hfq3aDF7mzw/nh3/TFyD4LuumKzwkoZt2TL2+n/BTLPQ0uLkcmskMwo/p5zsI+n9jFqH
         7AxsX/KU7i7MKlloMwu6np8PmHzZOofUBstPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685123153; x=1687715153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5DzB4Uzd4xa8xYGjieJgku2UHj5urdPOoD2PaVWUPI=;
        b=XTph5Zwx6toK8gA/m7FjAVhFyVK5aj880SBrwGGpcryTyoVrfg8ufA1+mN2cAlOew9
         QJTIqYbwzrWndRCwSbOcsLwtSpFeT5p+ipRLvNofknRCBI6Kge4dmt8cjxuenUSW6rRt
         Uwfb82krPRBez41mU7KoMXmDHSij7CDbSyPkA2AHPIHytSscGaHsrwjuJiqYs8WUPpe4
         O2+P7CBe7Ou8SBcpVWMrxdApEKAgIFfx2B1rWhRxBAv4HZvkzRxInmRXNGZS7FdWXbiv
         jnFLK431JZs0//+0P7jhlowjFMNHr/IXru3NqRDyJKJaV4bMeZcUQc8TV+h1q26OU11f
         BxOQ==
X-Gm-Message-State: AC+VfDzBr5OsKuMqEih0jQNbCvGNxA9X3ewh+cTRAOIOcZPScEqCXxTz
        xQ4NyRxgfk50Vwyjvo8EigGesA==
X-Google-Smtp-Source: ACHHUZ6bTR68Ulp3H8mCx5n9ISJvVraQuZrPuB0WoFzw2xKwVW0k2ZrQQwLo/O/F1jxVhyQvxBu6bQ==
X-Received: by 2002:a05:6a20:3952:b0:100:6f8f:7793 with SMTP id r18-20020a056a20395200b001006f8f7793mr229404pzg.3.1685123153201;
        Fri, 26 May 2023 10:45:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020aa780c9000000b0064d45eea573sm2985689pfn.41.2023.05.26.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:45:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     mhiramat@kernel.org, rostedt@goodmis.org, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] ftrace: Replace all non-returning strlcpy with strscpy
Date:   Fri, 26 May 2023 10:45:49 -0700
Message-Id: <168512314590.441353.7220379541429337017.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
References: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 14:53:23 +0000, Azeem Shaikh wrote:
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

[1/1] ftrace: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/bd35ef4f612f

-- 
Kees Cook

