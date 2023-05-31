Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB89718586
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjEaPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjEaPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:03:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C842123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:03:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so4388867b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685545424; x=1688137424;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7P3/iaRtzrgno6iuohovK7fRRccPrcE4URn2TEOy4ck=;
        b=fM+Di2kgOtcEyHpooWSysQ83fLR+lM4166t7n/Ru5EXmlXx0gc9beM7Jb68r1RxONl
         PS4datB5+HKW3aG0KzEPJ67/6fiysOX8Awk4AzgE1yeX47zVXJ7EuXJnmuKjz9Npfjiy
         Qzm5sqyeFoU+6ZIshbF9biyx9iZuzcRY95/bEKU1QzZIdJad2VPBAwt4+ij8vcvdmmXT
         qS0cdPmqiWyeo5eXL55GYcswjdiV4B8dm4nn1w9pKZb0a+eltUGszKgWlbT7d2aofaPR
         voTBhghSZg8pHhrSp2DEs1KUM462v0OpjOgDn2+U8dSq07YcLS/4OagouPY1PUomYvuc
         g5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545424; x=1688137424;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7P3/iaRtzrgno6iuohovK7fRRccPrcE4URn2TEOy4ck=;
        b=SR54q8jz8NXDvu3UpV6jF0LBlRlvEdwWubJkj/I5serzA18kJPGHKOG7yzbzEcusWw
         tbZYG+oEQ9PjjBDeDb3q17hhDkc5Ak/l1iPv78AQ3DCSm2KeLqB/tXZC+usRgMZCHUw5
         HOYt5pvDZFihkiJyG2tKzK5lpNjQovh8KPhRy8bMGMWTs3Vxh5flD8J+n/1xE3hAgR+w
         EyiKObEc6R24ap9us3BIoplfACi7yJrhygwwribskxanP52DT2MWYJ92IzFxc54dHZxi
         SdC/3z/tpBLQvE7YrKuxEQTY/Pb/GWY8KZ8yuee94vOvq2yijCENsY3rAgSRBgKRqk+3
         ZwBA==
X-Gm-Message-State: AC+VfDxS6q6XlOC0VvW67B7JAknU6YDdIGkp+XSY/BYXR4EHoT9/e9ee
        X2ro2JKbbTmyavYkCbmHTQD9nA==
X-Google-Smtp-Source: ACHHUZ4ux4FXbJUnXTvWpgX+ERHyZRis8AwzVJhnQ0Z+pY+eUo1tcGF2RSDR9jkEnHsyjCrcfWbwLA==
X-Received: by 2002:a05:6a21:6704:b0:10a:9f45:e3f with SMTP id wh4-20020a056a21670400b0010a9f450e3fmr4775740pzb.12.1685545423893;
        Wed, 31 May 2023 08:03:43 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id pi16-20020a17090b1e5000b0024df6bbf5d8sm1376271pjb.30.2023.05.31.08.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:03:43 -0700 (PDT)
In-Reply-To: <20230526154630.289374-1-alexghiti@rivosinc.com>
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-Id: <168554541145.21606.17332931108969315151.b4-ty@rivosinc.com>
Date:   Wed, 31 May 2023 08:03:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 May 2023 17:46:30 +0200, Alexandre Ghiti wrote:
> Early alternatives are called with the mmu disabled, and then should not
> access any global symbols through the GOT since it requires relocations,
> relocations that we do before but *virtually*. So only use medany code
> model for this early code.
> 
> 

Applied, thanks!

[1/1] riscv: Fix relocatable kernels with early alternatives using -fno-pie
      https://git.kernel.org/palmer/c/8dc2a7e8027f

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

