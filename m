Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F003470D126
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjEWCXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjEWCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D9E9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31C6A62DE4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010B8C433EF;
        Tue, 23 May 2023 02:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684808560;
        bh=t0TlqsrPLQ6kKMAcLnggv9TuJqf5UkByaXm7KfZhjRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DkMJiMeRwvfJV9cWmQamBI3hShalVJfH72gipXuYRYCiiUD0OYqBxy94BfTkfkqoY
         gKynJOdROCrShe7FWNRxQNQT4b7YAPyKonMHGB/50xjAYMOU5gTFNIP9BmfLuWVUjL
         +acBqGp6Wl0VsJMdZphRNFul+k7KbZgq7JN+z2Jez3O+TM6SSFDHUDUS0qZsdHwPuR
         wmYdTvhjWpR2B0K2wiK8QKsK1T13rqjFDeXXhzMqV/Fhb04/QbN+caUhvDnhnLlEN7
         /+I8CxqkJTpTeSHbVP6TP1WAcEsTFMKd6j29DDmmO+5iRBVGiSkSL5NTBex+WZ742+
         gEqUMuPS5YHvA==
Date:   Mon, 22 May 2023 19:22:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>, <brouer@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net] page_pool: fix inconsistency for
 page_pool_ring_[un]lock()
Message-ID: <20230522192238.28837d1d@kernel.org>
In-Reply-To: <cc64a349-aaf4-9d80-3653-75eeb3032baf@huawei.com>
References: <20230522031714.5089-1-linyunsheng@huawei.com>
        <1fc46094-a72a-f7e4-ef18-15edb0d56233@redhat.com>
        <CAC_iWjJaNuDFZuv1Rv4Yr5Kaj1Wq69txAoLGepvnJT=pY1gaRw@mail.gmail.com>
        <cc64a349-aaf4-9d80-3653-75eeb3032baf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 10:13:14 +0800 Yunsheng Lin wrote:
> On 2023/5/22 19:45, Ilias Apalodimas wrote:
> >> Thanks for spotting and fixing this! :-)  
> 
> It was spotted when implementing the below patch:)
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/168269857929.2191653.13267688321246766547.stgit@firesoul/#25325801
> 
> Do you still working on optimizing the page_pool destroy
> process? If not, do you mind if I carry it on based on
> that?

Not sure what you mean, this patch is a fix and the destroy
optimizations where targeted at net-next. Fix goes in first,
and then after the tree merge on Thu the work in net-next can 
progress.
