Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07AF6FF702
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbjEKQV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbjEKQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:21:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA022101
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:21:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-517c01edaaaso5892053a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683822080; x=1686414080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heapyBOK3aV1fZtrL6FBCSipibEU/9iPf6nNQf6o/H8=;
        b=fpLgr46GjmxVMykYNDwOPIDPvHafCefP8fNnepKPuq1erqsrurtMc293jCPXm5AJ/1
         181Wlk1a4XNBgrUwPzQHmhoo7wwGmdwe6hvuqZuT8MDxsHxQCTuasgNNj85oze+hfZSh
         DJj4iRKF/NrcBtey8LbCWG+dblmVoazJENJwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822080; x=1686414080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heapyBOK3aV1fZtrL6FBCSipibEU/9iPf6nNQf6o/H8=;
        b=ijnxZL1sddW1OEgS2MXn/SxVxTjWLYEr65vgD03UjR2Zz5HxSyKhwYlGfB7kHwBDVd
         8QbuPDY6MTMc/bRIcTh9i1WrzGnvMLyVdjtJX29QS8fSA/gBeNV8yhQki5JOnHyZIXSP
         flzVi14RuVfKfDMDeTu27SkVGoiw41EfrniU7nHR5IonTrABxxmq8dJMo+jRBiAhNnHf
         r+VJcF0mEKQz+wP5NlH9BlWIayEoJpT7IqFGO1fH00cnDwDGBAA5PQIyO/feNU2dtdCC
         WUvPoZTuUyHss6Ya11jXTd+UB3imBKdbCVykT7udK1nJEHkLLhCJnFnn/cFXa3HhElV8
         5l5w==
X-Gm-Message-State: AC+VfDwa2JdWoNf3PTZyy6bPDKRNmM4eMS5Ihfjjc4Q+wMk/1gI8RDth
        Ut7j7RFgEHTAaOevTBSMIregIw==
X-Google-Smtp-Source: ACHHUZ4rDN7oDHBSu5wOHvTjki4kVxR42aG5JcpjDaVZMOvXaRpv+OTXQovzh68r5d1kTHycgead+Q==
X-Received: by 2002:a17:902:eb4b:b0:1a6:7632:2b20 with SMTP id i11-20020a170902eb4b00b001a676322b20mr23433122pli.40.1683822080560;
        Thu, 11 May 2023 09:21:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001a6f7744a27sm6160602plg.87.2023.05.11.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:21:20 -0700 (PDT)
Date:   Thu, 11 May 2023 09:21:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Replace all non-returning strlcpy with strscpy
Message-ID: <202305110921.B62DD1BB@keescook>
References: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 09:11:46PM +0000, Azeem Shaikh wrote:
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
