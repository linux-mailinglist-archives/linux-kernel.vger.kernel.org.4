Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6770EE85
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbjEXGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbjEXGvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:51:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196C19D;
        Tue, 23 May 2023 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q9xln5Of0XYQlLaDuuwF580BoakPCRgS4xq/GOlA84E=; b=c3o4BciiL+/xQbd/mLsJmyHAPP
        mtv4SAVwob4fiAagaJ1jcMNkIxGuuQpjzAbOfv2ZDFz3uiKjnTjE8erv21tuqPaq76W3Min3PJi2E
        SsOQwQ4i9DAqXYu/7xa10RVCI+xsBcnhMeVyzXnV0wU+F3yePpkIdbLk2DiPyF1GASrMNJtRygWmy
        GBWWqKj9Y+/wphkr0zshh+OB7gb45MN3aqvdZT+orgj9++XYFfPGVZ12Dlb09SQFF7ZOZ6HFuN+4d
        I/icmXrOS25ZuWZ8j2mVOxjvB1BCAtlSkhf6p5/0WmTJ3v6hkuP/fK/f8niS+ZS2x/vC9q9q66l4A
        PEjwxbjw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iKW-00CX98-2n;
        Wed, 24 May 2023 06:50:40 +0000
Date:   Tue, 23 May 2023 23:50:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com
Subject: Re: [PATCH v10 05/11] modpost: Track module name for built-in modules
Message-ID: <ZG2zwMTdJryhGrbU@bombadil.infradead.org>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-6-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-6-allenwebb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:00:24PM -0500, Allen Webb wrote:
> Keep track of the module name when processing match table symbols.

This should mention why this would be good. Otherwise, think about it,
ok, it's done but why? If the reason is that it will be needed later
you need to say that in this commit log entry. If its not used now, it
also needs to say that in this commit log so it is easier to review
and set expecataions correctly for the reviewer.

  Luis

> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  scripts/mod/file2alias.c | 39 +++++++++++++++++++++++++++++++++++----
>  scripts/mod/modpost.h    |  1 +
>  2 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 91c2e7ba5e52..b392d51c3b06 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -28,6 +28,7 @@ typedef Elf64_Addr	kernel_ulong_t;
>  #include <stdint.h>
>  #endif
>  
> +#include <assert.h>
>  #include <ctype.h>
>  #include <stdbool.h>
>  
> @@ -1540,9 +1541,9 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>  			Elf_Sym *sym, const char *symname)
>  {
>  	void *symval;
> -	char *zeros = NULL;
> -	const char *name, *identifier;
> -	unsigned int namelen;
> +	char *zeros = NULL, *modname_str = NULL;
> +	const char *name, *identifier, *modname;
> +	unsigned int namelen, modnamelen;
>  
>  	/* We're looking for a section relative symbol */
>  	if (!sym->st_shndx || get_secindex(info, sym) >= info->num_sections)
> @@ -1552,7 +1553,12 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>  	if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
>  		return;
>  
> -	/* All our symbols are of form __mod_<name>__<identifier>_device_table. */
> +	/*
> +	 * All our symbols are either of form
> +	 *   __mod_<name>__<identifier>_device_table
> +	 * or
> +	 *   __mod_<name>__<identifier>__kmod_<builtin-name>_device_table
> +	 */
>  	if (strncmp(symname, "__mod_", strlen("__mod_")))
>  		return;
>  	name = symname + strlen("__mod_");
> @@ -1564,8 +1570,30 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>  	identifier = strstr(name, "__");
>  	if (!identifier)
>  		return;
> +	modnamelen = namelen;
>  	namelen = identifier - name;
>  
> +	/*
> +	 * In the vmlinuz.o case we want to handle __kmod_ so aliases from
> +	 * builtin modules are attributed correctly.
> +	 */
> +	modname = strstr(identifier + 2, "__kmod_");
> +	if (modname) {
> +		modname += strlen("__kmod_");
> +		modnamelen -= (modname - name) + strlen("_device_table");
> +		modname_str = malloc(modnamelen + 1);
> +		/* We don't want to continue if the allocation fails. */
> +		assert(modname_str);
> +		memcpy(modname_str, modname, modnamelen);
> +		modname_str[modnamelen] = '\0';
> +	}
> +
> +	if (modname_str)
> +		modname = modname_str;
> +	else
> +		modname = mod->name;
> +	mod->builtin_name = modname;
> +
>  	/* Handle all-NULL symbols allocated into .bss */
>  	if (info->sechdrs[get_secindex(info, sym)].sh_type & SHT_NOBITS) {
>  		zeros = calloc(1, sym->st_size);
> @@ -1597,6 +1625,9 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>  		}
>  	}
>  	free(zeros);
> +	mod->builtin_name = NULL;
> +	if (modname_str)
> +		free(modname_str);
>  }
>  
>  /* Now add out buffered information to the generated C source */
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 1178f40a73f3..34fe5fc0b02c 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -128,6 +128,7 @@ struct module {
>  	struct list_head missing_namespaces;
>  	// Actual imported namespaces
>  	struct list_head imported_namespaces;
> +	const char *builtin_name;
>  	char name[];
>  };
>  
> -- 
> 2.39.2
> 
