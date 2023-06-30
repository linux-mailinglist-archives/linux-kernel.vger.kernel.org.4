Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68677443FD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjF3Vjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjF3Vjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:39:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C535B6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wQi8kE1utZmoURCigtdOBC8M6Vwy/ecTHFCV8ZmblqA=; b=Fau6L1/KFNPruKB7rY1tU73Uiv
        isB9eLZGKuMwy8IZ/jSht4PywEmTZDXesH/yEHVbQbrRp8MWSazY/j/JzhSohgByM2GD9QoesUNYx
        uFA8DE84qcdnnAIp4uMlv44kj6NvLDNckUAQHXYyvoB6AjjD6a651BP4KDcCZ3NpCo5oqjrwD5LYM
        f8+Jw/w6gZ4DjBmR6mQtr+Hqc4JszwRBk+J1DeAmHKVCT2/G8RR5+O6rgn5dP2pCT6u1Pvm3HsyX9
        ovweEVVEaU/4KKUjSuQvD2LDVhAx9uS/kp9kh6jo/JFQmH5rDarmuuYmzQKB/DrJT6J5aRQjQ/kBw
        m00ZidjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qFLpu-0062Mp-Tz; Fri, 30 Jun 2023 21:39:26 +0000
Date:   Fri, 30 Jun 2023 22:39:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 0/2] mm: remove page_rmapping()
Message-ID: <ZJ9LjgghNB3osXIO@casper.infradead.org>
References: <20230630121310.165700-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630121310.165700-1-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 08:13:08PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> This minor patch series remove page_rmapping() and convert the last user
> fault_dirty_shared_page() to use a folio.

This patch series works better if you do it in the other order.
First convert the user, then remove the now-unused page_rmapping().

It's almost always a mistake to start with "I want to remove all the
users of API x".  You should be thinking "Here is function y that still
uses pages; I shall convert it to use folios".
