Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7EB7071B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjEQTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjEQTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:14:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF2D056
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:14:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so836716b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350845; x=1686942845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOcRPuLGObm+Vg1R2GCaP1lmxZ7GfKsTU0IS+UkR3zs=;
        b=SUqO4jCCzRBEgKPabZ2BR1iWXlDt2bJ4YSx2nTK+jnAsmW8ztUDPnxFpi2XNxv89H0
         xkQ2xhTIBVlUIXd65WUWWEmzgGVJRq5XXv4dHzNMp9TnfYmVeRGoc5/iYDZuxhtKLl+X
         R/owG4gwXqt6fPHMYaTSzJ+vYIB2PSQuBqtjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350845; x=1686942845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOcRPuLGObm+Vg1R2GCaP1lmxZ7GfKsTU0IS+UkR3zs=;
        b=XrnNYyf2B7kxYD4ldoutekli+aTQlEYvd3dyNJekXq/szh5P3X6fWmYUqQ3yiYeNeN
         gWh8rAuDN3Lmw3+Kyhb7pwFiZ1eA5btmB7sYfemfHHxN9UeOp3bGxVt5/j88Y4zwcp7s
         GcRUVGEjwlxd2+XZCQryZd24HxuRY3fL2js6MBp/PYYMA8MxpqgMSK6e6gewvF++yJR+
         qUKAJ3M1hCthMT8DD1xS9J/ePG2uFQOWX5mvpI0NlZmpv/ob5+7ihXE1EsAVosVKCPBl
         Y6r3EcfIRrxcrEk9UfuHj1LS2P1dry98yg2WslvdgNn5iJiusIk+RiyVBOpgn7peZGPW
         8NcQ==
X-Gm-Message-State: AC+VfDxDI/DzOGz05hCuBq/3L6YjAofDTWYEvruSIscgZgmIe1PuTIh4
        VE4ICEUQJoGRi2ttkHKZAWXYCA==
X-Google-Smtp-Source: ACHHUZ4LRkx/6YsdhklEs/2vurTILxouu44+3QT3dOA1O72v+gTZjxf++gH4zzIh+dIYs6Tt7TknXQ==
X-Received: by 2002:a05:6a00:15c1:b0:64c:ae1c:3385 with SMTP id o1-20020a056a0015c100b0064cae1c3385mr866272pfu.32.1684350845462;
        Wed, 17 May 2023 12:14:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f13-20020aa782cd000000b0062e63cdfcb6sm16005552pfn.94.2023.05.17.12.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:14:05 -0700 (PDT)
Date:   Wed, 17 May 2023 12:14:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] scsi: ibmvscsi: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305171214.77A5A62DD@keescook>
References: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:34:09PM +0000, Azeem Shaikh wrote:
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
