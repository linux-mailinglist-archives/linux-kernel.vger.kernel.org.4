Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB216C6C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjCWPun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjCWPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:50:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F65270B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:50:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3ed5cf9a455so63345e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679586639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfdI9P0w7BsEhZbIeZstC1SbyLByst3A6MZbU2P/PdA=;
        b=M0KLrypF9Eqf0Vzzw6TFab+9iQ+Ncl3B1z5cS2TruXPxfCRAnMc0Bsyt6FHXYX487C
         /ZAHiVD9ttbXsMKvR8J8QO8Rlp/b8weR3Sfwy+CkAzHvD5ESJhDusVkFb2Aa9+8jnhrt
         oY70G84O0h76FWyD3sMKsl7+coFfitqmLBdzEXnBXrNmcRoJOuByY6N/nb/29jm/j7et
         wtvFCsH01qVhPpDKApQfrzth8TWB/JdQnrLtlMWHUSLbEexnIoyZXD5ZTNlUT8eeQWbW
         6o6eimueCK1hZDEPHib4b11pg2Uw8U4LgLGoafXcwqHgBrJ16SWu5L+VTVQCfqcSczsD
         FL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfdI9P0w7BsEhZbIeZstC1SbyLByst3A6MZbU2P/PdA=;
        b=plbu8LCGrx/Kq4tW8RKFkFQoePEKfbgolcQR+nIdAeycl4SZDcLumHHw6LNpeH49xO
         RRU0vGE0ofge/IK3/o7pAUAuxxse7dsxShME99CMBaXF4D8FlZ9IhvPCc3LkrazHOaoo
         1kP1SETSGfEsw+cYQg5UVMW6eH+zchjnGL0MZMHd3MEdJz2DxdYHD1BRe8eU3ONZ0I5K
         oUZuufjHhMU1RXGbPmUket2/9aFFTphvLsTn89ra0I0A/8HqP0kuAHA9AZMPXteJoIJ0
         nSysHfW7SqYHLLYdL8yBlFeU1YG3tOwV19hjgFIwXsdwH1HGq+N4F4LTU/mIB+s9B1ve
         iecQ==
X-Gm-Message-State: AO0yUKUWe36FwedUYHuBA+6gXoujblrcxprVlCImeJL9lHr5fAPBCbm+
        N3X1TIoon7gygnR8jZe2CITn/Y6eYqgQsVm1HbsAReyqCPqkLBsIjp0=
X-Google-Smtp-Source: AK7set8lqur84/fe+VYl9U45ksdbEDweEiqlIGbpsmubdP0iQFhECOJZ/No6eWEGme2wt6RUP8SzwqkDovdZBGmGUJQ=
X-Received: by 2002:a05:600c:4fc2:b0:3ee:113f:4fd9 with SMTP id
 o2-20020a05600c4fc200b003ee113f4fd9mr209617wmq.1.1679586639380; Thu, 23 Mar
 2023 08:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZBxP77deq7ikTxwG@kernel.org>
In-Reply-To: <ZBxP77deq7ikTxwG@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Mar 2023 08:50:27 -0700
Message-ID: <CAP-5=fX-0giZxATOVXO5PmCD6yfhoGMb4_vMcWAQLnSq=+DMhQ@mail.gmail.com>
Subject: Re: perf tools power9 JSON files build breakage on ubuntu 18.04 cross build
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 6:11=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Exception processing pmu-events/arch/powerpc/power9/other.json
> Traceback (most recent call last):
>   File "pmu-events/jevents.py", line 997, in <module>
>     main()
>   File "pmu-events/jevents.py", line 979, in main
>     ftw(arch_path, [], preprocess_one_file)
>   File "pmu-events/jevents.py", line 935, in ftw
>     ftw(item.path, parents + [item.name], action)
>   File "pmu-events/jevents.py", line 933, in ftw
>     action(parents, item)
>   File "pmu-events/jevents.py", line 514, in preprocess_one_file
>     for event in read_json_events(item.path, topic):
>   File "pmu-events/jevents.py", line 388, in read_json_events
>     events =3D json.load(open(path), object_hook=3DJsonEvent)
>   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
>     return loads(fp.read(),
>   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
>     return codecs.ascii_decode(input, self.errors)[0]
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 5509=
0: ordinal not in range(128)
>   CC      /tmp/build/perf/tests/expr.o
> pmu-events/Build:35: recipe for target '/tmp/build/perf/pmu-events/pmu-ev=
ents.c' failed
> make[3]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 1
> make[3]: *** Deleting file '/tmp/build/perf/pmu-events/pmu-events.c'
> Makefile.perf:679: recipe for target '/tmp/build/perf/pmu-events/pmu-even=
ts-in.o' failed
> make[2]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>
>
> Now jevents is an opt-out feature so I'm noticing these problems.
>
> A similar fix for s390 was accepted today:

The JEVENTS_ARCH=3Dall make option builds the s390 files even on x86.
I'm confused as to why that's been working before these fixes.

Thanks,
Ian

> https://lore.kernel.org/r/20230323122532.2305847-1-tmricht@linux.ibm.com
> https://lore.kernel.org/r/ZBwkl77/I31AQk12@osiris
> --
>
> - Arnaldo
