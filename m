Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D967491F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjGEXkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGEXko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:40:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB351995
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:40:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8b318c5a7so8030965ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 16:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688600443; x=1691192443;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9I+KC5szuYeC056URDwDfaLH071wQ+5HX+v21iNWI4M=;
        b=zFu9wtKbHoud76MC9bRZr7ra5IVMIW9jjDhAD83FYmcIWC6lsHh7Gen6BRDlcxUBJB
         9sD19tENt5jIbW+a676ca7f8Z0W8rZAjh4Mv9Xgc+PuP0d3o/yfC9eHW5NQAOIml2MaF
         h8W/ZXnZrffB8JuoXBEZPtBA7JqQXOu/oz32Y7PxW34BZC6048Lw/tx8c5aztm56uYaF
         YXHg/xOxdiUYxhyd92SW9jNcI6zm3wUdjWlDZIXtPCUQBVkGTX6m17NSlpqu2wmYDNcX
         /++6fT0hpE49gUZtCdKTSVlN17QGbmhodzHgxpzN6pFqhyYTHsEkgAXerBD68BjVhfNI
         DIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688600443; x=1691192443;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I+KC5szuYeC056URDwDfaLH071wQ+5HX+v21iNWI4M=;
        b=UiKZiRA6Bi4r57/oF5xX9ky5RjwBOLxH15nDWGPk1D8a7OPmdTRP9fVsl/wB0gBAJJ
         uy+UCJOmjR5ywqVtjcQYF/VBHq6bNIvk25sCp2kksf58jQO8VRYZuKNYTBD+Jlu7Kh76
         oQ39etBwzgRkdltPeGJ5vcjwiHI/8GvxyxVklAMlvvQa7Cn5q+PfQsV5PgC6rueUdWSm
         LUAoK/O//+9Z15QXZ2EBsqejFxD4AbhTIJx1v9WRCNTMkzkHeEHHLP0U/CzEY7Vizu8o
         lLnreH40OrNAYec+Nj3l8tOg7skgrnhyR8qqxVXdJQ76NqCxWFkUADbzp31CukMzAE6H
         bHdg==
X-Gm-Message-State: ABy/qLZL95KH20+7UXerFRkzyB89GtxqXtjMHYFpK81LmPFEHfqhxx5h
        jdAOYb4zdZGJSpe2klphhlT6cQ==
X-Google-Smtp-Source: APBJJlHVE19iBGX8/fFvr5f3Nu4D58kyjMN9K9CLX3AQ3+HPnO8GRJ+I8MPT7LzVS/eKq/uKqveEYA==
X-Received: by 2002:a17:902:b942:b0:1b3:f8db:6f0c with SMTP id h2-20020a170902b94200b001b3f8db6f0cmr354847pls.58.1688600442742;
        Wed, 05 Jul 2023 16:40:42 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001ab18eaf90esm31967pli.158.2023.07.05.16.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 16:40:42 -0700 (PDT)
In-Reply-To: <20230703190044.311730-1-jhubbard@nvidia.com>
References: <20230703190044.311730-1-jhubbard@nvidia.com>
Subject: Re: [PATCH] mm: riscv: fix an unsafe pte read in huge_pte_alloc()
Message-Id: <168860030766.22647.15542339368600249770.b4-ty@rivosinc.com>
Date:   Wed, 05 Jul 2023 16:38:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Hugh Dickins <hughd@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 12:00:44 -0700, John Hubbard wrote:
> The WARN_ON_ONCE() statement in riscv's huge_pte_alloc() is susceptible
> to false positives, because the pte is read twice at the C language
> level, locklessly, within the same conditional statement. Depending on
> compiler behavior, this can lead to generated machine code that actually
> reads the pte just once, or twice. Reading twice will expose the code to
> changing pte values and cause incorrect behavior.
> 
> [...]

Applied, thanks!

[1/1] mm: riscv: fix an unsafe pte read in huge_pte_alloc()
      https://git.kernel.org/palmer/c/62ba41d27612

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

