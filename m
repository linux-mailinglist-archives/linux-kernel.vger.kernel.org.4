Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BBF62F139
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbiKRJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiKRJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:31:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD0217A9D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:31:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k8so8423996wrh.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fetCAE25qHzCxsfAEy/LSksZCYfUo1dgBC8JMthSJPw=;
        b=ILv/fUUE4o7JlmKvA5+N32XO6eYFm0iBtxdTyrL34D9ZI5gCqmn6DE97g6mWV7EtFG
         UcdJNssdQuxr3v9d9UsoPyFFSUgpYzN2KobUbXE0SXgj01H11UTURTXNm+72Ivq8H4uz
         z8OkqUsIst6nB+UHNlDEU5J/46IwZb4+0sVVvPShe7Jzfs4Fq1drLnMxVwdZ5Ox36BEP
         MV8s6fcWLq2vExgWwwrKOyblDydaa6QtOIQ1R36cKvlPUdA4RO3jRSdjDTiu148SAHWV
         jnaz5EI0axZWwCKmUGxxgmZhEhdydY/hKoF8LrtsXMwuoaHDAHNBs+Ui1so3IY2Oo5Rr
         /YcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fetCAE25qHzCxsfAEy/LSksZCYfUo1dgBC8JMthSJPw=;
        b=1Sa1dmonPlMizUDDz3Nqs9AMSk7Nx4cuuKvVOPaZjFoRClrum2IelFxKHYnw8KucbZ
         Jym8pKqjfQdXXrfVh2kzB7F6hpYPDyqM3A0HGIS/jBNcV3t+K/0oOY6ePhlq8laVrZdq
         GmDezKmxfDmYozN6KocdypKTongN5NIe/QKd4JOiWjoZ52A5NErNl3Y4YjopZxAJ9sxH
         OZYGKvcgWAkWrVW53hXcD1AkwVFnDhdJi1BQYYBXrz1VchBC5O/RzNxDbNcwAW1q6tlK
         6ZWD9Kh5NXoUxubk2eEDtou06gD7N+csuadaUQjZ5zRt+QBRCzfC8gxfaGzumCkcsZ1x
         /7Bg==
X-Gm-Message-State: ANoB5plQqSsfXW/KRLJLpvyjyZAtSM7uF7dEpOtazdQBPwTl8yHNYA6Y
        ZkYi5SQwS+QfeC0p7jrm0qU5aC8d2rxlqowjJLb7IWct4dc=
X-Google-Smtp-Source: AA0mqf7Rk7wCtA4/f82Bf4yD7jYLnoZVouyQ4A4+/ghML5Pw/n71edY9C7UBJw5yfA+Tboj7x+97Ige+myLGjQJF3kM=
X-Received: by 2002:a5d:6807:0:b0:241:a2a6:d205 with SMTP id
 w7-20020a5d6807000000b00241a2a6d205mr3731314wru.46.1668763910273; Fri, 18 Nov
 2022 01:31:50 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?6LW15aSP?= <zhaoxiahust@gmail.com>
Date:   Fri, 18 Nov 2022 17:31:38 +0800
Message-ID: <CAO0Zsh+OT_JNZC8OV_cG7LKn2y2ZYM2hm=SAapW5FEub-qa_BA@mail.gmail.com>
Subject: A bug or a feature of CONFIG_HZ on a low clock frequency FPGA
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

  We are running the linux kernel on a FPGA board with 20MHz clock
frequency. If we configure the CONFIG_HZ as 12, the kernel executes
perfectly. However, after configuring the CONFIG_HZ to 250 as a test,
the kernel boot stucks after printing "rcu: Hierarchical SRCU
implementation".

  We added one printk sentence in the timer_interrupt function to
check the next instruction pc stored in regs. It keeps printing the pc
of the replay_soft_interrupts function.

  We guess this is because the timer interrupt happens again when the
kernel is still processing the previous timer interrupt. Thus, the
kernel jmps into timer_interrupt again and again.

  If we are right, are there any guidelines to configure the CONFIG_HZ
based on the hardware platform clock frequency? If we are wrong, how
do we explain the stucking case that we met?


Thanks
Xia
