Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221A670B237
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 01:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjEUXzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 19:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUXzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 19:55:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA14DD2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 16:55:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a950b982d4so198485ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 16:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684713313; x=1687305313;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jmWZnYj5XiM6LuwQooPUrSa5JnI7IaYCNdnUaCT5p8=;
        b=LjoD1KstuPIIbtn1v+hXFZY/oxBCjdRD2KAJeG8eFcGHoZCPMtCF4unnylVTNPd4Rg
         bDeARlb+9q/xXv5BlHRtZaXmElu/9zJhb37LnhE5WjSXuo95xGUmaZbNfngBlosey7kH
         FVyuyWCLaCd61B3diL5tU3jp9WHsK4dDwdzk2hhMUpoLSIcjhTEpQrjTUV+RDEkAxrxC
         dRJXEPEo86FqFy7BSpr7cQiaTJdUh+DLpdlFOT/NzmW/gSnQR/ApJ9312gaoHaayI6sG
         S91ceMwuFF0vvnFxCKY4P4YB2nzNW6VfMLurUFFuFcMJ1YHa6+Zu5Tz3CzSqdg4gyrkQ
         v/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684713313; x=1687305313;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jmWZnYj5XiM6LuwQooPUrSa5JnI7IaYCNdnUaCT5p8=;
        b=fyeZwc34EjjlvIN/UbKi4LEH3hU8lqC420qpoZ3JDE+cgwLz8UkrugsW5EHkAz7xvE
         2tnC/ZPwAyUcHhJ+oG13GRsL6afxm9AIgfaQvHso9EmFO/IQIS3o9gM/9AWiaR73pDoi
         zqsQaydqkOHqiDdTiC2CgTw4uD058tXDFADuCNeBHZjta1gBWT0kBgmTYOd79VgFes0K
         39dCJA6ln64fxDiox+Q0Z0O8TGLhtACtNH3vyCOuwqMaXqQXBp+mkabQOWVoEvlTeuUn
         tcQ0JhFZNaTjCNhoKfrXwUt6z5eRXFQGjlMhQWMItXACQc/H/U84L4TJQ734hxB6Sy2m
         XUAQ==
X-Gm-Message-State: AC+VfDyz0BLUR91OH6cpSTn73nWdKSrpR5FPg0rLwh8+9/6Tp4Hk7C7H
        xERnGiN6Q5lGT8iItFizyD3AYQ==
X-Google-Smtp-Source: ACHHUZ52qhqgQUFh2dm9WwAzD8hKyyemsLBwKJKh9Sv5yolyeGJSUgt5bBQFztmEUqQedhSqmnXbag==
X-Received: by 2002:a17:902:c94e:b0:1af:90ce:5263 with SMTP id i14-20020a170902c94e00b001af90ce5263mr253822pla.26.1684713313037;
        Sun, 21 May 2023 16:55:13 -0700 (PDT)
Received: from [2620:0:1008:11:c77c:12d8:c868:4106] ([2620:0:1008:11:c77c:12d8:c868:4106])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0064d42e66205sm2990168pfi.56.2023.05.21.16.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 16:55:12 -0700 (PDT)
Date:   Sun, 21 May 2023 16:55:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yuanchu Xie <yuanchu@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: pagemap: restrict pagewalk to the requested range
In-Reply-To: <20230515172608.3558391-1-yuanchu@google.com>
Message-ID: <a9fe6da9-f5da-d223-6ed0-fbcea5e3a618@google.com>
References: <20230515172608.3558391-1-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023, Yuanchu Xie wrote:

> The pagewalk in pagemap_read reads one PTE past the end of the requested
> range, and stops when the buffer runs out of space. While it produces
> the right result, the extra read is unnecessary and less performant.
> 
> I timed the following command before and after this patch:
> 	dd count=100000 if=/proc/self/pagemap of=/dev/null
> The results are consistently within 0.001s across 5 runs.
> 
> Before:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0763159 s, 671 MB/s
> 
> real    0m0.078s
> user    0m0.012s
> sys     0m0.065s
> 
> After:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0487928 s, 1.0 GB/s
> 
> real    0m0.050s
> user    0m0.011s
> sys     0m0.039s
> 
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Acked-by: David Rientjes <rientjes@google.com>
