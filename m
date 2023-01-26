Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639C67D531
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjAZTPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjAZTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC444577FE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674760448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewpetcjXX//uVlbm7naEJ+CbPTwcrgo5uLE7anSGYlQ=;
        b=CBzeFkvbDCuc+k2tRa9+s0uEoV+SdDMK9/H/DFLQzMsRztQ8oqJ/9KewtqCmWsS3Yoz6ZV
        89LZhZjsk2xv+nj1HXh0pFfz692UnEbGYDN+VWDvUR7sNxAWg+Jsw37guFNocnRmVLXG7D
        YKjeO8EhiyvmWqBCU3PJqnmVUkXhPA8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-jDpMpMXkMw26wc4WcSyv4A-1; Thu, 26 Jan 2023 14:14:06 -0500
X-MC-Unique: jDpMpMXkMw26wc4WcSyv4A-1
Received: by mail-ej1-f69.google.com with SMTP id du14-20020a17090772ce00b0087108bbcfa6so1843797ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewpetcjXX//uVlbm7naEJ+CbPTwcrgo5uLE7anSGYlQ=;
        b=6qwoO4lgoi/egk+URnu1wRB56HXNqrbeXTnpysYENE4+7crJPRWTb402YzrgojbssY
         bQkf7SKRsBCO0SV+k0NkG+9wQDt8lE9QwFWQ/IVN2Ro02mp3wYZyRI6JooEDRdnTcH/k
         OD2QN5mg1XJBvNTQ8TiTuLfWnQvPAIgFDEuYLJMHJzxuJIbDF64GeaOYo1ZSkvVMXXmc
         7wqNLooqjInRpzaG+yFL48szqLyN01mbZ5ESPh6aLrjNVtsQ5qjCsAq8mHQe856LLn82
         bWu/GSyh8TljcsUwX1DcaAxO51iPLoY1/OcL6QMIuflMgkUG++btmokmIerTFJFQ/GbX
         SVnQ==
X-Gm-Message-State: AFqh2kqILmRAVMiz5ULID838Ubg+bCYr44AcfOkOS5awzrrVikNhlRfx
        rJ+mY9Hzbu0CN1YGYwPmMdbd6ovx1UuHFFiBLdw1pXmX0KlVo8YlLJyG0D5xOH6s1lyi/NZG7d4
        ckN1rOM3fBMPLm6Lh/cZt2fqx
X-Received: by 2002:a17:907:d506:b0:7c0:cc69:571b with SMTP id wb6-20020a170907d50600b007c0cc69571bmr45449528ejc.8.1674760444940;
        Thu, 26 Jan 2023 11:14:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXthLW3WuYOy4V25eXOjf0rSB91MY3+QAG0jSaeD9Auwq3D5kPEWFtkuVLnAC/Qx+fiQxZsaFA==
X-Received: by 2002:a17:907:d506:b0:7c0:cc69:571b with SMTP id wb6-20020a170907d50600b007c0cc69571bmr45449453ejc.8.1674760443885;
        Thu, 26 Jan 2023 11:14:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e22-20020a17090658d600b0085214114218sm990274ejs.185.2023.01.26.11.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:14:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CD8D4942F97; Thu, 26 Jan 2023 20:14:02 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>, nbd@nbd.name
Cc:     alexander.duyck@gmail.com, davem@davemloft.net,
        edumazet@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linyunsheng@huawei.com, lorenzo@kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [net PATCH] skb: Do mix page pool and page referenced frags in GRO
In-Reply-To: <167475990764.1934330.11960904198087757911.stgit@localhost.localdomain>
References: <04e27096-9ace-07eb-aa51-1663714a586d@nbd.name>
 <167475990764.1934330.11960904198087757911.stgit@localhost.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Jan 2023 20:14:02 +0100
Message-ID: <87tu0dkt1h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Duyck <alexander.duyck@gmail.com> writes:

> From: Alexander Duyck <alexanderduyck@fb.com>
>
> GSO should not merge page pool recycled frames with standard reference
> counted frames. Traditionally this didn't occur, at least not often.
> However as we start looking at adding support for wireless adapters there
> becomes the potential to mix the two due to A-MSDU repartitioning frames in
> the receive path. There are possibly other places where this may have
> occurred however I suspect they must be few and far between as we have not
> seen this issue until now.
>
> Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in page pool")
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

I know I'm pattern matching a bit crudely here, but we recently had
another report where doing a get_page() on skb->head didn't seem to be
enough; any chance they might be related?

See: https://lore.kernel.org/r/Y9BfknDG0LXmruDu@JNXK7M3

-Toke

