Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9015EA957
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiIZO5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiIZO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:57:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B08760E7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:27:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z6so10264076wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=T7W3vMO9tuQw1ch0loPah1OFffLIuFMRKn5RdUQipcs=;
        b=yfgZBniecjUWpi3bk6V4rQIus/MCIZpz9t4A7SVfoQPg00l0Rk23hmYkPyEaObXEb4
         hErU2p41GocomjtVpFRtLhtaVT/pVCvWai5rb66aecDYLhjdoxtTjhCtiAlyt7d+GoDd
         ExMEssCO5FQeGG9RZtVpGSYpS9DPtffUjQ/gWMr+cXq41hPvghCzcjm/etv6p+RSNuWw
         dJPvz42iGKt7Ja2hRVDorsq9VDPdrWr5fG8bwkuv8zThTLQskIX9o+zoOWF7yyxCXf1w
         Q0eiNduP6bFY3YXQ0VhPbuwyLS6qyewDcnGye4M4V/Dq/FQAy3+iRIehVfaFaI11ezH8
         z2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=T7W3vMO9tuQw1ch0loPah1OFffLIuFMRKn5RdUQipcs=;
        b=ghx5p/J/r3Mcz1uKG/SRyeCEvzS+NH41RqYQ48DFY+R/sNUn26Pocu2Bz6GdlajJuF
         +M8u0DFlrU7CyF49yvumN/Le/sjexdxqRuUso4ld8Ccd7L5+85RgUG8GC61GAy/tmfjw
         xD5cs8Utj+aCy08/ET64IH3/5o6HDV9Fu6LFtt6cS3C5MwqZICB3tGxX7CH/JWQJB0uR
         8eRkV4kQiC4oMvgs0TW+Dhawer4hTDoiIx2t164KZFwnOQg7mwzjDli8Jhr9QuRt6bFt
         LDRCDA5YKp7fhBkmAWv04RnUC9aaFplZR7E5iihrs85jMNkcB1d3w/EthrCS9QhpRxM0
         nYaw==
X-Gm-Message-State: ACrzQf1LTnQOnH55X+XPDvMEApLEjTxnIx5M8WPlPxYHlxy4x0KB8P/a
        VWUstFBF7ZymbSD1ouJff2MyFQ==
X-Google-Smtp-Source: AMsMyM44LUAubokNSp9WXwZur0Fu+NrElkwTgpu8o/bVy7gK60y+vIm67nYa43Tnf3t+D7BzAJmGhA==
X-Received: by 2002:a5d:6b09:0:b0:225:37cf:fb8b with SMTP id v9-20020a5d6b09000000b0022537cffb8bmr13370722wrw.179.1664198877330;
        Mon, 26 Sep 2022 06:27:57 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bn27-20020a056000061b00b0022762b0e2a2sm15616002wrb.6.2022.09.26.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:27:56 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:27:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cgel.zte@gmail.com
Cc:     lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] backlight: lp8788: use sysfs_emit() to
 instead of scnprintf()
Message-ID: <YzGo2o3bVLnOiQJr@maple.lan>
References: <20220923063533.239315-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923063533.239315-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 06:35:33AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/video/backlight/lp8788_bl.c | 2 +-

This one has the subject right and is a good change. However I'd still
prefer it as a single patchset that fixes *all* instances of this code
pattern.


Daniel.
