Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5444D71F37E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjFAUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFAUO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:14:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02AAD1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:14:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso1520246b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685650495; x=1688242495;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DU10fC4sdK9R/A5wUXzFvrPcTHv4BJBjCG5IQvpna0g=;
        b=iVSgJYKDVnVhYZj8QCyFCeURHMmhLu3VVf8IA+Rktq9uFB8EkPW5m6Ta5omFHjlEeK
         WuA1egxlBJoFX5mx4bdjc1D8pVs+Odg5HLEtlFnUkVyugOfudDT+LFLkbIQn0kgyz0qo
         sMUcF+kD19PIIgjBfuk/r6UTZ7WYLIKpUslxGXQGOlnYByxvn0oh1P6v//0IBEp9xNNK
         hefNQz5ZUTwTeubzx4wXkJ9h1RIpCbKwEksKEcOBVJC/vOX0JG43aeQsYPGhj5gmB81A
         5UYVotS4nrV/9S/lmh5v5YrkBe2T2XrJ1UKQnTFjxgKfIvRbkfKuwE07ILAToGU5QP9N
         FdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685650495; x=1688242495;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DU10fC4sdK9R/A5wUXzFvrPcTHv4BJBjCG5IQvpna0g=;
        b=BluZ1ZHHyaL7AzFMZ1iVkKWNbzgrF90Qowf5HiktX+J6226Vm5T5S1xSd6mHAG2ldG
         tT/oZoX3RWT8tPD7Bkz0yluQfWPTfJPQ/DAmI1/AcCSZCTY93V4Y1OK5hQOAU+4dQ4EA
         Fps/nT5dH71Kq0ZusZGTlH8uHPtL3BCyAvfEsIdqxteyLJ0BG4CRWBjhAqe2zLIxAUbJ
         DRfL7ijToJbN+M2MvflLqTAbF0prJQ0tMx4aO7gYcuf4SNvv5S9M9ZVK6t15ViOywPGQ
         c8CCGJnFmqtMqfH8nEaFsh24caMdR5LtQXpRhvCDEvO5js/8wKNmSaBWfE48S1dsqgZp
         /5ng==
X-Gm-Message-State: AC+VfDzxH5r/LVqjbaqlaFOxLXSKXXGUweNi7q5ajixWLoX+gYlHxhPa
        mO+J18rnhw0r9JyY7Bgma35asiMA/VBWlLFLPTk=
X-Google-Smtp-Source: ACHHUZ7sHeZlkfxdt9cp0rU09UKrgKs34CyQceaBIsyDPaeRwvqlUKonnuxVfhmQV1l7lk2NTicJxA==
X-Received: by 2002:a05:6a20:5494:b0:10c:8f0c:f81c with SMTP id i20-20020a056a20549400b0010c8f0cf81cmr13043820pzk.53.1685650495170;
        Thu, 01 Jun 2023 13:14:55 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 126-20020a630984000000b0052c562bd942sm1885144pgj.19.2023.06.01.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 13:14:54 -0700 (PDT)
In-Reply-To: <20230428120120.21620-1-alexghiti@rivosinc.com>
References: <20230428120120.21620-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH -fixes 1/2] riscv: Fix huge_ptep_set_wrprotect when PTE
 is a NAPOT
Message-Id: <168565042167.24704.4716430227206622688.b4-ty@rivosinc.com>
Date:   Thu, 01 Jun 2023 13:13:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Andrew Jones <ajones@ventanamicro.com>,
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


On Fri, 28 Apr 2023 14:01:19 +0200, Alexandre Ghiti wrote:
> We need to avoid inconsistencies across the PTEs that form a NAPOT
> region, so when we write protect such a region, we should clear and flush
> all the PTEs to make sure that any of those PTEs is not cached which would
> result in such inconsistencies (arm64 does the same).
> 
> 

Applied, thanks!

[1/2] riscv: Fix huge_ptep_set_wrprotect when PTE is a NAPOT
      https://git.kernel.org/palmer/c/d22ce4f4137a
[2/2] riscv: Implement missing huge_ptep_get
      https://git.kernel.org/palmer/c/640ad2677d56

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

