Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A806D9FFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbjDFSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbjDFSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A777E5FDB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680806289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cL0xEv36os7K6igc2mQAflPTjWsCcGWjiQ4JpavLjnU=;
        b=Yy9eM+eMTQ1V1UjpsAGiDyVGbAnbN3nHk+MakqTnF8S0TEAjfEdLeQNDdzd1IAKYq6Dws3
        G6X3aQ6KoEvYrNX3elZblmSlLkngH8DOt4XOWoibeg/9jqE+TKUgY7NQcCT4qi44ZBetJW
        KDFImEFGvL+oE29rLghQiYE9hcSRlrw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-uQp7gJRbMMiS-I0FS_r8kA-1; Thu, 06 Apr 2023 14:38:08 -0400
X-MC-Unique: uQp7gJRbMMiS-I0FS_r8kA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-4fa77edcbf5so762683a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806287;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cL0xEv36os7K6igc2mQAflPTjWsCcGWjiQ4JpavLjnU=;
        b=uSegcLReoP5ViUviY9eNsrNAKav96d82ouY6w7VJbiAzdEqbp8hyG0D7WAYqk+FO7d
         CxyF6i7MT9HmfSQ+UGfZDVjQva5eugPsF4g8dFfNBzx8dRB0BKAWi6pO8hssUEhwMayc
         XZ2KbdIupesgjHJQz+gDEYNf2MuN4lEusTaNr2ZoD3F4EperOKhj50BA2ycTP8mOtsjA
         7CVdMWBOLkzLiCa6ldrNI3WmFcVWUIWMLoI3GfRIMATNoqxGug7+nysK5EzcdXdAwkxe
         bkBFf9A5tOFtfWNJ53R8tvbUFTlidCjkb8ZZA5X5QkB8VeResJ6QhN3dZzlYbfsGJacJ
         IE5g==
X-Gm-Message-State: AAQBX9fpYdWPO0FlGieKgTw+F+d1+HNcsE3iT/7iMOsseOSw6DdxI0ZU
        gEdp6iBAhKE7iXFOlHeYW1M3xzm9dGAXIWMs3irsOz6qmWSagJJLGvlR+ri9SQ7YOwDcTFvGIQ+
        jou0PpJ+fVCaTpEXib83s9yy9
X-Received: by 2002:a05:6402:70e:b0:4fc:535c:3aa1 with SMTP id w14-20020a056402070e00b004fc535c3aa1mr475747edx.10.1680806287233;
        Thu, 06 Apr 2023 11:38:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bn8KXU73iNBODtP7YbUGAxE1utUCnkQ8ktBabX2iMDmsXj0FzDJn95e86pszBxnyLCKIdpYQ==
X-Received: by 2002:a05:6402:70e:b0:4fc:535c:3aa1 with SMTP id w14-20020a056402070e00b004fc535c3aa1mr475715edx.10.1680806286873;
        Thu, 06 Apr 2023 11:38:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x102-20020a50baef000000b004af73333d6esm1047561ede.53.2023.04.06.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:38:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3FD93A746CA; Thu,  6 Apr 2023 20:38:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kal Conley <kal.conley@dectris.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
In-Reply-To: <20230406130205.49996-2-kal.conley@dectris.com>
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 06 Apr 2023 20:38:05 +0200
Message-ID: <87sfdckgaa.fsf@toke.dk>
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

Kal Conley <kal.conley@dectris.com> writes:

> Add core AF_XDP support for chunk sizes larger than PAGE_SIZE. This
> enables sending/receiving jumbo ethernet frames up to the theoretical
> maxiumum of 64 KiB. For chunk sizes > PAGE_SIZE, the UMEM is required
> to consist of HugeTLB VMAs (and be hugepage aligned). Initially, only
> SKB mode is usable pending future driver work.

Hmm, interesting. So how does this interact with XDP multibuf?

-Toke

