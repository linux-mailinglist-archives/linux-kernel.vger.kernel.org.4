Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660855ECC9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiI0THZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiI0THX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:07:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD41C6A5A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:07:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f193so10279070pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TganKE5ujEzwcNzLIUtCyIVdPLaa9W7UwC/PPJN5TMg=;
        b=XKxxvLcIteR4SajvZ6q3lTfxxgv+onl6aCwE3qNraQJKKbQvKUF4KDQh4HHDtDrCqf
         icsI/UANgZaT5cNb94sUvnNT3tewZDV/vfylWxFZIqsXrSpQwS4OJN5WPWevGYnnTybz
         TpWFIqeVCTHkSuYQ/26eFfIcmuQECb/XUJqky7GDOSozTOrhPXYfRh8D4iKh+KAocwMd
         Wb0buyGOgSwY+79UHE4cHqsKPODHfTKHQI1ZWJDvd8eKJ+6tzWjEwwj/LTtuXPywC9pC
         Fz+b9zLoC36sHJkiZCdccZLJ5sdfk8S+Za2DdudqcuSjrQ892ugDa+2udxz+0/kF2a5x
         ykrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TganKE5ujEzwcNzLIUtCyIVdPLaa9W7UwC/PPJN5TMg=;
        b=uUYxu23UaBWUI5+eDU0nyKCE0lIfABAtW++7k684arJRZdcGdll47NsE4THJW4THrm
         rIAwsBbgdtT1bDPpwwxAiJwa9MWwKj95i7e0hAo4xlJtfvxA98sQYAtBA2YsrAW66i7V
         nG/u2YH3ovuKMFvse2MlhKiFBwukRWzPeqR6CY731uXBuh7i7wnE/c1kLh+meFyf3tyq
         jH5j7w5kexXEd9Vy3rO7Ku9xle7nsEtOq99Zfxman0cqzFmZLgk+Tf1k89NnNZaWfjeD
         xIfMfknLypdfNvM0NHf4vBM+lu7zrZcMaWL+qCgm5U2z9Z0hqhWu30xEdV+jBIFNHDfM
         qpZQ==
X-Gm-Message-State: ACrzQf0MZbY7vp1MgWOcRefTg/TB2F5eeQCrNy5odAEdrbG1CkjE8AYc
        +bJZvlURc3PTaxSzIwPQZpE=
X-Google-Smtp-Source: AMsMyM4nwBTr1WtUt3Z7FqBSlx3z1lIHjrRvu5Pe1cwl55ZGnSpGzfT+VszOE8d7Ny197LF3bCQq9A==
X-Received: by 2002:a63:1450:0:b0:439:3806:9b91 with SMTP id 16-20020a631450000000b0043938069b91mr25623673pgu.407.1664305641578;
        Tue, 27 Sep 2022 12:07:21 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b32-d148-19d6-82fa-6094.dynamic-ip6.hinet.net. [2001:b011:20e0:1b32:d148:19d6:82fa:6094])
        by smtp.gmail.com with ESMTPSA id s75-20020a632c4e000000b0042af14719f4sm1900407pgs.51.2022.09.27.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:07:21 -0700 (PDT)
Date:   Wed, 28 Sep 2022 03:07:13 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
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
Subject: Re: [RFC PATCH v2 5/9] mm, pgtable: Add a refcount to PTE table
Message-ID: <YzNJ4byJRZN7vBX8@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-6-shiyn.lin@gmail.com>
 <8C7248F0-55E4-4813-9167-C8CD2D02F1D0@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8C7248F0-55E4-4813-9167-C8CD2D02F1D0@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:59:16PM +0000, Nadav Amit wrote:
> Is there some assumption that pmd_get_pte() would not be called between the
> page_ref_add_unless() and cow_pte_fallback()?
> 
> Hard to know without comments or context.

Yes.
It is one of the corner case that I need to handle it.

Thanks,
Chih-En Lin
