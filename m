Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864EC67B099
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjAYLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjAYLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:07:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFB349973
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674644814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGyxR4QjlvV59Dun3XoNVcSY9X+5yxzcZa0pgXIqYKk=;
        b=CVrJQR+jUmAmjeYhXbJ57y6uz+YKFzSC8NjpviCW0rpJQcPJC+wUDmXofV13UmFmlA8/Fg
        wm5K5y4Bzk24aLFmmKrweq2TxgBzr6fGmZzomd/LQ4cG//A1XX+BmTqC/DmERdKENt7Zff
        K9mwQZj9H6zzJe49zrbAAn2kv8zDVjg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-nEvlg1g-NpK4Bai21KJrfw-1; Wed, 25 Jan 2023 06:06:53 -0500
X-MC-Unique: nEvlg1g-NpK4Bai21KJrfw-1
Received: by mail-oi1-f197.google.com with SMTP id es24-20020a056808279800b003630973475fso5684950oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGyxR4QjlvV59Dun3XoNVcSY9X+5yxzcZa0pgXIqYKk=;
        b=R0jf0TajjtdD5dezsL+X8D8eaY50PsZmmI12XojKwGRIrmSINmIEiGjbMvrUNnhoSN
         pQbc9J8+mBo9vrWBEphmV9NjEHnlXQnzZ0ET9Dh+KsDSmYwgh/SUraCV9ugTRhDLU9Dm
         KOL/EJZge7EyZYRlAPLmhb5c/HDRLQRO9NgNxd03cMPl2VZ2hp4rjNpraOsq9U2wD97/
         3UpZ0sI7jI9ud/lLES7OremttyeyPcJWPbZ26N0DYalvdh6vrRxymCMKnybzsVFsPg1a
         6qWTljnDthw9Aqif5zp7dOm/gdfCxHWudvRuALi58vxLn+fpNZXxsKSJx2v0RXDemo0p
         8Eig==
X-Gm-Message-State: AFqh2kqTmwvFVWTavwjNkaBQAtxp6JIY7F1qZ1a3GwTWN8CcBHYeqrzH
        AaEBsrz8fd7xyBhBrc8w8sGPd2tMdr5w9a5xDjaWQX/ZDXt6Accey0Jx85X8ZcfKXPNoCABwNBR
        qPzsMNGRi+nc9+v3hJGxjnfEM
X-Received: by 2002:a05:6871:54c:b0:15e:d38a:9991 with SMTP id t12-20020a056871054c00b0015ed38a9991mr17058770oal.33.1674644813156;
        Wed, 25 Jan 2023 03:06:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXteDxAqH1GaOU55z1R+UFAi798mOZdTrbwTOsUY2uvJOL3tH8LlrKWLzh+yPmUG1KRgX8GokQ==
X-Received: by 2002:a05:6871:54c:b0:15e:d38a:9991 with SMTP id t12-20020a056871054c00b0015ed38a9991mr17058741oal.33.1674644812295;
        Wed, 25 Jan 2023 03:06:52 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:14fa:9361:c141:6c70:c877? ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id pq3-20020a0568709c8300b0011d02a3fa63sm1746840oab.14.2023.01.25.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 03:06:51 -0800 (PST)
Message-ID: <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 25 Jan 2023 08:06:46 -0300
In-Reply-To: <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > Disclaimer:
> > a - The cover letter got bigger than expected, so I had to split it in
> >     sections to better organize myself. I am not very confortable with =
it.
> > b - Performance numbers below did not include patch 5/5 (Remove flags
> >     from memcg_stock_pcp), which could further improve performance for
> >     drain_all_stock(), but I could only notice the optimization at the
> >     last minute.
> >=20
> >=20
> > 0 - Motivation:
> > On current codebase, when drain_all_stock() is ran, it will schedule a
> > drain_local_stock() for each cpu that has a percpu stock associated wit=
h a
> > descendant of a given root_memcg.
> >=20
> > This happens even on 'isolated cpus', a feature commonly used on worklo=
ads that
> > are sensitive to interruption and context switching such as vRAN and In=
dustrial
> > Control Systems.
> >=20
> > Since this scheduling behavior is a problem to those workloads, the pro=
posal is
> > to replace the current local_lock + schedule_work_on() solution with a =
per-cpu
> > spinlock.
>=20
> If IIRC we have also discussed that isolated CPUs can simply opt out
> from the pcp caching and therefore the problem would be avoided
> altogether without changes to the locking scheme. I do not see anything
> regarding that in this submission. Could you elaborate why you have
> abandoned this option?

Hello Michal,

I understand pcp caching is a nice to have.
So while I kept the idea of disabling pcp caching in mind as an option, I f=
irst
tried to understand what kind of impacts we would be seeing when trying to
change the locking scheme.

After I raised the data in the cover letter, I found that the performance i=
mpact
appears not be that big. So in order to try keeping the pcp cache on isolat=
ed
cpus active, I decided to focus effort on the locking scheme change.

I mean, my rationale is: if is there a non-expensive way of keeping the fea=
ture,
why should we abandon it?

Best regards,
Leo







