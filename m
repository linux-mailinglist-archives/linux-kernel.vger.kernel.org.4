Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8C679B33
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjAXOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjAXOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:11:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3642BE0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:11:16 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lp10so11591145pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYhmQqrSkgyrF9GZ22+7sL9SN/b0wagx8GLXitDyd2U=;
        b=Jy5bfsLrbfPFQFniNs4LlQVJdkisvdUlHC6udaMPxF3KSHiPU+biXPZeUyAxrJsiP5
         kJWLT+JcZB3pPDTh9Phye/g8l5WCQbJGlV/7zESwmslLDe1+K3urwdiJpYnrnLgtpT6f
         StH63sfAEdSmqQAxc/wmM9KgwvktWsnpFfk9Uznm+bQh3l3vI1cxToX7Ncqp64j4Fyn0
         Q4c4cRgl1YlRYjFgF1YebSVF7ApWtydEvJPk7Jfnq+HQubaIzaWJMVoZDr8b3pDZWIMV
         vIZydMe0WHii/x+0f877Yfbecx/EleJAqM1Au89StBsHFKntYMNcSbVxk/NjuhymcI+w
         MM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYhmQqrSkgyrF9GZ22+7sL9SN/b0wagx8GLXitDyd2U=;
        b=B038vDFxnbAhFRz7JmeGARgARmXIJ0iYlJWjBeEF+aRE6DO49XfaRxQ+PSXv4QDJAP
         q+7bq/esCQEf6G6rIwY5uU34ZZnmG6BHHMQeYsphL+V3ZOnUwqR3itFW8wb8m1x8M+sW
         JlNcYMmy9N/CIA1vYm7BMkOvHpIGDFY0RK3pNDgrRXX518ydLLOUK2+EEJOh9h5d7wLM
         3ljreQavKzJVrPW73nJ4oeZvaZb3p/x/A44QDeRcpD9Tb/a2pXfSqVV/pC6acLi3FJLA
         Zlu9KBMtJ443g3Q+GwqKJNj5kEd++hypxn+pCym57ca3LlD1qWo+us8380UO4S0qefC0
         bz+A==
X-Gm-Message-State: AFqh2krho2PZ7rsegQOp2rAMjsD0GAhjYv8OW6h/DI/X6fsSkzQeBGTv
        2AmzV7mi1Y0MCUyYY+QAT1WtSg==
X-Google-Smtp-Source: AMrXdXv+MzXrbpWVCUWz6D+hs/wVmEIUHvt1K0VvdnqXqJ0KpBn514vswhg65FyUlI8kwtX5tUs8VQ==
X-Received: by 2002:a17:902:8209:b0:194:a374:31f3 with SMTP id x9-20020a170902820900b00194a37431f3mr7014867pln.3.1674569475625;
        Tue, 24 Jan 2023 06:11:15 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b001960735c652sm1714100plb.169.2023.01.24.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:11:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     asml.silence@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        Tom Rix <trix@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230124125805.630359-1-trix@redhat.com>
References: <20230124125805.630359-1-trix@redhat.com>
Subject: Re: [PATCH] io_uring: initialize count variable to 0
Message-Id: <167456947444.222255.5448115416387284017.b4-ty@kernel.dk>
Date:   Tue, 24 Jan 2023 07:11:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 04:58:05 -0800, Tom Rix wrote:
> The clang build fails with
> io_uring/io_uring.c:1240:3: error: variable 'count' is uninitialized
>   when used here [-Werror,-Wuninitialized]
>   count += handle_tw_list(node, &ctx, &uring_locked, &fake);
>   ^~~~~
> 
> The commit listed in the fixes: removed the initialization of count.
> 
> [...]

Applied, thanks!

[1/1] io_uring: initialize count variable to 0
      commit: 7a9e93db01f44a8d084c93648981cbc1535a734d

Best regards,
-- 
Jens Axboe



