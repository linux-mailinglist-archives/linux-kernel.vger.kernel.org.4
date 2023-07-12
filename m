Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D9750D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjGLPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjGLPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:54:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE961BE2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:54:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b852785a65so6547685ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689177246; x=1691769246;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuGfImREI3+vAOMG7Qz0iAJD7LdxEjUxKUaKqmBNQrI=;
        b=vrFoeYWDsg7YPhr4bqWyPs+29mbupjC5nNCh4GVYf8Vkh0zWSbRgBxhRUp+Ui01t2S
         A+Bj+AbZFLOizlV8tFhji8+D8hsioUYz8n6Ak7yGE+pEsX2ysSi7Fb7MqmJ9kHrINb1o
         0cv+ch7z4CNXTxUXLdw9MnQznvJXO45IN91j2NR5HNECOCgzVJrbMKbo8dXifrsmRbK/
         7MMdleXB7nsa4KJdjY1gLpRENrG6PHAUxp9886g9IOxNtWsNW962QxUBCgqOXRyU8c4t
         LPLjScfvOgfwmKrVqZwm0ksOhsJ5h2yr4mAtBtpO6mXfD6+BJjBN5peK2ir/cufvfLzi
         20lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177246; x=1691769246;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuGfImREI3+vAOMG7Qz0iAJD7LdxEjUxKUaKqmBNQrI=;
        b=i00vLejz4fnpm+QaXpjl89QBIkoBaMah35pvT5m9azT1vqjfUHfANF3jerO2WFj9YI
         brYKs5lekogNXTZN27OsU9HN1zB/IAWvkJCG1RvB45iMZ6I6cc0xx5Tl+F9hipMJHZwB
         y7UqBmac0Fjq7XkuseON+XsN+D5wCwoDYCWBzxOwg3UOFRlbnfGUqw4lgHczA7TVtnic
         c2V/gUeIAGly90TpcOkilXuUQTO9dbRVwr2/xAt8c6DpQmwHcrJ/fhfCmILjFC5YOP/G
         kw7qKLYcE0QZRYwCw07C4JOYcgWFDqb/Lv7CMSMEyjwscJn8HkQpn7C1XUzhsv+oCdkZ
         OHjQ==
X-Gm-Message-State: ABy/qLYJUmbcv647ylSa8mZ9UrF6tI5d+Ya3HB8cQuBb8nWZ4e/EvAl/
        6KlftY0+AjVnJyr2XuAtSEX6RGxrXS9q/A7KQBw=
X-Google-Smtp-Source: APBJJlHJejJb/aIFBNWoeTp9H1B/RU3lJPZiFXU2xM+nI3CFojsKJRB31oUA/72y1rfIIzU82Di2fg==
X-Received: by 2002:a17:902:6542:b0:1b9:e9ed:c721 with SMTP id d2-20020a170902654200b001b9e9edc721mr2441743pln.19.1689177245834;
        Wed, 12 Jul 2023 08:54:05 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709029b8200b001b891259eddsm4133317plp.197.2023.07.12.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:54:05 -0700 (PDT)
In-Reply-To: <20230709171036.1906-1-jszhang@kernel.org>
References: <20230709171036.1906-1-jszhang@kernel.org>
Subject: Re: [PATCH] riscv: mm: fix truncates issue on RV32
Message-Id: <168917713755.21773.10817207313937867675.b4-ty@rivosinc.com>
Date:   Wed, 12 Jul 2023 08:52:17 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Jul 2023 01:10:36 +0800, Jisheng Zhang wrote:
> lkp reports below sparse warning when building for RV32:
> arch/riscv/mm/init.c:1204:48: sparse: warning: cast truncates bits from
> constant value (100000000 becomes 0)
> 
> IMO, the reason we didn't see this truncates bug in real world is "0"
> means MEMBLOCK_ALLOC_ACCESSIBLE in memblock and there's no RV32 HW
> with more than 4GB memory.
> 
> [...]

Applied, thanks!

[1/1] riscv: mm: fix truncates issue on RV32
      https://git.kernel.org/palmer/c/b690e266dae2

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

