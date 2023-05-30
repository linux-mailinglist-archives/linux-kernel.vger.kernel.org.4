Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC28717198
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjE3XVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjE3XVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:21:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD85132
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d341bdedcso3723920b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488859; x=1688080859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc7vYtyLdqVYJlU5zArPBdwQtjT1hwksutVKyiK2hts=;
        b=RtPOvBx3dMlTDpe5c0TAtd0y9Qiu8xj+GDcQbPfPV6YQuOZqmHe1nzftLegPTWVC0m
         mHLFvnsGa2fjECeOc1fJZ0mhJcVPVQJchWzNFW0Rt4Sq+TDlebqDgNKELlMzewvMrcVI
         ueVdwLUUz8VblSnY+SJnhGcOYbbtLKRK2O+Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488859; x=1688080859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc7vYtyLdqVYJlU5zArPBdwQtjT1hwksutVKyiK2hts=;
        b=Ehk7nE05JztvLK3eU8bzxHBQ0hjB3eGtC+GPnklBTdXp4/bGjACsjx8PHg0mjaPg/W
         k8lNEqmqwHMsXMGdGfGfIbeWiSB9NpHN+Zpch1Ft5uucHzkKduMHyXiK8M45UmiH7gZk
         oBktpkFiXTRyDkkAQTUGNedBoLJHn2KnRvmsZ21f2XxcGE51q4iSKILjs2P78CJ3eA3t
         x4REr6mU1umaUKXal1xxpVk9mVo6n0UdMkBrQw1o14pO9I2/3OCYO7+CDXJbjBOhlVMx
         lF2BLieYG/PVOzIdbVAVvGMFgCJm0SbAmCE2Aq3bYznWnElZi0JEvXG53AQAz4+gyiqE
         iLlg==
X-Gm-Message-State: AC+VfDyCx3nxjbS37xD6VJK4a1lJK4uoLeoQ+NKLAkTyyNRrCIHdO7k4
        zhmLdXJvY3wcKgt/85c372BHQw==
X-Google-Smtp-Source: ACHHUZ6/4RM2ME+yk788hdtWvOu/8I1E6GpaaAjTf2G5gm2Qi0K9bve9DfbijZUHfFnTHBAyzlxOEQ==
X-Received: by 2002:a05:6a20:8f09:b0:110:d78f:8156 with SMTP id b9-20020a056a208f0900b00110d78f8156mr4691119pzk.19.1685488859674;
        Tue, 30 May 2023 16:20:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w123-20020a636281000000b00528b78ddbcesm9362967pgb.70.2023.05.30.16.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:20:59 -0700 (PDT)
Date:   Tue, 30 May 2023 16:20:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Brian Cain <bcain@quicinc.com>, linux-hardening@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hexagon: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301620.52B9CAC512@keescook>
References: <20230530162608.984333-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162608.984333-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:26:08PM +0000, Azeem Shaikh wrote:
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
