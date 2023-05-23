Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2170E3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjEWRV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbjEWRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:21:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204A192
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:21:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d24136663so24085b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684862490; x=1687454490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfEhaREexnLunSg5wCBPL+dpFdiNnSkUrVOZqlQDHEk=;
        b=A+WJheSy//Cq7Wk2eOH+sG3g3yvZZ+Pi55iMBsieOKUKWggt+b26yGdogCuM+EHe4o
         KCw93KwA1md97XsWNPEj2DMYDxWrH2uiL9eDHCQL847E2YXq64KZy+wfC4zOrqOyHn9D
         HFV0skJfYm4mJAQvZ4D1IhGsXWLhBFXNK7LPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862490; x=1687454490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfEhaREexnLunSg5wCBPL+dpFdiNnSkUrVOZqlQDHEk=;
        b=N2gmzjDl8QdgaAsySsjPJYw6ZMC6TgkkuGGOb8DMwB59R3Ho53WB1/WAY6F+EmSss4
         X5hToSRNQdx087ykRKUZR4RWgW6JpEeC5/m83cOwlFCGp3aYTQjmHAOa4cgHFH0KAtb/
         GSWDphtFgj2FOvbwrDAfGRNYVaZsL5crpQuqSU8Mi2QvvNNh3ibwIuh3IpvU5gjxnRQI
         TDKW5Q5hG+6Y9ElUDx+S6WYiozCtiw/wA5nIorwjQg04PT0pQjbCHNhAUdU1fIFtP2Lw
         H82zFnShm+txNV5BM4U1YbP2zbBa6MNCWLGT0sTgWujHGYt2PO7MIruJz4r5UIwh2U+l
         TUcw==
X-Gm-Message-State: AC+VfDx1Q0ms8NVkbXF9qqI+TFaaJFnSiLBl9EefN4cXcjp8Y/7OE2Zc
        l43jmeFdZhex8uBt33RUKRXcJw==
X-Google-Smtp-Source: ACHHUZ56/NYRoSNuzleiRtV4dRY/zW0gZwuFEggLub1Lj8aT7EotD520+MbzI/emSzlCoGE2EUD4VA==
X-Received: by 2002:a05:6a00:2314:b0:648:8c0d:6e4e with SMTP id h20-20020a056a00231400b006488c0d6e4emr18112351pfh.19.1684862490206;
        Tue, 23 May 2023 10:21:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e14-20020a62aa0e000000b0063b6cccd5dfsm3551359pff.195.2023.05.23.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:21:29 -0700 (PDT)
Date:   Tue, 23 May 2023 10:21:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305231021.73BFA380D@keescook>
References: <20230523021640.2406585-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523021640.2406585-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:16:40AM +0000, Azeem Shaikh wrote:
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
