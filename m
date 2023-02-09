Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49810691171
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBITh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBIThX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:37:23 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A2F2BF36;
        Thu,  9 Feb 2023 11:37:22 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id gr7so9659096ejb.5;
        Thu, 09 Feb 2023 11:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRQ+AqBQSo8wInSluRM33VrrcRj+TuOF6TCeB8K1fMo=;
        b=KnhyKhobG8EBoOSqMfpRcFMll7YJSkpMsetK7GzrEDpaOs2PAmAUZPlkHlEAI5Yefn
         TyGWmeE+x9SGeEZCgRF1Oh9fbctCkkq9tT+zAdBXEpmhbj0ngtrUKfr8FwOSxqNKsAG0
         +n6uCWrzUNW/P4vgEmlged38fIYCq/4MBXbC5X8gxJLGo2G9AoBTvpgSV8Z3NY6psnY/
         dt2bo0qy6bDJpyGax9VSCzRWeMJ3AoOzCuK/O+YJ5roNQbwBVYjqTR6QEcawghVTHBrn
         AiRRgxvE1q0h+E1UprW5WBNN8JSbHBtyeMIBu7iGsMeYLN6OQGSd7oZPWM7fVcm9QD+O
         XXfQ==
X-Gm-Message-State: AO0yUKUBqp+MiuDtXcPZgUPqF7/JGRIy+pTbalrKofXfJUZReFApE2kn
        Vq6Xawi8CVAfkc1Ichh21JSpO8nmXfAiezIdNTg=
X-Google-Smtp-Source: AK7set8AWc9FjJZ4cJ3vdZgcz5eCuoVCOc66/9AX590nDLt1MYnIqjzdWlX49FxX03GMogMn7OIFSN5xKGGRqYhJqD8=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2946159ejb.274.1675971441388; Thu, 09
 Feb 2023 11:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20230202151515.2309543-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230202151515.2309543-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 20:37:10 +0100
Message-ID: <CAJZ5v0ikyjgKfrnEk=yiK-KHas8QEC0-O_mdRCMvkeKS+uoovw@mail.gmail.com>
Subject: Re: [PATCH] kernel/power/energy_model.c: fix memory leak with using debugfs_lookup()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 4:15 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/power/energy_model.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index f82111837b8d..7b44f5b89fa1 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -87,10 +87,7 @@ static void em_debug_create_pd(struct device *dev)
>
>  static void em_debug_remove_pd(struct device *dev)
>  {
> -       struct dentry *debug_dir;
> -
> -       debug_dir = debugfs_lookup(dev_name(dev), rootdir);
> -       debugfs_remove_recursive(debug_dir);
> +       debugfs_lookup_and_remove(dev_name(dev), rootdir);
>  }
>
>  static int __init em_debug_init(void)
> --

Applied as 6.3 material, thanks!
