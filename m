Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B869740F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBOCD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjBOCDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:03:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D32B09C;
        Tue, 14 Feb 2023 18:03:12 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 16so11575537pfo.8;
        Tue, 14 Feb 2023 18:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmW8syz2zNNtStQhfhVL5+Vcz/fTkBT33+R+BuQLTdA=;
        b=QmDFYDqAF13r1jzKg/L8kuJVHfj63JmeIwWa3XzS/jJJnyGZGVG5MwOL0OLB74Ac+w
         yQUL5e4Qw9MrEtBiYvf1SO1NWYVTdtEc0GgQVz33p7/w4+aLoHnGyDL2tMbcsRDRcE13
         QWaSivoLvfmzbm7nSPLGPjG+bHHPYzV/FBAsEHxIRdOEhBhM+byR/+E1o8xXKIDkHwxV
         78JXwdeNeAtzsm99zUvYw/HEg19TrnFXOdDEGI3z7OouJwB1BZLQveBzeEf/qTtisvfw
         STS5ebHyK4ips1XxiM5Mv2td3RuwN9qM8cWWjAZH5BO8hHAGvcxdsaKOgUUZSq5z/Zx5
         KlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmW8syz2zNNtStQhfhVL5+Vcz/fTkBT33+R+BuQLTdA=;
        b=FlSMkMH0FsiDfj3UAaj4rtfhWZ+2cAyEgutfXxqSLGnrGJWkpVPjolD3QV+aKfmnhQ
         hmUxA/YI+sG3KpUWbg0ws1WvSPEE9ZftDZfPL+LNlBN/0vJ9uRk96gMcY9UDyyIQXK7l
         LRU2dsoWHRHqzixVkXsF2TCH7kTRX2wreeLK0iJn0SoYtweX893xUACOmEaGVShrkm4F
         chYHhl0jzyPCxnWDzdHa8bpGmiCiwOV4i+Or2H8/TDXEa71pHg4wmJXV6mlgBhOVfi0G
         A7nNY6J6mz19LaWvluwcyULwuh/J5jvhAYdFuTWozLW+SjO41JY/8dyH+EamTfFePdFz
         MKjw==
X-Gm-Message-State: AO0yUKUP3DHLJl31fEDGVqf+WZAbuaIPHY9Ut/lkJA/Q4ggGL4yZfa3Y
        B7IOvPJtP69HVweKTwwKcr4=
X-Google-Smtp-Source: AK7set9H0gjnTLoAb1IYmmc6EOBRCBTYo/dW1Ipht2+jl0gRcBlhVzVk3iHH5TGqRaTz6WzxooewBA==
X-Received: by 2002:a62:1854:0:b0:5a8:abd2:2beb with SMTP id 81-20020a621854000000b005a8abd22bebmr177579pfy.30.1676426592171;
        Tue, 14 Feb 2023 18:03:12 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-66.three.co.id. [223.255.225.66])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b005a8b4dcd213sm4705874pfo.78.2023.02.14.18.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:03:11 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 39D3D105563; Wed, 15 Feb 2023 09:03:08 +0700 (WIB)
Date:   Wed, 15 Feb 2023 09:03:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Ross Zwisler <zwisler@google.com>
Subject: Re: linux-next: manual merge of the ftrace tree with the jc_docs tree
Message-ID: <Y+w9W5JM6zIvnsWZ@debian.me>
References: <20230215121638.1e86ffa1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pHNxZJhB0m2qZi4p"
Content-Disposition: inline
In-Reply-To: <20230215121638.1e86ffa1@canb.auug.org.au>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pHNxZJhB0m2qZi4p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 12:16:38PM +1100, Stephen Rothwell wrote:
> diff --cc Documentation/trace/histogram.rst
> index 7b7e4893b8f6,8e95295e39b6..000000000000
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@@ -1861,9 -1864,9 +1864,9 @@@ A histogram can now be defined for the=20
>   The above shows the latency "lat" in a power of 2 grouping.
>  =20
>   Like any other event, once a histogram is enabled for the event, the
> - output can be displayed by reading the event's 'hist' file.
> + output can be displayed by reading the event's 'hist' file::
>  =20
>  -  # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
>  +  # cat /sys/kernel/tracing/events/synthetic/wakeup_latency/hist
>  =20
>     # event histogram
>     #
> @@@ -1908,10 -1911,10 +1911,10 @@@
>  =20
>  =20
>   The latency values can also be grouped linearly by a given size with
> - the ".buckets" modifier and specify a size (in this case groups of 10).
> + the ".buckets" modifier and specify a size (in this case groups of 10)::
>  =20
>     # echo 'hist:keys=3Dpid,prio,lat.buckets=3D10:sort=3Dlat' >> \
>  -        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigg=
er
>  +        /sys/kernel/tracing/events/synthetic/wakeup_latency/trigger
>  =20
>     # event histogram
>     #
> @@@ -2052,13 -2182,13 +2182,13 @@@ The following commonly-used handler.act
>  =20
>         # echo 'hist:keys=3D$testpid:testpid=3Dpid:onmatch(sched.sched_wa=
keup_new).\
>                 wakeup_new_test($testpid) if comm=3D=3D"cyclictest"' >> \
>  -              /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/t=
rigger
>  +              /sys/kernel/tracing/events/sched/sched_wakeup_new/trigger
>  =20
> -     Or, equivalently, using the 'trace' keyword syntax:
> +     Or, equivalently, using the 'trace' keyword syntax::
>  =20
> -     # echo 'hist:keys=3D$testpid:testpid=3Dpid:onmatch(sched.sched_wake=
up_new).\
> -             trace(wakeup_new_test,$testpid) if comm=3D=3D"cyclictest"' =
>> \
> -             /sys/kernel/tracing/events/sched/sched_wakeup_new/trigger
> +       # echo 'hist:keys=3D$testpid:testpid=3Dpid:onmatch(sched.sched_wa=
keup_new).\
> +               trace(wakeup_new_test,$testpid) if comm=3D=3D"cyclictest"=
' >> \
>  -              /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/t=
rigger
> ++              /sys/kernel/tracing/events/sched/sched_wakeup_new/trigger
>  =20
>       Creating and displaying a histogram based on those events is now
>       just a matter of using the fields and new synthetic event in the
> @@@ -2191,48 -2321,48 +2321,48 @@@
>       resulting latency, stored in wakeup_lat, exceeds the current
>       maximum latency, a snapshot is taken.  As part of the setup, all
>       the scheduler events are also enabled, which are the events that
> -     will show up in the snapshot when it is taken at some point:
> +     will show up in the snapshot when it is taken at some point::
>  =20
> -     # echo 1 > /sys/kernel/tracing/events/sched/enable
>  -      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> ++      # echo 1 > /sys/kernel/tracing/events/sched/enable
>  =20
> -     # echo 'hist:keys=3Dpid:ts0=3Dcommon_timestamp.usecs \
> -             if comm=3D=3D"cyclictest"' >> \
> -             /sys/kernel/tracing/events/sched/sched_waking/trigger
> +       # echo 'hist:keys=3Dpid:ts0=3Dcommon_timestamp.usecs \
> +               if comm=3D=3D"cyclictest"' >> \
>  -              /sys/kernel/debug/tracing/events/sched/sched_waking/trigg=
er
> ++              /sys/kernel/tracing/events/sched/sched_waking/trigger
>  =20
> -     # echo 'hist:keys=3Dnext_pid:wakeup_lat=3Dcommon_timestamp.usecs-$t=
s0: \
> -             onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_p=
rio, \
> - 	    prev_comm):onmax($wakeup_lat).snapshot() \
> - 	    if next_comm=3D=3D"cyclictest"' >> \
> - 	    /sys/kernel/tracing/events/sched/sched_switch/trigger
> +       # echo 'hist:keys=3Dnext_pid:wakeup_lat=3Dcommon_timestamp.usecs-=
$ts0: \
> +               onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev=
_prio, \
> + 	      prev_comm):onmax($wakeup_lat).snapshot() \
> + 	      if next_comm=3D=3D"cyclictest"' >> \
>  -	      /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> ++	      /sys/kernel/tracing/events/sched/sched_switch/trigger
>  =20
>       When the histogram is displayed, for each bucket the max value
>       and the saved values corresponding to the max are displayed
>       following the rest of the fields.
>  =20
>       If a snapshot was taken, there is also a message indicating that,
> -     along with the value and event that triggered the global maximum:
> +     along with the value and event that triggered the global maximum::
>  =20
> -     # cat /sys/kernel/tracing/events/sched/sched_switch/hist
> -       { next_pid:       2101 } hitcount:        200
> - 	max:         52  next_prio:        120  next_comm: cyclictest \
> -         prev_pid:          0  prev_prio:        120  prev_comm: swapper=
/6
>  -      # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
> ++      # cat /sys/kernel/tracing/events/sched/sched_switch/hist
> +         { next_pid:       2101 } hitcount:        200
> + 	  max:         52  next_prio:        120  next_comm: cyclictest \
> +           prev_pid:          0  prev_prio:        120  prev_comm: swapp=
er/6
>  =20
> -       { next_pid:       2103 } hitcount:       1326
> - 	max:        572  next_prio:         19  next_comm: cyclictest \
> -         prev_pid:          0  prev_prio:        120  prev_comm: swapper=
/1
> +         { next_pid:       2103 } hitcount:       1326
> + 	  max:        572  next_prio:         19  next_comm: cyclictest \
> +           prev_pid:          0  prev_prio:        120  prev_comm: swapp=
er/1
>  =20
> -       { next_pid:       2102 } hitcount:       1982 \
> - 	max:         74  next_prio:         19  next_comm: cyclictest \
> -         prev_pid:          0  prev_prio:        120  prev_comm: swapper=
/5
> +         { next_pid:       2102 } hitcount:       1982 \
> + 	  max:         74  next_prio:         19  next_comm: cyclictest \
> +           prev_pid:          0  prev_prio:        120  prev_comm: swapp=
er/5
>  =20
> -     Snapshot taken (see tracing/snapshot).  Details:
> - 	triggering value { onmax($wakeup_lat) }:        572	\
> - 	triggered by event with key: { next_pid:       2103 }
> +       Snapshot taken (see tracing/snapshot).  Details:
> + 	  triggering value { onmax($wakeup_lat) }:        572	\
> + 	  triggered by event with key: { next_pid:       2103 }
>  =20
> -     Totals:
> -         Hits: 3508
> -         Entries: 3
> -         Dropped: 0
> +       Totals:
> +           Hits: 3508
> +           Entries: 3
> +           Dropped: 0
>  =20
>       In the above case, the event that triggered the global maximum has
>       the key with next_pid =3D=3D 2103.  If you look at the bucket that =
has
> @@@ -2310,15 -2440,15 +2440,15 @@@
>       $cwnd variable.  If the value has changed, a snapshot is taken.
>       As part of the setup, all the scheduler and tcp events are also
>       enabled, which are the events that will show up in the snapshot
> -     when it is taken at some point:
> +     when it is taken at some point::
>  =20
> -     # echo 1 > /sys/kernel/tracing/events/sched/enable
> -     # echo 1 > /sys/kernel/tracing/events/tcp/enable
>  -      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
>  -      # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
> ++      # echo 1 > /sys/kernel/tracing/events/sched/enable
> ++      # echo 1 > /sys/kernel/tracing/events/tcp/enable
>  =20
> -     # echo 'hist:keys=3Ddport:cwnd=3Dsnd_cwnd: \
> -             onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
> - 	    onchange($cwnd).snapshot()' >> \
> - 	    /sys/kernel/tracing/events/tcp/tcp_probe/trigger
> +       # echo 'hist:keys=3Ddport:cwnd=3Dsnd_cwnd: \
> +               onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
> + 	      onchange($cwnd).snapshot()' >> \
>  -	      /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
> ++	      /sys/kernel/tracing/events/tcp/tcp_probe/trigger
>  =20
>       When the histogram is displayed, for each bucket the tracked value
>       and the saved values corresponding to that value are displayed

The resolution LGTM, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--pHNxZJhB0m2qZi4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY+w9VgAKCRD2uYlJVVFO
o8IUAQD4I8rJ0HyWNGOhM52MK5ktOacj1ymOJcmNqhAhRq6VlwEAgIAvi8dXUtnY
wLIyZnedyTrNUlgErWwF560BFsB0Ngw=
=8AAl
-----END PGP SIGNATURE-----

--pHNxZJhB0m2qZi4p--
