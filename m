Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133836C584B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCVU7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCVU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9203131;
        Wed, 22 Mar 2023 13:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788A262276;
        Wed, 22 Mar 2023 20:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749F1C433D2;
        Wed, 22 Mar 2023 20:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679518776;
        bh=87Afl5HnFSF4WgZ+2E0ys+G1g6P6k7cj2A7K/QdCgHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCH6pq7L+vFr2CaPWw+ssQd9utvA8fc/5RhttZ0oFWqVntcHd2RlMDRte+CowoGRn
         O+Y4qSrVHd86VutZAXzZlQWlV0I25bg71lIPH0W6lxqXsKaN3E7SYLgSFZwNAeTABZ
         V30UbRlxh+JQ7Fw+CB3GM02cul2GVaaw4K+SF4yA6U6Z9kMa4nC1MIsf24HmIK5HUH
         8LMGsXJxAMxlEyQCqgEpHQUav9w2RTHTjWe9bpTCzR1Ga2JEQ9yjyezKg7VszN4c7e
         B8d5r1EiRmGtV90ec96YCs6T9tPbvJfVURw2Hw2cIcbN8y2r8VLMTWB4Oxn7fsJh2G
         WYN+b92cmLuBg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82B164052D; Wed, 22 Mar 2023 17:59:33 -0300 (-03)
Date:   Wed, 22 Mar 2023 17:59:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
Message-ID: <ZBtsNTt6Fbp1Lg3t@kernel.org>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
 <20230313080201.2440201-2-tmricht@linux.ibm.com>
 <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
 <ZA9sYL/re/aNVpo+@kernel.org>
 <1ee6884a-2d92-68d9-0917-3ae4f5390714@linux.ibm.com>
 <CAP-5=fUtJsvAtrhe4xESoQc8U15WJ8BWREbH51OKoA218uJLzw@mail.gmail.com>
 <ZBDo2GiuUTrHhd2L@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBDo2GiuUTrHhd2L@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 14, 2023 at 06:36:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 14, 2023 at 09:34:46AM -0700, Ian Rogers escreveu:
> > On Tue, Mar 14, 2023 at 1:20 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > >
> > > On 3/13/23 19:33, Arnaldo Carvalho de Melo wrote:
> > > > Em Mon, Mar 13, 2023 at 08:22:44AM -0700, Ian Rogers escreveu:
> > > >> On Mon, Mar 13, 2023 at 1:30 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > > >>>
> > > >>> Add metrics for s390 z16
> > > >>> - Percentage sourced from Level 2 cache
> > > >>> - Percentage sourced from Level 3 on same chip cache
> > > >>> - Percentage sourced from Level 4 Local cache on same book
> > > >>> - Percentage sourced from Level 4 Remote cache on different book
> > > >>> - Percentage sourced from memory
> > > >>>
> > > >>> For details about the formulas see this documentation:
> > > >>> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Formulas%20including%20z16%20-%20May%202022_1.pdf
> > > >>>
> > > >>> Outpuf after:
> > > >>>  # ./perf stat -M l4rp -- dd if=/dev/zero of=/dev/null bs=10M count=10K
> > > >>>  .... dd output deleted
> > > >>>
> > > >>>  Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=10M count=10K':
> > > >>>
> > > >>>                  0      IDCW_OFF_DRAWER_CHIP_HIT         #     0.00 l4rp
> > > >>>            431,866      L1I_DIR_WRITES
> > > >>>              2,395      IDCW_OFF_DRAWER_IV
> > > >>>                  0      ICW_OFF_DRAWER
> > > >>>                  0      IDCW_OFF_DRAWER_DRAWER_HIT
> > > >>>              1,437      DCW_OFF_DRAWER
> > > >>>        425,960,793      L1D_DIR_WRITES
> > > >>>
> > > >>>       12.165030699 seconds time elapsed
> > > >>>
> > > >>>        0.001037000 seconds user
> > > >>>       12.162140000 seconds sys
> > > >>>
> > > >>>  #
> > > >>>
> > > >>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > >>> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > > >>
> > > >> Acked-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Thanks, applied the first two patches, please address the review
> > > > suggestions for patches 3-6 and resubmit only those.
> > > >
> > > > The patches will be in the public perf-tools-next branch later today.
> > > >
> > > > - Arnaldo
> > > >
> > >
> > > I would really prefer the current implementation without using "ScaleUnit": "100%"
> > > The reason is that these formulars are given to me from the s390 Performance team.
> > > They want to use the exact same formulars on all platforms running on s390
> > > which includes z/OS and z/VM. This way they are sure to get the same numbers.
> > >
> > > Hope this background info helps.
> > 
> > For the series:
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied.
> 
> - Arnaldo

While trying to cross build to s390 on:

ubuntu:18.04

using python3
 

   CC      /tmp/build/perf/tests/parse-events.o
Exception processing pmu-events/arch/s390/cf_z16/extended.json
Traceback (most recent call last):
  File "pmu-events/jevents.py", line 997, in <module>
    main()
  File "pmu-events/jevents.py", line 979, in main
    ftw(arch_path, [], preprocess_one_file)
  File "pmu-events/jevents.py", line 935, in ftw
    ftw(item.path, parents + [item.name], action)
  File "pmu-events/jevents.py", line 933, in ftw
    action(parents, item)
  File "pmu-events/jevents.py", line 514, in preprocess_one_file
    for event in read_json_events(item.path, topic):
  File "pmu-events/jevents.py", line 388, in read_json_events
    events = json.load(open(path), object_hook=JsonEvent)
  File "/usr/lib/python3.6/json/__init__.py", line 296, in load
    return loads(fp.read(),
  File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
    return codecs.ascii_decode(input, self.errors)[0]
UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 4271: ordinal not in range(128)

>  
> > Using ScaleUnit won't change the result. A ScaleUnit of "100%" means
> > scale the result up by multiplying by 100 and then apply the % after
> > the value. Another nit is having metrics that place their units in the
> > name, like _percent, is usually a sign the name can be better. Perhaps
> > we can follow up with some clean up.
> > 
> > Thanks,
> > Ian
> > 
> > > Thanks a lot.
> > > --
> > > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> > > --
> > > Vorsitzender des Aufsichtsrats: Gregor Pillen
> > > Geschäftsführung: David Faller
> > > Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> > >
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
