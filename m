Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED906482DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLINqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLINp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:45:56 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB45E9FB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=scntrexDvEFTL6MFGovcPcrFqt1lDEvuFuRvr5PfinY=; b=hUf3X96bDt5N1R+ZFy+AgMqlkx
        LO1sbuoyoRVEaqzcRhA0ybtBDd2CpIuWQ1YHIAKWBsnDOkKvUY1xvtdnbWqvwTh++NZMRjold/cpV
        RZdiRqqWt3BTN2ni8+aAA/oDj6TUTplPsFiNB/JxTLQ56mKh6Fst1eiZz59/K/Q5JhX5YHodtZVFe
        /tmeCWxGaitIllCNxYQ+6NlvRVWRvWaSnJA0Q34c2KAA5TL5n28cVdQvsARmOFsGm7xPs51kuKZXy
        L2jgePd5R4Tg81brX1YbLuzGUXY+8k+w6YsRAVmKZaHqsfXLjTL/X0BAmbf7wj7hriP6z1dq5aiIi
        iWtUGl4rdUC7wgNByweAY9llymducA4v+8RZjvt6WCSyjvHVEiV7+jm4FIdIaO1Dl/WR7OjkpeA6+
        749skjnLlcfe+rPSfDq3DrfSwATa27wjlMJQs0F84NKCscDljUb144MX2NN922VBD47pvWMYEvVLM
        TvT5kp+9jgfH6VrE+BGSQ+8Kgj15Vddw0Tu1xsHQBYMbEcq2crv2ZN5wNQkI1231QsRKQ2F/CvnJI
        2eGC7oTUksWXJyPlkm1fz0ACbvp3DNCn+trWxfh0g6rxuSuhMX4FFCrylP/njugfpnxFnC6Yi4NIw
        hhb/TP80m2MqXz/q4EMjnzBw8KTDX9H2Spgmlkrdk=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/client: fix data race on req->status
Date:   Fri, 09 Dec 2022 14:45:51 +0100
Message-ID: <2603677.8PHbUxGoeg@silver>
In-Reply-To: <Y5J4Voie1ik6BqnR@codewreck.org>
References: <20221205124756.426350-1-asmadeus@codewreck.org>
 <167052961.MU3OA6Uzks@silver> <Y5J4Voie1ik6BqnR@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 9, 2022 12:50:46 AM CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Thu, Dec 08, 2022 at 04:51:27PM +0100:
> > Right, looks like most of it should be fine. Maybe p9_client_zc_rpc() needs a
> > barrier as well?
> 
> Good point, the request is used without any other lock after the
> wait_event on req->status in trans_virtio.c;
> I'll send a separate patch for it later today.
> 
> 
> > > I think we're just protecting against compiler
> > > reordering or if on some arch the store isn't actually atomic.
> > 
> > And access order within the same thread.
> 
> In this case afaik the barrier also does that? There would be no point
> if a write barrier allowed a write placed before the barrier to be
> reordered after it...

If it's about a single access, right. However when there are multiple accesses
(e.g. an expression) and plain-C access was used then the compiler was still
free to re-order the accesses in a different order than coded.

> > > This code path actually was broken before I added the barrier a while
> > > ago (2b6e72ed747f68a03), as I was observing some rare but very real
> > > errors on a big server so I'm fairly confident that for at least x86_64
> > > the generated code isn't too bad, but if KCSAN helps catching stuff I
> > > won't complain.
> > 
> > What about p9_tag_alloc()?
> 
> I think that one's ok: it happens during the allocation before the
> request is enqueued in the idr, so it should be race-free by defition.
> 
> tools/memory-model/Documentation/access-marking.txt says
> "Initialization-time and cleanup-time accesses" should use plain
> C-language accesses, so I stuck to that.

When it is allocated then it is safe, but the object may also come from a pool
here. It's probably not likely to cause an issue here, just saying.



