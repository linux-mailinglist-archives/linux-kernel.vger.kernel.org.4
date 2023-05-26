Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4871713033
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjEZXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjEZXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:02:26 -0400
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 May 2023 16:02:23 PDT
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA97412A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:02:23 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 18623 invoked from network); 27 May 2023 00:55:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1685141740; bh=VvSoMrHvhVNlCwFPGAUIEqpYz2HzEWNVM8RO0H65NdI=;
          h=From:To:Cc:Subject;
          b=DSJBXsYzYEbbxbGZvm1lNifi5MzPbVQN3gG8iPJoT/j5tcpzTX0KNirPQ7qUaq8NZ
           wvWdXP9r4F7E7tecCII/piBg5e8hnIYb0DiLVQKQSIx1LKiByH3oBkhYqbLp+wlPM0
           mMzl68+h0kDKbsYO8Q52bSSt2E8YZmluVQ00VBcU=
Received: from public-gprs209227.centertel.pl (HELO mocarz) (deweloper@wp.pl@[46.134.156.140])
          (envelope-sender <deweloper@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@arndb.de>; 27 May 2023 00:55:40 +0200
Date:   Sat, 27 May 2023 00:55:39 +0200
From:   Aleksander Mazur <deweloper@wp.pl>
To:     Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] /proc/modules: honor kptr_restrict even without
 CONFIG_KALLSYMS
Message-ID: <20230527005539.5b06df24@mocarz>
In-Reply-To: <20220605224347.481e2fb4@mocarz>
References: <20220605224347.481e2fb4@mocarz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-WP-MailID: 16f17fd0e92567a0c1d51dcf35eb9c64
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [wSMk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Have you had a chance to review my patch?

--=20

Dnia 2022-06-05, o godz. 22:43:47
Aleksander Mazur <deweloper@wp.pl> napisa=C5=82(a):

> Commit e4a8ca3baa55 fixed building without CONFIG_KALLSYMS by providing
> dummy kallsyms_show_value(). Unfortunately -- due to hard-coded "false"
> being returned -- access to addresses in /proc/modules became permanently
> disabled.
>=20
> My proposal is to change this unconditional "false" to !kptr_restrict.
> This re-enables addresses in /proc/modules even without CONFIG_KALLSYSMS
> unless restricted by means of sysctl (kernel.kptr_restrict).
>=20
> Fixes: e4a8ca3baa55 ("/proc/module: fix building without kallsyms")
> Signed-off-by: Aleksander Mazur <deweloper@wp.pl>
> ---
>  include/linux/kallsyms.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index ad39636e0c3f..cf64f9709f46 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -160,7 +160,7 @@ static inline int lookup_symbol_attrs(unsigned long a=
ddr,
> unsigned long *size, u=20
>  static inline bool kallsyms_show_value(const struct cred *cred)
>  {
> -	return false;
> +	return !kptr_restrict;
>  }
> =20
>  static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *,
> struct module *,

