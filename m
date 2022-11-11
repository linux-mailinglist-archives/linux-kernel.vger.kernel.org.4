Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709576261D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiKKTV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKTVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:21:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817175BD7D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:21:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k7so4947471pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHk/WyAgMPc33IOyOTaPaWGnmZhp17CsZbK+KP95Wh8=;
        b=O6YivlkQdE2NV4Z4tLE02IOQ7YQgIRJrWM80tdZkt5k+XIQtZz7cxKpCMaB7rrfPq7
         G3XacIpYr2nn6HNsDJtbm6DA3HrV4P+qQd/qmV5UhkMSi3baY1lPJVMFkAstEJzuHUeN
         DgKOEOliQUckGTg21sefxcOucamEjp7kTw/Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHk/WyAgMPc33IOyOTaPaWGnmZhp17CsZbK+KP95Wh8=;
        b=pqeLidtm+a6qjGla0bAaLezzX8rBLIJhNtsLaHUhyde1zMfiHrEBLQ/SkDzTW4hQv2
         zL/dqAQS9eL5rpgrMSwJrdS53iO0/RKIWeEwDY4wlzCXFG2oc6otU3EwCAOfB8nf8OON
         Ri4nU0GC7Dt9SnO1h9VSQRpkQCj0UaSImuff88erfLK7IFJpD18RNaOzlUTPdUoPnIyv
         8uOtiSfYSMRG1qHf0wzbCiBgbuM03jgKpHQhpgJGpB7dXOWn1SCyjkibTcBuNCl+fKpK
         8Z2URnymtRNsqJF6VGGQSrNd44/utx0lpJs36O4V+iIgG6TCqLErqEkf6GLx1aryIRZl
         URCQ==
X-Gm-Message-State: ANoB5pm3o+I68lCJ9nBtwqyBu8TiPSX/1IjpqELw0v4MelmFjEdvfYLB
        UD1U+s8t8X4/ubA5hlVdvVHj0g3vDL+Szw==
X-Google-Smtp-Source: AA0mqf4i77VIhs5qpNyBlVvhpR2s9r/2VBj54xZbpPIy/ryD5gcsls//pP1BrhZB4gM/fwDn5Bz05Q==
X-Received: by 2002:a17:902:e052:b0:172:f5b1:e73b with SMTP id x18-20020a170902e05200b00172f5b1e73bmr3962831plx.58.1668194510942;
        Fri, 11 Nov 2022 11:21:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c14-20020a62f84e000000b0052d4cb47339sm1907746pfm.151.2022.11.11.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:21:50 -0800 (PST)
Date:   Fri, 11 Nov 2022 11:21:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: nouveau_dp_irq(): Null pointer dereferences
Message-ID: <202211111110.11B554B@keescook>
References: <202211100850.7A8DD75@keescook>
 <87iljl6ehe.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iljl6ehe.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:13:17AM +0200, Jani Nikula wrote:
> On Thu, 10 Nov 2022, coverity-bot <keescook@chromium.org> wrote:
> > Hello!
> >
> > This is an experimental semi-automated report about issues detected by
> > Coverity from a scan of next-20221110 as part of the linux-next scan project:
> > https://scan.coverity.com/projects/linux-next-weekly-scan
> >
> > You're getting this email because you were associated with the identified
> > lines of code (noted below) that were touched by commits:
> >
> >   Mon Aug 31 19:10:08 2020 -0400
> >     a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")
> 
> Hi Kees, this looks like a good idea, but maybe double check the Cc list
> generation? I was Cc'd on four mails today that I thought were
> irrelevant to me.

Hi!

Heh, I was recently asked to _expand_ the CC list. :)

For these last pass of reports, I added a get_maintainers.pl run to the
identified commit. In this instance, the commit touched:

 drivers/gpu/drm/nouveau/dispnv04/disp.c     |    6 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  192 ++++++++++++++++++++++--------------------------
 drivers/gpu/drm/nouveau/nouveau_connector.c |   14 ---
 drivers/gpu/drm/nouveau/nouveau_display.c   |    2 
 drivers/gpu/drm/nouveau/nouveau_display.h   |    2 
 drivers/gpu/drm/nouveau/nouveau_dp.c        |  132 ++++++++++++++++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_encoder.h   |   33 +++++++-
 7 files changed, 244 insertions(+), 137 deletions(-)

And the get_maintainers.pl rationale was:

Ben Skeggs <bskeggs@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:1/1=100%,commit_signer:6/16=38%,authored:4/16=25%,added_lines:23/124=19%,removed_lines:36/152=24%)
Karol Herbst <kherbst@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:2/1=100%)
Lyude Paul <lyude@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:9/16=56%,authored:6/16=38%,added_lines:92/124=74%,removed_lines:107/152=70%)
David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
Ilia Mirkin <imirkin@alum.mit.edu> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
"Nathan E. Egge" <unlord@xiph.org> (commit_signer:1/1=100%)
Jani Nikula <jani.nikula@intel.com> (commit_signer:6/16=38%)
Dave Airlie <airlied@redhat.com> (commit_signer:5/16=31%)
Thomas Zimmermann <tzimmermann@suse.de> (commit_signer:4/16=25%,authored:4/16=25%)
dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)


-- 
Kees Cook
