Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF06664609
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjAJQ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjAJQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:27:49 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5AB69B3A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:27:48 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so19287682lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=24b794oj7rHXD9kyGoCrHN+Vr9labBoVEJJqpRMaDe4=;
        b=YNVqHnxtOzQXgjbziYxPO8GNC7zCx3fYhOSnkxKEkOXp1MfydHcJtE8amfV4sYE+I0
         NcRsUKYzPLBlNrXccUbhCUhhtctYtGRko2Z4YwCqJM5WLEveWWedg15VOVBWF7ZsLRqj
         6n7GYYKK5lEelGx+dqR8nzmW6MpOtue07HicKDX25nB/Pv24Aq6qE/Rd+ttnM0oaNpYR
         Cr3OULPpuXwj3NW/ckiNNvY04oeCPndIgrR6Se/JV+z8naSMxQjCAc7FhAcsYqASjVks
         Zp1U4Sd6EDVF4StNiAregq+zcabhcsezlIhO3Ry8twGUCTStdahNTKgiaSJhoAQoV6c5
         ZOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24b794oj7rHXD9kyGoCrHN+Vr9labBoVEJJqpRMaDe4=;
        b=ME6MUedZPuFXxH8hchmXU45aiCy/iBRTyrpl69X6iqlMA8ntZdKaAq4d0+XPOiA6zz
         oGoeBStYrfFwt5HxojEGB1P9r2CodKWw6aUxo4lfL5nniZKNmwBz2hz+Hra0t504W4nu
         anQl05rBp8drTyaYXz0yqmNIaRZKLEzmZ93F3U8H2ywVAe5Sl4cwVH9mw4gctbklsPXa
         VMeORdWwevuN56iChU/LQcD/X5EbfB/1Kg+ksG+EPGtNZvgQvtMAE7tR5evwnDafRS/K
         xEqxERBr2qksoF8rpfMUKYEKZFpZsOMI6ES/fNg0f1VAveQE9sF7FTy0+2jB6DFsJ1py
         yHXw==
X-Gm-Message-State: AFqh2kryB7kkC2O48TnweKtIp3IPZwyM0I3EKNjBgyO8jlg5C18mSC4Y
        2F2BULkizgPBxx9/x6LCFQd8pTj1dkDWAhLjkvZaig==
X-Google-Smtp-Source: AMrXdXt9wWOWy5EEMwM3AwaHi7iIfQmcidQBM/gYmtegbnbkafoWpleRQ0oZbfHkxxzlcOiEEcsllu7h8Id6At6K9HY=
X-Received: by 2002:ac2:4d90:0:b0:4b5:91c1:6f1f with SMTP id
 g16-20020ac24d90000000b004b591c16f1fmr7018844lfe.291.1673368066228; Tue, 10
 Jan 2023 08:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20230110161831.2625821-1-trix@redhat.com>
In-Reply-To: <20230110161831.2625821-1-trix@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 10 Jan 2023 09:27:34 -0700
Message-ID: <CAMkAt6oqBH35=moST5nO_BXwc8k0M4h_8TvT9H6outR9vOw5qg@mail.gmail.com>
Subject: Re: [PATCH] crypto: initialize error
To:     Tom Rix <trix@redhat.com>
Cc:     brijesh.singh@amd.com, thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        nathan@kernel.org, ndesaulniers@google.com, rientjes@google.com,
        marcorr@google.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 9:18 AM Tom Rix <trix@redhat.com> wrote:
>
> clang static analysis reports this problem
> drivers/crypto/ccp/sev-dev.c:1347:3: warning: 3rd function call
>   argument is an uninitialized value [core.CallAndMessage]
>     dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> __sev_platform_init_locked() can return without setting the
> error parameter, causing the dev_err() to report a gargage

garbage

> value.
>
> Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")

Should this be: 'Fixes: 200664d5237f ("crypto: ccp: Add Secure
Encrypted Virtualization (SEV) command support")'

Since in that patch an uninitialized error can be printed?

+void psp_pci_init(void)
+{
+       struct sev_user_data_status *status;
+       struct sp_device *sp;
+       int error, rc;
+
+       sp = sp_get_psp_master_device();
+       if (!sp)
+               return;
+
+       psp_master = sp->psp_data;
+
+       /* Initialize the platform */
+       rc = sev_platform_init(&error);
+       if (rc) {
+               dev_err(sp->dev, "SEV: failed to INIT error %#x\n", error);
+               goto err;
+       }


...

+static int __sev_platform_init_locked(int *error)
+{
+       struct psp_device *psp = psp_master;
+       int rc = 0;
+
+       if (!psp)
+               return -ENODEV;
+
+       if (psp->sev_state == SEV_STATE_INIT)
+               return 0;


So if !psp an uninitialized error is printed?

> Signed-off-by: Tom Rix <trix@redhat.com>
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
