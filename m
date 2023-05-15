Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E796703B80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbjEOSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244853AbjEOSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:03:10 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EEE1CBBF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:00:44 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1929818d7faso73456030fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684173638; x=1686765638;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0mSaHf0z4H/25tkQER9uB8ytIeulJA6BHDHaGGeScc8=;
        b=W4umkPDOYnX9LBbSIbjR8NqLV96FNNnGrKovk6clhtH+Ob6vVA/thEAIOGKBeslT+4
         WbszT7aF4iGAuXxwF5unWu7UYp5nHO9D4r+3KjLgw+V2B74+eq8A+dWlhcpphfH1hErU
         iXjlu0t5F+2kbJyT4RCcD3e68fxYU1/GUD9LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684173638; x=1686765638;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mSaHf0z4H/25tkQER9uB8ytIeulJA6BHDHaGGeScc8=;
        b=MfhJ6Qmr5WVGs7Nclbc/hX8EuacYfFq9TWWB/gvV5KOy3bQP5Giytq4NI9aXL32ckP
         xWDv2hLE6c4GyJw8RcAIRetAHv1vpThUkyr4np0Je176ppNr1vAXBgU9XpMHDdILdH6s
         HIrZAxwQTcds8Kuj9sRQpTBCPVcMn6AJ4aJ6Mn1lWZavbGM8LQ91A9AuvAUmX/I0urYk
         Wwttw8qjaz9HKjCeG5WbQEBoGLc31WkUj6iAt4zwy4zToWeoSdvd3Yv1cfcjqsiZcIwF
         Ft04gj0/pK9xSCYlcxyEGRMXNDv2unZ8aeyuyaMCY6aU/H7kLbAPywQwClME+xTgjccg
         Yodw==
X-Gm-Message-State: AC+VfDylnLhTvuwUkLcmYkqBTimWXsvxpkyO5AyTbICUcu47SzzRShp9
        rcdchMpJEzsVP6v/D3/9WVOfpCD/hMmTwP/NXzv8HA==
X-Google-Smtp-Source: ACHHUZ5ScY8TBqNcKrDXAoJzX4Fpk+Nh7sNbnwOLqmyOSrrnlSNwpiIoHeOyML3P8/0oaJ0S1WSTakp1dUEkzwA5B5o=
X-Received: by 2002:aca:d885:0:b0:394:441a:6de7 with SMTP id
 p127-20020acad885000000b00394441a6de7mr8548261oig.12.1684173638588; Mon, 15
 May 2023 11:00:38 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 15 May 2023 11:00:27 -0700
Message-ID: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
Subject: mprotect outbound check.
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed there is a slight change for mprotect between 6.1 and 6.4 RC1

For example:
Consider the case below:
1 mmap(0x5000000, PAGE_SIZE,  ...)
2 mprotect(0x5000000, PAGE_SIZE*4, ...)

in 6.1 and before, 2 will fail, and in 6.4 RC1, it will pass.

I know that munmap will accept out-of-bound cases like this (because
memory is freed anyway).

Is this change intentional ?

Thanks!
Best regards,
-Jeff
