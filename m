Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2B6A2086
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBXRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:37:46 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284EB6A78A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:37:45 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id v27so413810vsa.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWzoZiGGKJU76InhrcpfnYDyqrXlTAbTxm3TVdiVpGQ=;
        b=rdlXLkxEkG9cQGBs2asmja/R6u0fRQWO7Lr54YW0AujGE+cnUoZ9o/o73COB3fUhHn
         Y/duNkM3PlYevse6re7o2nFCYYW3PxT23MLPbgvnnggud59/p+ygCbTBrBYFoLwG6DNA
         Hwpmr1HPSsXmIL80Zy0fVi7wfJ6GKqsM1QVfve8jYi0+glaEScOrdCpBe//CXNkOU5Nn
         M0nPUqQTG0S7WR8STO/pkFHcnXKXdfMKSncWQghRBcydDWxCwbsdATp+u3J37lgt2Cap
         9l3VK95sek0xgJ4jOjQrRr/DyWqwoaEqXow7F0PBCEy4AsiONsesXUuYEkvNuxZwQPqv
         Lp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWzoZiGGKJU76InhrcpfnYDyqrXlTAbTxm3TVdiVpGQ=;
        b=WHcz3acy6bMwUjWg3d2FL5eJsYpCKMUEltrJ7qQOYEAnYYfLnSdXTxpdhpPS/9UKsO
         VBwrx0vpP+/F6TUJ+awPaJuRRco/cGPcJmUcA3KFU3fjMyEvatHpdOmKfBVqVNqGUSIz
         o63s+qWEf1j7gQXkPsor3oOj+/QV5O0euVFu6Ti6XFSPnX8sPl85FCbJrxsMya/CBet7
         e7852fY9UCOxM0ue8TZoYM8hrAye8ySfK4vGU4xtRLn0AfezCDE9inV6y+zDRtjERNJj
         e9/IHDYG0MbE+paH99uEiBXzpOz+eh8FwxR9Df+aUOb9ZfWQOmS5lvEtzA194RGUibPW
         s8kA==
X-Gm-Message-State: AO0yUKW/lRFyZ83XL2Pv6AXw/ukNsud3X4MEBCZzPtMFxaaGLQ7o/SKC
        psD5iEJYudSQzyJKwppkcI2z04xb7eiMVumgD9TApg==
X-Google-Smtp-Source: AK7set+CQuj6d6BY8B+pqCObyMjUGt/K6CzwPWQvAyE66Bi1xIcAnW7ZLX/TDZpKnKjRmQLbxzmEq22JsZRrzyqK5Sk=
X-Received: by 2002:ab0:38d3:0:b0:67a:2833:5ceb with SMTP id
 l19-20020ab038d3000000b0067a28335cebmr507770uaw.0.1677260264194; Fri, 24 Feb
 2023 09:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-47-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-47-jthoughton@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 24 Feb 2023 09:37:08 -0800
Message-ID: <CADrL8HVZkzZJCGO2+67248JZz82iqCXfB8UtNFeoFK589KJHmw@mail.gmail.com>
Subject: Re: [PATCH v2 46/46] selftests/mm: add HGM UFFDIO_CONTINUE and
 hwpoison tests
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int test_fork(int uffd, char *primary_map, size_t len)
> +{
> +       int status;
> +       int ret = 0;
> +       pid_t pid;
> +       pthread_t uffd_thd;
> +
> +       /*
> +        * UFFD_FEATURE_EVENT_FORK will put fork event on the userfaultfd,
> +        * which we must read, otherwise we block fork(). Setup a thread to
> +        * read that event now.
> +        *
> +        * Page fault events should result in a SIGBUS, so we expect only a
> +        * single event from the uffd (the fork event).
> +        */
> +       if (read_event_from_uffd(&uffd, &uffd_thd))
> +               return -1;
> +
> +       pid = fork();
> +
> +       if (!pid) {
> +               /*
> +                * Because we have UFFDIO_REGISTER_MODE_WP and
> +                * UFFD_FEATURE_EVENT_FORK, the page tables should be copied
> +                * exactly.
> +                *
> +                * Check that everything except that last 4K has correct
> +                * contents, and then check that the last 4K gets a SIGBUS.
> +                */
> +               printf(PREFIX "child validating...\n");
> +               ret = verify_contents(primary_map, len, false) ||
> +                       test_sigbus(primary_map + len - 1, false);
> +               ret = 0;
> +               exit(ret ? 1 : 0);
> +       } else {
> +               /* wait for the child to finish. */
> +               waitpid(pid, &status, 0);
> +               ret = WEXITSTATUS(status);
> +               if (!ret) {
> +                       printf(PREFIX "parent validating...\n");
> +                       /* Same check as the child. */
> +                       ret = verify_contents(primary_map, len, false) ||
> +                               test_sigbus(primary_map + len - 1, false);
> +                       ret = 0;

I'm not sure how these 'ret = 0's got here -- they will be removed.

> +               }
> +       }

This else block also runs when fork() fails; we need to fail the test instead.

> +
> +       pthread_join(uffd_thd, NULL);
> +       return ret;
> +
> +}
