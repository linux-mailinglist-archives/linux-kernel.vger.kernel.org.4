Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5350C5B9257
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIOBtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiIOBsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:48:54 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9D8E4DC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:48:52 -0700 (PDT)
Date:   Thu, 15 Sep 2022 10:48:43 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663206531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=YfBJ/GC8iJydQQDAOa7qVsrlMvw7oRL/3fIgXnJ2x8Q=;
        b=tWXlOsDrBYO+izjXmjHpqkFMxiargiwT8rlf4lp4qGvTMbVb3NinF3u1DU9Kf2g85coPB8
        ghn+CUmEy+1JN7p11ySJ82P3MKuxQNDrtGKS5PH9JO7NYVLVYON+TSdutM3ncB+xKm0do2
        EbW4hkKK4iyoJsb1BaI0ypu0I4Jgfrc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cuibixuan@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm,hwpoison: check mm when killing accessing process
Message-ID: <20220915012626.GA1791458@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220914064935.7851-1-xueshuai@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:49:35PM +0800, Shuai Xue wrote:
> The GHES code calls memory_failure_queue() from IRQ context to queue work
> into workqueue and schedule it on the current CPU. Then the work is
> processed in memory_failure_work_func() by kworker and calls
> memory_failure().
>
> When a page is already poisoned, commit a3f5d80ea401 ("mm,hwpoison: send
> SIGBUS with error virutal address") make memory_failure() call
> kill_accessing_process() that:
>
>     - holds mmap locking of current->mm
>     - does pagetable walk to find the error virtual address
>     - and sends SIGBUS to the current process with error info.
>
> However, the mm of kworker is not valid. Therefore, check mm when killing
> accessing process.
>
> Fixes: a3f5d80ea401 ("mm,hwpoison: send SIGBUS with error virutal address")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thank you for the patch, the fix itself makes sense to me.
I agree with this patch with applying comments from Andrew.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
