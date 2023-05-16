Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A97055E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjEPSUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjEPSU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:20:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5010C2129
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:20:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae3ed1b08eso8773505ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684261219; x=1686853219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYBm9GcOUNPh4gLD7fS3/HVK5MmzEpTQ1UYJKsDW6z8=;
        b=ZpDWOGHhmLyAAR3xhqoNa9cHCEOfaCd0mVmq1oY9OAifiLQJPIAeDcvcIht0WKv8cy
         E4P4LnxaKMWlpehlw+14xCiOVeHMnRMwzLYGGBcC/85waa4EQvFMxrt3dhJbR8aZLMZj
         7MB+YXAb06DvCz9MejAWuoSkxao6BIe7GZygE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261219; x=1686853219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYBm9GcOUNPh4gLD7fS3/HVK5MmzEpTQ1UYJKsDW6z8=;
        b=Oa1oi7ELIw5ZY5vb6EzZB9TumWJMwe+qQ67ENbOgAFdzMahoXgbF5+MPjKKM010Nbj
         Q//S/y6pqbs6CX2a21Qcgc75suSXR3dfMcFaacIECtmk2C3JiBpBaDwBAmmGg1pVZyFF
         xTY+fB3sXu6t19e0ESWThR0MCNkK9x7yhbg7Mto8RUDRWqjInFH+4hQ3vy3NQZhh7CHB
         ncIdxh7/E1VLE0/BR91wiaDazdMfZH6oG07R1A2udTIv0JbAQh8dmNLzzZKwVCEHhiMf
         LS55AzU4O0i/hgwZD18Rihkk9QyID3d6Ll/wS/kDbNHD4rPk+XKH+iGbQu9mBTwwVrN/
         rGzA==
X-Gm-Message-State: AC+VfDxmBphs1rAGt7iRb+2htr8UI1b8NONaJDa+4onpLJOnY+JHfpQg
        UWqH2f02l0OoDtJG1unElZ0FzHsVkZlU3SwdOY0=
X-Google-Smtp-Source: ACHHUZ4CrDdQ4iLXNCzFZanLvMVQj9bV0mnZNPCVTJTpjTHbdVtXwUPj91zfKnKk5etlpLq1vX01gA==
X-Received: by 2002:a17:902:d507:b0:1ac:310d:872d with SMTP id b7-20020a170902d50700b001ac310d872dmr50492221plg.52.1684261218846;
        Tue, 16 May 2023 11:20:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902788400b001a69d1bc32csm15799763pll.238.2023.05.16.11.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 11:20:18 -0700 (PDT)
Date:   Tue, 16 May 2023 11:19:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: wil6210: wmi: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202305161119.A5486474@keescook>
References: <ZGKHM+MWFsuqzTjm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKHM+MWFsuqzTjm@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 01:25:39PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated, and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations alone in structs with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members alone in structs.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/288
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
