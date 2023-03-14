Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF26BA02E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCNT5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCNT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7252457D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678823823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwJKLbbt+tCbh3r4moNy9ZfrdrBTTmr8w1YMLV/pQG0=;
        b=Wj9XmQVNynuA1z3sCX0DPdvkdS7cS55hhUbQaZe7xJsJLlsxXFC1UncHaSDVWJeM6lp2TG
        j+CpUd6FahHiZRhbG44nfxUtyJv6LcyCsuprs/Oimv9i0cz6TAy2RvDOwxNbaw7tIZ61i3
        j0cTgE0vB54G4BuwmlE4EUPAMHK8LLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-kJiNRgUXP2iY_DBKqxDP7A-1; Tue, 14 Mar 2023 15:57:00 -0400
X-MC-Unique: kJiNRgUXP2iY_DBKqxDP7A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D402F802C18;
        Tue, 14 Mar 2023 19:56:59 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0655A400F52;
        Tue, 14 Mar 2023 19:56:58 +0000 (UTC)
Date:   Tue, 14 Mar 2023 14:56:57 -0500
From:   Eric Blake <eblake@redhat.com>
To:     Nir Soffer <nsoffer@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] block nbd: use req.cookie instead of req.handle
Message-ID: <20230314195657.vpazxest7rvm5frp@redhat.com>
References: <20230310201525.2615385-1-eblake@redhat.com>
 <20230310201525.2615385-4-eblake@redhat.com>
 <CAMRbyyv59L9GiLr5tJvnNdwnBNdNGw+xveG7S63WC9ycOuJYrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRbyyv59L9GiLr5tJvnNdwnBNdNGw+xveG7S63WC9ycOuJYrA@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 02:22:51PM +0200, Nir Soffer wrote:
> On Fri, Mar 10, 2023 at 10:16 PM Eric Blake <eblake@redhat.com> wrote:
> >
> > A good compiler should not compile this any differently, but it seems
> > nicer to avoid memcpy() when integer assignment will work.
> >
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  drivers/block/nbd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 592cfa8b765a..672fb8d1ce67 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -606,7 +606,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
> >                 request.len = htonl(size);
> >         }
> >         handle = nbd_cmd_handle(cmd);
> 
> This returns native u64 (likely little endian) but the new interface
> specifies __be64. Should we swap the bytes if needed?

Or document the field as u64 in the .h file.  I'm not sure which is
better, but the mismatch here is definitely why the test robot
complained about new warnings with my v1 patch.  I'm new enough to
kernel development that I will welcome a hint about which way I should
lean in writing v2.

> 
> This will help tools like the wireshark plugin to display the right value
> when checking traces from machines with different endianness. Or help
> the nbd server to show the same *cooike* value in the logs. The value
> is opaque but reasonable code can assume that __be64 can be safely
> parsed as an integer.

The fact that the old code was memcpy()ing a u64 into char[8] over the
wire means that wireshark was already seeing endian-dependant values
in that portion of the struct (a big-endian and little-endian client
that happen to use the same cookie/handle will show up differently).
I don't mind adding byteswapping and using __be64 (instead of direct
assignment and u64) if that's what we want, but I don't think anyone
should be relying on wireshark to have stable output for those bytes,
since they are opaque to the server regardless of endianness.

> 
> Also the same file has references to *handle* like:
> 
> static u64 nbd_cmd_handle(struct nbd_cmd *cmd)
> {
>     struct request *req = blk_mq_rq_from_pdu(cmd);
>     u32 tag = blk_mq_unique_tag(req);
>     u64 cookie = cmd->cmd_cookie;
> 
>     return (cookie << NBD_COOKIE_BITS) | tag;
> }
> 
> static u32 nbd_handle_to_tag(u64 handle)
> {
>     return (u32)handle;
> }
> 
> static u32 nbd_handle_to_cookie(u64 handle)
> {
>     return (u32)(handle >> NBD_COOKIE_BITS);
> }
> 
> So this change is a little bit confusing.
> 
> I think we need to use a term like *nbd_cookie* instead of
> *handle* to make this more clear.

I can additionally rename these helper functions in v2 if that would
be helpful.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

