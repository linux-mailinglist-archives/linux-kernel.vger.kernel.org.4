Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9605B3719
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIIMIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiIIMIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C8D13810C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662725316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zXr68Ku17TqRx7WZIlisO7PY+izsxHqFvN1+7uz8BY=;
        b=RHnrB20Z0vzPWl+eBeMd1bOrGahIzevDj5TL4kLpXMQw6+4uZ7ppjYYQRI0FeIdrA+DwVx
        2UB89cVs8PTIS9kiTDVORjmQ2uv68JeSHbPG/ysiRnjGUwrinSEFtvODvkX6RPJ1JCpxzL
        5Nnl/JaJ+ToPlu24XMxtNN9pG4lKx2s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-InZwhu-POJypt-WQl67BIg-1; Fri, 09 Sep 2022 08:08:34 -0400
X-MC-Unique: InZwhu-POJypt-WQl67BIg-1
Received: by mail-io1-f72.google.com with SMTP id o10-20020a6b5a0a000000b0068aba769d73so1212188iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0zXr68Ku17TqRx7WZIlisO7PY+izsxHqFvN1+7uz8BY=;
        b=UTxqr6NuT/CNXKper3o9jQPCjkzfPOpoWzJCbdazYSDRrycGJT4wb8gL37/SSoC3/7
         pXSMHifDUhXpf6kX4qtootSr3iE8dzTmCu/f6C8Hg/fFO5IvEIDMnw+W3iIvSaQWojov
         M5JSVLq0LtLeWNDZtTQXeSYT9ncScH3P9NeqgGZMQiez3PG52BmsdbOBMX/riWbqQzEZ
         YNKhazQl4yBki84YlFp7aAEdp50WCELV9rbsviPiG1SdbntIivHsc9racjHECt+Nb31Y
         ej/8N6VMhR4JE+2zrTkGKoJvJ1szqkZqMqVEml4UdBLFo3sOFPqcujSk9IKEaBycyQg0
         UEsw==
X-Gm-Message-State: ACgBeo3qEXi5yUgjy4/06tINZdpgVkwFLEJmcmnnv1WTXUsrgu0hoUVr
        8qtwZHa/Bxgrj0dl2USRuV8VzSgI+MMhcqIh8CdhgGAruF+XV3R8ercMrFYWwvK3vEBd4ks79cD
        5eMi4jM/Uf+tMWmHuzfyC1PZa
X-Received: by 2002:a05:6602:1691:b0:68d:8e03:197b with SMTP id s17-20020a056602169100b0068d8e03197bmr6694185iow.190.1662725314162;
        Fri, 09 Sep 2022 05:08:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5iSRx1+fKzoqaDdK1SGGLBKpq8PLWfkyRCyK8z6gMVXMYQAnQZDmTYSNyT4G7AZUQrY+aZ8g==
X-Received: by 2002:a05:6602:1691:b0:68d:8e03:197b with SMTP id s17-20020a056602169100b0068d8e03197bmr6694175iow.190.1662725313935;
        Fri, 09 Sep 2022 05:08:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g15-20020a05663810ef00b00358422fcc7bsm126205jae.120.2022.09.09.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:08:33 -0700 (PDT)
Date:   Fri, 9 Sep 2022 06:08:32 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [GIT PULL] VFIO fix for v6.0-rc5
Message-ID: <20220909060832.17f6607f.alex.williamson@redhat.com>
In-Reply-To: <CAHk-=wj3rrkPvPJB_u4qoHK4=PVUuBHKB67f_oZO62EE22pNPQ@mail.gmail.com>
References: <20220909045225.3a572a57.alex.williamson@redhat.com>
        <CAHk-=wj3rrkPvPJB_u4qoHK4=PVUuBHKB67f_oZO62EE22pNPQ@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2022 07:53:17 -0400
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Sep 9, 2022 at 6:52 AM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > VFIO fix for v6.0-rc5
> >
> >  - Fix zero page refcount leak (Alex Williamson)  
> 
> Ugh. This is disgusting.
> 
> Don't get me wrong - I've pulled this, but I think there's some deeper
> problem that made this patch required.
> 
> Why is pin_user_pages_remote() taking a reference to a reserved page?
> Maybe it just shouldn't (and then obviously we should fix the unpin
> case to match too).
> 
> Adding a few GUP people to the participants for comments.
> 
> Anybody?

Yes, David is working on allocating pages rather than pinning the zero
page, however that's going to have some user visible locked memory
accounting changes.  This isn't the long term solution, it's only meant
to close the shared zero page refcount holes we have currently.  Thanks,

Alex

