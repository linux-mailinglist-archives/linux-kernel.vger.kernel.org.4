Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78CC624DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiKJWrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiKJWqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:46:49 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7655C5EFAB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:46:47 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g62so3319435pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HQDpPym5LjtymWxLp9cUJ2V2mQCjf8ma1sxDeE3Trs=;
        b=4OVUeR2TK6kWC2W5gQrF/BlbpmApyFxOIyfASWXy/mRnhwY6WACExnL/RULtvMHmhe
         C8fGSRkbItiDjQ8hVxrOJAUjyIV9xkxtMqjVzhxKALVXd78L2XmkjRJaSQ6/KaXgd2in
         RrQMuyzZhqK16eo7uIywZbvcPNos8I658qoFY3EbmR+soPcjKYd9aO/IvGemRrwPd9hz
         ckiSEIZEWJQSkF4mAimRjRnVoOIvtnHn1YNGa5Seemn+U4SdpDYGdPQqqEI4JFopF8BA
         F2QwkNRxECouBslnr+PswF65YjcizTLqA6wgcr+rzHC1V9MsicfDO37acZq+CpwEH9wz
         EBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HQDpPym5LjtymWxLp9cUJ2V2mQCjf8ma1sxDeE3Trs=;
        b=Shm9hI8dtEquWi7OxzpTmgYsfHL+5bbzbWDG3hPQCyF1MAaEJaoHbYGl9VB5RKYgKC
         Ccw9RBdNCH5gwPJCN3raOMCjjfBUTg8TcU6xEcXW+J7MTx9QerVt5nbZWHhunAuvc/yJ
         Q0akmLOZXL3ciHDQ3e86ZU9PZH1sYSy3nlAQcjmHckYN1RhTGxEAVPKfNwCWoNVrAR9e
         4KkkJOjgyWLyTCnr3Xkkvv0GKzq8SgjpLXvph3EJFOEDCJnQ1bGSaNk4LcU+MCqnzZfe
         yPJUIvhTqUgxmedAKcYAxD55/zEb/hugS014g/3w+4B4gVLIJFcKRK4hWcbCgJ0FZd+p
         3dbg==
X-Gm-Message-State: ACrzQf34tiC06jBHuHUFBgIhmwiu7qs7tIj/V1Ts7MkQF+0oV+BQibf1
        p3NfPW+xnqtSIDDvroTP+Nk6vk9DAIp+fQ==
X-Google-Smtp-Source: AMsMyM6wdg+8KRdSAaiwO14Vxuxd+vx0l/jvivNeeD4ncPgJBLu1u77/UQZ2qL00jLHDi1FK6zWo0w==
X-Received: by 2002:a63:6d49:0:b0:43c:4eef:bac7 with SMTP id i70-20020a636d49000000b0043c4eefbac7mr3654048pgc.356.1668120406609;
        Thu, 10 Nov 2022 14:46:46 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a454a00b00214247ac1acsm3571235pjm.12.2022.11.10.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:46:46 -0800 (PST)
In-Reply-To: <20221031182943.2453-1-jszhang@kernel.org>
References: <20221031182943.2453-1-jszhang@kernel.org>
Subject: Re: [PATCH] riscv: vdso: fix build with llvm
Message-Id: <166812034329.20280.6345239431217056884.b4-ty@rivosinc.com>
Date:   Thu, 10 Nov 2022 14:45:43 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 02:29:43 +0800, Jisheng Zhang wrote:
> Even after commit 89fd4a1df829 ("riscv: jump_label: mark arguments as
> const to satisfy asm constraints"), building with CC_OPTIMIZE_FOR_SIZE
> + LLVM=1 can reproduce below build error:
> 
>   CC      arch/riscv/kernel/vdso/vgettimeofday.o
> In file included from <built-in>:4:
> In file included from lib/vdso/gettimeofday.c:5:
> In file included from include/vdso/datapage.h:17:
> In file included from
> include/vdso/processor.h:10:
> In file included from
> arch/riscv/include/asm/vdso/processor.h:7:
> In file included from
> include/linux/jump_label.h:112:
> arch/riscv/include/asm/jump_label.h:42:3: error:
> invalid operand fo
> r inline asm constraint 'i'
>                 "       .option push                            \n\t"
>                 ^
> 1 error generated.
> 
> [...]

Applied, thanks!

[1/1] riscv: vdso: fix build with llvm
      https://git.kernel.org/palmer/c/50f4dd657a0f

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
