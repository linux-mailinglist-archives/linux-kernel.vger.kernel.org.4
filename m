Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243DA614C05
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKANsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiKANsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF4F5FEB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ACF3611E7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83837C433C1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:48:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C/EkpA4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667310520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8h20gg7md2uQz/Rln5a9d67ErmfoHNc1Qg99wXNW8g=;
        b=C/EkpA4b/Tdro7cPvR9h88iJjDpsbmHf5+pX81lIAnKw6B+Rzfzhoh3qFrvtlIzq6nPmt1
        +PaK92fn0+xgspJ9W/ZgTDo/SYmSdiN88Kwwj20LReUWE8IpMN0KEQtVokunr5CYhWNfaR
        9nY4pvUNW0HU0x42at1kV6owTYXNrPU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 97918bde (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 1 Nov 2022 13:48:39 +0000 (UTC)
Received: by mail-vk1-xa2a.google.com with SMTP id m18so7069781vka.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 06:48:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf3PJuHjFEqUFb6WsTCzvx/+r6LZMQok8OwGwVj03Ar6ce0SEfFi
        zI60YrDG46Ah7EXVow+gG2NnQEGwXd0Thj9tn6I=
X-Google-Smtp-Source: AMsMyM7yOpJ+JF76Vcqm/2a5cD7/H0UAFt/1UbkFlW9YuAC6V37zK11coVQA3uw/+RQH3VjjTVNQQwkz9q96Ao1Psus=
X-Received: by 2002:a1f:9b58:0:b0:3ab:4834:f5d0 with SMTP id
 d85-20020a1f9b58000000b003ab4834f5d0mr1371092vke.3.1667310218464; Tue, 01 Nov
 2022 06:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221101111418.816139-1-cuigaosheng1@huawei.com>
 <Y2EEY63DnDodJFoz@zx2c4.com> <eed4512b-ac6e-bcec-2f66-7ab45aef9be9@huawei.com>
In-Reply-To: <eed4512b-ac6e-bcec-2f66-7ab45aef9be9@huawei.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Nov 2022 14:43:27 +0100
X-Gmail-Original-Message-ID: <CAHmME9rNE-fWcdJer-MsQJ224redaXJO-Vvcjy6xg0_Eib-RZQ@mail.gmail.com>
Message-ID: <CAHmME9rNE-fWcdJer-MsQJ224redaXJO-Vvcjy6xg0_Eib-RZQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/cpu: replacing the open-coded shift with BIT(x)
To:     cuigaosheng <cuigaosheng1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        puwen@hygon.cn, TonyWWang-oc@zhaoxin.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, andrew.cooper3@citrix.com,
        tony.luck@intel.com, mario.limonciello@amd.com,
        pawan.kumar.gupta@linux.intel.com, chenyi.qiang@intel.com,
        rdunlap@infradead.org, jithu.joseph@intel.com,
        rafael.j.wysocki@intel.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 2:37 PM cuigaosheng <cuigaosheng1@huawei.com> wrote:
> > 215 [ 0.953146][ T0] UBSAN: shift-out-of-bounds in mm/shmem.c:3749:18
> > 216 [ 0.953863][ T0] left shift of 1 by 31 places cannot be represented in type 'int'

Isn't this just an issue with `1 << 31` needing to be `1U << 31`?

Jason
