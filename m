Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866D75B7763
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiIMRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiIMRI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:08:57 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027FAC6CF3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:58:05 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id b15so764295vkp.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i5/2s/PtLL3F7sLuPHmoT47IPaMV4985HuOVmfSMhas=;
        b=FbQwg+dOez++WMspFJqw3yEG1M9ose4sVfHvAK1ksk90VagdWtbqpulHuCRHaYxWtx
         iWBUI7EruGr5Fnk1kzQbRwg2rXSrp1eTMYgGIhiEyyDqPWTrp28ydel1DboiYARudz05
         3HuiX/r1ZYm7OKE3cPd8kxtBYA08o1jSXqVOt/p+p00VqyKyxnQFlqtEQZ33eQRTqD0Y
         Vv4hGG7Dzo1Y1N+PY6/116ZIX+AOdx0Hsl8QBSO7ey8fPW54COsVdx0wAh+TbkQoBbVD
         gktX3l08/T7cFDFA6Zz2W65Jy6gqZXkfBtBsY7hTcGUI1RhvpppGaZvZKcEYhHdET21G
         zvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i5/2s/PtLL3F7sLuPHmoT47IPaMV4985HuOVmfSMhas=;
        b=VEV59KT7CXtu8Q0qCylHpdIAJ/j4tmtaBgJmjm9vFxiVFkzwB64Kkl8QARpDIemvLI
         F8AL9yHLUd7zRq47qdm81XkATzZsI1wHJOEdFx1EPSGI2fhmjWlKMpXEHL3uYJ0sBxcq
         pNE4y2ulqp/2s9nDwSb7RSQmJvDPMbXWlwGcw16Vo36k098kZEyIrELQb1TC0BbXrP2j
         4ympQNrGJIKD0Pcoy+86HJHkodecVSV0gLNTwY1jpSdtt1ukN4L6Pua7i7gtd9xYCPSH
         BN+M65ghwsJHPxZRcHkXSAJChy93rEtPiII5M/BqO802aWuSol44HSsW8ZTWQvd0p2bo
         voXA==
X-Gm-Message-State: ACgBeo39OLpLUDix1W1Hz7afAN/GX9okLqU67OJe00vdq0MNSBAld/cQ
        tZQlSmdWSBjAWdT63fYNllfdf+ILh4scwcQLCLg=
X-Google-Smtp-Source: AA6agR44lSG8WNfFrRxZTUuCUtDbsrpCwCxLMS1Oq5vTfjYOKjqu8k4+i5IJZlBMtaqQKUsoKsN6BU9gFKDQhHfo5ss=
X-Received: by 2002:a1f:2a58:0:b0:37d:2a8d:5fbd with SMTP id
 q85-20020a1f2a58000000b0037d2a8d5fbdmr10871327vkq.31.1663084677136; Tue, 13
 Sep 2022 08:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <20220912052852.1123868-2-jim.cromie@gmail.com> <87sfkw6gn5.fsf@intel.com>
In-Reply-To: <87sfkw6gn5.fsf@intel.com>
From:   jim.cromie@gmail.com
Date:   Tue, 13 Sep 2022 09:57:31 -0600
Message-ID: <CAJfuBxyrpMsHdYozXPSf=Oms4XAHyQ=PUx18RU3w=R1wVJQTtg@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] drm_print: condense enum drm_debug_category
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sean Paul <seanpaul@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 4:17 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Sun, 11 Sep 2022, Jim Cromie <jim.cromie@gmail.com> wrote:
> > enum drm_debug_category has 10 categories, but is initialized with
> > bitmasks which require 10 bits of underlying storage.  By using
> > natural enumeration, and moving the BIT(cat) into drm_debug_enabled(),
> > the enum fits in 4 bits, allowing the category to be represented
> > directly in pr_debug callsites, via the ddebug.class_id field.
> >
> > While this slightly pessimizes the bit-test in drm_debug_enabled(),
> > using dyndbg with JUMP_LABEL will avoid the function entirely.
> >
> > NOTE: this change forecloses the possibility of doing:
> >
> >   drm_dbg(DRM_UT_CORE|DRM_UT_KMS, "weird 2-cat experiment")
> >
> > but thats already strongly implied by the use of the enum itself; its
> > not a normal enum if it can be 2 values simultaneously.
>
> The drm.debug module parameter values are, arguably, ABI. There are tons
> of people, scripts, test environments, documentation, bug reports, etc,
> etc, referring to specific drm.debug module parameter values to enable
> specific drm debug logging categories.
>
> AFAICT you're not changing any of the values here, but having an enum
> without the hard coded values makes it more likely to accidentally
> change the category to bit mapping. At the very least deserves a
> comment.
>

hi Jani,

You're correct, this is unchanged :
   echo $script_debug_val > /sys/module/drm/parameters/debug

wrt the enum, the next patch adds a comment,

 enum drm_debug_category {
+       /* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
        /**
         * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,


But that comment mostly misses the point youre making.
and the specific NAME is stale.
and the s/int/ulong/ __drm_debug should go here, with the use of BIT()
I will fix this and repost.

Is it useful for CI / patchwork / lkp-robot purposes,
to branch-and-rebase onto drm-next/drm-next  or  drm-tip/drm-tip
(or dated tags on them ) ?




>
> BR,
> Jani.
>
>

thank you

> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  inclu
