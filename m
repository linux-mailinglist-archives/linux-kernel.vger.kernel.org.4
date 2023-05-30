Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C117170F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjE3WtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjE3Wsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:48:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC8E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:48:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso253738a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685486932; x=1688078932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99ubBmKAtal9ov3803GoR+21e+FgeWOsucCxQBKs674=;
        b=YT2bb4MCyOTr91hgg+9DRVqf/odg8pMgOXdB7UU7tyowTWkoE3uz6xFCP4z+UsH4pw
         5DK0+XWBXYXUDipIdD/maEgVXjP4Q8mKZ8Ky+2t5z7hiTslUYv3QBOcQeJ355wwkRm1f
         TPqVLeuKvAuqkqEOip+4FvIqxMgIaBIVPoVfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486932; x=1688078932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99ubBmKAtal9ov3803GoR+21e+FgeWOsucCxQBKs674=;
        b=WcMErtmtpKjwL7CFWMDRKtugq/3pr64CNjiHUW94Z8BHMZiTv39lbMA+sY6eNMcMnm
         d4tyIeBlpqHi63dQuZyWDVHp7WptrT0BJ90aksK7ZEKtjpzvImie7cReDHKd4HMHKAxo
         X5hgwLsBl2+JD6Gp3Vm9miLSGZS44mvHEspLQwl6X6VCgiHnAf1id0l3N5NTxgSOQsDt
         1DnKBljULyOgRtLOZKT21OVUP1eBqbxyrfiRw2zb5VQscXkUZOrubflPoaFM8cRYuD1g
         N7jgkTlrcXRno4D83o0a3hMb95Tnd1NbYLPHlvOrcxfAcImkF0rbY0qMd7bD/ok1EuTr
         1VZg==
X-Gm-Message-State: AC+VfDzp88IllDp/pid2hkVMdyUIQs3FImXffMOyh3NFUMd4BxHDE+4X
        IhOuUles6AtTUq4b4dGec8+oNg==
X-Google-Smtp-Source: ACHHUZ4ZfX0kxGPUegN/GzRK8B0dJT+aiebhYPAYaCZ+ZPMwmlkqk68mb6hZFGglN/bPxdauoAi4kw==
X-Received: by 2002:a17:90a:bc88:b0:23f:9445:318e with SMTP id x8-20020a17090abc8800b0023f9445318emr3957040pjr.3.1685486931842;
        Tue, 30 May 2023 15:48:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b002508d73f4e8sm58034pjv.57.2023.05.30.15.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:48:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     arno@natisbad.org, arnd@kernel.org, schalla@marvell.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        bbrezillon@kernel.org, davem@davemloft.net
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell/cesa - Fix type mismatch warning
Date:   Tue, 30 May 2023 15:48:49 -0700
Message-Id: <168548692863.1302890.6789778742527600870.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523083313.899332-1-arnd@kernel.org>
References: <20230523083313.899332-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 10:33:04 +0200, Arnd Bergmann wrote:
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
> [...]

Applied to for-next/hardening, thanks!

[1/1] crypto: marvell/cesa - Fix type mismatch warning
      https://git.kernel.org/kees/c/37f3abddda8d

-- 
Kees Cook

