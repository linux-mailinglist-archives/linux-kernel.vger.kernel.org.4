Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D0269A7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjBQJHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBQJHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B04E60A68
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYBgjTMjZdGOtt6bx76zu2DLo3upoWvpTnwIk+crChA=;
        b=GSIE2yV0pSYAPwfnKhm+J/hbBW/g3y0mAAu3VtxXA3i13Bm0Bcjl99TO75hZfoAoc8embN
        I1DUv8fM2SKM3+LqFub61pl7QSpdKq80Lzj4HpLQwFIxeYXELsZeHsvn3dKtYzOv2BLTNi
        nVvHqQhVcvcDy89/s0fdVYp6AUl6Lr8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-DduUCeakMA2eorEM-EulZw-1; Fri, 17 Feb 2023 04:06:33 -0500
X-MC-Unique: DduUCeakMA2eorEM-EulZw-1
Received: by mail-qk1-f197.google.com with SMTP id z40-20020a05620a262800b0073b344eb74dso2733919qko.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYBgjTMjZdGOtt6bx76zu2DLo3upoWvpTnwIk+crChA=;
        b=dc8f6VthKTh9KMm9kUgxiCcyRyR+zydo9zd1CFypMnEwXHxC5hh3CHmVLtzIJzwGqu
         unPlZ8KP+oxAZ099NIfj98WD84BJZt02451Ao6zy68nslv65P0fMDy6/ErE/lwiaPAW5
         xqZ2+97Vin0NodV4cIE+fayZ5F236f8dFLsGabgGlM+m319MUxK90OHiMV10MYVUXTFO
         OShPRfPqFv9TDG5Q0lJKdRH43TZQirMsI5HeMd34TQ+WNlaMKHyzJJCYezYKsg+kBQV6
         l/KuUFoYqJ4S8qYgx02iTRmb7GNsWxMj7wulvYwFDTnF7LxxmHQIgFbTUNNyeB80gJLo
         g2YA==
X-Gm-Message-State: AO0yUKXJ9ZQ1WshLsqqj/h0FTD9BP2H/0W7vG+o5mgHOwGxZqCNF78yu
        B1NgSQ67refmt2uWmnkIOF9Lxg0VdsN7WRh30pSx1wSBjUtZGYivYsGzT63SLmYTGPKuXH8Evds
        fs8r7s9/CXJfzAWlhDIwP+Q2S
X-Received: by 2002:a05:6214:21a9:b0:56e:fef4:7ff1 with SMTP id t9-20020a05621421a900b0056efef47ff1mr6224980qvc.21.1676624792392;
        Fri, 17 Feb 2023 01:06:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9dksCLRvkGtOCr4ORausUUH6GVWvsZbSk/a25QvYMl9pl4wePTorQHv5gsaTW5qe3V949j8g==
X-Received: by 2002:a05:6214:21a9:b0:56e:fef4:7ff1 with SMTP id t9-20020a05621421a900b0056efef47ff1mr6224956qvc.21.1676624792049;
        Fri, 17 Feb 2023 01:06:32 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id i65-20020a37b844000000b00705cef9b84asm2814791qkf.131.2023.02.17.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:06:31 -0800 (PST)
Date:   Fri, 17 Feb 2023 10:06:27 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel V edition (OSPM-summit 2023)
Message-ID: <Y+9Dk69B/PSMp3Lp@localhost.localdomain>
References: <Y8lFkbJ6nluNdVYO@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lFkbJ6nluNdVYO@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 19/01/23 14:28, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) V edition
> 
> April 17-19, 2023
> Universita Politecnica delle Marche, Facolta di Economia
> Ancona, Italy
> 
> ---
> 
> .:: FOCUS
> 
> After a couple of years break, OSPM is back! In a different venue.
> 
> The V edition of the Power Management and Scheduling in the Linux Kernel
> (OSPM) summit aims at fostering discussions on power management and
> (real-time) scheduling techniques. Summit will be held in Ancona (Italy)
> on April 17-19, 2023.

...

> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!).

Registrations are now open. Please use the link below to register. Don't
hesitate to reply to me privately if you experience problems with
the process.

https://forms.gle/QbRhGS3HWXinKBZq7

Also, website of the event is now online. Refer to that for logistic
information.

https://retis.sssup.it/ospm-summit/

You can find below the list of accepted topics.

https://docs.google.com/spreadsheets/d/10AJFQporrCPH9Gn6-MaRotdfO4Hm4LG6dVAoDrQdj5A/edit?usp=sharing

For registered attendees, a draft schedule will be available in the next
couple of weeks (tentatively :).

Looking forward to meeting you in Ancona!

Best,
Juri

