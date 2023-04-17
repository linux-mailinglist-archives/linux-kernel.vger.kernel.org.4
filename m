Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE06E5080
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDQTBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDQTBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:01:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415435BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB7C61768
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4134C433D2;
        Mon, 17 Apr 2023 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681758091;
        bh=XmPwWnyoTnixvrnBOL2nRZgx4VQqvaf1gkEpOzKe6MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1myIjNhaFl8VGvLbk5LulAkonJAJR358XvE8BCdZi0zONfP4AqfcLst04S9BfNjR
         jtpAAsv+owpct/B01rLXkpPdLAlOMAvb+5y1z0DRfATX0aVtPyPyOHopihXwCSV0sx
         6Z4gx6x6DpCzk5YMyPji/doOPqYn1IC1ahqho1rg8xr56/wuDO0V2KDA4apnmW8sbg
         gtkvHTe8DGcqJK4uLWGt8LSbK4lDL/KlKkDXsb2aSER3WmqMGy0aZL+m1BlfjcuZea
         kuVI9kMX4fiQXC8OtXpFl+D0GnpHOGsUZejaePY7iDb6Qk0tdrI352LRILYGpU22I2
         O3IEUTdOrinZw==
From:   SeongJae Park <sj@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        akpm@linux-foundation.org, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Mon, 17 Apr 2023 19:01:29 +0000
Message-Id: <20230417190129.1454-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZD2HlGwNkrrj+Odz@casper.infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 18:53:24 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Apr 17, 2023 at 05:26:57PM +0000, SeongJae Park wrote:
> > Hi Vlastimil,
> > 
> > On Mon, 17 Apr 2023 13:05:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> > 
> > > On 4/15/23 05:31, SeongJae Park wrote:
> > > > The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU
> > > 
> > > Since "tiny RCU" means something quite specific in the RCU world, it can be
> > > confusing to read it in this sense. We could say e.g. "... snippet uses a
> > > single RCU read-side critical section for retries"?
> > 
> > Looks much better, thank you for this suggestion!
> > 
> > > 
> > > > read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
> > > > similar example code snippet, and commit da82af04352b ("doc: Update and
> > > > wordsmith rculist_nulls.rst") has broken it.
> > > 
> > > "has broken it" has quite different meaning than "has broken it up" :) I
> > > guess we could just add the "up", unless someone has an even better wording.
> > 
> > Good point, thank you for your suggestion!
> > 
> > I will apply above suggestion on the next spin.
> 
> For the last one, perhaps changing the tense would have more clarity:
> 
> similar example code snippet, and commit da82af04352b ("doc: Update and
> wordsmith rculist_nulls.rst") broke it up.

Thank you for this suggestion, Matthew!  Will send a new version.


Thanks,
SJ
