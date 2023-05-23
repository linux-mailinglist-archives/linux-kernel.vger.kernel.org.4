Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D75870E2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbjEWRFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjEWRFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:05:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24956B5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:04:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64f47448aeaso10068b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684861498; x=1687453498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhFkuNdU3RaSjvEtwO+y/7ecKvyCxdBlxw2Du+ZEjV0=;
        b=MqpM42aQRI8ph68RBJUNu9y7y5/zbk0lexhnWzEHDaVozMUf2QZJiRhNvzjbOMZyar
         KcyfpLCKEttgYvBwNGF1lrT2UM+BIE/9QpJGfR8c/up0eGl2p8gaM4Mp28AKbtzjb7AF
         5DaO3affYplmoINg1LOMGrb3Dm+GDL/dKas3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861498; x=1687453498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhFkuNdU3RaSjvEtwO+y/7ecKvyCxdBlxw2Du+ZEjV0=;
        b=bFUlQyeULF1J3GAi+Tpld7FPEged7xB+rwMoBIWoK/Oja6X7JyEbZBqL1H4qjKmzDl
         0CXUiIhejWYWkOuSWhd/Xoq6hgn2ngCiPYKWEjnx1ZwyFVrYOOcFLkZP4uCIb6oXmcIg
         LeP1vBNZuAAG1U77Fz+O0YwP2JhqUHWHoYshdu4E6M02txepysAYmNg/mPwewCLEkIai
         Q2ar6F6mrGyqYpoyU71e45QMwguxKP1DVSrgAcnTymTaFMTRMMjAB74VRK0z2iThhsPA
         HcgeL1a7w4K1GlpMDAEkUsfIcb6qfpfbS/dF8LBiR/sxA+jUYPM3ChKYDLDPPZHc++v8
         Q0cg==
X-Gm-Message-State: AC+VfDyN+F5eKt2YRHL9lqSWGCdY+04F4OziVo72B21dqryF/hArI1Ni
        z4dhaFEMUZjDEZV5AhhS+oVhbRSkr4pHmcf7+pU=
X-Google-Smtp-Source: ACHHUZ4C5ACZqIuLvNOviGcFe5FNlvLcov5GqImR93+0T2n48F8wmgporLkFQ2YeewVG5bRNiRQXSA==
X-Received: by 2002:a05:6a20:258b:b0:10c:5745:3f44 with SMTP id k11-20020a056a20258b00b0010c57453f44mr3697979pzd.61.1684861498587;
        Tue, 23 May 2023 10:04:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h37-20020a631225000000b00520f316ebe3sm6181002pgl.62.2023.05.23.10.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:04:58 -0700 (PDT)
Date:   Tue, 23 May 2023 10:04:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell/cesa - Fix type mismatch warning
Message-ID: <202305231004.DC22DCDC@keescook>
References: <20230523083313.899332-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523083313.899332-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:33:04AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") uncovered
> a type mismatch in cesa 3des support that leads to a memcpy beyond the
> end of a structure:
> 
> In function 'fortify_memcpy_chk',
>     inlined from 'mv_cesa_des3_ede_setkey' at drivers/crypto/marvell/cesa/cipher.c:307:2:
> include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   583 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is probably harmless as the actual data that is copied has the correct
> type, but clearly worth fixing nonetheless.
> 
> Fixes: 4ada48397823 ("crypto: marvell/cesa - add Triple-DES support")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Gustavo A. R. Silva" <gustavoars@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
