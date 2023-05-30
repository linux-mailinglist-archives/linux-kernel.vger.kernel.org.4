Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3170717145
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjE3XGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjE3XGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:06:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6AE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5289ce6be53so251883a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685487977; x=1688079977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYokZxIOUVujp68h63xsKw8F957dSkticFKlcbqHhEs=;
        b=jLnDjUSR+F3a7ACJ+OuNUh2bkPR65jjgaho0TGEpJaufX0Id0PlgloFBPUEmkZ6RYP
         mABDYUwgLu8IjIKVr1udT2MlNeS/w7Xd5DAskUTmop25P0sYOI8KmJxrsamFDK362z9q
         HMlu3yKVX60sfqFCvdRpPwB+IKwkf9vr5zuTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487977; x=1688079977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYokZxIOUVujp68h63xsKw8F957dSkticFKlcbqHhEs=;
        b=Jh1zAH4DAXyjKcpxwS/OOJ6jgIYYFNjAdM0k57dm7B+miscJbZwfGTpo6KHfbUEz29
         Q6dAIOmUNHRg5I9NwbNowM+ceFkRoBfOCf2VF3CXNpM51WBg5Fk9IhuolVfN8NF5LleC
         5cRYfVXztr/ZQjVp/WYAcnrRl4fWWCBik25m73HCiCmTxwK+tTIFzYfuHFvhP7HfyJ3W
         PuZCRcXayliI/ogVIfujW7Y2zdnZ6WXZIPXksklTZ4GqusqZz5ubp5jI1J6kdgwkaHrU
         MJd3TV9aM4BH3/mkLjz81dNqnWutkEdhSacesTqpbTibyswiUlGVQkn3aYHb6ZbGq7+c
         RyVQ==
X-Gm-Message-State: AC+VfDwkNTmaJEGuWDuhym/ocT4erMx/G5Tr6khZhN++5XHGzUSqz2hn
        ysIMOmCdnU5rUP5v7kbm2vOb0Q==
X-Google-Smtp-Source: ACHHUZ4OtGNFUdj4Dz7T+6p0N4d/4VLdKHYa3SVbaBygy+RKPK7o7dvXOoKBWUXL5DYe7ZiaLnJJhg==
X-Received: by 2002:a17:90a:ec10:b0:23f:962e:825d with SMTP id l16-20020a17090aec1000b0023f962e825dmr4091752pjy.1.1685487977114;
        Tue, 30 May 2023 16:06:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090a7d1400b0024e37e0a67dsm9469124pjl.20.2023.05.30.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:06:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
        azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:06:06 -0700
Message-Id: <168548796310.1350188.10745694845862015530.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523021640.2406585-1-azeemshaikh38@gmail.com>
References: <20230523021640.2406585-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 02:16:40 +0000, Azeem Shaikh wrote:
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

[1/1] staging: most: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/32c7fb186c1b

-- 
Kees Cook

