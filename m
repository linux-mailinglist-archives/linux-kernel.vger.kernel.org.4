Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8371F1C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjFAS1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjFAS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:27:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80998171E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:27:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53fb64b3368so658364a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685644025; x=1688236025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctf1HD9q2IXAlWGZe0D1mEr62PaUnWG7sqP8wEigDAM=;
        b=oQgl78QYG5Oj68tYfu28Af11McToK99Xc7cFV/WH2ogHroD1GdfvX22wD/gSmA8aMP
         xqCFWhpZwhyN0YrqAvcKjFZdTkBLYFqwpi+GrPRnAe1zzZL0DZpvRCHlUNlpG4wyJSzO
         KPRVn/di/BWJKYn3/rifCxelC2KwvxVw4Wrx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685644025; x=1688236025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ctf1HD9q2IXAlWGZe0D1mEr62PaUnWG7sqP8wEigDAM=;
        b=fzHRNm+4yKP2DirP9tJfpA5FEQbx2ECxs3UoMdLRvJY6a3Uk8i6ipmM1Cfm5morXfU
         ri3KoPSu1RpPRMiZ+4OYYRRPJ51h/p+bEZooYawrOSvTi5ikuN5WPcjwd/M17HoTkxFk
         Oy0f105VYRswWyeD7Sy0lIK5WQfmPjCTo2vRaE/8W2MJ/WiKA/Yt01QMpwaqk7AC0mtB
         4VRyw6AI5U2bnZ8WN8d9QMHRYGw8b7T9fQA3P17c6lBtjiP7btMs1l9SF9hA83DiYl6q
         ykxx4GK9Wm5DmQUGuDWHgcxOXX+G+j37K2FBTvurh7oQjbbYDVF52mkkQ5V0T/xwH9UA
         gfwQ==
X-Gm-Message-State: AC+VfDzYmlGc0VzrjN5K4O7WaOwf4nq6CHMTqbIqulDvaMc0le/pmzTu
        wfDi98qLj55I+1lbeoDkeZJfRA==
X-Google-Smtp-Source: ACHHUZ7tPlL1ll6KCGCyuy9FbrvkGPsvnW5z4XOtzglH+OZASYBlfmRDsuL8K30dabeFU2fpmQaSgw==
X-Received: by 2002:a17:902:a710:b0:1b1:af8e:d31d with SMTP id w16-20020a170902a71000b001b1af8ed31dmr151235plq.40.1685644025042;
        Thu, 01 Jun 2023 11:27:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001a505f04a06sm3797670plf.190.2023.06.01.11.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:27:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     keescook@chromium.org, paul.walmsley@sifive.com
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org, linux@leemhuis.info,
        heiko.stuebner@vrull.eu, linux-hardening@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        joanbrugueram@gmail.com, masahiroy@kernel.org,
        conor.dooley@microchip.com, ajones@ventanamicro.com, hi@alyssa.is,
        palmer@dabbelt.com
Subject: Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
Date:   Thu,  1 Jun 2023 11:27:03 -0700
Message-Id: <168564402237.2891605.1600418987887898293.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601160025.gonna.868-kees@kernel.org>
References: <20230601160025.gonna.868-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 09:00:28 -0700, Kees Cook wrote:
> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> 
> struct sha256_state {
>         u32 state[SHA256_DIGEST_SIZE / 4];
>         u64 count;
>         u8 buf[SHA256_BLOCK_SIZE];
> };
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] riscv/purgatory: Do not use fortified string functions
      https://git.kernel.org/kees/c/ca2ca08f479d

-- 
Kees Cook

