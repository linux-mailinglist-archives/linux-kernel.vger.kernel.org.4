Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC94B74A81B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGGA26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjGGA25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:28:57 -0400
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B071992
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 17:28:56 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:28:41 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688689731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lsh6MjdQ0KBHzuwAeoaHvgzWnP9TaDfDS/YmZHIn9sU=;
        b=D+NHfSZJ7dtg6xct7bIgm2tX7On2PzW4RmxD2jBqXPb6KzZs9dEwU7UojNDj6ZjajJnpo3
        BxYvND1K6/jGPcrUM8/Z0UYtOsskMuuGrYxh+WXYsptindqWkBxWmfgx0QAprv77nn34qo
        sX7ASyPSDGKTrFy34JZd1tMMSyrG31k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duenwen@google.com, axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 3/4] hugetlbfs: improve read HWPOISON hugepage
Message-ID: <20230707002841.GA72816@ik1-406-35019.vs.sakura.ne.jp>
References: <20230623164015.3431990-1-jiaqiyan@google.com>
 <20230623164015.3431990-4-jiaqiyan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623164015.3431990-4-jiaqiyan@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 04:40:14PM +0000, Jiaqi Yan wrote:
> When a hugepage contains HWPOISON pages, read() fails to read any byte
> of the hugepage and returns -EIO, although many bytes in the HWPOISON
> hugepage are readable.
> 
> Improve this by allowing hugetlbfs_read_iter returns as many bytes as
> possible. For a requested range [offset, offset + len) that contains
> HWPOISON page, return [offset, first HWPOISON page addr); the next read
> attempt will fail and return -EIO.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

Looks good to me.

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
