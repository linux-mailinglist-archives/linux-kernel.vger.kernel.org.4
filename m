Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4368C1B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjBFPgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjBFPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:35:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFBA2E0D7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675697496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ViNvh2IavPltRwIS2u0eTkOgWpB6sQmqMz+8YaqMvr0=;
        b=S5KomHRGBXhvjRwtJCjKqgeRyCY/0AMA/IEpTpQfyE20MtBaJubH+6q4ImN0okHtBzjnl6
        aTe8YAwhK2VOHDOqUM8QT1TVFMbKkKIQSUSLDvhUGjKuMss2yvhQmoZugLUgVVriGA5Thu
        JecjUekTJWroKaGw70AhQYMQw7tF0dU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-U0N1-WNOPO233MrcuMYppg-1; Mon, 06 Feb 2023 10:31:34 -0500
X-MC-Unique: U0N1-WNOPO233MrcuMYppg-1
Received: by mail-io1-f71.google.com with SMTP id k4-20020a6b7e44000000b0071e11cafea7so7169044ioq.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViNvh2IavPltRwIS2u0eTkOgWpB6sQmqMz+8YaqMvr0=;
        b=OssmVxumYLZbVdiTmMOsWSNx6x8CGe8/E/V+Wac3HlX7+9KO2Z65TdPRbFPqKZrHjN
         YfnIdg6RGNO+WeMOZ+axFpxXRBFcN2FCDnvxmwJr9KmieNcs+JWfH4QDUYrD0ltgsdMd
         LgTEO87eQLnqXgROpej5MNnXyLSyvahIi2+0RTH3ZW2/QGGmxuD1OFVi0K3q4DrT4rm5
         ujzFGKtBe8uT6lnPPXHIP+suFQBKcnbT076HOhEpZsXDuh+DnDZX7odxGIYQt3uvLoNe
         C/qu3hrYda3J253KBU4XPPlQvIK7Af5S7udjg6TlahFcNdBO+7TI+WcxXQ5h7otYuDCj
         ZWWQ==
X-Gm-Message-State: AO0yUKWLnkK17QXs0F7UKvv1O+M6oNyCSo3ewYsbuu63oU3TVjZr2fL/
        rlLN2nMwr3RyJSXzek3kEod2QRlhgpCV7nFQ5QVJLGUg6Pxrgz3D8movwDKyx/gAwRFRI9qRMk3
        vunbrL8tDUGod2Vttn3y+b48I6TFK8eiH9uYQM2WZ
X-Received: by 2002:a92:2003:0:b0:30f:37f5:8520 with SMTP id j3-20020a922003000000b0030f37f58520mr4264639ile.63.1675697493948;
        Mon, 06 Feb 2023 07:31:33 -0800 (PST)
X-Google-Smtp-Source: AK7set8hCwd+me3+fYn1guoCKfdAzafeoQiTQpA+TBWgprx+HN0/zGbagcHaITaEMm2xP2+TKjAWyE38obGRBKZ4NwA=
X-Received: by 2002:a92:2003:0:b0:30f:37f5:8520 with SMTP id
 j3-20020a922003000000b0030f37f58520mr4264630ile.63.1675697493785; Mon, 06 Feb
 2023 07:31:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com> <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com> <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com> <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com> <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
 <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
 <CAL7ro1Hc4npP9DQjzuWXJYPTi9H=arLstAJvsBgVKzd8Cx8_tg@mail.gmail.com> <678002cf-f847-d5c3-a79b-5bebd3c1e518@linux.alibaba.com>
In-Reply-To: <678002cf-f847-d5c3-a79b-5bebd3c1e518@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Mon, 6 Feb 2023 16:31:22 +0100
Message-ID: <CAL7ro1G59CGj99YKJYAP=8W+sejE+q=XqXtYjmiXXP9=xVcjwA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
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

On Mon, Feb 6, 2023 at 2:27 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> On 2023/2/6 20:43, Alexander Larsson wrote:
> >
> > One problem I ran into is that erofs seems to only support mounting
> > filesystem images that are created with the native page size. This
> > means I can't mount a erofs image created on a 4k page-size machine on
> > an arm64 mac with 64k pages. That doesn't seem great. Maybe this
> > limitation can be lifted from the erofs code though.
>
> Honestly, EROFS 64k support has been in our roadmap for a quite long
> time, and it has been almost done for the uncompressed part apart from
> replacing EROFS_BLKSIZ to erofs_blksiz(sb).

Good, as long as it is on the roadmap.

> Currently it's not urgent just because our Cloud environment always use
> 4k PAGE_SIZE, but it seems Android will consider 16k pagesize as well, so
> yes, we will support !4k page size for the uncompressed part in the near
> future.  But it seems that arm64 RHEL 9 switched back to 4k page size?

Honestly I'm not following it all that closely, but I think Fedora was
at least talking about 64k pages.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

