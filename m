Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C89677E06
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjAWO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjAWO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:29:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A466233D1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:29:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso4671531wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVEX3K9R7UTVs9BpydIEVGiNnSD4cwRlULo8SBOwRn0=;
        b=i3RoMQQsfcUP8NOwgfzVsWobAfVLn54sIZ4XHfy+qH+5n0QZ0M+sWsiNJTPpKCU9K8
         yqaNynX/bMUw2xIkPwJI3RoYO+DyM0d0QhX/6Cngq7qnw6kclIfHvp7040IR4NAlnrM4
         fnhBpq/EZrpa5GzYXXa4C+IZaTklI8dpbkC5W9HcFJ8fbyzDPFaxXTA+WudfULmeJEYw
         DNvDV10+bAumqGo5/QMgQhj9vQUrSY+v0QJip3z9RXyIA32B3p49xegzWnudQhV/+BH9
         dhsot0MsFXnAaAJEOOVH8svtpyHgg3P9rk6izZrf6lOxlvZlfu+RMhr29AMY+npqCvlo
         kRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVEX3K9R7UTVs9BpydIEVGiNnSD4cwRlULo8SBOwRn0=;
        b=HrtbqPC9O6rCsQuhqPVdJgRO083q3yzQsB6NqSt82BwgR1ChyGAW8f3prQiyLtuXQE
         3M6BO76w9o5DFmoZiPdtk4HDLP95DAh89AwtH1WPfQLU0mc4D8dPlQKO+2EPFNkEe41h
         w1fo3iQN3ucckL4E30IWCbMhjXSJa+QVPcCC7IjTySPvvRdv/IkA/hlp8P6Kw+7mJ15W
         +JJIYhDsS7fLYLG5tA8whURcVgHeyRauNHeR6OuoDp6NJoCsNk7wEhDHHX1USxrsOS+R
         WITMiLi+r68ADazEH8ewnxsqJHCowaLRaSIruT/aEQYdlgk0yzSOsfVQT+kkmLb+bYng
         Q6rQ==
X-Gm-Message-State: AFqh2krdM7tWfuXpBB+0YxXRFwOT9R8yyb/2uxcwHwLdr1mRcI2Ce1yo
        L/la3yt2wwUM7dvQsNTzqto9jA==
X-Google-Smtp-Source: AMrXdXu+uy83sENphsRTx1C76RiEULtoqR/9nxoXaE+2BE1EGyLljUeg1Q2ZHou14FVb8ThEN22dvA==
X-Received: by 2002:a7b:cb88:0:b0:3d9:f801:73bf with SMTP id m8-20020a7bcb88000000b003d9f80173bfmr24150509wmi.12.1674484184653;
        Mon, 23 Jan 2023 06:29:44 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003dab40f9eafsm11865469wms.35.2023.01.23.06.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:29:44 -0800 (PST)
Date:   Mon, 23 Jan 2023 14:29:42 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y86Z1ohimSHhNvj8@aspen.lan>
References: <20230120155018.15376-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120155018.15376-1-lujianhua000@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:50:17PM +0800, Jianhua Lu wrote:
> Add Kinetic KTZ8866 backlight binding documentation.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
