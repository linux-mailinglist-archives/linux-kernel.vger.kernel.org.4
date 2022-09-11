Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721215B4EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIKMaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiIKMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:30:08 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C5B2C676
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:30:04 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1278a61bd57so16441861fac.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GXvt6+VlPIhHOKITk2PzUWa0nWONYyaMAMJ7e2meRv4=;
        b=EZEl63xbvmbPjPG63Mciy2nY6cBBuCukvf2nwy7bFE5t6cAKB3BIVny2QgCzUDc3/J
         GGXLQ8fOQCHZxx3nuiJorYB4DIzC5UHObvp4C26qKEjFIFEkhlZBletYjbcfQFXBb7D+
         EJFmAngJDZKB2KHGA9AR5DdyOlAVqzAySu9tPXWPvoZgv61F+bqYWKDIQOKpu6C40LT7
         Ys+HlXc0UWQoVCeBWDwRIU6AJlyWA6O0rp6fx+cllTLzT0HntkqLzqDFGSicpqJ1kIOC
         GRRPPElz72Mrl88k3Z6fS4MrIMaFoNRjTz/5YXBfPg66qsNRD3aE0NHojk507crMv5Zf
         lAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GXvt6+VlPIhHOKITk2PzUWa0nWONYyaMAMJ7e2meRv4=;
        b=xYIeVstBzkGWZoHvE2g5Fe2ycUPk4xH8WUUdGUIhqjUYhD8MwuLqQvFI2lIfLv7Gk1
         Fx7WZ7DiMW0kDrtoLqPYSnDkuArrLNU5IV/+ilUPhv+0ncIHYz90gzb42rHEws3a4qq6
         XvhC0fmSaNgUvymW3tbnrI1O8edZsf7JHe7eytovKVEfDQu0+kHWcf+Rri96OM0NuwNd
         o8ERMqgUO1XYSEQKRQaRE8HMpgjVv/zuWw2d1XwDDa3ys3QNCMqgpOy0eCM4JXuciYzM
         x9/uDtVWZJvZL2Y3tbl3b3gmogfsEF2yK8s1Y2WDQQ4ZK+p/UbG8g8A9DOD6dtBzS9td
         byLw==
X-Gm-Message-State: ACgBeo0ScxA/4OR2CKFqu8nl7+F+HOsVkKpI6wBWWxn53sB9NlfDhijf
        lOZcTg8ucZulaYQ4N2ULmbh9zzb/J2DzR1cLDzU=
X-Google-Smtp-Source: AA6agR4tKbPZAxhfGLE9XIxmEkvIdgiAEldIFmg/Gd0QPI979tp+VbXg7FDSSgmCioQZcs+KGrS2eed/fftgabqlH14=
X-Received: by 2002:a05:6870:2d1:b0:125:5519:1e4e with SMTP id
 r17-20020a05687002d100b0012555191e4emr9233932oaf.264.1662899404072; Sun, 11
 Sep 2022 05:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220910190303.682897-1-mwen@igalia.com>
In-Reply-To: <20220910190303.682897-1-mwen@igalia.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 11 Sep 2022 22:29:52 +1000
Message-ID: <CAPM=9txFJcKivJn=k2_n=PJt646vcvBN=5m3zxXojYew1E4gaQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/vkms: fix 32bit compilation error by replacing macros
To:     Melissa Wen <mwen@igalia.com>
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, igormtorrente@gmail.com,
        kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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

On Sun, 11 Sept 2022 at 05:03, Melissa Wen <mwen@igalia.com> wrote:
>
> Replace vkms_formats macro for fixed-point operations with functions
> from drm/drm_fixed.h to do the same job and fix 32-bit compilation
> errors.
>
> v2:
> - don't cast results to s32 (Igor)
> - add missing drm_fixp2int conversion (Igor)

btw I've applied this in drm-next, as otherwise I can't build my
32-bit arm build.

Dave.
