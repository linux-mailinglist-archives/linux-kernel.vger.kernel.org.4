Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56E873D53B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFYXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYXSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:18:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0978E43
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:18:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8054180acso3193355ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687735126; x=1690327126;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueNNjA6xOq7R8vflJ6M84ysKmaKYGoUOlWGuUp2U7kg=;
        b=zVB34HH6vSl2dU7Xc8ZYOhxtiXTvWBG0fU27eYP+hSf70c/mcydaHwf4DNJMky0I+o
         6lJtSoVcnQaAFWdPIL0EXG0RCzP4AqqyIkAx7ENaVNYz6ZlcYF0lvqKJjRqR6fhbVzPx
         L+pBAr1LgG2s9NG7ItokMW6aO8kTqRCpX6dlNDV+R1+EUAee6+VBOK+oK/jpluKDNi60
         w6n8rRD4F/GdDqGfycj+ux9vLqeo7uLd6LYBYBm3s4POK5LtQrUkPtn+513WwLO0qBeC
         kAvYUfrU2uz4d4XR2bt/rayduT5Zv93EPMd6fF77FoBhNeptFT3hqj4EEfMiJt6NV6m/
         RSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687735126; x=1690327126;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueNNjA6xOq7R8vflJ6M84ysKmaKYGoUOlWGuUp2U7kg=;
        b=dtC0KRdPnKB4CIWrJ49IfZCpY2a/1GUqDN9M/2qK8Tj2thN5E1XryKLBs/bwRxxqS8
         UpGClQK9QHgu66tINgiuadlaOIiflhx92gVMuSupszuEFqoxiDLt/95dmFSynPjSKSAz
         0bwbhW0QzTKdbw1VYso4HWDukT653a4IY71vGZ0MC35h5LJCupybMfLYwLeIDAWpWAyE
         0+/gl5f4Ge6ud90DYpRCoAWBhY2xhG9VszduVJb05dz+yUVJADzKrMiJ0RHSH4UFHfqy
         WrWobuSaDzErYqfq1CrszPMkALUGSVTwO3/8VoJhRljuscyusQdYutnDjbAS32xF0232
         ZD9g==
X-Gm-Message-State: AC+VfDzb8VQ8fDVtk5BeqB65OYtYZNkb4aNOi3qVSnks8kmvUqTNt21o
        lx2kUVTsil7SmGPFfrIQ5MyPHw==
X-Google-Smtp-Source: ACHHUZ4v8/2X/gpQXDywoE+B/iQdyrkCgRFN3DrwQrG9PuSuJO18SnoChqC1pC7ippUd6YpnI6gXGQ==
X-Received: by 2002:a17:903:2444:b0:1b7:e355:d1ea with SMTP id l4-20020a170903244400b001b7e355d1eamr6441113pls.24.1687735126268;
        Sun, 25 Jun 2023 16:18:46 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b001b558c37f91sm2831341plh.288.2023.06.25.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 16:18:45 -0700 (PDT)
In-Reply-To: <20230505072058.1049732-1-v.v.mitrofanov@yadro.com>
References: <20230505072058.1049732-1-v.v.mitrofanov@yadro.com>
Subject: Re: [PATCH v3 1/1] perf: RISC-V: Limit the number of counters
 returned from SBI
Message-Id: <168773507352.1389.2672044920046049803.b4-ty@rivosinc.com>
Date:   Sun, 25 Jun 2023 16:17:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux@yadro.com, Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 05 May 2023 07:20:57 +0000, Viacheslav Mitrofanov wrote:
> Perf gets the number of supported counters from SBI. If it happens that
> the number of returned counters more than RISCV_MAX_COUNTERS the code
> trusts it. It does not lead to an immediate problem but can potentially
> lead to it. Prevent getting more than RISCV_MAX_COUNTERS from SBI.
> 
> 

Applied, thanks!

[1/1] perf: RISC-V: Limit the number of counters returned from SBI
      https://git.kernel.org/palmer/c/ee95b88d71b9

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

