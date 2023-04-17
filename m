Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FA6E509C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDQTIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDQTIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CC35A2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E09860FA3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D870C433EF;
        Mon, 17 Apr 2023 19:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681758513;
        bh=DvfaB+8rMKPdQmf0iRaItOKw+iFrC1CjBgL93/QX3ZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eiy0UGNc/HcVJVXw4mIuX/Mo1o8ZOgc5A6YcqzOEPvyuHIuR7UtLSAst0+UaRIxl2
         uwPwwUJJa5mR9RgPBDelSAg6r0/BOFsNINI6ZmcGsFFXTpgin4TGiZcJ98Lg9f1jbq
         whnu1sNk7WhKnCfiCEVp/94k3Qzs9cucl3wIZyWgpRz0RierQGdlzM+twf9LdDEt32
         T5I2Yqv67kvrnAdwtX2AIzh0+pfqhRlSljQVanLUT20E/pkDi6UMXG2M7HCsTjdGX6
         kD7HyVEPVDgIZu5foW2jkkzpgt1fz58weRRl9edF2a5VXHMqumD0ogl63c5cGo5o0y
         /B+G++FcRroxg==
From:   SeongJae Park <sj@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     SeongJae Park <sj@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU example code
Date:   Mon, 17 Apr 2023 19:08:31 +0000
Message-Id: <20230417190831.1744-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <17bbab58-3cde-e980-bdeb-b9de65848b2e@suse.cz>
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

On Mon, 17 Apr 2023 21:02:22 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 4/17/23 21:01, SeongJae Park wrote:
> > On Mon, 17 Apr 2023 18:53:24 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > 
> >> On Mon, Apr 17, 2023 at 05:26:57PM +0000, SeongJae Park wrote:
> >> > Hi Vlastimil,
> >> > 
> >> > On Mon, 17 Apr 2023 13:05:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> >> > 
> >> > > On 4/15/23 05:31, SeongJae Park wrote:
> >> > > > The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU
> >> > > 
> >> > > Since "tiny RCU" means something quite specific in the RCU world, it can be
> >> > > confusing to read it in this sense. We could say e.g. "... snippet uses a
> >> > > single RCU read-side critical section for retries"?
> >> > 
> >> > Looks much better, thank you for this suggestion!
> >> > 
> >> > > 
> >> > > > read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
> >> > > > similar example code snippet, and commit da82af04352b ("doc: Update and
> >> > > > wordsmith rculist_nulls.rst") has broken it.
> >> > > 
> >> > > "has broken it" has quite different meaning than "has broken it up" :) I
> >> > > guess we could just add the "up", unless someone has an even better wording.
> >> > 
> >> > Good point, thank you for your suggestion!
> >> > 
> >> > I will apply above suggestion on the next spin.
> >> 
> >> For the last one, perhaps changing the tense would have more clarity:
> >> 
> >> similar example code snippet, and commit da82af04352b ("doc: Update and
> >> wordsmith rculist_nulls.rst") broke it up.
> > 
> > Thank you for this suggestion, Matthew!  Will send a new version.
> 
> It's ok, I can just use that when picking the patches up without a new resend.

Sorry, already sent[1]...  Please use or ignore it on your convenience.

[1] https://lore.kernel.org/linux-mm/20230417190450.1682-1-sj@kernel.org/


Thanks,
SJ

> 
> > Thanks,
> > SJ
> 
