Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128CD633B51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiKVL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiKVL0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:26:38 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB4363CE3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=i7zhY67HvXsANWaMrM7PgcglBFkDMzl8D8aIeEogL08=; b=T922QQ41QNfXRiKkPBs6IilCD2
        mfwcj4X4w9JP9blv78Y36yEJXwYQTEuxvWDbjuFOGv888tfIcdl+URcwnTK3zFKfUkpfnOeHKT2/8
        dE7h9O0yVj9jFIwS2qWExD/cXlRFN/OC7fFs8bt8ff5eYQPICphtC29cpK1LqG7OmKzaor2WOJp0W
        1JVXlpw9uDRmQtaHU4sjZT9ucyPNXqltGSKxhb1r1Z2SLDMsVpEMjWyj69VFun8uSp5dhIVmWgzZI
        8acITSPAfWoVsSQLjPxVQzi5boMPeAU3BMLvtpCYLyYjgqhPZMG6vOVkGhwOegLz4jcBYdHGk103p
        OE/c/jRbdCkkv6gbteXYAxsN5lpmIjDfhymSGZV7hTRKEeGJ1lsM/KnUmLI+0fy+Thdg4+Bvp01CZ
        qpGKffntcK+z8Gf+GJNyR+sfzjVpalQLzG8PvgQDxZjckR8CkztmSOkZD2npMBzWcNzCNPNlMNt1R
        Hh6u5MIQr7qYIPNyPuDlyoR8UOirpomSaQBOvyZ23cpMUte3Oe0J2zVz1cneJ/Y+IhHBvds257wcy
        C1uTchNGh2fviTgpIEJbGSiG9NkhV/zWvmyFxCBkziY0J5J0di1OVah4e2Rxf/YsqiNXse93XyycL
        tjb5Lnn/VFO658Fb+w2CzXstf8XP6hxfrvmldB+oM=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH 2/2] net/9p: fix response size check in p9_check_errors()
Date:   Tue, 22 Nov 2022 12:20:12 +0100
Message-ID: <2474218.LCornM2og2@silver>
In-Reply-To: <Y3wWFxRVpei71PQt@codewreck.org>
References: <cover.1669072186.git.linux_oss@crudebyte.com>
 <fffb512c532bf1290f0f2b1df6068b2ff6cd14c0.1669072186.git.linux_oss@crudebyte.com>
 <Y3wWFxRVpei71PQt@codewreck.org>
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

On Tuesday, November 22, 2022 1:21:43 AM CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Tue, Nov 22, 2022 at 12:04:08AM +0100:
> > Since 60ece0833b6c (net/9p: allocate appropriate reduced message buffers)
> > it is no longer appropriate to check server's response size against
> > msize. Check against the previously allocated buffer capacity instead.
> 
> Thanks for the follow up!
> 
> >  - Omit this size check entirely for zero-copy messages, as those always
> >    allocate 4k (P9_ZC_HDR_SZ) linear buffers which are not used for actual
> >    payload and can be much bigger than 4k.
> 
> [review includes the new flag patch]
> 
> hmm, unless there's anywhere else you think we might use these flags it
> looks simpler to just pass a flag to p9_check_errors?

For now that would do as well of course. I just had a feeling that this might
be used for other purposes as well in future and some of these functions are
already somewhat overloaded with arguments.

No strong opinion, your choice.

> In particular adding a bool in this position is not particularly efficient:
> -------(pahole)-----
> struct p9_fcall {
> 	u32                        size;                 /*     0     4 */
> 	u8                         id;                   /*     4     1 */
> 
> 	/* XXX 1 byte hole, try to pack */
> 
> 	u16                        tag;                  /*     6     2 */
> 	size_t                     offset;               /*     8     8 */
> 	size_t                     capacity;             /*    16     8 */
> 	bool                       zc;                   /*    24     1 */
> 
> 	/* XXX 7 bytes hole, try to pack */
> 
> 	struct kmem_cache *        cache;                /*    32     8 */
> 	u8 *                       sdata;                /*    40     8 */
> 
> 	/* size: 48, cachelines: 1, members: 8 */
> 	/* sum members: 40, holes: 2, sum holes: 8 */
> 	/* last cacheline: 48 bytes */
> };
> ----------------
> Not that adding it between id and tag sounds better to me, so this is
> probably just as good as anywhere else :-D

Yeah, that layout optimization would make sense indeed.

> Anyway, I'm just nitpicking -- on principle I agree just whitelisting zc
> requests from this check makes most sense, happy with either way if you
> think this is better for the future.
> 
> >  - Replace p9_debug() by pr_err() to make sure this message is always
> >    printed in case this error is triggered.
> > 
> >  - Add 9p message type to error message to ease investigation.
> 
> Yes to these log changes!
> 
> > 
> > Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> > ---
> >  net/9p/client.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/9p/client.c b/net/9p/client.c
> > index 30dd82f49b28..63f13dd1ecff 100644
> > --- a/net/9p/client.c
> > +++ b/net/9p/client.c
> > @@ -514,10 +514,10 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
> >  	int ecode;
> >  
> >  	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
> > -	if (req->rc.size >= c->msize) {
> > -		p9_debug(P9_DEBUG_ERROR,
> > -			 "requested packet size too big: %d\n",
> > -			 req->rc.size);
> > +	if (req->rc.size > req->rc.capacity && !req->rc.zc) {
> > +		pr_err(
> > +			 "requested packet size too big: %d does not fit %ld (type=%d)\n",
> > +			 req->rc.size, req->rc.capacity, req->rc.id);
> 
> Haven't seen this style before -- is that what qemu uses?
> We normally keep the message on first line and align e.g.

Lazy me, I haven't run checkpatch.pl this time. I'll fix that.

I also have to fix the format specifier for `capacity` that kernel test bot
barked on.

> > +             pr_err("requested packet size too big: %d does not fit %ld (type=%d)\n",
> > +                    req->rc.size, req->rc.capacity, req->rc.id);
> 
> (at least what's what other grep -A 1 'pr_err.*,$' seem to do, and
> checkpatch is happier with that)



