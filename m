Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327106FCE24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjEITDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEITDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:03:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3647235B3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:03:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so9544285a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683659010; x=1686251010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XAiN9wOh89SiyYeYfp6ErFWKCpwKQ6oBL8/wSiSp9c=;
        b=dnSGiE2hRYVFPDNqnsAy7ojfu+hLyT+fl503XqYy+9X/xsjp26v+q/W3NOEOtMSyRw
         wWdAMfRG6sH6Sj/qQAg2QwAlc41woVG+ZXMI30RsEhnLAZsnO9J+o3VzhqtPordOec3K
         YyyzPuD3CcZ2zwS+DHxPYa/yyvqMgVJwXaclLUKaGjV81uqmftuBzuKkYFKugPC8Nai7
         lXHR9+Ig1nJzAIOACw7Q7J/GwLTqpsutWOVYwuC0Pw/5qwlc5QBf2P9mQoKIEiw4CQmM
         o3JgrrFqZA6uuk0pbgYthMrh5Dbo7lzZjecUdLm2AMlxsGRwvVLfQK8iPGrRzPikEb5u
         +fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683659010; x=1686251010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XAiN9wOh89SiyYeYfp6ErFWKCpwKQ6oBL8/wSiSp9c=;
        b=Dyp6AYBoX9aOB+hwM0+Znnq3l2A3AdfQ2cUfq3xDANg75ILfvMZNv/kj3JuMk/mirj
         KhfSKocAfqYIzbQVDwYWO+F1THbXsi8POC2jscisKw3OMkiyhpZ6rSntsmdcNV0ZPWp7
         ltMO13kFdk00b0cKiTKiAwS21jUx4Wc/Y8FM79kwM5g9hWdklBR6c/w/KS0R4JV4g/OT
         J10XyMB6ronxF/N4LtcM9wr9k5DTtgF/kjoJquB7Q0e9sI/sx20D4U6vXDVv6aaIkPlP
         ROLxPnWch+xWAGwOK2+DVS0TdcCb+4c+eyMlDJWHzHt6tGBVVoT6uK5q2iov60pYysZm
         7H0A==
X-Gm-Message-State: AC+VfDySSW+6gzCzxFOUCVspO3aw+G9IE/abf976RcW1NDBi65jk5Vl0
        1hlE+k9eMeRqSDqgD50qPHfkb1r1/YHRCg==
X-Google-Smtp-Source: ACHHUZ4PmGS7F05GoGxIQh0wVLb2Sn2AW/DUV3zy42ddt1rVfgRARvvtZN1WvjncUYLqYvgtSqPBIA==
X-Received: by 2002:a17:907:96a1:b0:966:a691:678d with SMTP id hd33-20020a17090796a100b00966a691678dmr7056761ejc.51.1683659010509;
        Tue, 09 May 2023 12:03:30 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id og40-20020a1709071de800b0095807ab4b57sm1670550ejc.178.2023.05.09.12.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:03:29 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id E43ADBE2DE0; Tue,  9 May 2023 21:03:28 +0200 (CEST)
Date:   Tue, 9 May 2023 21:03:28 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Ben Hutchings <ben@decadent.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Use $KBUILD_BUILD_TIMESTAMP as man page date
Message-ID: <ZFqZAB2ZShmdKtvy@eldamar.lan>
References: <20160517132809.GE7555@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160517132809.GE7555@decadent.org.uk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Ingo, Arnaldo,

On Tue, May 17, 2016 at 02:28:09PM +0100, Ben Hutchings wrote:
> This allows man pages to be built reproducibly.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> --- a/tools/perf/Documentation/Makefile
> +++ b/tools/perf/Documentation/Makefile
> @@ -120,6 +120,9 @@ endif
>  ifdef DOCBOOK_SUPPRESS_SP
>  XMLTO_EXTRA += -m manpage-suppress-sp.xsl
>  endif
> +ifdef KBUILD_BUILD_TIMESTAMP
> +ASCIIDOC_EXTRA += -a revdate=$(shell date -u -d '$(KBUILD_BUILD_TIMESTAMP)' +%Y-%m-%d)
> +endif
>  
>  SHELL_PATH ?= $(SHELL)
>  # Shell quote;
> --- a/tools/perf/Documentation/asciidoc.conf
> +++ b/tools/perf/Documentation/asciidoc.conf
> @@ -71,6 +71,9 @@ ifdef::backend-docbook[]
>  [header]
>  template::[header-declarations]
>  <refentry>
> +<refentryinfo>
> +template::[docinfo]
> +</refentryinfo>
>  <refmeta>
>  <refentrytitle>{mantitle}</refentrytitle>
>  <manvolnum>{manvolnum}</manvolnum>

As we do apply the change in Downstream in Debian, I was wondering if
it just felt trough the cracks and could still be applied. Is there
anything missing?

Regards,
Salvatore
