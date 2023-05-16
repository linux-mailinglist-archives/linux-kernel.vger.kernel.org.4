Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506D7047BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjEPIZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjEPIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:25:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6314227
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:25:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3062db220a3so8958988f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684225528; x=1686817528;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEHq4uf+3svOh2D6WOkj9m9HzrghkGExgYoXPhK5Ua8=;
        b=rjMLOJ0tPgSjlAEj9jp5RzpEXpZLlb8LAC+cVFtAsCg/LkCjWdjdZdxQ3h+h2DvGju
         lZKgayvWyzOPXpppl4Kas3hreyHLHcZjgrdy6f0P6PyDQ1MNXMIopuixLiZOp5Q59Q/O
         jM/B3tBtQArURowHYX9oC/tKd7JbgWstcv7J2507HGEmmY1JHfOgtSExatryH58a4qoi
         HzxcsxZEPQSinBXRNkaxSYUt56td21QlYNZL/g1uotEbp4p9CTjH3a0AMwJniz2rajmC
         pc5ti//Z2Vs/GVLdDboh2ip8g+inakT7Jt6Q7p0+fc6Pvc1BHcaS9gLyMoFroH5e6GyL
         1M6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225528; x=1686817528;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEHq4uf+3svOh2D6WOkj9m9HzrghkGExgYoXPhK5Ua8=;
        b=DAqxhUVWKKvcngbPs3qCx8R1iLAHz15oeNwVMJKEdlCkCk5ofT42Mf+e00XkavH4Hv
         yyezMYDxa2QUdnldrjS6hxuPObyeHW3g7L1zFiwxO+5udRMLLi7LD7uFZz06+ErMbLyL
         OfkjfBv3PuVYG1MImHvJg45L/xiiqHcrX7potAiEkbekFlADUZfiSUA5VHlw234IVvEz
         JtxpcTN5F6u0N7EYDjBPct18RHeQ9RGwC2m+KUVW3rLb4033aS6Gd+bL92hF6lDO2noB
         6pbzagiOkkQGo+AV0cV5lJhO3lUbH/abRclatIEsCDLgRfGe9LOVkQLA34dV1Ydfjc1K
         Dy9w==
X-Gm-Message-State: AC+VfDygt3IZJQ+yS6kcvhLRxI39impGp2xRkI2fF+KCmC0zwvGrC2T1
        9PICtZE9uMkXClWgSkieCUS9rg==
X-Google-Smtp-Source: ACHHUZ6B+surVC4xL16y7czkG/1us80y98HY9it8a0hLJBdVC+P+tF7o3qpa6eUkcv1lgq+qmUBFiA==
X-Received: by 2002:a05:6000:1813:b0:2f7:80d9:bb2f with SMTP id m19-20020a056000181300b002f780d9bb2fmr25959439wrh.22.1684225528009;
        Tue, 16 May 2023 01:25:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r14-20020a5d494e000000b003063a92bbf5sm1727505wrs.70.2023.05.16.01.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:25:27 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230515184408.9421-1-francesco@dolcini.it>
References: <20230515184408.9421-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] drm/bridge: tc358768: remove unneeded semicolon
Message-Id: <168422552722.63953.3468930623030924435.b4-ty@linaro.org>
Date:   Tue, 16 May 2023 10:25:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 May 2023 20:44:08 +0200, Francesco Dolcini wrote:
> Remove unneeded stray semicolon.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: tc358768: remove unneeded semicolon
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=81d6b37b69b8b5d1a4c81d2e208b41888d4283df

-- 
Neil

