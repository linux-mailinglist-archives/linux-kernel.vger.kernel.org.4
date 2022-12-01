Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89663FC2B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiLAXmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiLAXml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:42:41 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6803EAA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:42:38 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 136so3017428pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYaAuz+w4vdYZfsYDz+oOuvKR/cpiOgie6VFw1LV4mQ=;
        b=avvaovpY8709YgS64snIHQSwqeg7ys+GMPllTNmQzhGERBABOksdBT3d0/KsXrOCRm
         KAL/6xZ+mrMu3Nz45MnWX4Jxu0tWzPyxDxHSBbDg9gidsIZFBJYefstX0lfeSG0eaC6k
         8r0GZ4aieiFN8L2baEya7A3N0wv7qWbUxodS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYaAuz+w4vdYZfsYDz+oOuvKR/cpiOgie6VFw1LV4mQ=;
        b=KFwf+Oref+4Sl4QDOZ15HXOj8LIB5p36KkQZn/mi5EY7zkuU/in4KP6UkVqwbshV1Y
         wKgsyFLgRl2MmhPi9PtY5LZsMXSYFdJ4knzAV8dZ3F9v7ZHfbuD1mCIIM66OxrcjqM6m
         +sA0W36cHkfpDUqEZg8bTEqVo2QLWrB+fqioK+LI8NEQC0A9vsKqwBLZyI3PBN1tixhK
         YaGW00dxADUlsM89OfsyltPlfa3+hbFrTlax//dGR+qZGdnlxAupen3FPlwH0d5/tLEx
         AlXlu8eat7177w7iYUrtGiIVrfGiI48gYRCDZGWcG1K3Ccs14t/EJvvBL0ennUxOe9Kn
         YIlw==
X-Gm-Message-State: ANoB5pnkqsKQVdpuMpLjp1FTiH3Y5GAUWA0iSFHeUzWlZLgVBF+lLj8X
        agXE7KpmHuEZZmo8/owIrPdcHw==
X-Google-Smtp-Source: AA0mqf4haPNn3jC4MJ8/LumQ/z4VlcwWdyH89TAuLpTjJVXzAeubcwLY8UnaCDu+bSvc1xmxOPE9pw==
X-Received: by 2002:a62:60c7:0:b0:56b:94f5:400c with SMTP id u190-20020a6260c7000000b0056b94f5400cmr49309464pfb.31.1669938158427;
        Thu, 01 Dec 2022 15:42:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709028f8100b00188fcc4fc00sm4198248plo.79.2022.12.01.15.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:42:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     haifeng.xu@shopee.com, brauner@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, elver@google.com,
        oleg@redhat.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH] signal: Initialize the info in ksignal
Date:   Thu,  1 Dec 2022 15:42:28 -0800
Message-Id: <166993814728.941514.14527504091820169396.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128065606.19570-1-haifeng.xu@shopee.com>
References: <20221128065606.19570-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 06:56:06 +0000, haifeng.xu wrote:
> When handing the SIGNAL_GROUP_EXIT flag, the info in ksignal isn't cleared.
> However, the info acquired by dequeue_synchronous_signal/dequeue_signal is
> initialized and can be safely used. Fortunately, the fatal signal process
> just uses the si_signo and doesn't use any other member. Even so, the
> initialization before use is more safer.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] signal: Initialize the info in ksignal
      https://git.kernel.org/kees/c/935d428bb528

-- 
Kees Cook

