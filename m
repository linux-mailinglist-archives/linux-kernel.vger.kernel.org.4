Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB356827E0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjAaJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjAaJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:00:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D30F4B759;
        Tue, 31 Jan 2023 00:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19819B81A56;
        Tue, 31 Jan 2023 08:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73B7C4339B;
        Tue, 31 Jan 2023 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675155287;
        bh=NTMstEjBKq2RRhSC/QQd9421QayiCvHcV2OsRUI3g6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tLu4pZ/GzDZw9MJaoLdNG4J+9iGfeo7KHyzRXqLWwY7B64iub67WpWES8mcKx6UkL
         ujzSS5EV0kJ3aC7ILOB+f7YCn+7cn2Gk6Ob6uOgHP0oucYQQ7YNeANMoJsGCT6Xxqu
         RQGZ45UGjofmYXfswZ8bXwQj69oGIp4Sz6+dAhF6XAHessZvJ2hCGa7MQWr2DpczPn
         W8+wWBy+HkwmfX9Ld123pE6uA0XZGJ+wFf1MiadTdH/y/0JaLpptdo5iVZbEIBK53f
         wOxL72N3Y8aibwGtfx+khlwjCEKrxcM4oJr8wVSLEzAq+mfQGW8VojT4ES5v8ozxnw
         TKc57dZTPV2mA==
Received: by mail-oi1-f176.google.com with SMTP id j21so3318542oie.4;
        Tue, 31 Jan 2023 00:54:47 -0800 (PST)
X-Gm-Message-State: AFqh2koxjjvmMN9RKfq3Vs4KN8oWckzATDpU+hjviVsQjDqD8sONwVUA
        ZaIdlYXlXDULozMn8zqokQRbncaKC0QSTErl0d4=
X-Google-Smtp-Source: AMrXdXuYweFo7uPcJ+NWyvWLhoQOsFc8HHaOb+1PwauXJg0REsAY6FLZFYS84zW2oja508SYFVtI+JXMlfzhVomURRw=
X-Received: by 2002:a05:6808:1786:b0:35e:7c55:b015 with SMTP id
 bg6-20020a056808178600b0035e7c55b015mr3244852oib.287.1675155287099; Tue, 31
 Jan 2023 00:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20230131084323.1414010-1-jlu@pengutronix.de> <20230131084323.1414010-2-jlu@pengutronix.de>
In-Reply-To: <20230131084323.1414010-2-jlu@pengutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Jan 2023 17:54:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_-NCpzB7WOKomaBo30Xxt53GCVvxxME7i6eXHr8Fhrw@mail.gmail.com>
Message-ID: <CAK7LNAT_-NCpzB7WOKomaBo30Xxt53GCVvxxME7i6eXHr8Fhrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] certs: Fix build error when PKCS#11 URI contains semicolon
To:     Jan Luebbe <jlu@pengutronix.de>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 5:43 PM Jan Luebbe <jlu@pengutronix.de> wrote:
>
> When CONFIG_MODULE_SIG_KEY is PKCS#11 URI (pkcs11:*) and contains a
> semicolon, signing_key.x509 fails to build:
>
>   certs/extract-cert pkcs11:token=foo;object=bar;pin-value=1111 certs/signing_key.x509
>   Usage: extract-cert <source> <dest>
>
> Add quotes to the extract-cert argument to avoid splitting by the shell.
>
> This approach was suggested by Masahiro Yamada <masahiroy@kernel.org>.
>
> Fixes: 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>


Both applied to linux-kbuild/fixes.
Thanks.




> ---
>  certs/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/certs/Makefile b/certs/Makefile
> index 9486ed924731..799ad7b9e68a 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -23,8 +23,8 @@ $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
>  targets += blacklist_hash_list
>
>  quiet_cmd_extract_certs  = CERT    $@
> -      cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
> -extract-cert-in = $(or $(filter-out $(obj)/extract-cert, $(real-prereqs)),"")
> +      cmd_extract_certs  = $(obj)/extract-cert "$(extract-cert-in)" $@
> +extract-cert-in = $(filter-out $(obj)/extract-cert, $(real-prereqs))
>
>  $(obj)/system_certificates.o: $(obj)/x509_certificate_list
>
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada
