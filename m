Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37416387B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKYKmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:42:01 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E820043AF4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:41:59 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q7so4694478ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FsdyF22Jd1SmNdZVco6Z+UYx7zskrJpALmeloXVwY24=;
        b=NV+dXmBbaB4hNo9Yc5iLiBeuwwF6pwZqbU5DI1obYKp7AFo1JUQZhZvw6EGsYXlRLk
         nisk3lKSUpoHTLo3hZ6WNo5UvI+PH4bVTaR6BXqoV8CVxKTkkZ+hIYWg7+scKqsDBXrc
         9HPew8UtNQi3kdT3DboDJDfhNkToZmtKY+KsCIsP6iK394P2Z9CUPHKX0eF5i2d/dtau
         XDfGc/iuAEg9vRUvgOFEhijjQqXgAuWTko1yX0KzJis0QOZVbgFK67X5z7kM8zLj+2Ze
         HwZskjCVDpsVeUicaMVCBVNG6bneZ38BGAPlMUSmfzbSEaBIYlXP7UM7K+lQ49j4zxMW
         G7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsdyF22Jd1SmNdZVco6Z+UYx7zskrJpALmeloXVwY24=;
        b=EtvxNzSKn5vg3Eaq4CFBNPm2kCZytZlZUQ3SRawEt9zIqnOmvekx0QaNbOxDxpbBRt
         WZ2/Uxf1gErV+mypxDBtHrRiZbVxDqjpnmCJAAJWNjUicON3W4xxJYuRu1mrByN3DhjD
         scCz2jN3m9qgiAPhv9724uu/oXELKrUY8N3UY5Q0/j/o8As1xAvM7DFRDGgPTyYrG6Nt
         rzAKbeJkBTVQvahnmK1SghZ2IsigXt4W3cp+XR1Y+uU/npevTFr8kiR+x1cU9KHJx5xE
         U/skVaR9qS8lq6w+Eof8aNSSncwfk2MQdXM4GcEHOGKONYUI0lrBTVRtBVKNx+V6ioyb
         +bgg==
X-Gm-Message-State: ANoB5pkicrtRUHtzCVgDzmrGFCDci2lS/YHAzvJYlOhOkm6O+4MJq534
        unfSjIac2moC6dZeQ4JKOMxv+j0aTUkrJFGVQrM=
X-Google-Smtp-Source: AA0mqf4YvBrEKGFHWA6OAJ8H9MO+PD9RXFe8yPcjNSp3hYZPG5u92Koq1cs+EzjZpM862eItB/EKseJGQOCjO+hxo5M=
X-Received: by 2002:a2e:a4c9:0:b0:279:4bb9:bb51 with SMTP id
 p9-20020a2ea4c9000000b002794bb9bb51mr6996322ljm.28.1669372917958; Fri, 25 Nov
 2022 02:41:57 -0800 (PST)
MIME-Version: 1.0
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Fri, 25 Nov 2022 19:41:46 +0900
Message-ID: <CAM7-yPTWs8J6sGjcyDrRsXu5APDHm5Kr19G500y=72=FwYCq3g@mail.gmail.com>
Subject: [Question] About UNWIND_HINT_ENTRY on entry_SYSCALL_64.
To:     jpoimboe@kernel.org, peterz@infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

While I try to see the information related to ORC in vmlinux,
I'm trying to find out ORC information related to entry_SYSCALL_64's address.

For this, I've tried to take the following step:
    1. booting the kernel with the "nokaslr" option.
    2. Getting ORC information by "objdump orc dump vmlinux"
    3. cat /proc/kallsyms and check the address of "entry_SYSCALL_64"
          - In my kernel, It's address .text + a00000
    4. Find out related ORC entry gotten in step 2.

But, I couldn't find the reason why entry_SYSCALL_64's orc info isn't
encoded with end =1.
Instead, It was encoded as INVALID ORC entry like:

  .text+a00000: sp:(und) bp:(und) type:call end:0

IIUC, Some of the code is started with UNWIND_HINT_ENTRY or UNWIND_HINT_EMPTY,
it should be encoded with end = 1. But it doesn't.

Am I wrong?


-- 
Sincerely,
Levi
