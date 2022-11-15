Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60B562A19E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiKOS7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiKOS7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:59:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9B24962;
        Tue, 15 Nov 2022 10:59:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s8so8779811lfc.8;
        Tue, 15 Nov 2022 10:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m8W/0pY0U0/YdEIdwLzpMd90XGiJVa107n2xUOXTtzI=;
        b=YCV05GN19uBSTv2O3yqeIqJiaYtG17bkaWOAhO2RO720T7T7oeBpFZ5WVRHZPyBcR3
         FjlLo5voVc5ek6ikFUlEMO8pkRz7pxPlqjR1a6qimPrz/QGQbVxXdR+pHWMkJTr6AsoB
         yo+R+Dym3E04WHHTy2FSMTRD+mYonFztVnYpKVWDnXqiyg6YCbyqN1pYV8dnkC1Hr8Vq
         /pVFoVYN4W1cpDqCvEVZbOD1EhS+nV5ElutWA/TNax8AGsdbxdki3t++u2ssR44Na+J4
         2mZqbL/3/xoCEH6i/3LiNhiHn6vPyKeK3VKrJrDkx7VH+kn+tjfcbABUC10EaWPZW8dY
         1G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8W/0pY0U0/YdEIdwLzpMd90XGiJVa107n2xUOXTtzI=;
        b=Vdaq4U5KSjD9ijd8hdaD3EiRzpT/KUGunVQ83xqsAItebMyldo459p3c/UVpw7XwXs
         L3VrwExN5JRaBZnaRf9zQdeNlH5w0rNkm6XZr2eNNPplOz/w8BLC7/qWGDPBzBwSZ9XT
         r+9GYZ5K8UgO2k8lsqu5H2w2MV/rUstSHXTGXilf60ivSlAO2Po6LZe+UwFvp3CBjddd
         e0YeHzQVMBji+wpgIjxJt4MdTqhWQt4TkS7cim8TFwBPTYHF2Mkcpvm9zZ5d1wlxgx0H
         oDbr2etOxHiALOTBuIyVxa0/EB7QltQPMb6inQdonYEWoQwOr1gt6YH9MsND3EFLQgDX
         SDXw==
X-Gm-Message-State: ANoB5pmCaBDlk24qk/063fgeexLVZypQgs1OmlDId7q2z6pv3IZZ+Kyu
        AvIYCh2heDDaH+Q3I+olmoszfPJdozwDIB9wq/8=
X-Google-Smtp-Source: AA0mqf5y3LwZWjhCawuga7fH/h6NG7Icta3bCFw/67wQ9nG9UkOVSb3d8XJy76j5N0V5Cx0wDPh0qB9hQe8PCjffaZ8=
X-Received: by 2002:a05:6512:138f:b0:4ab:534b:1b2c with SMTP id
 p15-20020a056512138f00b004ab534b1b2cmr5800959lfa.426.1668538756218; Tue, 15
 Nov 2022 10:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20221115142701.27074-1-abelova@astralinux.ru>
In-Reply-To: <20221115142701.27074-1-abelova@astralinux.ru>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 15 Nov 2022 12:59:04 -0600
Message-ID: <CAH2r5mtaTSih9X6Xzc0HTqRYSTx47vNzStMkXeWYzyXPMqzEFg@mail.gmail.com>
Subject: Re: [PATCH] cifs: add check for returning value of SMB2_close_init
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Aurelien Aptel <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
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

good catch.

merged into cifs-2.6.git for-next

On Tue, Nov 15, 2022 at 8:41 AM Anastasia Belova <abelova@astralinux.ru> wrote:
>
> If the returning value of SMB2_close_init is an error-value,
> exit the function.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 352d96f3acc6 ("cifs: multichannel: move channel selection above transport layer")
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  fs/cifs/smb2ops.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 880cd494afea..9737296c0fbc 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -1126,6 +1126,8 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
>         rqst[2].rq_nvec = 1;
>         rc = SMB2_close_init(tcon, server,
>                              &rqst[2], COMPOUND_FID, COMPOUND_FID, false);
> +       if (rc)
> +               goto sea_exit;
>         smb2_set_related(&rqst[2]);
>
>         rc = compound_send_recv(xid, ses, server,
> --
> 2.30.2
>


-- 
Thanks,

Steve
