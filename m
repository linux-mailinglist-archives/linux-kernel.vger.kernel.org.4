Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5297360E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjFTA50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjFTA5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:57:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E316010C1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:57:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-54fac3b7725so1651699a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687222637; x=1689814637;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRom180+ATZtgmyPRPdQxtGMIDvHG/58KwOF2Gsfd7g=;
        b=CkvcwqYH/SA5Ms6ONtC0mRosDGng6jZiToLgTHz1hGKxWc5yivcLEK01aCfLcq7eBG
         /uGkXUu9EKUbYdrrEXEjfdLXVKey/HRU1qwqGGpO09itGaTHSwKPbnGVgZsyWnLrX7t7
         5C3nzr5IvmOdPNbR5BsavXGU7uGuSjI5p0tvmCH2a4jAjDpfGCpbWvYpo5yKiij/BoVf
         YJTK1uMPmMwUUUV1y5BO16kLKtwj7yTpqK5opPGqt5C0neAJ30tIccBv7l8cg21DXS0q
         cH0TbljYvq3NDHHMOLcJ/SQRa33SY8LyKxn31ExJwCDHVx8qLyRees1j+fqn+cFtL8ek
         ClPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687222637; x=1689814637;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRom180+ATZtgmyPRPdQxtGMIDvHG/58KwOF2Gsfd7g=;
        b=knh01qnmqI65KJQF2Ig4yf93t0/wF4VhIntagGRgwHlF46pR2QZk+1aWI2d3CN34z7
         1UljSa9v/Gp8yU/9uRVwFOnhoK+wyjRIHnAJQctGu9meLYrf04JTo0WT8b0K9spbnpQl
         QbVT7U4kSayMv1u5VGbBcmdr9M9q1PBBGem1/OaFVkxx5OQ6KS9quCH1yJjnUumiPxYm
         OSL4ZQcYQUlkzvq8qWJ8KfYAiBijzt+babFe6rs4SGis2uXepjWkyQRrsRqL8ZejZwCk
         8XUvD3e6XAeWcqDw2z9UjfJYgZDZ7FC4rPGfB2TgfWADTJgpWvEGyTIUOXJtx1eRGpY9
         V6sA==
X-Gm-Message-State: AC+VfDwLaWmoyCw7PlwZ94G5yKqcbaI783e9PV197WnfCXNvcwajsheY
        yR+Kjnv18DVuKKNffzGJxBWh2A==
X-Google-Smtp-Source: ACHHUZ6sAzMneIYhOdpTkZKgfiElyvst2qwHku16IuuLibRfnlo5qgTwJjp4nMxsX6IV05ei7Eaorw==
X-Received: by 2002:a05:6a21:32a2:b0:11f:3553:5c8a with SMTP id yt34-20020a056a2132a200b0011f35535c8amr5409311pzb.12.1687222637386;
        Mon, 19 Jun 2023 17:57:17 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b001b024ee5f6esm385131plg.81.2023.06.19.17.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:57:17 -0700 (PDT)
In-Reply-To: <20230522025020.285042-1-songshuaishuai@tinylab.org>
References: <20230522025020.285042-1-songshuaishuai@tinylab.org>
Subject: Re: [PATCH V2] riscv: hibernation: Remove duplicate call of
 suspend_restore_csrs
Message-Id: <168721242544.30028.11015895389526975730.b4-ty@rivosinc.com>
Date:   Mon, 19 Jun 2023 15:07:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        suagrfillet@gmail.com, mason.huo@starfivetech.com,
        leyfoon.tan@starfivetech.com, ajones@ventanamicro.com,
        jeeheng.sia@starfivetech.com,
        Song Shuai <songshuaishuai@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 May 2023 10:50:20 +0800, Song Shuai wrote:
> The suspend_restore_csrs is called in both __hibernate_cpu_resume
> and the `else` of subsequent swsusp_arch_suspend.
> 
> Removing the first call makes both suspend_{save,restore}_csrs
> left in swsusp_arch_suspend for clean code.
> 
> 
> [...]

Applied, thanks!

[1/1] riscv: hibernation: Remove duplicate call of suspend_restore_csrs
      https://git.kernel.org/palmer/c/c6399b893043

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

