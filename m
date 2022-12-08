Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5D647A44
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiLHXoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiLHXnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:43:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13982E7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:43:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so6292489pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b7+DfIZYAZCKS7KrI1o9B1zMBxHX7xEOSBgU1nNaKM=;
        b=uL19ZsGOUMhPCblwO2whI96WEkxqmFAJsxuGwp9fGaoK/PE7Yfg11otPIFsG3r8FCL
         jZANyH4juMEQmPnYx5D5hjeHPg1s9uPCVyoLPJMveJ17RsrnfNlsXpoj7wRH5Zqd3CCf
         d+rVaZBk1TnyswKZgFNNjzsGJXPZufTnQeKuQp7t8I33NHzQ5vpao+5mGxdD/CXo5EqC
         HZd5GYEJEn7+borpGc/gsrkR4qTSqW0Rq3ppv/dESt0Grni55KmMBNLmk1PUsSQRqKRq
         Wb2GplLJ5ruGn71mxUgzl2aStjsws2NJwtlE2V8yVdNbUiu7uBdwW2ByWM/zBEBHRkwV
         BaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b7+DfIZYAZCKS7KrI1o9B1zMBxHX7xEOSBgU1nNaKM=;
        b=ig9uCug4tSp9YDmVxFyTCPZFaGyYqyjMUrBK/VyqTNq8bUFsyclX9LBhH4nVpW47dT
         nKw6qsfx4lHRITjBr53fE2cJEzBlSoSHMQ6ETGvTBklvTzsGfxbYci712LKgH0zpttoe
         HT2XFwkwZZBSlsIJHXXooEmdNzq0Fz6p2EnazSBphgpqvduSdszfuqqLafKjWrKfkeEa
         cp59JNnRpUnpvhjADvQ8LMCvgnIejcueXSwS5UJc04s6wdCmaPF1vbH/3wcJXNh0+Pg0
         gCq0CGZLZMWa86RtP1O0m3zOTGlkRw0Q+42y0yI9eGRNKklizhZsg3R3HAZGBRMvyVpz
         cDvQ==
X-Gm-Message-State: ANoB5pnVnEQVkV3pfTxVxKlLMBGMLx6Nx4fH6PF7YIsZP95ofc/iG8UE
        uPA5speL2EeTIAp+MF3YWU6zeMVnj9ydqDMO
X-Google-Smtp-Source: AA0mqf4pnJCHELQ1vkRdNPoLn/TUUUwPuyBJ+Iqm4Ct51Tbk/qApTXmOzSwPdB5XxVjfuf2QEuzvOQ==
X-Received: by 2002:a17:90a:7c4d:b0:219:e9e9:ea0 with SMTP id e13-20020a17090a7c4d00b00219e9e90ea0mr3517911pjl.3.1670543011147;
        Thu, 08 Dec 2022 15:43:31 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a3b0c00b00219f8eb271fsm152919pjc.5.2022.12.08.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:43:30 -0800 (PST)
In-Reply-To: <20221111223108.1976562-1-abrestic@rivosinc.com>
References: <20221111223108.1976562-1-abrestic@rivosinc.com>
Subject: Re: [PATCH] RISC-V: Fix unannoted hardirqs-on in return to userspace slow-path
Message-Id: <167054299652.8453.17062801658432513942.b4-ty@rivosinc.com>
Date:   Thu, 08 Dec 2022 15:43:16 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 17:31:08 -0500, Andrew Bresticker wrote:
> The return to userspace path in entry.S may enable interrupts without the
> corresponding lockdep annotation, producing a splat[0] when DEBUG_LOCKDEP
> is enabled. Simply calling __trace_hardirqs_on() here gets a bit messy
> due to the use of RA to point back to ret_from_exception, so just move
> the whole slow-path loop into C. It's more readable and it lets us use
> local_irq_{enable,disable}(), avoiding the need for manual annotations
> altogether.
> 
> [...]

Applied, thanks!

[1/1] RISC-V: Fix unannoted hardirqs-on in return to userspace slow-path
      https://git.kernel.org/palmer/c/e1ceb0964163

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
