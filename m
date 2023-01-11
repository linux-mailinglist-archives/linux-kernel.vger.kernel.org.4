Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2103C666226
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjAKRj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbjAKRiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:38:24 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19CFF5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:38:09 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id i9so23427297edj.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGJIgTfN1JjipHMjfss98PcNNaUF4CupCyImB+zTYVA=;
        b=VgUDCd35ZV4b9NgVdhY0e/S1SfN19SCzxhT92VFaiAU86cGKPmv5ifpPDpJWwVGHmM
         /6+8sFsU2DV4+zdnp+x81oa6ZIdYKaa8fh28Zkub1r68FP1odISuNYzamOxj/tKyC74p
         7CKfLeN49DbWIQpQ67HwVl96tWbRjGu8orlHRNcNkQ0GR70kCCRqM6oz5Jkthx6jbSR+
         XyLo5wDNUyLY7r3ixnTRZ5PxJxRts8NX/YEHqD+NtsfB5RbiRw7cUOSW0kNLFnJeTXl7
         UiH4zHXaZsOjshBY5FLIaolwXCkwJlyjYZmBYcciUVWr9qDGC9/hNxTSYfYTIu59jjIY
         H/PA==
X-Gm-Message-State: AFqh2kpabkZWeB7Ed+tm3XY8F0WtTHXnSwQZwnJmi94ztPJPUp8gZuOF
        RZrL6/10nep+6TAY6EBW4WDH3GmIfwKHXxm09N8=
X-Google-Smtp-Source: AMrXdXuvXNzdUgSIja1KA3Rr50AiKdw8p/UnfAsVIfcgKm26m5j3ZjxX5r+71MfY4+1267boeE9h+sVHIFeqbQwGItE=
X-Received: by 2002:a05:6402:5c5:b0:46d:53d7:d1f6 with SMTP id
 n5-20020a05640205c500b0046d53d7d1f6mr7508909edx.211.1673458688125; Wed, 11
 Jan 2023 09:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20230111113018.459199-1-gregkh@linuxfoundation.org> <20230111113018.459199-17-gregkh@linuxfoundation.org>
In-Reply-To: <20230111113018.459199-17-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 18:37:56 +0100
Message-ID: <CAJZ5v0hSxG0VL8RuQ-7rb_6s7X9shT-Bwy4PR6bHVV3Ka1pdxg@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] kobject: kset_uevent_ops: make uevent() callback
 take a const *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:30 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The uevent() callback in struct kset_uevent_ops does not modify the
> kobject passed into it, so make the pointer const to enforce this
> restriction.  When doing so, fix up all existing uevent() callbacks to
> have the correct signature to preserve the build.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Christine Caulfield <ccaulfie@redhat.com>
> Cc: David Teigland <teigland@redhat.com>
> Cc: Bob Peterson <rpeterso@redhat.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: cluster-devel@redhat.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c     | 4 ++--
>  fs/dlm/lockspace.c      | 4 ++--
>  fs/gfs2/sys.c           | 6 +++---
>  include/linux/kobject.h | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 72ec54a8a4e1..b0cee0f30d8d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2387,9 +2387,9 @@ static const char *dev_uevent_name(const struct kobject *kobj)
>         return NULL;
>  }
>
> -static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
> +static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  {
> -       struct device *dev = kobj_to_dev(kobj);
> +       const struct device *dev = kobj_to_dev(kobj);
>         int retval = 0;
>
>         /* add device node properties if present */
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index d0b4e2181a5f..9b6cfc4c30e3 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -215,9 +215,9 @@ static int do_uevent(struct dlm_ls *ls, int in)
>         return ls->ls_uevent_result;
>  }
>
> -static int dlm_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
> +static int dlm_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  {
> -       struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
> +       const struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
>
>         add_uevent_var(env, "LOCKSPACE=%s", ls->ls_name);
>         return 0;
> diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> index d87ea98cf535..d8dfabb0bc12 100644
> --- a/fs/gfs2/sys.c
> +++ b/fs/gfs2/sys.c
> @@ -767,10 +767,10 @@ void gfs2_sys_fs_del(struct gfs2_sbd *sdp)
>         wait_for_completion(&sdp->sd_kobj_unregister);
>  }
>
> -static int gfs2_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
> +static int gfs2_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  {
> -       struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
> -       struct super_block *s = sdp->sd_vfs;
> +       const struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
> +       const struct super_block *s = sdp->sd_vfs;
>
>         add_uevent_var(env, "LOCKTABLE=%s", sdp->sd_table_name);
>         add_uevent_var(env, "LOCKPROTO=%s", sdp->sd_proto_name);
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index 58a5b75612e3..bdab370a24f4 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -137,7 +137,7 @@ struct kobj_uevent_env {
>  struct kset_uevent_ops {
>         int (* const filter)(const struct kobject *kobj);
>         const char *(* const name)(const struct kobject *kobj);
> -       int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
> +       int (* const uevent)(const struct kobject *kobj, struct kobj_uevent_env *env);
>  };
>
>  struct kobj_attribute {
> --
> 2.39.0
>
