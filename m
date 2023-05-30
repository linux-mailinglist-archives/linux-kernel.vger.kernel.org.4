Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E47271718A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjE3XRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjE3XRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:17:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC4138
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b0314f057cso23844535ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488658; x=1688080658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htQvHyRPKywmvqgggGcNa8SuYARR+iKblgi3Lk2cgcQ=;
        b=SPiemOvN4l+hQOe10jQ/zlIUyFw1b3j7k7vKZjbaMYFU5hG16QEMZyUm2RjdLpU0Sl
         aQgfaqyLPUPdGIn6fPlWo+fLuJ/7/R4MXrUM929ffA5uvTEdYATepCa59cWdcXw7EpEz
         Mhts2ZAEipA6VoK17Ol0KlxTcHxglhPMsx8zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488658; x=1688080658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htQvHyRPKywmvqgggGcNa8SuYARR+iKblgi3Lk2cgcQ=;
        b=Stkh6uOFIqH3AAWI2uYR3L1S116bL+U0S6B2uRWD6A5/L+z+cIAIf9arORty8rDyhT
         FVGHPoTXa/ML03cNmSbtvonUEwtxF9OZlep7w9jN0iNoKLuN6F/IJ/uMDVFJr9ihKN7H
         hXHxAuBNLl3/L03NJ8MuTS8lJ2Ac6MSuhvLMYUjUNN6IqCXTCXMSGeXhc4QWcKLBmx0y
         WOX+MyyTrnHEVSupLYlH7p3jgjEkr5lqwyczDKXDillWxm7pPrDdwloSYZx9vF/6l/pM
         MQoTW+/rCtGMTc7x3fJWbhM1jOARejkiz5NzSUc5VV0ImAb3+QZgKjjHu0l5ptCSqxCQ
         Hh6w==
X-Gm-Message-State: AC+VfDzPLz25V5fTkh7LZy3ZzK1Kl3t2qIum7rBeyFScgi1OvPtbiPCw
        Uebhmp5IfMygrsz2xwOJ3abLUA==
X-Google-Smtp-Source: ACHHUZ7MnshdhHQU3GZ7AJ/pNk3+u3JS+QrXTvcqHGBBAbZSHFA2SuLvk6HrJbIf6Rh+UrsRpchscg==
X-Received: by 2002:a17:902:ba84:b0:1b0:5814:d8d4 with SMTP id k4-20020a170902ba8400b001b05814d8d4mr3731454pls.53.1685488658304;
        Tue, 30 May 2023 16:17:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a22-20020a170902b59600b001ae2b94701fsm10777113pls.21.2023.05.30.16.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:37 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-hardening@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: libfcoe: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305301617.FD9EAC9@keescook>
References: <20230530155818.368562-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155818.368562-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:58:18PM +0000, Azeem Shaikh wrote:
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
