Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D72607BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiJUQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJUQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:11:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA51402CB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w189so1545201pfw.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qxZq7Hd3ML2paI3WmsE1h3hTCDov6ahbHtSJdPhwKs=;
        b=C2v0Uub9Ezr8SlP+nrocG6g0Z2KUXuTwEzoDkG29zezmx4Mde/3JDKHuwHKaJu7uDn
         Otgd9ypuhyEkgiGtjvElFZ3fdxC1KNsGN+c+fgFKUmqefOL6jSbOlp8TrhPR7hNiIe39
         64sTVpHUxG9UqADv4AXrcaEol5oxKkiDV548o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qxZq7Hd3ML2paI3WmsE1h3hTCDov6ahbHtSJdPhwKs=;
        b=Xpy/g58SVa2rpiud+7VoTCVXQor3weeaMYnwpmzyEWN9wV0F2vjh5i9C9hmrTOTRp7
         hlCo93MtL3iOJK+Va+oYUX0hTWDUVq7cUmLPNIwaZQ4E3BpRFYtiv64Okeb3DxToStJu
         pbDvSChWjoWwVdQpJC+U7DApUgyW6DGTarnszPHbGsFs0mAll/mWU0upiQMK7Jmt8zj/
         l5bIlBEnqlHLM6W6xNcLO7Dp32ETiH6TvZwx+p3Oj6+bQnde0XNy7Pl5IkQcEMpCrp+o
         MSbbT5o1yk66/BEwAbC0Y7Z4rsC6jBersFBbs+iAHdQuAmENhiTReMCJ7LnomX2QED3X
         ivAg==
X-Gm-Message-State: ACrzQf3NVdW0iedZ4FhA7MswgYbnoa9yLGbECY/SZ9pE3VApn30Y8mVY
        CJSh3dNYwUte2qUbbiBeWvQSlw==
X-Google-Smtp-Source: AMsMyM7sthN0prpjLbx7tdYg/VEL33Orup0q8+4Wmwbb8ZKjsZClBsVAqC4fVu6h1NL8XTJH2Hk0tA==
X-Received: by 2002:a63:1508:0:b0:438:eb90:52d1 with SMTP id v8-20020a631508000000b00438eb9052d1mr17177993pgl.252.1666368680316;
        Fri, 21 Oct 2022 09:11:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b0017a1145eec7sm15229227plh.157.2022.10.21.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:11:19 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:11:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] compiler-gcc: remove attribute support check for
 `__no_sanitize_thread__`
Message-ID: <202210210911.030D948@keescook>
References: <20221021115956.9947-1-ojeda@kernel.org>
 <20221021115956.9947-3-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-3-ojeda@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:54PM +0200, Miguel Ojeda wrote:
> The attribute was added in GCC 5.1, which matches the minimum GCC version
> supported by the kernel.
> 
> Therefore, remove the check.
> 
> Link: https://godbolt.org/z/vbxKejxbx
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
