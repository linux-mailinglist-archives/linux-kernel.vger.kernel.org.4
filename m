Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDB05F521E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJEJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJEJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC816EF37
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664963842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20ff7s16mtIwZ8gqYFObUPuSeBfntjdVTNqXHSuaHoI=;
        b=EDLA5cFkVIHtShmNq9CdiJgkVBQP2SWDEXVm0ZZv+VOoyrtjjreRe50RKeZM5CCG6k9DQr
        gZ4ImhFhjpsbfCHg7yn3R5HgF5qFcTH8lFFtGY2wSftqyq/ZArHmbXHE67zydyxJIBKyOq
        JRzdOqx3gTHJ/9140NcxQn1JLQFBAwA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-ze47MeHON8ScP0Mv4du60g-1; Wed, 05 Oct 2022 05:57:21 -0400
X-MC-Unique: ze47MeHON8ScP0Mv4du60g-1
Received: by mail-ed1-f72.google.com with SMTP id q17-20020a056402519100b00459a2e5adbcso1049726edd.16
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 02:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=20ff7s16mtIwZ8gqYFObUPuSeBfntjdVTNqXHSuaHoI=;
        b=Oi9KzPGlZss4F0TK9hJYrpgDdUDEissIjguMd4ExnPsCKKdA6EI0H2TLqiv4S7rB+R
         1CIta3U88IGamE0ZX/0Q4AcgR9cFKqqsTntAe7gYPt9je696Vkx4uJVkzEka9OOEUjKa
         KixXw2Hwb7y4k9tTQ89+FDnW/yRcB+EkYQcAb3K8XmXlaWETp+uF91REeMo3VvS4SrLQ
         uh2mQFjSrDD5rd5HurE+AWYkrg+e4wJ2mI3UOcrzvv+tLvAPiosKCtuIQ1JiuKR43hTw
         1ZnC30JVWWvGenbPebmSEwF/UXFgRCpMkCQPPG8M6WgGNB4yhmmQ5XY1jvegltJfDCuI
         qP5A==
X-Gm-Message-State: ACrzQf1FWuQC32x4JM3tg2P7T93Miykxwcn342EYnQwQqWMW+94imqQB
        jHqJXu4CAkWWlJQ1LKMxr2iZ80QOLvRPQNegdXoZdXefif/7EMfvMXsGcO4XsRPnTIQmU09g+bg
        dYiRM8BizXvN5GlnXwWaMPFMX
X-Received: by 2002:a17:907:8a04:b0:782:5277:2bac with SMTP id sc4-20020a1709078a0400b0078252772bacmr23287307ejc.128.1664963840704;
        Wed, 05 Oct 2022 02:57:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5mca9biPXLa+2VXu6jXHj36N0ePmCtaDc/BXk6keLmkoscY89Q4ZDPxtCjzrCOOdednWj6xg==
X-Received: by 2002:a17:907:8a04:b0:782:5277:2bac with SMTP id sc4-20020a1709078a0400b0078252772bacmr23287285ejc.128.1664963840468;
        Wed, 05 Oct 2022 02:57:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id oq4-20020a170906cc8400b0078b1ff41f05sm5053016ejb.43.2022.10.05.02.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 02:57:19 -0700 (PDT)
Message-ID: <477635db-c89b-cfd3-cd26-fea51bb094a5@redhat.com>
Date:   Wed, 5 Oct 2022 11:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Content-Language: en-US, nl
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        ksummit <ksummit@lists.linux.dev>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
 <c74d9d75-4428-e22d-1adb-334b1173d871@leemhuis.info>
 <20221004202540.etokkm3jk6sk7z7y@meerkat.local>
 <89926f21-e172-9f3d-d08f-8d5eef812ee1@leemhuis.info>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <89926f21-e172-9f3d-d08f-8d5eef812ee1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/5/22 11:00, Thorsten Leemhuis wrote:
> On 04.10.22 22:25, Konstantin Ryabitsev wrote:
>> On Tue, Oct 04, 2022 at 10:06:28PM +0200, Thorsten Leemhuis wrote:
>>> Your plan would afaics mean that we invest further into a software
>>> abandoned by its upstream and already becoming more and more of a
>>> maintenance burden. That investment would also further increase our
>>> dependency on that software by establishing workflows that rely on it.
>>> Is that really wise at this point? Wouldn't it be better to spend that
>>> time and effort to build something better that is more future proof?
>>
>> Unfortunately, there's no such thing. ;) And maybe we'll even help tip the
>> course of history into the other direction -- Red Hat uses bugzilla, and so
>> does OpenSuse, so there's a pretty good core of well-funded companies that
>> would be in a position to help keep bugzilla going if it's looking like the
>> platform is still alive. Or that could all be wishful thinking and they'll all
>> migrate to Jira or something equally horrible, who knows.
> 
> Well, Red Hat apparently is already in the process of migrating to Jira
> in the long run:
> https://lists.fedoraproject.org/archives/list/epel-devel@lists.fedoraproject.org/thread/U7TZRWXVUGBCHS6EBJIBSFAVPFUHHV7J/
> 
> To quote that mail from March:
> 
> ```
> As some of you may know, Red Hat has been using both Bugzilla and Jira
> via issues.redhat.com for RHEL development for several years.  Our
> intention is to move to using issues.redhat.com only for the major
> RHEL releases after RHEL 9.
> ```

That is for RHEL only though I'm not sure what the plans for Fedora are.

Also I do believe that the Red Hat bugzilla team is working on porting
bugzilla to postgresql, which would at least fix the problem of depending on
a no longer maintained mysql version.

If the postgresql port is something of interest to keep bugzilla.kernel.org
going for now, then it is probably best to just directly contact the bugzilla
maintainers @redhat.

Regards,

Hans



