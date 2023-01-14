Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49BC66AD39
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 19:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjANSLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 13:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjANSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:11:30 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F7B77B;
        Sat, 14 Jan 2023 10:11:29 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id x37so25746969ljq.1;
        Sat, 14 Jan 2023 10:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSlRoDTtSoPSgCdi+CZiZS3Sznec9wySQ545Pko7j/k=;
        b=Z8eXvudrG4nQzD8PfAyoxIhxbLNvVxnIrofwEXoHf8uz02oXhL2i5BvN8zAV8V8rJt
         u3C7YyUb2MeYY1GPqWkxpAhkdLEpe3SI8T94/ysVfIuMSXInnJQNGSONIP4GwqoJiD7N
         uF5buMMj6oOJi+bbO74m8kS/N7/SMzZfnF73Nu+8W/9tFDFfzS58t1DbCy+uD2xxaNX7
         IqoIYVHxDBhke6+gQRog682Z1+qLVD3ZLU8ysy09+MBIZTsJNCEmZ6XJVkLCUIlOhPOq
         O34XYAadIUNwFcmFh8UVkOT9MyHTEssVtdXFsi5J4aNBoACjcBSQ6oQiq4QhApMvkQ+S
         lNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSlRoDTtSoPSgCdi+CZiZS3Sznec9wySQ545Pko7j/k=;
        b=A/Y0mNDhr0lxRfttqbtlUxO5asx81zJntC6HqqLB/IGNfUJDZU6itha59914Xm9XBJ
         xf/xcOHvShNR+XsGVjiqEmphkCKeD9i/F5bHjs7yyQJKqF7uQ3X48be4K647zGTCUYy1
         SOdMwTlSGxwXNNSA6D/pSB1HDOSrtberzJQe2R0+Yse5ro39P0jIy6xRzWzuWm6LoDDF
         zjS93X6MCNIXa3E9oUQKQ6hy96Wz2VKrWAUowq0HDTudMjWyW8Vs4EhDZ3jYqPtJYaJC
         N5kdolAlpkvZmWGNvHltSS6y7O11IuEcafaJzaHS1gdZBfmAKV01/ku9hXF5iIUw1jQN
         2MLg==
X-Gm-Message-State: AFqh2ko0DkPf4YQIc+lACrunYuiWAPrBBoahUY+pXp3yILl8MOG56Wtu
        j1TtOwIeRiD8v3MD7oFDl3HkqFJTcramFb0Gea8=
X-Google-Smtp-Source: AMrXdXsegW3pLvFHzGQ24UgODjHyhq7rdd1Hqg+NWXOoist8eCemWI9UMRmUSycI6TzREF0sM3CTiOZ+G+VfBIPYeA0=
X-Received: by 2002:a2e:988b:0:b0:28b:7925:3d2 with SMTP id
 b11-20020a2e988b000000b0028b792503d2mr48626ljj.229.1673719887512; Sat, 14 Jan
 2023 10:11:27 -0800 (PST)
MIME-Version: 1.0
References: <b4cb5ccc96332ca81d6732b3063942186614eaa6.1673686651.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b4cb5ccc96332ca81d6732b3063942186614eaa6.1673686651.git.christophe.jaillet@wanadoo.fr>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 14 Jan 2023 12:11:16 -0600
Message-ID: <CAH2r5mvvVwSFf7y=YB0=gxGPOhVaN2zwNvFdRSh_E5Dk7hAMEg@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: Use kstrtobool() instead of strtobool()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Sat, Jan 14, 2023 at 2:58 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
>
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
>
> While at it, include the corresponding header file (<linux/kstrtox.h>)
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch was already sent as a part of a serie ([1]) that axed all usages
> of strtobool().
> Most of the patches have been merged in -next.
>
> I synch'ed with latest -next and re-send the remaining ones as individual
> patches.
>
> Changes in v2:
>   - synch with latest -next.
>
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  fs/cifs/cifs_debug.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
> index 56b23def4c95..612f0bb284c9 100644
> --- a/fs/cifs/cifs_debug.c
> +++ b/fs/cifs/cifs_debug.c
> @@ -8,6 +8,7 @@
>  #include <linux/fs.h>
>  #include <linux/string.h>
>  #include <linux/ctype.h>
> +#include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/proc_fs.h>
>  #include <linux/uaccess.h>
> @@ -787,7 +788,7 @@ static ssize_t cifsFYI_proc_write(struct file *file, const char __user *buffer,
>         rc = get_user(c[0], buffer);
>         if (rc)
>                 return rc;
> -       if (strtobool(c, &bv) == 0)
> +       if (kstrtobool(c, &bv) == 0)
>                 cifsFYI = bv;
>         else if ((c[0] > '1') && (c[0] <= '9'))
>                 cifsFYI = (int) (c[0] - '0'); /* see cifs_debug.h for meanings */
> @@ -947,7 +948,7 @@ static ssize_t cifs_security_flags_proc_write(struct file *file,
>
>         if (count < 3) {
>                 /* single char or single char followed by null */
> -               if (strtobool(flags_string, &bv) == 0) {
> +               if (kstrtobool(flags_string, &bv) == 0) {
>                         global_secflags = bv ? CIFSSEC_MAX : CIFSSEC_DEF;
>                         return count;
>                 } else if (!isdigit(flags_string[0])) {
> --
> 2.34.1
>


-- 
Thanks,

Steve
