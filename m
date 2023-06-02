Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9948B7207BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjFBQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjFBQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6F1AB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685723834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WIPSNWBQXPxxS791JlgpzSYCeZvx3Su3TMXyqeGUJho=;
        b=FXl2KhN62SLyT5p9u/MnFF6pWrLkIS8/w0/6g9/G+zJW/CxByWBtVp4+QUWzq5t6yDHqfc
        UuqTqhywOqp0H6JohXhiGVccvcD+8x+ecGGAlipBn6GoUjXz/kuWCedhYzhr2OAMNVLZLN
        JKU5ZAwnub7hn2VPydn7lfyBIcp0l+A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-kpDUw9s3MJ-Xcf9WigeDog-1; Fri, 02 Jun 2023 12:37:13 -0400
X-MC-Unique: kpDUw9s3MJ-Xcf9WigeDog-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30ad0812151so1149954f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723832; x=1688315832;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIPSNWBQXPxxS791JlgpzSYCeZvx3Su3TMXyqeGUJho=;
        b=DSUhFGpIhTvoe5rj7t95ZjYwvwmr8s8gE/GaK6rfzjg0q9VWgqGF5exGUupylWr0GK
         8uhH9L1MizUExZy4Zc5YG9nc4pNmrDRbUIV/EDJ83s8N5MaynfUVBQeVKxHbFUB873MG
         gYe2srDg4+ugMRYATdTkb9TB0DhK6WWtFD6+7AJcJJrTZXsRr/YpRMlGcmZmUNOvfcP/
         5yLim0XjGvq4shYMrq02xMa837lLOFVknCidpyOtTt4nOj/W3JjmjHXcwGcP5f3jWoSo
         EPz1x+9USfvhgClv4AP+LRCcmnjuULN+flWN8Tr8tBUNUYQfDSafS0WvmJrk52wJg86+
         usZQ==
X-Gm-Message-State: AC+VfDz0IRtvmOH0PlRut5agQmL9UnxgGb50GP1VIzUFBeyznRh5d2Rv
        NdU2m4b/9JEB1pXhHnUTFVvbFhL4c4Kb5NzdHlEYkTywg0qb+nqbLhyPX3kzlxq8fw/rY16l+Ae
        fSSb8LsSuo8zi7NGNmmh5kCif
X-Received: by 2002:a5d:440f:0:b0:30a:e647:fc2e with SMTP id z15-20020a5d440f000000b0030ae647fc2emr387292wrq.19.1685723832193;
        Fri, 02 Jun 2023 09:37:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FLY9lVp/RbHs95OsTWq3deEM5dUJjhfQSHWkPRE6RJLhFVpSAsoCuKdrt8Q/kzIkm3oqtbQ==
X-Received: by 2002:a5d:440f:0:b0:30a:e647:fc2e with SMTP id z15-20020a5d440f000000b0030ae647fc2emr387266wrq.19.1685723831850;
        Fri, 02 Jun 2023 09:37:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id y5-20020adfd085000000b003095bd71159sm2165442wrh.7.2023.06.02.09.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:37:11 -0700 (PDT)
Message-ID: <6711d7ba-1349-de28-6d35-9dce91be7996@redhat.com>
Date:   Fri, 2 Jun 2023 18:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
References: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
 <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org>
 <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <CAHk-=whwFoC30zoTfsQAvkDRvgMCovwKGW_R1PPnqiF+YemcOA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
In-Reply-To: <CAHk-=whwFoC30zoTfsQAvkDRvgMCovwKGW_R1PPnqiF+YemcOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.23 18:06, Linus Torvalds wrote:
> On Fri, Jun 2, 2023 at 11:20 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> What concerns me a bit, is that on the patched kernel we seem to hit more cases where
>> boot takes much longer (in both kernel configs).
> 
> So it potentially serializes the loads to the same file more, but in
> the process uses much less memory (since the ones waiting will not
> have done any of the "load file contents and uncompress them"). So
> it's a bit of a trade-off.

I have the feeling that -- on this system -- it's some inaccurate 
accounting of firmware+loader times to the kernel startup time. Combined 
with some other noise. Especially the firmware loading time seems to be 
fairly randomized.

I guess what we care about regarding module loading is the 
initrd+userspace loading times, and they are fairly stable. But we 
mostly care about udev.

So let's look only at "systemd-udev" services:

1) !debug

a) master

5.672s systemd-udev-settle.service
  505ms systemd-udev-trigger.service
  272ms systemd-udevd.service
5.418s systemd-udev-settle.service
  487ms systemd-udev-trigger.service
  258ms systemd-udevd.service
5.707s systemd-udev-settle.service
  527ms systemd-udev-trigger.service
  273ms systemd-udevd.service
6.250s systemd-udev-settle.service
  455ms systemd-udev-trigger.service
  283ms systemd-udevd.service


b) patched

4.652s systemd-udev-settle.service
  461ms systemd-udev-trigger.service
  302ms systemd-udevd.service
4.652s systemd-udev-settle.service
  461ms systemd-udev-trigger.service
  302ms systemd-udevd.service
4.634s systemd-udev-settle.service
  444ms systemd-udev-trigger.service
  296ms systemd-udevd.service
4.745s systemd-udev-settle.service
  444ms systemd-udev-trigger.service
  273ms systemd-udevd.service


2) debug

a) master

32.806s systemd-udev-settle.service
  9.584s systemd-udev-trigger.service
   471ms systemd-udevd.service
29.901s systemd-udev-settle.service
  8.914s systemd-udev-trigger.service
   400ms systemd-udevd.service
28.640s systemd-udev-settle.service
  9.260s systemd-udev-trigger.service
   477ms systemd-udevd.service
29.498s systemd-udev-settle.service
  9.073s systemd-udev-trigger.service
   444ms systemd-udevd.service


b) patched

28.765s systemd-udev-settle.service
  8.898s systemd-udev-trigger.service
   400ms systemd-udevd.service
28.292s systemd-udev-settle.service
  8.903s systemd-udev-trigger.service
   401ms systemd-udevd.service
34.588s systemd-udev-settle.service
  8.959s systemd-udev-trigger.service
   455ms systemd-udevd.service
28.641s systemd-udev-settle.service
  8.953s systemd-udev-trigger.service
   389ms systemd-udevd.service



So except some noise, in the general case the patched version seems to 
be faster just looking at systemd-udev.

> 
> We could complicate things a bit, and let other callers return -EEXIST
> a bit earlier, but I'm not convinced it really matters.

Looking at the numbers, agreed.

> 
> Honestly, taking too long because user space does something stupid and
> wrong is not a kernel bug. Not booting because we use too much memory
> - that's problematic. But booting slowly because udev does several
> thousand unnecessary module loads is entirely on udev.

Yes.


I'll do some more experiments, but from what I can tell

Tested-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

