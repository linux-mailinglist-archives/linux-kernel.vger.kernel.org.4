Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F15FBBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJKUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJKUGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:06:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523099AFDC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:06:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i6so14548274pfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2fjLHj4AizGsdQ3rUWzzJN2TYcfP94NYRiXnGsKpTo=;
        b=a/7u3VA0O2xc11jDut8N3ZmXSCJ0nDSWKEsx9snjFx3F8tWuE9imDVrSc1Hg46kH7K
         T7diJYGgTULbLyTnSy81gqP6ajNyHKbsGWy02P/4SkRyhlv/ZDZQ2bwEMcmlV7HZDSGi
         F8ODV4vdUknYFSDw2lWxRCCe8y5SeBpHG44fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2fjLHj4AizGsdQ3rUWzzJN2TYcfP94NYRiXnGsKpTo=;
        b=fmg7xQN2/QGL43Os34z8JOpE/sbPnkUkNw7+Nck5XZ487dMnu2657hmmK7AX3z1fC9
         NcFmawXS3H8bckmNNrZmJG6HH08utchvO47BvBNO0fZDnqJ9Cezi0djkAN9TTM4Q7wOl
         IgiGlSok55GZ0zS9T3IaJ2IMpTN1TajjfSRP8zEgR85po4Ne5TRdPP7mCaGaAGz1M7aI
         OoE1kCDgZoFxMiacJ+s1pyTfB4WAVfwA4QaCZ662IggOFYgnbAbZcAjpDxt+l2jGaBIy
         v4oyP6Q4eKcdejl+Yb9mk3VORGcrVPhLf6t4+x/l5/yOvavzhYQQqOUPIXYJ4CRUnMnH
         VAAQ==
X-Gm-Message-State: ACrzQf3d7LJll5nUYh7UTUGU2wlAoaempEvIwvM4Amuu5uZAJWLGuCO+
        /24c4sK7kAk1kDZhbfUNw+FwPqke8ZSkWA==
X-Google-Smtp-Source: AMsMyM4TEOHwtoixNT7awm8qgMYy7OR8kAYaGhOZ+lGYZBmQ5oaFWN17ZCj7GIEYqz2AiIVmhn1OCA==
X-Received: by 2002:aa7:96e6:0:b0:562:6f4e:151 with SMTP id i6-20020aa796e6000000b005626f4e0151mr26788185pfq.35.1665518793741;
        Tue, 11 Oct 2022 13:06:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b0016dc6279ab7sm6861285plg.149.2022.10.11.13.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:06:33 -0700 (PDT)
Date:   Tue, 11 Oct 2022 13:06:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <202210111305.743F591@keescook>
References: <Y0W5jkiXUkpNl4ap@mail.google.com>
 <Y0XMP2RMkE4MWNPE@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XMP2RMkE4MWNPE@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 09:04:15AM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated. So, replace one-element array with
> fixed size array member in struct dlm_ls, and refactor the rest of the
> code, accordingly.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/228
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
> 
> v4: resend patch using the right version number. Req: Gustavo Silva
> v3: replace one-element array with a fixed size array. Req: Kees Cook
> v2: patch resent as I had an issue with a <CRLF> char in my mail client
> v1: https://lore.kernel.org/lkml/Y0ICbf8tCtXMn+W0@mail.google.com/
> ---
>  fs/dlm/dlm_internal.h | 2 +-
>  fs/dlm/lockspace.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index e34c3d2639a5..94fadb619ba0 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -670,7 +670,7 @@ struct dlm_ls {
>  	void			*ls_ops_arg;
>  
>  	int			ls_namelen;
> -	char			ls_name[1];
> +	char			ls_name[DLM_LOCKSPACE_LEN + 1];
>  };
>  
>  /*
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index bae050df7abf..23de0d47cbc1 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
>  
>  	error = -ENOMEM;
>  
> -	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
> +	ls = kzalloc(sizeof(struct dlm_ls), GFP_NOFS);
                     ^^^^^^^^^^^^^^^^^^^^
I think you forgot the suggestion Gustavo had here. :) Preferred style would
be:
	sizeof(*ls)

-- 
Kees Cook
