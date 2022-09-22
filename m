Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690185E6B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiIVTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84133106A29;
        Thu, 22 Sep 2022 12:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE9160ED1;
        Thu, 22 Sep 2022 19:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589B6C433D6;
        Thu, 22 Sep 2022 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663874344;
        bh=fH/ftMSCMde/tGgysJ6GXrjfJcRK3hwxp51NNNMYSFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpInakzF/YtLR0GbsbO3sqUR/uaQGEOaH+QUKjCFD90cCiAoPClfFis7jvQ6Iq9V9
         woDePn4JOZoLS9INmwPdG7h13IZNDGzJb8Kb5ZqSrn7ZpoyI7zw4XYk2gaPAr4iq9f
         aWwP2c/elk1FeYiiKcsKG/QHmkknN3Cle7cpBrrCGNWEoP55aQAfFtIBFRlHHdSys5
         9ORBGvqGGh560Grx4MyYKxPBsS7mj/mOjDhO27d0AljgDH0mdXHQwr9V49JaUV36Dh
         B6Gc2Bn2b+1kgE0Iqfte0cikEZ6TdtwzePpimxEORHsHxmnPJ/U2vlICBeAkxP4Rvx
         ecUjR6FvTZH1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2EBA2403B0; Thu, 22 Sep 2022 20:19:02 +0100 (IST)
Date:   Thu, 22 Sep 2022 20:19:02 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        adrian.hunter@intel.com, davemarchevsky@fb.com, wcohen@redhat.com,
        andres@anarazel.de, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] perf annotate: use strscpy() is more robust
 and safer
Message-ID: <Yyy1JgWCuQTMKFkY@kernel.org>
References: <20220922012431.232372-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922012431.232372-1-ye.xingchen@zte.com.cn>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 22, 2022 at 01:24:31AM +0000, cgel.zte@gmail.com escreveu:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.

Where is strscpy() defined?

I see it defined in the kernel:

⬢[acme@toolbox perf]$ grep -w strscpy include/linux/string.h
ssize_t strscpy(char *, const char *, size_t);
/* Wraps calls to strscpy()/memset(), no arch specific code required */
⬢[acme@toolbox perf]$

But not in tools/

Have you actually build with these patches?

- Arnaldo
 
> That's now the recommended way to copy NUL terminated strings.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  tools/perf/util/annotate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 5bc63c9e0324..e2b038b14ff6 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1702,7 +1702,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  			char *new_name = filename_with_chroot(dso->nsinfo->pid,
>  							      filename);
>  			if (new_name) {
> -				strlcpy(filename, new_name, filename_size);
> +				strscpy(filename, new_name, filename_size);
>  				free(new_name);
>  			}
>  		}
> @@ -2002,7 +2002,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		kce.len = sym->end - sym->start;
>  		if (!kcore_extract__create(&kce)) {
>  			delete_extract = true;
> -			strlcpy(symfs_filename, kce.extract_filename,
> +			strscpy(symfs_filename, kce.extract_filename,
>  				sizeof(symfs_filename));
>  		}
>  	} else if (dso__needs_decompress(dso)) {
> -- 
> 2.25.1

-- 

- Arnaldo
