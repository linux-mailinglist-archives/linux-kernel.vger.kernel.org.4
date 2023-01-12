Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB246687C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjALXQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjALXQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:16:18 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2417E2A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:16:16 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 200so8771240pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNj8hiHmYECMxQ7rDPxg/ql88u4zYVQ6jg68zWAoduU=;
        b=o3UKieOxKgyc/xo4BYmvsY+C9h/BeuIF3FvDvnUmJeSKP95tl/GoDTgKzbs6GiJH68
         M5HLJuFaLLMphfyZ987JQ5gmqdoeJrN7AvqDKQJAG9/QMHgxUWsCM5NQ09foDNiUrqCw
         HNem62CND1ThzJlmLlNLKWiub6wDOOTmQZ2mAGwM2RUDMPfcHZtQUvQYJhuz7ydFvuMh
         RWIqkeXHFzMulYXBXqgJVOhW5T2MaKeT3mnfaHhHIZpumeplsgBfqfrgYdWes2tozsKk
         zKaL9oG0WM/oJWUc2sTQZTCyXQ/s3g9ozBtNxPyjSm9La5tWL3dp+h2wtNrv9DxcnsWg
         ZjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNj8hiHmYECMxQ7rDPxg/ql88u4zYVQ6jg68zWAoduU=;
        b=iz/lcgy3D1ODEfKP3o1aGvBRszMGh90PGt3MHh2njSrNg9HNip5XRx+0RItbFZ0rO5
         XSjCar8vgnRQnRlYuAk6uKgHrKJ8fZeUVcq+rQQbeWa0HiCgoVkpNwiI/i0/IUq/DZFS
         PlOOF64ixQjR6xmj42tC1ImDTh7lfrn+I5a2pV67K3rw6faZpzsk2HdAmBXAKJ4hoo6V
         R0uiQ0xlOe1Z+ZbmMfZxoVUs2faigsGMo5NSgLedQ9hkU57F1jXXNnZ501uJuNAeuqag
         Tzi7PjvUDJwzHUZjr1+ZkJoMAZi/ohaEXktmkYUgJPfdnbf3xxrBel5sbyupP3F9Pkpa
         FOsw==
X-Gm-Message-State: AFqh2kqAc3m2miNP3mirsmLRj8VUr5gYe3zjWmK44KsgjnjXng71RtBD
        UdVQkoTlx19/4rLGt3VhBxF/MQ==
X-Google-Smtp-Source: AMrXdXsU17qDRodGGHs2H+tRGx4RZMQiFUb57DEDPdbRG7LpDpfQBmmDbDcRfRuPA2EMe09PM3/8FA==
X-Received: by 2002:a62:1695:0:b0:57f:f570:128d with SMTP id 143-20020a621695000000b0057ff570128dmr19435910pfw.1.1673565376231;
        Thu, 12 Jan 2023 15:16:16 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y127-20020a623285000000b0058abddad316sm5689607pfy.209.2023.01.12.15.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:16:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Christian Mazakas <christian.mazakas@gmail.com>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        "io-uring Mailing List" <io-uring@vger.kernel.org>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Jiahao XU <Jiahao_XU@outlook.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>
In-Reply-To: <20230112203452.317648-1-ammar.faizi@intel.com>
References: <20230112203452.317648-1-ammar.faizi@intel.com>
Subject: Re: [PATCH liburing v1] man/io_uring_prep_splice.3: Fix
 description in io_uring_prep_splice() manpage
Message-Id: <167356537481.562725.4943790071828235420.b4-ty@kernel.dk>
Date:   Thu, 12 Jan 2023 16:16:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2023 03:34:52 +0700, Ammar Faizi wrote:
> Commit 55bbe5b71c7d missed a review from Gabriel. It was blindly copied
> from liburing.h comment with just a modification to support manpage
> formatting. Fix that.
> 
> While in there, also fix the liburing.h from which that mistake comes.
> 
> 
> [...]

Applied, thanks!

[1/1] man/io_uring_prep_splice.3: Fix description in io_uring_prep_splice() manpage
      commit: 0df8a379e929641699c2ab1f42de1efd2515b908

Best regards,
-- 
Jens Axboe



