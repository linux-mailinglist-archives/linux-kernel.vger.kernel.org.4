Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653766E6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjAQTVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjAQSyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:54:54 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F675AA69
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:18:06 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q64so33239269pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0fpJFz+uumjj7KE/lorb8wR6u11JYG6vZ+zsVfls5E=;
        b=VBrRf9pTr/4IPYNmGourNvutyd/ceeVLNpGDPjYtcjudgwi8bWs3X2fID1pp4T6P9x
         kCxV6g3thz6inwVNXqUomT28JPS2ASsErK+GnX32+XdchqM1ZA9rZp1L54MNryjAKc2D
         3Y8dbKLBCXTr72HwAJPkq9mYKDdLlO9Ww4JA9vgJ+ariun+1gAwsRGjIgOetyIN/lKC8
         pBlvSQCFm1kfkCg1oJ0Gp9WU//JwlAYAoqDqvoUs0678SECg+yGXEuLIzQdsvAU9uMH/
         hlHBXvoF3ljJyon0Q4DggoJ1vVF1vkwaLkoZSDQW6aEmLBQARFMreCm7uLanSV6HKBfZ
         0xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0fpJFz+uumjj7KE/lorb8wR6u11JYG6vZ+zsVfls5E=;
        b=GldjtVdwafqZrUVnVONkV5LxcyQZdeq2ZN4nlRdSoT/RkmeyfmHJMm3TpTKg36k2M1
         W9VOJj4klfGPanSIq7uK9/gl3mFvxRaYkgzI77K4KZadszMBuSOojzfWIOIT2lJZ++xR
         S8QiQCfbbJTkCXxoo2eM6Ugpzd0fyZfTism1nFsVC/FZX18nYT4Lq1Cqdh81mqGHyyn9
         6G/N2itVuMi5p3Jc+a+i0qUnbWCBtc7pY9x2YVlzWf7Jik5J9ElcmnV0QNjRJGr8g+wr
         PlmFJSCHy9W0hTw5bSvte/2ytzP2sifNbnsyF6DcbhMHC+Dll16O1NY17tINPKucw+S6
         sy3A==
X-Gm-Message-State: AFqh2koMsKXXVy9J0rrSgQIAV3pEf3SjC+HIYsE9SnMslLTisT84DLoQ
        kMLLGEmfCVoCSWU8gtdKf/jb3Ls2m7k0G53l1t4RzQ==
X-Google-Smtp-Source: AMrXdXsLciTK/2HzPHQv+ZKXUDNClH0QiJEUmRoQczErUi+3abrIY/ID2bNm4k6HDiWy8rkplZ05CxtNFA2LLMBhZzU=
X-Received: by 2002:a17:90a:c784:b0:227:202b:8eaa with SMTP id
 gn4-20020a17090ac78400b00227202b8eaamr359677pjb.147.1673979476682; Tue, 17
 Jan 2023 10:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20230110170848.3022682-1-trix@redhat.com>
In-Reply-To: <20230110170848.3022682-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Jan 2023 10:17:45 -0800
Message-ID: <CAKwvOdnde5qmYCsU1V4ccRn4tkEmPZLwJ2UFFLQfR-to7wLQTw@mail.gmail.com>
Subject: Re: [PATCH v3] crypto: ccp: initialize 'error' variable to zero
To:     Tom Rix <trix@redhat.com>
Cc:     brijesh.singh@amd.com, thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        nathan@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 9:09 AM Tom Rix <trix@redhat.com> wrote:
>
> Clang static analysis reports this problem
> drivers/crypto/ccp/sev-dev.c:1347:3: warning: 3rd function call
>   argument is an uninitialized value [core.CallAndMessage]
>     dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> __sev_platform_init_locked() can return without setting the
> error parameter, causing the dev_err() to report a garbage
> value.
>
> Fixes: 200664d5237f ("crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v2 cleanup commit log
> v3 cleanup commit log
> ---
>  drivers/crypto/ccp/sev-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 56998bc579d6..643cccc06a0b 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1307,7 +1307,7 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
>  void sev_pci_init(void)
>  {
>         struct sev_device *sev = psp_master->sev_data;
> -       int error, rc;
> +       int error = 0, rc;
>
>         if (!sev)
>                 return;
> --
> 2.27.0
>
>


-- 
Thanks,
~Nick Desaulniers
