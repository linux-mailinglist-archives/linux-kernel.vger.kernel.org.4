Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF7634D97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiKWCID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiKWCIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:08:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1294C753
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 622E7B81E4A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CF9C433D7;
        Wed, 23 Nov 2022 02:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669169277;
        bh=IVgh5S5eiXF+LTyDjfjNqQUhbZ6tDAFYNBQWdojMtuQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pyTZYZZOWLwsX9wWjy5I6sqD5qGqICPH6astc9/IzZACiKzL+1bBmn89lMpKFut3S
         daPnWM1jpU21rlfMD0GZs2ayJvsnt5pw4oMZqS5KOAgrcgGCcwUHmQ4NtmoYxQ8hK3
         hCh28xzGYpFBf4UHN2VAVDRa+5wcPk1vPuY5Vd2o=
Date:   Tue, 22 Nov 2022 18:07:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v10 0/3] fix hugetlb MADV_DONTNEED vma_lock handling
Message-Id: <20221122180755.86a7a0b68932226b7d40dad6@linux-foundation.org>
In-Reply-To: <20221114235507.294320-1-mike.kravetz@oracle.com>
References: <20221114235507.294320-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could this series be implicated in
https://lkml.kernel.org/r/00000000000041a69905edf8c1e3@google.com?
