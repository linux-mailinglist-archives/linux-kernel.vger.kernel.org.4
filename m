Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FDD723AE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbjFFIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbjFFIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:01:32 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FFC10D5;
        Tue,  6 Jun 2023 00:59:36 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue,  6 Jun 2023 09:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1686038373; bh=ugFgVXtXAHiyh53jfuuwLqhaTiumhr8PnP3WR0m8Ydg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fU6gnxqAXu8V0ZdcfFCWSKfhKI3tw2aXM+3AIIqRHv2CsWKAg4TDU/nsm+qtcninI
         OizVUEytaccvX5nItXg32lLCDmoHmL/rrHouyhs/w2B8Z20u3TWvs1aicF5LtZBRrK
         SVSulOc3oXVJkGtuIlCcLu9+G4GxPbXur1cBAB1k=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id B222A822F1;
        Tue,  6 Jun 2023 09:59:34 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id A3595180F3E; Tue,  6 Jun 2023 09:59:34 +0200 (CEST)
Date:   Tue, 6 Jun 2023 09:59:34 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] scripts/kallsyms: remove KSYM_NAME_LEN_BUFFER
Message-ID: <ZH7nZpukq8lstUIh@buildd.core.avm.de>
References: <20230605122604.1826856-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605122604.1826856-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1686038373-2DFD1D8E-DBA36048/0/0
X-purgate-type: clean
X-purgate-size: 3986
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:26:04PM +0900, Masahiro Yamada wrote:
> You do not need to decide the buffer size statically.
> 
> Use getline() to grow the line buffer as needed.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/kallsyms.c | 61 ++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 0d2db41177b2..fc9709839b19 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -19,6 +19,7 @@
>   *
>   */
>  
> +#include <errno.h>
>  #include <getopt.h>
>  #include <stdbool.h>
>  #include <stdio.h>
> @@ -29,24 +30,8 @@
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
>  
> -#define _stringify_1(x)	#x
> -#define _stringify(x)	_stringify_1(x)
> -
>  #define KSYM_NAME_LEN		512
>  
> -/*
> - * A substantially bigger size than the current maximum.
> - *
> - * It cannot be defined as an expression because it gets stringified
> - * for the fscanf() format string. Therefore, a _Static_assert() is
> - * used instead to maintain the relationship with KSYM_NAME_LEN.
> - */
> -#define KSYM_NAME_LEN_BUFFER	2048
> -_Static_assert(
> -	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
> -	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
> -);
> -
>  struct sym_entry {
>  	unsigned long long addr;
>  	unsigned int len;
> @@ -136,24 +121,40 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
>  	}
>  }
>  
> -static struct sym_entry *read_symbol(FILE *in)
> +static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
>  {
> -	char name[KSYM_NAME_LEN_BUFFER+1], type;
> +	char *name, type, *p;
>  	unsigned long long addr;
> -	unsigned int len;
> +	size_t len;
> +	ssize_t readlen;
>  	struct sym_entry *sym;
> -	int rc;
>  
> -	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);
> -	if (rc != 3) {
> -		if (rc != EOF && fgets(name, ARRAY_SIZE(name), in) == NULL)
> -			fprintf(stderr, "Read error or end of file.\n");
> +	readlen = getline(buf, buf_len, in);
> +	if (readlen < 0) {
> +		if (errno) {
> +			perror("read_symbol");
> +			exit(EXIT_FAILURE);
> +		}
>  		return NULL;
>  	}
> -	if (strlen(name) >= KSYM_NAME_LEN) {
> +
> +	if ((*buf)[readlen - 1] == '\n')
> +		(*buf)[readlen - 1] = 0;
> +
> +	addr = strtoull(*buf, &p, 16);
> +
> +	if (*buf == p || *p++ != ' ' || !isascii((type = *p++)) || *p++ != ' ') {

For me, this is not as easy to read as the previous fscanf(), but I like
the switch to getline().

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> +		fprintf(stderr, "line format error\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	name = p;
> +	len = strlen(name);
> +
> +	if (len >= KSYM_NAME_LEN) {
>  		fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
>  				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
> -			name, strlen(name), KSYM_NAME_LEN);
> +			name, len, KSYM_NAME_LEN);
>  		return NULL;
>  	}
>  
> @@ -169,8 +170,7 @@ static struct sym_entry *read_symbol(FILE *in)
>  
>  	/* include the type field in the symbol name, so that it gets
>  	 * compressed together */
> -
> -	len = strlen(name) + 1;
> +	len++;
>  
>  	sym = malloc(sizeof(*sym) + len + 1);
>  	if (!sym) {
> @@ -257,6 +257,8 @@ static void read_map(const char *in)
>  {
>  	FILE *fp;
>  	struct sym_entry *sym;
> +	char *buf = NULL;
> +	size_t buflen = 0;
>  
>  	fp = fopen(in, "r");
>  	if (!fp) {
> @@ -265,7 +267,7 @@ static void read_map(const char *in)
>  	}
>  
>  	while (!feof(fp)) {
> -		sym = read_symbol(fp);
> +		sym = read_symbol(fp, &buf, &buflen);
>  		if (!sym)
>  			continue;
>  
> @@ -284,6 +286,7 @@ static void read_map(const char *in)
>  		table[table_cnt++] = sym;
>  	}
>  
> +	free(buf);
>  	fclose(fp);
>  }
>  
> -- 
> 2.39.2
> 
