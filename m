Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36E6BF4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCQV6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCQV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:58:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10BA37B73
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:58:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o7so5647699wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679090311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5Vf9hPk4TijoCslag2qu8Bydr8Y3MLZgxsiyraFWDI=;
        b=GesoOYtkRvZvc8UDZKdCOVv0bjs87Z0DM/cCHzjncbj1wX0MSojd2K6jf+QesOuh5Q
         kZCmczsOpxAvQxJ/szlpbti5EhBsTBHiB8u5bpuRmtYYcTJAjo9FTQACwgEcjoEffI13
         9zI+fXO1DsSlQnmy2LnosY9x9FRHintSA5ITqXFnLW/ta0bMBArTS9ybGrRmbc3+GkLt
         XGPZrxMgyHGMLYdJ/0byP30lidX6IHuMG+51aEfrZVqs6+m+Q/VdSjwtAX/jaUXhoFDT
         bLm+KGk5Mksuz/kRewHry8LFRV6rodlbgmrXtijDCcxwKp5lCtWckhzm+U5QQwwmP9EQ
         37Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679090311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5Vf9hPk4TijoCslag2qu8Bydr8Y3MLZgxsiyraFWDI=;
        b=c+MrdvfuNiac4kW7B/pvWCgI45Kw8ePYDKqJsuZIS+xWvZ0qo1O47muj/2Sl0TLZra
         0iW1hyHaxgirzBQGJUYaKcGGnvmunbZPnztZnr15guRy87vCjPKP4OWPMR/9NOR3Xxtn
         o34vgEFecNclq3MT9LXSNE9niOKLZ8Dc8ckIfY3XfU+tESmVQpl9/KNUSelTwuSFH5gQ
         FdfeCI6m4B7OII8qW0Z/4B2myzuPiFMtSe9clxs6HJvkOEj8Co+i2i4ksAzmSoau53PM
         5UfqwyVPxcUz33vh06obOgZgEt39rr3hq+4CYMtLjN0ZiSYfwTblcf6hsEQNB4tGS4fL
         kViQ==
X-Gm-Message-State: AO0yUKWCniRaDAQV4HTmtO7NwvSu7/WA8s3RloCQuxAwc7bePyLXprI1
        s+jJdeZlcPmlT/1RFhM2T90=
X-Google-Smtp-Source: AK7set/0giHP1Q0iPR9xqaXyDpTJ/ztJWRNNYrWVJ0+w4kQpByF/HxcMY6MvBXLY5FhRiRmI///LxA==
X-Received: by 2002:a5d:6944:0:b0:2c5:4c9d:2dab with SMTP id r4-20020a5d6944000000b002c54c9d2dabmr3807112wrw.10.1679090310797;
        Fri, 17 Mar 2023 14:58:30 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm2849757wrt.110.2023.03.17.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:58:29 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 0/2] Refactor do_fault_around()
Date:   Fri, 17 Mar 2023 21:58:24 +0000
Message-Id: <cover.1679089214.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor do_fault_around() to avoid bitwise tricks and arather difficult to
follow logic.  Additionally, prefer fault_around_pages to
fault_around_bytes as the operations are performed at a base page
granularity.

I have run this code against a small program I wrote which generates
significant input data and compares output with the original function to
ensure that it behaves the same as the old code across varying vmf, vma and
fault_around_pages inputs.

Lorenzo Stoakes (2):
  mm: refactor do_fault_around()
  mm: pefer fault_around_pages to fault_around_bytes

 mm/memory.c | 62 ++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

--
2.39.2
