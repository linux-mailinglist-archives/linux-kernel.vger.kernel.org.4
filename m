Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE89B5B62D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiILVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiILVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:35:53 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4B4BD29;
        Mon, 12 Sep 2022 14:35:52 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-127f5411b9cso26959926fac.4;
        Mon, 12 Sep 2022 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/o3x3HJJvyFzRpNNCPC85nRj+zJ3gyuFs0jeQWhGJmw=;
        b=juYaYKhrF7cl0EaKYaWZ+AS2Kstij6b2t45dYf+NYCpf1G0dMMWSYSrMvXLotkY9Px
         CBBOwsrvYqBIbOhvKXR3688Rti0rZUiUoAEve5Rs2+yFLM672o1WCzQnB6Dn62+C9/BF
         tL3igihIXZ73g7Eq6LNME/dpsWqfqItJgn3j/EW5GDiMtswOwh05xBsrhqqa8pU4wVK4
         LGMsdYOMTYfd2JNDsyeKuUHwWnqH5aE/XVFbMBfPjCNMpeqZ0wPOTXZI3tANZJAWvB4f
         4bp7UK5qMcC0agm4EWYRzAWhL3BrXNkatylqbMOhaSER9FEaEC8wyFbql5BXG5Yml7VI
         a3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/o3x3HJJvyFzRpNNCPC85nRj+zJ3gyuFs0jeQWhGJmw=;
        b=G5MByno6gEZuNRKVklmywVrI1rCTIbl+UzOVdDkD4k1CE3dndbueyISD6wGfpLigG+
         ukGEdoItz02ZVYcBUH2goObKy1NfdC6UQ/D3d1P7npCcLuaAtzI1OG/5dvYFhXQjKzt9
         4xH+R3PqkqXv7o1x2MZ8+yY3ETVxkt6B671vdXWHfeWy9H/iB1yLfprXi4gS/auyoUuj
         HIU16IaW+V7ie1i6Pv4/iqlgs1+NTLbmLGs0A6Qt/8vZBunwUILxE6ma1SEvBGo/orML
         UaBOfui8JIOwfOA9DlUT7djlojujtEEXi2eWhqfwoJkxzeCZDm25DF6iSAGVqBaeIxF8
         Z8aA==
X-Gm-Message-State: ACgBeo2GUT0pHSRkx9ePG3vhBB9prmklx0TM9pUg9ZEVT8G2zov4TPeb
        RSxYkiF/SmPD77ouleW2PqM=
X-Google-Smtp-Source: AA6agR7OE+87SRc4MPIhGnL6cCMzVvYQe3e6nMRpyLIY5RBCxJbTrkn+IJpD7vA73ULAoKLnIkwcbg==
X-Received: by 2002:a05:6870:e413:b0:127:2f43:af44 with SMTP id n19-20020a056870e41300b001272f43af44mr174675oag.175.1663018551656;
        Mon, 12 Sep 2022 14:35:51 -0700 (PDT)
Received: from wintermute.localdomain ([76.244.6.13])
        by smtp.gmail.com with ESMTPSA id eq22-20020a056870a91600b0012779ba00fesm6426446oab.2.2022.09.12.14.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 14:35:51 -0700 (PDT)
Date:   Mon, 12 Sep 2022 16:35:47 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dianders@chromium.org, lkundrak@v3.sk,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>, tzimmermann@suse.de,
        javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Subject: Re: [PATCH v1 0/2] Revert chrontel-ch7033 byteswap order series
Message-ID: <20220912213547.GA6141@wintermute.localdomain>
References: <20220912113856.817188-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912113856.817188-1-robert.foss@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 01:38:54PM +0200, Robert Foss wrote:
> After applying the "chrontel-ch7033: Add byteswap order option" series,
> Laurent reported an issues with the approach. Since no fix has been submitted
> for the issues outlined in time for the next kernel release, I'd like to
> revert this series for now.
> 
> Just to be clear I would very much like to see a v3 of this[1] series, where the
> issues outlined have been fixed.

I will work on a v3 soon, I just have to finish a few other things first.

That said, I'm not very familiar with what we're trying to do in an automated
fashion. In my use case I have DPI output (from an Allwinner R8 to this bridge)
which then connects via HDMI. I'm aware that we should be able to get the color
space information from the HDMI connector, correct? Is it that information I
would then need to use to set the bridge colorspace, or is it the color info
from the DPI connector I'm using?

I'm still pretty new to DRM drivers so this is mostly new to me. Thank you.

> 
> [1] https://lore.kernel.org/all/20220902153906.31000-1-macroalpha82@gmail.com/
> 
> Robert Foss (2):
>   Revert "dt-bindings: Add byteswap order to chrontel ch7033"
>   Revert "drm/bridge: ti-sn65dsi86: Implement bridge connector
>     operations for DP"
> 
>  .../display/bridge/chrontel,ch7033.yaml       | 13 ---------
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c         | 28 -------------------
>  2 files changed, 41 deletions(-)
> 
> -- 
> 2.34.1
> 
