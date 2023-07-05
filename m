Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D187491F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjGEXkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGEXkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:40:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC7E12A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:40:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55ae51a45deso79226a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 16:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688600439; x=1691192439;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heq1Q1+wvbmb5OAij38OsJQX4YW0Eh3uUJoVnnFKKL0=;
        b=w7ObabrxLzWbFZucsKbXsxG872nezRh31k9tgMIKAmOV1ZnhQy797FIaBqEHUd/S6u
         yqa3PCq34Th7JgfLwyPgxW6/xSPozlZhDK9/i8xmrzHgPtPK/vtnx1ChdB+67VPUR7Hi
         9p3D08Y1dTf2Ur/iw1NhgTL8dzYd7W4De9TKoknq64Q2N+iH81rDvYSReXlWVF+nzBb1
         kzh8UeQbi+057HGg7/4ohJitSPFwglsZBDO9Rd69vvR/Cp54estk3Q7fTzTHUjKvA775
         +EPtZ/X6mQ2sET5RP60mdz/BLaIY0qRd67Y+3nMNjSJbFl6e8wtsK28/2QfZyJ+NtB38
         gWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688600439; x=1691192439;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heq1Q1+wvbmb5OAij38OsJQX4YW0Eh3uUJoVnnFKKL0=;
        b=g6AmhcLI4uAIq2Sl2WcR85DgmNu54rG0G/xRZHDO2oIgvXwbx0hUv0/lTye1d/BHgx
         YfCOztxn4HAkqrVoHybTB7y5or2TdFnGvBeMJvpbUhOvOIBf7fOGJXm/4owpMMfi3+Q6
         aFxVjTuQGy1/1U8CiilyLm1YEoWts3MY0EBr1BJ5M45G6+E2qwdLSMFGVHele0UsFXWH
         qkw7kG/ajHhes3A1oQ6hKlpRTsZcal2jRpvuPSLt20aXhuXo08KG5BivcKkWtNy0yA/s
         SA5tZfJWauk1k1Kv32n6eCcA7yDfc9c3OKzWtkOP+kfVamUgJB4hBsWwpDFcVkLAEqRi
         R/tg==
X-Gm-Message-State: ABy/qLaj2j5ELXnQpPWllPphVx/dgALjldgjud47CBQ2fvWEOPCIUNoB
        0RW8fv/cGzmTeDn3bkzFVAOltA==
X-Google-Smtp-Source: APBJJlHrF+ReT3bql2iEnECkOOHScprHU4DO/XyssfWMSQft03OZhJD+Z19gAWqG11ZIacyCwW68qA==
X-Received: by 2002:a05:6a21:9983:b0:12d:cf28:3bc7 with SMTP id ve3-20020a056a21998300b0012dcf283bc7mr280116pzb.11.1688600439500;
        Wed, 05 Jul 2023 16:40:39 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b001ac2be26340sm25658plp.222.2023.07.05.16.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 16:40:38 -0700 (PDT)
In-Reply-To: <20230629142228.1125715-1-bjorn@kernel.org>
References: <20230629142228.1125715-1-bjorn@kernel.org>
Subject: Re: [PATCH v4] riscv: Discard vector state on syscalls
Message-Id: <168860030759.22647.12460788590492187878.b4-ty@rivosinc.com>
Date:   Wed, 05 Jul 2023 16:38:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-901c5
Cc:     =C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        C3=A9mi_Denis-Courmont?= <remi@remlab.net>,
        Darius Rad <darius@bluespec.com>,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        =C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2023 16:22:28 +0200, Björn Töpel wrote:
> The RISC-V vector specification states:
>   Executing a system call causes all caller-saved vector registers
>   (v0-v31, vl, vtype) and vstart to become unspecified.
> 
> The vector registers are set to all 1s, vill is set (invalid), and the
> vector status is set to Dirty.
> 
> [...]

Applied, thanks!

[1/1] riscv: Discard vector state on syscalls
      https://git.kernel.org/palmer/c/9657e9b7d253

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

