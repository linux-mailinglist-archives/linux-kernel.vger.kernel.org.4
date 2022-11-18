Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9136362FB85
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiKRRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiKRRWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:22:30 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9842F03B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:22:29 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kt23so14628359ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tGlHMVAixSLQ2/vSJKtVJw1fS47SH8DBN8tgE+O+1Dw=;
        b=OjlT+FkV3ubQznoPIsACkVupwz5M/BwNXgn9nTXGpJQCMt858j95Bbt5uaocOT6zFt
         18FjSBC/7LGXjKqU37PeyaBP9NipzTpWgsr41BiQfe9ZyGXXRyBSHqgyYsSt1UU+7aWg
         HqR+3cay+O13G9V+9VbC+9DNlTn3vMb90kT+QHVobVy2PLUjD17zi5uyZdNGFMP48Y9B
         qMTqGh9BPsEmeWB3pG+MoVMwFq4wK7M6gTbpU7CKznn87Lnta2WnpAL4A0/8UdnZ+u2T
         ooxthkH0fMlCsUozhubGVi1WCF9tF6z6+T+sAZ572CXMThA0V70d2P7JerZNUPCHFf0T
         r0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGlHMVAixSLQ2/vSJKtVJw1fS47SH8DBN8tgE+O+1Dw=;
        b=Caft3MFLOkFfXSmPNArfOwye4Z9ZyEL1H2DnTNyl+A7YHoSWkn+KWGwWpjNdm84Ycf
         WFgqrYOHv8vRaX/INHz+a3xAxcBE5wRq4YD6aNq21xxk9hkWpcBecjl8wmCXMTWdpJzC
         kubJ6VpkGQPEFJxHKe49FxyfZLaQvmboDWf/lthZ6GjAqsPZT3ZvTsq63/oXPV2lOScc
         vfXkQPwcRrie7XjXz81vSUcUyODUFuPGbkLeHb1zyg8MYboi13tilSMm35P+JtcVOwPt
         aWQ0EtazWBozAqPYpG8ofQSKONhTcopLhOwNGuRduGeEkgT/sdgTO2PZSSntPCjgFHlN
         3/5Q==
X-Gm-Message-State: ANoB5pm/oNUBr3G7UfyPXOAuKL/Who49vpn1y9iv9k7PEZUXbL0HTbfw
        4eScCrYIimt0LVXIl6LiAp8vTMJJycIaS6OEhfoK5g==
X-Google-Smtp-Source: AA0mqf5RTDYL95yJLINf+DHoUvPAbKBKfzSUkMLfE676P01sHCik4FCCjPl1FZtbx4cSowoLTeqPlB3L+yyX8On2pds=
X-Received: by 2002:a17:906:9246:b0:7af:da0:aebe with SMTP id
 c6-20020a170906924600b007af0da0aebemr6761187ejx.723.1668792147755; Fri, 18
 Nov 2022 09:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20221118084244.199909-1-umang.jain@ideasonboard.com>
 <20221118084244.199909-3-umang.jain@ideasonboard.com> <166876741790.50677.17305359640652054680@Monstersaurus>
In-Reply-To: <166876741790.50677.17305359640652054680@Monstersaurus>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 18 Nov 2022 17:22:12 +0000
Message-ID: <CAPY8ntDMM-0S_gz5A+4rWQ7M2gmUMeOYRW__cr8v=afo5fM_sA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vc04_services: mmal-vchiq: Use bool for vchiq_mmal_component.in_use
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang & Kieran

On Fri, 18 Nov 2022 at 10:30, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Quoting Umang Jain (2022-11-18 08:42:43)
> > In commit 7967656ffbfa ("coding-style: Clarify the expectations around
> > bool") the check to dis-allow bool structure members was removed from
> > checkpatch.pl. It promotes bool structure members to store boolean
> > values. This enhances code readability.
>
> This only talks about 7967656ffbfa as I can interpret it.  A sentence
> here describing what we're going to do about it in /this/ patch would be
> clearer as a second paragraph:
>
> """
> Convert the remaining bit-field storage for 'in-use' to a bool and use
> it accordingly.
> """
>
> But that's trivial and not worth a v3 specifically. (unless anyone
> applying this wants to add it).

Totally agree.

> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> >
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> >  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 6 +++---
> >  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > index 4abb6178cb9f..294b184d4a49 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > @@ -1648,7 +1648,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
> >         for (idx = 0; idx < VCHIQ_MMAL_MAX_COMPONENTS; idx++) {
> >                 if (!instance->component[idx].in_use) {
> >                         component = &instance->component[idx];
> > -                       component->in_use = 1;
> > +                       component->in_use = true;
> >                         break;
> >                 }
> >         }
> > @@ -1724,7 +1724,7 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
> >         destroy_component(instance, component);
> >  unlock:
> >         if (component)
> > -               component->in_use = 0;
> > +               component->in_use = false;
> >         mutex_unlock(&instance->vchiq_mutex);
> >
> >         return ret;
> > @@ -1747,7 +1747,7 @@ int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
> >
> >         ret = destroy_component(instance, component);
> >
> > -       component->in_use = 0;
> > +       component->in_use = false;
> >
> >         mutex_unlock(&instance->vchiq_mutex);
> >
> > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > index 6d984cf5a83a..09f030919d4e 100644
> > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> > @@ -82,7 +82,7 @@ struct vchiq_mmal_port {
> >  };
> >
> >  struct vchiq_mmal_component {
> > -       u32 in_use:1;
> > +       bool in_use;
> >         bool enabled;
> >         u32 handle;  /* VideoCore handle for component */
> >         u32 inputs;  /* Number of input ports */
> > --
> > 2.38.1
> >
