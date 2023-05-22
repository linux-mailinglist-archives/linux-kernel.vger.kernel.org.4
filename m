Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656E770BB53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjEVLOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjEVLN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:13:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98B340E3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f6e83e12fso476838266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753732; x=1687345732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=98lOxWtkYqQBj7WoU2tuTFhM5XcyeFAlNL/cfpQ20c0=;
        b=AxqvHHenxPjMs45PSZx9ASngS0HYhg47jCFTdR5Z+JF7IQazHIivOhqldO8ooe7+ig
         r4EXDYUO/RuG1YLy/z7bureyBKd2pLbwbfm2nCaiuME9tcvF4fjoaUr/pSzRX9QPUgv3
         9R0UeGTKuUm+4eRPgi1JNijOK4pE/AMxoUOg2t9oZTmCkEjm3ImqMPg04rh9/2pMmjPr
         +HAjeVqB8dH+sTbY0ZbZApCps5noucy9JpxA6Ha+3PcIrHhJk29mSn9LOrL8U9P1F5xY
         JdHjkBz29NAeDn0y6CsnKPEInXY7WaKxwjmj7z5lHgXYDNGZcSifzWj3T36KDl0baHhw
         czvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753732; x=1687345732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98lOxWtkYqQBj7WoU2tuTFhM5XcyeFAlNL/cfpQ20c0=;
        b=bCI3ZPb+h1niUWf+tlyyS5igqwmE+N9K1XaiHoH9Ox1cSP9RE50+8uP2TQjuZiSouT
         nNTCbCNSbu0R3wOjLSYfrPME6KVGEsUEtK5UkmNphhcRsge4MQO8XJZz7GtMyiEOsPde
         hLcYSHB/6nsmMnyS6lRUbb2T2GCGU0VrVxcy4EUpYHjq4JWpqPvj7QDzLcmUK2VSrgTH
         5e8l256Q/c7RclQSyeXHjn/iXxBoN7qOAzJNV813gkqjAw0NiyQXkdmJffq8ABhVlpCX
         oS+wdMWBOyNwRwLcYv4XiJ25Q0vGfVlxlqLAx2Q9v0XoJs9OpSgKA/3BYqEysAy8WZSK
         sPVQ==
X-Gm-Message-State: AC+VfDyW8rOah29o4XEyOPdNUhey8MZnSjfCM0IWKoAUB6V2hEvqN1O6
        6bnM97Uj9oev+gGJAvCtgIs=
X-Google-Smtp-Source: ACHHUZ7k8MSJVFO5RzHe+bEAXiCuxPmpUOxZT7/3wJhShhZW6Rcj+iOaAvFUXzpMyI0xu7XSM+GCiA==
X-Received: by 2002:a17:906:dc93:b0:96f:d235:e1f with SMTP id cs19-20020a170906dc9300b0096fd2350e1fmr3437625ejc.14.1684753732026;
        Mon, 22 May 2023 04:08:52 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:51 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 0/9] Mitigate a vmap lock contention
Date:   Mon, 22 May 2023 13:08:40 +0200
Message-Id: <20230522110849.2921-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, folk.

1. This is a followup of the vmap topic that was highlighted at the LSFMMBPF-2023
conference. This small serial attempts to mitigate the contention across the
vmap/vmalloc code. The problem is described here:

wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf

The material is tagged as a v2 version. It contains extra slides about testing
the throughput, steps and comparison with a current approach.

2. Motivation.

- The vmap code is not scalled to number of CPUs and this should be fixed;
- XFS folk has complained several times that vmalloc might be contented on
  their workloads:

<snip>
commit 8dc9384b7d75012856b02ff44c37566a55fc2abf
Author: Dave Chinner <dchinner@redhat.com>
Date:   Tue Jan 4 17:22:18 2022 -0800

    xfs: reduce kvmalloc overhead for CIL shadow buffers
    
    Oh, let me count the ways that the kvmalloc API sucks dog eggs.
    
    The problem is when we are logging lots of large objects, we hit
    kvmalloc really damn hard with costly order allocations, and
    behaviour utterly sucks:
...
<snip>

- If we align with per-cpu allocator in terms of performance we can
  remove it to simplify the vmap code. Currently we have 3 allocators
  See:

<snip>
/*** Per cpu kva allocator ***/

/*
 * vmap space is limited especially on 32 bit architectures. Ensure there is
 * room for at least 16 percpu vmap blocks per CPU.
 */
/*
 * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be able
 * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
 * instead (we just need a rough idea)
 */
<snip>

3. Test

On my: AMD Ryzen Threadripper 3970X 32-Core Processor, i have below figures:

    1-page     1-page-this-patch
1  0.576131   vs   0.555889
2   2.68376   vs    1.07895
3   4.26502   vs    1.01739
4   6.04306   vs    1.28924
5   8.04786   vs    1.57616
6   9.38844   vs    1.78142
7   9.53481   vs    2.00172
8   10.4609   vs    2.15964
9   10.6089   vs      2.484
10  11.7372   vs    2.40443
11  11.5969   vs    2.71635
12   13.053   vs     2.6162
13  12.2973   vs      2.843
14  13.1429   vs    2.85714
15  13.7348   vs    2.90691
16  14.3687   vs     3.0285
17  14.8823   vs    3.05717
18  14.9571   vs    2.98018
19  14.9127   vs     3.0951
20  16.0786   vs    3.19521
21  15.8055   vs    3.24915
22  16.8087   vs     3.2521
23  16.7298   vs    3.25698
24   17.244   vs    3.36586
25  17.8416   vs    3.39384
26  18.8008   vs    3.40907
27  18.5591   vs     3.5254
28   19.761   vs    3.55468
29    20.06   vs    3.59869
30  20.4353   vs     3.6991
31  20.9082   vs    3.73028
32  21.0865   vs    3.82904

1..32 - is a number of jobs. The results are in usec and is a vmallco()/vfree()
pair throughput.

The series is based on the v6.3 tag and considered as beta version. Please note
it does not support vread() functionality yet. So it means that it is not fully
complete.

Any input/thoughts are welcome.

Uladzislau Rezki (Sony) (9):
  mm: vmalloc: Add va_alloc() helper
  mm: vmalloc: Rename adjust_va_to_fit_type() function
  mm: vmalloc: Move vmap_init_free_space() down in vmalloc.c
  mm: vmalloc: Add a per-CPU-zone infrastructure
  mm: vmalloc: Insert busy-VA per-cpu zone
  mm: vmalloc: Support multiple zones in vmallocinfo
  mm: vmalloc: Insert lazy-VA per-cpu zone
  mm: vmalloc: Offload free_vmap_area_lock global lock
  mm: vmalloc: Scale and activate cvz_size

 mm/vmalloc.c | 641 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 448 insertions(+), 193 deletions(-)

-- 
2.30.2

