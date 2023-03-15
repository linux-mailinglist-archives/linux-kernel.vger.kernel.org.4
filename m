Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E815D6BA77C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCOGH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCOGHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:07:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA4F5A6CF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:07:21 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 26532442FE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678860440;
        bh=AVU4kb/QR1tulNQD4T4kJea28Mw4MLstFyCkcQW4+m8=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=EC4bDgv/3b833rMvVIDrdU7yIIGgH/WUKuKhC1exkvKPDMmsk1Lfg50amPNSzQ1fQ
         ru/anBp4cpzIOKfkIplodqBgsoF/XGeARRQhXFsCUi9Y7+/PAGxy+Zyi7xbSz0kMLf
         gbT9wYsWZCYX3irAwedarMUwdhdFdN10JHCKbaBs32XYkqODBvzVwzKh4s/OrZf9BB
         ioALxEZMI/CRJP45v0WdHppGgETB0q3241tw0J+sMK9ggLnUY/zDw9KxncP0xw4GUR
         1bRAAzGoVCrYybz2JNO2SJy3oUD6Qsyr5lzdayxk+HDxVERUVJ9c8y5l5yrAHqM8yN
         2v1LPAkqEDSqg==
Received: by mail-ed1-f69.google.com with SMTP id y24-20020aa7ccd8000000b004be3955a42eso25516522edt.22
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678860439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVU4kb/QR1tulNQD4T4kJea28Mw4MLstFyCkcQW4+m8=;
        b=3jddATFeSEbnUrmBmFSS35vAfj4IlQN02+xgGljy1OtE8v263dS/4YfyJt5ZiN+8NE
         kT10ZSq1IshZBfSNgOCgZS7Tb/g1g6FhMr9+w0k5zNvoPzfqWIXdKBXi7A2pnQl0Q/fE
         DNfvvvv1cmT0sNImcqiG6bmT06lW6mWi2HeiygXT+g+PiR9RTDqXdsa2Ej0BKxCC6eK9
         KYX/E8MXu/NMj6+1wsO4lRHlSQZrS6xkVfhWXvSYOzuWN3L5+739fn/bD1bmdO1t1ZXr
         gmbly8oLyDJN5HMR+wsHWnLQxv/N4IWy7HP4SFvwx+6eCsy82w3vIYp/0fM5psKym0bp
         Js2g==
X-Gm-Message-State: AO0yUKVnQhduaRUFtsY4cUBidH04M5z031xSZRvN162dGTtpASMJwpv0
        tzm56iAIfZUOCtI+MTDVxP6rWPWzxjAHMErG6p7xtq/RmfEBzWv/ugfF2xHJm8fOWQY3GAguZHK
        4bsOJqG+2GNKCVDJbAzdsc00lRH9a2RtNEPVK1jjILQ==
X-Received: by 2002:a17:906:2603:b0:8b2:8876:6a3c with SMTP id h3-20020a170906260300b008b288766a3cmr5905369ejc.29.1678860439519;
        Tue, 14 Mar 2023 23:07:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9MBRbsoEastfAfOs1NQLpqt3qQ+WHZ9sata8X/oRby9nHjDitGRVuHm6+gZUtsuTsG2uZPaQ==
X-Received: by 2002:a17:906:2603:b0:8b2:8876:6a3c with SMTP id h3-20020a170906260300b008b288766a3cmr5905342ejc.29.1678860439197;
        Tue, 14 Mar 2023 23:07:19 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id rq4-20020a17090788c400b00927341bf69dsm2009205ejc.88.2023.03.14.23.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:07:18 -0700 (PDT)
Date:   Wed, 15 Mar 2023 07:07:17 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
Message-ID: <ZBFglTYuKeAT8dBX@righiandr-XPS-13-7390>
References: <20230111161155.1349375-1-gary@garyguo.net>
 <ZA+IUIOAgrWH2oZ0@righiandr-XPS-13-7390>
 <20230313214853.GY19419@kitsune.suse.cz>
 <ZA+bXi0o27XPx3nz@righiandr-XPS-13-7390>
 <20230313220234.GZ19419@kitsune.suse.cz>
 <ZA+fGpAdnvB5VwKW@righiandr-XPS-13-7390>
 <ZBCG3ykG1q4GEcIf@righiandr-XPS-13-7390>
 <ZBCL1G+8z8c6zLI0@righiandr-XPS-13-7390>
 <CR6IV4NTEN8Z.1V1RNR667SWJ7@vincent-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CR6IV4NTEN8Z.1V1RNR667SWJ7@vincent-arch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 01:15:03AM +0100, Vincenzo Palazzo wrote:
> > In practice, this is what I'm testing at the moment:
> >
> > ---
> > diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> > index ff045644f13f..ea6c830ed1e7 100644
> > --- a/arch/powerpc/kernel/module_64.c
> > +++ b/arch/powerpc/kernel/module_64.c
> > @@ -234,12 +234,13 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
> >  static void dedotify_versions(struct modversion_info *vers,
> >  			      unsigned long size)
> >  {
> > -	struct modversion_info *end;
> > +	struct modversion_info *end = (void *)vers + size;
> >  
> > -	for (end = (void *)vers + size; vers < end; vers++)
> > +	for (; vers < end && vers->next; vers = (void *)vers + vers->next) {
> >  		if (vers->name[0] == '.') {
> >  			memmove(vers->name, vers->name+1, strlen(vers->name));
> >  		}
> > +	}
> >  }
> >  
> >  /*
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 8c5909c0076c..4744901bdf63 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -34,9 +34,11 @@
> >  #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
> >  
> >  struct modversion_info {
> > -	unsigned long crc;
> > -	char name[MODULE_NAME_LEN];
> > -};
> > +	/* Offset of the next modversion entry in relation to this one. */
> > +	u32 next;
> > +	u32 crc;
> > +	char name[0];
> > +} __packed;
> >  
> >  struct module;
> >  struct exception_table_entry;
> > diff --git a/kernel/module/version.c b/kernel/module/version.c
> > index 53f43ac5a73e..5528f98c42dc 100644
> > --- a/kernel/module/version.c
> > +++ b/kernel/module/version.c
> > @@ -17,32 +17,30 @@ int check_version(const struct load_info *info,
> >  {
> >  	Elf_Shdr *sechdrs = info->sechdrs;
> >  	unsigned int versindex = info->index.vers;
> > -	unsigned int i, num_versions;
> > -	struct modversion_info *versions;
> > +	struct modversion_info *versions, *end;
> > +	u32 crcval;
> >  
> >  	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
> >  	if (!crc)
> >  		return 1;
> > +	crcval = *crc;
> >  
> >  	/* No versions at all?  modprobe --force does this. */
> >  	if (versindex == 0)
> >  		return try_to_force_load(mod, symname) == 0;
> >  
> >  	versions = (void *)sechdrs[versindex].sh_addr;
> > -	num_versions = sechdrs[versindex].sh_size
> > -		/ sizeof(struct modversion_info);
> > +	end = (void *)versions + sechdrs[versindex].sh_size;
> >  
> > -	for (i = 0; i < num_versions; i++) {
> > -		u32 crcval;
> > -
> > -		if (strcmp(versions[i].name, symname) != 0)
> > +	for (; versions < end && versions->next;
> > +	       versions = (void *)versions + versions->next) {
> > +		if (strcmp(versions->name, symname) != 0)
> >  			continue;
> >  
> > -		crcval = *crc;
> > -		if (versions[i].crc == crcval)
> > +		if (versions->crc == crcval)
> >  			return 1;
> > -		pr_debug("Found checksum %X vs module %lX\n",
> > -			 crcval, versions[i].crc);
> > +		pr_debug("Found checksum %X vs module %X\n",
> > +			 crcval, versions->crc);
> >  		goto bad_version;
> >  	}
> >  
> > diff --git a/scripts/export_report.pl b/scripts/export_report.pl
> > index feb3d5542a62..1117646f3141 100755
> > --- a/scripts/export_report.pl
> > +++ b/scripts/export_report.pl
> > @@ -116,18 +116,19 @@ foreach my $thismod (@allcfiles) {
> >  	while ( <$module> ) {
> >  		chomp;
> >  		if ($state == 0) {
> > -			$state = 1 if ($_ =~ /static const struct modversion_info/);
> > +			$state = 1 if ($_ =~ /static const char ____versions/);
> >  			next;
> >  		}
> >  		if ($state == 1) {
> > -			$state = 2 if ($_ =~ /__attribute__\(\(section\("__versions"\)\)\)/);
> > +			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
> >  			next;
> >  		}
> >  		if ($state == 2) {
> > -			if ( $_ !~ /0x[0-9a-f]+,/ ) {
> > +			if ( $_ !~ /\\0"/ ) {
> > +				last if ($_ =~ /;/);
> >  				next;
> >  			}
> > -			my $sym = (split /([,"])/,)[4];
> > +			my $sym = (split /(["\\])/,)[2];
> >  			my ($module, $value, $symbol, $gpl) = @{$SYMBOL{$sym}};
> >  			$SYMBOL{ $sym } =  [ $module, $value+1, $symbol, $gpl];
> >  			push(@{$MODULE{$thismod}} , $sym);
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index efff8078e395..55335ae98f4f 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -2046,13 +2046,17 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
> >  static void add_versions(struct buffer *b, struct module *mod)
> >  {
> >  	struct symbol *s;
> > +	unsigned int name_len;
> > +	unsigned int name_len_padded;
> > +	unsigned int tmp;
> > +	unsigned char *tmp_view = (unsigned char *)&tmp;
> >  
> >  	if (!modversions)
> >  		return;
> >  
> >  	buf_printf(b, "\n");
> > -	buf_printf(b, "static const struct modversion_info ____versions[]\n");
> > -	buf_printf(b, "__used __section(\"__versions\") = {\n");
> > +	buf_printf(b, "static const char ____versions[]\n");
> > +	buf_printf(b, "__used __section(\"__versions\") =\n");
> >  
> >  	list_for_each_entry(s, &mod->unresolved_symbols, list) {
> >  		if (!s->module)
> > @@ -2062,16 +2066,27 @@ static void add_versions(struct buffer *b, struct module *mod)
> >  				s->name, mod->name);
> >  			continue;
> >  		}
> > -		if (strlen(s->name) >= MODULE_NAME_LEN) {
> > -			error("too long symbol \"%s\" [%s.ko]\n",
> > -			      s->name, mod->name);
> > -			break;
> > -		}
> > -		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
> > -			   s->crc, s->name);
> > +		name_len = strlen(s->name);
> > +		name_len_padded = (name_len + 1 + 3) & ~3;
> > +
> > +		/* Offset to next entry */
> > +		tmp = 8 + name_len_padded;
> > +		tmp = TO_NATIVE(tmp);
> > +		buf_printf(b, "\t\"\\x%02x\\x%02x\\x%02x\\x%02x",
> > +			   tmp_view[0], tmp_view[1], tmp_view[2], tmp_view[3]);
> > +
> > +		tmp = TO_NATIVE(s->crc);
> > +		buf_printf(b, "\\x%02x\\x%02x\\x%02x\\x%02x\"\n",
> > +			   tmp_view[0], tmp_view[1], tmp_view[2], tmp_view[3]);
> > +
> > +		buf_printf(b, "\t\"%s", s->name);
> > +		for (; name_len < name_len_padded; name_len++)
> > +			buf_printf(b, "\\0");
> > +		buf_printf(b, "\"\n");
> >  	}
> >  
> > -	buf_printf(b, "};\n");
> > +	/* Always end with a dummy NULL entry */
> > +	buf_printf(b, "\t\"\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\";\n");
> >  }
> >  
> >  static void add_depends(struct buffer *b, struct module *mod)
> This looks promissing, do you had a small reproducer to this just to
> make the code a little bit clearn to the reader?

My reproducer was to simply boot the latest 6.2 kernel with this patch
appplied on top on a ppc64 server (without the additional changes the
system just fails to boot as soon as the first module is loaded,
spitting random errors/oops to the console, due to random memory
accesses). I don't have a smaller reproducer than this, maybe I can
clarify a bit more the purpose of the last dummy entry in the comment to
help the reader understand why we need this empty entry (if I understand
your request correctly).

For the TO_NATIVE(tmp) change, instead, it's enough to build the kernel
with a recent gcc (I'm using gcc 12.2.0-17ubuntu1) and the build just
fails.

-Andrea
