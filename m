Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2821967EE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjA0Taq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjA0Tao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:30:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A8380FB4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674847783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUv5DFOx1orc2Szz1mjtgk5jcU9W4yiwziY2UuvBPys=;
        b=EJRjtkSs4wO8UEiFb4+XLL3tCn01j3aXo7v/Bnge5HtUNGXBCtdXR59hvdx85raCIpijbE
        LZq0oS+XKbNL9kHShnazwL14/kz0sLCmL8g4YcpQ5TBMqqD9//QruMJlMvC+SiUhguIJ5U
        zZ40iGB8Sck6WgIe4cJO2EkxQfJE1UA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-y1MmfSTiMIe-LygZHv0TnA-1; Fri, 27 Jan 2023 14:29:42 -0500
X-MC-Unique: y1MmfSTiMIe-LygZHv0TnA-1
Received: by mail-ot1-f72.google.com with SMTP id w15-20020a056830144f00b00687ec8c75cdso2677772otp.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUv5DFOx1orc2Szz1mjtgk5jcU9W4yiwziY2UuvBPys=;
        b=ROKMSJvflt3XyHH8QRiY+anq6BDo8D+9Q4C1W2rAD7ZAZEHm+e3d0soTDb4mXdXQsa
         57u0hqVPCmj5kKSxPE4iec1YDdumYkqjl0xZdgkiidBvo92Ej2uS8rQGX9hI+YF0SO9y
         pSYcN3pjRdeizDLKIDicvmRtqbgL0mN6Lx5zYbj+wiYNFQFq3+waR8q1dJ2/JD4P20bP
         WftP0tIVzC76vFHWPkGune02j/D41q7W/mBONb8yZyTaSquBVRDK7PfDVqvuSOveylkv
         1qztJ+ppuaea32YRB5N3QuqVTmAJdwupcCoUFZTvzt6qUlvHOyWhlDAGIrlhQ6/d1qRG
         0SGA==
X-Gm-Message-State: AO0yUKUzJGVMOTNz2DvgCf5nyNz9A54kp24p8qPp2rbXrkI0D9FPcQZ+
        oGn2Nuwx9/zu6QIrC0Q0mHQZMyGSuwMRdVhEMok8CkLOv6Tb/jcZxSMHpQnCXIZGFdwwTQqhsRd
        +MGSk48OiMkWNhMf46c7KH7EC
X-Received: by 2002:a9d:3f1:0:b0:68b:ba7e:1800 with SMTP id f104-20020a9d03f1000000b0068bba7e1800mr38637otf.34.1674847781948;
        Fri, 27 Jan 2023 11:29:41 -0800 (PST)
X-Google-Smtp-Source: AK7set+Ph9lhLfqTNVR5otrvd7xQnQfYQPxx7b1GPoc50tFYq9YnPESypV2bWjtmZa5dzVRAfQJQCQ==
X-Received: by 2002:a9d:3f1:0:b0:68b:ba7e:1800 with SMTP id f104-20020a9d03f1000000b0068bba7e1800mr38629otf.34.1674847781695;
        Fri, 27 Jan 2023 11:29:41 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id cp11-20020a056830660b00b0066ca61230casm2160524otb.8.2023.01.27.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:29:41 -0800 (PST)
Message-ID: <029147be35b5173d5eb10c182e124ac9d2f1f0ba.camel@redhat.com>
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
Date:   Fri, 27 Jan 2023 16:29:37 -0300
In-Reply-To: <Y9OZezjUPITtEvTx@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
         <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
         <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
         <55ac6e3cbb97c7d13c49c3125c1455d8a2c785c3.camel@redhat.com>
         <Y9N7UMrLTyZT71uA@dhcp22.suse.cz>
         <15c605f27f87d732e80e294f13fd9513697b65e3.camel@redhat.com>
         <Y9OZezjUPITtEvTx@dhcp22.suse.cz>
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

On Fri, 2023-01-27 at 10:29 +0100, Michal Hocko wrote:
> On Fri 27-01-23 04:35:22, Leonardo Br=C3=A1s wrote:
> > On Fri, 2023-01-27 at 08:20 +0100, Michal Hocko wrote:
> > > On Fri 27-01-23 04:14:19, Leonardo Br=C3=A1s wrote:
> > > > On Thu, 2023-01-26 at 15:12 -0800, Roman Gushchin wrote:
> > > [...]
> > > > > I'd rather opt out of stock draining for isolated cpus: it might =
slightly reduce
> > > > > the accuracy of memory limits and slightly increase the memory fo=
otprint (all
> > > > > those dying memcgs...), but the impact will be limited. Actually =
it is limited
> > > > > by the number of cpus.
> > > >=20
> > > > I was discussing this same idea with Marcelo yesterday morning.
> > > >=20
> > > > The questions had in the topic were:
> > > > a - About how many pages the pcp cache will hold before draining th=
em itself?=C2=A0
> > >=20
> > > MEMCG_CHARGE_BATCH (64 currently). And one more clarification. The ca=
che
> > > doesn't really hold any pages. It is a mere counter of how many charg=
es
> > > have been accounted for the memcg page counter. So it is not really
> > > consuming proportional amount of resources. It just pins the
> > > corresponding memcg. Have a look at consume_stock and refill_stock
> >=20
> > I see. Thanks for pointing that out!
> >=20
> > So in worst case scenario the memcg would have reserved 64 pages * (num=
cpus - 1)
>=20
> s@numcpus@num_isolated_cpus@

I was thinking worst case scenario being (ncpus - 1) being isolated.

>=20
> > that are not getting used, and may cause an 'earlier' OOM if this amoun=
t is
> > needed but can't be freed.
>=20
> s@OOM@memcg OOM@
=20
> > In the wave of worst case, supposing a big powerpc machine, 256 CPUs, e=
ach
> > holding 64k * 64 pages =3D> 1GB memory - 4MB (one cpu using resources).
> > It's starting to get too big, but still ok for a machine this size.
>=20
> It is more about the memcg limit rather than the size of the machine.
> Again, let's focus on actual usacase. What is the usual memcg setup with
> those isolcpus

I understand it's about the limit, not actually allocated memory. When I po=
int
the machine size, I mean what is expected to be acceptable from a user in t=
hat
machine.

>=20
> > The thing is that it can present an odd behavior:=20
> > You have a cgroup created before, now empty, and try to run given appli=
cation,
> > and hits OOM.
>=20
> The application would either consume those cached charges or flush them
> if it is running in a different memcg. Or what do you have in mind?

1 - Create a memcg with a VM inside, multiple vcpus pinned to isolated cpus=
.=20
2 - Run multi-cpu task inside the VM, it allocates memory for every CPU and=
 keep
    the pcp cache
3 - Try to run a single-cpu task (pinned?) inside the VM, which uses almost=
 all
    the available memory.
4 - memcg OOM.

Does it make sense?


>=20
> > You then restart the cgroup, run the same application without an issue.
> >=20
> > Even though it looks a good possibility, this can be perceived by user =
as
> > instability.
> >=20
> > >=20
> > > > b - Would it cache any kind of bigger page, or huge page in this sa=
me aspect?
> > >=20
> > > The above should answer this as well as those following up I hope. If
> > > not let me know.
> >=20
> > IIUC we are talking normal pages, is that it?
>=20
> We are talking about memcg charges and those have page granularity.
>=20

Thanks for the info!

Also, thanks for the feedback!
Leo

