Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6895F983B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJJGSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiJJGSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:18:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9654C9D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:18:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so9548118pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 23:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYWYA1/DBdsUSF1pq4Iqs0V+J1NFLRK9XVgu/yztoos=;
        b=KgpBWhbO4lmUrxYH1zb3xhj/CgjyanZOTVJiYWT4Rrqz+0ovQXT20N74gTBBM8/71Z
         pHKhjDcMmGkMzC2RdLL+3ttYAFWYN+R1+9VEFvQxaF4a/+lJagraV6+GnEFyYU+cDNWD
         m+fB5ErMyVeCxDooQ5uw7qCBRyB+mMhrMdeeHnR+qwbhEyvNYJ3VQ8fHbhj3kTTYZkfM
         uuk5Chhz/yMsjL6JRtgTY7auVtTm3fkixfoc89UkkIM/Uj4xsUwUKITlhBxeppr5mqj8
         Or2TSjEZ/XCwZ86FKnqNFvzmtBsrL+09OBAxET3gpj774lPrM9fYWbq6TEp5NmBJwL+W
         iuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYWYA1/DBdsUSF1pq4Iqs0V+J1NFLRK9XVgu/yztoos=;
        b=GhToMY8jLABsOCP0kbGmIPd3pfxi+c2LsJ1MGVYT90ed/sDLHiHOmhGbrQ3FYYcBiN
         Ys2KwJ0fCW+gCw4GhMYNhUh0UOyXCxvrNlFzE8WWnWFd69Vb6OIZIDz8lSgFwMFIAkYA
         zDPjD/8e/k3E8htINSysWJUgdy5sj5lfIVGgpF8gbnORa0ht2/g2UXpl6kD32OPOxBAN
         8dT73TNbVwfo7cj3osPuHVHJYaVSVfbWO2t7BQOVUErYb+TWaOYOSpXEhtmsZblIfP/g
         yUg37UPKhYBJIdErmY9iTKV9vH9SUN9wlDlIXvKseZ62Nt90lG4XJ30QRhA3Nr1yJ4OV
         Te5w==
X-Gm-Message-State: ACrzQf1pLHxi/vWu5HIhf2C6mKjXbsdtkUZBuGXZqDZcY6E2xJVfN42y
        6G8pCYO6qzvUbIRnNQ//GXk=
X-Google-Smtp-Source: AMsMyM5q2sP3cRKv2s0qOn6rbuONynmWUqOSKKvRXSpiFi9HliaC+XTLQGmB3trT0BDzam90cHwk6g==
X-Received: by 2002:a63:90c4:0:b0:45f:c571:67eb with SMTP id a187-20020a6390c4000000b0045fc57167ebmr10439170pge.541.1665382715882;
        Sun, 09 Oct 2022 23:18:35 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id e24-20020a63db18000000b0040caab35e5bsm5603309pgg.89.2022.10.09.23.18.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Oct 2022 23:18:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
Date:   Sun, 9 Oct 2022 23:18:32 -0700
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 7, 2022, at 3:58 AM, Alexander Atanasov =
<alexander.atanasov@virtuozzo.com> wrote:

> On 7.10.22 0:07, Nadav Amit wrote:
>>>>=20
>>>> I was looking through the series and I did not see actual users of =
the
>>>> notifier. Usually, it is not great to build an API without users.
>>>=20
>>>=20
>>> You are right. I hope to get some feedback/interest from potential =
users that i mentioned in the cover letter. I will probably split the =
notifier
>>> in separate series. To make it usefull it will require more changes.
>>> See bellow more about them.
>> Fair, but this is something that is more suitable for RFC. Otherwise, =
more
>> likely than not - your patches would go in as is.
>=20
> Yes, i will remove the notifier and resend both as RFC. I think that =
every patch is an RFC and RFC tag is used for more general changes that =
could affect unexpected areas, change functionality, change design and =
in general can lead to bigger impact. In the case with this it adds =
functionality that is missing and it could hardly affect anything else.
> In essence it provides information that you can not get without it.
> But i will take your advice and push everything thru RFC from now on.

Jus keep the version numbers as you had before. That=E2=80=99s fine and =
better to
prevent confusion.

>>>> [snip]
>>>>> +
>>>>> +static int balloon_notify(unsigned long val)
>>>>> +{
>>>>> +	return srcu_notifier_call_chain(&balloon_chain, val, NULL);
>>>> Since you know the inflated_kb value here, why not to use it as an =
argument
>>>> to the callback? I think casting to (void *) and back is best. But =
you can
>>>> also provide pointer to the value. Doesn=E2=80=99t it sound better =
than having
>>>> potentially different notifiers reading different values?
>>>=20
>>> My current idea is to have a struct with current and previous value,
>>> may be change in percents. The actual value does not matter to =
anyone
>>> but the size of change does. When a user gets notified it can act =
upon
>>> the change - if it is small it can ignore it , if it is above some =
threshold it can act - if it makes sense for some receiver  is can =
accumulate changes from several notification. Other option/addition is =
to have si_meminfo_current(..) and totalram_pages_current(..) that =
return values adjusted with the balloon values.
>>>=20
>>> Going further - there are few places that calculate something based =
on available memory that do not have sysfs/proc interface for setting =
limits. Most of them work in percents so they can be converted to do =
calculations when they get notification.
>>>=20
>>> The one that have interface for configuration but use memory values =
can be handled in two ways - convert to use percents of what is =
available or extend the notifier to notify userspace which in turn to do =
calculations and update configuration.
>> I really need to see code to fully understand what you have in mind.
>=20
> Sure - you can check some of the users with git grep totalram_pages - =
shows self explanatory results of usage like:
> fs/f2fs/node.c:bool f2fs_available_free_memory(struct f2fs_sb_info =
*sbi, int type) - calculations in percents - one good example
> fs/ceph/super.h:        congestion_kb =3D =
(16*int_sqrt(totalram_pages())) << (PAGE_SHIFT-10);
> fs/fuse/inode.c:                *limit =3D ((totalram_pages() << =
PAGE_SHIFT) >> 13) / 392;
> fs/nfs/write.c: nfs_congestion_kb =3D (16*int_sqrt(totalram_pages())) =
<< (PAGE_SHIFT-10);
> fs/nfsd/nfscache.c:     unsigned long low_pages =3D totalram_pages() - =
totalhigh_pages()
> mm/oom_kill.c:  oc->totalpages =3D totalram_pages() + =
total_swap_pages;
>=20
>=20
> So all balloon drivers give large amount of RAM on boot , then inflate =
the balloon. But this places have already been initiallized and they =
know that the system have given amount of totalram which is not true the =
moment they start to operate. the result is that too much space gets =
used and it degrades the userspace performance.
> example - fs/eventpoll.c:static int __init eventpoll_init(void) - 4% =
of ram for eventpool - when you inflate half of the ram it becomes 8% of =
the ram - do you really need 8% of your ram to be used for eventpool?
>=20
> To solve this you need to register and when notified update - cache =
size, limits and for whatever is the calculated amount of memory used.

Hmm.. Not sure about all of that. Most balloon drivers are manually =
managed,
and call adjust_managed_page_count(), and tas a result might want to =
redo
all the calculations that are based on totalram_pages().

Side-note: That=E2=80=99s not the case for VMware balloon. I actually =
considered
calling adjust_managed_page_count() just to conform with other balloon
drivers. But since we use totalram_pages() to communicate to the =
hypervisor
the total-ram, this would create endless (and wrong) feedback loop. I am =
not
claiming it is not possible to VMware balloon driver to call
adjust_managed_page_count(), but the chances are that it would create =
more
harm than good.

Back to the matter at hand. It seems that you wish that the notifiers =
would
be called following any changes that would be reflected in =
totalram_pages().
So, doesn't it make more sense to call it from =
adjust_managed_page_count() ?

> The difference is here:
>=20
> mm/zswap.c:     return totalram_pages() * zswap_max_pool_percent / 100 =
<
> mm/zswap.c:     return totalram_pages() * zswap_accept_thr_percent / =
100
> uses percents and you can recalculate easy with
>=20
> +static inline unsigned long totalram_pages_current(void)
> +{
> +       unsigned long inflated =3D 0;
> +#ifdef CONFIG_MEMORY_BALLOON
> +       extern atomic_long_t mem_balloon_inflated_free_kb;
> +       inflated =3D atomic_long_read(&mem_balloon_inflated_free_kb);
> +       inflated >>=3D (PAGE_SHIFT - 10);
> +#endif
> +       return (unsigned long)atomic_long_read(&_totalram_pages) - =
inflated;
> +}
>=20
> And you are good when you switch to _current version - =
si_meminfo_current is alike .
>=20
> On init (probably) all use some kind of fractions to calculate but =
when there is a set value via /proc/sys/net/ipv4/tcp_wmem for example it =
is just a value and you can not recalculate it. And here, please, share =
your ideas how to solve this.

I don=E2=80=99t get all of that. Now that you provided some more =
explanations, it
sounds that what you want is adjust_managed_page_count(), which we =
already
have and affects the output of totalram_pages(). Therefore, =
totalram_pages()
anyhow accounts for the balloon memory (excluding VMware=E2=80=99s). So =
why do we
need to take mem_balloon_inflated_free_kb into account?

Sounds to me that all you want is some notifier to be called from
adjust_managed_page_count(). What am I missing?

