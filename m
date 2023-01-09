Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096DC66289A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjAIOcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjAIOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:31:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C61CFFF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673274665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/5CxOh6JMVjx4DWpk0WTYPdAcLVAF5Kf4Udq+XxJnU=;
        b=Vfp0c/PFl//VdIq39GQs/A0X4+4JULQzTukk5Q1G5XSqkUBxvPzwqsqlT/oNc3ZLSzjj16
        pCe2Rk0bzo2PHQwjEE07ssEQPMgcYcDxybJJSaIjIQEshLdFVPp3zHn0DSrg1k6//kvX1I
        6eGYRL5bDY8WOUs2vPAkIvi2u/Ie3FU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-Rmjh9MUtPvKhCjVCjKVnvw-1; Mon, 09 Jan 2023 09:31:03 -0500
X-MC-Unique: Rmjh9MUtPvKhCjVCjKVnvw-1
Received: by mail-qv1-f70.google.com with SMTP id mu2-20020a056214328200b00531cc0222faso5288501qvb.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 06:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/5CxOh6JMVjx4DWpk0WTYPdAcLVAF5Kf4Udq+XxJnU=;
        b=4Lx+Vl5y02n66WMbr+CT9JZAwLIwV8fvmkowZ1tgg3X78WHhsF5psDMmz5hlGJBos8
         LQ0c4Oaahh/i4plsfvK02lJ6bJ76lKWm1ODAvNP/5qx0fSJH62TI7Fb+odwxErqlGY4l
         BUbVn4b2JaCj12pURzcLgtNk8DShnADpuZ9eX5LvEOux1vUvMgUamo6oK6gj/WJ4D5xp
         spE/ZJLK7WFVqWkx81dAlEE/K4k87aCk07/B891Ggoht85HGj4K35DmSlPi+TQpU7jRJ
         EuxeKpDZojZSSeA+m29w1qUGqDjQRwE7IfzFs1huw2oOjlYCzxktFGODfoHOAvuUFH/7
         6iJg==
X-Gm-Message-State: AFqh2koKQ/ZU0ZEpmAnWKx0fsvmHB9xbIZkQOEnsHCe8W9dczX77tj3Q
        qv8UakmejGNKppKISlSh2vWYQ8G9+O4vhlewq0DY3FWAgJ1JeHH1HhqNVRHuPMdOVoFv4gmsxyX
        qLVeDwWXIdztVWkXGQH7dyOCU
X-Received: by 2002:a05:622a:258c:b0:3ab:9ef8:f7e8 with SMTP id cj12-20020a05622a258c00b003ab9ef8f7e8mr61154356qtb.42.1673274661756;
        Mon, 09 Jan 2023 06:31:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs2PjV6Le5BW95OcfwC5I0zXYI7ZeewrhxYZzbihODOMKdAREvC1S3JTRjDCftXyp1XLCxvtA==
X-Received: by 2002:a05:622a:258c:b0:3ab:9ef8:f7e8 with SMTP id cj12-20020a05622a258c00b003ab9ef8f7e8mr61154334qtb.42.1673274661522;
        Mon, 09 Jan 2023 06:31:01 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id x23-20020ac87ed7000000b0039467aadeb8sm4588461qtj.13.2023.01.09.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:31:01 -0800 (PST)
Message-ID: <05df91ed071cfefa272bb8d2fb415222867bae32.camel@redhat.com>
Subject: Re: [PATCH 02/11] filemap: Remove filemap_check_and_keep_errors()
From:   Jeff Layton <jlayton@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 09:31:00 -0500
In-Reply-To: <Y7weinAVLt0uPRa8@casper.infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
         <20230109051823.480289-3-willy@infradead.org>
         <36311b962209353333be4c8ceaf0e0823ef9f228.camel@redhat.com>
         <Y7weinAVLt0uPRa8@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-09 at 14:02 +0000, Matthew Wilcox wrote:
> On Mon, Jan 09, 2023 at 08:48:49AM -0500, Jeff Layton wrote:
> > On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> > > Convert both callers to use the "new" errseq infrastructure.
> >=20
> > I looked at making this sort of change across the board alongside the
> > original wb_err patches, but I backed off at the time.
> >=20
> > With the above patch, this function will no longer report a writeback
> > error that occurs before the sample. Given that writeback can happen at
> > any time, that seemed like it might be an undesirable change, and I
> > didn't follow through.
> >=20
> > It is true that the existing flag-based code may miss errors too, if
> > multiple tasks are test_and_clear'ing the bits, but I think the above i=
s
> > even more likely to happen, esp. under memory pressure.
> >=20
> > To do this right, we probably need to look at these callers and have
> > them track a long-term errseq_t "since" value before they ever dirty th=
e
> > pages, and then continually check-and-advance vs. that.
> >=20
> > For instance, the main caller of the above function is jbd2. Would it b=
e
> > reasonable to add in a new errseq_t value to the jnode for tracking
> > errors?
>=20
> Doesn't b4678df184b3 address this problem?  If nobody has seen the
> error, we return 0 instead of the current value of wb_err, ensuring
> that somebody always sees the error.
>=20

I was originally thinking no, but now I think you're correct.

We do initialize the "since" value to 0 if an error has never been seen,
so that (sort of) emulates the behavior of the existing AS_EIO/AS_ENOSPC
flags.

It's still not quite as reliable as plumbing a "since" value through all
of the callers (particularly in the case where there are multiple
waiters), but maybe it's good enough here.

I'll look over the rest of the set.

Thanks,
--
Jeff Layton <jlayton@redhat.com>

