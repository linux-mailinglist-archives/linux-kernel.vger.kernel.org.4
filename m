Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07A9747535
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGDPWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGDPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:22:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9BBD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:22:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-262cc036fa4so2615818a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688484134; x=1691076134;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2YfH84aYhOUVzBJ91PYNwuoKxVCBB5MOVaCTdQMEy0=;
        b=wBMMe94gIZsJ6DpQk6yi8d0pg/B40kzuLGm1+/AkC92eNaPANxBBg02XfhM4fCdL7d
         esnha/Weday37ZU93W/kCiytV4BCWPy/YWVczXH/Rb1du0mxml7VqxBRnZKdCqe3lGqY
         LoreV/EAtJdvptUSEsHVJ0rsOZ8DK87EJSA6OIB3zwPepbQ/ob4fLV408tUKmchxdWEm
         1gQnnCljX3COXqmk3rw6CAiQkCRF8kea4sDkgxI5GNPtHb+iRYkm5bRD3dNfXhUt6ZWb
         jW5dtCNgdJ0hEhp6vmb1yHUUL1LBYTCuA6sQQK/5xwpi1L/nWkYkwk71PP1dq+YYlgmA
         LFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688484134; x=1691076134;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2YfH84aYhOUVzBJ91PYNwuoKxVCBB5MOVaCTdQMEy0=;
        b=OZ8WKZdQzz3VJh9aMEHXxnRb7A2O1L3qHG5GJdumeWC4UKZdkqxd23wvT52dGNOJI9
         f4E3XQBwGVT8evxJXXx1XwrqzPJHgXqpR+E4NCh7AuC5U2Z6zoJFerXH50sMu3KsBAdG
         REuKKswgVFu0hWWJ/aPw5BdcoBNogbeKehjTZB/e1cl3AMm2d6pE99swZdZxXkjy9o3y
         Pa8lhMLsFldol6x4Vd7pZ8HAc6EYbtVEo7O7HPKQctQWjIJul4NNcg4YcVeUTdSO58Tk
         U3257k97AvJYIdhuETO4YC6w8Y5xvgrc6Pao3KRmBj4cbsKwTM6jiFXCf2xw1CINe8pT
         naQA==
X-Gm-Message-State: ABy/qLZIqjIHzvqj+DB6M8bV56ep/E6e/QrRWm3+cKBS+lqpoE216zIy
        W6Ar6uELht6UngW4N8sfkMM4s8jo5mPxTbZLtK0=
X-Google-Smtp-Source: APBJJlGSNBzHh0j7jKsh/zTZH7bW4kPewXrJeGRjJm8yNqJaVvvGK8HprTj97ZEJRG58iKb0ywEH9A==
X-Received: by 2002:a17:90a:d481:b0:263:5d25:150c with SMTP id s1-20020a17090ad48100b002635d25150cmr10407031pju.29.1688484134375;
        Tue, 04 Jul 2023 08:22:14 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id r19-20020a634413000000b005579f12a238sm15446098pga.86.2023.07.04.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:22:13 -0700 (PDT)
In-Reply-To: <20230616114357.159601-1-ben.dooks@codethink.co.uk>
References: <20230616114357.159601-1-ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] riscv: vdso: include vdso/vsyscall.h for vdso_data
Message-Id: <168848412160.5368.3153467967300556806.b4-ty@rivosinc.com>
Date:   Tue, 04 Jul 2023 08:22:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Jun 2023 12:43:57 +0100, Ben Dooks wrote:
> Add include of <vdso/vsyscall.h> to pull in the defition of vdso_data
> to remove the following sparse warning:
> 
> arch/riscv/kernel/vdso.c:39:18: warning: symbol 'vdso_data' was not declared. Should it be static?
> 
> 

Applied, thanks!

[1/1] riscv: vdso: include vdso/vsyscall.h for vdso_data
      https://git.kernel.org/palmer/c/54cdede08f2f

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

