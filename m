Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63F6FFB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbjEKUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjEKUx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:53:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233794C12
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:53:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab13da70a3so88217305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1683838404; x=1686430404;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmqiYN6k7kNOHcOaFBtfG/CJoGmGnLxuGsiwVK55cYc=;
        b=QMR7fofFIz7UTDWgIWfb/8kl0kAphqE7lnR7CJeis2c94cLuhg3/r0tQz6eL/sMqfr
         q5xNDM7Hyo8pCRISro7QIUqhbV0mD85g5HYjAcBlMXOYLVpaVTD13xfZjSQmD8E/djLw
         0NPo8sFeER6dWIgeC+RaBaTHqqemzXR6zPA6W3ilnRtavZimjUbZ1Sa22tPEWq0Toe8y
         alpjDn886e8wtA1bMsiOvg1d8k7nW6tnvOIrrs3/Gymhm4LuaTtX3LuZ5jrexsSsXg2A
         PA+LVL4p9c22qmItfYfCYjj3HB682Ah3O0gRd7XS5qTuZaG9SwNSfX4TZgWWPy2lHlYp
         2JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683838404; x=1686430404;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmqiYN6k7kNOHcOaFBtfG/CJoGmGnLxuGsiwVK55cYc=;
        b=jUvPcAmNvU/nZYbjc9cL/ybuuOkFGvgJ5TKGv5ljBtmSm1Oau/BoKqHeC4U5AaaPE1
         EZg9Q+Isml/2HtW0XrTy04Y8fGuA8+b5/ZtaYrPb+LEE50XDAS7SqtPam4Wof7Y4PyGz
         jCj8QyEAzuusc1g3G1cHqfcLpoFOBdPDqi6TY4fGSbIE89MAzwm5kirT4USUts5d6h7Q
         9uIIf1bEjKhxELAtGkJD7mJqNdmTArQFdWYt4/bFNDHxcNQFhmQ299qANwRuRlcNzG5Q
         m+4ahasCV7neu/jOooolUbpfY5ebyL9tZkHFWeThIvZ69mB4McBV/p6hCsLoNtWL8cud
         PdIg==
X-Gm-Message-State: AC+VfDxiOt4CRdBReYqJdJ03CLxXPxoRH3ZWkCRopx120AP/p8FjBib8
        uTotCf/8mMxUrMWz3uK15ntZDg==
X-Google-Smtp-Source: ACHHUZ4RrmTAXKngjyn+GYqfCF3MaY6lhqY4LbQJaq1mFOhwPgfCLqhai76N7zGoZNwWLze23GeF0w==
X-Received: by 2002:a17:902:ce82:b0:1ac:95c2:ed75 with SMTP id f2-20020a170902ce8200b001ac95c2ed75mr15028551plg.53.1683838404455;
        Thu, 11 May 2023 13:53:24 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ee8a00b001a9873495f2sm6366920pld.233.2023.05.11.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:53:23 -0700 (PDT)
Date:   Thu, 11 May 2023 13:53:23 -0700 (PDT)
X-Google-Original-Date: Thu, 11 May 2023 13:53:02 PDT (-0700)
Subject:     Re: [PATCH 0/3] riscv: sbi: Switch to the sys-off handler API
In-Reply-To: <20221228161915.13194-1-samuel@sholland.org>
CC:     dmitry.osipenko@collabora.com, rafael.j.wysocki@intel.com,
        samuel@sholland.org, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        geert@linux-m68k.org, heiko@sntech.de, kai.heng.feng@canonical.com,
        mcgrof@kernel.org, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, pmladek@suse.com,
        yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangmeng@uniontech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-59817569-7525-450f-9bfd-ecb34a30744c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 08:19:12 PST (-0800), samuel@sholland.org wrote:
> I want to convert the axp20x PMIC poweroff handler to use the sys-off
> API, so it can be used as a fallback for if the SBI poweroff handler
> is unavailable. But the SBI poweroff handler still uses pm_power_off, so
> done alone, this would cause the axp20x callback to be called first,
> before the SBI poweroff handler has a chance to run.
>
> In order to prevent this change in behavior, the SBI poweroff handler
> needs to be converted to the sys-off API first, at a higher priority.
>
> This series performs the conversion, after accounting for the fact that
> the SBI poweroff handler is registered quite early during boot.
>
> The first patch is a dependency for both this series and the PSCI
> series[1], so I would like to get at least patch 1 merged soon.
>
> [1]: https://lore.kernel.org/lkml/20221105214841.7828-1-samuel@sholland.org/
>
>
> Samuel Holland (3):
>   kernel/reboot: Use the static sys-off handler for any priority
>   riscv: sbi: Share the code for unsupported extension warnings
>   riscv: sbi: Switch to the sys-off handler API
>
>  arch/riscv/include/asm/sbi.h |  1 -
>  arch/riscv/kernel/sbi.c      | 63 +++++++++++++++++++++---------------
>  kernel/reboot.c              | 10 +++---
>  3 files changed, 41 insertions(+), 33 deletions(-)

Samuel: do you mind rebasing this and resending it with the reboot folks 
in the To list?  That way we might be able to get an Ack on the generic 
bits.

Thanks!
