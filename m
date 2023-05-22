Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC670C8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjEVTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjEVTjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:39:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566DC184
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso3012479b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784387; x=1687376387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeBiZJ+mkcROTMwzny6Jscg8KAQZlqaxY7QZOK6st8o=;
        b=hPch3qB9RpnmdPFVirVd2RAwofPWHGA9pXFsd2Y98GlpOd3JYNhShIQSeeWZcB+WMs
         Vd2MDXHOuc1aKVfPRk2Sded3e+d6LWrqnTxDKr8zuE8b66EPEOqgmrXBsirm7sYH5aKV
         yuq4KN+/g5NIAOWCKmx2ilvGRMDwokn6BgXpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784387; x=1687376387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeBiZJ+mkcROTMwzny6Jscg8KAQZlqaxY7QZOK6st8o=;
        b=SxvErHu/PVPEaUzRJpFwa83im9J1ikFxSUwnpDMqNmKu5wZ9fVuw/KoZKThZCDmicd
         TJBLn9lV75U2+2NS06bnm3CIumxjYWqKYdP3cuPv1v8ObcJ8ydgfgzaYfhnbD5vRssSG
         BobNVizTYtvUd6AOX+tK8CtvyrMeXb9NBMDig7HeYNboLiiNuiP32RjpiJL+4oNK7fJp
         ZQfxqyoRLxap5R+VGItmuuKKNHQHCQ4sDPdJxDA2/Pc0HLBUzOTa4F/vSp7PtHb4GdaF
         pWKJPpYMTluds920ybTZzDLTn6UYcKsfzJbMAXUWy7UVBk+G8QG+IOSg5hsv8ex6pbKQ
         yJLA==
X-Gm-Message-State: AC+VfDzdePrFCWhdBY5Khfi8dVIyQsmOVytcgOvD6wuO6DjSgKW/5FeV
        iLlC7LO5SSne1nPz/hlAHGwjQg==
X-Google-Smtp-Source: ACHHUZ54dSWFhkpL4abI2tgoRFctOL2MElc8Bh2F9GR8ydE32Kjge5WqUJ4f4wGFGOUH03A5KIDV0g==
X-Received: by 2002:a05:6a00:804:b0:647:d698:56d2 with SMTP id m4-20020a056a00080400b00647d69856d2mr15842120pfk.27.1684784387602;
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u24-20020aa78498000000b0064dbf805ff7sm1504699pfn.72.2023.05.22.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     aacraid@microsemi.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: aacraid: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:38 -0700
Message-Id: <168478437625.244538.2849240506920412730.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
References: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
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

On Wed, 17 May 2023 14:30:49 +0000, Azeem Shaikh wrote:
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

[1/1] scsi: aacraid: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/d966a54946cc

-- 
Kees Cook

