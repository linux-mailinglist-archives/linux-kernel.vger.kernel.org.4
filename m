Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13F67D7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjAZVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjAZVgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9603246A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674768933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPp5FgezLTRv8/n6j2CbiI3M1hJrXQSjOFT+aTSHCWQ=;
        b=HsZgmv7lq+tWmZOZEdLArT4tT1daeynOEU5k4cEXUPrZzbtdiL/0s1hlhBhCZA0kLAzg5e
        Pf/P6AgwwXOSo5rS8rtPF8YeUI/RMaZp5buLZtlMK2Ffb6tvWHQPmeqWL5CEMK4O/Kybw/
        1KRW/+LPGNkLD8zG/hFcLObcNMscVnE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-345-1hAC2-bZNxilllQeEB5UwA-1; Thu, 26 Jan 2023 16:35:30 -0500
X-MC-Unique: 1hAC2-bZNxilllQeEB5UwA-1
Received: by mail-ej1-f71.google.com with SMTP id ds1-20020a170907724100b008775bfcef62so2040860ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPp5FgezLTRv8/n6j2CbiI3M1hJrXQSjOFT+aTSHCWQ=;
        b=aoCrL8LDr00mZdQMBBYWjYgtN+GuLADmJ6eaC9mwKThxxL+E01A6PTATuA9RbChUeb
         DOGkYwqugqGZvSrMg4WJGjfgzXFfls7BKU4HgPKpiN+/vLKbZVywDZ2zChXBp+dFCUjH
         FFS55BR1zXuDrFdHbMjbdgYr5P94M69D/9AutsUzFtIp6VEJ0ngedU4fd2Hg4fDj2jgL
         /4k0Pxc6zcoDtaNkOa9/884edSRPNarxKZjwI+mhvXWdlNJLqBhscS6lFfnI0kFU1ElZ
         C725IiGIv3tbCxCieI1VzKV9mrlzYQVBAD5BB5wvO8NBDg/TCd/ffCzH64IZ4UzmUZHR
         aivA==
X-Gm-Message-State: AFqh2kr6YUESbBh+LIBouHGXkJxKYu54gbion24VC+O+TloNC3Hr2kS2
        U2nsYnKXrIeoovnsK3Efu2rwGO5QVVrXbJuld+nJsklElqt8PRQpI4AoX/Co4WtlNFhvLkzGpoV
        HsgcPYq9a7guBnv4eIpUyCzbX
X-Received: by 2002:a17:906:f299:b0:7c0:fd1a:79ee with SMTP id gu25-20020a170906f29900b007c0fd1a79eemr39636415ejb.63.1674768929148;
        Thu, 26 Jan 2023 13:35:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXse1aQgjk7OzwHyV0hK4unOcklvyKMqYnBLn5Dt4eFYSU4VegC3jZmirDgxa/gkgJwaBBS/EA==
X-Received: by 2002:a17:906:f299:b0:7c0:fd1a:79ee with SMTP id gu25-20020a170906f29900b007c0fd1a79eemr39636386ejb.63.1674768928756;
        Thu, 26 Jan 2023 13:35:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cm20-20020a170907939400b0086f40238403sm1125890ejc.223.2023.01.26.13.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:35:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7327B9430CD; Thu, 26 Jan 2023 22:35:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     nbd@nbd.name, davem@davemloft.net, edumazet@google.com,
        hawk@kernel.org, ilias.apalodimas@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linyunsheng@huawei.com,
        lorenzo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH] skb: Do mix page pool and page referenced frags in GRO
In-Reply-To: <CAKgT0UfsLFuCK0vQF70s=8XC8qwrzxag_NR2dCDvxqx84E0K=g@mail.gmail.com>
References: <04e27096-9ace-07eb-aa51-1663714a586d@nbd.name>
 <167475990764.1934330.11960904198087757911.stgit@localhost.localdomain>
 <87tu0dkt1h.fsf@toke.dk>
 <CAKgT0UfsLFuCK0vQF70s=8XC8qwrzxag_NR2dCDvxqx84E0K=g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Jan 2023 22:35:27 +0100
Message-ID: <87o7qlkmhs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On Thu, Jan 26, 2023 at 11:14 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> Alexander Duyck <alexander.duyck@gmail.com> writes:
>>
>> > From: Alexander Duyck <alexanderduyck@fb.com>
>> >
>> > GSO should not merge page pool recycled frames with standard reference
>> > counted frames. Traditionally this didn't occur, at least not often.
>> > However as we start looking at adding support for wireless adapters th=
ere
>> > becomes the potential to mix the two due to A-MSDU repartitioning fram=
es in
>> > the receive path. There are possibly other places where this may have
>> > occurred however I suspect they must be few and far between as we have=
 not
>> > seen this issue until now.
>> >
>> > Fixes: 53e0961da1c7 ("page_pool: add frag page recycling support in pa=
ge pool")
>> > Reported-by: Felix Fietkau <nbd@nbd.name>
>> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
>>
>> I know I'm pattern matching a bit crudely here, but we recently had
>> another report where doing a get_page() on skb->head didn't seem to be
>> enough; any chance they might be related?
>>
>> See: https://lore.kernel.org/r/Y9BfknDG0LXmruDu@JNXK7M3
>
> Looking at it I wouldn't think so. Doing get_page() on these frames is
> fine. In the case you reference it looks like get_page() is being
> called on a slab allocated skb head. So somehow a slab allocated head
> is leaking through.

Alright, thanks for taking a look! :)

-Toke

