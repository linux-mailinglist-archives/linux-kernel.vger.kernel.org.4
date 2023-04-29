Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11DE6F24BF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjD2NC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjD2NC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:02:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD51FD5;
        Sat, 29 Apr 2023 06:02:54 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b603bb360so734069a12.2;
        Sat, 29 Apr 2023 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682773373; x=1685365373;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6xKCB+Y3CcsCy3CtAOFIYxIvy2+5Tg1PPE+Nps9RFE=;
        b=IvmbQGzFi0l/yBeHU+1xyZQokwY+0w0SKzYHzMSqvBPBqVdEi2zkw9+aApnhQBgZCn
         CJIkS5nVXOaKn2yvRd0TOIHfOEN0iewNVf/kWSOHFzD9Tv9nfIrUrFbJYu1zhqySRNf0
         xJOlgYj1/ZsmL2z4Y1a+EDCWBFDXF7WOC+Qve0AI6cg+TCCXBMENUMWCKJyhmDPEs3fW
         6QQKzYIw8d4Ziyk0itYnUFxyvi+tZasX0NZcri53Dxbra891ZSI9vcxqLLPT7L54N7f5
         RpNX3VmJqlTVCftXIa3CWKbH7wtFm8QIL9uG8WdTIa3sny53S1VUhBjeavL4C2RR6oQJ
         e1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682773373; x=1685365373;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j6xKCB+Y3CcsCy3CtAOFIYxIvy2+5Tg1PPE+Nps9RFE=;
        b=fF9HEinz0Y7vQMXra22w3gKiVxo7S/Id++izEPMqFhQOS8p7MqlGuWy+BOlfOQhRz7
         +4iBUz5IMzom8Yo841QkWkNgS0CNFvrfbUT0a4i0idZbF0DTXC+VVvsoujDJfvd08vCQ
         viIHR4rXbVwbbU+LYkxJ9Zcjw1M3Zt/QyTldxp+b95RIMIgKQP18wbLBoiHZIYK1S15x
         pPaBwBOWJMSVv4C5QKfH6LAItvhA+zY+jk1yc4A5IPJ/QaBcEYsEUb7GBy2hGa9+zI1a
         9UvfOH+Fsv6sdFPtsaFatHXLOe7Jb7tOGKCY5UlQnDqMENPas+nSGTat7X8u+RwQJQwO
         diJw==
X-Gm-Message-State: AC+VfDwwzACRoFnjT6pEF40NUQvyp01ehBCW62CIF0y0aUlkkwlxyWl9
        V0VVBzAMV5JZsGdQHCtfZzQJaPTwJ0KRGg==
X-Google-Smtp-Source: ACHHUZ53yPM/g9mUgOcEHxX5VcxQNGdtOGutE6AqmReyf1VIgPqUBT9CFgzT/Q9gJLkIyQLA+RRlPQ==
X-Received: by 2002:a05:6a20:7da6:b0:f8:ea21:7c37 with SMTP id v38-20020a056a207da600b000f8ea217c37mr7658493pzj.20.1682773373531;
        Sat, 29 Apr 2023 06:02:53 -0700 (PDT)
Received: from [192.168.1.10] (pon087-250.kcn.ne.jp. [61.89.50.250])
        by smtp.gmail.com with ESMTPSA id e27-20020a630f1b000000b00502e7115cbdsm6553736pgl.51.2023.04.29.06.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 06:02:52 -0700 (PDT)
Message-ID: <a68fca00-666a-bbf4-b4d3-acd409dd69d2@gmail.com>
Date:   Sat, 29 Apr 2023 22:02:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>
From:   Ryo Munakata <ryomnktml@gmail.com>
Subject: Rust ENC28J60 ethernet driver working on Raspberry Pi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've written an ethernet driver for ENC28J60, a stand-alone ethernet 
controller with a SPI interface, in Rust.
It works fine on Raspberry Pi 4B with Raspbian AArch64.
You can connect to the internet and play some videos on YouTube with it 
(10BASE-T though).
I hope it will be an example of real-world drivers in Rust.

* ENC28J60 ethernet driver in Rust
enc28j60rs: https://github.com/pfpacket/enc28j60rs
`impl Sync/Send`, mostly because of raw pointers, and the initialization 
of `workqueue::Work` and `sync::Spinlock`
require a tiny bit of "unsafe" code, but otherwise no unsafe code used.

* The forked kernel with Rust support for SPI and netdev
https://github.com/pfpacket/linux-rpi-rust/tree/rust-netdev
Forked from the Raspberry Pi tree and merged Rust-for-Linux `rust` 
branch into it.
(BTW are there any easier way to get Rust-for-Linux work on Raspberry 
Pi? If so please let me know.)
Then I added the SPI support referencing rust/kernel/platform.rs and 
netdev support.
The netdev support is based on the following GitHub PR from Fujita-san:
https://github.com/Rust-for-Linux/linux/pull/908

Regards,
Ryo Munakata
