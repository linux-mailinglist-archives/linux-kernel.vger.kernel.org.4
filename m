Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D4E65C857
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbjACUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbjACUp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:45:28 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C021409E;
        Tue,  3 Jan 2023 12:45:26 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-46198b81e5eso452658157b3.4;
        Tue, 03 Jan 2023 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+3JBM1k56yKl55H/sSVuzObxHoNMCyKwCe4lUAVYz8w=;
        b=JIjRdZPV6+BSjR1ei14D7j5zk9/1vwJwzYbL+Q4/0tWfxOdhiaZT1sAaw20OZlQpTY
         qg044Z3y0LBmEJIod7ReIE1pX3P4KLWCk2gTLO9XXepI04IRWRJsYl75xPw61SlOwWWC
         X+QYXE+q4vYXBnnHl0XNSqeMl9J5PXyvqmHtTHNvB+igy7UmU+GHaL3jmFiI5DG3CYnh
         uLpwMUwqxaE9VkWlIw7fAqATVkPKb8AIM14OUuNQKgWloPrY/j7POOp5IT0OEI/8y7df
         jfGEUSzNTPk+LjMSSoDIj5XcZ+U8Up6+oEViIX2T8Lym9Io+tbuF80c9iSUI/tSf/CeT
         zitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3JBM1k56yKl55H/sSVuzObxHoNMCyKwCe4lUAVYz8w=;
        b=HL3Tla7fDnxjPHMkWaR3yTxEc9qNMNpBSY3gTys0lcWQIumuA+bgnJDRBWTF4sIZAj
         wUW1Cmnp36rmnp5zzOSljUtoaSbGvGqvkgb2IAz5wiTR+AiMwASWnioTXwd8EAxC4Kmh
         jw1k96DPyS3953DMP6sxAGIjMxZ9wwPpStHDBJsI9ORAED32DnQiV/flnXHYoCLVZ9jS
         iVklLerhcoqhP/4M56GruoaRfQuXZCyB/nFPKwwI32yPogAqd4Di4iOG9r6xCFbv+4op
         P9FLXbVPx7pUo6pVsBpXuMaNL5edOdPkxmE4D1Mp/wnxbQXhXPwOPcVzcTGUtBcDGstC
         C0SQ==
X-Gm-Message-State: AFqh2koOlE/OITJY0qdZYjyetNz2A9pRU8QVAzokkr1hepPnTR59ATkj
        mc9PKf2o2pP7mPdTiuCepTYxDJATXHbqfrg29ro=
X-Google-Smtp-Source: AMrXdXuDfedFAD34vQELEPd/hr3pWJDR0G43tXNA7Ak90t3yosTF3jzXmM7MeqbHYm0/FgdrZaHJ6/MYjKLTEMSjTQM=
X-Received: by 2002:a81:94d:0:b0:3bc:7270:cb70 with SMTP id
 74-20020a81094d000000b003bc7270cb70mr5510503ywj.83.1672778725262; Tue, 03 Jan
 2023 12:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org> <20221231064203.1623793-3-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-3-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Jan 2023 21:45:14 +0100
Message-ID: <CANiq72mxvxE+6p44157v4hFgyTugO_0+J4nuZteajM4wLVbCtQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] fixdep: parse Makefile more correctly to handle
 comments etc.
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This commit improves the parser a little more for better processing
> comments, escape sequences, etc.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
