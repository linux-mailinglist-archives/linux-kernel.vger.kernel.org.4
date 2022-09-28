Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027115ED7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiI1Igb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiI1IgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A69DDB9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:36:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b5so11603653pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uwSOve/81KIYjst9n3pRzNvaQgmpZogrRPtc/KOwrbY=;
        b=fVdLIjCzXskYCPFBD7V4kHnhC3YY9gmFDy66aJl80T2WgiPe/7Hi+MfBtayhy+WqL3
         Tzk/Edsy1ghw5D0K6w5Bzfqhh4ts9yfprsNZVdsbY45L9ai9CBbPnkucK3/tVkv5nFDN
         AV3SeWrM90xe6swRhTSqLavbOG5qKsrT43fFBicfeEOlYV7PWtXZoZlGjQAltUXPMUEf
         unDLtZ/cx3ni9i9gAOb/2Sg03j3oPSzefOpYvJSpyIalKoqINrdpHL9uqKnJj/sU8jtb
         L06uoo5v5cjHcKGhj1OaUBg9FTpqzLmSpuDTWS25611Dl80jTfLLeGJSlSty1xgd9RWK
         3qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uwSOve/81KIYjst9n3pRzNvaQgmpZogrRPtc/KOwrbY=;
        b=kk4vW2Qnypc2kmDlW8K8F0uxpXBc7OzWvITzRN9EYJdUeEpBQQsyW5TQ8Sbz4bYlzg
         wSYPuyK8SKfEuLyJVh49Goy/u1PMh1703SPEorhIndV3v5QR16mtg6SIT2yMMkLTm8gm
         Ci+MXCci6KlIqhMXSt6OvZSWLPkH39+mkzXuMlc3jdWLSCMUpJdCkW7Pj5ggxpapfYL7
         k2zR3shkU+NvPy5OJz2KCCxbOSeoSMQ9jiGUbhw1/LKnswUVBAFxdqO079GN63M/0E8P
         4KmjVV9nycBiXVvfEKIY5l4YfyV6yzXCZ2gyN0zgH4fV5bA24O4YgYgdEyGlbxvz9sgl
         71Uw==
X-Gm-Message-State: ACrzQf1f4N+6ZVko8ksbckLsCdKrzehXwluybMFmwp/6qYawVNMiQwLT
        uDkEdw3T7TJRnETNkp6RUqU=
X-Google-Smtp-Source: AMsMyM4ZQHWSb1aqIiBySy0Xbx9HGL0uAAjV9wv/7Ewg+qbpNrsajGsi6IckX04ALplBhcmHudrfmg==
X-Received: by 2002:a63:4a20:0:b0:43c:428d:1783 with SMTP id x32-20020a634a20000000b0043c428d1783mr23129554pga.189.1664354183850;
        Wed, 28 Sep 2022 01:36:23 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b32-d148-19d6-82fa-6094.dynamic-ip6.hinet.net. [2001:b011:20e0:1b32:d148:19d6:82fa:6094])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902e75100b00179eaf275d5sm3067951plf.27.2022.09.28.01.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:36:23 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:36:15 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 2/9] mm: pgtable: Add sysctl to enable COW PTE
Message-ID: <YzQHf8DOogqejrlP@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-3-shiyn.lin@gmail.com>
 <7db06e3d-5e00-2b8e-ea46-fbcdb82c4416@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7db06e3d-5e00-2b8e-ea46-fbcdb82c4416@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:22:27PM -0700, John Hubbard wrote:
> > +extern int sysctl_cow_pte_pid;
>
> So are setting a global value, to a single pid?? Only one pid at a time
> can be set up?
>
> I think that tells you already that there is a huge API problem here.
>
> As the other thread with Nadav said, this is not a sysctl. It wants to
> be a prctl(), at least the way things look so far.

I will change it to use the prctl().
Probably it will be under PR_SET_MM or create a new option.

> > +static void set_cow_pte_task(void)
> > +{
> > +   struct pid *pid;
> > +   struct task_struct *task;
> > +
> > +   pid = find_get_pid(sysctl_cow_pte_pid);
>
> This seems to be missing a corresponding call to put_pid().

Thanks.

> thanks,
>
> --
> John Hubbard
> NVIDIA
>

Best regards,
Chih-En Lin
