Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA18A64C12A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiLNA3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiLNA3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD3313DD7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670977705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKxbAmDy4kBbnLLyS6DnUH8pcciN3a5kpJSNy5AHjoU=;
        b=EaweofYUQfc2F5U1tnC1+k3OlzJIUjYLBGWBttdZYrqPfbtmW6+UHMUNfl5Q/vIElf0Kqi
        F7buPYe0/ssjl60wFir6kOlpi+iO08xUo3rCMF17htai/9p58cPGMIaaK1u5Udh78Uh9NZ
        8xVpcRgeMZi60T/iHBvW8NY9l/lN4Vc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-7i-1xNtFPJCls4KXJYB4qA-1; Tue, 13 Dec 2022 19:28:24 -0500
X-MC-Unique: 7i-1xNtFPJCls4KXJYB4qA-1
Received: by mail-yb1-f197.google.com with SMTP id i19-20020a253b13000000b0070358cca7f7so18457727yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKxbAmDy4kBbnLLyS6DnUH8pcciN3a5kpJSNy5AHjoU=;
        b=W2BRZQNDmrQxJtbbmTAGlBb10CSstDxmj3RIi3fBGjNR0RLgLWc+6Q7HEdpfv43sbR
         M0YHjZwBRYbcD+iVYgR4CAXMwJWBctyDbOLu68+6RQu5NEhqO43m38u62cw43oYw4DN3
         0puA+sG+fe2vbPU1nVNJcehq0Ot48fSidKTkWfz+icDBzowlJRtlyqy56fA0uNZBZ4rI
         Fug/7oTziD3fRVnjF3+oF0GesdshZi9IqzjrY8wmNFil7U3Cc9Xdnj8sQFfY6u6qertz
         gaN5z7Z4d0InRIjuNrBMrlmEf8CPbuNcbEjvAGkMbp1Q/tYYmxeWa4YVPxzKtrZjZmP4
         y9JA==
X-Gm-Message-State: ANoB5pn5Fpg+8tzfcA1l6sglESZ109TLcv+3wUvWaoSiQIHQcQRxD5k1
        1UDVNDzF/gIRvJ0VSykwvRTBrU3RTEOmXctLQQoKQ+RZ0Az/H/TFG8OK270p/4nM9WXiK/fB4Lh
        fRyuOLCbnoaFkWlZOE936I3wnGcJ1iqzX/dkvZSLu
X-Received: by 2002:a25:cf55:0:b0:706:f436:e05a with SMTP id f82-20020a25cf55000000b00706f436e05amr10658841ybg.489.1670977704132;
        Tue, 13 Dec 2022 16:28:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ceicumy6iYOWIsiBBjN5PFlI06lEhjxzctq/SoLQzbbDOkgCLpMjqH8i5tFp9OhA/CmRbvGmRvx5VOKjvxLA=
X-Received: by 2002:a25:cf55:0:b0:706:f436:e05a with SMTP id
 f82-20020a25cf55000000b00706f436e05amr10658834ybg.489.1670977703890; Tue, 13
 Dec 2022 16:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20221213234505.173468-1-npache@redhat.com> <Y5kPKpNp5qCnZEWy@monkey>
 <CAA1CXcB653kDtF90oWUgVA3TDUrJHac-WPe1HdsQtRwtN5B3gA@mail.gmail.com>
In-Reply-To: <CAA1CXcB653kDtF90oWUgVA3TDUrJHac-WPe1HdsQtRwtN5B3gA@mail.gmail.com>
From:   Nico Pache <npache@redhat.com>
Date:   Tue, 13 Dec 2022 17:27:58 -0700
Message-ID: <CAA1CXcDK=bpAbmkwyssja9d7eA3iEtNQ2aNaQo4DkdjV3YvOVA@mail.gmail.com>
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in set_compound_order
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, gerald.schaefer@linux.ibm.com,
        sidhartha.kumar@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the document linked the following approach is even faster
than the one I used due to CPU parallelization:

page[1].compound_nr = ( shift & ~shift) | (-order & shift);

for(int x =0; x< 11;x++){
        unsigned int order = x;
        unsigned long shift = 1U << order;
        printf("order %d output : %lu\n", order, ( shift & ~shift) |
(-order & shift));
}
order 0 output : 0
order 1 output : 2
order 2 output : 4
order 3 output : 8
order 4 output : 16
order 5 output : 32
order 6 output : 64
order 7 output : 128
order 8 output : 256

-- Nico

On Tue, Dec 13, 2022 at 4:53 PM Nico Pache <npache@redhat.com> wrote:
>
> Hi Mike,
>
> Thanks for the pointer! Would the branchless conditional be an
> improvement over the current approach? I'm not sure how hot this path
> is, but it may be worth the optimization.
>
> -- Nico
>
> On Tue, Dec 13, 2022 at 4:48 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 12/13/22 16:45, Nico Pache wrote:
> > > Since commit 1378a5ee451a ("mm: store compound_nr as well as
> > > compound_order") the page[1].compound_nr must be explicitly set to 0 if
> > > calling set_compound_order(page, 0).
> > >
> > > This can lead to bugs if the caller of set_compound_order(page, 0) forgets
> > > to explicitly set compound_nr=0. An example of this is commit ba9c1201beaa
> > > ("mm/hugetlb: clear compound_nr before freeing gigantic pages")
> >
> > There has been some recent work in this area.  The latest patch being,
> > https://lore.kernel.org/linux-mm/20221213212053.106058-1-sidhartha.kumar@oracle.com/
> >
> > --
> > Mike Kravetz
> >

