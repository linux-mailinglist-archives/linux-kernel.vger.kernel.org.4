Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FFE6FB519
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjEHQ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjEHQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:29:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AEE6A5D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:29:32 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-518d6f87a47so2138336a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683563371; x=1686155371;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NCAPmpxEboZRCp5DLfCJG8it89iaKWx8exXle5+fDgE=;
        b=A+o0rLnAoFkcu74b0ZTyzM4ELOkmu/fubFOC43V3bUC8SI2ZLvAgDgdLvm7YpNb4iY
         lkDovKqfkqWHqHpHROm2OpwUiBiwkFH0eq41npWZUl0Auxtvlm9TltesUV5gaGCOdjK6
         YZeNqElzkzKVeM4q1kGcoXt0wC6fx/+T09iRE4HSSfLzQrMpX69Es2m2gFqj/lsccwA3
         G+IDS9nQAaFgj/uLiCLVwBBL26UiAwRdZ+quQGoVCbC2LZugLCjsv3wveXeRpElvfrSt
         rbOd8ZsetUR6aYFg8l/NOSvaQOYVs49lC//LrjyPaKtzsYZ8J1y4h8OQcDQgfnmQv9TE
         Esuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683563371; x=1686155371;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCAPmpxEboZRCp5DLfCJG8it89iaKWx8exXle5+fDgE=;
        b=GpGDLHIhakKck5Q+Rt/LaqQ/tyygde+XuNJxW1LHvtAA5uaFMTczWPH5w3zIGzCXeq
         LhrO3fJbbnhRprz+q8XX/Mbeaa5gRrjaKzeVJIF0zIzblMpwh6n6W1WEgcXkfUUnlUIY
         im1FUQEOtFVOP5AYKkb1tdpe/UC9be3VvAIRBco4xFUweTVN79nPq9DkzpuDxHQy9Dka
         YWSJH014PSrK60Xgm9Y2QNCbErZv+O9UJrqqpRvFIVyDiiTbn2qTKIPHopBeUqXgaBnt
         uGphNm2FE7eWUssjZlJI2+sY93S0BeqltcNpZnhH8Qrpe3H0uyPyM/ySKZJq3/f0DSl3
         AYFQ==
X-Gm-Message-State: AC+VfDzp/8qmUdsuSJoLs7mAciXgYgztE5o+X7ULrx8UC1Zgjhx+Ba53
        GXgY2eimtSD19aMgEruS6N965Dv+KUVLZBRl3w==
X-Google-Smtp-Source: ACHHUZ76MdGRZaZii/Tb2tEloQqPEW6qT4wxUIpboq08Bq3SCocGXXbj1z+MFqhm9tKSr2oW8q4lKvAUY4lcbA5McQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:2b04:0:b0:521:62ef:9b38 with SMTP
 id r4-20020a632b04000000b0052162ef9b38mr3198022pgr.3.1683563371206; Mon, 08
 May 2023 09:29:31 -0700 (PDT)
Date:   Mon, 08 May 2023 16:29:29 +0000
In-Reply-To: <20230504001409.GA104105@monkey> (message from Mike Kravetz on
 Wed, 3 May 2023 17:14:09 -0700)
Mime-Version: 1.0
Message-ID: <diqz5y92g51y.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 2/2] fs: hugetlbfs: Fix logic to skip allocation on hit in
 page cache
From:   Ackerley Tng <ackerleytng@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     willy@infradead.org, sidhartha.kumar@oracle.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, jhubbard@nvidia.com, vannapurve@google.com,
        erdemaktas@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



I wrote a selftest to verify the behavior of page_cache_next_miss() and
indeed you are right about the special case.

I'll continue to look into this to figure out why it isn't hitting in
the page cache.

Thanks Mike!
