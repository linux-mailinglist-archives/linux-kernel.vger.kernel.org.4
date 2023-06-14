Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D694730790
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjFNSqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjFNSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:45:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449801BF7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:45:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b3af7e3925so31668525ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686768355; x=1689360355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClhXyTMCOAhGnHue/rYnwljuM17idvr3usaXpO/VYvI=;
        b=iN5gmCcfAB7dsmep+MstonHEHRYzEhlS+IDRUeD1FVo2baBN7gE1e/6OykHCJtDM6k
         Aiv//w+9AXJ/zy/NXNT20xnVtwfIlXKbYo/O5dPK5a9/RFmRk3PVym1cdIHem0bj4BEf
         as7tjxepzRLn+7/UlA4gAW6PAVikEu3RC1W1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686768355; x=1689360355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClhXyTMCOAhGnHue/rYnwljuM17idvr3usaXpO/VYvI=;
        b=JFwiZOSLHDy2W8T3AvP3U1aaJqLxLZeFQxHz+Lz4lKmDabEsqg1Ox6Lsx2gk/mHoAx
         lXxz7DkspzAsJ3rMFPexXMlo+YFhVb9xz5COgDM3eQStsgycjETjbPBl2qXIM7+22QzY
         UsxJE2EPvCPRQo5OFcRlzvKiZKwpYkSFWHlBSoURpAoJysFJ9rJNM25eA0n77RKytJlH
         ooN2qZxj5ItNohe5SLH4iRzAc8LfGus97MTKACBKuP/J2MO96aXoDwpa50Fe6OflMVuE
         eDuMc8O9SDXGCKxi7zxPpEOQsA0HZ58uYwBnQKiSGKqgr2gVcxAYOkMtsFeG24SmjzFG
         71Dw==
X-Gm-Message-State: AC+VfDy9zl2fi9cHgfQh1/D+tgS3X0ZtJcvdh7AtqGNave+UkY7KYTvt
        o+/TF5mFFitBAKeb/m5ErutPIg==
X-Google-Smtp-Source: ACHHUZ6J3AlNKEtdy+6aTy3emeKWFNXqfnFihyGEv/Pc0nkR+DlArJgpJPxQ9pGtGnsi+YY/88GzpA==
X-Received: by 2002:a17:902:d389:b0:1b3:b84b:9017 with SMTP id e9-20020a170902d38900b001b3b84b9017mr10213717pld.14.1686768355338;
        Wed, 14 Jun 2023 11:45:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d68300b001b243a5a5e1sm5902905ply.298.2023.06.14.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:45:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        ysato@users.sourceforge.jp, azeemshaikh38@gmail.com,
        dalias@libc.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, linux-sh@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sh: Replace all non-returning strlcpy with strscpy
Date:   Wed, 14 Jun 2023 11:44:29 -0700
Message-Id: <168676826702.1963449.9061022814058323294.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530163041.985456-1-azeemshaikh38@gmail.com>
References: <20230530163041.985456-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 16:30:41 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Build tested with sh4 GCC 13.1 from:
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/

with defconfig and:
	CONFIG_CPU_SUBTYPE_SH7343=y
	CONFIG_SH_DMA=y
	CONFIG_SH_DMA_API=y

Applied to for-next/hardening, thanks!

[1/1] sh: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/ca64da3052be

-- 
Kees Cook

