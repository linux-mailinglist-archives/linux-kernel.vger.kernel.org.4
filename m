Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866EF6E326D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDOQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:27:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577EBE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA56F61535
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 16:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD85BC433EF;
        Sat, 15 Apr 2023 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681576062;
        bh=l7SbKU9F9qydFA63ScSFIvkpFCyV2VwENOTEfPuxH1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3pwUNWGjWJ7oF2B7SdpVX0kEW5mVBH3e5ZgCwzY0DqHClrl2OH9v2TiXTY3xew4G
         Udbqy3DPZoez1xv46q48OXrvV4GYbLZB59fkzE0xIJF49J2SRFaNFs7QgQsnB/LuUZ
         39ueqpB/dUCOAQVazye3+lt9qzOaGVvAbSBRtYqy7moQNsUKItnEuG2+Mf3JmR9g8S
         PxXg88SKzdWxMqmnUlseR1lsRgHa4wM8gwjiixaqpd/um96DT0iLNVGI8LO5Eo5oGa
         0eOlBwtdNrOOUFU8BxJO2zChUy7Tpfo8rrQgQRweM9dT8BZR4Rg7LveJRlXajfXRbL
         S/NQSN4sYBN8w==
From:   SeongJae Park <sj@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        vbabka@suse.cz, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Sat, 15 Apr 2023 16:27:39 +0000
Message-Id: <20230415162739.5898-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZDoe2K7mMu31/6Lb@casper.infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2023 04:49:44 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Apr 15, 2023 at 03:31:59AM +0000, SeongJae Park wrote:
> > The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU
> > read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
> > similar example code snippet, and commit da82af04352b ("doc: Update and
> > wordsmith rculist_nulls.rst") has broken it.  Apply the change to
> > SLAB_TYPESAFE_BY_RCU example code snippet, too.
> 
> so the page cache (eg find_get_entry()) does not follow this "split
> the RCU critical section" pattern.  Should it?  What's the benefit?

The benefit would be shorter RCU grace period that allows lower memory
footprint, iiuc.

Whether it should split the section or not would depend on the lookup speed and
number of retries, I think.  If the total lookup takes a time that long enough
to make the grace period too long and therefore the amount of RCU-protected
objects that cannot freed due to the grace priod is huge, I think it would
better to follow the pattern.


Thanks,
SJ
