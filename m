Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D766F2216
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347271AbjD2BbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjD2BbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C039A10F9;
        Fri, 28 Apr 2023 18:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B06561B14;
        Sat, 29 Apr 2023 01:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A31C433EF;
        Sat, 29 Apr 2023 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682731874;
        bh=8vVB+NnMi8RMkMjonMxxDxtHJ0Cil/D4Pv0s0AwjbA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhuZALSe9GXdA4vvHA/TH6CYCGY+CeNMRgJK0P05VtUEL9qYcJxQ4GS8Ly67dZVjT
         UzsnC/Z3Vszz7BU61CLnTGs55r7kEXKGKEJyNQBnkQRHsDEDJxQPtYA+ygAE26RM1y
         29neqnjrRHtDD+fAmIEpVehjSmor8wYHEGAB9SiJz8EM90ubLXPeZFgyZc7QxSYPUg
         coHWEhkcWYnn5bVW/J+sssplESpqbJ8M9qWkL1ryI3Pws3jWfZV/yDx9hPtO7SOQK7
         rpeTVQ9bPyJ6A2nSMYI/7XkmUnyrNbbEVPtuPHQk6ghJNNDyV3YOEnzJ0RCtz2I1gJ
         RjY/bCgwe1y9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C54AA403B5; Fri, 28 Apr 2023 22:31:11 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:31:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, leo.yan@linaro.org,
        eranian@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Fix return incorrect build_id size in
 elf_read_build_id()
Message-ID: <ZExzXy5J+CAjOD81@kernel.org>
References: <20230427012841.231729-1-yangjihong1@huawei.com>
 <f149f4ce-bd2e-b192-920f-1e2599e5b16f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f149f4ce-bd2e-b192-920f-1e2599e5b16f@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 27, 2023 at 09:02:06AM +0300, Adrian Hunter escreveu:
> On 27/04/23 04:28, Yang Jihong wrote:
> > In elf_read_build_id(), if gnu build_id is found, should return the size of
> > the actually copied data. If descsz is greater thanBuild_ID_SIZE,
> > write_buildid data access may occur.
> > 
> > Fixes: be96ea8ffa78 ("perf symbols: Fix issue with binaries using 16-bytes buildids (v2)")
> > Reported-by: Will Ochowicz <Will.Ochowicz@genusplc.com>
> > Link: https://lore.kernel.org/lkml/CWLP265MB49702F7BA3D6D8F13E4B1A719C649@CWLP265MB4970.GBRP265.PROD.OUTLOOK.COM/T/
> > Tested-by: Will Ochowicz <Will.Ochowicz@genusplc.com>
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> As an aside, note that the build ID on the ELF file triggering the bug was
> 62363266373430613439613534633666326432323334653665623530396566343938656130663039
> which is 80 ASCII characters, which would have been a 20 byte binary number i.e.
> 
> $ echo -en "0000: 62363266373430613439613534633666\n0010: 32643232333465366562353039656634\n0020: 3938656130663039" | xxd -r | od -c -A d 
> 0000000   b   6   2   f   7   4   0   a   4   9   a   5   4   c   6   f
> 0000016   2   d   2   2   3   4   e   6   e   b   5   0   9   e   f   4
> 0000032   9   8   e   a   0   f   0   9
> 0000040
> 
> So perhaps a mistake in the creation of the build ID on that ELF file.
> 
> In any case, for the fix:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/util/symbol-elf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 41882ae8452e..059f88eca630 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -903,7 +903,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
> >  				size_t sz = min(size, descsz);
> >  				memcpy(bf, ptr, sz);
> >  				memset(bf + sz, 0, size - sz);
> > -				err = descsz;
> > +				err = sz;
> >  				break;
> >  			}
> >  		}
> 

-- 

- Arnaldo
