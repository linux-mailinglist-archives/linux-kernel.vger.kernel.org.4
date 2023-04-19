Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A76E7C57
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjDSOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjDSOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:22:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD5130E0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kx14so8307168pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681914159; x=1684506159;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Waf+QACGwPaX1ZCD7e4w4TBQTFocG4VaRO3bMuKWQeY=;
        b=l6v7+ZM9QWue1cFyKkTewWsi9T3Z7Jx3gSzVSOBLDFH7L4SiXnvU7N+svVhQ48RDF3
         KmVwYId81LSUiIhUMIqTQ/54QklERHf+CNKdlYQMEGoMgGbFNXvYbFe+MOlqCG8C6HrS
         n0s/5RcK378D2IyRgvlLOgnX8KrTffkRrXMsICFF4YKNSarGEJkTLV0tYEfNkSfimdnF
         ZGifCAmLa7zB3qzElf7Stg+u7TqUKiQpP4/kM8EbD8NvS1VN4QUm8DLJnuBljnFyOngm
         qMojS00yepGhR+ndQauGQQeWO9ouylc+YUD8KxaUznghP9lrKzYxVyBWa0Jw82o/ZtZy
         Phew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914159; x=1684506159;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Waf+QACGwPaX1ZCD7e4w4TBQTFocG4VaRO3bMuKWQeY=;
        b=Dal0ArLSHRHbLE9RRU49HPpgOE1lnDCFSrmVMpuYJphroVe6Jxkk+IJ+WxCOaXK3Oy
         OkzVtNv1prg0pfaMRw5PPGHdkJWqVIUhj0sKh9nI/tBlSsAtaJVWfPNdK6disrV80bSh
         rh/zsCohoNIwF4bPOUWhspJk4/zqStmhXJcf0kQsgxUtkYQ62c72lGlfDVb6bv+5WEdN
         kZImeImcLexxae2MtjV3kb5ayNjrUur5rbfP2ScVtsfmWtK8RjV595mTuExSzD15daqH
         qE95EpalsNfVGwxZioTVv696+lBLVeAnW3fEsumUq4G2jLinrQ+N2+5dOp9t3t3DKx9x
         i6lg==
X-Gm-Message-State: AAQBX9eKO7rXLtWSMK67IOfRpwG1j7gTSE6taaMm3r34BUC/9+kRTjXR
        UEEYMuENsTY19RtZ2coT9VBmPtJsnAOPWyXEK4s=
X-Google-Smtp-Source: AKy350aPnlfvP4qUDvfv5/vOO3cn2Bw34qPnDNeOqdEF3EgYhvkEXRXInv8IlMOb7I6WoLdjYIoKBg==
X-Received: by 2002:a05:6a21:6d87:b0:f0:2c96:1c6c with SMTP id wl7-20020a056a216d8700b000f02c961c6cmr2519297pzb.25.1681914158966;
        Wed, 19 Apr 2023 07:22:38 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id u35-20020a632363000000b0051b36aee4f6sm10483297pgm.83.2023.04.19.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:22:38 -0700 (PDT)
In-Reply-To: <20230323123924.3032174-1-suagrfillet@gmail.com>
References: <20230323123924.3032174-1-suagrfillet@gmail.com>
Subject: Re: [PATCH V2] riscv: export cpu/freq invariant to scheduler
Message-Id: <168191414576.1929.17819502904863461212.b4-ty@rivosinc.com>
Date:   Wed, 19 Apr 2023 07:22:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
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


On Thu, 23 Mar 2023 20:39:24 +0800, Song Shuai wrote:
> RISC-V now manages CPU topology using arch_topology which provides
> CPU capacity and frequency related interfaces to access the cpu/freq
> invariant in possible heterogeneous or DVFS-enabled platforms.
> 
> Here adds topology.h file to export the arch_topology interfaces for
> replacing the scheduler's constant-based cpu/freq invariant accounting.
> 
> [...]

Applied, thanks!

[1/1] riscv: export cpu/freq invariant to scheduler
      https://git.kernel.org/palmer/c/c4b52d8b6c1d

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

