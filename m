Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1756C66FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjCWLoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjCWLoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F178C65B7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679571791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVq2mVM36cawCh4Vfk1jD5A152b458CdM0n5/LpNp2k=;
        b=VVyAZ5nEKLioWGwn/1cQ25ibuuiV/3KS7IP5efILEnGhCB7f0frl3cMf+XNnrAH7VxyAtZ
        Qg+xmOP4FCMAEmAzWta0i45q5psoqdfa1zAQeU061J/8tEn+7OkdgJsDScEVdnh0zwF4i/
        X9Sbdslqbbz/W08Q3pGNT+EzQPAhDOI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-nOhDvYQjNG2gUy1ZJSgLGA-1; Thu, 23 Mar 2023 07:43:09 -0400
X-MC-Unique: nOhDvYQjNG2gUy1ZJSgLGA-1
Received: by mail-ed1-f69.google.com with SMTP id es16-20020a056402381000b004fa3e04c882so31708780edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679571788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVq2mVM36cawCh4Vfk1jD5A152b458CdM0n5/LpNp2k=;
        b=kRwV3uJzFa77tE7pvWdEPab+FwCpSYm7gxVr57u+eXLcj5MZAy3jrQtrXkxstX0oB3
         bgRP1CaeFbLBgKddMRgmJqbniTrhPqymV8jvnWnE8hvrCWmONna5jEmfJc8FO88iOQJx
         19OGEOQOXVsxiC5hL4z+hs7jigwLjqk3p0WGicbZhejrAf2pyka7+/WaKPgggyUhTPTt
         tDHeUO5PEx1NOsZUVVMA3z68AsF0WieyzDIeG+OTrSyv+vYLQfBKYl+MWdipQpG2zPDz
         R+wfq92Q0vRQDeEVbRc3wXRZcIpA+xL0f0w7yB9EMziXCaCnDRzvcSsV44IbfYG/fn0t
         GrGA==
X-Gm-Message-State: AO0yUKV9+G/BvZgTVquzT3RT97h6aiJe/A/xwA/DiJvSV13opNVl7xHY
        SChT3j+ExTJq7dA7KwAJFXK72REKfkf9R5SzLmKDJM0FayzLtw3/heFn2klOo20qXYL8D0WZ6qQ
        6Gu4FW4Z5xaJaARDRbJfQVVSj
X-Received: by 2002:aa7:d8d1:0:b0:4fa:4b1c:6979 with SMTP id k17-20020aa7d8d1000000b004fa4b1c6979mr9960918eds.28.1679571788587;
        Thu, 23 Mar 2023 04:43:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set8KZdBp0oRYbIBzh9n5LfprMrAnKWiAlrUE2BOpvPhUzjwGFy4ljscwHArQq5l6tGkLkXTHLA==
X-Received: by 2002:aa7:d8d1:0:b0:4fa:4b1c:6979 with SMTP id k17-20020aa7d8d1000000b004fa4b1c6979mr9960900eds.28.1679571788332;
        Thu, 23 Mar 2023 04:43:08 -0700 (PDT)
Received: from redhat.com ([2.52.143.71])
        by smtp.gmail.com with ESMTPSA id b22-20020a50ccd6000000b00501dac14d7asm2175467edj.3.2023.03.23.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:43:07 -0700 (PDT)
Date:   Thu, 23 Mar 2023 07:43:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mike Christie <michael.christie@oracle.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323073918-mutt-send-email-mst@kernel.org>
References: <20230322185605.1307-1-michael.christie@oracle.com>
 <20230323033557-mutt-send-email-mst@kernel.org>
 <20230323104445.qidusxeruimeawy6@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323104445.qidusxeruimeawy6@wittgenstein>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:44:45AM +0100, Christian Brauner wrote:
> On Thu, Mar 23, 2023 at 03:37:19AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
> > > vhost_task_create is supposed to return the vhost_task or NULL on
> > > failure. This fixes it to return the correct value when the allocation
> > > of the struct fails.
> > > 
> > > Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
> > > Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
> > > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > The affected patch is not upstream yet, right?
> > I don't know if the tree in question allows rebases - linux-next
> > does. So ideally it would be squashed to avoid issues during bisect.
> > Still it's error path so I guess not a tragedy even without squashing.
> 
> I tend to not rebase once stuff has been in linux-next but I make
> exceptions as long as it's before -rc4. For now I've put the patch on
> top (see the other mail I sent) but if it's really important I can
> squash it after the weekend (I'll be mostly afk until then.).

Hard to say how important, but I'd prefer that, yes.

-- 
MST

