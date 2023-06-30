Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8074422B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjF3SZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjF3SZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:25:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99311CA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:25:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso1620881a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688149524; x=1690741524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THzb2mxWSB498SbTKEigAG3BbQmUyfPai6SPDufuYVQ=;
        b=fwgdBLRw/OL24yIe9DR1DbDq0ls1En8ub+t31vUJPas+cneMdfjhphEdaVvHMtIfQp
         Z4KwZyofbAGkDREK40sNwJ1hl3USv7l72P7sea5BRSS6KXuXklxGzctZ2/AuuVvjhYkT
         3LinGnv99CoMpoHT6PSreXbOM+aSwZ75RfenE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149524; x=1690741524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THzb2mxWSB498SbTKEigAG3BbQmUyfPai6SPDufuYVQ=;
        b=PZh3O1nirNMgpOiX3+KubJNx19Aupd89XUeLa1pxzoJfEsM6gmIYB99n4N5+RBT9+q
         ggjpsaEDmUEwmqc5iJ4Hp3YBqxaCUJoB1a7adL0n0iEKTM64oaDCTtIZM1mNocUMbsH2
         dejQVNOpxBe05LUcpRC+qCUrHM5qd6WLRbLBNbeA3m430nnyxs0XdHjSAHAYNdyFOpWS
         OENCr1FwgS1Ux4JD39G6TrAe1V6Y7KdNvmnv2YFz0VlH2iHH6nUfKE0PU1rq925At/U4
         wtr6cf6IdtDR40wXVRsdY06rzMQ2/jcp3OIM4Z86sCRNLtyDCXejtxdzUArhLjlILRHi
         dGfg==
X-Gm-Message-State: AC+VfDw0FF4UVzWU7bUdStD9iOJNDVAUgSDzOM1mzZtV6JohwdIpn4HX
        +eid5bIaSjRcmQebyzMQecyYaQ==
X-Google-Smtp-Source: ACHHUZ4BxNqg0tDxcmJLzFG13UXanJEtBxUPHSlYkDyRPNnGGdkF2s45tYBqApFjvkyqxE9iTc+X8A==
X-Received: by 2002:a05:6a21:998f:b0:111:1bd6:2723 with SMTP id ve15-20020a056a21998f00b001111bd62723mr4289059pzb.3.1688149524129;
        Fri, 30 Jun 2023 11:25:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709028c8700b001b03842ab78sm11096926plo.89.2023.06.30.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:25:23 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:25:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] riscv: Add ftrace_stub_graph
Message-ID: <202306301125.5E2EE84@keescook>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-11-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:42:48PM +0000, Sami Tolvanen wrote:
> Commit 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and
> ftrace_stub_graph()") added a separate ftrace_stub_graph function for
> CFI_CLANG. Add the stub to fix FUNCTION_GRAPH_TRACER compatibility
> with CFI.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
