Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1FA717898
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjEaHsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjEaHsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:48:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743CE12E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:48:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5147a478c38so8026709a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1685519287; x=1688111287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWWD4qbrDGR/HBs5xD9X3UlB8CGkHV7RogTz7x4M/JE=;
        b=lT56eC8mwkDEWQDguBfL84f/lKDJ43KNHh1ld0+DfdyNcycS9Eu1K2SWmsy1X0wm8V
         8zPIvgWM0TuIdPIkeJYvMMG1ipaxZje9PCI8i/0GE3el3UboDkwFUEYYFlm/0+NMugjh
         l1nOk1PgdGLdD1475IyXC4313FQef5hlXMDyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519287; x=1688111287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWWD4qbrDGR/HBs5xD9X3UlB8CGkHV7RogTz7x4M/JE=;
        b=S4gESArftOsA6mwRj+d7Qe0DqHWo7DUqvAEK5GcrFoOMym53cb8V3tU3SyjaPTd18/
         JBoyQbQof+oZPKPEyOq90Sfp1C7mZllDxWS0rkiCWSX43UFdiGH5VJF8psk3sv+SO2QX
         hPkDF6rRhPwlNK4XDcSphTQHTP200TQLI9v79cdS38YGUHswUFdqTlV+SRHbpOMIi4gD
         bwbGHjMd/UVaTpvB3mEVbHx+8WFcphDOoOTgN7v6t03m70ZgBXgDTK5Hn4u+qPJO44Zz
         ZBl84r0uK8g7Gy2SkDI5LyZ39FsYVX04zq/JYgRXDME171e9X1AVB2fAmjOVusXFLl9A
         sovw==
X-Gm-Message-State: AC+VfDy9DRgHCn+RwtY/0s8b38IIP/zXW8o6kPHrY2BnytLY3ZojScMe
        bHQvc+cwRyqh2swlhIuW2qt7zHpk8qYjXBfqC3I=
X-Google-Smtp-Source: ACHHUZ6pkBfDsqDexyslBugO5nUPJK/53IRAI5RdrndNQJTnap6QybNHFEorZ1hEzuPkAkVUPSm3Ab12n9uQCvr/WBc=
X-Received: by 2002:a17:907:1694:b0:94a:74c9:3611 with SMTP id
 hc20-20020a170907169400b0094a74c93611mr4133845ejc.35.1685519287071; Wed, 31
 May 2023 00:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230412185602.1592629-1-eajames@linux.ibm.com> <20230412185602.1592629-2-eajames@linux.ibm.com>
In-Reply-To: <20230412185602.1592629-2-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 May 2023 07:47:54 +0000
Message-ID: <CACPK8XcK7s44VzkDyA6O3CKKGCfSsV=nmtwkf6YwV-9ZDAx63A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsi: core: Lock scan mutex for master index removal
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 at 18:56, Eddie James <eajames@linux.ibm.com> wrote:
>
> If a master scan occurs while the master is being unregistered,
> the devicecs may end up with incorrect and possibly duplicate names,

typo: devices

> resulting in kernel warnings. Ensure the master index isn't changed
> outside of the scan mutex.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index fcbf0469ce3f..18d4d68482d7 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1354,12 +1354,12 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
>
>  void fsi_master_unregister(struct fsi_master *master)
>  {
> +       mutex_lock(&master->scan_lock);

The ida functions are supposed to not require locking, but protecting
against the test and changing of ->idx makes sense.

Do you want to add a Fixes: line?

>         if (master->idx >= 0) {
>                 ida_simple_remove(&master_ida, master->idx);

the ida_simple functions are depreciated, at some point we should
replace them with ida_alloc/ida_free.

>                 master->idx = -1;
>         }
>
> -       mutex_lock(&master->scan_lock);
>         fsi_master_unscan(master);
>         mutex_unlock(&master->scan_lock);
>         device_unregister(&master->dev);
> --
> 2.31.1
>
