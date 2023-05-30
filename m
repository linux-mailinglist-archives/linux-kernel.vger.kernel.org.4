Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B414E717183
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjE3XRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjE3XRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:17:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351AF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b04706c85fso22389735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488652; x=1688080652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cI5RWWDaCtzDppmiGoeA662GR/0rxVkDI+/Xp1CjfFE=;
        b=mnlm+bH6/fI+ZtXDTL9Lrmbx7ViXjTU7huF80OGn3FPSp8sLaGgLeMI/tbG51iToyf
         mHejWE7I8q4WGv1OLqXPEGPc2Sr9cyq04o4I5lYUkiMp+gXSQAX+P/Z32VBAzM9xpOe8
         TJlReIhaYPOcD9qAo6SrRLJQGDxkHsAZw9l3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488652; x=1688080652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI5RWWDaCtzDppmiGoeA662GR/0rxVkDI+/Xp1CjfFE=;
        b=Y8g2NrgS336RxfuVMu1SzyKDERC1ZdhuJqxIWDBuU1uKGnaTfs1jY7VPghVVI4vQ9B
         FMalKm4wfd9UYAIHkqf0AkYPhj1Ok6JhtRMSRKqap/7NFx6ZJB2VtiH5ekKsmOnQwgo9
         ma/nLHwsO0+38bN01+5wSwO53aHIraE72xtlFHkmG9d3qWx7Ik3fioBEIxgQgWmhBCiH
         Cal9wPBmj4nLWx798Zeb77i6ICeNQVDs4jEcH17n31QpcYM0RxVSdl3CayS0DFJ/2CFP
         kfaI0uJM5XjvrmkBwM3QAVnc9yhvUp5nAknXVXoJWcdhPB9KN+Sc37p/hoHrC+FQgxYk
         kbag==
X-Gm-Message-State: AC+VfDxOe7lnqrLtoNVuQX26nKwe42vg16oE2PtEztVphB7L0CwbeTR3
        bk1SG2jIEuf5U6D6PlUH/0Y9qA==
X-Google-Smtp-Source: ACHHUZ4rzSiRcHEqELCHFhfbmEP90GAMJuKp2xmVuatTGNDqQav21vDNIxEXT/nfHYEkIEh+wIJLXg==
X-Received: by 2002:a17:902:b696:b0:1af:beae:c0b with SMTP id c22-20020a170902b69600b001afbeae0c0bmr2991202pls.22.1685488652497;
        Tue, 30 May 2023 16:17:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bf5-20020a170902b90500b001b0772fe3fdsm649636plb.265.2023.05.30.16.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:31 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-hardening@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] bpf: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301617.EEB6B76B5B@keescook>
References: <20230530155659.309657-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155659.309657-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:56:59PM +0000, Azeem Shaikh wrote:
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
