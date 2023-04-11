Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40636DE2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjDKRkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:39:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF9C72A8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:39:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51843c78ee6so7924a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1681234771;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7pct+dMjqiVr0F6C0Ngb551md/gaAhmGoQbOMdY6l0=;
        b=VCnOKB7O+R3rx2QJgQk+H76PSX9UqiXTO19L4ieeibPM7fkJd6muBXdHWN8GaQcGfr
         0BjwL4NsGsQFHkT/CJZgfltdch5C47yw4K876P471CXwfRSj/00O6H61ZVxrmdpkRc5r
         4pYW/qNJUquMFVnrS2ZlraLQmSJ3h2XM7diaWmQy6wV3TYPPTQnDQ8hKqdc5lPrkYOm3
         TQKI0IxR6WeQM1lqxBUzRKMGYDd/PR7jaxvcFicisM7epKdXgmvyxN3gVHTnYji9enI7
         1uawsGcdwebp9Q0YDAbIIXtHR7u4AEJGvSnzqISlmOOfZ0BtaihjOzWyOuXtJXOE28is
         u9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681234771;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7pct+dMjqiVr0F6C0Ngb551md/gaAhmGoQbOMdY6l0=;
        b=h1Lc/5O67jdVHA7tfNqpWq9ldwCiDrnfvB5K4GWkE8sLIkEAHUEvyEVaoKQExQBeXQ
         nXCOMNO8udSWtT7E4TY3+DNJ/WeJ0/uduARYljr0o3lvue92va6naALLh6LNBxn2K/cz
         h5nNI4ZotY6QUKOdZOo5oVYJbLGFWj1Xb1tOvYBZ3gJUFXazcr+M4edwwe5XJPBbSQV/
         e9hDD8i2F2LXE8jP21dGY7y7NZeVOSLOSLCATggpyFl9UhJQEq2v/KnyVFsqNbgr5KFe
         l7PtaZXK+qH/pJL46LL2A8PG79atm1SsspFLSDUmiugzQlhF7L9iD0N1Q9eUxBShueTv
         vx5Q==
X-Gm-Message-State: AAQBX9eJEWEAjU93qL+uA8DvcqT0E2sO3giD6yBvvcIeAIygvAkkmx6C
        DJKCivtOyv8EVrdzJidMd7aXfg==
X-Google-Smtp-Source: AKy350a0lBTG5rtlJI4P1dbKwIlPah2sQql23zMsXH7d1sea7rkk6PhXo9y8G6+MoHm7zs+V7yzF9Q==
X-Received: by 2002:a62:8492:0:b0:627:ea7a:ff46 with SMTP id k140-20020a628492000000b00627ea7aff46mr15278563pfd.16.1681234770885;
        Tue, 11 Apr 2023 10:39:30 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n4-20020aa78a44000000b006338e0a9728sm6432340pfa.109.2023.04.11.10.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:39:30 -0700 (PDT)
In-Reply-To: <20230403065207.1070974-1-bjorn@kernel.org>
References: <20230403065207.1070974-1-bjorn@kernel.org>
Subject: Re: [PATCH] riscv: entry: Save a0 prior
 syscall_enter_from_user_mode()
Message-Id: <168123475135.4147.9051999374596978440.b4-ty@rivosinc.com>
Date:   Tue, 11 Apr 2023 10:39:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-901c5
Cc:     =C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
        iko_St=C3=BCbner?= <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Yipeng Zou <zouyipeng@huawei.com>,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        =C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 08:52:07 +0200, Björn Töpel wrote:
> The RISC-V calling convention passes the first argument, and the
> return value in the a0 register. For this reason, the a0 register
> needs some extra care; When handling syscalls, the a0 register is
> saved into regs->orig_a0, so a0 can be properly restored for,
> e.g. interrupted syscalls.
> 
> This functionality was broken with the introduction of the generic
> entry patches. Here, a0 was saved into orig_a0 after calling
> syscall_enter_from_user_mode(), which can change regs->a0 for some
> paths, incorrectly restoring a0.
> 
> [...]

Applied, thanks!

[1/1] riscv: entry: Save a0 prior syscall_enter_from_user_mode()
      https://git.kernel.org/palmer/c/9c2598d43510

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

