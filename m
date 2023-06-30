Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7128F743327
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjF3DZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 23:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjF3DZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:25:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665113598
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7f9d66812so11384145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGZNY/d45qcsqv/6dK9Kz1D5j5tQyoBwHqcnw/3xWks=;
        b=ClO4Qqdk//HiL4nAnF+jD3EXrUP0WC/6JqzrvFwxUaQAnuTb8GhL6XjHKC0M5ZnWer
         q/QyM079DUjYyDDb55dxU0VEZkgtgl707aXs/D3aUAnFICB1gvftBkzo+qbnZ+XHv7Xg
         dpb6aAnBl6WZhLhF8JseLS8FEa3OkLY5IW4HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGZNY/d45qcsqv/6dK9Kz1D5j5tQyoBwHqcnw/3xWks=;
        b=lyuoxQZASABYyOzkfLCGqx6P858wSWfUVoLhWQsT8raFj7V6QZsr3+1nVNQOazrrya
         OfCvilrXUieRMzJk9QXwuIpAeaG0Osw9HlHGYXp+7jggvLCEDHA4+Z5a3RQz6UNw56yI
         We2l41Ig3h9JJET2+XBogFcZShrCZiH0kFV27MuJZZKJnCFklQO0PPkwdovUd1ythhUj
         tV8Lto7nXXBMzdjxgC3rAsxALfnrMrFq/j6nJ6o1kB/cpGB/AMir4W6P5802usfPjEM7
         l3gG5RildgPbRnc0B96pYDQxhxp59/rMJKcsgw90Dh+6PrifaHha4ZkmKK3xSX+TlkJI
         J7zA==
X-Gm-Message-State: ABy/qLb+yvumvSc/HwaLqTRi+klJNj1L5+eEUwHBb2Gqbb1RzNWnOcLE
        zMKy1wEt5mP+vvatDddjg+5TAg==
X-Google-Smtp-Source: APBJJlE7RIil3rQSgYWENbH10+1mHtgxaRDkTD8nyfCULDKfglAL51FCHofXxyxl+cjgtq0ZR5dd4Q==
X-Received: by 2002:a17:902:d2cd:b0:1b8:16c7:a786 with SMTP id n13-20020a170902d2cd00b001b816c7a786mr1379879plc.4.1688095537808;
        Thu, 29 Jun 2023 20:25:37 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id x3-20020a1709027c0300b001ae5d21f760sm9728322pll.146.2023.06.29.20.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:25:37 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/1]  Add documentation for sysctl vm.memfd_noexec
Date:   Fri, 30 Jun 2023 03:25:34 +0000
Message-ID: <20230630032535.625390-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add documentation for sysctl vm.memfd_noexec

Thanks to Dominique Martinet <asmadeus@codewreck.org> who reported this.
see [1] for context.

[1] https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/

V3: resend V2 with cover letter.
V2: revise.
V1: initial version.

Jeff Xu (1):
  Documentation: mm/memfd: vm.memfd_noexec

 Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.41.0.255.g8b1d071c50-goog

