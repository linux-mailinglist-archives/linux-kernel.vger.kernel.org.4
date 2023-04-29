Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3B6F21FE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347229AbjD2BXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjD2BX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:23:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3442703;
        Fri, 28 Apr 2023 18:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F21EE63E31;
        Sat, 29 Apr 2023 01:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1FEC433D2;
        Sat, 29 Apr 2023 01:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682731406;
        bh=Om0U2/psqyq2TUDOWeE8s8ppWFJLGmuqmhLL4lH2eq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xvcddoc3kY9XhvmWbp6sikEkfs0g4xuJFLFVgp8ih3nmnIvXSBVUgsCBE9hEOtKR1
         BCCMi1w4d8aGJ1N+H+PQq1RYIO25NMTU+bR30VuRkKDAwuAJLXfqPIgkjyiQJiB0fN
         fWqn6kefmMKMxgvzVQNp+ccoIaC8Ldtw0gBJggAIC/G12u9Q99sqE4EDHtEX8LaTIf
         FU9JI/rgwUO50YHFD+V/eJQ6YKvbwTYvuz8/zlw04a8YnCyeEpG4SFKCJ0xux2fROe
         +HprTHs0IxpgGTeeFtpwe5hUJ7hSUL5+1VCsvBPWMyRdhO+e/K6tbvLeXPjnCc72V2
         V+CBO+cwlebKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02A12403B5; Fri, 28 Apr 2023 22:23:23 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:23:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     p4ranlee@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, acme@redhat.com, anton@ozlabs.org,
        dja@axtens.net, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] perf tools riscv: Add support for riscv
 lookup_binutils_path
Message-ID: <ZExxi7KAW7W/OSwa@kernel.org>
References: <20230315051500.13064-1-p4ranlee@gmail.com>
 <mhng-534349ae-0594-455c-bc27-da0d8a70d0be@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-534349ae-0594-455c-bc27-da0d8a70d0be@palmer-ri-x1c9>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 18, 2023 at 08:41:21PM -0700, Palmer Dabbelt escreveu:
> On Tue, 14 Mar 2023 22:15:01 PDT (-0700), p4ranlee@gmail.com wrote:
> > Add RISC-V binutils path on lookup triplets.
> > 
> > Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> > ---
> >  tools/perf/arch/common.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> > index 59dd875fd5e4..e80d4d22cabf 100644
> > --- a/tools/perf/arch/common.c
> > +++ b/tools/perf/arch/common.c
> > @@ -43,6 +43,20 @@ const char *const powerpc_triplets[] = {
> >  	NULL
> >  };
> > 
> > +const char *const riscv32_triplets[] = {
> > +	"riscv32-unknown-linux-gnu-",
> > +	"riscv32-linux-android-",
> > +	"riscv32-linux-gnu-",
> > +	NULL
> > +};
> > +
> > +const char *const riscv64_triplets[] = {
> > +	"riscv64-unknown-linux-gnu-",
> > +	"riscv64-linux-android-",
> > +	"riscv64-linux-gnu-",
> > +	NULL
> > +};
> > +
> >  const char *const s390_triplets[] = {
> >  	"s390-ibm-linux-",
> >  	"s390x-linux-gnu-",
> > @@ -166,6 +180,10 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
> >  		path_list = arm64_triplets;
> >  	else if (!strcmp(arch, "powerpc"))
> >  		path_list = powerpc_triplets;
> > +	else if (!strcmp(arch, "riscv32"))
> > +		path_list = riscv32_triplets;
> > +	else if (!strcmp(arch, "riscv64"))
> > +		path_list = riscv64_triplets;
> >  	else if (!strcmp(arch, "sh"))
> >  		path_list = sh_triplets;
> >  	else if (!strcmp(arch, "s390"))
> 
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks, applied.

- Arnaldo

