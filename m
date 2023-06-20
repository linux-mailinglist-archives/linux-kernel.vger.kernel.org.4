Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0488D737514
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjFTTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFTTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:30:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD991B6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:30:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b50394a7f2so29292925ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687289451; x=1689881451;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Jak4VAiKyxNW2MF2c52goYxqj84zATitJ45PnIg+zA=;
        b=jj/nx4Q6wNcCgENH9upzbuBBoImgkFJF8LxIGxpgWSB9SKXU30q8kWo4GaX1UuvSB7
         cdjPBn1/jMj2LABx1PB07h45Myd+qD0uZNHctKmuR7hdIGlPAXaZf18758E9K8cweq0F
         /3uGiQhsp4cG7LQ3UQdWKcjMSHK/s3CFpJoltpwy2aIusr/E8xAKJ/MVI/OPvv1CcaAi
         DBPLtM1clszs6abhLfytm+rQXgx31+E/6QSuORzUZA+P9p+lUOEsEnjP23tZpBUzAhwb
         RXTlrEmySXpJagjNknKVF0WIz+sxt/WFkHeEWDzv68GAwO4obOG1SWoHpfEdEjT5roOr
         3MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289451; x=1689881451;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jak4VAiKyxNW2MF2c52goYxqj84zATitJ45PnIg+zA=;
        b=FdMIQaK9KT2IrNk2pv/A75OEbcVcy6KjLoRW4SqjXdegG5GnIFRTpSEhpe5MSarqPt
         CioiQVbsKz6AHmLSJWoSoh/H2GCbSe9iFAmX7VHJ3SGkkdvaYdYfdpB2K3tHai+lafr+
         1yxUyWzTYoZhiFJQU/sWpPGvXEdmaPOaOx6a0AX1ywIpugup6y3jGtyBybLrXt5oNP5e
         q1Re+FsVVdgH0FgJm+F2z13lcRCjnewN12S0kZTTRdGeqkA42sV4SqtKpanJcgazb02v
         /hIxRRll2JmfHnOz+9fNmC/Oz46cGW1yTA1GC449wJiefkMoSix4X4Jdj7wvU+E2W1Aq
         BZ8w==
X-Gm-Message-State: AC+VfDyD+sCLIb5sEnsn4MsyD1Te8toBaucyeIGbiUaeBLZltJh/e8yw
        AHyrjtM69Ycq6pnGZJpY6HuljQ==
X-Google-Smtp-Source: ACHHUZ5X8f2vx2Z0B3hkaw5OWyJtmMa5qKAxvgJNC9XDE9TuY7k834Xx2Ye3EvrakXc/fvbarw16zg==
X-Received: by 2002:a17:902:cec9:b0:1af:f751:1be4 with SMTP id d9-20020a170902cec900b001aff7511be4mr12796873plg.63.1687289451482;
        Tue, 20 Jun 2023 12:30:51 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902b70e00b001b0034557afsm2000604pls.15.2023.06.20.12.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:30:49 -0700 (PDT)
In-Reply-To: <20230523165942.2630-1-jszhang@kernel.org>
References: <20230523165942.2630-1-jszhang@kernel.org>
Subject: Re: [PATCH] riscv: mm: try VMA lock-based page fault handling
 first
Message-Id: <168728927543.19726.6287680101393948485.b4-ty@rivosinc.com>
Date:   Tue, 20 Jun 2023 12:27:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
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


On Wed, 24 May 2023 00:59:42 +0800, Jisheng Zhang wrote:
> Attempt VMA lock-based page fault handling first, and fall back to the
> existing mmap_lock-based handling if that fails.
> 
> A simple running the ebizzy benchmark on Lichee Pi 4A shows that
> PER_VMA_LOCK can improve the ebizzy benchmark by about 32.68%. In
> theory, the more CPUs, the bigger improvement, but I don't have any
> HW platform which has more than 4 CPUs.
> 
> [...]

Applied, thanks!

[1/1] riscv: mm: try VMA lock-based page fault handling first
      https://git.kernel.org/palmer/c/648321fa0d97

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

