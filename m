Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D748F6D22EA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjCaOs2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 10:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCaOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:48:26 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EAA1D2C0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:48:25 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id ew6so90545305edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9yfdG+Ykiax5icMw+SbLxlU8RHfzLBC3pI270DeyJs=;
        b=srn63yGgm9TOTumcpf5az0eecczkR0kRXKsgWOAjNaYjjFD1YM/ewNtH11HW71J6me
         CEXjYm+pPwdjITLc8YVQfJ1KGRUNmhNff/5PRbsXMzYqekaRoPmVF9NEL77hp5g4r69o
         ZN3YKoJ1MovmDI/PBEoUiNtSJD2VX4uk1EHxIs3tFAx7FbfgAC7rPEVPj1l+PUkTNJQu
         7vjRZR6qgGA8da6IQUsAnue+w9SOyu0meinbS5P6pRcvSiv1MvsDwGxLuzMr8MqjzIOp
         iohAPAch8s3vgKDROsaYMpbg0aItgYsyMfSda2v0CR8dPCG+TCzW3LF2uKXC3iX67Ntq
         yhGw==
X-Gm-Message-State: AAQBX9dBlgHNbsZEq9ylMac173afBuvWi0mIB2SxTVRlrFdiITlPBENE
        Ka21ERoo9jFPTkAADsGpSGvtYvc0YzuBRR1R8xCpXQjk/kY=
X-Google-Smtp-Source: AKy350bCU+sGcrNd9vvwbp+HE0xJcJHbe8TMLxZqB8KxEZmMuyFDg+KRYMbAlunUp9JKPfiikk6v5gBjz9f1HXaszE4=
X-Received: by 2002:a50:c34f:0:b0:4fa:71a2:982b with SMTP id
 q15-20020a50c34f000000b004fa71a2982bmr5365918edb.0.1680274104246; Fri, 31 Mar
 2023 07:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093318.82288-1-gregkh@linuxfoundation.org> <20230331093318.82288-3-gregkh@linuxfoundation.org>
In-Reply-To: <20230331093318.82288-3-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 16:48:13 +0200
Message-ID: <CAJZ5v0jwqGcj8qn7s5R9pTPZ1ndyTixeQ2vps0qzKN1Bcq0CaA@mail.gmail.com>
Subject: Re: [PATCH 3/7] driver core: class: remove subsystem private pointer
 from struct class
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Now that the last users of the subsystem private pointer in struct class
> are gone, the pointer can be removed, as no one is using it.  One step
> closer to allowing struct class to be const and moved into read-only
> memory.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/class.c         | 4 ----
>  include/linux/device/class.h | 2 --
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index a8a1bf976290..fcfb295363cc 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -97,8 +97,6 @@ static void class_release(struct kobject *kobj)
>
>         pr_debug("class '%s': release.\n", class->name);
>
> -       class->p = NULL;
> -
>         if (class->class_release)
>                 class->class_release(class);
>         else
> @@ -206,7 +204,6 @@ int class_register(struct class *cls)
>         cp->subsys.kobj.kset = class_kset;
>         cp->subsys.kobj.ktype = &class_ktype;
>         cp->class = cls;
> -       cls->p = cp;
>
>         error = kset_register(&cp->subsys);
>         if (error)
> @@ -222,7 +219,6 @@ int class_register(struct class *cls)
>
>  err_out:
>         kfree(cp);
> -       cls->p = NULL;
>         return error;
>  }
>  EXPORT_SYMBOL_GPL(class_register);
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index 9cb5db0588c8..f7aad64e256a 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -71,8 +71,6 @@ struct class {
>         void (*get_ownership)(const struct device *dev, kuid_t *uid, kgid_t *gid);
>
>         const struct dev_pm_ops *pm;
> -
> -       struct subsys_private *p;
>  };
>
>  struct class_dev_iter {
> --
> 2.40.0
>
