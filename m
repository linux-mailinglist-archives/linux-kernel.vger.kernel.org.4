Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79D570EEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbjEXHAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbjEXHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:00:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE4A3;
        Wed, 24 May 2023 00:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LDkj7fx8OszlJ4sR4sf3mfb9f8SxFIoxaxQFs3Jt+lk=; b=5BDnLy4teHwSY8P0YNy3zQo9T/
        3zfIDQ51x/X8IlNA1Mcm9FwXMXWb3Y2XVySOPVh8+9/PQ7lPY1C+X1SjwTpAsupIZ9Jks87ZFu2aP
        53aehgDvcHK+bObLO0eeaJd2bmWmbxEOdUStLx0/JKmO3nhQ1dY5yes4jjQ0U72TWVHjRmEwQMoVf
        V+YVYV36umotfRSFeC2HYo3zAmqCmi6UK7tTfz0J9nRV+eZPgBg916BMTHFZMULhQFCo3l9mhp26s
        L/tA6xGsqGvTS8gurEs4ya5Xegq8V77lW58bOt1/vT1q239O3cnJeZjfZUmU1QbGEtaX0pyHYG0vn
        8fgfKdig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iTb-00CYJS-2R;
        Wed, 24 May 2023 07:00:03 +0000
Date:   Wed, 24 May 2023 00:00:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com
Subject: Re: [PATCH v10 07/11] file2alias.c: Implement builtin.alias
 generation
Message-ID: <ZG2184mfMX9BCZiO@bombadil.infradead.org>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-8-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-8-allenwebb@google.com>
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

On Thu, Apr 06, 2023 at 02:00:26PM -0500, Allen Webb wrote:
> This populates the mod->modalias_buf with aliases for built-in modules
> when modpost is run against vmlinuz.o.

The commit log should describe why. And if its not used now why is it
being introduced separately. If its to make changes eaiser to read it
shoudl say so.

So builtin thing is set but is it used at this point? Does this patch
make any functional changes? If not why not?

> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  scripts/mod/file2alias.c | 61 ++++++++++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index b392d51c3b06..3793d4632b94 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -233,6 +233,8 @@ static void do_usb_entry(void *symval,
>  	add_wildcard(alias);
>  	buf_printf(&mod->dev_table_buf,
>  		   "MODULE_ALIAS(\"%s\");\n", alias);
> +	if (mod->builtin_name)
> +		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
>  }
>  
>  /* Handles increment/decrement of BCD formatted integers */
> @@ -377,9 +379,13 @@ static void do_of_entry_multi(void *symval, struct module *mod)
>  			*tmp = '_';
>  
>  	buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
> +	if (mod->builtin_name)
> +		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
>  	strcat(alias, "C");
>  	add_wildcard(alias);
>  	buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
> +	if (mod->builtin_name)
> +		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
>  }
>  
>  static void do_of_table(void *symval, unsigned long size,
> @@ -611,12 +617,18 @@ static void do_pnp_device_entry(void *symval, unsigned long size,
>  
>  		buf_printf(&mod->dev_table_buf,
>  			   "MODULE_ALIAS(\"pnp:d%s*\");\n", *id);
> +		if (mod->builtin_name)
> +			buf_printf(&mod->modalias_buf, "alias pnp:d%s* %s\n",
> +				   *id, mod->builtin_name);
>  
>  		/* fix broken pnp bus lowercasing */
>  		for (j = 0; j < sizeof(acpi_id); j++)
>  			acpi_id[j] = toupper((*id)[j]);
>  		buf_printf(&mod->dev_table_buf,
>  			   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
> +		if (mod->builtin_name)
> +			buf_printf(&mod->modalias_buf, "alias acpi*:%s:* %s\n",
> +				   acpi_id, mod->builtin_name);
>  	}
>  }
>  
> @@ -638,6 +650,8 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
>  			const char *id = (char *)(*devs)[j].id;
>  			int i2, j2;
>  			int dup = 0;
> +			char acpi_id[PNP_ID_LEN];
> +			int k;
>  
>  			if (!id[0])
>  				break;
> @@ -663,19 +677,23 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
>  			}
>  
>  			/* add an individual alias for every device entry */
> -			if (!dup) {
> -				char acpi_id[PNP_ID_LEN];
> -				int k;
> -
> -				buf_printf(&mod->dev_table_buf,
> -					   "MODULE_ALIAS(\"pnp:d%s*\");\n", id);
> -
> -				/* fix broken pnp bus lowercasing */
> -				for (k = 0; k < sizeof(acpi_id); k++)
> -					acpi_id[k] = toupper(id[k]);
> -				buf_printf(&mod->dev_table_buf,
> -					   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
> -			}
> +			if (dup)
> +				continue;

The change from !dup to (dup) continue makes your changes harder to
read. It would be good to make that change separately so to make it
easier to read what you are doing differently.

> +
> +			buf_printf(&mod->dev_table_buf,
> +				   "MODULE_ALIAS(\"pnp:d%s*\");\n", id);
> +			if (mod->builtin_name)
> +				buf_printf(&mod->modalias_buf, "alias pnp:d%s* %s\n",
> +					   id, mod->builtin_name);
> +
> +			/* fix broken pnp bus lowercasing */
> +			for (k = 0; k < sizeof(acpi_id); k++)
> +				acpi_id[k] = toupper(id[k]);
> +			buf_printf(&mod->dev_table_buf,
> +				   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
> +			if (mod->builtin_name)
> +				buf_printf(&mod->modalias_buf, "alias acpi*:%s:* %s\n",
> +					   acpi_id, mod->builtin_name);
>  		}
>  	}
>  }
> @@ -1476,10 +1494,13 @@ static void do_table(void *symval, unsigned long size,
>  	size -= id_size;
>  
>  	for (i = 0; i < size; i += id_size) {
> -		if (do_entry(mod->name, symval+i, alias)) {
> -			buf_printf(&mod->dev_table_buf,
> -				   "MODULE_ALIAS(\"%s\");\n", alias);
> -		}
> +		if (!do_entry(mod->name, symval + i, alias))
> +			continue;

Same here. You could just fold the changes which negate the check into
and shif the code into one patch with 0 functional changes. Then a
second patch with your changes.

> +		buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
> +		if (!mod->builtin_name)
> +			continue;
> +		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias,
> +			   mod->builtin_name);
>  	}
>  }
>  
> @@ -1554,10 +1575,8 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>  		return;
>  
>  	/*
> -	 * All our symbols are either of form
> -	 *   __mod_<name>__<identifier>_device_table
> -	 * or
> -	 *   __mod_<name>__<identifier>__kmod_<builtin-name>_device_table
> +	 * All our symbols are of form
> +	 *   __mod_<name>__<identifier>__kmod_<modname>_device_table
>  	 */
>  	if (strncmp(symname, "__mod_", strlen("__mod_")))
>  		return;
> -- 
> 2.39.2
> 
