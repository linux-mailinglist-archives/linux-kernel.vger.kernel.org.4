Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58AA669645
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbjAML5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjAML5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:57:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9954737
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673610705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dzPxknbDeycONq8q91XK21adsaXcGOaKeXyc86TDPM=;
        b=XZUHIgy3ye0sEW+Cg+k7R2ALIEA2CHD3rRIl2apQYDdigukCC3pALewnMHZrulV872CgOF
        EiHZWwLWsCh3+6U7VFtuyVK8s8IPtBtPrFLviEcj4IAWt0Sh/R954g5XZi2+2XRdv7rxiv
        Sgure/kjBMSVFJ1uXaVYJoyViSdSYUQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-JRHysNvvP7y6yo1V1_3A4w-1; Fri, 13 Jan 2023 06:51:44 -0500
X-MC-Unique: JRHysNvvP7y6yo1V1_3A4w-1
Received: by mail-qk1-f200.google.com with SMTP id s7-20020a05620a0bc700b006e08208eb31so14989562qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dzPxknbDeycONq8q91XK21adsaXcGOaKeXyc86TDPM=;
        b=YyZVXkNy8EguwNZrM3DJWDMmF3U8lUXE0fgQPfqFi/r+NZdOmZaKODU6pFUFDcLosc
         56GeMTaNi5GnrL6LhLvpSL8UcLOFI/DSAA4rFxpLBlpe9inVXQ7zF6cHw2TzXsZjrbh+
         7hbJlrRuEvM5672RdIgtnoKE5DiCDPOp+d9Ty1p9R+HSZGOOVs9Lujom/EpU9BXd2coQ
         tSn37Z4eAaMvSBjq9aD+Ok47ABB4SjDni5jJvVvhtPRuU49KTEWS16dP44ghV5H5sJhU
         JwZKiLRZB30VMrcaKA6IBbhv7ufX39RxAFpsmro1QMbDujGFFmKCwWu+U34ZbBTwOz0k
         10gQ==
X-Gm-Message-State: AFqh2kpyZ3qbuRo4J2q+1NegQNk+k0u3VKvDTBSgmod8zUIqOwre9sOJ
        B+PCVUZopvog6RNo2O18Uo5Ip936pXCM9sXZHW1u2jCfbib1Pzx71mSpIqOmZBSnoU1kK1lcSKg
        CTSLD6vuH49hE9ayAtE73N7LL
X-Received: by 2002:a0c:b292:0:b0:534:7dbc:1748 with SMTP id r18-20020a0cb292000000b005347dbc1748mr3706566qve.36.1673610703832;
        Fri, 13 Jan 2023 03:51:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsxU92iBsFxEYAqdlYG3wkOiJ5infP2DAZf/e7Dbfb6JldHMAl3LPJR+kNYczlt9fxshfTrWw==
X-Received: by 2002:a0c:b292:0:b0:534:7dbc:1748 with SMTP id r18-20020a0cb292000000b005347dbc1748mr3706551qve.36.1673610703631;
        Fri, 13 Jan 2023 03:51:43 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-183.dyn.eolo.it. [146.241.113.183])
        by smtp.gmail.com with ESMTPSA id o5-20020a05620a2a0500b006f9e103260dsm12733220qkp.91.2023.01.13.03.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 03:51:43 -0800 (PST)
Message-ID: <397b05375f57ec5dc0f084315b995bfda4527d95.camel@redhat.com>
Subject: Re: Patch "net/ulp: prevent ULP without clone op from entering the
 LISTEN status" has been added to the 5.4-stable tree
From:   Paolo Abeni <pabeni@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, slipper.alive@gmail.com,
        stable-commits@vger.kernel.org
Date:   Fri, 13 Jan 2023 12:51:40 +0100
In-Reply-To: <Y8FDhdy3s1z/JxAi@kroah.com>
References: <16735310493146@kroah.com> <Y8AP6Lqo9sfX9Bb8@kroah.com>
         <20230112105731.0da81d58@kernel.org> <Y8BZboDOQ1I+VTAC@kroah.com>
         <Y8FDhdy3s1z/JxAi@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Fri, 2023-01-13 at 12:41 +0100, Greg KH wrote:
> On Thu, Jan 12, 2023 at 08:03:10PM +0100, Greg KH wrote:
> > On Thu, Jan 12, 2023 at 10:57:31AM -0800, Jakub Kicinski wrote:
> > > On Thu, 12 Jan 2023 14:49:28 +0100 Greg KH wrote:
> > > > On Thu, Jan 12, 2023 at 02:44:09PM +0100, gregkh@linuxfoundation.org wrote:
> > > > > 
> > > > > This is a note to let you know that I've just added the patch titled
> > > > > 
> > > > >     net/ulp: prevent ULP without clone op from entering the LISTEN status
> > > > > 
> > > > > to the 5.4-stable tree which can be found at:
> > > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary  
> > > > 
> > > > Oops, nope, this broke the build for 5.4 and older kernels, now
> > > > dropping.
> > > 
> > > There's no clone op, right?
> > 
> > Correct.
> > 
> > > If you're willing to futz with it I think
> > > you just need to remove the "and the ops don't have ->clone" part of
> > > the conditions. Any presence of ops on older kernels should make us
> > > bail.
> 
> Ok, I've queued up the following patch for 5.4. and older.  Let me know
> if I've messed anything up here, but it at least builds for me :)

The backport patch LGTM, thanks!

Paolo

