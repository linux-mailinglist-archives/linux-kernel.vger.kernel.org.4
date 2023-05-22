Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8570CBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjEVUzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjEVUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:54:53 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C700B7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:54:52 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5208be24dcbso4575061a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684788891; x=1687380891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NoMOPLv7no4oTfFk9NPdm7qdXLsHesaFY5RP9uixIY=;
        b=YAbkAhamHMqgwB/fmb97d06Aas3nfKBdgo3MFaaijc8nFzNSIQN4hG+Q3a31wS63AP
         K/0Q5fEOURfRDKRvNesUwiJ2FuPd/kvLXtteSJHVjZDEzM4ir/gWRYNlsj+jTs6J34x8
         tM4UB+Q+LycG1DFt0P+cdepL/65Bzozly6vJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788891; x=1687380891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NoMOPLv7no4oTfFk9NPdm7qdXLsHesaFY5RP9uixIY=;
        b=da9ZtGXBhWhKHXeR67cuGukXSO9TsaJplEGrWI5SSkW9cUTiARrxpKb883QNefVaXl
         gj5tJt9lCzClTAK25S9elZJfJzXbRekRknYX2URPsH+suKdRchx5K//bMAA8QCKdp+8H
         ikP17dupqgb6OmCUP8QKdMB3XgIqgGPb9NkTimic+jlzom5fer3UXRjJBZw4n9sRmps1
         hykkQHzmh4/O0dozBobyUZxn6XdJAkp6thZsSvkUTa3ILm0olqKrM4eGZW+hXYAERJax
         IDXc1a+54+jt9a1orI9oM1S7SKMnqODB0dsQrWMRiiCEpVZHgQWZY6avrfgt8suznQ/m
         VQfA==
X-Gm-Message-State: AC+VfDxifoOeyaxbOIuDz5rpJIs+NmA2GD8atAgshRZkGBV+bkKAYTFi
        A9A79Wl2Q4HdM7EouwpQ1m1Cdg==
X-Google-Smtp-Source: ACHHUZ4WCaSPgXTc5XPwlg4IRq/kzCNCY0JzzAU84nb9QtSpKKa25DGdSRYQ9MlGMDG8WMvF0qdEIw==
X-Received: by 2002:a17:902:c944:b0:1a6:46f2:4365 with SMTP id i4-20020a170902c94400b001a646f24365mr14314154pla.30.1684788891502;
        Mon, 22 May 2023 13:54:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902bd8a00b001a1a82fc6d3sm5231582pls.268.2023.05.22.13.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:54:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, evan.quan@amd.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Xinhui.Pan@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, airlied@gmail.com,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/pm: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 13:54:48 -0700
Message-Id: <168478888725.1444594.3121115156306616962.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
References: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 15:52:45 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drm/amd/pm: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/0f53b61b1ca0

-- 
Kees Cook

