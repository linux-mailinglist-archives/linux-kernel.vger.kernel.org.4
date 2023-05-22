Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4687470CAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjEVURU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjEVUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:16:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43491186
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae6b4c5a53so34208865ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786586; x=1687378586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tk3bD9idbrl9PK1wi5VEyItHEpJJoo8tWtDD672a6E=;
        b=CLjZcbeeJRsWfyBj8z/QVwLw/ENfE5+A1dPkMRNzX87xKEByhVIPvwWqQm4vMwpfHx
         LkuslqD3tJGP5ZErdH8X4BGmRzZsFV6FOZtqvKaAwxu+bJS4PEowjRWKQf08zVeZOnNS
         nCUd+51z44rEqWO2oc6lzbzLBxNDbL4CuXt+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786586; x=1687378586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tk3bD9idbrl9PK1wi5VEyItHEpJJoo8tWtDD672a6E=;
        b=DJp0w6UwsfcswKW7o4eFDg8exFlxnKA1e6EkDyFDm3PBDLQCkUDbNSSAKJ6FC2VYow
         xn8CiEQi7QNL//Oncd3BvxE07rjuQIqaZOP0WyZT9BX4dTokONkV/wp6PeO9wi4b0JwN
         bRH6AIYnmpUHH4eqY8IDNeYGb8ZzpEvAhtCqn0vr4oDDpmWNhuP5dNFQIwDvRbrHewJa
         YLen02bYOO5Ce8EVSD3FsgxrXB3dNOP40583X2RKWS5kp799EWYHbPtxXtXFOF+zJcen
         ASU5oHZ91jU2YNnojVlZK5Wk36Q+NMTQNml0ceO8zt9hyJebYZXYh9IzPiw8qniqZwoj
         9gRA==
X-Gm-Message-State: AC+VfDw800RZUdHgBUXeGo/2tY5B6Z0LyQ4RVPvGHI/3f1bBgsvzWQWe
        Ms32yjT2Yv5DbuZ7qBnMaA8wZA==
X-Google-Smtp-Source: ACHHUZ6BuhhlrdHXweBhtsG3t4yfH689XOUIExdIl9faSWmma0pPdymM3tTUL/dYHxtJKYUa0AJF+w==
X-Received: by 2002:a17:902:ec86:b0:1a6:a8e5:9240 with SMTP id x6-20020a170902ec8600b001a6a8e59240mr13889786plg.4.1684786585815;
        Mon, 22 May 2023 13:16:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ab2b415bdbsm5247910plg.45.2023.05.22.13.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:25 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i2c: tda998x: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221316.C0D13F1@keescook>
References: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155350.2337029-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:53:50PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
