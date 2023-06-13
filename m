Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048EC72EBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjFMTZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjFMTYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:24:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE381FEF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:24:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-652a6cf1918so4573145b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684286; x=1689276286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hW07/KxIwpPsYdFA9lPkBZ4Xt/G7PhfjivAGs4nndnM=;
        b=QklL5AG1tnpVT2frkelZwrvdvjq6NFTrjc5Tvszw/aY/f3B3LALEwyX5gYg+7k89GF
         3cHjdzapmDZJt99ue2P72ax0cIVA9VO9+o5PHgSe42jmMAUnIiY+ghg7elKePQGvMEZ+
         oSz1rroYJAyibfzgpXQPviHZwRvqIKvQ1tbW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684286; x=1689276286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW07/KxIwpPsYdFA9lPkBZ4Xt/G7PhfjivAGs4nndnM=;
        b=VUVgki9v75guuazoMm1PTsvDdavpZiJT3V/dPHqltUys4W6CmN9YMPq0k7PCR4J7Bo
         XJFDrlSMJGmzIFn9l8KVPnitSHY+OKQhnGeyCGyfctYtfrbbxCpB0wia1ioDLhEbSJHs
         hleVWE9HiYBWmwlC7KiVWIDnHzWZpJpzcb445UkNR5DXn2LIy2kCV9Eu1OVLaeEhjs8R
         qMHnoCmbagaccP8hdSS+Z3uwbtSLN5YpeZbKKE9aoI74kavjJtZnANWTSW4Qm3Kmmj/g
         0tw59L4I8U5nWtXKaCq+xTS/CypJwXRvifmlPtG2RkmURTidlsWa/xsFqe0e7nFC/mup
         51TA==
X-Gm-Message-State: AC+VfDxykIDjGDtRSYjVhjczXganQOemgq3/3s8dC6rfCVD6FxIXMzEc
        4dE9JqS4Pr/psY5J1vjDIvy2cg==
X-Google-Smtp-Source: ACHHUZ5nGaJQrazHitO9RBRakIkNp+QjgEC3mKbozW40uweFVPJxBHm2vmipYf4h5+/k8wqt0EJcMQ==
X-Received: by 2002:a05:6a00:1826:b0:63b:854e:8459 with SMTP id y38-20020a056a00182600b0063b854e8459mr17087049pfa.31.1686684285923;
        Tue, 13 Jun 2023 12:24:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a16-20020a62bd10000000b0065ecdefa57fsm8952203pff.0.2023.06.13.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:24:45 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:24:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] cfg80211: cfg80211: strlcpy withreturn
Message-ID: <202306131224.338EAD654@keescook>
References: <20230612232301.2572316-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612232301.2572316-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:01PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since WIPHY_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
