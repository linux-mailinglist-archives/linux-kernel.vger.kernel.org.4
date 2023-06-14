Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80F273064F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjFNRtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjFNRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:49:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050642684
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:48:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6668950b6c0so115029b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686764938; x=1689356938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjrKab4vfGxL0dLn3LMbtzN7OEg/16CgMG49/q/se/g=;
        b=eCzeoU8LezyUAvJVYQgqiFYeiiMn3HN0d1MFvlfoQcOtsyJGayKkkfvin8rgYYT0Bt
         VTZZOHWzvvj9xL8WycutB9Jeggr8qAprVQaAIU3ZW8LODkJWI3m7vBx5wSR/27xhbNrw
         9NrPMzZ9s3xIoU7SPD4pN2wH8igILNyC1g9R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764938; x=1689356938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjrKab4vfGxL0dLn3LMbtzN7OEg/16CgMG49/q/se/g=;
        b=lE2sAXdxuObWBaU7u9GoIhaJBQzJ/eUbJ+jpFjZutBWXWOk+oGEROVx4hqSYLKvPxD
         k/jGDieURIOfLsnEU4839EOqLta60dLsCVNpd/VcJC8JpFuNGN6DZQKoln/a40jViw4P
         ipCZvbPo09j7o4Iihrg0hGkEl96VoTYfHTbCPxKxcwvnix2NmdGwlNrTnYJ+F0NPlSOV
         Jfrl+hq+lKISWfKMK8GNX/lApINY/Vdwk7wqjcmEYBfMr03wjBUcewOO5SJESFKYiJlo
         yrRyVWRUb5yOVx6+iSUxNqXH2gYwGeJZBtmN+2XPyXnynYTTRp/uzABGEjDlG+PZT6M8
         hzeQ==
X-Gm-Message-State: AC+VfDyzrBJK1b9oMqMt6YArBR1UBSH6A7j1wuTGB65/cpeBC2V8h47F
        ukNb8FGEEX4Ua4xM6NozXfsFpQ==
X-Google-Smtp-Source: ACHHUZ6/py/DK99QfyP54m1+xWT2yTOI77wGCJA7udeTtjICND/fJZsxj4XWok3Kr4uiaXYP0dhCeA==
X-Received: by 2002:aa7:8892:0:b0:657:e9ae:e022 with SMTP id z18-20020aa78892000000b00657e9aee022mr3031205pfe.5.1686764938500;
        Wed, 14 Jun 2023 10:48:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020a63444e000000b00528da88275bsm11301568pgk.47.2023.06.14.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:48:57 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:48:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbip: usbip_host: Replace strlcpy with strscpy
Message-ID: <202306141048.27FC4B7F3D@keescook>
References: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 02:10:26PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
