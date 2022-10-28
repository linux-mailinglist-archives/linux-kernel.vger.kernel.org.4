Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC71B6114D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJ1OlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJ1OlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85278D123
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666968004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8u03zJ9W/9aPpgScCpedLnCuBIcs476DTocYuAgwTQ=;
        b=MsI90uqhsa0YrFXIyXrlSXPrfOc4u5g6N+ZcbKjvHO/LBBvypdtQL/zkEiJQsN0cAMOp5c
        NTZ4lEGYwrwRIl83bWStzJEBcYDWEFYc9clXmisnuriSZuDp2oAP9fsblwUkaYR9qMGeeW
        R6ZTBtdvJJLzEwdbd2rogdKqVdK0TWg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-5igu3YbxOgSxpndkx9YOIQ-1; Fri, 28 Oct 2022 10:40:02 -0400
X-MC-Unique: 5igu3YbxOgSxpndkx9YOIQ-1
Received: by mail-io1-f70.google.com with SMTP id u11-20020a6b490b000000b006bbcc07d893so4465249iob.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8u03zJ9W/9aPpgScCpedLnCuBIcs476DTocYuAgwTQ=;
        b=StVzY5KlaT6PKBKbXXn8buDjcKhwWtD3RCPnvvh5B/NcE+HU8rEHl0fIq37kA71u3g
         jRf6fVfAt7bYJ6Px7cw7GZb/+aH17IOk/vUHV7M7kEcUAqe2CEOfPLMa1R+Z0WKyi6UM
         JXpX7Ll8rfxFpvMMpLuvIOh9bc3X905pelReFuwhM9luprZ5iCeN+H2LSaQs543fjx4d
         DuLDGbhxTLb6JaZY1FbN+qV6QGdAwTo58X5AL7uAoXWvQ2RtFf1Wwdewvebyj8rbzoKE
         G3C9PdjJGFFElsBXXlqnMtKTygt4Z0cTvIIIEndYuS4Rt89cWYMLCRopSVygsC5cTIgk
         2W0w==
X-Gm-Message-State: ACrzQf2cdv2FsrdlcrrZeH1VZI0bdUyZAvg1XpCJeS4BvW/+7ZOEzgp4
        XpM8424tSihenMhrf0CTZSL8bES2wC7UjKokO0hgCO3EazXjgijGQZu5pMHU295M0Tiy1wrM1ih
        PMTxng3wJ0LTh//+Ua82hcCag
X-Received: by 2002:a6b:3ed4:0:b0:6b6:9e4b:4c40 with SMTP id l203-20020a6b3ed4000000b006b69e4b4c40mr33778060ioa.11.1666968001860;
        Fri, 28 Oct 2022 07:40:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7BP97wXNo6tvFx31on64A0evagjI1RVqWCRAz+6aF8sGPc1Byafy0wFnz/lBsANsOPjWzrUA==
X-Received: by 2002:a6b:3ed4:0:b0:6b6:9e4b:4c40 with SMTP id l203-20020a6b3ed4000000b006b69e4b4c40mr33778040ioa.11.1666968001559;
        Fri, 28 Oct 2022 07:40:01 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id e18-20020a026d52000000b003740de9fb65sm1803968jaf.46.2022.10.28.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:40:00 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:39:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yuanzheng Song <songyuanzheng@huawei.com>,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH STABLE 5.10] mm/memory: add non-anonymous page check in
 the copy_present_page()
Message-ID: <Y1vpvzaU322ENcEc@x1n>
References: <20221024094911.3054769-1-songyuanzheng@huawei.com>
 <3823471f-6dda-256e-e082-718879c05449@google.com>
 <Y1nRiJ1LYB62uInn@x1n>
 <fffefe4-adce-a7d-23e0-9f8afc7ce6cf@google.com>
 <Y1qdY8oUlUvWl067@x1n>
 <8aad435-bdc6-816f-2fe4-efe53abd6e5@google.com>
 <Y1sMk30wS+1uH/hc@x1n>
 <432c4428-b6d4-f93-266-b920a854c3c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <432c4428-b6d4-f93-266-b920a854c3c@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 06:32:01PM -0700, Hugh Dickins wrote:
> Sorry for leading everyone astray: my mistake was to suppose that
> its !PageAnon check was simply to avoid the later BUG_ON(!anon_vma):
> whereas David and Peter now agree that it actually corrects the
> semantics for fork() on file pages.

Thanks for raising this from the start, Hugh.  It's definitely worthwhile
to discuss this topic which is not obvious at all at least to me, and merge
even the same patch would be different before/after such a discussion,
since we're clearer on the side effects.

> 
> I lift my hold on Yuanzheng's patch: nobody actually said "Acked-by",
> but I think the discussion and resolution have given better than that.
> (No 3rd thoughts please!)

I've acked directly on v2, note that after this discussion IMHO the comment
of !Anon check can be slightly improved (e.g. add some more information on
why we decided to not copy the page even if anon_vma existed), but I don't
want to be harsh on any stable backports that helps resolving problems
already in correct ways.

Thanks,

-- 
Peter Xu

