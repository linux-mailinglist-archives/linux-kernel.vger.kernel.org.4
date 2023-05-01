Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1676F3AA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjEAWpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjEAWpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:45:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E69269E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:45:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aad6f2be8eso25074975ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682981102; x=1685573102;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LZi0uFoSVBSgxnjAaZxQ81ReVJ0WeW+B2FFhNfROww=;
        b=ahejidMZTueaiJMvaEq7zIo8KZo9LgVrR2se3EgkY2xdLWi0ff4/W/mIv99jbch/zj
         EeSmY+8PkfMv2hP5iRkEcYcaktQOreBhcTpFE179BrMe42S5IFoertGSs/osFvwf/eTe
         PhQ3mnCF+ZwIzlFuczKeK+QsTTd2c3Fyjo5qMt196Qn8LF0kx5Xi2ccF0JjgGFt/UZqx
         7pqJLxR5bHSnkAf8934pj1cj07FDTnSTIZFzLZ3w91082zp1JG6ifY8ISta8wD0suIp4
         q8y1BQXEW3+/ZXzmPg6m3/5FudLE144YnISLQh7ZbxF/0tLMU5mJLhwUk9Qfutkwy7QT
         0jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981102; x=1685573102;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LZi0uFoSVBSgxnjAaZxQ81ReVJ0WeW+B2FFhNfROww=;
        b=RImHl4fvU2GPXjp4NobmfHnvr5TDWfiISrbKPtki/2UrU5eV4Bjvtu2EGHE86IV1H9
         rGLWYEy2K+NGd2VF1XZfqUXLhXh7y3jdoegb88ye8L0rz964FRs5O9n+wrp4kBw6QANp
         I0kAwAgar3l6pEycm/W+QosxeHxsXVF8ieF0QDzEXmlR66cSQKaqjAV8qdxx6iOUA2zT
         A1UVBO5dK7TxVnb3qN5ZcJ5IIEFtUMy5Yrkqdcu7zUb4+2gEqxn8nSUOzks1DDPGyWvW
         tPmTKkhiwo4LkYmXzohQ87NE89z2gSfMEup2+ekEnwHQBNe6X1KoYXgphjB1/xvi+0VA
         +Iyw==
X-Gm-Message-State: AC+VfDw4wMxLpGn5wjpT723yJTcPDaPvIBKAxdqxYwGhjTWyxHIBMhda
        KDncQTIQh4WCsfztPvLDogf0Zg==
X-Google-Smtp-Source: ACHHUZ5xmM0eXrwYAGux0Gd55M+QfxHl5MSIckzBt45AIO11o1GavlntEMZonuJdLzlh6wmdmSK7IQ==
X-Received: by 2002:a17:902:f546:b0:1a9:9a18:346a with SMTP id h6-20020a170902f54600b001a99a18346amr19548933plf.5.1682981101945;
        Mon, 01 May 2023 15:45:01 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b001a634e79af0sm1639156plr.283.2023.05.01.15.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:45:01 -0700 (PDT)
In-Reply-To: <20230429-trilogy-jolly-12bf5c53d62d@spud>
References: <20230429-trilogy-jolly-12bf5c53d62d@spud>
Subject: Re: [PATCH] RISC-V: fixup in-flight collision with
 ARCH_WANT_OPTIMIZE_VMEMMAP rename
Message-Id: <168298107622.32296.5069114246670068360.b4-ty@rivosinc.com>
Date:   Mon, 01 May 2023 15:44:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Lukas Bulwhan <lukas.bulwhan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Apr 2023 10:27:33 +0100, Conor Dooley wrote:
> Lukas warned that ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP had been
> renamed in the mm tree & that RISC-V would need a fixup as part of the
> merge. The warning was missed however, and RISC-V is selecting the
> orphaned Kconfig option.
> 
> 

Applied, thanks!

[1/1] RISC-V: fixup in-flight collision with ARCH_WANT_OPTIMIZE_VMEMMAP rename
      https://git.kernel.org/palmer/c/26b0812f4cf8

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

