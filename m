Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3470E3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjEWRTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEWRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:19:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0E8B5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:19:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so8750b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684862369; x=1687454369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhdnKxVU8mo4nI5H1oRl197kuHM+g1eNkzJ0cHFJ7RA=;
        b=MwN4DVCBvOHZmSmfLl/EWVYpzBvrJ/gSzhjcK6XTYZKL9AHP073mN4nhk9Ne53vqZg
         kkoBB5B2exsXkiAoCr2Tkjklv0r+MZTNKTOr5e9EwtM5ta5E4CJvKQYohRWPJsY9iSQy
         JRUI1FBciW1TTFujIWCgZh8yDSRTeI1S6EfvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862369; x=1687454369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhdnKxVU8mo4nI5H1oRl197kuHM+g1eNkzJ0cHFJ7RA=;
        b=PmqwD1BS0Ii39evuUz6+HuoW/15PlmakqBxjV3NefR0o05Hffvmclql4ugN8GZ1ntB
         WDm+ccYFHF/5r7IAKJRTioT9R6B/57VoYAbS797gPOEFChsDOv1f2atemVjXx+iNUOLN
         axGtVo9IwFojyQTikilIz/ezllTU0ehRlk0HFwW3UPJBgSN+1SM34gq+emOHRkEi9Oy1
         t0h1t5cYEkDuewsUDpmihx1vY5iVUJTX4renpoMRaECKMZNLiQZoPZDmHkEnyrPzGCX/
         KN0k4n/OofXnguu1PektSMtZC55AC4gOMRZK6fclvYYO9Nj5gbZygZ6Ef+Z/ZkxNjwRK
         zs3g==
X-Gm-Message-State: AC+VfDy6VPGCWP2EIbh0SEq4WyD/WkEAkiu2icveIk66y86IXZTxNdZe
        b2jytbjEA9+gDzK17WhAxV4dTA==
X-Google-Smtp-Source: ACHHUZ7pYafOwubkexMSJtmC0irXuN1qWSgt5wCCd4SHMKB0SyV2Gr23uvjRKAixTn2lm9hscG6/CQ==
X-Received: by 2002:a05:6a00:804:b0:64d:1e10:5000 with SMTP id m4-20020a056a00080400b0064d1e105000mr20767369pfk.14.1684862368946;
        Tue, 23 May 2023 10:19:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d1-20020aa78681000000b0064ccfb73cb8sm6048427pfo.46.2023.05.23.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:19:28 -0700 (PDT)
Date:   Tue, 23 May 2023 10:19:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jan-Simon Moeller <jansimon.moeller@gmx.de>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: blinkm: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305231019.C6461091@keescook>
References: <20230523021228.2406112-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523021228.2406112-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:12:28AM +0000, Azeem Shaikh wrote:
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
