Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD016887A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBBTlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjBBTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:41:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074628001A;
        Thu,  2 Feb 2023 11:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8972D61CB4;
        Thu,  2 Feb 2023 19:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E290C433EF;
        Thu,  2 Feb 2023 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675366881;
        bh=CuJ4XgEPGhIEJdNgzo9MezbHnyWO3g4nrF5KyTF/TPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i14qfuoPtqQqWcNoYL04Ky5uSo5sq3iFFVvZTISt4arCiN0DNPkqGCe0ldC7Co4j5
         zQr1RLqFcSPKhOyuUtlRWB4c+IAaof0nyN2rh+V0SGLlHQP7a47H8IlqRHreuV7gIF
         cOWyzTbXITIvc4hcl8vTUDof004x//EkUUUV9yw1YYwNd3mdRyn0Xb3raOjJYylcc/
         ukedXMx7cYnMMWVaMWqKGcwI08rrGaadVMfCI8lVpsjYhmpe7N2tjUtisJIeQsHse/
         +VvidiDRDSGVmVTabflLDvOAJT4Y55TYk1h0jakzzQlKfFSBZ3wOadkS2Y9sHugpTH
         jRkfYLuiPEJWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01B73405BE; Thu,  2 Feb 2023 16:41:17 -0300 (-03)
Date:   Thu, 2 Feb 2023 16:41:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V2 8/9] perf symbols: Start adding support for .plt.got
 for x86
Message-ID: <Y9wR3T1AWUCwmJoA@kernel.org>
References: <20230131131625.6964-1-adrian.hunter@intel.com>
 <20230131131625.6964-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131131625.6964-9-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URI_NOVOWEL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 31, 2023 at 03:16:24PM +0200, Adrian Hunter escreveu:
> For x86, .plt.got is used, for example, when the address is taken of a
> dynamically linked function. Start adding support by synthesizing a
> symbol for each entry. A subsequent patch will attempt to get a better
> name for the symbol.
> 
> Example:
> 
>   Before:
> 
>     $ cat tstpltlib.c
>     void fn1(void) {}
>     void fn2(void) {}
>     void fn3(void) {}
>     void fn4(void) {}
>     $ cat tstpltgot.c
>     void fn1(void);
>     void fn2(void);
>     void fn3(void);
>     void fn4(void);
> 
>     void callfn(void (*fn)(void))
>     {
>             fn();
>     }
> 
>     int main()
>     {
>             fn4();
>             fn1();
>             callfn(fn3);
>             fn2();
>             fn3();
>             return 0;
>     }
>     $ gcc --version
>     gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
>     Copyright (C) 2021 Free Software Foundation, Inc.
>     This is free software; see the source for copying conditions.  There is NO
>     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>     $ gcc -Wall -Wextra -shared -o libtstpltlib.so tstpltlib.c
>     $ gcc -Wall -Wextra -o tstpltgot tstpltgot.c -L . -ltstpltlib -Wl,-rpath="$(pwd)"
>     $ readelf -SW tstpltgot | grep 'Name\|plt\|dyn'
>       [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>       [ 6] .dynsym           DYNSYM          00000000000003d8 0003d8 0000f0 18   A  7   1  8
>       [ 7] .dynstr           STRTAB          00000000000004c8 0004c8 0000c6 00   A  0   0  1
>       [10] .rela.dyn         RELA            00000000000005d8 0005d8 0000d8 18   A  6   0  8
>       [11] .rela.plt         RELA            00000000000006b0 0006b0 000048 18  AI  6  24  8
>       [13] .plt              PROGBITS        0000000000001020 001020 000040 10  AX  0   0 16
>       [14] .plt.got          PROGBITS        0000000000001060 001060 000020 10  AX  0   0 16
>       [15] .plt.sec          PROGBITS        0000000000001080 001080 000030 10  AX  0   0 16
>       [23] .dynamic          DYNAMIC         0000000000003d90 002d90 000210 10  WA  7   0  8
>     $ perf record -e intel_pt//u --filter 'filter main @ ./tstpltgot , filter callfn @ ./tstpltgot' ./tstpltgot
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.011 MB perf.data ]
>     $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
>     28393.810326915:   tr strt                               0 [unknown] =>     562350baa1b2 main+0x0
>     28393.810326915:   tr end  call               562350baa1ba main+0x8 =>     562350baa090 fn4@plt+0x0
>     28393.810326917:   tr strt                               0 [unknown] =>     562350baa1bf main+0xd
>     28393.810326917:   tr end  call               562350baa1bf main+0xd =>     562350baa080 fn1@plt+0x0
>     28393.810326917:   tr strt                               0 [unknown] =>     562350baa1c4 main+0x12
>     28393.810326917:   call                       562350baa1ce main+0x1c =>     562350baa199 callfn+0x0
>     28393.810326917:   tr end  call               562350baa1ad callfn+0x14 =>     7f607d36110f fn3+0x0
>     28393.810326922:   tr strt                               0 [unknown] =>     562350baa1af callfn+0x16
>     28393.810326922:   return                     562350baa1b1 callfn+0x18 =>     562350baa1d3 main+0x21
>     28393.810326922:   tr end  call               562350baa1d3 main+0x21 =>     562350baa0a0 fn2@plt+0x0
>     28393.810326924:   tr strt                               0 [unknown] =>     562350baa1d8 main+0x26
>     28393.810326924:   tr end  call               562350baa1d8 main+0x26 =>     562350baa060 [unknown]  <- call to fn3 via .plt.got
>     28393.810326925:   tr strt                               0 [unknown] =>     562350baa1dd main+0x2b
>     28393.810326925:   tr end  return             562350baa1e3 main+0x31 =>     7f607d029d90 __libc_start_call_main+0x80
> 
>   After:
> 
>     $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
>     28393.810326915:   tr strt                               0 [unknown] =>     562350baa1b2 main+0x0
>     28393.810326915:   tr end  call               562350baa1ba main+0x8 =>     562350baa090 fn4@plt+0x0
>     28393.810326917:   tr strt                               0 [unknown] =>     562350baa1bf main+0xd
>     28393.810326917:   tr end  call               562350baa1bf main+0xd =>     562350baa080 fn1@plt+0x0
>     28393.810326917:   tr strt                               0 [unknown] =>     562350baa1c4 main+0x12
>     28393.810326917:   call                       562350baa1ce main+0x1c =>     562350baa199 callfn+0x0
>     28393.810326917:   tr end  call               562350baa1ad callfn+0x14 =>     7f607d36110f fn3+0x0
>     28393.810326922:   tr strt                               0 [unknown] =>     562350baa1af callfn+0x16
>     28393.810326922:   return                     562350baa1b1 callfn+0x18 =>     562350baa1d3 main+0x21
>     28393.810326922:   tr end  call               562350baa1d3 main+0x21 =>     562350baa0a0 fn2@plt+0x0
>     28393.810326924:   tr strt                               0 [unknown] =>     562350baa1d8 main+0x26
>     28393.810326924:   tr end  call               562350baa1d8 main+0x26 =>     562350baa060 offset_0x1060@plt+0x0
>     28393.810326925:   tr strt                               0 [unknown] =>     562350baa1dd main+0x2b
>     28393.810326925:   tr end  return             562350baa1e3 main+0x31 =>     7f607d029d90 __libc_start_call_main+0x80
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/symbol-elf.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 9e265a726418..254116d40e59 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -466,6 +466,30 @@ static bool machine_is_x86(GElf_Half e_machine)
>  	return e_machine == EM_386 || e_machine == EM_X86_64;
>  }
>  
> +static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
> +					   GElf_Ehdr *ehdr,
> +					   char *buf, size_t buf_sz)
> +{
> +	struct symbol *sym;
> +	GElf_Shdr shdr;
> +	Elf_Scn *scn;
> +	size_t i;
> +
> +	scn = elf_section_by_name(elf, ehdr, &shdr, ".plt.got", NULL);
> +	if (!scn || !shdr.sh_entsize)
> +		return 0;
> +
> +	for (i = 0; i < shdr.sh_size; i += shdr.sh_entsize) {
> +		snprintf(buf, buf_sz, "offset_%#zx@plt", shdr.sh_offset + i);
> +		sym = symbol__new(shdr.sh_offset + i, shdr.sh_entsize, STB_GLOBAL, STT_FUNC, buf);

Had to apply the patch below with the following committer note:

Committer notes:

Fix build on 32-bit a arches where shdr.sh_offset is a uint32_t and on
64-bit whete it is uint64_t, so cast use PRIx64 and cast it to the
64-bit type, as done elsewhere in this same file.


diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b149cfea73d0f422..41882ae8452e5091 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -631,7 +631,7 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
 
 	for (i = 0; i < shdr.sh_size; i += shdr.sh_entsize) {
 		if (!get_plt_got_name(&shdr, i, &di, buf, buf_sz))
-			snprintf(buf, buf_sz, "offset_%#zx@plt", shdr.sh_offset + i);
+			snprintf(buf, buf_sz, "offset_%#" PRIx64 "@plt", (u64)shdr.sh_offset + i);
 		sym = symbol__new(shdr.sh_offset + i, shdr.sh_entsize, STB_GLOBAL, STT_FUNC, buf);
 		if (!sym)
 			goto out;

> +		if (!sym)
> +			return -1;
> +		symbols__insert(&dso->symbols, sym);
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * We need to check if we have a .dynsym, so that we can handle the
>   * .plt, synthesizing its symbols, that aren't on the symtabs (be it
> @@ -514,6 +538,11 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
>  		goto out_elf_end;
>  	symbols__insert(&dso->symbols, plt_sym);
>  
> +	/* Only x86 has .plt.got */
> +	if (machine_is_x86(ehdr.e_machine) &&
> +	    dso__synthesize_plt_got_symbols(dso, elf, &ehdr, sympltname, sizeof(sympltname)))
> +		goto out_elf_end;
> +
>  	/* Only x86 has .plt.sec */
>  	if (machine_is_x86(ehdr.e_machine) &&
>  	    elf_section_by_name(elf, &ehdr, &plt_sec_shdr, ".plt.sec", NULL)) {
> -- 
> 2.34.1
> 

-- 

- Arnaldo
