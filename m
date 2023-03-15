Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5636BA71A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCOFbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCOFa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:30:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A922523A56
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 22:30:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cn6so5017223pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678858182;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yO2JdZBhVT6K1R3HgGxTHc/9StnL6HlTJnhtNYvf5b8=;
        b=XuLxPRJerXkMReEgVl/f2mnOOygVmUj/lGES6XEg2QF9HGWYxHEEd7ModPiSeLoQe/
         JJhxbB0dGuJqqdYo1rbDU+5Fg/upImnHV+1uHRE+9IuE1i0NXRDZ8jTayPJXrtp76xPy
         xaWfTIasXplx/YoCYdOz5jvlONSUmo+WUBRF4DlPJqUAyktTzreZPFkPxRGLF1GFBqG4
         FQjzk/acv06/si0z0mVxBOqrN8azDRzRu3MGJqanLEsz8m07ehhutRjcqva2cAewJ2Xc
         TqGhJnfFfaWjkeHsK6u1qA8Eks0m9NItfUpJJUfSlyJnWxnqhhVVsQHb7eqmj6dDgZh+
         HCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678858182;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO2JdZBhVT6K1R3HgGxTHc/9StnL6HlTJnhtNYvf5b8=;
        b=JMBUti9zrbGc6nmMag/W7xwhCYg2Z1UMO0Ji3huNUO1qLVJQCIlM/MRl4Loftv+nmD
         jFNmZ0xZdM7oamqNKC/Zt/Upisyg8egMmcMYFwy4kW8F6JgsYy2AUq7woCWpak8i0OPw
         KmfHpwVldJ5PGn1mG2mgz99fdSjeaPN0zuQRBjdFYtTIEiihUjgE5TJTJcvLmJEvXo6g
         mNJX/XN9VsPaSRmqm0ea6LueUJl8ITPIk/CdcqxPjXUnhrcxT40tuqRpnORLyfDy9LqI
         +SN0rOLcFBMK/5zLWZ2MvUKEI+0prZPOivUq2vR35gMcmoEfycsJkJul7AXZqYjtQ6Qq
         ehwg==
X-Gm-Message-State: AO0yUKV+v6NLNY6rFzasjw4supBdDjysASQzsWF5tt14woXEG/ULnVtm
        x2hzN2VsqdNImdSaTOoUiDQpoQ==
X-Google-Smtp-Source: AK7set+xKbFQdz8ev2g2AROltE2M+kKt2ZcWLgaiLiw2loNj9CyiqQ8fdncCa1eye2Iakvln0Vx3xQ==
X-Received: by 2002:a05:6a20:4d8a:b0:c7:13be:fb53 with SMTP id gj10-20020a056a204d8a00b000c713befb53mr32479621pzb.3.1678858182370;
        Tue, 14 Mar 2023 22:29:42 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p12-20020aa7860c000000b005cd81a74821sm2526622pfn.152.2023.03.14.22.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 22:29:41 -0700 (PDT)
Date:   Tue, 14 Mar 2023 22:29:41 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Mar 2023 22:28:31 PDT (-0700)
Subject:     Re: [PATCH RFC 0/2] RISC-V: T-Head vector handling
In-Reply-To: <20230228215435.3366914-1-heiko@sntech.de>
CC:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-6d6a325c-4adb-4d9a-98a0-012c75b4562e@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 13:54:33 PST (-0800), heiko@sntech.de wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> As is widely known the T-Head C9xx cores used for example in the
> Allwinner D1 implement an older non-ratified variant of the vector spec.
>
> While userspace will probably have a lot more problems implementing
> support for both, on the kernel side the needed changes are actually
> somewhat small'ish and can be handled via alternatives somewhat nicely.
>
> With this patchset I could run the same userspace program (picked from
> some riscv-vector-test repository) that does some vector additions on
> both qemu and a d1-nezha board. On both platforms it ran sucessfully and
> even produced the same results.
>
>
> As can be seen in the todo list, there are 2 places where the changed
> SR_VS location still needs to be handled in the next revision
> (assembly + ALTERNATIVES + constants + probably stringify resulted in
>  some grey hair so far already)
>
>
> ToDo:
> - follow along with the base vector patchset
> - handle SR_VS access in _save_context and _secondary_start_sbi
>
>
> Heiko Stuebner (2):
>   RISC-V: define the elements of the VCSR vector CSR
>   RISC-V: add T-Head vector errata handling
>
>  arch/riscv/Kconfig.erratas           |  13 +++
>  arch/riscv/errata/thead/errata.c     |  32 ++++++
>  arch/riscv/include/asm/csr.h         |  31 +++++-
>  arch/riscv/include/asm/errata_list.h |  62 +++++++++++-
>  arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++++--
>  5 files changed, 261 insertions(+), 16 deletions(-)

I have no opposition to calling the T-Head vector stuff an errata 
against V, the RISC-V folks have already made it quite apparent that 
anything goes here.  I would like to get the standard V uABI sorted out 
first, though, as there's still a lot of moving pieces there.  It's kind 
of hard here as T-Head got thrown under the bus, but I'm not sure what 
else to do about it.
