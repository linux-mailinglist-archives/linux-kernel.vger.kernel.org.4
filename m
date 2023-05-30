Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEE371719A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjE3XVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjE3XVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:21:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1AE5E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso5695264b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488880; x=1688080880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olkd5FdK39xwOU4GbWWKQgW5dE56bKupA6Kog3J0D9U=;
        b=I66TxfywFbovbwxMYfgVqGu6OQ15EAfC3r2Nk3gU4AlgjbxZUqZpUbVpAQIfdtnc0h
         FXdv3YrEUG2H/4wiPbkwiLFyuNcTd0PSOSnje+7kLQbCtU2x4t9OprLMMRCowpallEeS
         F/GnpmvW0w9OTMOmfTk+HT/pzqBqo7VJ/JVhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488880; x=1688080880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olkd5FdK39xwOU4GbWWKQgW5dE56bKupA6Kog3J0D9U=;
        b=SXPTRZmTJJhXYgFAcrtdSHGqeyP/1G6SAus1teTeDwTMOCj3dtE5PvTVce3rGcMNhY
         g2ZDyzWgJZiVzF44liXU6uFRcF/vyLDWVELXigfY1jwyjcZe5uWvp1kq398EDB9iEBZT
         yZbgKN5cI1uD6U/Rsy+46VVj1B+4fas+mlBZFfwcvN2V+EhDIib/NQVNxNFrwpfGp/oq
         nsL/0l9EK6OwSmpdkobmCqADOanFVP6SnNsoB6yuBgij+6orapfOjbXrCG4n1M49fHtm
         T2ruDUMNfTvdW7LGQz6tJntD/pAm43ZhJ/avFV64If2McMSxYGkGl3J4fqnmZlvt347U
         LlXQ==
X-Gm-Message-State: AC+VfDyaJi8Ov2DBJ6tVMTxm2Zi0y+uy/3EAuFG6/N68GVtXhWifCH0I
        MoKZ3V7vCP6C3AkWICcfKu/gEQ==
X-Google-Smtp-Source: ACHHUZ5L6QnQe2Ow2yj0s6as1ruiWEChEcxKhwrITISgxHUHXQuY8n8FjIRUt7C3pCP0LPYNw5yo5w==
X-Received: by 2002:a05:6a00:1787:b0:645:cfb0:2779 with SMTP id s7-20020a056a00178700b00645cfb02779mr4255573pfg.26.1685488880576;
        Tue, 30 May 2023 16:21:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b0063f2e729127sm2171189pfh.144.2023.05.30.16.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:21:20 -0700 (PDT)
Date:   Tue, 30 May 2023 16:21:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301621.3D086C4C@keescook>
References: <20230530164131.987213-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530164131.987213-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:41:31PM +0000, Azeem Shaikh wrote:
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
