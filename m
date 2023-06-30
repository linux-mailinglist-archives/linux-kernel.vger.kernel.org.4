Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892A4744233
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjF3S1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjF3S1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:27:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB61B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:27:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666eef03ebdso1264538b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688149628; x=1690741628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5t/XCescOSH3WrNyDablW8O75mx4NM5DVxxt7h12xmA=;
        b=LXTFdVugLTfGdcztpl1w2i9zg6mOiIcldrFYXDwHLgZCmp/TrhXKsJ02A6K+EML7zA
         cQfqy8eoBYrQGKV8bk7qFhFFyMS3PlCs0enpW1ivslO0K0HawB/c7SqpufuZd3aIm6Fb
         71Yk+FVuiiqRdEousZgGpKXlzwT/s9JQh6A1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149628; x=1690741628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5t/XCescOSH3WrNyDablW8O75mx4NM5DVxxt7h12xmA=;
        b=ObCVQmn1+Vhm+5JFJFpNlICFzf9SKYR6Fwca38W1mPKFfpvNIYpLSAOWid449ACSZt
         xa2b69f1JQxssNRXmke2YpEQOGHStJ19jZoy3CxGz4t73cdH0ee7lgzOrY9f9aqhJ9RE
         +pyfpv2OWpAamXnxvBFtoFgpJdURj92Lx3InU5dj4LqnIFNJ1Rvd/OCEs8KAhbhYKEap
         5F5gHIG33iYV7xF4EATYeZ1KyMV4bhJcHR+X+nvfIeKpQQfNI6FwtpsGVzo4+1PLMEKt
         UYYkb5TBRaV8ttw8y5KaZXJVG5+XdCv1lYnw4ot0OdkjtfqVjNlpEPYgeMKMajxbj8LC
         fWYA==
X-Gm-Message-State: AC+VfDwkahL6qco78jahhlP1Zi6bMcf305fXH0qYWsb24bpi92+TBCaB
        wmkU9SBAhovCS+VMIdU6YQy1qQ==
X-Google-Smtp-Source: ACHHUZ7ErgW8c42xZjlrONwyIDX0fbYZnPFTbXDgs2IWbzVwX2JCviMz9xGbIQ4Z/aYlsMj05YSgdQ==
X-Received: by 2002:a05:6a20:6aa2:b0:10a:ef63:4c33 with SMTP id bi34-20020a056a206aa200b0010aef634c33mr2672145pzb.47.1688149628100;
        Fri, 30 Jun 2023 11:27:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jm15-20020a17090304cf00b001b016313b1dsm11094410plb.86.2023.06.30.11.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:27:07 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:27:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] riscv/purgatory: Disable CFI
Message-ID: <202306301127.9730BE4@keescook>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-13-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:42:50PM +0000, Sami Tolvanen wrote:
> Filter out CC_FLAGS_CFI when CONFIG_CFI_CLANG.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
