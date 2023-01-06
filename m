Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237386608AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjAFVPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAFVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:14:59 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007381C2E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:14:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id e21so1995691pfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwOLnK2ifzFuyr165LNzqz5GnvMFyliD+SS3u04GcaQ=;
        b=fQ3uOApcxQR/IsZivYDkfhBOj3GhwFU3tAsLTFuEVAPRPR10Inv7wS4kVorYVsJLlG
         8n0xE/1sTmVOH0hu+adBfEjI8JaSxtmQsvOScWoHbuCb/zC7iXJRmVjUi/zMHRyp1Woj
         aIkxixCOv2op1sVjyL0pqY0STzhYHHIKifcn+SV2YQ7lkhVjAP0pQ0BDvW7rWSaf9BcM
         FbrWjT1sIdJKfH5SiffG/z0ZWEfSoZqDaCViQqjeNsv5lVZHXzUN/xFq4XiDMSOWk69M
         Dl+f8JPEzAA1dBCgkT8/ssw8M92FVA43pnEzRE7ZHzoxOquhEfiJ7M967D5W8gGtWKtV
         vDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwOLnK2ifzFuyr165LNzqz5GnvMFyliD+SS3u04GcaQ=;
        b=koMJA181cbtC5CM8dCP2KKGK9ekUbWBplSMAJdQmJF+FHw9iqUoVt8gT5fHD0YCUGW
         aGVNwQi3LQpRnF4PLPK1qvyWWdebkKMy7Ujc1Iv3qZ2VfkY3Bt26Pfg1lEi4PhL0cRlz
         TOaBMYnsiC7Oec6YKaWODOIpH+rr1+G/qmG46BYuAUnzP6vejUEOrkQkhdnZZO6Q20cn
         oml8U4FZyXZ4vgz/xyNY0ZWmU4yuL6wSGu2cVr19I8V2kbqOdVPx7o6vOPb3e6vr2Hq7
         bnIo+SyesRyrGLBxBveTwvEwJJVTAQ2xG3/NgdJ7hZA00LJ90/ArgzHmEaR7TzggQbd8
         115A==
X-Gm-Message-State: AFqh2kqwtaPpN+d7eC5fj/WqOf5A8Cd0YG/hhMmqxHyqrUJYg/7EGFN1
        r6DdZ7ySwRmOrF1QAIpCtkdf6FAMQ1ABpvj1hXY8
X-Google-Smtp-Source: AMrXdXunbq8svWmpL5uzJpDIG9dH1bnChWXrVS5uoNEeJGgqDMuv7i47INaTjXl1feUFwaMf91aGmisI+GELaFzB0V8=
X-Received: by 2002:a05:6a00:1345:b0:582:5f1a:97c2 with SMTP id
 k5-20020a056a00134500b005825f1a97c2mr1477126pfu.3.1673039698452; Fri, 06 Jan
 2023 13:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20221221141007.2579770-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221221141007.2579770-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Jan 2023 16:14:47 -0500
Message-ID: <CAHC9VhQUAuF-Fan72j7BOqOdLE=B=mJpJ_GpR5p5cUmXruYT=Q@mail.gmail.com>
Subject: Re: [PATCH v2] security: Restore passing final prot to ima_file_mmap()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 9:10 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Commit 98de59bfe4b2f ("take calculation of final prot in
> security_mmap_file() into a helper") moved the code to update prot with the
> actual protection flags to be granted to the requestor by the kernel to a
> helper called mmap_prot(). However, the patch didn't update the argument
> passed to ima_file_mmap(), making it receive the requested prot instead of
> the final computed prot.
>
> A possible consequence is that files mmapped as executable might not be
> measured/appraised if PROT_EXEC is not requested but subsequently added in
> the final prot.
>
> Replace prot with mmap_prot(file, prot) as the second argument of
> ima_file_mmap() to restore the original behavior.
>
> Cc: stable@vger.kernel.org
> Fixes: 98de59bfe4b2 ("take calculation of final prot in security_mmap_file() into a helper")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index d1571900a8c7..0d2359d588a1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1666,7 +1666,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
>                                         mmap_prot(file, prot), flags);
>         if (ret)
>                 return ret;
> -       return ima_file_mmap(file, prot);
> +       return ima_file_mmap(file, mmap_prot(file, prot));
>  }

This seems like a reasonable fix, although as the original commit is
~10 years old at this point I am a little concerned about the impact
this might have on IMA.  Mimi, what do you think?

Beyond that, my only other comment would be to only call mmap_prot()
once and cache the results in a local variable.  You could also fix up
some of the ugly indentation crimes in security_mmap_file() while you
are at it, e.g. something like this:

diff --git a/security/security.c b/security/security.c
index d1571900a8c7..2f9cad9ecac8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1662,11 +1662,12 @@ int security_mmap_file(struct file *file, unsigned long
prot,
                       unsigned long flags)
{
       int ret;
-       ret = call_int_hook(mmap_file, 0, file, prot,
-                                       mmap_prot(file, prot), flags);
+       unsigned long prot_adj = mmap_prot(file, prot);
+
+       ret = call_int_hook(mmap_file, 0, file, prot, prot_adj, flags);
       if (ret)
               return ret;
-       return ima_file_mmap(file, prot);
+       return ima_file_mmap(file, prot_adj);
}

--
paul-moore.com
