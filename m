Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E755ECD34
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiI0Txw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiI0Txs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:53:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F661E05F7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:53:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so11079453pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=BwxLi034ZmBCXZ/bE4RAvlOWFchcPPbITbc3K0MZeVU=;
        b=YNNVuaRDR5Ft7r8wpzjocZ2lNbS9QN3uhBOhPGelD3X6TgQyvDQLML1Dovg3NSAzB8
         OLJEa3pcWHat4D3ij98oXv6bZD+rh2jiUMrLH3ByjjaaAl6Ym1akPfJH+JeLLqRddv2J
         1ElrkKgCBBx2wxK6EC8KrHYBneZLaEl/oFD5pyDU3g5J41JnZ1yD8xFVU4rh8RJoQb9Y
         eaHPb0zJ4zEc7ME63cxEouR/jN9VJdF4ahi3KLS4Z16CLvHrjqNg8/VjhEcJfje0Ndxe
         Bx9ai8gsQCR/kAd+++m/Tu2sTb5UQ6YeQkZy7nlK61fNvGs+bMql4lUhBguZB+iMlPHp
         YCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BwxLi034ZmBCXZ/bE4RAvlOWFchcPPbITbc3K0MZeVU=;
        b=v7qVVOHMf1CfgHu7riVYI/8tfV/HmAKyA00Jv4jyaMt2SGQ9b158pjGvbx9cJrqJlL
         6gJb+zgNMl1GeJd0rlo6NL+cIzi2/RbK0YmMIBKQt1WAg71e9kL/YypXgLn2D+2GT8zh
         VdjmlCrp+r/tKQEpW5YVBuOqnifRhSVeckPzcVibblm+DDwnb5ypIZOwI3twFEX4Ivwh
         ia26Dwpffy8uWyKmqJngBPJA46bzG26qYa0YzygE9pzAyPbfbbkvTMii+TDdQY2ZCX5i
         e69UODfKNvOU8Ax49ELK75f79M7i8BNrT6FJXVy/KIGHVr6aToK3Cm1gWifHZsNS6nGh
         sMlA==
X-Gm-Message-State: ACrzQf0y84+FCyIzlsdKwhaHsTWD0EQNsCFU9It0aYaon0p+bxU6UBtN
        agbetR3PeFJKUEJG7ViOSf0=
X-Google-Smtp-Source: AMsMyM4CHu2/pYiv8P1vxKyV4EcvlYmqhdWDQ4NwzAQ8C9dImRFHhR6yu58N5tI7CNcAlhm/AttP0Q==
X-Received: by 2002:a17:902:d50e:b0:176:e777:59c4 with SMTP id b14-20020a170902d50e00b00176e77759c4mr28502492plg.82.1664308427019;
        Tue, 27 Sep 2022 12:53:47 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b32-d148-19d6-82fa-6094.dynamic-ip6.hinet.net. [2001:b011:20e0:1b32:d148:19d6:82fa:6094])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a3d0400b002002014039asm8951691pjc.6.2022.09.27.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:53:46 -0700 (PDT)
Date:   Wed, 28 Sep 2022 03:53:39 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
        Li kunyu <kunyu@nfschina.com>,
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
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Message-ID: <YzNUwxU44mq+KnCm@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
 <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 06:38:05PM +0000, Nadav Amit wrote:
> I only skimmed the patches that you sent. The last couple of patches seem a
> bit rough and dirty, so I am sorry to say that I skipped them (too many
> “TODO” and “XXX” for my taste).
> 
> I am sure other will have better feedback than me. I understand there is a
> tradeoff and that this mechanism is mostly for high performance
> snapshotting/forking. It would be beneficial to see whether this mechanism
> can somehow be combined with existing ones (mshare?).

Still thanks for your feedback. :)
I'm looking at the PTE refcount and mshare patches. And, maybe it can
combine with them in the future.

> The code itself can be improved. I found the reasoning about synchronization
> and TLB flushes and synchronizations to be lacking, and the code to seem
> potentially incorrect. Better comments would help, even if the code is
> correct.
> 
> There are additional general questions. For instance, when sharing a
> page-table, do you properly update the refcount/mapcount of the mapped
> pages? And are there any possible interactions with THP?

Since access to those mapped pages will cost a lot of time, and this
will make fork() even have more overhead. It will not update the
refcount/mapcount of the mapped pages.

I'm not familiar with THP right now. But we have a plan for looking
at it to see what will happen with COW PTE.
Currently, I can only say that I prefer to avoid involving the behavior
of huge-page/THP. If there are any ideas here please tell us.

Thanks,
Chih-En Lin
