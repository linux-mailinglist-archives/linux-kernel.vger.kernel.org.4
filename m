Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2667F14C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjA0WnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjA0WnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:43:14 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7B04A210
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:43:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 88so5949751pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WmZkqsaxGsxQVAXbyc3t7DBRwM/9VryKi+3Pr7qmZDM=;
        b=EHEuRJwyc3aEnvPQ3LoS4NKvPJJkNLp5KseEGyAq2wF9rZ8ro1RFeYADPeEMdRsehS
         bE8CKiS29ezfHzwcmtCt3DgNyhhtmPWNw+BaWyQ+q6Vl7OXhbPtMqGhbB4xCCgRoY/Fh
         YqT+syA3CishdtD5tz8Ec3wxHW/07PLDnW2qrQPWNdeFTLa8cnRQ4nLoy7kqB/xoUvCP
         PYXxD9nfnhArpnRu0ECP7JdSSJBsbA8f3kaxYLc0YoLrrSdXRWu9A/u+O86d6t/uikGJ
         mG/PY80YDpxlQaB6vnXeKB/soKLVjTgo0zIBy9KJoKyEvAeID18y8fHVJYeMmMTlliYC
         7FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmZkqsaxGsxQVAXbyc3t7DBRwM/9VryKi+3Pr7qmZDM=;
        b=0ddZGeaJneVN0oQn3BapSZtiw1ulfSsEGVY6HSVS1E4FL3vX3vbqrjiaKAq0KGC0N1
         Pr42dfVAUK2vfPTe/xfAIyzvpJd1lc/yFncUnMNop6qkWYXKxsNMC2oeBBdHAmRg7npe
         3BDfr89Xp3hXnhjxmDyiC4xmnc+KELUpijw30HDRsdexTSE59Zsc4BOLdeRc9FdjP61H
         EZQbAUsgYg01oh3G9z/jVKCr50OtbT4dEKOObuMzUOSGjkdqTF/9SSd0WFfn4lRf2nPE
         9zxI/lwhi1ZwaSLqzpGA0a8ZKp3XZmsFaDm9z2UNvDKwKXNnZ2Rol0F6v0Vq77dQjCwU
         2Pvw==
X-Gm-Message-State: AFqh2kpq/+agV6G0zUAJw5dc1OQbbs8v5U7e6ZbiT3ocPrhUQoQiRIHa
        Rs+mzEAQSFan7tXAUblsMmxKI9CHw+2QgPPfnt9b
X-Google-Smtp-Source: AMrXdXustphmqNFUVCzyCLlM6K9y5ETwjauqRlKHwVZFt4XVnBeuiN5gqhYBOfGFydEDeSZxy4iglGTbZndDf10aDKs=
X-Received: by 2002:a17:90a:5b0c:b0:223:fa07:7bfb with SMTP id
 o12-20020a17090a5b0c00b00223fa077bfbmr5374291pji.38.1674859393131; Fri, 27
 Jan 2023 14:43:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674682056.git.rgb@redhat.com> <f602429ce0f419c2abc3ae5a0e705e1368ac5650.1674682056.git.rgb@redhat.com>
In-Reply-To: <f602429ce0f419c2abc3ae5a0e705e1368ac5650.1674682056.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Jan 2023 17:43:02 -0500
Message-ID: <CAHC9VhQiy9vP7BdQk+SXG7gQKAqOAqbYtU+c9R0_ym0h4bgG7g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] io_uring,audit: do not log IORING_OP_*GETXATTR
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Stefan Roesch <shr@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:24 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Getting XATTRs is not particularly interesting security-wise.
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Fixes: a56834e0fafe ("io_uring: add fgetxattr and getxattr support")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  io_uring/opdef.c | 2 ++
>  1 file changed, 2 insertions(+)

Depending on your security policy, fetching file data, including
xattrs, can be interesting from a security perspective.  As an
example, look at the SELinux file/getattr permission.

https://github.com/SELinuxProject/selinux-notebook/blob/main/src/object_classes_permissions.md#common-file-permissions

> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> index a2bf53b4a38a..f6bfe2cf078c 100644
> --- a/io_uring/opdef.c
> +++ b/io_uring/opdef.c
> @@ -462,12 +462,14 @@ const struct io_op_def io_op_defs[] = {
>         },
>         [IORING_OP_FGETXATTR] = {
>                 .needs_file = 1,
> +               .audit_skip             = 1,
>                 .name                   = "FGETXATTR",
>                 .prep                   = io_fgetxattr_prep,
>                 .issue                  = io_fgetxattr,
>                 .cleanup                = io_xattr_cleanup,
>         },
>         [IORING_OP_GETXATTR] = {
> +               .audit_skip             = 1,
>                 .name                   = "GETXATTR",
>                 .prep                   = io_getxattr_prep,
>                 .issue                  = io_getxattr,
> --
> 2.27.0

-- 
paul-moore.com
