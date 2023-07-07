Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7019A74B874
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjGGVF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjGGVFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F6A1BD2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34CED61A66
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC7FC433C9;
        Fri,  7 Jul 2023 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688763953;
        bh=wIbc8HTUUZfRvfDpoEteNIK4JDXCZ1at/pNiozS117k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z/5k/i7fxqVHgVojMa++l/xaXfNe7dqYCBfHSWAwn5Vvom1hVKoyeOGgvh6Fcejjn
         fjbvugBxpSZwlu5VfZvPb6BcOFzrkKMjmwC/vcygGF2P4J3nC1wdSDfoGf3u2M/Vga
         BNyvpHeP6+4+y2oNjNGrC40yJNDGdMgQ+0UZFSMM=
Date:   Fri, 7 Jul 2023 14:05:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jiaqi Yan <jiaqiyan@google.com>, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb
 folio is raw HWPOISON
Message-Id: <20230707140551.07e06293e4943be0c6c557fe@linux-foundation.org>
In-Reply-To: <ZKh2K7ObVtlXHkTk@casper.infradead.org>
References: <20230707201904.953262-1-jiaqiyan@google.com>
        <20230707201904.953262-3-jiaqiyan@google.com>
        <ZKh2K7ObVtlXHkTk@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 21:31:39 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jul 07, 2023 at 08:19:02PM +0000, Jiaqi Yan wrote:
> > Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a
> 
> This is incorrect naming.  "subpage" was needed before we had the
> folio concept, but it should not be used any more.  We have folios
> and pages now.
> 
> Also, abbreviating "hwpoison" as "hwp" seems like a bad idea to me.
> hwp is already used as an acronym by acpi, intel_pstate, some clock
> drivers, an ethernet driver, and a scsi driver.

Thanks, Matthew.  I'll merge v3 so we hit next -next (which actually
won't be until Monday), and add a note that v4 is expected.

