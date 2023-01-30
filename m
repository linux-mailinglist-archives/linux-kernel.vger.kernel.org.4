Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323616814BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbjA3PUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjA3PTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:19:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D036094;
        Mon, 30 Jan 2023 07:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B878DCE177D;
        Mon, 30 Jan 2023 15:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AD2C4339E;
        Mon, 30 Jan 2023 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675091974;
        bh=tMOEgqH5sdYs3wJI3azBMLp95TQD+BWGUsNFr2sCEvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QE4DhhI9dqA9dIg6VjvJEp081kUDC2zXANgrd+ImH2J9rf3gxJg11Pwmd4Ky8asB8
         R3pPogBPzkBRzn5H0wf3sWMe04x2Ko85UuYA1IF2+Y4Yhg1p7Ai1K2didr1cinVdtE
         74PJSyOyR9oiijJWa7NFolWqEHRFQgwlUacVAN/P6rMkYR5nyHOlisTBUCn8M5Aypl
         Xfi1ZBpM0wThwz0q0CNK6vQs+LKitamhJGBivXq3vsHgwCgfxoRRiEeGQ+qsQ+IYN0
         pqY3gx1SP9VwE+MUrE+zr4sp8eMhqPOOSKj6R3SQW9FdzQlIYOGKoJ6C1HzLXfo8Zp
         H7xM/Tp6yLvEQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-163bd802238so3220194fac.1;
        Mon, 30 Jan 2023 07:19:34 -0800 (PST)
X-Gm-Message-State: AFqh2koOmJPVxxX2ef2wOu5OkbLCz/M/mAIE+Q1Euwfsed8ILATcPUFE
        k8OZIyyJD0mIcUh4Ak44fWI3jFLnr24RJg4Jl1Y=
X-Google-Smtp-Source: AK7set+gmAtuKgSfLSV9b6u8l0NDviT2HPJq3rzM6TDit+PHUBzQGycEsbMNPqCUYD3Uz4zqBS8xv+GV2BKu4eGJe3U=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr2272953oaf.287.1675091973278; Mon, 30
 Jan 2023 07:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20230130141553.3825449-1-jlu@pengutronix.de> <20230130141553.3825449-2-jlu@pengutronix.de>
In-Reply-To: <20230130141553.3825449-2-jlu@pengutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Jan 2023 00:18:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReD_97qWRT8f47VKx9cScTWUJcHNkUyhXQoMAYPwAPUQ@mail.gmail.com>
Message-ID: <CAK7LNAReD_97qWRT8f47VKx9cScTWUJcHNkUyhXQoMAYPwAPUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] certs: Fix build error when PKCS#11 URI contains semicolon
To:     Jan Luebbe <jlu@pengutronix.de>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:16 PM Jan Luebbe <jlu@pengutronix.de> wrote:
>
> When CONFIG_MODULE_SIG_KEY is PKCS#11 URI (pkcs11:*) and contains a
> semicolon, signing_key.x509 fails to build:
>
>   certs/extract-cert pkcs11:token=foo;object=bar;pin-value=1111 certs/signing_key.x509
>   Usage: extract-cert <source> <dest>
>
> Add quotes to the PKCS11_URI variable to avoid splitting by the shell.
>
> Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  certs/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/certs/Makefile b/certs/Makefile
> index 9486ed924731..cda21811ed88 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -67,7 +67,7 @@ $(obj)/system_certificates.o: $(obj)/signing_key.x509
>
>  PKCS11_URI := $(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY))
>  ifdef PKCS11_URI
> -$(obj)/signing_key.x509: extract-cert-in := $(PKCS11_URI)
> +$(obj)/signing_key.x509: extract-cert-in := "$(PKCS11_URI)"
>  endif
>
>  $(obj)/signing_key.x509: $(filter-out $(PKCS11_URI),$(CONFIG_MODULE_SIG_KEY)) $(obj)/extract-cert FORCE
> --
> 2.30.2
>

Instead, how about this?




diff --git a/certs/Makefile b/certs/Makefile
index 9486ed924731..799ad7b9e68a 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -23,8 +23,8 @@ $(obj)/blacklist_hash_list:
$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
 targets += blacklist_hash_list

 quiet_cmd_extract_certs  = CERT    $@
-      cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
-extract-cert-in = $(or $(filter-out $(obj)/extract-cert, $(real-prereqs)),"")
+      cmd_extract_certs  = $(obj)/extract-cert "$(extract-cert-in)" $@
+extract-cert-in = $(filter-out $(obj)/extract-cert, $(real-prereqs))

 $(obj)/system_certificates.o: $(obj)/x509_certificate_list






--
Best Regards
Masahiro Yamada
