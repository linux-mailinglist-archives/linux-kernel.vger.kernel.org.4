Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE795669EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjAMQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjAMQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:49:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322306A0E7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673628456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=djME/70Dq2hCyOWtbb9rXV1J/myyoY9n25749b7HV2g=;
        b=FNilpsuJ8Y7ARbvSiNCzGoZ04f2OzGcd1UYTYVdKd1GqkI+6up6IhZfBLUcdtl/xlL5Pn0
        F7MV0U2JcX7LireZaVBH84rzhm9GOpqUA3EFKcjNCPh8m2UxN1/GBY56PIXsGCAic9W0ia
        UmSuJmnu1eZ3D+eDBdCH6v2BmFlwfJY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-324-ELt3lwm8OWe3g-tBTW2G-g-1; Fri, 13 Jan 2023 11:47:34 -0500
X-MC-Unique: ELt3lwm8OWe3g-tBTW2G-g-1
Received: by mail-wm1-f70.google.com with SMTP id bg25-20020a05600c3c9900b003da1f6a7b2dso1691167wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djME/70Dq2hCyOWtbb9rXV1J/myyoY9n25749b7HV2g=;
        b=txJZvexKbCPP/b7GkXK6MNdc/O3eepk4BSxujka0CBfKPgJ/yopwA8QSB8+2o6nXy0
         hbLVXY0Uamk9J9akXfLn5254DyUi1QpGG/w0jr9DHTD8v1c77Hk+dK3cgahOS3WACQPe
         ththZQOqdM9AhFxe9RWyV+I1oMQjZJhywa9RQ1BcQzsGEo2AH1ASYttor+oFYEX/LGGK
         KQBqMO6qkBqhRp+xhssf21cVTWEE6/xomVYyMbf+IfMVfUpBZory1ZnoMGKn13e6JCwH
         TCjSby0pc/qsFl4z6S/abpmppFCpCVn05pdpdvLcjuphoz19qEBb8W/TGB4OfNeyZdnE
         cZeQ==
X-Gm-Message-State: AFqh2kofHhAfSK0biJu6uy7zHlSKLv+UuHzKkW13T3XMtVTkcLawYZnf
        jiqllsISBbSrSQpuT/unrpg73r+AQp9YaLkgmu/5dh4IQzE4LWmQocOxcT2vxKBvIty2L2SMlWm
        1Dtp/Wca5DUW/LBmYIaowj+1E
X-Received: by 2002:a5d:5c12:0:b0:242:800:9a7f with SMTP id cc18-20020a5d5c12000000b0024208009a7fmr55202705wrb.65.1673628452598;
        Fri, 13 Jan 2023 08:47:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv5j3W2PLZJa6k66qSJK7vxx5Jkcl2ZNrIGiRyqW1y76dg3kAVn3B9j77QV4e5H///posi9iw==
X-Received: by 2002:a5d:5c12:0:b0:242:800:9a7f with SMTP id cc18-20020a5d5c12000000b0024208009a7fmr55202698wrb.65.1673628452442;
        Fri, 13 Jan 2023 08:47:32 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id e1-20020adfdbc1000000b002b8fe58d6desm19496504wrj.62.2023.01.13.08.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:47:31 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the workqueues tree
In-Reply-To: <Y8GHXUcXYJcHPkOY@slm.duckdns.org>
References: <20230113143102.2e94d74f@canb.auug.org.au>
 <Y8GHXUcXYJcHPkOY@slm.duckdns.org>
Date:   Fri, 13 Jan 2023 16:47:31 +0000
Message-ID: <xhsmhzgamidp8.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/23 06:31, Tejun Heo wrote:
> On Fri, Jan 13, 2023 at 02:31:02PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the workqueues tree, today's linux-next build (x86_64
>> allnoconfig and several others) produced this warning:
>>
>> kernel/workqueue.c:1993:13: warning: 'rebind_worker' defined but not used [-Wunused-function]
>>  1993 | static void rebind_worker(struct worker *worker, struct worker_pool *pool)
>>       |             ^~~~~~~~~~~~~
>>
>> Introduced by commit
>>
>>   793777bc193b ("workqueue: Factorize unbind/rebind_workers() logic")
>
> Valentin, this is caused by rebind_worker() being only used by
> rebind_workers() which is inside CONFIG_SMP. I don't see any other uses of
> rebind_worker(). Just fold it back into rebind_workers()?
>

Woops! Yes I only did it to keep things aligned with unbind_workers(), let
me resend with that folded back in. Sorry!

> Thanks.
>
> --
> tejun

