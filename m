Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61CA6CCA42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjC1Sug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjC1Sud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:50:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC8B273C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:50:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so16107284pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680029430;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aclulig/0cfgGpGgV4u2S3tdNeq79Q6EXLxPCDRVnhs=;
        b=HocprYJL3KkdQ38U4oCRR6ZmkWsefj9ZzPHM3NVz7mFT7/1swDRkZmrzI9KLhPaPEu
         WTjvhcEk1bvJsjUgLc+dUpJBaKs8bR8LQTDso6D0HKIlaMFos8Fq72QXfskBawrYNgYJ
         Sf57zvusns/FArDHCdcTszk/2hwAxcUm9cQQqtWSgk+IMK0RPQpcBcO7l5FGzHnHU28K
         V3ni0maTj5rAkQsz62/vhlaIv8L8oX9X0X84kTQUCJJRJ52vjjBUE8T/s5if5lwTDFkj
         5X0CU9aJkWjRHb+x2PCx7DUiZxEbcjOa++lzcClqVCgzDQvJid928qK5ZmFHwQOFBA1z
         itlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029430;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aclulig/0cfgGpGgV4u2S3tdNeq79Q6EXLxPCDRVnhs=;
        b=TAwedNakUYMgl1nJn2o+bL9rfxoTfQOJ+J2y6IlQchXdbthXlt76rNPjk4dtpPIwbw
         sK2TdDN3hRQePFa1QapYh3eqJS+rmyLq4t08FJJXzlrvkUcN0MkNPpDUZy14uqi90ijW
         vDU5DhWkzw0Hb9Xod/o5UainZy31GNgX1TRilavwkmsBZKeo518qRAdmAQzmpFdzMfWf
         t7wekL3WMjI7OuQ7jV/1LsOm5QqvBa9UMl33bbJXFZ0xMkE0UoVLSardRmDYFCEzT6IZ
         AKXjPG8+yh/VLNplp16nQCbbPELCs7AKf1YGyWvpgjRk+cK2COtIqJrtIqm8jvV2gauL
         3zpw==
X-Gm-Message-State: AO0yUKUsOCRpzAFL65XAIWBt9eLSW3DYQMIg0mZNIbaLZQjWat63ILEm
        jEKTbnRoQa5fwJVTkrFjt8qLCg==
X-Google-Smtp-Source: AK7set8uvctoh/nJkDcpyIUFGHdxrv7NFMLkftZwEZXTua9H6PiYWtD5qB1zOx63VGJ9TOv670v8fg==
X-Received: by 2002:a05:6a20:78a2:b0:d9:2cef:949a with SMTP id d34-20020a056a2078a200b000d92cef949amr12028036pzg.28.1680029430067;
        Tue, 28 Mar 2023 11:50:30 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d2-20020a639742000000b00502e7115cbdsm17453090pgo.51.2023.03.28.11.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:50:29 -0700 (PDT)
In-Reply-To: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
Subject: Re: (subset) [PATCH v3 0/3] Add RISC-V 32 NOMMU support
Message-Id: <168002941844.20337.2129252480039803517.b4-ty@rivosinc.com>
Date:   Tue, 28 Mar 2023 11:50:18 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org,
        Jesse Taube <mr.bossman075@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2023 19:26:54 -0500, Jesse Taube wrote:
> This patch-set aims to add NOMMU support to RV32.
> Many people want to build simple emulators or HDL
> models of RISC-V this patch makes it possible to
> run linux on them.
> 
> Yimin Gu is the original author of this set.
> Submitted here:
> https://lists.buildroot.org/pipermail/buildroot/2022-November/656134.html
> 
> [...]

Applied, thanks!

[2/3] riscv: Kconfig: Allow RV32 to build with no MMU
      https://git.kernel.org/palmer/c/b5e2c507b06c
[3/3] riscv: configs: Add nommu PHONY defconfig for RV32
      https://git.kernel.org/palmer/c/77c0c966719f

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

