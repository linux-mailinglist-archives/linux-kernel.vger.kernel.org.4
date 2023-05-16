Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE07055CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEPSQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEPSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:16:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE8A420A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:16:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae4c5e12edso2632025ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684260966; x=1686852966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84nwJfF5J6T8UXJDjJIGknoJcQZGQDLwemF5IvWH188=;
        b=TOrDyWMhovHSWLdMZZLFO2aQDFuuPNmAgwXZUpHizvYaoVMl7PKB6QMwFyb9um/nkC
         8WEuQxQQIBhwg3UanQgfr1RUfmUTSlY8K8RtXTlYfolVprSZ2iAxuH+SUp5S6H/VAAUu
         pHqB2gS9CapmpKklaBvwnaZ3IUIt5AYhBE8vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260966; x=1686852966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84nwJfF5J6T8UXJDjJIGknoJcQZGQDLwemF5IvWH188=;
        b=Y8TIeaelG9AmSJ3Me8Pj4nmSIa17V+BSw3aXe4eAltSe03Yc8W7mMOubK7HOx5Ny7v
         2CF2IjGLqT1w14oLCRiX9KgEd0JjvPL7/uff632I4ipEM2z95ajj0nW0POSKg3S1jAAH
         ANXHRb+Xsv+FRtJ915enNCZCuOTd65GsjPnw9w0MvvnepYJXKt9s7BUbyLJDmHAuxIOQ
         B9ztwL0HoX9vrovClXaLac2aFgEN1OaESw1DnZLsojbKsT63lSZCZXne/ZVUronfRV4c
         Ou9506cv7x3DDjZKrFudVetdNQrfNz36MScxLxO4RpsCSKbaMnICL5lA8xIhd7E1ECL4
         dvuw==
X-Gm-Message-State: AC+VfDyIYcWdjK5DIlcWWM9KAtjYYonKW+BjuzffuH7jZmf8hvhUE7tz
        Nwv3KgyQCfUVCg1rnfmXkZO9uA==
X-Google-Smtp-Source: ACHHUZ7bezD1AfXTru0fjrFVtWJPfsMcjudLSkYIWaDbfyoRl8Xk0oroge6WdmZaIIIqqJqKWTfMVg==
X-Received: by 2002:a17:902:9049:b0:1ab:19db:f2b with SMTP id w9-20020a170902904900b001ab19db0f2bmr40306193plz.36.1684260966700;
        Tue, 16 May 2023 11:16:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b001ab016e7916sm6473789plh.234.2023.05.16.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:16:06 -0700 (PDT)
Date:   Tue, 16 May 2023 11:16:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] scsi: target: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305161115.8FACC7D1@keescook>
References: <20230516025322.2804923-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516025322.2804923-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:53:22AM +0000, Azeem Shaikh wrote:
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
