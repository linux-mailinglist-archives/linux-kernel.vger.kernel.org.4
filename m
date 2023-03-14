Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5E6B88A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCNC3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCNC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:29:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37295BD7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:28:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso9137591wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678760915;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xBbJf2nyIau0pTkmGYXVKrw3imLGEtTzPsxp4/AtNZs=;
        b=Y7GySellnDoj5QDl1Ux8iibLv22teOOQB1bQ5s2cGBkSoTL3b/sIV02ykEeI2Mjhnn
         7Wgq4eLV2eiILn5v4BQr1zK+I/suAbmq+Rw3VfzYXNYY0rXiJuah599QFH15DprEcXhP
         iWG20d5XzJ97SGvvpAhT6Spjgt8bwTLSPonAOL21lb7KvOZEpBUhlE4ldsARW6/Shdib
         kmdUZHnMtxYMctPDs+vrpjwR8eRNo4CFct6tbewbjZIhli2iqIcVWkolObtx+dkJBJGm
         eQaGynjPL8PiWy84MSb0sBfPA6QnTQlMwPTGf60mMoEq0YaMGV/6cuXqNK4RKlFWGu9+
         31qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678760915;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBbJf2nyIau0pTkmGYXVKrw3imLGEtTzPsxp4/AtNZs=;
        b=osX7UGviyluVN1ZlSKWWO+YxqZ1XpzMEG6ANbUm0Gx4t7oVxOBFT4PbcHtBXU7I/U0
         hqvRVczgbZEXAP985mKvpPc1OHhhl6J+mVr7gw62xmdxw5cWt06fZVO+06VA3O9PI2Wc
         jvwUyH8MEeq1D76aYTXIUwSlcXdbg2Zpw/Vu5UZWo2AQGvWqgtEyat9bOslnPB+ZBmY1
         PUA3pkkRKL8jjXTghoVQX9G04X9Oc+ISA2t9U8K7R61K37Nc86Zftvyon7WngrP4FjpD
         k3EqcAb2xlsGVci8K45T2s/r2XsZ9tnCeNnZGxeNQYyJSrUqa5hWUsT2xYAQ63Lg1ytf
         Cyqg==
X-Gm-Message-State: AO0yUKWfCMej36BikshxrwnJHnPOTp8Yc4PdiYORYgk3EH/Ehu/YCmec
        xHnbtvUD0LdPSnuuwzIISZXk+eg2lb/q+OY5B0z2q314IOA=
X-Google-Smtp-Source: AK7set/7MQmcfUJ+RS7a32pdng01fXyV9LS18tVqy5Gi8ijb/sXEjM0SUoLu4/ZneWcaHLpCDQoh84xfrd2aNHUF3ts=
X-Received: by 2002:a05:600c:a39a:b0:3df:d852:ee05 with SMTP id
 hn26-20020a05600ca39a00b003dfd852ee05mr3581569wmb.0.1678760914806; Mon, 13
 Mar 2023 19:28:34 -0700 (PDT)
MIME-Version: 1.0
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Tue, 14 Mar 2023 10:28:23 +0800
Message-ID: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
Subject: Question about select and poll system call
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (Sorry, not find the maintainers for this subsystem, so to the lkml)

There're two questions about these system calls:
1. According to https://pubs.opengroup.org/onlinepubs/7908799/xsh/select.html:
ERRORS
[EINVAL]
      The nfds argument is less than 0 or greater than FD_SETSIZE.
But the current implementation in Linux like:
       if (nfds > FD_SETSIZE)
               nfds = FD_SETSIZE
What's the rationale behind this?

2. Can we unify the two different system calls? For example, using
poll(...) to implement the frontend select call(...), is there
something I'm missing for current implementation? The Cons and Pros,
etc

Thanks,
