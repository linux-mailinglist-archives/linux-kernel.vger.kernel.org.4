Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA806FF726
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbjEKQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbjEKQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:26:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5E855BE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:26:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf21bb427so63830125ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683822387; x=1686414387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndBrQ3w0AHpWG5hJlqPBYuez6El2zpi53yJoXY7Mu50=;
        b=e0/UwYTlRtR2RbPrnGw3TEV3B0HEDL/iXR+Q2PlPbNY5XTUy7Gn1joONOUh7sEeZJQ
         iC843L9UHEbDTk0Ge7TeWWHWKypOeA9fJ9g7nDuiZ+v7peGZ1bOQ+FH6HBFsip8lCJ3G
         hocIjwqI14UzBOfRXLrP3aNFoQIRy1PFjeKHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822387; x=1686414387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndBrQ3w0AHpWG5hJlqPBYuez6El2zpi53yJoXY7Mu50=;
        b=fdlKGQJRzQ3+F4bNWDEc2A3extLcOC6gGs3p2KITKYu8UvT2biSXR0Q9jyUlsbgG+J
         TlM1gIk2OhUC/eC4SeW8PZYWQvpKJuQ4otCCjq03/H0OjoAj+xc/wBge1QlGmaF8Xb+c
         wEnjrFZQ2lzyYDwDqfP/QHiNlwatjlCAc/qEFeBeO6cLN+PUEmbQUjcJEiT1oMEyL74w
         z3L42WTTBHzJ7vTkkQRROQ7RdtcTJigvTO7l19xNItUu8pHYUAS4FKZXePlVY4QXVICT
         weZyvq7U7Ej2RGKqAI7Gxr1LjaWpT+biQpGXSOxs47hhaA40I0/sYxLErXoIfGYYvSjT
         GVFw==
X-Gm-Message-State: AC+VfDwAGam1UpwSOF9m+yuSE1kLL+Bj8+KYq/KwC4EorWSrC3VI9NyX
        NUKODRQrchMWr0b7ZmKj/YEE4OzwlUESTcEb2UB+9Q==
X-Google-Smtp-Source: ACHHUZ5y1saTqsWRD5lKY3DfBma0oCNPx8Yo7rLHR+umtawiVR8DGcUWb5J5pFrfL6M10DRtlR2reQ==
X-Received: by 2002:a17:902:d491:b0:1ab:26a8:5401 with SMTP id c17-20020a170902d49100b001ab26a85401mr31973723plg.31.1683822386770;
        Thu, 11 May 2023 09:26:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902bb9100b001aaef9d0102sm6120820pls.197.2023.05.11.09.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:26:26 -0700 (PDT)
Date:   Thu, 11 May 2023 09:26:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        linux-hardening@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dlm: Replace all non-returning strlcpy with strscpy
Message-ID: <202305110926.4A833D9@keescook>
References: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:12:37PM +0000, Azeem Shaikh wrote:
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
