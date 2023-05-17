Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9757071B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjEQTOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEQTOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:14:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA7AD20
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:13:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae557aaf1dso8644585ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350830; x=1686942830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3LyAD6kF+WYm6aM+dOL9pdJx+PYnMvlk4fW1DFmn8o=;
        b=aUN6Cw/VFUP8+Ce3d4zl8ZPmQT7+wxj4JmACdz58rbbxwEk3ZVr4Z1/5zHdUBrqcwi
         ee5OXXjwCTv6JjzwnROTkQ0h9MPxgv2Ietsiqce1dVljKQpSb/WAikrFdpXm9om+2lo7
         O0HUc6JtU7Drp1ypY6o2YWppaBJGMTkC4Xe+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350830; x=1686942830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3LyAD6kF+WYm6aM+dOL9pdJx+PYnMvlk4fW1DFmn8o=;
        b=kJJ5e12qmJR+QKvgVfrzIykQCm50LK1+K4Z3MSEFNFY2ZO4OldAb6glrYisHeR26ui
         kCrdVmapkSrcdvKdzJgzp0nU7Zzij+QlpN5CpaoDOqmqQ5ZB+TAG99UVsUGtKGAlW4G4
         LcjF/FPeRMGCjqbTiQNNl087IaAzkA+VvO1pi8PMpBtL+8JkzNwXG8OWgZcawnRritlN
         9MDQtia+6Z9gWc3Gsr9mHl2/IXu5XsrNTwDnR4nNX4Sf0vMWwa/129nYDx7BUf50V3ws
         6KJIkNmDtKuIBQc9rdaSJ8xVn6DGiNzvHtOldCqi0I2OBlQCTXszp8W8BBBhPUo1BgN2
         t1Gg==
X-Gm-Message-State: AC+VfDxZBXBVSC/CXbDVflLPP1CcaLxLIXfxuA71ZOH5ENxlv/RVst1l
        kxw6cZBnRPf5gG9u92F2agZtpQ==
X-Google-Smtp-Source: ACHHUZ6dcH8haH9mHEP9elVIRuuwE25P3Is4Xzixr93z0vZSba8vGzbWx2zxi6KVOnS6/pPFpPBo2w==
X-Received: by 2002:a17:902:8344:b0:1ae:3991:e4f9 with SMTP id z4-20020a170902834400b001ae3991e4f9mr5665517pln.61.1684350830446;
        Wed, 17 May 2023 12:13:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b001ab2592ed33sm2121288plb.171.2023.05.17.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:13:49 -0700 (PDT)
Date:   Wed, 17 May 2023 12:13:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: bnx2i: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305171213.DD6DF93F39@keescook>
References: <20230517143130.1519941-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517143130.1519941-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:31:30PM +0000, Azeem Shaikh wrote:
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
