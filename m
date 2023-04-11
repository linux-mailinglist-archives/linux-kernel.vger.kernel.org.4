Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E291D6DDAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDKMbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDKMb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:31:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684DF3C0D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:31:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so12120318wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681216287; x=1683808287;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsdJg6MZvLyW6lyiDQpN3lhmgzc4LeAZsE9rDHV+Jr8=;
        b=gik7YFy29rFOY8/ULA7RG1tlEApOn1I1BhHWSq0CeLDZpAQjbKnGrnZpCaMFbjkGr/
         Mb7BiyfdL3fyxV/v+fxU8dStBUcPzh9mHpb5ZzbACaLg4sEFF5YSOUu/dTp90nx8j+wU
         Fgfla62Kt+GiUM6LgIaXxuzqrIle3fiR2tV9Zx00NRZufT7qZ6tr2gymEJooY2oazGEV
         eVVHRWh2MbrN7UiycEa0yoqumWR9lqg6dUOtWhJztQDIQ8Ozsqrx+/JStTkpxaUQrSkR
         5PVQiS8p287IOdqvUw+ACt6umZheyrTvNMI/mQ58HlEElU53W9qguwwRVRHdWs4Iynko
         qlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681216287; x=1683808287;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsdJg6MZvLyW6lyiDQpN3lhmgzc4LeAZsE9rDHV+Jr8=;
        b=z46sZ+ZyZpbosh76hH9TgA5e4T/wDffGi3ioaRHZ327poqbu+isb+XP91C2wwdjsL9
         k2qAgtX9dSQlzRXIrVrrKrFaqlA+BfFFCCNVlW1gH8cySFhL0uqme+ZiBl5UUWm6DaDj
         iKN4qefsAzFzU6W5CpbRVUunc2STIz06m8KOP+teFADGIXe+BleVMULZxFatyYUENXGA
         aBhO4FvS9AKY4LTJI0fmcr934RFb/Jp/WlRLTBh8/8W72/DBIU3Sr8JBfAc6hdul3uO2
         1G6Er1Oxe9HrqL0yUVLr8UL6POWOkI5HL5R1pYDsk4UOzv/2Z9LxyBSbr4pMM1mUAiE1
         BJlA==
X-Gm-Message-State: AAQBX9fovlmPkNXIB6ONCGIwGG6GnovASFjm8T05uLdyJstIg44nBlJX
        OTkvXnC9Hw2YcrwaAcWcaDC/iGakLu5iWnsGj1GVuQ==
X-Google-Smtp-Source: AKy350aaxiNbNBEuf22Wx7XVDPR+xAL3ayHy6cBRDSBbd98zpwLA07+fLQAy8RT/FUUA9LkhcQ/xUDUsdwCdCs74LiI=
X-Received: by 2002:a05:600c:218c:b0:3ee:282d:1031 with SMTP id
 e12-20020a05600c218c00b003ee282d1031mr2918698wme.7.1681216286906; Tue, 11 Apr
 2023 05:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230329082950.726-1-cuiyunhui@bytedance.com>
In-Reply-To: <20230329082950.726-1-cuiyunhui@bytedance.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Tue, 11 Apr 2023 20:31:16 +0800
Message-ID: <CAEEQ3wn6Gu_L37PEnQc-bBJC+OAnQWH1gDSOwKYPSTNzy1tCzg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Dump user opcode bytes on fatal faults
To:     conor.dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mpe@ellerman.id.au, jpoimboe@kernel.org, mark.rutland@arm.com,
        svens@linux.ibm.com, cuiyunhui@bytedance.com, guoren@kernel.org,
        jszhang@kernel.org, ebiederm@xmission.com, bjorn@rivosinc.com,
        heiko@sntech.de, xianting.tian@linux.alibaba.com,
        mnissler@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Any comments on this patch?

Thanks,
Yunhui
