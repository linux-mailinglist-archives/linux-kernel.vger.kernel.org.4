Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5072CA16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbjFLPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbjFLP3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:29:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2B91B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:29:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3942c6584f0so1632474b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1686583791; x=1689175791;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+L3sNBGkEDm+nY+O6ThdBKE7WdymZq4deKq6djroJ+4=;
        b=go09bCif4ImXiCWgjVptfkS9gXEy0+VB5/+YiVIIRg/UaF0J/xL24VDZEuptVDNfL1
         TrKC73Qm8r/vjS4Dp1y7404UdPFirmviByLME8pnKRyqb4YDCW63IpUOf642JoPHe6bj
         APrd9Nse/u+hCdTqF61XybXoApKjTARMyWt8tjlL6fu6estIpaQhGDh0SEmtdRd2Ja88
         c5kKfKXmD3BKOwYJlqaYos0cL435spWC59lFgnIQbC2gpYTnhA+qnFMw3cfyRwK0Q48p
         ONlTAEDfPvkyMx7opPf3w0a7TeNZJ3ePeKlgU/Fc/GmQfGTlA5fGoxqFZ78zyQ0sRjQp
         EYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583791; x=1689175791;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L3sNBGkEDm+nY+O6ThdBKE7WdymZq4deKq6djroJ+4=;
        b=YAv35Y8UzaRKQpRMmARh2yJnJTRthQgAICmgsYodDZwNn61bR1vtE7e+2GrvMnsYUE
         zYJ4uqSM4CSTqDwqZelOB/5UnVE4pQXse0jO4b5fESKM2Iyv2b1bdB4u3FyC091VNymz
         3KkTF/GElkteLZKy06jyNRKXkev/lX4Z9UfT00H9U6ovG7kxQi3c+njJPzwhhjrF0BkO
         G3abEfVxL85svkHjIWMg4e+5H21URmx60vfPmMHUm7KxED0PGlOsYkFmJ4NXF8SVPdLU
         k2ayZIT9JoGQc8rAf3VIoTzvsOYVSLM094GlpxTMC1tcJU4uvSlVRZsyvOINDfXeY9Sg
         Rgew==
X-Gm-Message-State: AC+VfDzqSXjgDQ3XOVlk8xvzHcX+vxyFpdac1LrDIrZXEYlXcGoFwm9O
        pThQj8gnjIthY55U25lmopnmw3MAW+SMwc04kB8=
X-Google-Smtp-Source: ACHHUZ57XwJNmqydEfIp4zrTcUdo5NXQTs9MhZtPtZpjHailChIEu86ekE94sWUuxvP9d3aojoVRKQ==
X-Received: by 2002:aca:230b:0:b0:394:4642:7148 with SMTP id e11-20020aca230b000000b0039446427148mr4426563oie.48.1686583790671;
        Mon, 12 Jun 2023 08:29:50 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b002599ef80ab9sm9418417pjb.3.2023.06.12.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:29:49 -0700 (PDT)
Date:   Mon, 12 Jun 2023 08:29:49 -0700 (PDT)
X-Google-Original-Date: Mon, 12 Jun 2023 08:29:45 PDT (-0700)
Subject:     Re: [PATCH RFC 0/2] RISC-V: T-Head vector handling
In-Reply-To: <mhng-6d6a325c-4adb-4d9a-98a0-012c75b4562e@palmer-ri-x1c9a>
CC:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de, guoren@kernel.org
Message-ID: <mhng-ca852a2c-a1c7-4b14-a9a2-f2bd4541d6b7@palmer-ri-x1c9>
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

On Tue, 14 Mar 2023 22:29:41 PDT (-0700), Palmer Dabbelt wrote:
> On Tue, 28 Feb 2023 13:54:33 PST (-0800), heiko@sntech.de wrote:
>> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>>
>> As is widely known the T-Head C9xx cores used for example in the
>> Allwinner D1 implement an older non-ratified variant of the vector spec.
>>
>> While userspace will probably have a lot more problems implementing
>> support for both, on the kernel side the needed changes are actually
>> somewhat small'ish and can be handled via alternatives somewhat nicely.
>>
>> With this patchset I could run the same userspace program (picked from
>> some riscv-vector-test repository) that does some vector additions on
>> both qemu and a d1-nezha board. On both platforms it ran sucessfully and
>> even produced the same results.
>>
>>
>> As can be seen in the todo list, there are 2 places where the changed
>> SR_VS location still needs to be handled in the next revision
>> (assembly + ALTERNATIVES + constants + probably stringify resulted in
>>  some grey hair so far already)
>>
>>
>> ToDo:
>> - follow along with the base vector patchset
>> - handle SR_VS access in _save_context and _secondary_start_sbi
>>
>>
>> Heiko Stuebner (2):
>>   RISC-V: define the elements of the VCSR vector CSR
>>   RISC-V: add T-Head vector errata handling
>>
>>  arch/riscv/Kconfig.erratas           |  13 +++
>>  arch/riscv/errata/thead/errata.c     |  32 ++++++
>>  arch/riscv/include/asm/csr.h         |  31 +++++-
>>  arch/riscv/include/asm/errata_list.h |  62 +++++++++++-
>>  arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++++--
>>  5 files changed, 261 insertions(+), 16 deletions(-)
>
> I have no opposition to calling the T-Head vector stuff an errata
> against V, the RISC-V folks have already made it quite apparent that
> anything goes here.  I would like to get the standard V uABI sorted out
> first, though, as there's still a lot of moving pieces there.  It's kind
> of hard here as T-Head got thrown under the bus, but I'm not sure what
> else to do about it.

The V-1.0 support has been merged, so I think we're good to go.  Does 
someone mind re-spinning this against for-next so it lines up with all 
the new user interfaces?
