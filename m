Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A75B622821
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiKIKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKIKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:11:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6636CFD04
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667988644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5MPz3Ec+EPgg7rG8vMEpdX68m++2s8DqWYBcdW2qsvI=;
        b=C1Eo/z9K0XzWDaxc+N2ZUnny0vBIxOYELgbh6/qYFOnLDLMRo22mvJfbf407k8f1NbuxZA
        95UXa2IWafvCjJdGwxs1vZeLkTcaDjhFV0qv0R5e/u9ZQ6inbKsZcTFBxTrd7wCQVsuWAh
        jF6Z3SDexZ6bgJ8pNEDtNUqaXH8pD7M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-360-UgAFNzEsM4OB72JoLHAoEA-1; Wed, 09 Nov 2022 05:10:43 -0500
X-MC-Unique: UgAFNzEsM4OB72JoLHAoEA-1
Received: by mail-qk1-f197.google.com with SMTP id az31-20020a05620a171f00b006fa2cc1b0bfso15516433qkb.23
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MPz3Ec+EPgg7rG8vMEpdX68m++2s8DqWYBcdW2qsvI=;
        b=I9BfUNy9E+4641iAhO4+JvBZUqQK06K/JVEqXTk5f/FntSCIAYa3rd8lAnGo+QhMKe
         H8NThXrwln5PsBjVMZOTWhmxKVcxV8Z07i/EnbJMlnM+83UQnvsQ6zWIZpuzmV9CZrhm
         irM6UsU6nZLDXqwN/Jo8J3tXP4pbR05XN+YePMRaib/giuEP/GywfiOmi3WOQZR9+jwd
         MF6M60RFwFRsEmcNgbn0k6szZ6lIIl0k30M8kA05+4kSEmnqKCGB7lLpT6evIUVswSRY
         O5+KMY0UqYM3h2k8uvGWT+mX9WuCVOxTlmjGjcE5nfn/ZsRENhlrGxH8pEPS+W5qiB/M
         FMiQ==
X-Gm-Message-State: ACrzQf1QPuRZvT6FaYAQ95O8N341mLOKAq6Zzu3zf/+BSMDD0PskBnYu
        8JZipxaXMR9GAb7RddDE2OOy7pCzev3xWmfCQ0BT+FKdIpB/aLIqPhXQADqbMjPL2znUlJuqSvR
        H4Z6SyAHYeTBgOTYrgsxZkZLf
X-Received: by 2002:ac8:5058:0:b0:3a5:3cb0:959 with SMTP id h24-20020ac85058000000b003a53cb00959mr32919859qtm.123.1667988642846;
        Wed, 09 Nov 2022 02:10:42 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7zaE5m+054WqSltDiseEsHQRGbV23se1lE6TQwdYPc3zaWSm4fkB44f0GuQqZbDqR+b7Kc9w==
X-Received: by 2002:ac8:5058:0:b0:3a5:3cb0:959 with SMTP id h24-20020ac85058000000b003a53cb00959mr32919847qtm.123.1667988642628;
        Wed, 09 Nov 2022 02:10:42 -0800 (PST)
Received: from redhat.com ([185.195.59.52])
        by smtp.gmail.com with ESMTPSA id r4-20020ae9d604000000b006fa2b1c3c1esm10651656qkk.58.2022.11.09.02.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:10:42 -0800 (PST)
Date:   Wed, 9 Nov 2022 05:10:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] vhost: fix range used in translate_desc()
Message-ID: <20221109051030-mutt-send-email-mst@kernel.org>
References: <20221108103437.105327-1-sgarzare@redhat.com>
 <20221108103437.105327-3-sgarzare@redhat.com>
 <CACGkMEuRnqxESo=V2COnfUjP5jGLTXzNRt3=Tp2x-9jsS-RNGQ@mail.gmail.com>
 <20221109081823.tg5roitl26opqe6k@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109081823.tg5roitl26opqe6k@sgarzare-redhat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:18:23AM +0100, Stefano Garzarella wrote:
> On Wed, Nov 09, 2022 at 11:28:41AM +0800, Jason Wang wrote:
> > On Tue, Nov 8, 2022 at 6:34 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > 
> > > vhost_iotlb_itree_first() requires `start` and `last` parameters
> > > to search for a mapping that overlaps the range.
> > > 
> > > In translate_desc() we cyclically call vhost_iotlb_itree_first(),
> > > incrementing `addr` by the amount already translated, so rightly
> > > we move the `start` parameter passed to vhost_iotlb_itree_first(),
> > > but we should hold the `last` parameter constant.
> > > 
> > > Let's fix it by saving the `last` parameter value before incrementing
> > > `addr` in the loop.
> > > 
> > > Fixes: 0bbe30668d89 ("vhost: factor out IOTLB")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > 
> > > I'm not sure about the fixes tag. On the one I used this patch should
> > > apply cleanly, but looking at the latest stable (4.9), maybe we should
> > > use
> > > 
> > > Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")
> > 
> > I think this should be the right commit to fix.
> 
> Yeah, @Michael should I send a v2 with that tag?

Pls do.

> > 
> > Other than this
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> 
> Thanks for the review,
> Stefano

