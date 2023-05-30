Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487EA717195
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjE3XVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjE3XU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:20:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3120A107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:20:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b01d912924so40860065ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488850; x=1688080850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddypSZo0pvZj3CCocZxOELdl+DEZnsNHTPXNYsUXA+U=;
        b=fOMdV6bV4zFWMAEfPk/QN3zM+edy6/AD1CsjZLT8PblcO/ut+cRCpK8KxeGMNB0syn
         opcmuwL4i+1Wl/PevrFmRdnTBv5gRGHMyH027oMB3BoiaPTaMlpqyJNWaDoPQR6jrY+s
         iAL/AmtGZeh+OLxcaQxGlX0Q9weQoHgPZSNZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488850; x=1688080850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddypSZo0pvZj3CCocZxOELdl+DEZnsNHTPXNYsUXA+U=;
        b=JKER+TwBTpdUgDGv6QZ9fMqsaP7cZcAE2sHf5Ik84Kt7yiQmtYtw+VNAIqSSPmM6UK
         35RSJfE6paY2ZnP3y/YWZFOlhrxmhz/jlPXBj1np1DXVZFYiKm/a6a4aM6pIoMBYha8j
         x7ezlDGdhra0TvuTAIr5HP9g9E/5a1S4iCSTC+Rm8gQQV1XMdMfMfXh9H+v0YdLZUXH7
         SbjuuiYPmKOUC2kvqFdozpl4zvYg3Z2inoR4sWbHi4TT199YeiqOLeVg37uKgJAqlvaf
         3Y1UWqPUJapMVFfXdVz8/pCVy9qEb3Adx0360CShd9p8rnW84utuUK/ccLLWkmViUf0e
         THSA==
X-Gm-Message-State: AC+VfDxwf97KoxcnrPwWWnWQnoo04uizW1Xn5WE1FCRutuL6vkg9kPTl
        qnaN701w9EMVsr/DqiDoRdmldw==
X-Google-Smtp-Source: ACHHUZ5rzUACM1i508I2O0D5Ud9Tu42v2WmVDme8hyjAXpZFBjMT8MeFfihGvE1PSb330BeZX303gw==
X-Received: by 2002:a17:903:2442:b0:1b0:41fb:4ad5 with SMTP id l2-20020a170903244200b001b041fb4ad5mr4303960pls.46.1685488850466;
        Tue, 30 May 2023 16:20:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001aaec7a2a62sm8685754pls.188.2023.05.30.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:20:49 -0700 (PDT)
Date:   Tue, 30 May 2023 16:20:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Don Brace <don.brace@microchip.com>,
        linux-hardening@vger.kernel.org, storagedev@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: smartpqi: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305301620.75F9B609@keescook>
References: <20230530162321.984035-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162321.984035-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:23:21PM +0000, Azeem Shaikh wrote:
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
