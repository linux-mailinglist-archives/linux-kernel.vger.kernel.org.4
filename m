Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD87265C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFGQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFGQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC0C1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686154956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mHrnG9R4s+c+iNcyk6zQ7fxgQTkZTZ0gNQsPom+d5G0=;
        b=Qar1pE+Kz/Y6WvQFq5gYbuwfRi4AI0MGoqWZbimaII7D2FRu9E2knTBMLpeeAizwJ68/Mq
        zpi7WosM4GW2qtnQRc/hiGKnH8tkcp+TDYqi6qCpDkZPno2rRQJqMG4vVnv0kdIdbhCW0Z
        ky9oT6WH1olUII+PrF+dMnXAenkRu7s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-uM8dhZbGMaCUbb9wPGiawA-1; Wed, 07 Jun 2023 12:22:03 -0400
X-MC-Unique: uM8dhZbGMaCUbb9wPGiawA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-626204b0663so14342766d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686154900; x=1688746900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHrnG9R4s+c+iNcyk6zQ7fxgQTkZTZ0gNQsPom+d5G0=;
        b=cyhXr+xDX0uGUt3nJTHFxCfQCTeM/SuJarMiCPdd8e+NSAKUHYvwg7osE5E93khDxe
         JSFGtB5VjRdhxGwJSWLoXe9AS9EuDa5PY+QFQJnshBLiWupDrJrY9yd0+jRFLIpJMYps
         9pKK2/B6E+/V3K2BLHfcyg/wa/BsEv6+qiyqClPSsDePBziDUWJySo3TqhnBHHVyeEYL
         2fzE2Q0UDnp5PeBDlOqpT3rGFMpKolr3XWFN7gD+jeBQChirMn0pc+1RGH1svqNeOm3Y
         IXmBwyaVsNN8lV0O7BR50SOWgNc373fKxRN2LFxGFA31eL/PiB2MtLsVU3j8FBq7lCR/
         xpJg==
X-Gm-Message-State: AC+VfDyrOZfHxl8S3/+KgYkFoghikSPCtqXhcCZeR/ZTGoIMlITGaQmS
        PNO3XtyIkpf7sU+keo0h5hrUvWOBlZfgsS07FcXxGTH2OTwsWzDvJPR8QUS3l4LFhe4/fmp1V+e
        BgXGuNxtt2TatWQF6V9CGNrmz
X-Received: by 2002:a05:6214:300e:b0:61b:2111:c2e2 with SMTP id ke14-20020a056214300e00b0061b2111c2e2mr6663395qvb.2.1686154899897;
        Wed, 07 Jun 2023 09:21:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/yoyuPYJ0hyJgINcPPC5ifERAaVNoHqfAgbxEJrcaY9uJmpbkD79W2qQpl/pg/cbL/CEUGQ==
X-Received: by 2002:a05:6214:300e:b0:61b:2111:c2e2 with SMTP id ke14-20020a056214300e00b0061b2111c2e2mr6663374qvb.2.1686154899613;
        Wed, 07 Jun 2023 09:21:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id da10-20020a05621408ca00b006238b6bd191sm6148082qvb.145.2023.06.07.09.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 09:21:39 -0700 (PDT)
Date:   Wed, 7 Jun 2023 12:21:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 0/4] mm: Fix pmd_trans_unstable() call sites on retry
Message-ID: <ZICukdhrxcaA74Pp@x1n>
References: <20230602230552.350731-1-peterx@redhat.com>
 <ZICK3uqTeUxeIlc9@x1n>
 <97b5657d-e09d-b3a9-c09d-eaff9fb7929d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97b5657d-e09d-b3a9-c09d-eaff9fb7929d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:45:28PM +0200, David Hildenbrand wrote:
> On 07.06.23 15:49, Peter Xu wrote:
> > On Fri, Jun 02, 2023 at 07:05:48PM -0400, Peter Xu wrote:
> > > Please have a look, thanks.
> > 
> > Hello, all,
> > 
> > This one seems to have more or less conflict with Hugh's rework on pmd
> > collapse.  Please hold off review or merging until I prepare another one
> > (probably based on Hugh's, after I have a closer read).
> > 
> > Sorry for the noise.
> > 
> 
> [did not have time to look yet]
> 
> Are there any fixes buried in there that we'd like to have in earlier? I
> skimmed over the patches and all read like "cleanup" + "consistency",
> correct?

There are bug fixes when unluckily hitting unstable pmd I think, these ones
worth mentioning:

  - pagemap can be broken, causing read to be shifted over to the next
    (wrong data read)

  - memcg wrong accounting, e.g., moving one task from memcg1 to memcg2, we
    can skip an unstable pmd while it could quickly contain something that
    can belong to memcg1, I think.  This one needs some eyes from memcg
    developers.

I don't rush on having them because these are all theoretical and no bug
report I saw, no reproducer I wrote, only observed by my eyes.

At least the pagemap issue should have been there for 10+ years without
being noticed even if rightfully spot this time.  Meanwhile this seems to
have conflict with Hugh's series which should have been posted earlier - I
still need to check on how that will affect this series, but not yet.

Said that, let me know if any of you hit any (potential) issue with above
or think that we should to move this in earlier.

Thanks,

-- 
Peter Xu

