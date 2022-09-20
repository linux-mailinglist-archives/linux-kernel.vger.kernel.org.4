Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80635BEE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiITUUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiITUUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:20:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7EB1EC56;
        Tue, 20 Sep 2022 13:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE0D662990;
        Tue, 20 Sep 2022 20:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CB5C433D6;
        Tue, 20 Sep 2022 20:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663705203;
        bh=2+ENAYE8ehVwmcxbOTeuAqbgb0Y266rcs4NiZqtgqjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asvmFW4XObXemY07ghw90NJHDkynfFwblhuWBs3HTS/MXUfElhF2UeLOVfixT2yx1
         msxW1YWHeZK8nsG5Av7pWYmIZoKlBGLcBQHS6h8acPHZZDekxRsWNWhPRImVXRTXqD
         zcuJpbaLrrgMmDeWdGEggxHUS2OTxO1OwC27qMBT1WSW1t8aV/F1JZ+ud6mcyGQKnz
         hmJXsP7yVCrVK9sxHXC20sVniw2Cl4scQu8TdTJiNV9w9gCF2JGhLlTNQu7o6JrBUF
         b/7ql5VRIqy+1QZghL5JT2KA14poVTIJcfcwM/Ja8yDa5VgW0T2e5UpEpRWijkmLYC
         QrM/Gz0SynO1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFB6440856; Tue, 20 Sep 2022 21:20:00 +0100 (IST)
Date:   Tue, 20 Sep 2022 21:20:00 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Daniel Dao <dqminh@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf kcore_copy: Do not check /proc/modules is unchanged
Message-ID: <YyogcHTpJRKjevIn@kernel.org>
References: <20220914122429.8770-1-adrian.hunter@intel.com>
 <CAM9d7chgWF_iCFeSN0ovoiq=c+JCmD16VVopKzFjjr5En9Eqaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chgWF_iCFeSN0ovoiq=c+JCmD16VVopKzFjjr5En9Eqaw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 16, 2022 at 11:02:25AM -0700, Namhyung Kim escreveu:
> On Wed, Sep 14, 2022 at 5:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > /proc/kallsyms and /proc/modules are compared before and after the copy
> > in order to ensure no changes during the copy. However /proc/modules
> > also might change due to reference counts changing even though that
> > does not make any difference. Any modules loaded or unloaded should be
> > visible in changes to kallsyms, so it is not necessary to check
> > /proc/modules also anyway.
> >
> > Remove the comparison checking that /proc/modules is unchanged.
> >
> > Reported-by: Daniel Dao <dqminh@cloudflare.com>
> > Fixes: fc1b691d7651 ("perf buildid-cache: Add ability to add kcore to the cache")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/symbol-elf.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 75bec32d4f57..647b7dff8ef3 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -2102,8 +2102,8 @@ static int kcore_copy__compare_file(const char *from_dir, const char *to_dir,
> >   * unusual.  One significant peculiarity is that the mapping (start -> pgoff)
> >   * is not the same for the kernel map and the modules map.  That happens because
> >   * the data is copied adjacently whereas the original kcore has gaps.  Finally,
> > - * kallsyms and modules files are compared with their copies to check that
> > - * modules have not been loaded or unloaded while the copies were taking place.
> > + * kallsyms file is compared with its copy to check that modules have not been
> > + * loaded or unloaded while the copies were taking place.
> >   *
> >   * Return: %0 on success, %-1 on failure.
> >   */
> > @@ -2166,9 +2166,6 @@ int kcore_copy(const char *from_dir, const char *to_dir)
> >                         goto out_extract_close;
> >         }
> >
> > -       if (kcore_copy__compare_file(from_dir, to_dir, "modules"))
> > -               goto out_extract_close;
> > -
> >         if (kcore_copy__compare_file(from_dir, to_dir, "kallsyms"))
> >                 goto out_extract_close;
> >
> > --
> > 2.25.1
> >

-- 

- Arnaldo
