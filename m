Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992496AF624
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjCGTyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjCGTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:53:46 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BE2A17CD;
        Tue,  7 Mar 2023 11:45:28 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h31so8285437pgl.6;
        Tue, 07 Mar 2023 11:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678218327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8WHAoxDTRRK4jgSNRWSO106FAPif1ofRn3Id2SdfTg=;
        b=Df7Py+r+m8TXzKdv94IMkfGQikmUBvIMX0mpKskcpWVQxBtnSYifG65S7ptSkgy4hD
         dyJBe3RRVpaDLcMe2/WgMbLwgSvkfcFJ15689YjlPWO6VxQFsPWh6c7CCanjgOlTKRVO
         ksWtvFsuzT4zUxfnzRJiIh4MLVxwo/isqPSgVBt9h8iZR53N2tvKT4bw3sDEFJ0wcKhQ
         LRgsGCPWQl6g8mQFruudwy+LexsvlrdKtRjto7Zde28tzAybL5vqzoMy10Stp7TGnUUj
         WC7QMlv2QAVsGQeiLv++s+uzRNxGeFDjyr6m9xA1j/pdVsMSIsXHPFmXmA18VpXFZQNu
         ZYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678218327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8WHAoxDTRRK4jgSNRWSO106FAPif1ofRn3Id2SdfTg=;
        b=bjNQcaQWxf/vTkr29KgQZmc9kLYSjnRG31FUd5H8+HuYZUtq+N8NNcuS21evheqBbS
         ov5s2PMSNUqOLxv8ZjZ6Bn4plMEMz0cAczcWquorTuQ++d3vOuNYedXN/0BUcdnNC1yn
         i12A6dahL7c9Ua63CJyVMk+BG1znLzp6CZHPQxAQv6NIzomb+P+FU+KIxxK/vK35KF7f
         al1A8CLz1WYCV+A4zLGQtyWGLYwle3uULkCtRcgXQ9tgoFJE/I/W3eaR6F+tZHPuEkkb
         79zY/YWUb3P2xijQ25/XVHfSCK8GihEg8wNwrt+SxvForW8OsRqjKETq/EGzTgC5wkYs
         uPMQ==
X-Gm-Message-State: AO0yUKXDP9SWPv3L89a5dsjjyg8hj6f5ehO/86NQwJ4n8/IJ8pMDad8I
        SBKpwA1b3DXHNBxDbvdn3HaU4S4rka2eR4sBspY=
X-Google-Smtp-Source: AK7set8dNzbBQE8T8gnrJ4/QKDyk+bntEZEGiPqi70liTAPp0sYr6bg4WsKA8nle1I/wlCQ54LthkY82dhH9SuSP1vQ=
X-Received: by 2002:a63:931e:0:b0:503:2561:6fed with SMTP id
 b30-20020a63931e000000b0050325616fedmr5561743pge.1.1678218327480; Tue, 07 Mar
 2023 11:45:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
In-Reply-To: <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 7 Mar 2023 11:45:16 -0800
Message-ID: <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        leo.yan@linaro.org, mathieu.poirier@linaro.org,
        adrian.hunter@intel.com, Jiri Olsa <jolsa@kernel.org>,
        acme@redhat.com, mike.leach@linaro.org,
        Will Deacon <will@kernel.org>, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for the prompt response. Please see the inline replies.

On Tue, Mar 7, 2023 at 2:32=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
>
>
> On 06/03/2023 21:13, Yang Shi wrote:
> > Hi,
> >
> > I'm seeking some help regarding perf record --kcore + coresight. When
> > I tracing with perf record --kcore -e cs_etm ... , perf report shows
> > "The perf.data/data data has no samples!".
> >
> > I tried other combinations:
> > 1. perf record --kcore (w/o using coresight): works
> > 2. perf record -e cs_etm ... : works
> > 3. Manually copy kcore with perf buildid-cache, then run perf record
> > -e cs_etm... : works
> >
> > So just "perf record --kcore -e cs_etm ..." doesn't work.
> >
> > I'm using v6.2 kernel and the perf is built from the same kernel
> > source with OpenCSD 1.4. Also attached the sample file generated by
> > perf.
> >
> > Any suggestion is appreciated.
> >
> > Thanks,
> > Yang
>
> Hi Yang,
>
> I don't see any issue with this command and I still get samples:
>
>   perf record -e cs_etm// --kcore -- true

This command works for me. But the below command doesn't work:

perf record --kcore -e cs_etm/@tmc_etf63/k --per-thread -- taskset
--cpu-list 1 uname

>
> You might want to try running both record and report in verbose and
> stdio mode (-vvv --stdio) to see if you see any warnings.
>
> I can't think of any way --kcore would cause an issue because all it
> does is save kcore into the .debug cache rather than affecting the
> actual perf.data file.

Yes, this is what I thought. But digging into the code seems it may
add a new dummy event. Please see the below data header dump.

>
> Are you running perf report in the same place the recording was made? Or
> on another system?

Yes.

I did some further investigation. The below is the dump for both good
and bad data files.

Good (copy kcore manually):
# captured on    : Tue Mar  7 11:19:14 2023
# header version : 1
# data offset    : 1576
# data size      : 26736
# feat offset    : 28312
# hostname : fedora
# os release : 6.2.0-coresight+
# perf version : 6.2.g3424af22c4fc
# arch : aarch64
# nrcpus online : 128
# nrcpus avail : 128
# cpuid : 0x00000000c00fac30
# total memory : 2108862504 kB
# cmdline : /root/bin/perf record -e cs_etm/@tmc_etf63/k --kcore
--per-thread -- taskset --cpu-list 1 true
# event : name =3D cs_etm/@tmc_etf63/k, , id =3D { 2248 }, type =3D 9, size
=3D 128, { sample_period, sample_freq } =3D 1, sample_type =3D
IP|TID|IDENTIFIER, read_format =3D ID|LO
ST, disabled =3D 1, exclude_user =3D 1, exclude_hv =3D 1, enable_on_exec =
=3D
1, sample_id_all =3D 1, { bp_len, config2 } =3D 0x12792918
# event : name =3D dummy:u, , id =3D { 2249 }, type =3D 1, size =3D 128,
config =3D 0x9, { sample_period, sample_freq } =3D 1, sample_type =3D
IP|TID|IDENTIFIER, read_format =3D ID|
LOST, disabled =3D 1, exclude_kernel =3D 1, exclude_hv =3D 1, mmap =3D 1, c=
omm
=3D 1, enable_on_exec =3D 1, task =3D 1, sample_id_all =3D 1, exclude_guest=
 =3D
1, mmap2 =3D 1, comm_exec
=3D 1, context_switch =3D 1, bpf_event =3D 1
# event : name =3D dummy:u, , id =3D { 2250, 2251, 2252, 2253, 2254, 2255,
2256, 2257, 2258, 2259, 2260, 2261, 2262, 2263, 2264, 2265, 2266,
2267, 2268, 2269, 2270, 2271
, 2272, 2273, 2274, 2275, 2276, 2277, 2278, 2279, 2280, 2281, 2282,
2283, 2284, 2285, 2286, 2287, 2288, 2289, 2290, 2291, 2292, 2293,
2294, 2295, 2296, 2297, 2298, 2
299, 2300, 2301, 2302, 2303, 2304, 2305, 2306, 2307, 2308, 2309, 2310,
2311, 2312, 2313, 2314, 2315, 2316, 2317, 2318, 2319, 2320, 2321,
2322, 2323, 2324, 2325, 2326
, 2327, 2328, 2329, 2330, 2331, 2332, 2333, 2334, 2335, 2336, 2337,
2338, 2339, 2340, 2341, 2342, 2343, 2344, 2345, 2346, 2347, 2348,
2349, 2350, 2351, 2352, 2353, 2
354, 2355, 2356, 2357, 2358, 2359, 2360, 2361, 2362, 2363, 2364, 2365,
2366, 2367, 2368, 2369, 2370, 2371, 2372, 2373, 2374, 2375, 2376, 2377
}, type =3D 1, size =3D 128
, config =3D 0x9, { sample_period, sample_freq } =3D 1, sample_type =3D
IP|TID|TIME|IDENTIFIER, read_format =3D ID|LOST, exclude_kernel =3D 1,
exclude_hv =3D 1, sample_id_all =3D
1, exclude_guest =3D 1, ksymbol =3D 1, text_poke =3D 1
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: armv8_pmuv3_0 =3D 8, software =3D 1, arm_cmn_0 =3D 10,
uprobe =3D 7, cs_etm =3D 9, breakpoint =3D 5, tracepoint =3D 2, arm_cmn_1 =
=3D
11, kprobe =3D 6
# contains AUX area data (e.g. instruction trace)
# CACHE info available, use -I to display
# time of first sample : 18446744073.709551
# time of last sample : 18446744073.709551
# sample duration :      0.000 ms
# MEM_TOPOLOGY info available, use -I to display
# armv8_pmuv3_0 pmu capabilities: slots=3D0x00000004,
bus_slots=3D0x00000000, bus_width=3D0x00000000
# missing features: (null) CPUDESC BRANCH_STACK GROUP_DESC STAT
CLOCKID DIR_FORMAT COMPRESSED CPU_PMU_CAPS CLOCK_DATA HYBRID_TOPOLOGY

Bad:
# captured on    : Tue Mar  7 11:19:14 2023
# header version : 1
# data offset    : 1576
# data size      : 26736
# feat offset    : 28312
# hostname : fedora
# os release : 6.2.0-coresight+
# perf version : 6.2.g3424af22c4fc
# arch : aarch64
# nrcpus online : 128
# nrcpus avail : 128
# cpuid : 0x00000000c00fac30
# total memory : 2108862504 kB
# cmdline : /root/bin/perf record -e cs_etm/@tmc_etf63/k --kcore
--per-thread -- taskset --cpu-list 1 true
# event : name =3D cs_etm/@tmc_etf63/k, , id =3D { 2248 }, type =3D 9, size
=3D 128, { sample_period, sample_freq } =3D 1, sample_type =3D
IP|TID|IDENTIFIER, read_format =3D ID|LO
ST, disabled =3D 1, exclude_user =3D 1, exclude_hv =3D 1, enable_on_exec =
=3D
1, sample_id_all =3D 1, { bp_len, config2 } =3D 0x12792918
# event : name =3D dummy:u, , id =3D { 2249 }, type =3D 1, size =3D 128,
config =3D 0x9, { sample_period, sample_freq } =3D 1, sample_type =3D
IP|TID|IDENTIFIER, read_format =3D ID|
LOST, disabled =3D 1, exclude_kernel =3D 1, exclude_hv =3D 1, mmap =3D 1, c=
omm
=3D 1, enable_on_exec =3D 1, task =3D 1, sample_id_all =3D 1, exclude_guest=
 =3D
1, mmap2 =3D 1, comm_exec
=3D 1, context_switch =3D 1, bpf_event =3D 1
# event : name =3D dummy:u, , id =3D { 2250, 2251, 2252, 2253, 2254, 2255,
2256, 2257, 2258, 2259, 2260, 2261, 2262, 2263, 2264, 2265, 2266,
2267, 2268, 2269, 2270, 2271
, 2272, 2273, 2274, 2275, 2276, 2277, 2278, 2279, 2280, 2281, 2282,
2283, 2284, 2285, 2286, 2287, 2288, 2289, 2290, 2291, 2292, 2293,
2294, 2295, 2296, 2297, 2298, 2
299, 2300, 2301, 2302, 2303, 2304, 2305, 2306, 2307, 2308, 2309, 2310,
2311, 2312, 2313, 2314, 2315, 2316, 2317, 2318, 2319, 2320, 2321,
2322, 2323, 2324, 2325, 2326
, 2327, 2328, 2329, 2330, 2331, 2332, 2333, 2334, 2335, 2336, 2337,
2338, 2339, 2340, 2341, 2342, 2343, 2344, 2345, 2346, 2347, 2348,
2349, 2350, 2351, 2352, 2353, 2
354, 2355, 2356, 2357, 2358, 2359, 2360, 2361, 2362, 2363, 2364, 2365,
2366, 2367, 2368, 2369, 2370, 2371, 2372, 2373, 2374, 2375, 2376, 2377
}, type =3D 1, size =3D 128
, config =3D 0x9, { sample_period, sample_freq } =3D 1, sample_type =3D
IP|TID|TIME|IDENTIFIER, read_format =3D ID|LOST, exclude_kernel =3D 1,
exclude_hv =3D 1, sample_id_all =3D
1, exclude_guest =3D 1, ksymbol =3D 1, text_poke =3D 1
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: armv8_pmuv3_0 =3D 8, software =3D 1, arm_cmn_0 =3D 10,
uprobe =3D 7, cs_etm =3D 9, breakpoint =3D 5, tracepoint =3D 2, arm_cmn_1 =
=3D
11, kprobe =3D 6
# contains AUX area data (e.g. instruction trace)
# CACHE info available, use -I to display
# time of first sample : 18446744073.709551
# time of last sample : 18446744073.709551
# sample duration :      0.000 ms
# MEM_TOPOLOGY info available, use -I to display
# armv8_pmuv3_0 pmu capabilities: slots=3D0x00000004,
bus_slots=3D0x00000000, bus_width=3D0x00000000
# missing features: (null) CPUDESC BRANCH_STACK GROUP_DESC STAT
CLOCKID DIR_FORMAT COMPRESSED CPU_PMU_CAPS CLOCK_DATA HYBRID_TOPOLOGY


Dumping raw events could show the events from the bad data file. But
it has zero samples after event collapse.

The only difference is --kcore inserted a new text_poke dummy event.
It seems coresight also inserted a dummy event with my command but
your command didn't. So it seems like the two dummy events confused
event collapse.

The text_poke dummy event is added by commit
f42c0ce573df79d1b8bd169008c994dcdd43585a ("perf record: Always get
text_poke events with --kcore option"). If I reverted this commit,
then it works. But I'm not sure whether this is the right fix or real
root cause or not. Or coresight shouldn't insert its own dummy event?

>
> James
