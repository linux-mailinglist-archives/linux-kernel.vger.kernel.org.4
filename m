Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6563796D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiKXMz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKXMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:55:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B521105AAE;
        Thu, 24 Nov 2022 04:55:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1442B827DB;
        Thu, 24 Nov 2022 12:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D973C433D6;
        Thu, 24 Nov 2022 12:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669294516;
        bh=xlfV1TNMGUSVn1obIYOe5CMVSNYkPspSlOooLiZNgOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzCMtXT24GlkN5uPeNTsY2hlept4nKLRHt6AvMxyv//tekOWQE5DX6K7OhxR9b1EC
         fZ0V8kGQYkLwfXRerzRl3RRTXn1ddgkFFyJT3aYKaehN703WnO6qB348jLmfA3+dXL
         7aAbgv2+kVPpMt9SZUiem4rTxLKlkoygx5gctQm5pkQhzQsOQC5Icw6KDZz1kfxUnZ
         b6KKVY1e4ayMhYKI/HNC1WnXa4PKEoc02AvFOuvhFnOW/PfLFj24+KfjPiJOU9+VrQ
         q2u18SZmGoQ07OjrATqe8CSn4UtyyLG4iofS/vJH08GkoDLGvYxivga7/Zd0g2hKmI
         ia/BS8MRkoUCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53C0E4034E; Thu, 24 Nov 2022 09:55:13 -0300 (-03)
Date:   Thu, 24 Nov 2022 09:55:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ajay Kaher <akaher@vmware.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, rostedt@goodmis.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        srivatsab@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH] perf symbol: correction while adjusting symbol
Message-ID: <Y39psTnUYxwWt1qo@kernel.org>
References: <1669198696-50547-1-git-send-email-akaher@vmware.com>
 <Y38+NGjF1tZNHkwr@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y38+NGjF1tZNHkwr@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 24, 2022 at 05:50:23PM +0800, Leo Yan escreveu:
> Hi Ajay,
> 
> On Wed, Nov 23, 2022 at 03:48:16PM +0530, Ajay Kaher wrote:
> > perf doesn't provide proper symbol information for specially crafted
> > .debug files.
> > 
> > Sometimes .debug file may not have similar program header as runtime
> > ELF file. For example if we generate .debug file using objcopy
> > --only-keep-debug resulting file will not contain .text, .data and
> > other runtime sections. That means corresponding program headers will
> > have zero FileSiz and modified Offset.
> > 
> > Example: program header of text section of libxxx.so:
> > 
> > Type           Offset             VirtAddr           PhysAddr
> >                FileSiz            MemSiz              Flags  Align
> > LOAD        0x00000000003d3000 0x00000000003d3000 0x00000000003d3000
> >             0x000000000055ae80 0x000000000055ae80  R E    0x1000
> > 
> > Same program header after executing:
> > objcopy --only-keep-debug libxxx.so libxxx.so.debug
> > 
> > LOAD        0x0000000000001000 0x00000000003d3000 0x00000000003d3000
> >             0x0000000000000000 0x000000000055ae80  R E    0x1000
> > 
> > Offset and FileSiz have been changed. 
> > 
> > Following formula will not provide correct value, if program header
> > taken from .debug file (syms_ss):
> > 
> >     sym.st_value -= phdr.p_vaddr - phdr.p_offset;
> > 
> > Correct program header information is located inside runtime ELF
> > file (runtime_ss).
> > 
> > Fixes: 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
> > Signed-off-by: Ajay Kaher <akaher@vmware.com>
> 
> 
> Just curious how you can produce this issue?  IIUC, the runtime symbol
> files are copied into .debug folder and they can be found by perf tool
> by matching build ID.  Seems to me, you manully use
> "objcopy --only-keep-debug" command to strip runtime info from elf files
> under .debug folder.  Do I understand correctly?
> 
> Though I have above question, this patch itself looks good to me,
> thanks for the fixing!
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Had to apply it manually, as it was done on a codebase older than this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d518ac7be6223811ab947897273b1bbef846180

author	Ian Rogers <irogers@google.com>	2022-07-31 09:49:23 -0700
committer	Arnaldo Carvalho de Melo <acme@redhat.com>	2022-08-01 09:30:36 -0300

@@ -1305,16 +1305,29 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,

 			if (elf_read_program_header(syms_ss->elf,
 						    (u64)sym.st_value, &phdr)) {
-				pr_warning("%s: failed to find program header for "
+				pr_debug4("%s: failed to find program header for "
 					   "symbol: %s st_value: %#" PRIx64 "\n",
 					   __func__, elf_name, (u64)sym.st_value);
