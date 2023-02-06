Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1198468C5E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBFShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBFShS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:37:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6F2B0B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:37:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id iy2so2976428plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KLC/XkXNzAEy7VypcsOB1BhiDn5tCJJ6z4r2FO96gZ4=;
        b=Z6Xobl+ifCTmy3tuXbCb4/T7KQuqh1+ELYFMFncOG8gjGjYWHYVKBkKWf/hs7705kQ
         U9pBsHYgyI4LBsQZ4svp9ACnySmMw1lzFGzLx+r5Z3R6I6fYbCXXJfRBQAJhTeaJt2Rd
         DZ+n9H0FNUIhVcUTh+hGz3QzvSZi2ZTAZCEBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLC/XkXNzAEy7VypcsOB1BhiDn5tCJJ6z4r2FO96gZ4=;
        b=GZuGL9iHaXOYoTpNgvAskCMsh+zdgRBPdoFGHlTzbvSgSTxD/lxrULYIa5nZx4yBd9
         4smD/1CoKrJTZRsHNuaAyGIVgWLEzVup7t3/S+CQZdn2rrTOnXR7ClCTTj3QEhBpTreU
         6MgnfYvi21LUz6JHsQ6FwnD3Ol/UvshlPp1Fha8OpoNj1S7nUeCPtOQpMuEjxHiYKkrj
         CHiS+9fuRw0ostTcN2fVTEg4+hjwcrzH91VjsCKAcgt3UO3k9AKskxBAtKkPVGKKNfkA
         pJ8Go8xr8/zB8K13tyoNeRpTLZhfVVJccqIOnPD47rAxdeRaVUp8z8g1uYEEcW7/kKg5
         QM5g==
X-Gm-Message-State: AO0yUKXtGBMNlDVyAj2exvDuqkiR9Swv2FeNz1Sm91cii2bM9yGw4ZUV
        JI/GxZvw77hgnGAGP4Zf5U/IPw==
X-Google-Smtp-Source: AK7set/Rzubn+NGDwIh+RLUe/eGNYmHcdSo19eILBU6BpKaPvO08yVnkIMQkb7RsLOZ4nQQiabKtPQ==
X-Received: by 2002:a17:902:e749:b0:196:68ee:f363 with SMTP id p9-20020a170902e74900b0019668eef363mr27185847plf.69.1675708634329;
        Mon, 06 Feb 2023 10:37:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b001967580f60fsm7204461pli.260.2023.02.06.10.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:37:13 -0800 (PST)
Message-ID: <63e148d9.170a0220.20379.b4a7@mx.google.com>
X-Google-Original-Message-ID: <202302061035.@keescook>
Date:   Mon, 6 Feb 2023 10:37:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: Handle NULL return values
References: <20230204183510.never.909-kees@kernel.org>
 <Y99XGrFvXBL32cOO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y99XGrFvXBL32cOO@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 08:13:30AM +0100, Greg KH wrote:
> On Sat, Feb 04, 2023 at 10:35:10AM -0800, Kees Cook wrote:
> > Each of to_fs_info(), discard_to_fs_info(), and to_space_info() can
> > return NULL values.
> 
> The code says it could, but I really do not think that is possible at
> all, especially based on the fact that there have never been any crashes
> reported here.

I'm not sure that's a useful measure if we're trying to improve
robustness under memory corruption, but at least one of those helpers is
performing a type check, not just a simple container_of(), etc.

Regardless, yeah, if this can be done without NULL returns, sure, let's
do it. I just don't know this code well enough to say what's possible.
:)

-- 
Kees Cook
