Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9688B70CA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjEVUPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjEVUPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:15:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67D10D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:15:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so59601865ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786526; x=1687378526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdrje6wvnlDZ+Z6wbd9zxIlTwzeS32i409hLZznOFcY=;
        b=IKgGDbfMAFcTW0fCraBOWKLWmKW3iVgSXiA5H6aqBySMQvF33LN3e/4WaaVBfsNkiv
         rlwvatxvFaLKPYJiJOQxmwX7qux9hU+DbTGFv0sTcdeK2WbWfEGPKqRy9tINpmr6Gs9P
         +LMTABtMt4FGiI3+DOzwVFbwur7RscLj5yUcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786526; x=1687378526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdrje6wvnlDZ+Z6wbd9zxIlTwzeS32i409hLZznOFcY=;
        b=jI+ULoBsXC2vKkOLWK74Zt7bNvN7kPcHQNIC67tYDJzH2jartJAQHA5An7SdCRJTkt
         RQEMTxRKD7jnknOA+SSWnsKHEA/6z3OgjWok8Pdg+MswrWJLicnri+z01WQDwDeHYZpv
         zwFRusLEifQyzf/GPocCTxLb1tsvqy51Jiu5YitmWw62gmvEREqGRjKZq3rX4s7ng78D
         ySIeCLYuLoXtWTK+X6/UXL1rCUV/tzNEKVzQo69YC6wwTMhfAwXvXaxOQnEsP4nQZIar
         8k5ZumjkWfKrEr/XJ4FCR5eeyuCMfQRWIPYs3G/2uKTVQnnAc8cEsvWvSNZKf3w7kF7L
         OJVA==
X-Gm-Message-State: AC+VfDxYSI/0hrMoanb4PjvoRCGqmAkdRR35vxHgb1HrN4D0jd/WuXxq
        GtqBG+8njk2AhVO4Iy4u4FadPw==
X-Google-Smtp-Source: ACHHUZ7wj/gcQ29SqjtFdOT9i9jtD3FakkeSS/upmgojrQC0P7/HF13gNCI198y84KiPEaHhCoJBeg==
X-Received: by 2002:a17:902:b288:b0:1ae:56ff:74e with SMTP id u8-20020a170902b28800b001ae56ff074emr12788781plr.9.1684786525810;
        Mon, 22 May 2023 13:15:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902a38100b001a6ff7bd4d9sm5339234pla.15.2023.05.22.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:15:25 -0700 (PDT)
Date:   Mon, 22 May 2023 13:15:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221315.B1E5C7B@keescook>
References: <20230522155149.2336620-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155149.2336620-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:51:49PM +0000, Azeem Shaikh wrote:
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
