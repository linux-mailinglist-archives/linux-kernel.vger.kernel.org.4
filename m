Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88F6CF588
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjC2VrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC2VrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CE40DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680126373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLdrrjYrVuiWJorDb/815Wq1wAW83zbfu/IRhqAaimY=;
        b=GDWEDXH8T0x7ENDjBWHR/dFjf0YudTt1/scSY26fC56uJvp1t7/n4pi9Bq/fo43+07hXyK
        Qk9NcvX7+t/SUEuP5C5zS3bZIwRQ+SdKbUyNGUciOELWy0LVb77rNTTOf6d88eArraUQyi
        ClWbbsNLWjhMdNCvvXA0fnoiYKLU6bQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-yNQhsKoWPqeEYKPyUKxzsw-1; Wed, 29 Mar 2023 17:46:11 -0400
X-MC-Unique: yNQhsKoWPqeEYKPyUKxzsw-1
Received: by mail-ed1-f69.google.com with SMTP id a27-20020a50c31b000000b0050047ecf4bfso24219920edb.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680126370;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLdrrjYrVuiWJorDb/815Wq1wAW83zbfu/IRhqAaimY=;
        b=x3irBDpD7NtBeuaawGbtKpD0KxsKnpV8Hs4kIxQJ0TOcwosikPmbks6Q4wZwUeJ7DF
         MkWODq8SxAMFzFZfAmXouC2FUXY3vUNTxGXMH4acSa5M5qHo89z5O7XHgaZYPPwJQA+0
         cPw5iSTptrY58SYuEtmN5WYdwjfMxstId/9bo9bBHVAnwTbOr+dw5dfmBTw4C4wCWbBA
         hsQZ5xIqSKyWqRcaw/jzPGSm43yjY8sPMY1jaKSeLi3p0xb6njvFsKFwa7d6hOMG6ftJ
         zswy9CJD6Yrhlt4NaW2u8gNUu8wlI2jVvX+m5d0Vws6VERNxvOECJgV2XODZSNsKHEdr
         tZ2g==
X-Gm-Message-State: AAQBX9eqGdNlIca/zjNjXAzB1BrrDDLOfOSL7wZ5xL8pX9JY6iPIuz3j
        D/frNye+skZStqSGra5eqLuOQe5netjHqPeZjmAdUR4yRo4OvV063lfe/yiw/z2JFkdIMJdCtED
        sFf+DATA2eV2gicLOxravFAMB
X-Received: by 2002:a17:907:7f86:b0:926:9c33:ea4 with SMTP id qk6-20020a1709077f8600b009269c330ea4mr23062338ejc.27.1680126370361;
        Wed, 29 Mar 2023 14:46:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZGQUYQJeTXwnRV15le8g2e5F6QxBAZ5bivkYpLnhuEBXno6vpJg9RQt0C5heMRA6NQh8z/2A==
X-Received: by 2002:a17:907:7f86:b0:926:9c33:ea4 with SMTP id qk6-20020a1709077f8600b009269c330ea4mr23062308ejc.27.1680126369951;
        Wed, 29 Mar 2023 14:46:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z26-20020a17090674da00b009310d4dece9sm16869157ejl.62.2023.03.29.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:46:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 974C8A22B54; Wed, 29 Mar 2023 23:46:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Subject: Re: [xdp-hints] [PATCH bpf RFC-V2 1/5] xdp: rss hash types
 representation
In-Reply-To: <168010734324.3039990.16454026957159811204.stgit@firesoul>
References: <168010726310.3039990.2753040700813178259.stgit@firesoul>
 <168010734324.3039990.16454026957159811204.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 29 Mar 2023 23:46:08 +0200
Message-ID: <87355nnsdb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 7133017bcd74..81d41df30695 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -721,12 +721,14 @@ __bpf_kfunc int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *tim
>   * @hash: Return value pointer.
>   *
>   * Return:
> - * * Returns 0 on success or ``-errno`` on error.
> + * * Returns (positive) RSS hash **type** on success or ``-errno`` on error.

This change is going to break any BPF program that does:

if (!bpf_xdp_metadata_rx_hash(ctx, &hash))
  /* do something with hash */


so I think adding a second argument is better; that way, at least
breakage will be explicit instead of being a hidden change in semantics
(and the CO-RE style checking for kfuncs Alexei introduced should
trigger correctly).

But really, what we should do anyway is merge this during the -rc phase
to minimise any breakage :)

-Toke

