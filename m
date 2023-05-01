Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705E66F3A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjEAWpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjEAWpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:45:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92A30D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:45:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b620188aeso3602916b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682981101; x=1685573101;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzHLu2IE2hBOSzYWzYuO1d3tPlj9dvz+Gi0jCi92Ess=;
        b=l+etingCqkCcg7YVZcIbCb3tAgH/fw+7NrA+JQimhwOqMhVpayG0TnqhScXDp67Gbj
         mt3Rowavme0deGnxcl7tzfUNKU12fLdb2IepA/AGjDtk/8ZyHItON/8clKIEh7Ih3a/+
         Xqq+3KEvSI5pa77EM7OeEwgURPpOwsZ9CYJttafPPCtDiNExYauuLjzdHhXO4r3O3Kzm
         LEAN3Q6qQrRzf8NZaXfvYyEhm8katOz+3bmQ1bSozWkYnz/s3uMAFoo7OM3jYJyKtQOQ
         EvSGYVkCub7saq51URsMQIxyI4nVjxbTnDMzcGdzljShHBuQ8J44LmZp+xkYYv20iJhz
         b06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981101; x=1685573101;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzHLu2IE2hBOSzYWzYuO1d3tPlj9dvz+Gi0jCi92Ess=;
        b=JK39wI+npma/Ql0nc05+d5ptlb5cqmq7yWWCIaQwr3tMmiwpDCwiSbyZT1HpiGZ5Zy
         bGsjdKPmhrq9uNocG9ng8CpxbV66+Vj7TgZptTrOmeUQAoD9ss4Ri1Ln0W/JuYWlKnmp
         ePtEyAIFLPAuGBjh/vLK2VodQ00eIRksh+dansB9knxE9D20vRF7ykBlb+3BKYbsItib
         H4pqGtWQNMxsmegNoB3tYv0hLOmV+tqyj/RWiLCO0ENPaiFGZ64tziHL61hL/BuZBI2D
         4UtKXULM8+jkhSOsWIoBp5vjI5Nv8y6NLa8BvovARhIvUpcLrvuWI/Ox/0srKORB9g4G
         fe4w==
X-Gm-Message-State: AC+VfDwKPwBskc/kB0FiegV0JRuKyzjvRWzY0+kPTTvuE8ZG6AeH7zLK
        qvJgCOWOFKZsqq+Q1lV6gIiff9KBV44etaKBSsM=
X-Google-Smtp-Source: ACHHUZ4x6VuJp/yEmoeYuM5nzs5gQwZFdfvd1p2XMb9T7ryqZdb9THhG5jPgoDjaT3nPCWGHnvXe+A==
X-Received: by 2002:a05:6a00:1a14:b0:63d:2d7d:b6f2 with SMTP id g20-20020a056a001a1400b0063d2d7db6f2mr22871225pfv.4.1682981100881;
        Mon, 01 May 2023 15:45:00 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p14-20020aa79e8e000000b006258dd63a3fsm20407733pfq.56.2023.05.01.15.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:45:00 -0700 (PDT)
In-Reply-To: <20230429155247.12131-1-rdunlap@infradead.org>
References: <20230429155247.12131-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in
 errata
Message-Id: <168298107620.32296.5030493060943182788.b4-ty@rivosinc.com>
Date:   Mon, 01 May 2023 15:44:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Evan Green <evan@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Apr 2023 08:52:47 -0700, Randy Dunlap wrote:
> When CONFIG_MODULES is set, __init_or_module becomes <empty>, but when
> CONFIG_MODULES is not set, __init_or_module becomes __init.
> In the latter case, it causes section mismatch warnings:
> 
> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: .init.text)
> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .init.text)
> 
> [...]

Applied, thanks!

[1/1] RISC-V: fix sifive and thead section mismatches in errata
      https://git.kernel.org/palmer/c/a2a58b5ca124

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

