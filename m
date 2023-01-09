Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2676D6631BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbjAIUoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbjAIUod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:44:33 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9D4ECB8;
        Mon,  9 Jan 2023 12:44:31 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id r6-20020a056830448600b006848a91d910so2301825otv.12;
        Mon, 09 Jan 2023 12:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePA/IX1EL8d1Iza9X32BzjolB/4rRGKbpwCcOLOiZ4A=;
        b=hj9I9N6LdA8bmryOkT6IM15+nru45NlRRM/eaZ5QNHKsreypmvOlx5cAZ/kXqaHtJY
         XApewPY3ibQHQj5Od3n92dJVoK/qMTOpiWVE/O3ZixuMoO/NwCSsSCxdwCUrNj/FvYvE
         A2/NVfCNSwoi2xejSUOJqz08IsIKKfjxA2g3oSGcuxYlqd7HKEZ6Z9CdmkJ/ude7qqBk
         wg/zCNuaQCyprjlV5EsYIQZRPwdooHIb9dHC8VfxjNQgFmwq1Fz2sHOO3cY86qdQtdun
         AIyigHJOHDwsJ4hNB8wlzIXqSUxZbbPKhiyuQYhpGqS6EFuW7Q6YyMedP+8Gmof49L59
         IYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePA/IX1EL8d1Iza9X32BzjolB/4rRGKbpwCcOLOiZ4A=;
        b=41MIGJy9PsNN7nr39+Rssw170IAzVexhQ+uT9oItaJnA6aUGMDGMHChmJ2Qh6aUDkR
         HV7FSyZo2kxsp8zZOPv/zNGb7mO263xG0mV/dI7of6BlP/mIsC4wf3TgtV6CpAlyP1j5
         jQdtJk1Epy5HeTAz1i8ezh0JrTaZ5a03WGmMUB/bpFUKvqxRr2A3Kqsfj5SY/+/RCq+/
         qnEw1aHKlEWREGhR8S+QBpURsncqnOyKMyoNj6kzJpmm4hcU5fy3HjPY3SsgnNepRH4n
         farM7AUtZBjD4vPUTGKQCCMwmjbixFzJ3luYui+XguDcCmt2vsz4UaPZHGrmDHk2QBIr
         EISA==
X-Gm-Message-State: AFqh2koQ2KpCw5mh26JecLX6rVEAxOU0EWZFQ1Q5FeXXe/yEWfbSKp8Q
        YJzAWtc7ZO6hirjnV0wM3a/H1Ic4a6s2AqyYsg0N0luudpQRt/ol
X-Google-Smtp-Source: AMrXdXuWevfq7MaXD6yeFl3FOjTb0cXp+nF6Y92mxk+aAn2xWAjKk7qNSv4APLm4uOkjHzAEB8advUpAbQrrdSiCM1g=
X-Received: by 2002:a9d:61ca:0:b0:670:6dc1:6c2c with SMTP id
 h10-20020a9d61ca000000b006706dc16c2cmr4065515otk.375.1673297070961; Mon, 09
 Jan 2023 12:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20230109093347.6639-1-apantykhin@gmail.com>
In-Reply-To: <20230109093347.6639-1-apantykhin@gmail.com>
From:   Alexander Pantyukhin <apantykhin@gmail.com>
Date:   Tue, 10 Jan 2023 00:44:20 +0400
Message-ID: <CAPi66w-mB1LSW=O7mm3jqH0FRCr9h6Y4CiXfTPA6vP=TPNSx2w@mail.gmail.com>
Subject: Re: [PATCH] tools:perf:scripts:python:mem-phys-addr fix performance
To:     mark.rutland@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
There are some things which I would like to discuss there.

1) I found that if there is for example the following system_ram:
system_ram =3D [int('00000000', 16) , int('0000ffff', 16)]

and the func

def is_system_ram(phys_addr):
    #/proc/iomem is sorted
    position =3D bisect.bisect(system_ram, phys_addr)
    if position % 2 =3D=3D 0:
    return False
    return True

The value:
is_system_ram(int('0000ffff', 16)) is False.
It seems to be a mistake. This value is the end of the range and it
should be a True.
(There is another check on the 88 line: if int(m[0], 16) <=3D phys_addr
<=3D int(m[1], 16)
where both ranges are included in the check.)

2) The script reads the whole file when parse_iomem()
and uses this information for pmem and system_ram. What if to store
whole info about addresses
for all memory types?
In This case it's possible to store the data structure like the
following example:

/proc/iomem
00000000-0000ffff : reserved
00010000-0009f3ff : System RAM

Result: [(00000000, 'reserved'), (0000ffff, 'reserved'), (00010000,
'System RAM'), (0009f3ff, 'System RAM')....]

This case the searching would be O(log(n)) for all types not just for
"System RAM" and "Persistent Memory".

But the behavior of the script would be changed: the current version
re-read the file and scan the fresh data
when neither "System RAM" nor "Persistent Memory". But the suggested
fix requires to call parse_iomem() when
fresh data is required.

If these changes are approved, I would like to fix it.

Best, Alex.

=D0=BF=D0=BD, 9 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 13:33, Alexander Pa=
ntyukhin <apantykhin@gmail.com>:
>
> Avoid double strip() calls for getting memory type.
>
> Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
> ---
>  tools/perf/scripts/python/mem-phys-addr.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scri=
pts/python/mem-phys-addr.py
> index 1f332e72b9b0..f267d8382eda 100644
> --- a/tools/perf/scripts/python/mem-phys-addr.py
> +++ b/tools/perf/scripts/python/mem-phys-addr.py
> @@ -8,7 +8,6 @@ from __future__ import print_function
>
>  import os
>  import sys
> -import struct
>  import re
>  import bisect
>  import collections
> @@ -30,12 +29,14 @@ event_name =3D None
>  def parse_iomem():
>         global f
>         f =3D open('/proc/iomem', 'r')
> -       for i, j in enumerate(f):
> +       for _, j in enumerate(f):
>                 m =3D re.split('-|:',j,2)
> -               if m[2].strip() =3D=3D 'System RAM':
> +               memory_type =3D m[2].strip()
> +
> +               if memory_type =3D=3D 'System RAM':
>                         system_ram.append(int(m[0], 16))
>                         system_ram.append(int(m[1], 16))
> -               if m[2].strip() =3D=3D 'Persistent Memory':
> +               elif memory_type =3D=3D 'Persistent Memory':
>                         pmem.append(int(m[0], 16))
>                         pmem.append(int(m[1], 16))
>
> @@ -75,6 +76,7 @@ def is_persistent_mem(phys_addr):
>  def find_memory_type(phys_addr):
>         if phys_addr =3D=3D 0:
>                 return "N/A"
> +
>         if is_system_ram(phys_addr):
>                 return "System RAM"
>
> --
> 2.25.1
>
