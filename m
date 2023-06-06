Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE628723904
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjFFH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjFFH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:29:33 -0400
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [IPv6:2001:41d0:203:375::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEAAEC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:29:31 -0700 (PDT)
Date:   Tue, 6 Jun 2023 03:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686036570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvza9IPMgmRkUl/NJKuP6rAJ/u8djUVL0bbFabvKlV4=;
        b=TMv03tPHFmRnFSk4eVCnmeG98P+YeUM3qWkAAPB/9EZfD4JclfClbAINn24CJosfC5wspj
        XFMaiZa0fXdIHqlYFjKomsGiU7Ywdsn+riZjAPyNGjS+vBjDC5ST8w0D+dsy5Ao6l3toF4
        7JMRiT8WHvDLm0skuTHlHtAGM5SDoRM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: [PATCH v2 1/5] block: Rework bio_for_each_segment_all()
Message-ID: <ZH7gVpuTy445jaYW@moria.home.lan>
References: <20230605212717.2570570-1-kent.overstreet@linux.dev>
 <ZH6UAU5d0fiBB/OI@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH6UAU5d0fiBB/OI@ovpn-8-17.pek2.redhat.com>
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

On Tue, Jun 06, 2023 at 10:03:45AM +0800, Ming Lei wrote:
> On Mon, Jun 05, 2023 at 05:27:13PM -0400, Kent Overstreet wrote:
> > This patch reworks bio_for_each_segment_all() to be more inline with how
> > the other bio iterators work:
> > 
> >  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
> >    one in the iterator and pass a pointer to it - bad. This way makes it
> >    clearer what's a constructed value vs. a reference to something
> >    pre-existing, and it also will help with cleaning up and
> >    consolidating code with bio_for_each_folio_all().
> 
> by-value is more readable & clean, the current by-reference is just for aligning
> with original interface.

This is the fourth or fifth time this patch set has been out on the
list, and I specifically asked you to review it awhile back, and you're
just now looking at it?
