Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A150712CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbjEZS47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjEZS45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:56:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EF187
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:56:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b011cffef2so9018315ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685127415; x=1687719415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DSj23Ygy/LeYNL160hb36OKyVMmbtWslUUZxoLYre8k=;
        b=WV6iS7vdC0UyPONyu3GoVHaX/teq0aAOLnDLc+HEfVRIqo2rwUOqFmyu8lYG+LEDp+
         miDg5XiFHrFiQhKLHYOcDDEXAK8nC1kgJCnPN+6gR8NM0kgXbiHLvy7dSHZo8znmSUpz
         3vOP/Eka5f9wGc0ieRzLs6SstQEZDpzEEhfJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127415; x=1687719415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSj23Ygy/LeYNL160hb36OKyVMmbtWslUUZxoLYre8k=;
        b=E8RZzyc87OuBW7VJcfg44UIF0lUOgGl0Ge2Zg07wQ3y7e88qDL/P2hS8BK1TvGPIcl
         9b7TyH59UsY1JLfbV9fKkzPZcyxcYhHLZ2D8Z6VqsIaWWAkjNYhhThuYnNiTSyc6aqn8
         eOuTdyhpUV7PnDBB+iv61BBY6kkeECGT28uqXMXVgl2MysmyH1nPHhlqAVNEOi3oYG4K
         TYXDLGeN7kQ3h9d2rMMUlwD1kJCXZgc+7hcqxuR3i4QPCuHLHLbwwkrR2vA2ZYqNOh5L
         YzbXntxOgSiRNfuKARZaqZh9hjz70m77YKmPDXuc7YOnCD2Q5wlclwxBnqZcx/kPOYE1
         d6Pg==
X-Gm-Message-State: AC+VfDyXlmO4C9Eal91n1UAZJqQWbdzOM1z+txFhWuO1AYPkHZ97Vroz
        gM3d0stqjBhNfU2CRdYzPcUQoQ==
X-Google-Smtp-Source: ACHHUZ4pa9oCfs3Tr2WIutfaZtF57hm+Ea83Uk/wzE0Jj+t+Z+a87Gy1lY5t1tm19stAI9Hngey7OQ==
X-Received: by 2002:a17:902:e806:b0:1af:d00c:7f04 with SMTP id u6-20020a170902e80600b001afd00c7f04mr4614891plg.12.1685127415577;
        Fri, 26 May 2023 11:56:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b001ac5896e96esm3565658pln.207.2023.05.26.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:56:55 -0700 (PDT)
Date:   Fri, 26 May 2023 11:56:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     ojeda@kernel.org, qing.zhao@oracle.com, morbo@google.com,
        llvm@lists.linux.dev, trix@redhat.com,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, gustavoars@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
Message-ID: <202305261156.67CDEE933D@keescook>
References: <20230517190841.gonna.796-kees@kernel.org>
 <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
 <CANiq72=38mdTnJ3cicgwPB2xWqtbnGsL8Rtr4pwq7xGRr-m=Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=38mdTnJ3cicgwPB2xWqtbnGsL8Rtr4pwq7xGRr-m=Wg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 07:47:03PM +0200, Miguel Ojeda wrote:
> On Fri, May 26, 2023 at 7:16 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > FYI, applied to for-next/hardening:
> >
> > [1/1] Compiler Attributes: Add __counted_by macro
> >       https://git.kernel.org/kees/c/86a76e91cbab
> 
> Sorry, I was going to apply it soon -- in case you want it:
> 
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

> And thanks Nathan for resubmitting the `Reviewed-by` from v1!

Yes, apologies for missing this in my v2 submission!

-- 
Kees Cook
