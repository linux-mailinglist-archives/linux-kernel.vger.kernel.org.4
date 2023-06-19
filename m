Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6073603C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFSXoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFSXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:44:52 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1BE187
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:44:47 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-762490831f6so242681185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687218286; x=1689810286;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6NVBN3x4KrAYlFI5NJJMWbkFks+jrlTm7nV+Qf0S1A=;
        b=DC8vg/VHEzuBj5dHLugui1wJEWfATTozq8rSoU8iW2VInUwqg0k2wXK82rVw5yxGGn
         RlIKoLpVcEPPjolbCopKExuQm25nzEsthEm14/fFoQobBCjsKi+QgmyzuuEWEzs2+i1y
         lsTH5vZBqLLJwtcN+9dSjAC1eZRXbfYmbZ9wRkwuW4nYYYEz2LXC10vNCAelvV07NBPz
         S4QkVgD1mdzB9B6wE8bW2ujvYY5bpd0Z/bDsAClhebwveFdviPnpKQ2WEL7haq1GJzvu
         LtRIEXyEPnf2ehWS6/NKpNMZ82VTBDAkC+QS9ST86eY91wRnzgO1IxyKZ6XAX0ohZNXY
         Jxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687218286; x=1689810286;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6NVBN3x4KrAYlFI5NJJMWbkFks+jrlTm7nV+Qf0S1A=;
        b=IjPjq3c/zL+mLTxgF+OJPmYcW03Xsy65b+YkcJZG6feftYpUqTKGY7L/B3HMFM34uM
         gF1VkBdpZa9n11g3GsODeBvwUyL5e7dZVqccg+0nf8L7yOVK3xIZ90Y225KP7u6gBUeF
         AJJNCxmEoivUMGZwQ0yVOiquCZ7nHM18LcZac1odc3mRlBu/LzhcFvBfRAdyaMluUKfp
         gSjy4AdMIqJZOGPLGhKFKqpL/AjE0jhD+U+sqp3X+nJ3zBlF9x/1OOqvGaAyQ5eHHQRd
         9G1J4kIe4Wb49B7RPHE5kRF9Jubp7vRT4uj3Y6Ev9f3qeR83I+ySAdtvPaI/bP3dTNq6
         SY1Q==
X-Gm-Message-State: AC+VfDyZATaKlkOq/0xHGFS+j+pAZKwrK1hzBFWuUIbKrrY16AIDhHF4
        YsnGjiAp9aleG/y0Hu5NXaimsFaoqrZfCu4naqg=
X-Google-Smtp-Source: ACHHUZ6ykADNR4ba4m3MttX4Zwe8bV6FzvLAWlo7P94vWhsGn4ambgFET6InpYy7OQWy9VqozVPvTA==
X-Received: by 2002:ad4:5de8:0:b0:62d:e1ac:7133 with SMTP id jn8-20020ad45de8000000b0062de1ac7133mr11906766qvb.33.1687218286636;
        Mon, 19 Jun 2023 16:44:46 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id n1-20020a6563c1000000b0054ff075fb31sm177473pgv.42.2023.06.19.16.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:44:46 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:44:46 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Jun 2023 09:54:19 PDT (-0700)
Subject:     Re: [PATCH v2 1/3] RISC-V: Add Zba, Zbs extension probing
In-Reply-To: <23717157.ouqheUzb2q@diego>
CC:     linux-riscv@lists.infradead.org, apatel@ventanamicro.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Evan Green <evan@rivosinc.com>, jszhang@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, ajones@ventanamicro.com,
        Evan Green <evan@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     heiko@sntech.de
Message-ID: <mhng-40d6f343-f3cf-4248-8944-c344d60d189a@palmer-ri-x1c9>
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

On Wed, 10 May 2023 07:45:50 PDT (-0700), heiko@sntech.de wrote:
> Am Dienstag, 9. Mai 2023, 20:25:01 CEST schrieb Evan Green:
>> Add the Zba address bit manipulation extension and Zbs single bit
>> instructions extension into those the kernel is aware of and maintains
>> in its riscv_isa bitmap.
>>
>> Signed-off-by: Evan Green <evan@rivosinc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

Just FYI: b4 is giving me this

    NOTE: some trailers ignored due to from/email mismatches:
        ! Trailer: Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
         Msg From: Heiko Stübner <heiko@sntech.de>
    NOTE: Rerun with -S to apply them anyway

I added it.  No big deal on my end, I also send email from random addresses
that are different from my trailers.  It's just the first time I remember b4
saying something.
