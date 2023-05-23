Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85D70E2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbjEWReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbjEWReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:34:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E331EE71
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:33:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae454844edso53929375ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684863216; x=1687455216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5TaiMEFaVRXBBXmrOT5rVhJkyEwfpcOBFjZH1D7ygU=;
        b=Myk//XnL+kcfvxEiu6r+DEazWtDYHot8a7HGhSgrCLT9b1EVVnsag052Ai+KzdXHoi
         1nNww3UZcbHk7SCmfSTINJ4IyaPi7b6r1OSROire4HNLINsmBtaJWqinJ6DoaLbeUtTW
         /UxiVGHhvdzOV1dasHhaBpQAj/fGwcY+PYVKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863216; x=1687455216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5TaiMEFaVRXBBXmrOT5rVhJkyEwfpcOBFjZH1D7ygU=;
        b=d1PLXk+YC5kAOLLRCtgmq9sn44H//hHSDq5AMYKVAaYpYfQHMdFtLWe8WOw4Zj7YUI
         nVhrLblqZVqajx14xUTGCmWH/IGNByaoJAggUK5D4ckTwrvzCOmMpweiQ07FVZX31pTe
         fzR35TszLe46dcOiKhVo3eouaM6L1mk2nzxdcHDybrDzFAsNdy/SEw5MLCm/OjwN4D8A
         mLE4hxb0shXOyOSEL0ZKHjLc9lo1nfH4s1cMxGY704VS+OJ52dQcBnscoEBCqjOP1aI2
         w1K0mmFOEMJexW34lxfRCPHURHg2WU9usBznRCmxZE3pgwYvQijJb8XrJfYHQfXbCW5y
         w1Rg==
X-Gm-Message-State: AC+VfDwCqyQG9DCgS0bWHsPu9KAmKyh+ADXEg6nHpHS3E02+lkpv3mpL
        oUsPsIk/vQgL81JDkmofqX1NXcLNUC3FM2FtQN4=
X-Google-Smtp-Source: ACHHUZ5nwNAWC6zOqEQfgyyaEtHV6Q5KAnW9bk4XY0Mad+k3IZZq1+L248juk8kAqBZXvMIP4RNNjg==
X-Received: by 2002:a17:903:248:b0:1a9:3b64:3747 with SMTP id j8-20020a170903024800b001a93b643747mr18446929plh.17.1684863216117;
        Tue, 23 May 2023 10:33:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001a2104d706fsm7052433plx.225.2023.05.23.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:33:35 -0700 (PDT)
Date:   Tue, 23 May 2023 10:33:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        linux-hardening@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] i2c: Replace all non-returning strlcpy with strscpy
Message-ID: <202305231033.2842F1500C@keescook>
References: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523021150.2406032-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:11:50AM +0000, Azeem Shaikh wrote:
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
