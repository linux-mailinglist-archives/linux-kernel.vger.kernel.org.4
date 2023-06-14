Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD149730829
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbjFNTYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbjFNTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:24:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9826A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:24:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6668950b6c0so212512b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686770643; x=1689362643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBFhzdyVFTFeidFRV/hzmSKzDZQEfLbMd1EOce0vowg=;
        b=PuyEFSGBXGTrO/fhnwBpCkobIO5Jk0/+9gDFSJqGsDrc1TEiSpswv2wUEiuqy9xEcz
         62U47wGFpFzCuFrREagC8eEbD2FxOcYrBcsQFjO62hqW5F+J1ZlWuUvYdhN5iR17064j
         JUercQ1Lpn//9ZJX+29k81+pv2OIEEUpTYMmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770643; x=1689362643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBFhzdyVFTFeidFRV/hzmSKzDZQEfLbMd1EOce0vowg=;
        b=UXC95346lUx/ihZWUKVm90Ri2QUByolddJX3UOwA2KXV6pxvtXs4WKPU18kluQo/p6
         L8t/ZVWmjGhPzBhh3vLZpUHGRKVfIRNIcLfo8SVgRV4s1zj/0T7sq8eHZ+ukes5H/OnP
         d9jg5SkOZkbswuDbcMDUKdqoxN0DNUh80OtLx8W3+O63FxU8+aA7mel9NPGgfqTYSt57
         eC6TLBh8SlYcF4CHv8AmqY+yxEW27MbgXs31DDT5fOY/QUy016P7KmwDIKJqN8vKUlzK
         TblknQve+4RmcQICRw3TpU/8fTnkABRpj/gxvpmaytURvoh9VDcP07gvZBM1wCUNwitO
         TtfA==
X-Gm-Message-State: AC+VfDzlH3CLjLyUrGau4cPILbblfR9xEtg58ZM1atdgkhlwqFoKZidc
        96LfFmBmnQdkQ1O2XzK+RlKTfg==
X-Google-Smtp-Source: ACHHUZ7SPmlNngLf5Yjzik1pSrgKnOJsza4hMlfEDXZnlvtwsMUHrcep3YDul2Kfpc98729xaV417w==
X-Received: by 2002:a05:6a20:5481:b0:10c:b441:5bd0 with SMTP id i1-20020a056a20548100b0010cb4415bd0mr3078684pzk.18.1686770643711;
        Wed, 14 Jun 2023 12:24:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0063b6cccd5dfsm1619049pfi.195.2023.06.14.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:24:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     keescook@chromium.org, richard@nod.at
Cc:     linux-um@lists.infradead.org, linux-hardening@vger.kernel.org,
        anton.ivanov@cambridgegreys.com, Al Viro <viro@ftp.linux.org.uk>,
        johannes@sipsolutions.net, azeemshaikh38@gmail.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: Use HOST_DIR for mrproper
Date:   Wed, 14 Jun 2023 12:23:28 -0700
Message-Id: <168677060698.1965769.17288786387912659034.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606222442.never.807-kees@kernel.org>
References: <20230606222442.never.807-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 15:24:45 -0700, Kees Cook wrote:
> When HEADER_ARCH was introduced, the MRPROPER_FILES (then MRPROPER_DIRS)
> list wasn't adjusted, leaving SUBARCH as part of the path argument.
> This resulted in the "mrproper" target not cleaning up arch/x86/... when
> SUBARCH was specified. Since HOST_DIR is arch/$(HEADER_ARCH), use it
> instead to get the correct path.
> 
> 
> [...]

Build tested with/with-out patch, and I can see "mrproper" target
correctly cleaning up now.

Applied to for-next/hardening, thanks!

[1/1] um: Use HOST_DIR for mrproper
      https://git.kernel.org/kees/c/48ad87a5be06

-- 
Kees Cook

