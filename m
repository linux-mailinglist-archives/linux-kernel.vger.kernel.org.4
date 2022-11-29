Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60963B96A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiK2FVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiK2FVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:21:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4FD51307
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:21:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so9948555wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LARk8O4PCz3ZLBwlQfBi5BEmv4wZ+Sw+Xo5oGP3B1CE=;
        b=goRbF1RTZ30DicmEQhLpcdVlHHqVOyr753UogRWZ8PxG3ze7LOpEYnqde452O+Id9u
         z0tGgGSHs0Nyy7CnbBISewpFn6dWB0zKSFtwCo2NGRVTUCLTwFA1n/EbJI9zlhG9cCkN
         laH7imHPRRgitkA6HaJKcJfZk9qgkcuf7/HkNwsfndFWgVe68SpVr4q2Tfs44JMMaIvb
         mlsKzhpBk7OpX0QOroseEtg+SlwTqP2YZPmM8qftmKeIcNZmBy5KTLtd/unrgbsakiyI
         J3wfWeu2zMGk/CdOgZPkLwp+zYDO1GXfz6cLFD1PmRUN0Lv3FSo3ErosAOMQuGV4p+hw
         z05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LARk8O4PCz3ZLBwlQfBi5BEmv4wZ+Sw+Xo5oGP3B1CE=;
        b=WjxVBFOG3RvIsmSZHYpYsKiij4NeGWCVmRC4+TK9jpEu3i0BRHsG35wP0BAKhptsY0
         kwVkhF32Q0e36DgQbIJ1w7R47vGjNOttLyTApbfBiP6AaGC4lo0zz2rMV6eSvaGTp7Jv
         fy3B+vOanXM3NM0BeTu2MbTyzoe6vlqeMQ4O3ADAU8cD+I/6TB4+4scl1ieJtWEBvsdQ
         eh5AvS2g/UG5SgwtdMcFloF4Zhk6ZfuNY2WR8nkgyNQ5qQ7AtScta5z47DkjKrjATC8w
         Xif+3o1dpGM9AIRG/04J8TCSkn2gDlgkfrPvA/MtoWhuP9ckiUMpIJL6mgLnxfW7ea0F
         NIwQ==
X-Gm-Message-State: ANoB5pkDIrSsA5wJWsimMhThbKg5lyYJHQWFnDBlwDeO+a7FrWCsW13c
        sjaRUa254zxlXzZjJjb/0EKa1291Ucux4w==
X-Google-Smtp-Source: AA0mqf4b+5BQU3/xN1wFpJu0JTT5Wj0V8fyYcPgx9oKbFzXVQAzV7OTyAHLMTttBrnXjTgoB71lTmA==
X-Received: by 2002:a05:600c:3507:b0:3cf:8e62:f907 with SMTP id h7-20020a05600c350700b003cf8e62f907mr31303586wmq.7.1669699278949;
        Mon, 28 Nov 2022 21:21:18 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b002421ce6a275sm2816994wrx.114.2022.11.28.21.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 21:21:18 -0800 (PST)
Date:   Tue, 29 Nov 2022 06:21:17 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] RISC-V: KVM: Move sbi related struct and functions
 to kvm_vcpu_sbi.h
Message-ID: <20221129052117.d2o4zadk2z43jgoy@kamzik>
References: <20221128161424.608889-1-apatel@ventanamicro.com>
 <20221128161424.608889-6-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128161424.608889-6-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 09:44:20PM +0530, Anup Patel wrote:
> Just like asm/kvm_vcpu_timer.h, we should have all sbi related struct
> and functions in asm/kvm_vcpu_sbi.h.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_host.h     | 10 ++--------
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  6 ++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
