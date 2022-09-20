Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F85BDAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiITDj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITDjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:39:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA521400A;
        Mon, 19 Sep 2022 20:39:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m3so1907131eda.12;
        Mon, 19 Sep 2022 20:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=G999qRJ3ZYDAwyPJfqHMd90vcXhx8IHao6Ql7QiFPDQ=;
        b=a1adS1ECR642XvCjjjLjLzQ6JfBYYWC6Zjk4Ayb0GPq1HNHS6cqyiHrOVDg6U66sl0
         oRwS5IaWQZ+A5oOC1m7PxvHbKpXhbG7+ITj7+GYBrhpBh9xKw8vK67u8q6EX1Xki8DUo
         CDP74oWnx9ZaM60n/aZKsxAgdaJUVTWMaF9yFWNxcQkdtfYRxgwyEspizTHzaFbOCzgV
         ow1iuQ8bKgJYPcLGUqqzxM7BgkoIsKCZhQGQhb9cCsywveib9s1aSgybsdN2E41GWeXS
         rALuCfC8AzbIeVWaRYMIHWZdHmEgrfViS3GY5sZGLUldXsqTqQIWHrw+E1895ArI8ghu
         cFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=G999qRJ3ZYDAwyPJfqHMd90vcXhx8IHao6Ql7QiFPDQ=;
        b=jm8Fgs0HLPj97TBOxVxZMjXc5lcBeZEjFpgiNMPfmDbOsWb82x1Ri/dDToDmFvWgC5
         y+mueOXZJbSextKT4uj2X0ks5NBcQd4RLvKfmNfwrd67l+IHHayhXgC2AxLv9HyQB3et
         kd6GUYVG52qRgyt3fJjzRqMT4NYWvI5y6KFtOYiMOS3A4RXIieKpn9Nw8iNFjIvFC0Mp
         CIRDqbLEjTjC91yvrVwnlJcke3FhRD0/m4ol3oq/uMzO6RQrOzgtPAVNlPsif/+cURvh
         pgyBSWNxW+IKqY/BB4KG0ga7V3wQ3xxn5ly1CAxzDXOR7U8cjDta28qEPUdKW/LlbDoq
         B2MQ==
X-Gm-Message-State: ACrzQf0iT9Hky+MaZDlUtSltzgWUJHjhhRwLPVnzWWv2VSj/WHUWafUs
        pstEFO0rPjYf7y5lcM8Wikwme+UEzaoKs3SpyVk=
X-Google-Smtp-Source: AMsMyM6UiGVnTD/J8ryFZQsJHTbdkIhpQZQxOdBwdC1toRqikXsXkHg47dV0ojfdIgLd8MUR/GxUavW0TPpgHSHF44M=
X-Received: by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id
 r7-20020aa7cb87000000b0043be6506036mr18386887edt.350.1663645189918; Mon, 19
 Sep 2022 20:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082120.8347-1-yangyicong@huawei.com> <20220822082120.8347-5-yangyicong@huawei.com>
 <302febae-508c-d73e-8676-d51752946645@arm.com>
In-Reply-To: <302febae-508c-d73e-8676-d51752946645@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 20 Sep 2022 15:39:38 +1200
Message-ID: <CAGsJ_4ywwFJFi+q3Ra5UE3twzS9eExtvuXgoGK-8u4c1ZdXCBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 3:00 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 8/22/22 13:51, Yicong Yang wrote:
> > +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> > +{
> > +     return true;
> > +}
>
> This needs to be conditional on systems, where there will be performance
> improvements, and should not just be enabled all the time on all systems.
> num_online_cpus() > X, which does not hold any cpu hotplug lock would be
> a good metric ?

for a small system, i don't see how this patch will help, e.g. cpus <= 4;
so we can actually disable tlb-batch on small systems.
just need to check if we will have any race condition since hotplug will
make the condition true and false dynamically.

Thanks
Barry
