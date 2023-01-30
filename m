Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18721681F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjA3X0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjA3X0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:26:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509BAD04;
        Mon, 30 Jan 2023 15:26:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id k13so13373006plg.0;
        Mon, 30 Jan 2023 15:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFbKyH27aw6PAgsNUS0/uuOzdux7vghVnk8ZZpbogbU=;
        b=H3NsFKgZcD0ceYwhquUp0fKOOyCU2XmD0LjwySePEszNE5f8BjHscRam0yRCDI+ee4
         qyIya/Jxc2AdlLCr5RBv2QZ9iiP2G/hfJYlXOdl6v/AtsmRPEVc5ZETpMhpHXVdU6K21
         2OPvJpnYZ34FL1Z/ULE10fy4/I27NbRXNIRbFcTCwBuzhIDyamX9UTrqs4iINB0DUfTu
         +jGB4r5Gm49LyfUV6hWpxVkFJjI5CgPGPANH7Bu443GKGZFsSVXX9Va6Ig0sAnNyB35A
         SX23D51Sd41FzvLFghZqAZs/AIG6Bies0MLqd8NQqoq3eTyI3NYhjTb0Db5s9aWTVjpF
         Un9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFbKyH27aw6PAgsNUS0/uuOzdux7vghVnk8ZZpbogbU=;
        b=kfGYOukdwJNqTUXrPOFd805YZCJRtyNvbl55SKntzzMn8UQ/AKYMWqapRppGFSZ092
         7XXtdJTnWEdfqWiTZdVM4MnVFsCC53lRzKYrvI/rx2urZO9LPMTmCDQGUbB1phzfpdFY
         RKWZNwOS7vPsg+OwuwARVzhAN9wfuOhvXHXFdLV3wEtttdcjYtUU06swXh9KwlitqmZf
         5EziwqNO71aBAhUsjrSShO1P8f++9D6yC94KhnWyim3iVWFVJ1uJOhGIwaooMl6glp0G
         mwr90vsr8qPeHI6KNjXUW7g1h642xyuRVjPyEKihAlj8Q30KNHMVRMJeyzxeT8KRfJJP
         y54g==
X-Gm-Message-State: AFqh2kod30ph6kp+T7oUMd+vRH2+ClBXSP5q6gI4IqM+eK1TalCeSW6g
        YfTelpD7ZYhhWEOje8yWl4dSDAkMTcI=
X-Google-Smtp-Source: AMrXdXsI0tc6X0NaVf4E/HspNrSwkMWTwaOH0bXHZ7074m6SRjgkr+Il3wxGTbaQoOEAt+0Athl5iQ==
X-Received: by 2002:a17:90a:4401:b0:229:2427:532f with SMTP id s1-20020a17090a440100b002292427532fmr53282150pjg.40.1675121164098;
        Mon, 30 Jan 2023 15:26:04 -0800 (PST)
Received: from google.com ([2601:647:6780:ff0:6062:cce2:7a14:2728])
        by smtp.gmail.com with ESMTPSA id z2-20020a633302000000b004df23936d6dsm6728151pgz.81.2023.01.30.15.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:26:03 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Mon, 30 Jan 2023 15:26:01 -0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 9/9] perf symbols: Get symbols for .plt.got for x86-64
Message-ID: <Y9hSCR6WvpI4b5Cm@google.com>
References: <20230127170222.9895-1-adrian.hunter@intel.com>
 <20230127170222.9895-10-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127170222.9895-10-adrian.hunter@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 07:02:22PM +0200, Adrian Hunter wrote:
> For x86_64, determine a symbol for .plt.got entries. That requires
> computing the target offset and finding that in .rela.dyn, which in
> turn means .rela.dyn needs to be sorted by offset.
> 
> Example:
> 
>   In this example, the GNU C Library is using .plt.got for malloc and
>   free.
> 
>   Before:
> 
>     $ gcc --version
>     gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
>     Copyright (C) 2021 Free Software Foundation, Inc.
>     This is free software; see the source for copying conditions.  There is NO
>     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>     $ perf record -e intel_pt//u uname
>     Linux
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.027 MB perf.data ]
>     $ perf script --itrace=be --ns -F-event,+addr,-period,-comm,-tid,-cpu > /tmp/cmp1.txt
> 
>   After:
> 
>     $ perf script --itrace=be --ns -F-event,+addr,-period,-comm,-tid,-cpu > /tmp/cmp2.txt
>     $ diff /tmp/cmp1.txt /tmp/cmp2.txt | head -12
>     15509,15510c15509,15510
>     < 27046.755390907:      7f0b2943e3ab _nl_normalize_codeset+0x5b (/usr/lib/x86_64-linux-gnu/libc.so.6) =>     7f0b29428380 offset_0x28380@plt+0x0 (/usr/lib/x86_64-linux-gnu/libc.so.6)
>     < 27046.755390907:      7f0b29428384 offset_0x28380@plt+0x4 (/usr/lib/x86_64-linux-gnu/libc.so.6) =>     7f0b294a5120 malloc+0x0 (/usr/lib/x86_64-linux-gnu/libc.so.6)
>     ---
>     > 27046.755390907:      7f0b2943e3ab _nl_normalize_codeset+0x5b (/usr/lib/x86_64-linux-gnu/libc.so.6) =>     7f0b29428380 malloc@plt+0x0 (/usr/lib/x86_64-linux-gnu/libc.so.6)
>     > 27046.755390907:      7f0b29428384 malloc@plt+0x4 (/usr/lib/x86_64-linux-gnu/libc.so.6) =>     7f0b294a5120 malloc+0x0 (/usr/lib/x86_64-linux-gnu/libc.so.6)
>     15821,15822c15821,15822
>     < 27046.755394865:      7f0b2943850c _nl_load_locale_from_archive+0x5bc (/usr/lib/x86_64-linux-gnu/libc.so.6) =>     7f0b29428370 offset_0x28370@plt+0x0 (/usr/lib/x86_64-linux-gnu/libc.so.6)
>     < 27046.755394865:      7f0b29428374 offset_0x28370@plt+0x4 (/usr/lib/x86_64-linux-gnu/libc.so.6) =>     7f0b294a5460 cfree@GLIBC_2.2.5+0x0 (/usr/lib/x86_64-linux-gnu/libc.so.6)
>     ---
>     > 27046.755394865:      7f0b2943850c _nl_load_locale_from_archive+0x5bc (/usr/lib/x86_64-linux-gnu/libc.so.6) =>     7f0b29428370 free@plt+0x0 (/usr/lib/x86_64-linux-gnu/libc.so.6)
>     > 27046.755394865:      7f0b29428374 free@plt+0x4 (/usr/lib/x86_64-linux-gnu/libc.so.6) =>     7f0b294a5460 cfree@GLIBC_2.2.5+0x0 (/usr/lib/x86_64-linux-gnu/libc.so.6)
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/symbol-elf.c | 158 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 254116d40e59..4fc8e7fc10f4 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -466,28 +466,178 @@ static bool machine_is_x86(GElf_Half e_machine)
>  	return e_machine == EM_386 || e_machine == EM_X86_64;
>  }
>  
> +struct rela_dyn {
> +	GElf_Addr	offset;
> +	u32		sym_idx;
> +};
> +
> +struct rela_dyn_info {
> +	struct dso	*dso;
> +	Elf_Data	*plt_got_data;
> +	u32		nr_entries;
> +	struct rela_dyn	*sorted;
> +	Elf_Data	*dynsym_data;
> +	Elf_Data	*dynstr_data;
> +	Elf_Data	*rela_dyn_data;
> +};
> +
> +static void exit_rela_dyn(struct rela_dyn_info *di)
> +{
> +	free(di->sorted);
> +}
> +
> +static int cmp_offset(const void *a, const void *b)
> +{
> +	const struct rela_dyn *va = a;
> +	const struct rela_dyn *vb = b;
> +
> +	return va->offset < vb->offset ? -1 : (va->offset > vb->offset ? 1 : 0);
> +}
> +
> +static int sort_rela_dyn(struct rela_dyn_info *di)
> +{
> +	u32 i, n;
> +
> +	di->sorted = calloc(di->nr_entries, sizeof(di->sorted[0]));
> +	if (!di->sorted)
> +		return -1;
> +
> +	/* Get data for sorting: the offset and symbol index */
> +	for (i = 0, n = 0; i < di->nr_entries; i++) {
> +		GElf_Rela rela;
> +		u32 sym_idx;
> +
> +		gelf_getrela(di->rela_dyn_data, i, &rela);
> +		sym_idx = GELF_R_SYM(rela.r_info);
> +		if (sym_idx) {
> +			di->sorted[n].sym_idx = sym_idx;
> +			di->sorted[n].offset = rela.r_offset;
> +			n += 1;
> +		}
> +	}
> +
> +	/* Sort by offset */
> +	di->nr_entries = n;
> +	qsort(di->sorted, n, sizeof(di->sorted[0]), cmp_offset);
> +
> +	return 0;
> +}
> +
> +static void get_rela_dyn_info(Elf *elf, GElf_Ehdr *ehdr, struct rela_dyn_info *di, Elf_Scn *scn)
> +{
> +	GElf_Shdr rela_dyn_shdr;
> +	GElf_Shdr shdr;
> +
> +	di->plt_got_data = elf_getdata(scn, NULL);
> +
> +	scn = elf_section_by_name(elf, ehdr, &rela_dyn_shdr, ".rela.dyn", NULL);
> +	if (!scn || !rela_dyn_shdr.sh_link || !rela_dyn_shdr.sh_entsize)
> +		return;
> +
> +	di->nr_entries = rela_dyn_shdr.sh_size / rela_dyn_shdr.sh_entsize;
> +	di->rela_dyn_data = elf_getdata(scn, NULL);
> +
> +	scn = elf_getscn(elf, rela_dyn_shdr.sh_link);
> +	if (!scn || !gelf_getshdr(scn, &shdr) || !shdr.sh_link)
> +		return;
> +
> +	di->dynsym_data = elf_getdata(scn, NULL);
> +	di->dynstr_data = elf_getdata(elf_getscn(elf, shdr.sh_link), NULL);
> +
> +	if (!di->plt_got_data || !di->dynstr_data || !di->dynsym_data || !di->rela_dyn_data)
> +		return;
> +
> +	/* Sort into offset order */
> +	sort_rela_dyn(di);
> +}
> +
> +/* Get instruction displacement from a plt entry for x86_64 */
> +static u32 get_x86_64_plt_disp(const u8 *p)
> +{
> +	u8 endbr64[] = {0xf3, 0x0f, 0x1e, 0xfa};
> +	int n = 0;
> +
> +	/* Skip endbr64 */
> +	if (!memcmp(p, endbr64, sizeof(endbr64)))
> +		n += sizeof(endbr64);
> +	/* Skip bnd prefix */
> +	if (p[n] == 0xf2)
> +		n += 1;
> +	/* jmp with 4-byte displacement */
> +	if (p[n] == 0xff && p[n + 1] == 0x25) {
> +		n += 2;
> +		/* Also add offset from start of entry to end of instruction */
> +		return n + 4 + le32toh(*(const u32 *)(p + n));
> +	}
> +	return 0;
> +}
> +
> +static bool get_plt_got_name(GElf_Shdr *shdr, size_t i,
> +			     struct rela_dyn_info *di,
> +			     char *buf, size_t buf_sz)
> +{
> +	void *p = di->plt_got_data->d_buf + i;
> +	u32 disp = get_x86_64_plt_disp(p);
> +	struct rela_dyn vi, *vr;
> +	const char *sym_name;
> +	char *demangled;
> +	GElf_Sym sym;
> +
> +	if (!di->sorted || !disp)
> +		return false;
> +
> +	/* Compute target offset of the .plt.got entry */
> +	vi.offset = shdr->sh_offset + di->plt_got_data->d_off + i + disp;
> +
> +	/* Find that offset in .rela.dyn (sorted by offset) */
> +	vr = bsearch(&vi, di->sorted, di->nr_entries, sizeof(di->sorted[0]), cmp_offset);
> +	if (!vr)
> +		return false;
> +
> +	/* Get the associated symbol */
> +	gelf_getsym(di->dynsym_data, vr->sym_idx, &sym);
> +	sym_name = elf_sym__name(&sym, di->dynstr_data);
> +	demangled = demangle_sym(di->dso, 0, sym_name);
> +	if (demangled != NULL)
> +		sym_name = demangled;
> +
> +	snprintf(buf, buf_sz, "%s@plt", sym_name);
> +
> +	free(demangled);
> +
> +	return *sym_name;
> +}
> +
>  static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>  					   GElf_Ehdr *ehdr,
>  					   char *buf, size_t buf_sz)
>  {
> +	struct rela_dyn_info di = { .dso = dso };
>  	struct symbol *sym;
>  	GElf_Shdr shdr;
>  	Elf_Scn *scn;
> +	int err = -1;
>  	size_t i;
>  
>  	scn = elf_section_by_name(elf, ehdr, &shdr, ".plt.got", NULL);
>  	if (!scn || !shdr.sh_entsize)
>  		return 0;
>  
> +	if (ehdr->e_machine == EM_X86_64)
> +		get_rela_dyn_info(elf, ehdr, &di, scn);

What about EM_386?  Now I'm seeing segfaults on 32 bit test programs
with .plt.got section.

Thanks,
Namhyung


> +
>  	for (i = 0; i < shdr.sh_size; i += shdr.sh_entsize) {
> -		snprintf(buf, buf_sz, "offset_%#zx@plt", shdr.sh_offset + i);
> +		if (!get_plt_got_name(&shdr, i, &di, buf, buf_sz))
> +			snprintf(buf, buf_sz, "offset_%#zx@plt", shdr.sh_offset + i);
>  		sym = symbol__new(shdr.sh_offset + i, shdr.sh_entsize, STB_GLOBAL, STT_FUNC, buf);
>  		if (!sym)
> -			return -1;
> +			goto out;
>  		symbols__insert(&dso->symbols, sym);
>  	}
> -
> -	return 0;
> +	err = 0;
> +out:
> +	exit_rela_dyn(&di);
> +	return err;
>  }
>  
>  /*
> -- 
> 2.34.1
> 
> 
