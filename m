Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1623C6576A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiL1MtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiL1MtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:49:12 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEFAEAF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:49:06 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g16so6303919plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6gDrXdowsD5wNp3NTDHh4ckr3ghwrPSRVQHTuuyLts=;
        b=gSftiTPD/6azNoRXbxwxc2CgGQXghSFW1g3BBzKfH165w6rhBTUqUpdC2BjaiiQT5N
         NLvdRe5UtfFMkoerf4jnB5Z4yo5CQG5TPFGSzdyJQj2ZnPiIdBSvPAtO880PBnBkGL1C
         KE9efK8gsLU7hGrJNhLqZWJPCzN2kbxiQ0E7kIaWN1g//fOwGH0hRoIpvBUIfjuZCmLz
         gKs/ShQK3sl8cVVA8qzBmr5PFZV83Z5wHrbomMpzHq81+xNnqZ8NiPne/uMZeD/DS9Q0
         huxzC6ypJ4fM10jksU3KLr44pxB4EeJWjwXBtzW6TD3UQKOWEJXeabgbGx8s6Bo/kflf
         CLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6gDrXdowsD5wNp3NTDHh4ckr3ghwrPSRVQHTuuyLts=;
        b=sJF175vQ6UeIfSjM+BQp4W3F5Wd2V++/ax6ZugTMwM5P1teaZmZk+tufenV9jaUfvY
         KokB8jlq0iH4L/z3bhl0KuHGYmncKIVL80jdyjmitLpxT18L6rKvuZHZsWeBOFOroNyc
         CXHDycpLYW+omJPWT0U+NkWvsl8ndr7OC+TuyKbuuRBPOqo78d0EFKdhRvPqfiluBdzf
         4J5dSw3AgjYZ0XjPvi/HuBRiBxvcswHoIF4aPEWUrcrcctdNBitrEDZnae9vJQ6Hazr6
         4wDzrG9q/4OdEJeWtLvqPktZJwsIWzgSbCNFQBfW138jvwQqr83FFJMmrW677MpLIJ+A
         yiIA==
X-Gm-Message-State: AFqh2kp7Z7UHExDCKqruyqZPf4nNjUbdrPSp0v7Ds48FZELdz8dJaL1b
        9cHkuM4KGmlMisEG5jFXiG23lnfqez4aig==
X-Google-Smtp-Source: AMrXdXvM9jjVjHMsfATruyxrLdD9AD5DCPMwwg9rYDKq2s+GvIpBHRcNtfEqUmsvCKteAs4csaRjZw==
X-Received: by 2002:a17:90a:3c86:b0:225:dac9:f070 with SMTP id g6-20020a17090a3c8600b00225dac9f070mr14781123pjc.32.1672231745154;
        Wed, 28 Dec 2022 04:49:05 -0800 (PST)
Received: from smtpclient.apple ([2001:2d8:621a:351f:d5bd:4555:ce5f:72f0])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a2a8e00b002187a4dd830sm5538651pjd.46.2022.12.28.04.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:49:04 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 28 Dec 2022 21:48:51 +0900
Subject: [QUESTION] about the maple tree and current status of mmap_lock scalability
Message-Id: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
To:     linux-mm@kvack.org, liam.howlett@oracle.com, willy@infradead.org,
        surenb@google.com, ldufour@linux.ibm.com, michel@lespinasse.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
X-Mailer: iPad Mail (20B82)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello mm folks,

I have a few questions about the current status of mmap_lock scalability.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
What is currently causing the kernel to use mmap_lock to protect the maple t=
ree?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

I understand that the long-term goal is to remove the need for mmap_lock in r=
eaders
while traversing the maple tree, using techniques such as RCU or SPF.
What is the biggest obstacle preventing this from being achieved at this tim=
e?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
How does the maple tree provide RCU-safe manipulation of VMAs?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Is it similar to the approach suggested in the RCUVM paper (replacing the or=
iginal
root node with a new root node that shares most of its nodes and deferring
the freeing of stale nodes using RCU)?

I'm having difficulty understanding the design of the maple tree in this reg=
ard.

[RCUVM paper] https://pdos.csail.mit.edu/papers/rcuvm:asplos12.pdf

Thank you for your time.

---
Hyeonggon=
