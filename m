Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D36624BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiKJUco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiKJUcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986D1D330
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668112296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ubDOzq2ubfJnUIZlKZc1NgXFcoLakRaKWn8ZApn11x4=;
        b=hEdit3h/fAoOj39puh9r8BV+rtVtMpzFdF1hfvDlio1vhlx/275y38rpEIy8+dOpe8G3i7
        W7G94jZkuM6CctU6ehOLSIgIMYHNaueU8gqXB5BESQ4bIKCVtNPJoWWn0thIAp24SeegFF
        n8ZGwo3C1R7Cdd9dFYtHdYYHjrzpKhs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-360-NHAxEnYBN8itLtkt8Hn-eg-1; Thu, 10 Nov 2022 15:31:35 -0500
X-MC-Unique: NHAxEnYBN8itLtkt8Hn-eg-1
Received: by mail-qk1-f198.google.com with SMTP id bk30-20020a05620a1a1e00b006fb2378c857so2241204qkb.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubDOzq2ubfJnUIZlKZc1NgXFcoLakRaKWn8ZApn11x4=;
        b=pnqz9M/YxD6sEs3uFKhJcD3uxKljezXVnZkZuXyXibezO8WHzBY3vr9b7pp8YERGt9
         S3z3oYzACRuo9SrQdhqQjOw9vXMs75vYSsfSLypUKvLjAAupNnu/dpMK2xDXjGdo402b
         +W3rFp6t74hjN1wLkcdEqk/VDKvXk2/ofaWg+RUqCR32jrnj7NSQVQjlYrvfsKh6IxCk
         +cjQWJRkiYY80AH2pTAW9Q6ViSo6QktDp/sWQVj34ojC4lB/vku6QIqBiXepfK3qdDcx
         3iFKRE1DQK+Tcasn5jlPLwOaq3/M3KpSofxYwS/UXA6uHrKT4BllPkiPxNBcvT6gUnat
         1Kow==
X-Gm-Message-State: ACrzQf2XSe4laJ2OmYRNa20jZmtOKQGLRKKB/oZ5tb5UR5WpVpbvOBlg
        hdT48riAYOKiR2ib4dhUiCAyl/hOO87HMijKKn6IVUM7cIOtYisN1hM8azBNNl09y8OEk+nPwuU
        XpEQyhUo53BF+v398x1pvJYOwxCYH4nheOfB7JfliJOsPXJAnd52CZ0rtk1WIrqWeqvhl8a4lKw
        ==
X-Received: by 2002:a05:620a:2205:b0:6fa:3043:8898 with SMTP id m5-20020a05620a220500b006fa30438898mr1727181qkh.190.1668112294389;
        Thu, 10 Nov 2022 12:31:34 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4mIY18fMNQYUuML70gG70xA3sXTuGbuVM7Mh8CUO5mEiJqzw+XhIsjWLdrKMWQKFYIQRYPqg==
X-Received: by 2002:a05:620a:2205:b0:6fa:3043:8898 with SMTP id m5-20020a05620a220500b006fa30438898mr1727157qkh.190.1668112294088;
        Thu, 10 Nov 2022 12:31:34 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i1-20020ac860c1000000b00399edda03dfsm123588qtm.67.2022.11.10.12.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:31:33 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] mm/migrate: Fix writable pte for read migration entry
Date:   Thu, 10 Nov 2022 15:31:30 -0500
Message-Id: <20221110203132.1498183-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Replace WARN_ON_ONCE with VM_WARN_ON_ONCE in patch 2 [Nadav]

This comes from a report from Ives on using uffd-wp on shmem.  More
information can be found in patch 1 commit message.

Patch 2 added some more sanity check when walking pgtables and when we
convert the ptes into other forms e.g. for migration and swap.  It will
make the error trigger even earlier than the user could notice, meanwhile
nail down the case if it's a wrong pgtable setup.

Ives, I only attached the reported-by tag for you but not tested-by because
the fix patch (patch 1) has a slight change compared to what I sent you
before, but hopefully it should also work for you.  If you want, feel free
to reply directly here if the patch also works for you.

We probably need patch 1 for stable (5.19+).  Please have a look, thanks.

Peter Xu (2):
  mm/migrate: Fix read-only page got writable when recover pte
  mm/uffd: Sanity check write bit for uffd-wp protected ptes

 arch/x86/include/asm/pgtable.h | 16 +++++++++++++++-
 mm/migrate.c                   |  8 +++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.37.3

