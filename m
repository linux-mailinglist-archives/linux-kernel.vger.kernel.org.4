Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B664B3AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiLMLBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiLMLBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:01:10 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19662FB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:01:08 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 4882DC01C; Tue, 13 Dec 2022 12:01:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670929277; bh=i+3KSd/BKuiZzIgaQKdwdpk5+VGqCi4zl8XD5fOa8QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Myn8FwbQHXJqNcTPuq2ZLZaY3T2N2jYM/qyH7kvoubhGQovdc2y8dSzs9dafJRxS7
         B4nkCYvv9c2zPcA28Q3WnEVx4gMNMvFfCc0QXEWAwVlYL+AtfGEFJhenIE6lTvhQVp
         Sr2M3KWY79i9Fpj3yiPGz4BpAza1IXl7XIj0JP3kj/pczQ/glrB8FEHzEcUssj+Ojy
         hitQ4I/VH5md1KV3Td9eTbS8CLmUA0lpkoSET/k6k5V+ZtHANKOjJpKoILb43k0/kY
         aiBtGQ52TH1oVbUimVvGrRm5WOzJnjQ+XlSDRtMeoud8G+zfhSLImHFyrizg+4oB2o
         M1RCWoZNKn0sg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 6957EC009;
        Tue, 13 Dec 2022 12:01:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670929276; bh=i+3KSd/BKuiZzIgaQKdwdpk5+VGqCi4zl8XD5fOa8QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6jaoe6b/cRpvorEGj2ppTb3TwsxUgxj9OpPv+ODz6+ULupIaHCEyledy/wyPy0Rl
         3aIgRY3hOpNQ7B4/H+4x5xZh/bGE8eVT+YjOLQe29TzrXmd9sNI63DeuInrBiMSkIv
         ntpvpiEbxThgus/zNUqchJWdpO++UDwyIwZ92WZsHEhadFLTGz3vT1PuO0+Gw4F3BD
         9SYaYojunrCIUpK2teBcUDOcmI6/R4twBKo7JjFNld4jbE+rf0K7t2U4RiIMVhJ1B+
         Kj4EIMkygP9LTwXiwiA2qGtKrWe4KIO/jQ6YbJfBTSW26v7pDzkZ9feyaZcosGnnbn
         mRMqDJ95Z+RaQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5087022c;
        Tue, 13 Dec 2022 11:01:00 +0000 (UTC)
Date:   Tue, 13 Dec 2022 20:00:45 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/virtio: add a read barrier in p9_virtio_zc_request
Message-ID: <Y5hbXanne5IryJBV@codewreck.org>
References: <20221213065901.3523-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221213065901.3523-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Your mailer breaks threads, please have a look at how to make it send
In-Reply-To and/or References headers)

Hillf Danton wrote on Tue, Dec 13, 2022 at 02:59:01PM +0800:
> On 10 Dec 2022 09:10:44 +0900 Dominique Martinet <asmadeus@codewreck.org>
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
> >  	// RERROR needs reply (== error string) in static data
> >  	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
> >  	    unlikely(req->rc.sdata[4] == P9_RERROR))
> 
> No sense can be made without checking err before req->status,
> given the comment below. Worse after this change.

Hmm, I don't see how it's worse (well, it makes it more likely for
req->status to be RCVD after the barrier without the rest of the data
being coherent I guess), but it's definitely incorrect, yes...
Thanks for bringing it up.


Having another look I also don't see how this can possibly be safe at
all: if a process is killed during waiting here, p9_virtio_zc_request
will drop pages it reserved for the response (in the need_drop case) and
sg lists will be freed but the response can still come for a while --
these need to be dropped only after flush has been handled.

If these buffers are reused while the response comes we'll be overriding
some random data...


This isn't an easy fix, I'll just drop this patch for now; but I guess
we should try to address that next cycle.

Perhaps I can try to find time to dust off my async flush code, some
other fix might have resolved the race I used to see with it...

-- 
Dominique
