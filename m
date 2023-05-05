Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77936F7C78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjEEFkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEFku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A017A1FE1
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 22:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683265199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=B7kVUYKilEKC1sSmEWakcXvmq4DsPQRiV4ukNCTywSc=;
        b=Xm2BF87MonuEAxF7cIMUenCAko/atMdhGRD2ZxTrI897+S+l2CyarlQbtRcZ7ZIBc7U2Yj
        ZAZ6J22aAdsHUeQf2Obx5vCsWoPV0qspmgHl1+SuaCtgqZcyU0qRdo1Z1ZJKLXiy7NTeia
        27lOc6YsM6U0lcqpabCSByDwhR1GHNs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-33TQ21VBP8O2GGhmsZ_xww-1; Fri, 05 May 2023 01:39:58 -0400
X-MC-Unique: 33TQ21VBP8O2GGhmsZ_xww-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-38e279dfb65so968817b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 22:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683265197; x=1685857197;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7kVUYKilEKC1sSmEWakcXvmq4DsPQRiV4ukNCTywSc=;
        b=MbXpNXZHhuXcWUaazkYtnat2MLjLm0XlD9OVWZcbdJQAgYlDfT8w+j7QUoRiARxovV
         Icc590nrcOgCr+NQTFC5DUhyV9nONB2RpAMOugB/beFh4Z6uVLFTXUmzTl2jbfzX6Eda
         A7dpx7myhNjb8ijhKhZUfJDkPY29Y5tL6uuUihhS4LkSZGpLMsytnq3ADT6ocXaOrV7l
         4mFrL7bBKobuZtWHMvE/jJ/n/0vQEvxMDn6w4f8L/FbNX6mGet7aGQlhKJLpr3hpVkf/
         kEel9wYegC3pZpF14QqZAB44LK2UaKG10nfdBNhZDcOD/95e+Z6o3mPfjgSudG63apfe
         n1Aw==
X-Gm-Message-State: AC+VfDzNecx5s0atnvElLfTBiiRmwbfQbGkzoCOyw3W9Ru9MqEZUEZlI
        /XacLvJQ/eczR4B6pFxkNo30QfCo8ZY0TRQaGB49i/OYQ2e+hmHNF0pAmjlZ/xDdx5oYY3sCylB
        ZG84KGa4EfZA+c6hPZaSm4hLmxBrhTT9zmjitvic6
X-Received: by 2002:a05:6808:150:b0:38d:ce1e:306e with SMTP id h16-20020a056808015000b0038dce1e306emr34752oie.34.1683265197609;
        Thu, 04 May 2023 22:39:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4evgGa3yxWmOKvDQyUe48IQ3fGoJnCZIUnXAFsqCW728s0O5cb4DUrp8vPlNnfa6aHS5mgHxkgCo3kPf4R30A=
X-Received: by 2002:a05:6808:150:b0:38d:ce1e:306e with SMTP id
 h16-20020a056808015000b0038dce1e306emr34749oie.34.1683265197395; Thu, 04 May
 2023 22:39:57 -0700 (PDT)
MIME-Version: 1.0
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Fri, 5 May 2023 08:39:46 +0300
Message-ID: <CADDUTFy29Cn6y56XLB-me0FneXrMED0LuHLb-7KD_NoiXZSZrg@mail.gmail.com>
Subject: confusing documentation about Development Process
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are five topics named "Development Process" or "Working with the
development community" or both.

It is clear that these topics are related to the development. Some
content is overlapping.

Questions:
- Is it by design or chance?
- What are the principal differences between the topics?
- Are there any outdated documents?
- How should it be?


References:

"Working with the development community":
https://docs.kernel.org/index.html#working-with-the-development-community

- "All development-process docs" linked to "Working with the kernel
development" community: https://docs.kernel.org/process/index.html

-  - "How the development process works":
https://docs.kernel.org/process/2.Process.html

- "A guide to the Kernel Development Process":
https://docs.kernel.org/process/development-process.html

Development tools and processes:
https://docs.kernel.org/index.html#development-tools-and-processes

Thanks,
Costa

