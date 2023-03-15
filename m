Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC36BA509
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCOCRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCOCQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:16:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3B22C64D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:16:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so410034pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678846618;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwBAR+UkxMnSfUf34bmVcyrSKlfEQzQsi3AcgUhJuek=;
        b=hNro0VYbQSfFtDVDaIf8e99lkLrpi4+NJoIs5WZJa4CntRov7RB69q2mwcM42qUx5l
         g9GgiQC6B2UamSEaNjQnBU1A3FFBZDdFpmx8mz4erk7PkRwNQRmcgmOssvTL1qnsqmyo
         5jCzMA2OWQPpr/51QyzQFX9rDCchGqvjtDSM28LN+hZubaVFxHc67WnyRVAf56Ae6C3q
         YjNQsJ2XUWMSVWYbN8Zd/9UEuKDvMvcnqEBWIQ6yDIjhOm8Wdreq9gLp8B5MrKzdg4dK
         zNKyqGvMupSc/12QkDBLaMC3d9mKrJbQ/7Q/ObZD/cJ3MPo/GvqGujaSEhMfOgxpj2Jc
         pbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678846618;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwBAR+UkxMnSfUf34bmVcyrSKlfEQzQsi3AcgUhJuek=;
        b=muvlZMcTScoxMasBsxLliH3t/f8NQ0L1vGa5GrCoef9BtZ0nRNmM3RYAFW0/wJEnM2
         L0+sEyWps2GKihnIdrZeDrkkgJkwH1mQBJdAgG1BccfPhFFMlokAfV+GBqL/eX97+2ba
         qloNj7SwVaHTRos1z/06b7K89yWndCYRmigG7tsugudvaitpu54D4Ipz3mc5oi6HjcUA
         q4vYzm5iGgXd0Al2I/svu/0h4ZwUuDXN7Yo1K09Cxcly/65SGAgqkuY57LiJuysjTCbx
         ALD7WQbjczJj/WPxA750GcC6MDRSgNBRy8vl3IKwv5/imJZgdOf6/eYT5Xj35Q5Ecc8c
         SBdw==
X-Gm-Message-State: AO0yUKVAyyj2qCjN+7N2ls75VvHY4djs21bvpZsx4pEAerWe+vDIpm/Z
        cTMA3Iu2lF5pRFrpCUR0Sug3jQ==
X-Google-Smtp-Source: AK7set8jkF7aJ83Dj6iCO3ZNZNSDYLalFWoPUkQVlz72eQVIA4v6Kt12UFvxcYv2mdDdffdYMu4PiA==
X-Received: by 2002:a17:903:2844:b0:19d:74c:78e5 with SMTP id kq4-20020a170903284400b0019d074c78e5mr964618plb.50.1678846618049;
        Tue, 14 Mar 2023 19:16:58 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id kf14-20020a17090305ce00b001a064282ce5sm2331959plb.294.2023.03.14.19.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 19:16:57 -0700 (PDT)
In-Reply-To: <20230310075021.3919290-1-dylan@andestech.com>
References: <20230310075021.3919290-1-dylan@andestech.com>
Subject: Re: [RESEND PATCH v2] RISC-V: mm: Support huge page in
 vmalloc_fault()
Message-Id: <167884655832.30922.14980065995349775052.b4-ty@rivosinc.com>
Date:   Tue, 14 Mar 2023 19:15:58 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     liushixin2@huawei.com, x5710999x@gmail.com,
        Bjorn Topel <bjorn@rivosinc.com>, abrestic@rivosinc.com,
        peterx@redhat.com, hanchuanhua@oppo.com, apopple@nvidia.com,
        hca@linux.ibm.com, aou@eecs.berkeley.edu,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, tim609@andestech.com,
        peterlin@andestech.com, ycliang@andestech.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dylan Jhong <dylan@andestech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Mar 2023 15:50:21 +0800, Dylan Jhong wrote:
> Since RISC-V supports ioremap() with huge page (pud/pmd) mapping,
> However, vmalloc_fault() assumes that the vmalloc range is limited
> to pte mappings. To complete the vmalloc_fault() function by adding
> huge page support.
> 
> 

Applied, thanks!

[1/1] RISC-V: mm: Support huge page in vmalloc_fault()
      https://git.kernel.org/palmer/c/47dd902aaee9

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

