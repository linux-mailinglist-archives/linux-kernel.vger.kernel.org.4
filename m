Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0670E391
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbjEWRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbjEWRVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:21:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C977A129
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:21:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae79528d4dso52048235ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684862479; x=1687454479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5S5txlWNiYeKIEfhmZSeDGPnfFSDx5ycbWVRYMu5dI=;
        b=lrP15ZPaMmvR5rJuYAASPnbjeZYvXf0yiRkQ1CYjnypEMU5zoEvMLZj19GdPCI4/Mw
         rREjfwYPpbtcDBkm/f3CycHsjt9YkV7+bxsmMn7DBiv0eYJLrZVL/HN3LcP+D2rUlDXu
         duzHtKUI9GwcyIORlYUQ/LA+xWG9QFbCmK5H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862479; x=1687454479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5S5txlWNiYeKIEfhmZSeDGPnfFSDx5ycbWVRYMu5dI=;
        b=bW6Z2PZLFIMRe+VJ/u/6brBHGlt1vSn8Zz69Sh8g0E3tOT6LMe7yRQwMl2eNASFbx6
         l9tLFGwLtRyiJM3X/UpBK3MdgLSBAK28pi2G1rLlIBTMgKHDXW2Mx1mtewmmAJntRRTA
         r/YeHLlxA9KMU5zEa4XE6cCFXDGDpOLeNogtLz3XoP+a0TG8UfAFtfRzGom9QUeLHJk6
         IfbAWbTqL1+QLN7AQ1oxq3KkiTZD/+Lk8IAn8q5mfEmnF3Quyup1F9rwl26V8ObzhwD8
         zaDMa/s1MxsFkYwBvUyNSYuCYKiAyzTirbMd786Owtttopxd5SKm6LSR4X3aFFs7BKXm
         PCXQ==
X-Gm-Message-State: AC+VfDxheQiQ5UvJySb5fDFrz46a10xa6+TO5ndaWuy6CqyEvQQQHFcJ
        AzSjjeCujJYeNrY6TX+KMXw0ew==
X-Google-Smtp-Source: ACHHUZ5AGolyDK1desZRPBO2wmeKuC8o8zbGl++vcoBBGTrXyygK4a5Hm6SfJkUiqsEdeZ2tdi1ABQ==
X-Received: by 2002:a17:902:dace:b0:1ae:43a8:2759 with SMTP id q14-20020a170902dace00b001ae43a82759mr15495847plx.58.1684862479082;
        Tue, 23 May 2023 10:21:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001aaed524541sm7032578plb.227.2023.05.23.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:21:18 -0700 (PDT)
Date:   Tue, 23 May 2023 10:21:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Replace all non-returning strlcpy with strscpy
Message-ID: <202305231021.DFA0C4F7D@keescook>
References: <20230523021451.2406362-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523021451.2406362-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:14:51AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
