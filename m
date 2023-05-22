Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E541970C321
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEVQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEVQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:18:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2AADB;
        Mon, 22 May 2023 09:18:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f475366514so43185195e9.2;
        Mon, 22 May 2023 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684772337; x=1687364337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJzZyuZNzPn2ke6jAQ+3bvF8maBxSbotNT8/V4Lv+Fc=;
        b=euu6Ey1XqJ8ygZoDaz732PRPtPW5Qdy2EFdO1xauW9Pwf9TOVYJw8E9ENlLca1CRnn
         aTFTpmLbmR6yQp7mq8PFpfAe3j9FLKds9vFAm/wBgVGgfxEk4jsowOd/CAGzFD3rPTWy
         gX+kGRKO8janr9uLAa7E2k3T7XF6B/9JtX/+0+wM3gcdIAbzx1MgP+dYJ3oghChYh2ci
         hM4l8usavYCowAUr9xBUosnZ/K2ROTrLG+WF/GytXpWHOIVJMUnXcqsVgDGLxls6jMwC
         HKw/fdSVsOEt2jmJht2OTnSrFT7EsT94Ef4LDAvXI/gZzv4DztbcRTD41tQ1KaUa1iA2
         erGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772337; x=1687364337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJzZyuZNzPn2ke6jAQ+3bvF8maBxSbotNT8/V4Lv+Fc=;
        b=SDevyBWcXZKOVIrZ+n4tOLE9LuJcTEYpHnLX4Pr+aseHSgH4dVkh2RwuFnYbDaRZ3h
         dQ3eTI0X7wzgVMGgnTZtpznrsarcOgVs7PuocZiOigdJ7XPIqlWwBEUlTMn+97niymgB
         A7FnoCAETGyhdPXBq3xWcH5pMDaRG46ok+kFuin5PKxT9bhGLDL4dSpacldmY3GZZvzb
         fRYlbn+zlVfqOugIvUVNVYBLQI6VT4Tqi8wwrnRyI0mGtWs0PCJLkpSywXmVGQTbmtuU
         XXzsKgTLOMUfRLdI2yJB6DiTfpn8ArPUQ70Gw1W41ztEplUkuHWxSudT06aKg1ECgNmA
         8r+A==
X-Gm-Message-State: AC+VfDwePzt+RqMrUrGZVmiKfFcyYgJhfUOW2ybPbMek1p1cG4JhuQSi
        H1UHM+ywBoHjWeikjso06UjJL4HC03WYSpoTTwWbZnBoxtE=
X-Google-Smtp-Source: ACHHUZ4kjOVYxEoor1w0hcaOXS33WeDLf0YRoOnSYzNl5ea6bGgc3qRhDbdI4pwwhHHJXH7oI9bc0NRBHiqq5OR8B9Q=
X-Received: by 2002:a5d:4b12:0:b0:309:4b55:419d with SMTP id
 v18-20020a5d4b12000000b003094b55419dmr4840129wrq.8.1684772336654; Mon, 22 May
 2023 09:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230510221237.3509484-1-azeemshaikh38@gmail.com> <202305110926.4A833D9@keescook>
In-Reply-To: <202305110926.4A833D9@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Mon, 22 May 2023 12:18:45 -0400
Message-ID: <CADmuW3U7tFfSKrQL5TopOYnDNNiHPsC42E3ghWhpqCDtKeOSYg@mail.gmail.com>
Subject: Re: [PATCH] dlm: Replace all non-returning strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        linux-hardening@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 12:26=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Wed, May 10, 2023 at 10:12:37PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Friendly ping on this.
