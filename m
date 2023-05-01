Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802EA6F3A9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjEAWpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjEAWo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:44:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6241FDD
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:44:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b62d2f729so2310129b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682981097; x=1685573097;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMZkDj7VgOqodDQTf+RGZGFN4SlNg+bxklecIZiMapk=;
        b=YVQSVHFU6drEqf6yR/m6JMlUICqGPz8mmUwFAW7FbfEsT+pckdZjnIMW+++g0P2j8R
         n5Yj9CkUumkqJTaLJ5tiHVoc8iI9hdW5eYb8Ku0ptL81OrvNGX0bbPSvCoB7PADM9mrB
         gPKhJYMq/6SHQj2OzLEa9XdWtDBFL+46S9VvC77QbLCrFHjh+VZkmE0SXcV09eKXiDRJ
         LyaeeiqGcZ40LIDdsv+taJZGzTshwahmdUcuJRWh5e07qzMu4FCbfaTqaN2n6fDkhHYd
         tQqEV4+HkkcJtnsZyGoIvbzxztoPOtI8LTX7JYgjexux+X8jgo/GI9v3Csqgs8GlT2NQ
         NORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981097; x=1685573097;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMZkDj7VgOqodDQTf+RGZGFN4SlNg+bxklecIZiMapk=;
        b=fiEd3C0fk0LBhDzP+XUAspTp9SpCoLh//a1RjnVxwhV1AVvdHYGwCDY2gxSJD03Wmt
         ss9+6MmLg20izpWJ1pkmmRvRMH2wSAo7qkmbng1zSuMTFXmPNOiX0zgHQonm2bQ9DZI9
         VJfMPB9m63LFRNv55QtuoyhvuJiNPC48W83Zu7DGwpq4GkPalYYv8fLqU6pVaEsiYCJQ
         +Z05YCSNp+s5XMTHWYQdTtkQ5uAMcIxUeLnfFJOzF1wd/mOJHkB4qjo2XJo7OcUFZTxZ
         llpR2fHnZy+ctRD5dPJPOh9W6GF52r6nIppUZeDuGfpMe1g2v9asj2IaeGdf2NY5r25B
         IjzA==
X-Gm-Message-State: AC+VfDxZpoSuPv53kOoOXMfpRbJJ5tcHWMKa99yiOpZavsSMN7hFL/b9
        8tDR02dSpFRHYfnRDwOGdIw/0Q==
X-Google-Smtp-Source: ACHHUZ4jrHnaq1MA5auC9NOYzdlhP/SacF2pM/8Y8Ooc2TkJgP5bZP9Y0KpXdSnHIjCvNRn2dfaARw==
X-Received: by 2002:a05:6a00:1706:b0:63b:7bc7:8049 with SMTP id h6-20020a056a00170600b0063b7bc78049mr23109268pfc.2.1682981097274;
        Mon, 01 May 2023 15:44:57 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id o8-20020a62f908000000b0063b5776b073sm20206232pfh.117.2023.05.01.15.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:44:56 -0700 (PDT)
In-Reply-To: <20230330064321.1008373-1-jeeheng.sia@starfivetech.com>
References: <20230330064321.1008373-1-jeeheng.sia@starfivetech.com>
Subject: Re: [PATCH v8 0/4] RISC-V Hibernation Support
Message-Id: <168298107607.32296.5646151276592938501.b4-ty@rivosinc.com>
Date:   Mon, 01 May 2023 15:44:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2023 14:43:17 +0800, Sia Jee Heng wrote:
> This series adds RISC-V Hibernation/suspend to disk support.
> Low level Arch functions were created to support hibernation.
> swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> cpu state onto the stack, then calling swsusp_save() to save the memory
> image.
> 
> Arch specific hibernation header is implemented and is utilized by the
> arch_hibernation_header_restore() and arch_hibernation_header_save()
> functions. The arch specific hibernation header consists of satp, hartid,
> and the cpu_resume address. The kernel built version is also need to be
> saved into the hibernation image header to making sure only the same
> kernel is restore when resume.
> 
> [...]

Applied, thanks!

[1/4] RISC-V: Change suspend_save_csrs and suspend_restore_csrs to public function
      https://git.kernel.org/palmer/c/0def12f32129
[2/4] RISC-V: Factor out common code of __cpu_resume_enter()
      https://git.kernel.org/palmer/c/fcb89863d1b7
[3/4] RISC-V: mm: Enable huge page support to kernel_page_present() function
      https://git.kernel.org/palmer/c/a15c90b67a66
[4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
      https://git.kernel.org/palmer/c/c0317210012e

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

