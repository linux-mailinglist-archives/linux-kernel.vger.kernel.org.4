Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25105708822
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjERS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjERS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:59:56 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B788E5C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:59:39 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba82059ef0bso2150995276.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684436378; x=1687028378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtBOHOwmDp9SMINU5LAjPqVHhLD9SSVab8maKjIrOho=;
        b=A/v5w98UE3b9NLHqHa2kzJa6P+se5gh5td7rb7BYIYiUOUTG1Wv0AcVKxHsDW7H+K+
         6XKj5cAOfXxmbtOPX+F3Tjq3bDkj3diO56tw9wm0G6VUgd4BS20xaufxQ0a41b6rNl+d
         f/DW0DhUADqSgG8xwEpvLkUrwB8Dlvp13NXTmkTpCK9LInNztd396SEydzKZrdACYcYj
         IZYtm7fKaxr+7VNNZMM/ZHv3nH5MO/hEqkxvq6/oHBYzOb5sarsrnPP3h7WLkrlNGEmH
         bKDX+2VcVpxI7MGOKFmuUrTevhd4a+4Rw4jh869yTsMoIDXPvRMhQBi5efq+wBuaaLEY
         xJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684436378; x=1687028378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtBOHOwmDp9SMINU5LAjPqVHhLD9SSVab8maKjIrOho=;
        b=iCnVFH5i1wNbHpbFkO40qyevUPN/DjrYtZwrqXmntI4IcO1NXQndZyJl+Y1TYz4mJf
         k1LppkSCbKY4v+OeVB2DKcFOLFE8m9YsUoG3MMZ/Vljqyhj5DXnfGT8s4RUC7misT0Ls
         PZlSIKbOzcaZeAoho3Y8A2xGRQwtRoZddtuRuMJ55iLGnYvC5AiB/k0HGAUUrKl4lx1I
         +wZn98rBnpaXPBP1ldODmO2pDPfwwSkrSfUUDu2DE7G1JXPvExrYiOsGw3CCJos2lwV2
         nDEf0yopzM8vx2NABT/HhWperlTxIDc6KHIuV6tlXtm9rrVOEBGGb4mAcIa5QlsbWp0d
         WLZg==
X-Gm-Message-State: AC+VfDxMPbIOR+bqASmZdeu9hHGZ/Jtj9gJDu+t0aWwDL6ghgUnNWYUp
        MVWLH2vE3oKSj/GKsq7ug9zscAjcVsIYaNwb8XfM
X-Google-Smtp-Source: ACHHUZ74/iXoSHc+ftLq8tme01H36+JfSuO86ZpjAPbOWNnDVIUmF3ovPG3r9WymgIzJJWKqXQmBbqEXhqCl/FofgPY=
X-Received: by 2002:a25:ac19:0:b0:b95:9b76:34a5 with SMTP id
 w25-20020a25ac19000000b00b959b7634a5mr1917345ybi.64.1684436378606; Thu, 18
 May 2023 11:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 May 2023 14:59:27 -0400
Message-ID: <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        mortonm@chromium.org
Cc:     penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> pr_warn message clearly says that GID should be printed,
> but we have UID there. Let's fix that.
>
> Found accidentaly during the work on isolated user namespaces.
>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
> v2: __kuid_val -> __kgid_val
> ---
>  security/safesetid/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm assuming you're going to pick this up Micah?

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index e806739f7868..5be5894aa0ea 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -131,7 +131,7 @@ static int safesetid_security_capable(const struct cr=
ed *cred,
>                  * set*gid() (e.g. setting up userns gid mappings).
>                  */
>                 pr_warn("Operation requires CAP_SETGID, which is not avai=
lable to GID %u for operations besides approved set*gid transitions\n",
> -                       __kuid_val(cred->uid));
> +                       __kgid_val(cred->gid));
>                 return -EPERM;
>         default:
>                 /* Error, the only capabilities were checking for is CAP_=
SETUID/GID */
> --
> 2.34.1

--=20
paul-moore.com
