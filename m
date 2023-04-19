Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF26E7C52
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjDSOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjDSOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:22:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC348BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2496863c2c7so1549279a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681914160; x=1684506160;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMJ/Ks8F05/giS2sBv9GPELVvdqCwDwD9O0hhEBT8Xc=;
        b=UoocXWjwl9V3/hx6ZI4+IjcvhlWT0acnKID1oyI8wcavFlhZyOXd7O9Os7Cgxkmh6z
         TdwJKMilnVzlPZAmQNIj3OYbc31I194tIdCA2s2aNo6sppTQ9L+QiWmkqbM5e5mZ2fsj
         gu8iv5kgqEMhUx5GEB+4NU1Kn7nBtlXDD5HzsixU7CHgNHVR6Ks3oxZ0Rv5c5WwM8ed2
         pFlQyTWZHpt3WsjG9bzXh8E3PjPBAaxSoP+pqAk+eTquK+fqheyAg0EohC6XGjcOKV4c
         WKr2SVuiUKFHsXeWURUEkNkjPLmjbXUmTw3KmLSSPuiP1jwM/QFJhwmcSeR3TIpBI+uH
         LxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914160; x=1684506160;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMJ/Ks8F05/giS2sBv9GPELVvdqCwDwD9O0hhEBT8Xc=;
        b=EOrTn1i0YLutIlARGuE0h4d8DATkR1bszK+2O/pNKWhCU4EKeoG4m+bKK2u4Wfu+35
         xLfSjJG+fXgS7FmEZOv9qq3iDtIHIW8GmTgFVQpfT6m26pQHxkaNU9vFecoKE83fgu62
         /fnIGSf0m+uYpdfk2Ehpb/z05QY3V4LHplHrRNfShmqvxKLMNPgPct+FXK+H8hy+nYyL
         94xz3fzk+uk2i8yjtuoKGqqVNsAgpNQwMewx+sfT8XYFjFb+P/+1p12hR/zNbEXPg6pm
         JJsK1iFj7SwB9/JuqhpRJTuIqjnhNtIWAJtrTVMvLoasv0YTUuJeXezoj4pA9vRUAe1R
         dtnA==
X-Gm-Message-State: AAQBX9dGH7FOE8Y0qcib7oLkMmwLsoE0yVgE0xWdtJ2ljD6tsFl0GlXh
        qJSpgsPRuR9hudHr7Ti05UHh3sMfDSOL54SrQIE=
X-Google-Smtp-Source: AKy350ZymVA5je/JcZjLGXcT5bH394U6gvSQpMLr27jaRm4O7bjq/74s/E3gO89lzpSu3uJBBBoyiQ==
X-Received: by 2002:a17:90a:f415:b0:247:6be7:8cc0 with SMTP id ch21-20020a17090af41500b002476be78cc0mr2863499pjb.35.1681914160200;
        Wed, 19 Apr 2023 07:22:40 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0023d0290afbdsm1509639pjb.4.2023.04.19.07.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:22:39 -0700 (PDT)
In-Reply-To: <20230310110336.970985-1-suagrfillet@gmail.com>
References: <20230310110336.970985-1-suagrfillet@gmail.com>
Subject: Re: [PATCH] riscv: Kconfig: enable SCHED_MC kconfig
Message-Id: <168191414578.1929.148048847590891306.b4-ty@rivosinc.com>
Date:   Wed, 19 Apr 2023 07:22:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Conor Dooley <conor@kernel.org>,
        Song Shuai <suagrfillet@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Mar 2023 19:03:36 +0800, Song Shuai wrote:
> RISC-V now builds the sched domain based on the simple possible map.
> 
> Enable SCHED_MC to make the building based on cpu_coregroup_mask()
> which also takes care of the NUMA and cores with LLC.
> 
> 

Applied, thanks!

[1/1] riscv: Kconfig: enable SCHED_MC kconfig
      https://git.kernel.org/palmer/c/8bf7b3b66762

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

