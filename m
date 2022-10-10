Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD95FA068
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJJOrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJJOrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:47:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9282F6D9D1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:47:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 3so9418203pfw.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmLmBuwnxY8079sNUZWy0seIJQJaeaJcXLUydQ13od4=;
        b=lMC87aE7ClxvxqaDEhP79ZEp0tBmRmu+BkcZr8zS6xu7nIHlEsB9ZJ3vb/IuWuD+pf
         28WviVdssVyD/ndnYFGbKdG5ahbgil7XM/o0TJypCqzm4AUwRAypqrw7xakYSEslJrq3
         Y9Ms+9vY1Tuxeq7xs7wfdlQtWVg55I2MF1EvZsyBpgY4lCGtx54E51q9gXSyCwR6es5+
         w5QsDzPM2nVquMXELBOKVv0oD72W1+MXizrXbs/d9rfWd7Ra2sKm6wHSvhBBXDrs+Bgo
         Bj/zEHwd2Y21i4EeSOKQ2X/EwkdYdpLTcp1k5xzfD1etNR35nS9nfZqGMcuox5Onolnd
         FrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmLmBuwnxY8079sNUZWy0seIJQJaeaJcXLUydQ13od4=;
        b=12tYllJuguojDR5a2eU2wWMDdTwTuJEXbjeD7VmnE2dqlcqXH/OvtqrRDBFNK9zHjj
         xeFsjesvvWzc4HZC5NaaHfSIY7iHkqPbZMrMmM24zn6eBcsT0c5f/m8OVpiY51SRaAFj
         EO8c5KXvCMQsu9SuK9GOBftoB1id4ygfzVl0uJ9bWdoWZxxfy5DbPszOHDrjdc0aMNeT
         ssG/VL+Oo7WQQXH4rMvNxNOA+RzZbhXgWSva0Fqu+/bWLbJE//99TbxLpZT2QOp2P3kq
         eKH4c4LOQC4NYs0Nv3ZQzvHmNveD9Z+GLKLKlRom2LyZqBcH1mz8+zKt08+7anma9WRL
         UoQg==
X-Gm-Message-State: ACrzQf0AHISrqABha7EsEkjMqlToKIVOzSY7plhymtl/O3NZmTKPI/uZ
        cQc6EVTZQxA3noqRdO6hjy23w5AZiX/1Ng==
X-Google-Smtp-Source: AMsMyM6KkS7WCUWfdYXh1/HGf88nF6b5wKp19VPh6dCGXHtc8IvTX6/LKE4CtCGKv72UH4EPHy1pLQ==
X-Received: by 2002:a63:6cca:0:b0:43c:7998:8a78 with SMTP id h193-20020a636cca000000b0043c79988a78mr16766082pgc.600.1665413228373;
        Mon, 10 Oct 2022 07:47:08 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id i4-20020a63bf44000000b0044046aec036sm6247938pgo.81.2022.10.10.07.47.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2022 07:47:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
Date:   Mon, 10 Oct 2022 07:47:06 -0700
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
 <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
 <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
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

On Oct 10, 2022, at 12:24 AM, Alexander Atanasov =
<alexander.atanasov@virtuozzo.com> wrote:

> Hello,
>=20
> On 10.10.22 9:18, Nadav Amit wrote:
>> On Oct 7, 2022, at 3:58 AM, Alexander Atanasov =
<alexander.atanasov@virtuozzo.com> wrote:
>>> So all balloon drivers give large amount of RAM on boot , then =
inflate the balloon. But this places have already been initiallized and =
they know that the system have given amount of totalram which is not =
true the moment they start to operate. the result is that too much space =
gets used and it degrades the userspace performance.
>>> example - fs/eventpoll.c:static int __init eventpoll_init(void) - 4% =
of ram for eventpool - when you inflate half of the ram it becomes 8% of =
the ram - do you really need 8% of your ram to be used for eventpool?
>>>=20
>>> To solve this you need to register and when notified update - cache =
size, limits and for whatever is the calculated amount of memory used.
>> Hmm.. Not sure about all of that. Most balloon drivers are manually =
managed,
>> and call adjust_managed_page_count(), and tas a result might want to =
redo
>> all the calculations that are based on totalram_pages().
>=20
> Yes, i will say that it looks like mixed manual - for large changes =
and automatic for small changes. VMWare and HyperV have automatic and =
manual/not sure exactly what you can change on a running VM but i guess =
you can/ - Virtio is only manual. I do not know about dlpar / xen.
>=20
> Scenario is like this start a VM with 4GB ram, reduce to 2GB with =
balloon - vm can be upgraded.
>=20
> All we are talking about relates to memory hotplug/unplug /where =
unplug is  close to nonexistant hence the balloons are used./
>=20
> All values should be recalculated on memory hotplug too, so you can =
use the newly available RAM.
>=20
> RAM is the most valuable resource of all so i consider using it =
optimally to be of a great importance.
>=20
>> Side-note: That=E2=80=99s not the case for VMware balloon. I actually =
considered
>> calling adjust_managed_page_count() just to conform with other =
balloon
>> drivers. But since we use totalram_pages() to communicate to the =
hypervisor
>> the total-ram, this would create endless (and wrong) feedback loop. I =
am not
>> claiming it is not possible to VMware balloon driver to call
>> adjust_managed_page_count(), but the chances are that it would create =
more
>> harm than good.
>=20
> Virtio does both - depending on the deflate on OOM option. I suggested =
already to unify all drivers to inflate the used memory as it seems more =
logical to me since  no body expects the totalram_pages() to change but =
the current state is that both ways are accepted and if changed can =
break existing users.
> See  discussion here =
https://lore.kernel.org/lkml/20220809095358.2203355-1-alexander.atanasov@v=
irtuozzo.com/.

Thanks for the reminder. I wish you can somehow summarize all of that =
into the
cover-letter and/or the commit messages for these patches.

>=20
>=20
>> Back to the matter at hand. It seems that you wish that the notifiers =
would
>> be called following any changes that would be reflected in =
totalram_pages().
>> So, doesn't it make more sense to call it from =
adjust_managed_page_count() ?
>=20
> It will hurt performance - all drivers work page by page , i.e. they =
update by +1/-1 and they do so under locks which as you already noted =
can lead to bad things. The notifier will accumulate the change and let =
its user know how much changed, so the can decide if they have to =
recalculate - it even can do so async in order to not disturb the =
drivers.

So updating the counters by 1 is ok (using atomic operation, which is =
not
free)? And the reason it is (relatively) cheap is because nobody =
actually
looks at the value (i.e., nobody actually acts on the value)?

If nobody considers the value, then doesn=E2=80=99t it make sense just =
to update it
less frequently, and then call the notifiers?

>>> The difference is here:
>>>=20
>>> mm/zswap.c:     return totalram_pages() * zswap_max_pool_percent / =
100 <
>>> mm/zswap.c:     return totalram_pages() * zswap_accept_thr_percent / =
100
>>> uses percents and you can recalculate easy with
>>>=20
>>> +static inline unsigned long totalram_pages_current(void)
>>> +{
>>> +       unsigned long inflated =3D 0;
>>> +#ifdef CONFIG_MEMORY_BALLOON
>>> +       extern atomic_long_t mem_balloon_inflated_free_kb;
>>> +       inflated =3D =
atomic_long_read(&mem_balloon_inflated_free_kb);
>>> +       inflated >>=3D (PAGE_SHIFT - 10);
>>> +#endif
>>> +       return (unsigned long)atomic_long_read(&_totalram_pages) - =
inflated;
>>> +}

So we have here two values and it appears there is a hidden assumption =
that
they are both updated atomically. Otherwise, it appears, inflated
theoretically might be greater that _totalram_pages dn we get negative =
value
and all hell breaks loose.

But _totalram_pages and mem_balloon_inflated_free_kb are not updated
atomically together (each one is, but not together).

>>> And you are good when you switch to _current version - =
si_meminfo_current is alike .
>>>=20
>>> On init (probably) all use some kind of fractions to calculate but =
when there is a set value via /proc/sys/net/ipv4/tcp_wmem for example it =
is just a value and you can not recalculate it. And here, please, share =
your ideas how to solve this.
>> I don=E2=80=99t get all of that. Now that you provided some more =
explanations, it
>> sounds that what you want is adjust_managed_page_count(), which we =
already
>> have and affects the output of totalram_pages(). Therefore, =
totalram_pages()
>> anyhow accounts for the balloon memory (excluding VMware=E2=80=99s). =
So why do we
>> need to take mem_balloon_inflated_free_kb into account?
> Ok, you have this:
>                                   / totalram
> |----used----|b1|----free------|b2|
>=20
> drivers can inflate both b1 and b2 - b1 free gets smaller, b2 totalram =
pages get smaller. so when you need totalram_pages() to do a calculation =
you need to adjust it with the pages that are inflated in free/used =
(b1). VMWare is not exception , Virtio does the same.
> And according to to mst and davidh it is okay like this.
> So i am proposing a way to handle both cases.

Ugh. What about BALLOON_INFLATE and BALLOON_DEFLATE vm-events? Can=E2=80=99=
t this
information be used instead of yet another counter? Unless, of course, =
you
get the atomicity that I mentioned before.

>> Sounds to me that all you want is some notifier to be called from
>> adjust_managed_page_count(). What am I missing?
>=20
> Notifier will act as an accumulator to report size of change and it =
will make things easier for the drivers and users wrt locking.
> Notifier is similar to the memory hotplug notifier.

Overall, I am not convinced that there is any value of separating the =
value
and the notifier. You can batch both or not batch both. In addition, as =
I
mentioned, having two values seems racy.

