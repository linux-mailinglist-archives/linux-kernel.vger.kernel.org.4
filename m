Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD16DF753
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjDLNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDLNgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CB112A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681306479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avnUO+n0BtEa4d40ZQG2oXgOaFPN9DVhnjMogjSitH8=;
        b=Xeb/0xJElLv/x2I8MD/DQDpD58lunIZb/q6djhkEmuZJSOtBDjw/phqETFrM1XvcCkJJjU
        UFAyeYYpnkhtjLr6RDrCktdy2tJ4uZ++JGJoMDr4G18AqZW6YE1ABgkyqa7jhsED0Y+ACD
        7hFwGMvBNcOjvq3lVGWMAor61ZMR/S4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-WJCVsKfzO7iC_ZSPnhIThA-1; Wed, 12 Apr 2023 09:34:38 -0400
X-MC-Unique: WJCVsKfzO7iC_ZSPnhIThA-1
Received: by mail-ej1-f72.google.com with SMTP id vx12-20020a170907a78c00b0094a9009d99bso3687098ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681306477;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avnUO+n0BtEa4d40ZQG2oXgOaFPN9DVhnjMogjSitH8=;
        b=G8bZ7AtFImVjdna9ntwG86QY1NwHDLws5cyGfEM5aBUPl4C1DwnpZ/hNAekIaa4d69
         u07XxZTB6f8ELx1N/hMjY21m691egW+30GHo7Sj28Ito1n7vfcPJjddLSRLFcAePMVTc
         fx/eqAGYNPRL+0luGG3OTfaC03FV1GNWe8T24ZgTjxGxHYyGm7zwsmVkIJtuN5xitNXs
         N/WJfrDbiqMn3yvPjJxhCCoiIJWF8R2iNrE5Gnaeh5xcpC7erhStShb8ukG5FlByLAwT
         JvxqNnPX0eiAiWNASTREj5a0/xo6zaYyoeFk4YHXncpstS4yP8hXLw+fwZmOgLQREgQc
         khAA==
X-Gm-Message-State: AAQBX9emkHQW3X/YYzknNYyQSmansOUDrkNj/mADhaQ2BCLURXaHs2pa
        PSzOo327H+tcMkjlebqajbZaHsTvw5L8tYcAf3slHQmi3EsjXbUS0pZCKJ7vbeGSkiYFi/34qs8
        r8b6ybmGi/JvJqV4JhgwL3UqV
X-Received: by 2002:a17:906:99c8:b0:8e6:bcb6:469e with SMTP id s8-20020a17090699c800b008e6bcb6469emr2343008ejn.0.1681306476782;
        Wed, 12 Apr 2023 06:34:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350YgapZMeMC4Rm/QdXzs4rXyxXgFabYvm7ZL0sTQJ3wSeNGkMdybuNwlZL/acPVv3QhRoQAsuw==
X-Received: by 2002:a17:906:99c8:b0:8e6:bcb6:469e with SMTP id s8-20020a17090699c800b008e6bcb6469emr2342948ejn.0.1681306475958;
        Wed, 12 Apr 2023 06:34:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906319600b00930525d89e2sm7264423ejy.89.2023.04.12.06.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:34:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 00D35AA78D2; Wed, 12 Apr 2023 15:34:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kal Cutter Conley <kal.conley@dectris.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
In-Reply-To: <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer>
 <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 12 Apr 2023 15:34:34 +0200
Message-ID: <875ya12phx.fsf@toke.dk>
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

Kal Cutter Conley <kal.conley@dectris.com> writes:

>> > > Add core AF_XDP support for chunk sizes larger than PAGE_SIZE. This
>> > > enables sending/receiving jumbo ethernet frames up to the theoretical
>> > > maxiumum of 64 KiB. For chunk sizes > PAGE_SIZE, the UMEM is required
>> > > to consist of HugeTLB VMAs (and be hugepage aligned). Initially, only
>> > > SKB mode is usable pending future driver work.
>> >
>> > Hmm, interesting. So how does this interact with XDP multibuf?
>>
>> To me it currently does not interact with mbuf in any way as it is enabled
>> only for skb mode which linearizes the skb from what i see.
>>
>> I'd like to hear more about Kal's use case - Kal do you use AF_XDP in SKB
>> mode on your side?
>
> Our use-case is to receive jumbo Ethernet frames up to 9000 bytes with
> AF_XDP in zero-copy mode. This patchset is a step in this direction.
> At the very least, it lets you test out the feature in SKB mode
> pending future driver support. Currently, XDP multi-buffer does not
> support AF_XDP at all. It could support it in theory, but I think it
> would need some UAPI design work and a bit of implementation work.
>
> Also, I think that the approach taken in this patchset has some
> advantages over XDP multi-buffer:
>     (1) It should be possible to achieve higher performance
>         (a) because the packet data is kept together
>         (b) because you need to acquire and validate less descriptors
> and touch the queue pointers less often.
>     (2) It is a nicer user-space API.
>         (a) Since the packet data is all available in one linear
> buffer. This may even be a requirement to avoid an extra copy if the
> data must be handed off contiguously to other code.
>
> The disadvantage of this patchset is requiring the user to allocate
> HugeTLB pages which is an extra complication.
>
> I am not sure if this patchset would need to interact with XDP
> multi-buffer at all directly. Does anyone have anything to add here?

Well, I'm mostly concerned with having two different operation and
configuration modes for the same thing. We'll probably need to support
multibuf for AF_XDP anyway for the non-ZC path, which means we'll need
to create a UAPI for that in any case. And having two APIs is just going
to be more complexity to handle at both the documentation and
maintenance level.

It *might* be worth it to do this if the performance benefit is really
compelling, but, well, you'd need to implement both and compare directly
to know that for sure :)

-Toke

