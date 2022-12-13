Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DBF64AE86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiLMEEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiLMEER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:04:17 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5AF1DA45
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:04:15 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9B014C01D; Tue, 13 Dec 2022 05:04:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670904264; bh=vhlILI+vHoNfr+ISMlfj3L2/y/4T49eJ8NexDBX73eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVud/Fql/x5OBAytvhGz3mtgcsvPKgQVl6Tg+c6cmRuHrwCnXJMivzUVwECrUIANd
         aCRWn8by4iRCWCTlFXDewRwYNW19liyoS5z59f+dP3mYCC+CO1BqMeuBFxXoSvhHqE
         WInfZrweYQOAYq5rwtUPKhFb3AVV4ho2We8dimmmD/5JCmae4GJ65kYhMRIRJ2h6v5
         uAkGquk7nsexmgD2fs+Qjv/rwfE6sosqNun4NfPRX4r7gafphi19+2yCGhiNGs3hXf
         5gvVdkk1bDeJD1pQn2KAMHRFAeBYuiwCm46Cqhdm/2zSzQ9hkxLdt96JgIy9YHob3G
         fECguENXBYgWw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 9C553C009;
        Tue, 13 Dec 2022 05:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670904263; bh=vhlILI+vHoNfr+ISMlfj3L2/y/4T49eJ8NexDBX73eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KEatnRtcY1R1imBOfC7CYYfINTFehClJS2CRiCKmB3IXAHvPBDokv3JrI/+8aHzS3
         2iK4m5Ma1569+iX0JppFMNC2q6KdAB0niapL975gWhpHywcMmvDTJLflWqc22BKu2q
         CHwV8WEX6AkdkEZ1WxCP2/XAVvQt2l1/6KIFetBBDaKkwst+vNRqV68DRl6Qi/V04V
         OkT8mFdgHVxhHSIekDQXXTvDWwiABVf41z/FqoFkaOCyuPW99fdPClGil3xxRvo4Y7
         1rkHv+uPiYN7IdOOdl0Bz/fEHbe0LxikcY34C2egdk9qn/TVk9tp0SuuPJgGeB9gvM
         2UXMlsQNoo7KA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 85a5df99;
        Tue, 13 Dec 2022 04:04:07 +0000 (UTC)
Date:   Tue, 13 Dec 2022 13:03:52 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/virtio: add a read barrier in p9_virtio_zc_request
Message-ID: <Y5f5qG1SkGrEST6H@codewreck.org>
References: <20221210001044.534859-1-asmadeus@codewreck.org>
 <21422678.bhv4C0q8Fj@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21422678.bhv4C0q8Fj@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Mon, Dec 12, 2022 at 02:35:39PM +0100:
> > diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> > index 3c27ffb781e3..98425c63b3c3 100644
> > --- a/net/9p/trans_virtio.c
> > +++ b/net/9p/trans_virtio.c
> > @@ -533,6 +533,12 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
> >  	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
> >  	err = wait_event_killable(req->wq,
> >  			          READ_ONCE(req->status) >= REQ_STATUS_RCVD);
> > +
> > +	/* Make sure our req is coherent with regard to updates in other
> > +	 * threads - echoes to wmb() in the callback like p9_client_rpc
> > +	 */
> > +	smp_rmb();
> > +
> 
> Oh, I had p9_client_zc_rpc() for this in mind, but I see why you chose this
> place in p9_virtio_zc_request() instead. LGTM

Yes, we access req data here so as much as it'd make more sense to keep
it symetrical in p9_client_zc_rpc (like p9_client_rpc) I think we need
it here.

> I also made some tests to check whether this barrier would hurt performance,
> but I measured no difference. So this should be good to go:

Thanks!
The assembly generated with the barrier is actually slightly shorter for
x86_64, but it's hard to tell the actual performance impact....

> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Cheers, I've queued this patch as well: let's make that this merge
windows' batch unless a problem comes up.

-- 
Dominique
