Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACEF70715F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEQS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjEQS4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:56:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF482FE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:56:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae4e49727eso12751435ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684349814; x=1686941814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Foj4fb82zG/bYBqANgJwBXrXANMC6U7inLZ4E4KgMU=;
        b=iOCD/WrUpOU4uwvpO5V+3F7ZkEOjT/WN64f9NAzD2urz3GLD/JuJAxgTLQG97peGK7
         yrPCCtFIbru/XgaK6AtKEUimK5Nj6D8P9YzuE86qo3BHb4OV+EnApoBRT5vIHGe5s10x
         jQMChyAVwtfMncW91E4P9FRdE5wgUCR5A8oQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684349814; x=1686941814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Foj4fb82zG/bYBqANgJwBXrXANMC6U7inLZ4E4KgMU=;
        b=ip03DQUSNTkC71r30ut42hS8vIcc378u2gRU8ZKihTaJEkk/Yi0mDH5EdSHd+fuOli
         Dgp3992gu1ENNUP5l26ByWhgttQ3u0//EdnUOcAa6twFRDyi846efamnTbLRu3kiwL23
         vulYJzr8a1lvGramJ0VjokRyJKx3lzVaqAIy+fuC5oQd9rU9cTd7X55NX8m12m9jyzWA
         QKFfZj7Op9mFjfT8ZlQauRAEl9OBXhw9t17la/Fj7vpSdSsYh3Zn9vwG56OBEuHFlGBe
         45bJo/R9bIdm4HdRQEFm/2Xm7en9EzOifhI++X2IAe1ZsL8Gg/FEEuBvtl87k963WuRN
         BZ4w==
X-Gm-Message-State: AC+VfDzGq7wJ+oFIkqdXwdTOnH5WpcSE0uhulDYkmn51UqqLEm5xplOi
        RNB+m3HTt6+EquAYmEcKkYKt7Q==
X-Google-Smtp-Source: ACHHUZ5hnnyGUiD6IbLeQh5HdBRkD0JKc0SMUktLHpS79jIBd1u/IX3HLGticHMt5x2tcZ6gCjzMKA==
X-Received: by 2002:a17:902:ab89:b0:1ad:1c22:1b53 with SMTP id f9-20020a170902ab8900b001ad1c221b53mr24650997plr.40.1684349814193;
        Wed, 17 May 2023 11:56:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b001a64851087bsm8129700plh.272.2023.05.17.11.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:56:53 -0700 (PDT)
Date:   Wed, 17 May 2023 11:56:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: include header in signal handling code
Message-ID: <202305171156.1D26B2025E@keescook>
References: <20230517125423.930967-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517125423.930967-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:54:09PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> kdb_send_sig() is defined in the signal code and called from kdb,
> but the declaration is part of the kdb internal code.
> Include this from signal.c as well to avoid the warning:
> 
> kernel/signal.c:4789:6: error: no previous prototype for 'kdb_send_sig' [-Werror=missing-prototypes]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
