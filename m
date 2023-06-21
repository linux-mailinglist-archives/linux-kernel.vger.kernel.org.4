Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36447384E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjFUNYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjFUNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:24:05 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1125199B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:24:02 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b45cfe3110so4030821a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687353842; x=1689945842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77CFlz9TwTlFk4rL1YgfbwtxFKs8v8egG44k3ujctUA=;
        b=nS+b/5jq1z/kJRNoTiGqfITeO9WumeN0/hxEkI3nJmhBtVGi7RrqXd38ZpzgTxueCa
         lbMAVL2eOyH9YyV2kmMGsoA8xQvaZgzzk/DpMzoFiS9UF/29fnC5iBa7XuRvByH3uzsG
         PZZgCqoKOJ9Hm1sbwvk+Y9GmnK3Ky0/acfzVlMci13auc9cel0QMWuNg6Fb/45DkPwCS
         pMij/4KxN1fqQMUReWO4g9YowdUsD1vaP8wZPPto12tCemohGPgVJNrUdsCz8vQ9bXqm
         JEsuqVsZKYtFTZfqRrCE12MI0pOyc5v1fEJC6YHBfxJpRZnPLEVCzDtqMfjbaISe7Dvl
         uxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687353842; x=1689945842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77CFlz9TwTlFk4rL1YgfbwtxFKs8v8egG44k3ujctUA=;
        b=RNcK0lO9NaBFXDgKntAZfxR3C6/uau5kdZFWyP2ctAfoheDGyQ7Y4fMph7bjHLk7cg
         RJQFqnNoRmTuTXqw+1lCq4yPWQOwNltnY215ua8WvOczCK1M6rwHAkuQQ6tLPUQqq8pd
         ljuhOXqi3Mo/lf7j7cmr2Fp3PtjAMlwSq7tQIw+OYQgQXt3JEs26fwfAyTWIEJfVgDYh
         FfjasJwdkNnKut3dXKPpMonaK+5xcMpdA99WRvJLXtBebDAMHPyYjVvfHfmQcARHiXLg
         ftJtRgSjvMGN/7/6x9kbW6dxPVwOQqrc66PykYj+b0cG7+EZF99xcgH+pts59OLUdsNw
         agyw==
X-Gm-Message-State: AC+VfDx/CtuwggJj83HqMcD+Xsl+cJHF8oPRjgI5PcKtBBR90I+hQJLn
        cB9Dovcn/F8Ji0TJ6h5k3ZUi0VubUFnYnb+Rw/M=
X-Google-Smtp-Source: ACHHUZ5EvsYYC1aM28L+BhJdSyRInfskfoYHS088kDZqSOW9v6mvhxzADB2/cRIPZkyCiRr0Tv+QTA==
X-Received: by 2002:a05:6808:2088:b0:39e:dfd7:162 with SMTP id s8-20020a056808208800b0039edfd70162mr9144606oiw.31.1687353842147;
        Wed, 21 Jun 2023 06:24:02 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id y19-20020a63b513000000b0053423447a12sm3091162pge.73.2023.06.21.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:24:01 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:53:54 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
Message-ID: <ZJL56kehoYJm1g2q@sunil-laptop>
References: <20230621072234.9900-1-alexghiti@rivosinc.com>
 <20230621072234.9900-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621072234.9900-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> ---

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!
Sunil
