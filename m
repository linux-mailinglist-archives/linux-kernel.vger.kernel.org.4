Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821557071AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjEQTNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjEQTNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:13:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5959F8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:13:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae3ed1b0d6so9405335ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350800; x=1686942800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6czxj2yh/2mLyL8a+KpoQy5McU/reD4RvDXw+77Cpc=;
        b=QwKQlvilqcEW2x6DKwphNwJhhD+FIPW3wsl/pJqnfEhMuS5gPImBThRtc8IeFe9ATj
         9kRW5jalZeegpFo9A40Jj4PZVs9ip76KAgOktsvYXoZNyQn9eubHm/mzXKUDSdmfQkXq
         hx+OqrWYi/AW+RjK/5NRxbzwzOcz36qulbkF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350800; x=1686942800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6czxj2yh/2mLyL8a+KpoQy5McU/reD4RvDXw+77Cpc=;
        b=Z9OwA0AUBoSkGBVb8AXPtEvabjl02OyAT2dYQnk0ScQc2GTIAu4fS6Vs3H6+MpJLNm
         sqAG4p2LwBAHIkOxoIsEcLeLTrQ8eBQxsoWiH3Hv/eVP6YienmzI+8gjPtI5LBb2lzmb
         NXelUl8NrqDxh7ZSV9Az2C32IyebMz6LM8gtk4EyCeSCrHTZ6M79BSbywDKmzqOe0EAA
         gnqSobC4iKy/xcCR2kQ++CyGfCFloCWWeG0KZb74z1fXRnyOMHIgG4JkpE/tuNvJD1ul
         mOwnjquvOlUBjkwNM5SOu11c0Smy5RxzHumIK2YNmK+D2AoOnnzYJEnaZmpQjn5KNkf6
         X5Pg==
X-Gm-Message-State: AC+VfDzTvMbuSru/NgPBq85jJz5zlr2+nHAp3kle/822+Tlo3ovrPynR
        llCFyusEwyuo0jG8B0qVVx1dAw==
X-Google-Smtp-Source: ACHHUZ64wPSvM/q5kDI7IKFpS45eLHhjh6pMFolF+HvUoNJeUircwL59gxk6wPnioJ8AyerG0Kiv0Q==
X-Received: by 2002:a17:90b:80f:b0:253:2c87:9459 with SMTP id bk15-20020a17090b080f00b002532c879459mr585016pjb.45.1684350800035;
        Wed, 17 May 2023 12:13:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a0f8a00b0024e06a71ef5sm2013789pjz.56.2023.05.17.12.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:13:19 -0700 (PDT)
Date:   Wed, 17 May 2023 12:13:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Adam Radford <aradford@gmail.com>, linux-hardening@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: 3w-9xxx: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305171213.3CA3EC1@keescook>
References: <20230517142955.1519572-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517142955.1519572-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:29:55PM +0000, Azeem Shaikh wrote:
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
