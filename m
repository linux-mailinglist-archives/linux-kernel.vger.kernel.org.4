Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC21E670F92
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjARBIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjARBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:07:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41603C10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B1/ebhkUYGZ6opiMxC5uXAuUoxAT0QnKaFHjZsBIcyc=; b=FZ7kXWfN+N88S+4scUrAeVj22g
        hbT652X46XnRlozUXq2mpIhoPRAxwhW+1pSEEv559r8EPgFy4TBGYQdGijUcR2l2sjRZ227h8cFUZ
        XngNdqF9Lb+FPZiDo4xqHEQSJbKiuPplejpv3Wn/9SLeswxZ06EUmkACEMSgfC/y4kubqGSnQz124
        U0XUTVQMbe4vJBs04bQylZLRoI7D5/SFTxVKsRxATW/qYcP3KIez66kRreR0/VQJJ5bnY+La+efb4
        sZAXej/TmTN7+RPdWBCHwOu+OGoger6G1yQBuf2a1vt843/1AJM/Ezap1o78kdUyyw2sRDf5fsRfv
        dhuCOO/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHwop-00AD6X-Mu; Wed, 18 Jan 2023 01:00:47 +0000
Date:   Wed, 18 Jan 2023 01:00:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "T.J. Alumbaugh" <talumbau@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
Subject: Re: [PATCH mm-unstable v1 1/7] mm: multi-gen LRU: section for
 working set protection
Message-ID: <Y8dEv/YeZt+TRSlv@casper.infradead.org>
References: <20230118001827.1040870-1-talumbau@google.com>
 <20230118001827.1040870-2-talumbau@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118001827.1040870-2-talumbau@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:18:21AM +0000, T.J. Alumbaugh wrote:
> +++ b/mm/vmscan.c
> @@ -4475,6 +4475,10 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
>  	return true;
>  }
>  
> +/******************************************************************************
> + *                          working set protection
> + ******************************************************************************/
> +
>  static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)

We don't usually do this.  Why do you want to?
