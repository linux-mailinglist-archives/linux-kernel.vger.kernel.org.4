Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9B70E3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbjEWROF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbjEWROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:14:01 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7DDFA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:13:59 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77479a531abso33639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862038; x=1687454038;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrI6AYlzjcl4nMmYuLcdi4eM1imL6VrDVKTkn1q3jMY=;
        b=EaskHZIWKhfmS8IaXJ0fv+3NzjgTB0p2sXIvRK+cuWjpfYBpLfsKQ7T5UyOdAPBV2y
         xozstN6igAvnjpKnsifRVbHaOXLq0/8Bxk6BBhW3pO2q2DbTc2446nZH0uA9oIZRfWC0
         OwTat6pdsEZUJaeb6uuZiOA4BikHxkKP5GcmCY14iTS7IsHnLO82VJL9ylYjuKIimLYq
         O5ivonQEJrkd3uG6/6j4dUAclvh+KRRyeqQ0sRQoJfHJProwjOJXCBsFwR5RXa5lzr36
         E8nejmPmAs2irKw4HOrFk1DWT+nj2aJjdaDuTbivmyh0/gfdh2E+o7bWvU6UaH5XwFoc
         /HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862038; x=1687454038;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrI6AYlzjcl4nMmYuLcdi4eM1imL6VrDVKTkn1q3jMY=;
        b=XfAZrz0If96JjO17LZhBxi218UluIK/uqAKfdkAI3iDBnl1IgEqJwk370xSeCrO4rX
         s+mD9e5qNl2WRNEVc6qzHMmxCNhpEhumhzPzi/qkAQ/2K8oWRvRUJ5XWNO4fsm9Fs4Rl
         wm5lJ9TzZRfe81gnPfEqjnzt0p9pfQVRU78O6CPce+J7iIX9Xs5z839sg9kDg4OEqUIf
         yvbJqmREcuSGNEW7O0a3fnK08JjbNIu+YdW4m8bslcvuQv7SM9KuRQNKCDWNmgw/FsZh
         awUGz7sdFN5oGsXph3Ints6UU5CeFUfZVDCfK06hQwGD6Vuw3SUau0tki4Fk79n+Gu2z
         +kTQ==
X-Gm-Message-State: AC+VfDxEufvnDeTxSpKZfYaWQ2dmlrTtcB2tnL/89Kcghmn/EfJ4TZBM
        vX2VGQhFoiFrDmOx0Rj/PS91/cb/KI1KC+U7Xno=
X-Google-Smtp-Source: ACHHUZ6wptu7UX9mfUmDiOvR2N8dvD3PZCw+E50iyN97etGEBhxycMU2e76pg2ObgzKKK2ArTn/Jcw==
X-Received: by 2002:a05:6602:72c:b0:774:83a5:eac7 with SMTP id g12-20020a056602072c00b0077483a5eac7mr1595597iox.2.1684862038373;
        Tue, 23 May 2023 10:13:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Paolo Valente <paolo.valente@unimore.it>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20230523091724.26636-1-paolo.valente@unimore.it>
References: <20230523091724.26636-1-paolo.valente@unimore.it>
Subject: Re: [PATCH] block, bfq: update Paolo's address in maintainer list
Message-Id: <168486203704.398377.7893057179231056095.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 May 2023 11:17:24 +0200, Paolo Valente wrote:
> Current email address of Paolo Valente is no longer valid, use a good one.
> 
> 

Applied, thanks!

[1/1] block, bfq: update Paolo's address in maintainer list
      (no commit info)

Best regards,
-- 
Jens Axboe



