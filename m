Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793607410E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjF1M3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjF1M3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:29:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E07B2102
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:29:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-311394406d0so5229817f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687955367; x=1690547367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+/73Hn30Z9/qFlAesgRRh1yqPTxLtGthW/sft72KEE=;
        b=biTFYwLWFXgAh7bC73xZA1eta3vNuT/uPCAiX3RUNlQIesyL3vayeQoPILYKyl40tz
         +9FZgJhBKE/rS1cQzR3+ZINCITlLUe/3+gMwcQyfDSrNtjPUAU5TmSNfChyxswx1K470
         LmJaEHQY1JzBTMjwd/JOnmDr0IpODglPqCmHxRan+XS8WufyMlY/940g43KyTUXrimPZ
         meLgvWj63vCyxwHMICaM21gOo4ERn2pM4ibk1vQ32sFTuhi1SLY4gzWs341IJ8hafhpv
         jDDeR5URGQNClyuLnr5utfsDLye0WuQX1y01qz98tz8t/V4g5FpiXvgiESfX+9YHwgpQ
         KDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687955367; x=1690547367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+/73Hn30Z9/qFlAesgRRh1yqPTxLtGthW/sft72KEE=;
        b=D/I8oblnrQ1aDVMDluY+mKWPhuZdjd5Iq0PSQuKPCNAskcuFnw4zqZFfEBTDT+B6I6
         lKqltSKdsKvyILnkcGkpDUsKeDZ7TwTb+Wc5TEyGW0eLAULOnm23t3BWfqqqzBdmTaDc
         A8aNkuWNGoEDhngcVTj3bVnuvQgO1ij+Gjw3TdJdIqW5Y4lrA2F0orauPzKQwry7XahI
         e823qX5aW1ocBQN6W/R2p/zsL8HZpqhO4VbRKVMF4IKfZsMJF+PaHGvF03M4c7yWebNi
         U5N7WrgT40X6AkjTHIA3UybCAH8Tz609kLBQUI5oLFGSGJqVs6Bxo1VAxW4P3CV8aANc
         RF8w==
X-Gm-Message-State: AC+VfDwQFBV7bCGAGXg+WBzXHb/OoSMY/HX8hZ54HQkrBoDUrEFXVWYw
        aGeJzdQfCYTKO8+iBwra+FusVg==
X-Google-Smtp-Source: ACHHUZ7Py18273KjWJU/FbRcTvns9S7wOmxcd7KNdChxScd1mSJl7GXIZLWx+YoWuBYMA8dTprdbGQ==
X-Received: by 2002:a05:6000:1292:b0:313:f7da:2b7e with SMTP id f18-20020a056000129200b00313f7da2b7emr5491984wrx.20.1687955367689;
        Wed, 28 Jun 2023 05:29:27 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm13382663wri.73.2023.06.28.05.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:29:27 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:29:25 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Hongren Zheng <i@zenithal.me>, linux-riscv@lists.infradead.org,
        kernel-janitors@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Jiatai He <jiatai2021@iscas.ac.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@rivosinc.com,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Evan Green <evan@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko.stuebner@vrull.eu>,
        Stefan O'Rear <sorear@fastmail.com>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <ZJwnpTieyeWvEkJ5@vermeer>
References: <20230627143747.1599218-2-sameo@rivosinc.com>
 <97a7d701-3b48-252e-6d78-ef3d0e7f8f03@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97a7d701-3b48-252e-6d78-ef3d0e7f8f03@web.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 01:21:01PM +0200, Markus Elfring wrote:
> …
> > This patch also changes the logical id of
> …
> 
> Does such a wording really fit to the known requirement “Solve only one problem per patch.”?

That comment is inaccurate anyways. I removed it from v2 of the patch
set.

Cheers,
Samuel.


> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n81
> 
> 
> Please choose an imperative change suggestion.
> 
> Regards,
> Markus
