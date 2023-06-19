Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A9C7360E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjFTA5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFTA5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:57:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166CDE7E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:57:17 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3fde5e37974so28943591cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687222636; x=1689814636;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgrA10PlHqfUGfzRZzcrXtrkAeSCmc5QAg9LlgetDZ8=;
        b=FNDZS5lsetRtZSn1PvfXIXdbXNMLt+Xn3NNjVym1JoLwcLXGf7cfedR9Y0g+IrPrgT
         0G53k+RT6Qoh6HbJC3mpbatuGpalbeOZawDwpv64uWZpyGJh0ud1LMEB+Y6Ypk4YI2G/
         hrU+G6o5lsdwxvzgTS3MgQ/8t+mXm4/l4CxzPElEvVrv8z4frsifWMcWWfCVfbLdVUVT
         OXIPQeCjFi0lPYlDElB5KK+6gR4u4lHWZ11kN2a748MizOJwIcmQataCi6P5QmmKJuTA
         x1+lHa96+wt++MZvX724HLKshHJ70P43ZstF0acjjSWhenE6A/meO8q2PZLcnK5jEIIU
         rP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687222636; x=1689814636;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgrA10PlHqfUGfzRZzcrXtrkAeSCmc5QAg9LlgetDZ8=;
        b=bl20FObJ/HfYfqoPv7E1mqhf+radzqa/sl3AfNsMbABaMH2c6Vkg3E8p+NXD+iw3HZ
         LnwqADaz1zYrJAejdh7yJ/NV5XpREPbSSu84jj0kcosiPkfSq9iVGc9kxBaMk2vhVGoH
         GQH6X8N4q48xPGYNGc8+kJFYVKCDYgJbw179PqtA70RMtuKGVNcH0hUiod1ofgcSJaYM
         HYUna80X12aKen8scpK7mrIsHDd0kgEvVsWMRcKa9PyZON4Z7rrvhtxjl2kA3mgF09n9
         2lAQEquAz0bz+8LPngPnmKfXLio+4ogBkmhCI7P/p1N3JRZ3UK/Xlq/Px1IGtyI3Fi1j
         e7Tw==
X-Gm-Message-State: AC+VfDxiV/mT6L3UStXJ3CTlo0T4rCNfBZmzTOpHzPpAmAWCx3B2+KpH
        4YQeLzjyeaNYat4zvHrmpMxXmA==
X-Google-Smtp-Source: ACHHUZ6b+THtxPksGqB7NfejvUSscrc9nACIvaaPTW2ypTct6ZfFy/dWI58bE/AsRZKwVf2/mXwozA==
X-Received: by 2002:ac8:5fd2:0:b0:3f6:c0f7:a5c6 with SMTP id k18-20020ac85fd2000000b003f6c0f7a5c6mr15011128qta.46.1687222636182;
        Mon, 19 Jun 2023 17:57:16 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id g6-20020a6544c6000000b00520f4ecd71esm202476pgs.93.2023.06.19.17.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:57:15 -0700 (PDT)
In-Reply-To: <20230519060854.214138-1-suagrfillet@gmail.com>
References: <20230519060854.214138-1-suagrfillet@gmail.com>
Subject: Re: [PATCH] riscv: hibernation: Replace jalr with jr before
 suspend_restore_regs
Message-Id: <168721242542.30028.8232901143224055307.b4-ty@rivosinc.com>
Date:   Mon, 19 Jun 2023 15:07:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 May 2023 14:08:54 +0800, Song Shuai wrote:
> No need to link the x1/ra reg via jalr before suspend_restore_regs
> So it's better to replace jalr with jr.
> 
> 

Applied, thanks!

[1/1] riscv: hibernation: Replace jalr with jr before suspend_restore_regs
      https://git.kernel.org/palmer/c/650ea2a1dd96

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

