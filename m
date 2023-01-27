Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8D67DE98
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjA0HgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjA0HgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7141627BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674804930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOQxAgAAK0FHDcI+jB5U3fyhR/dhMwJss/kdGg+mJds=;
        b=NhX5PZ7681qynWPUrWTadTCqSE00zaRsie31izol5b2ehfv0E8nfJIuC8SFw5fKsORzvmw
        pruJmdM3RbyXcHBe8+o7pd1uvsETF+rXVN7pCWYfB2lOXKVh95YYqH1XeoGKUXIEcG1G2y
        flSUkU1bqbjurbbFtL/zGbIVMcew/h4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-ORtLNKNwMWeUHdNZJsbXMA-1; Fri, 27 Jan 2023 02:35:27 -0500
X-MC-Unique: ORtLNKNwMWeUHdNZJsbXMA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-16316ec053fso1483309fac.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOQxAgAAK0FHDcI+jB5U3fyhR/dhMwJss/kdGg+mJds=;
        b=w0AWbw7dv7k9OuevV+dmnoOAfc9LFFuQnDGGMOJfZOoizYOHue04O257XUTHXNcTTu
         nXqSgB45fuf0xx6/fY6YV1X4NgIlutidJGNvod+skemEz2jolWkXZtyuL0fxIAEil9jE
         rFSKV2YWoa03de8m34MCJQx7W+w3ZH/IfdEQjfsna/2Mz1pveEh6JbxejK2mljfnO4za
         8Y9zudIS6Xof6ybEiDLX8bdMXRQU7Gf0SY8HxP3Reo03jcYyznyryzI99Qjjimyautyg
         cG/K81KfuCDK3QMqx8tRwL8l9luLdGR9NQbs6LBd6ZEnCWtKodR/v9m8afO32Q0Kia6Q
         ot0Q==
X-Gm-Message-State: AFqh2kqCeV0O7gCIvR+WZmT/4sYdPab9+k8L4Ak1ocTQEm44re60+sce
        smqMryGBE0wYp+RKCVQCVdTFHqa52V4tCj5gyb3OQVm4SBH6OU+qfIy0nSOUo3WqSIdG6hJyoBW
        ZNGI5JfZqg/3Qpj/tHK5Bfbij
X-Received: by 2002:a05:6830:2477:b0:686:6cf1:1cb3 with SMTP id x55-20020a056830247700b006866cf11cb3mr13732066otr.13.1674804927000;
        Thu, 26 Jan 2023 23:35:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtTdCpwGeK5oWchZcZI01VdWJ8sxsZP+9IEvbdt5720U4H1aYd/ws6aYZNtqySF3kyS2GdjQQ==
X-Received: by 2002:a05:6830:2477:b0:686:6cf1:1cb3 with SMTP id x55-20020a056830247700b006866cf11cb3mr13732060otr.13.1674804926780;
        Thu, 26 Jan 2023 23:35:26 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id cp11-20020a056830660b00b0066ca61230casm1476844otb.8.2023.01.26.23.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 23:35:26 -0800 (PST)
Message-ID: <15c605f27f87d732e80e294f13fd9513697b65e3.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Jan 2023 04:35:22 -0300
In-Reply-To: <Y9N7UMrLTyZT71uA@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
         <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
         <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
         <55ac6e3cbb97c7d13c49c3125c1455d8a2c785c3.camel@redhat.com>
         <Y9N7UMrLTyZT71uA@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-27 at 08:20 +0100, Michal Hocko wrote:
> On Fri 27-01-23 04:14:19, Leonardo Br=C3=A1s wrote:
> > On Thu, 2023-01-26 at 15:12 -0800, Roman Gushchin wrote:
> [...]
> > > I'd rather opt out of stock draining for isolated cpus: it might slig=
htly reduce
> > > the accuracy of memory limits and slightly increase the memory footpr=
int (all
> > > those dying memcgs...), but the impact will be limited. Actually it i=
s limited
> > > by the number of cpus.
> >=20
> > I was discussing this same idea with Marcelo yesterday morning.
> >=20
> > The questions had in the topic were:
> > a - About how many pages the pcp cache will hold before draining them i=
tself?=C2=A0
>=20
> MEMCG_CHARGE_BATCH (64 currently). And one more clarification. The cache
> doesn't really hold any pages. It is a mere counter of how many charges
> have been accounted for the memcg page counter. So it is not really
> consuming proportional amount of resources. It just pins the
> corresponding memcg. Have a look at consume_stock and refill_stock

I see. Thanks for pointing that out!

So in worst case scenario the memcg would have reserved 64 pages * (numcpus=
 - 1)
that are not getting used, and may cause an 'earlier' OOM if this amount is
needed but can't be freed.

In the wave of worst case, supposing a big powerpc machine, 256 CPUs, each
holding 64k * 64 pages =3D> 1GB memory - 4MB (one cpu using resources).
It's starting to get too big, but still ok for a machine this size.

The thing is that it can present an odd behavior:=20
You have a cgroup created before, now empty, and try to run given applicati=
on,
and hits OOM.
You then restart the cgroup, run the same application without an issue.

Even though it looks a good possibility, this can be perceived by user as
instability.

>=20
> > b - Would it cache any kind of bigger page, or huge page in this same a=
spect?
>=20
> The above should answer this as well as those following up I hope. If
> not let me know.

IIUC we are talking normal pages, is that it?

Best regards,
Leo

