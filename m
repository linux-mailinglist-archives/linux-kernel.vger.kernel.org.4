Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4A6BBE17
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjCOUoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjCOUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:44:08 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA361AA4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:44:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b5so8409419iow.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678913042; x=1681505042;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVbNewAl7WWQFUh8x7OTgNmK/vzQ9xLJ0WJgN2KttLs=;
        b=xJX9LGUwOvMWE7joYraKjr2s0OzNFpuSrdXTgEIbalYG3hqkIUWuQFTer8vqf6Q47F
         W55qjVyK1A5rsJW5ZV8HuUmjCTj/CPYcxopnhw0qWTiWB+gvy1akH9Y1pTARcDWYM77j
         XouegIgBBMf7Glbk5eWBhyQoGZSGBFhFwt8oziIEvD2G6IxprMC3Kdh3Bs04r0+8p9fl
         7C04+p4FP526BGLw+JH+We3mbtGTTquhftCtCCR7qk1kvbp5wzxiDNn80f6rq0hZqoJi
         fJt8/hMeCei4u4nzcxsLgioxxlOF2yFokdMHhpEc3uAs83O5oQAg3rj2xCVoP9AUAD4j
         DPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913042; x=1681505042;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVbNewAl7WWQFUh8x7OTgNmK/vzQ9xLJ0WJgN2KttLs=;
        b=GMzYPILzY2s5CTyuIIyX6bOl6Ok87fNYbTK2pG/M09E2vZOoRFZyUh0OrfypoCn+qM
         4aytm70qT6cPfU+W6TE4XRgfQli5TWyJn5+srskbPe58Rc3b369LNiDSfV3qc+1apAPN
         Ttrf3QAdtsBuh4kRZNYAM++fLtm+R2RH2z8RfH/xmcS9CS13Msvc07v35YNHOVasSu3z
         0RiwXDHGY8Yi6dfF+4i9YfIdJbOhFjtz/Oh4zFbiwOlHjt7Rr+9/DYtE+sd4FjJ8sVCz
         qGIcb2c250XFCfHoSSzZ1NAXMW1HDL3XKkn6HAJiz0kWnCF2Ic/wEuWSij3gQE+s1Pzb
         kx3A==
X-Gm-Message-State: AO0yUKWvq+HamcBcKDnUbMt9taE84d6DNMJ4oVS3tEeh3GjJG84xgBdc
        HJX473SDTaIwCQPgE/X7ycqdQQ==
X-Google-Smtp-Source: AK7set9LtBdTc4/XsJuNiuOKLjpH7H3YT2JgHVR8skcSmqPXD1A5qP0Mk2LMrGia7Hcd1cBsnFTpYQ==
X-Received: by 2002:a6b:6e08:0:b0:74e:8718:a174 with SMTP id d8-20020a6b6e08000000b0074e8718a174mr2501465ioh.1.1678913042658;
        Wed, 15 Mar 2023 13:44:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c21-20020a02a615000000b0040618ad53aesm835924jam.31.2023.03.15.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 13:44:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        Breno Leitao <leitao@debian.org>
Cc:     leit@fb.com, linux-kernel@vger.kernel.org
In-Reply-To: <20230310201107.4020580-1-leitao@debian.org>
References: <20230310201107.4020580-1-leitao@debian.org>
Subject: Re: [PATCH] io_uring: One wqe per wq
Message-Id: <167891304198.106283.16674521434746961243.b4-ty@kernel.dk>
Date:   Wed, 15 Mar 2023 14:44:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Mar 2023 12:11:07 -0800, Breno Leitao wrote:
> Right now io_wq allocates one io_wqe per NUMA node.  As io_wq is now
> bound to a task, the task basically uses only the NUMA local io_wqe, and
> almost never changes NUMA nodes, thus, the other wqes are mostly
> unused.
> 
> Allocate just one io_wqe embedded into io_wq, and uses all possible cpus
> (cpu_possible_mask) in the io_wqe->cpumask.
> 
> [...]

Applied, thanks!

[1/1] io_uring: One wqe per wq
      commit: c122b27ea454f5f8ed3066964c67e9aea4e11fc8

Best regards,
-- 
Jens Axboe



