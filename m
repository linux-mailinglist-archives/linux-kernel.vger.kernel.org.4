Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A73726FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjFGVAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbjFGVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734CE2109
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B1E2648CC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2252BC433D2;
        Wed,  7 Jun 2023 21:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686171602;
        bh=K7QsNx354p5UJb+W0jt0jJmIo1DtPxXeGq1FHy48xWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KTNvxPinFizEuJn1y1ca+OL7HSvTz45fSL1nS4DIvD+mRfKBSBF+XQsXofn0uAWLw
         Cm9GZS4khbbCdQlp00yyEJPPiS6HTZ5LXu/afx0eqEv2zq4yCcTz2jcQkzb3crBfLf
         mwoI4754n1XsqP8Oqd8DCAaT0ZMyvzV3fKt5xAJg=
Date:   Wed, 7 Jun 2023 14:00:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        jmarchan@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Dongwon Kim <dongwon.kim@intel.com>,
        James Houghton <jthoughton@google.com>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm: fix hugetlb page unmap count balance issue
Message-Id: <20230607140001.6685b0a058511f125a005da4@linux-foundation.org>
In-Reply-To: <20230607205310.GA4122@monkey>
References: <20230512072036.1027784-1-junxiao.chang@intel.com>
        <CADrL8HV25JyeaT=peaR7NWhUiaBz8LzpyFosYZ3_0ACt+twU6w@mail.gmail.com>
        <20230512232947.GA3927@monkey>
        <20230515170259.GA3848@monkey>
        <20230516223440.GA30624@monkey>
        <20230607120312.6da5cea7677ec1a3da35b92c@linux-foundation.org>
        <20230607205310.GA4122@monkey>
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

On Wed, 7 Jun 2023 13:53:10 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > 
> > BUGs aren't good.  Can we please find a way to push this along?
> > 
> > Have we heard anything from any udmabuf people?
> > 
> 
> I have not heard anything.  When this issue popped up, it took me by surprise.
> 
> udmabuf maintainer (Gerd Hoffmann), the people who added hugetlb support and
> the list where udmabuf was developed (dri-devel@lists.freedesktop.org) have
> been on cc.

Maybe Greg can suggest a way forward.

> My 'gut reaction' would be to remove hugetlb support from udmabuf.  From a
> quick look, if we really want this support then there will need to be some
> API changes.  For example UDMABUF_CREATE should be hugetlb page aligned
> and a multiple of hugetlb page size if using a hugetlb mapping.
> 
> It would be good to know about users of the driver.

So disabling "hugetlb=on" (and adding an explanatory printk) would
suffice for now?
