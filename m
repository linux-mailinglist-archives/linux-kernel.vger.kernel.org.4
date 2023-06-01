Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE371F387
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjFAURM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjFAURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:17:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94122189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:17:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b01bd7093aso7869195ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1685650625; x=1688242625;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjlZZ6nKS4GkUYpJEs75tROJCn6U9CxfxsCk2Sp4Rbc=;
        b=aDdbymcrnaNTB9sTEUjXxYlQF+34yd3gmVLW6y8qN+ciqLDdoDsbstFhfyDrM/PY1n
         MW92kPQsCXs4+aBKxg7nAQiIZq+bW6/D7HMmgrWx9Tykz6gDlLL/Ga8Y4kqeD+TAlF01
         Ii/8HV4B/epZ0php7mruuRMTndTIxxgGVyBoNPqVgf6I3dDyo3YlxqNAYnvPBVaga9mz
         FjyvLsYICnFuX3gVpaFiVzbZ5KfiTNcuUVgmamBCMLG7VgDqsWRLE2SVuhfOUJGs//p+
         txUuP/BJrP8NczFjOq8sXTsFELlWkXEaXMzu2x3pTdHHBhYtT36wSR0Uzkh47WvYo71u
         r93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685650625; x=1688242625;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjlZZ6nKS4GkUYpJEs75tROJCn6U9CxfxsCk2Sp4Rbc=;
        b=WY/aDKXYUGPxVHMZAYhPt+QhpkE4rp7mPIptiwR7TY5B11akW5WVXI1h7dSY2EhEX6
         vlSesP+KGFT1jc9S+0Ir67ambMhl6jStcLpb6ebrGNt89ZRU0hjEQkauYZdicIU49CwW
         bSUEEmRiYQSydbEraFaIHquhJa9kkzd8uqMXpqagxl55KrQJJKEhMK/Mpo04mcJblDgM
         oyKttI2lo+EzGD5WZ+lnJUy+qi0heVKPFQoKyknQ4QOmqlYuk04bSKcmbqL/hrz3go8L
         qfVYiHVE+2VN7oQryKqfhU+vPbunxW7+qLoZeiHOzyS4G5J3xgEg/z8YxappEzMCNMSN
         eWaA==
X-Gm-Message-State: AC+VfDyEQX/EqEL66sovnuLnxTRvHIZF1Viu6s8ZNu+O0g94puobWwh2
        rlEpJxo//vpIB4AMNKOWi1WxVQ==
X-Google-Smtp-Source: ACHHUZ4BpDHb2NTKUdlUUm/HUFHW89maI9BAsHQKu1v+LeQFvchawM0FVdmNZjlMPVk4Trl80MDxJg==
X-Received: by 2002:a17:902:f801:b0:1ae:8b4b:327d with SMTP id ix1-20020a170902f80100b001ae8b4b327dmr335375plb.42.1685650624848;
        Thu, 01 Jun 2023 13:17:04 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id im16-20020a170902bb1000b001a95c7742bbsm3979313plb.9.2023.06.01.13.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 13:17:03 -0700 (PDT)
Date:   Thu, 01 Jun 2023 13:17:03 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Jun 2023 13:16:34 PDT (-0700)
Subject:     Re: [PATCH v2] riscv/purgatory: Do not use fortified string functions
In-Reply-To: <168564402237.2891605.1600418987887898293.b4-ty@chromium.org>
CC:     keescook@chromium.org, Paul Walmsley <paul.walmsley@sifive.com>,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org, linux@leemhuis.info,
        heiko.stuebner@vrull.eu, linux-hardening@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        joanbrugueram@gmail.com, masahiroy@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, hi@alyssa.is
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-8c6309b5-4ba9-4276-a8e6-2864426e77f0@palmer-ri-x1c9a>
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

On Thu, 01 Jun 2023 11:27:03 PDT (-0700), keescook@chromium.org wrote:
> On Thu, 1 Jun 2023 09:00:28 -0700, Kees Cook wrote:
>> With the addition of -fstrict-flex-arrays=3, struct sha256_state's
>> trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
>>
>> struct sha256_state {
>>         u32 state[SHA256_DIGEST_SIZE / 4];
>>         u64 count;
>>         u8 buf[SHA256_BLOCK_SIZE];
>> };
>>
>> [...]
>
> Applied to for-next/hardening, thanks!
>
> [1/1] riscv/purgatory: Do not use fortified string functions
>       https://git.kernel.org/kees/c/ca2ca08f479d

Sorry, I'd just applied this to riscv/fixes as well.  I can drop it if 
you want?  I was going to send a PR tomorrow, just LMK.
