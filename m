Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F335ECBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiI0SGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiI0SGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:06:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF4AA349
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:06:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l65so10361254pfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=gldTMiGdSSy+s/mX5olbpKniS/LLCTAFW6jQieMpGNc=;
        b=O4RQnE+kP++cKx/K7Aw550wsJ4fY1C8HC+psA7CQHnY7faIr8roalHlx4b2Ak+Qp/4
         hTTHWqFGCOhM8E7PHekmTZVU2krdXaxiPtW5AbbugelKKlVku0oaSW4HJg27/b33l8rW
         2wFKlszRjdyPQZPoAVEfJYPkeO05TT2yyXLDUVoNNPg6LAKbIEe6WgdqmBJ6c3Vq/nQF
         B0kc9DXK7ArVbcjrkCtI6sph3lGljpXrfFrcZL+4PMeLEv1uo1ioWx7ubdunt4s3qsd5
         DBpRbqWSmWmyY6TYfM9yiH6Rh/xMSZURWoYos9ABnEGH0xRYj/HvK/jChSE17bTHyckW
         +ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gldTMiGdSSy+s/mX5olbpKniS/LLCTAFW6jQieMpGNc=;
        b=LkhpiXo28Mfvu7lEgg+Q1gmSCyOBJzFhGaqM8FIY+CC2xCEY9tzumLqyUI7BCMX002
         T+pZF2gqmXf6knQ+EUo7PLH7gxefX7Vmidd7kRf4ejVaS+TwMQZk+IDA1JI+h72Eb5UM
         scj5Y6maWUZIjPsddv0lQuVhrRbDsqBGQowpVkDcKPHAj9VaOg+6CZU5vG97Xfs+qFQ8
         pvnKTyK7roL0oUP6muNlyj45o+FPm3nuu03//1yTENP2J+CsXuP1QAaAXruHuhwHTTOb
         +ocQplltfbVinOqEImSOofWsOA2LLrsYnY3gIn4696Cmw9UuAil/VGnkovKVmnpEkLlu
         B2OQ==
X-Gm-Message-State: ACrzQf195Q+YaAM7mz9XP9rKz84xpgLTOchlT/8wAz54/uehby8ZLehF
        QXU5qQ2ugf+bU/8yyjZid20=
X-Google-Smtp-Source: AMsMyM67D5l6eCrRorHIp+FxVnOs/2rE6yCoLSkUXLEQ7zNt+/Db1rh6BF5lqhVRxJRmE/Hguv4dPw==
X-Received: by 2002:a63:1546:0:b0:42c:50dc:2115 with SMTP id 6-20020a631546000000b0042c50dc2115mr25819826pgv.613.1664301967508;
        Tue, 27 Sep 2022 11:06:07 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b32-d148-19d6-82fa-6094.dynamic-ip6.hinet.net. [2001:b011:20e0:1b32:d148:19d6:82fa:6094])
        by smtp.gmail.com with ESMTPSA id i8-20020a655b88000000b00434651f9a96sm1821908pgr.15.2022.09.27.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 11:06:06 -0700 (PDT)
Date:   Wed, 28 Sep 2022 02:05:59 +0800
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
Subject: Re: [RFC PATCH v2 2/9] mm: pgtable: Add sysctl to enable COW PTE
Message-ID: <YzM7hxmfCQWxM0aZ@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-3-shiyn.lin@gmail.com>
 <8632896B-35D1-4B8F-8A7F-275DEEBCB962@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8632896B-35D1-4B8F-8A7F-275DEEBCB962@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:27:45PM +0000, Nadav Amit wrote:
> On Sep 27, 2022, at 9:29 AM, Chih-En Lin <shiyn.lin@gmail.com> wrote:
> 
> > Add a new sysctl vm.cow_pte to set MMF_COW_PTE_READY flag for enabling
> > copy-on-write (COW) to the PTE page table during the next time of fork.
> > 
> > Since it has a time gap between using the sysctl to enable the COW PTE
> > and doing the fork, we use two states to determine the task that wants
> > to do COW PTE or already doing it.
> 
> I don’t get why it is needed in general and certainly why sysctl controls
> this behavior.
> 
> IIUC, it sounds that you want prctl and not sysctl for such control. But
> clearly you think that this control is needed because there is a tradeoff.
> Please explain the tradeoff and how users are expected to make a decision
> whether to turn the flag or not.
> 

If applying COW to the page table, it will has a significantly change
to kernel, this is why I think it uses the sysctl at first.
But, prctl might be better a choice.

For the tradeoff. Since, in some cases (like executing the command in
the terminal), enabling COW to page table only will increase the
overhead due to the page fault (break COW). It doesn't have any benefit
from the COW mechanism. So, we let the users decide which process will
enable COW page table.

The expected user usually will be the process that requires a lot of
memory and want to create a new process for an isolated environment.
(e.g., fuzzer, container, etc) So, expand COW to page table may
improves the startup time and memory usage (on-demand allocate memory).

Thanks,
Chih-En Lin
