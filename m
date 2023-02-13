Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00CD69436F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBMKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBMKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:49:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327F1815B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676285272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8e0tSRvc+YL951h4sSmsJVVaLhOjRYbzfiUjuNKXVKo=;
        b=PdD0OhFzXr/hA6Zcne8DzbSFclQjWDZ8+U5cwQ9toP2v5rolUbDYTKKlyGpRChOwc+6qIH
        0vijf2hoGGgoyDfMAZa8aY0BkdmT4L+yGggqPNQx787K6eiiXB023eAox1p6XXF/ItGiu7
        hmWelbJM/xp88UgzLnJ5RtRpGXf9S04=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-brMObkysOIGBdvlUfXKENA-1; Mon, 13 Feb 2023 05:47:51 -0500
X-MC-Unique: brMObkysOIGBdvlUfXKENA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-52f2445e802so19512897b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8e0tSRvc+YL951h4sSmsJVVaLhOjRYbzfiUjuNKXVKo=;
        b=OWzSM6et5CAgKU3N/dL5DE6hs2d+iPy2EQ+54FQJmwV889CxH8cd1//yfqKw+3zIcB
         pqCiw3UHgdzTwp2YKN18jnAwwIUrvFZchLqGuskFKmTYW6iJCWjjoaoMZrQhVA629bqw
         /AfGHv1A7RJshuKINrK8PzaY2rvkwH9FKPVRs64lUx09Ffp5eHjVYlTnrGU9CLCXhDSu
         DflIQHKZZnjAbnkn8ERz7cu+9P2LRC7u4vlolqU4rbhsJGtdc5JiDa11xn2u0CBbdhD7
         ECM4OZeFBlR9ResPnAyFJdtqKXIIPd2TnZfaZZfFbOhYwQxvkhDJvNLOO7k8J7VwK2JA
         Fz6g==
X-Gm-Message-State: AO0yUKURHXalRXxNR6QA6Xt0BtIgvOfA9FCMouufYuq4g+xjz1EFq6xH
        6E3bUzojN283qcIEFz/e2tNImut228/vGcbTirG2vPNq3n1OTyAUqIz47fGhni+yBGdYjLvUVb/
        nuxQq+pHWdlUbHfDocLDPs8zp4GlNb8CR3oGouFzo
X-Received: by 2002:a25:8d89:0:b0:8bb:3a1:e811 with SMTP id o9-20020a258d89000000b008bb03a1e811mr2239397ybl.348.1676285271266;
        Mon, 13 Feb 2023 02:47:51 -0800 (PST)
X-Google-Smtp-Source: AK7set8dJc8mnZ68h5E2i4/98a3p4ECiI1nN8E7NmC90OrgSer4bFI/xxW/0lDOs/nXlXzBuyRhjkzwcookyHm1CFPU=
X-Received: by 2002:a25:8d89:0:b0:8bb:3a1:e811 with SMTP id
 o9-20020a258d89000000b008bb03a1e811mr2239395ybl.348.1676285271031; Mon, 13
 Feb 2023 02:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20230125-hid-unregister-leds-v3-0-0a52ac225e00@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v3-1-0a52ac225e00@diag.uniroma1.it>
 <20230210132017.2497-1-hdanton@sina.com> <CAO-hwJJKCvbdjuG4wER6sHozoLA4F2OTUUpHORtj6KM0q-avzA@mail.gmail.com>
 <20230211020041.2613-1-hdanton@sina.com> <CAO-hwJ+bvOvm-7CcKwa_g+f4V4P8k9MKQN46DDckAgBgzNH_yg@mail.gmail.com>
 <20230213103658.3091-1-hdanton@sina.com>
In-Reply-To: <20230213103658.3091-1-hdanton@sina.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 13 Feb 2023 11:47:40 +0100
Message-ID: <CAO-hwJ++sRYUXhu9URU_=12y1nwC+pgEfPwmtyWisQenkZkiiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] HID: bigben: use spinlock to safely schedule workers
To:     Hillf Danton <hdanton@sina.com>
Cc:     Pietro Borrello <borrello@diag.uniroma1.it>,
        Jiri Kosina <jikos@kernel.org>, Hanno Zulla <kontakt@hanno.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 13, 2023 at 11:37 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 13 Feb 2023 09:25:37 +0100 Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > The remove flag is just a way to prevent any other workqueue from
> > starting. It doesn't mean that the struct bigben has been freed, so
> > acquiring a lock at that point is fine.
> > We then rely on 2 things:
> > - devm_class_led to be released before struct bigben, because it was
> > devm-allocated *after* the struct bigben was devm-allocated
>
> This is the current behavior and it is intact after this patch.
>
> > - we prevent any new workqueue to start and we guarantee that any
> > running workqueue is terminated before leaving the .remove function.
>
> If spinlock is added for not scheduling new workqueue then it is not
> needed, because the removed flag is set before running workqueue is
> terminated. Checking the flag is enough upon queuing new work.
>

I tend to disagree (based on Pietro's v4:
- no worker is running
- a led sysfs call is made
- the line "if (!bigben->removed)" is true
  - this gets interrupted/or another CPU kicks in for the next one
-> .remove gets called
- bigben->removed is set to false
- cancel_work_sync() called

the led call continues, and schedules the work

.removes terminates, and devm kicks in, killing led_class and struct
bigben while the workqueue is running.

So having a simple spinlocks ensures the atomicity between checking
for bigben->removed and scheduling a workqueue.

Cheers,
Benjamin

