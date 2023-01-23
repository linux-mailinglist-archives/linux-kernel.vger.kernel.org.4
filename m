Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65E677FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjAWPd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWPd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:33:58 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14331A976
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:33:57 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id x26so6598749qkj.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXpxTVFDU/4N2fs9Sln594JhoesX+RwFbstr1NRuPCQ=;
        b=sbEaMWJdzLuzZJrqAulWCafZ/v25sU35s7p+XR5Q35lcuRy0qoeDMp3j0TV2kRvapg
         8mtOxkm1MKMZKsljDphrdfLp84sAc7r3aBZmZwIhNQT5nKqZGHnKNRURsLc9wOnI1kss
         B8+EkojNTf6/t4sAnZf5RZbuv2VmfZSfNNA1yyKNTDrfELaNPTkXYadDkNwxDweTU0RM
         VIMegROguAsCWumyf6c9VDz6HsfhR3Yw4eArM3cdN//p9l49pt9CoxBRmAHl95AisQEu
         O93oyzOziZ/LUIvXnOTkgVrWZ7KuXBxwnWZsulYWmdsxJ0Vhwr6Kz1En4ZGltmba5jEK
         JD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXpxTVFDU/4N2fs9Sln594JhoesX+RwFbstr1NRuPCQ=;
        b=GO8CXdLH3vyvg6auIo/dOABkzWX6yuRpBiRBC7BS9UZB93uumzzm1yTkxdtbx2HoHm
         DZJ+oPcJIqy8Oz5nR4JuylTuHQ/zxhIMRGPeR2OmmnbATCWAoMCPh9jLH35IxnmGJdqB
         pBhP4M8INQAuQuCirsVt9rba/TBaf0wn1OJo+6x+p/z3hXKDsBtDOdiVJumQhUjd1C5E
         0BTBven3YRwJJhf5bIIXEXbvmLYyqdX33HHtgGn4dBHC4uI9tzQKRl10LWMY5zIs0HCK
         ajIM49FpvpTv5iizckT/NE1QgtDCfD8pQ0l8EXQDcmqXuyqJY2p6GHTVSnGpWK31Tjtf
         rkGg==
X-Gm-Message-State: AFqh2kpFF76t96wm2H6JKUel1GrKsKRAa91gJZNNHUTfxM6RLB6Xs2ZY
        PvpgsfzuyjpjsrOVjRX/DIpiozRvcfbJdkvcHTIHIQ==
X-Google-Smtp-Source: AMrXdXtXGJ5Ng4fgxnumc+iIzYvH9ZJpIHxw75ljeHzRjPEolnQJvMLz84YDeOntNGJ8nbxQqaXvsrCkvQry4rYkGR0=
X-Received: by 2002:a05:620a:31a4:b0:706:7050:fbdf with SMTP id
 bi36-20020a05620a31a400b007067050fbdfmr1553646qkb.380.1674488036671; Mon, 23
 Jan 2023 07:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20230113175459.14825-1-james.morse@arm.com> <20230113175459.14825-10-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-10-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 23 Jan 2023 16:33:45 +0100
Message-ID: <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>
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

On Fri, Jan 13, 2023 at 6:56 PM James Morse <james.morse@arm.com> wrote:
> MPAM's cache occupancy counters can take a little while to settle once
> the monitor has been configured. The maximum settling time is described
> to the driver via a firmware table. The value could be large enough
> that it makes sense to sleep.

Would it be easier to return an error when reading the occupancy count
too soon after configuration? On Intel it is already normal for counter
reads to fail on newly-allocated RMIDs.

-Peter
