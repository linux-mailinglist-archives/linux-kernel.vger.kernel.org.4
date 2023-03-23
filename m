Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC896C68FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCWM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCWM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:59:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02C42ED60;
        Thu, 23 Mar 2023 05:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68DC2B820F7;
        Thu, 23 Mar 2023 12:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DDBC433D2;
        Thu, 23 Mar 2023 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679576370;
        bh=YOBJmsp7i1KWavj4jti1adesbNPKvG0aHPIRQJ341es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtRpihDZjj8YcJgKjX7fIpTyRbnyV4VbInU34L/Be6y2oJw4mlI0Xer2LWmTObvJ+
         mV5cF1F2wQc1eUGVaxnMUoPBLM/ufAOE3c5eo2QB51a9l1KF5PkJIzJYxy6C2/iewN
         MQKyG2kvqH+p9IxIMz3BJDUN99XUcogSFInpgL8iZnoS+ru9kA0n+PxX7rAc7wCmT5
         Ktxczm2yE1eutPSei0MWh8TmeOfnexhfw1mJZCMpLKxBXOhGl2R/EUtFDETX4dcmXW
         O5rluaav4wp2+KPGGj5nRCwmKKdhg+4C16p2GAS2DybK1ZoUFFU4XRsNxWHm29/Smj
         qexajRgdCP71Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72EEF4052D; Thu, 23 Mar 2023 09:59:27 -0300 (-03)
Date:   Thu, 23 Mar 2023 09:59:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
Message-ID: <ZBxNLxmCh11Ig+Pk@kernel.org>
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
 <20230313080201.2440201-2-tmricht@linux.ibm.com>
 <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
 <ZA9sYL/re/aNVpo+@kernel.org>
 <1ee6884a-2d92-68d9-0917-3ae4f5390714@linux.ibm.com>
 <CAP-5=fUtJsvAtrhe4xESoQc8U15WJ8BWREbH51OKoA218uJLzw@mail.gmail.com>
 <ZBDo2GiuUTrHhd2L@kernel.org>
 <ZBtsNTt6Fbp1Lg3t@kernel.org>
 <9632bc6c-276e-d0d6-b6d9-efe91fe3a1e2@linux.ibm.com>
 <ZBwkl77/I31AQk12@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBwkl77/I31AQk12@osiris>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 23, 2023 at 11:06:15AM +0100, Heiko Carstens escreveu:
> On Thu, Mar 23, 2023 at 10:51:16AM +0100, Thomas Richter wrote:
> > On 3/22/23 21:59, Arnaldo Carvalho de Melo wrote:
> > > While trying to cross build to s390 on:
> > > 
> > > ubuntu:18.04
> > > 
> > > using python3
> > >  
> > > 
> > >    CC      /tmp/build/perf/tests/parse-events.o
> > > Exception processing pmu-events/arch/s390/cf_z16/extended.json
> > > Traceback (most recent call last):
> > >   File "pmu-events/jevents.py", line 997, in <module>
> > >     main()
> > >   File "pmu-events/jevents.py", line 979, in main
> > >     ftw(arch_path, [], preprocess_one_file)
> > >   File "pmu-events/jevents.py", line 935, in ftw
> > >     ftw(item.path, parents + [item.name], action)
> > >   File "pmu-events/jevents.py", line 933, in ftw
> > >     action(parents, item)
> > >   File "pmu-events/jevents.py", line 514, in preprocess_one_file
> > >     for event in read_json_events(item.path, topic):
> > >   File "pmu-events/jevents.py", line 388, in read_json_events
> > >     events = json.load(open(path), object_hook=JsonEvent)
> > >   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
> > >     return loads(fp.read(),
> > >   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
> > >     return codecs.ascii_decode(input, self.errors)[0]
> > > UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 4271: ordinal not in range(128)
> > > 
> > >
> > 
> > Hmmm, this is very strange. After reading this mail I installed Ubuntu 18.04
> > on my s390 system. The build works fine, no errors at all.
> > 
> > 
> > # pmu-events/jevents.py s390 all pmu-events/arch pmu-events/pmu-events.c
> > # ll pmu-events/pmu-events.c
> > -rw-r--r-- 1 root root 317284 Mar 23 10:46 pmu-events/pmu-events.c
> > #
> > 
> > The file has the correct contents and the build works fine too.
> > # make 
> 
> The file contains UTF-8 characters, which were already present before
> your patch. Guess you need to provide an addon patch which converts to
> plain ASCII.

Yeah, and in this s390 perf test build container in the past I didn't
have the needed python3-dev package needed to build jevents.py, so it
was being disabled and the problem was left unnoticed.

Now that it is a opt-out feature, I installed python3-dev, jevents.py
got built and then this failure surfaced.

- Arnaldo
