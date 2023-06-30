Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CF744234
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjF3S1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF3S1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:27:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835343C01
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:27:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-553a998bca3so1425990a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688149635; x=1690741635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCaYu7xdiD6BYe4W0cxKoMr/LaGK6LhgIOaIA+QBb3Q=;
        b=nWBu4aSpwIzbfoKGCfhgKgbCs6gDjEv/fnSx1CZ7ic42Qqt1/WL8TD+UVwGZETfDwV
         QQjyRZ4dCdNb2q1kRyMCOxZDVEIeJBBXl3s1lSTBfxu9RMPdQBTcm2qwPHx2yOX+FF3f
         SrPrpOqomzg/3qgcVlXGzRn6taGxmQw1uUQZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149635; x=1690741635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCaYu7xdiD6BYe4W0cxKoMr/LaGK6LhgIOaIA+QBb3Q=;
        b=h6HVrkeypaqB79CZc1ZI7RegMZfl/ATxLC0wqxiZcY1kRpguD4wTZO7gicqXGCDMp/
         8SAaeUrh5vwD3a/aU8J15vL6WsumM5Q3ulqH9Jq6D4HAgqV+zaAPeXiBHGnYesap1ld+
         doZdK7f6NXur8kV/nla0X17B/AqwclOwDaahb70GY6w9oBaJ6cv1ZSzrHfdo0mykfNgy
         9LCznU3aL1JXZZbcoevXAHiRGOIhnHd9HZ0ztR0Vqpkc1F9lLPcJ0BcVzTrU55860yYP
         ry1aVd2TuYScV+Td7QwCr2wNgtvMhquuLFHSZHx1fMUj4JobkhmqwPaOYga2lBeozt0+
         57vQ==
X-Gm-Message-State: AC+VfDw4AfcBQaDHwDE5LY8GiEKio6pM/6Jom1nVcMGjFrQfTeoXW1Wl
        mSbHQmo9xMD7M4JvGRpQFAFndTfbJqROQ03Q9kQ=
X-Google-Smtp-Source: ACHHUZ4xu3/wYm9bZWhQyjBCDCie8wDoJAWUFLnjI06jhYBKyFPIxuphb53h3EEDqEvg7aT4BsmD0Q==
X-Received: by 2002:a05:6a20:96c6:b0:11d:4c79:90ee with SMTP id hq6-20020a056a2096c600b0011d4c7990eemr3081600pzc.25.1688149635037;
        Fri, 30 Jun 2023 11:27:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u23-20020a62ed17000000b0064d74808738sm10138390pfh.214.2023.06.30.11.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:27:14 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:27:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] riscv: Allow CONFIG_CFI_CLANG to be selected
Message-ID: <202306301127.4EEB06A4@keescook>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-14-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:42:51PM +0000, Sami Tolvanen wrote:
> Select ARCH_SUPPORTS_CFI_CLANG to allow CFI_CLANG to be selected
> on riscv.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
