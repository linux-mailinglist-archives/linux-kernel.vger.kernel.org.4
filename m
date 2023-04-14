Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303C16E1B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDNEzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDNEzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA740C5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 21:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681448054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tocrHY6nV4YHVi/za0FgRWwQlzOhOYvZ+UJ+s+zXC54=;
        b=GIvBhBxmyfFtsU/Djf/2vhQ41bmXbj3ueqrlsJVOEflDmttf8964PC4OOdxAeW0NvrKgwz
        Zw6jqZxmifkRJZLThmud71Gm3PxyQa0ooVv8bU5i0nWsu2Qvl7kK9f3bzVaSYXGRBkpxE9
        wv/LCarxKOtwVU1uREKJZ9TtOVYgKkY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-WtH0z4cwOXGHRvxhbdVaSg-1; Fri, 14 Apr 2023 00:54:10 -0400
X-MC-Unique: WtH0z4cwOXGHRvxhbdVaSg-1
Received: by mail-oi1-f198.google.com with SMTP id e18-20020a056808149200b00386f33cd11dso4857899oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 21:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681448050; x=1684040050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tocrHY6nV4YHVi/za0FgRWwQlzOhOYvZ+UJ+s+zXC54=;
        b=fSDdjDinEjfS4Rjhw3w1zUjbhpYK2BhHDSAS36KHFmy6Xiy2E772ilO4VXzbF6pTUg
         tQA+Q8RJM63MwZbnH8YnV2ff9aPdqPzlM7h+nScVP/Wu3mdwgEoZ/Wjud5XPjvtgxJaU
         V7/YsIiWcIksazZIzK0tOfVuEogcPh/XHZoNvFecvkS3fYvRQnmSXmSkDzB92qWx5KMw
         MKhRCzYDrjthM/MbpXIFaGR7P/6r1g3ubRi2QaNPsp0lPO7ngcR0uZoHyY+UCAHBZmcz
         XtUZbdHyuZbV9ZCvKj8ssqCRlNLhj5MVDvB1ELUGtTvbhgRLpZwzdv7/Wg8ZwbSzMjIX
         LQsw==
X-Gm-Message-State: AAQBX9ckbIIBoDf25lv6pv8RLJBsbeRwt4OyvHIpgr4nZtZwRVZ3h9MC
        SmzEePHL/g8eIg54fwH2DohOk7k1NHZsNG+XJ+mGHOm03Lt/a9vNpUtukYZ6oh5jk58VtgHT/rQ
        M4OdFIn8MOt1GPjVqwqIf88dmJpidKv0NLwCQPSFh
X-Received: by 2002:a05:6830:1e68:b0:69f:bac:aa8a with SMTP id m8-20020a0568301e6800b0069f0bacaa8amr1184190otr.2.1681448049902;
        Thu, 13 Apr 2023 21:54:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAIBCx4X+NNcvZ8A50bkSP9FEpyJ2twQnWfg2TY5sYS6XErk+0sb1nV9eWtNhrxdMNTlOsljAiPXJyV7oGAZs=
X-Received: by 2002:a05:6830:1e68:b0:69f:bac:aa8a with SMTP id
 m8-20020a0568301e6800b0069f0bacaa8amr1184177otr.2.1681448049732; Thu, 13 Apr
 2023 21:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com> <20230413070408.630fa731@kernel.org>
In-Reply-To: <20230413070408.630fa731@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 Apr 2023 12:53:58 +0800
Message-ID: <CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/2] virtio-net: don't busy poll for cvq command
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     mst@redhat.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 13 Apr 2023 14:40:25 +0800 Jason Wang wrote:
> > The code used to busy poll for cvq command which turns out to have
> > several side effects:
> >
> > 1) infinite poll for buggy devices
> > 2) bad interaction with scheduler
> >
> > So this series tries to use sleep instead of busy polling. In this
> > version, I take a step back: the hardening part is not implemented and
> > leave for future investigation. We use to aggree to use interruptible
> > sleep but it doesn't work for a general workqueue.
>
> CC: netdev missing?

My bad. Will cc netdev for any discussion.

Thanks

>

