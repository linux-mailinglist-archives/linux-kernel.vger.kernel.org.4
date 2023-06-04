Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD064721B00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 01:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjFDXML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 19:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDXMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 19:12:09 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0946A9;
        Sun,  4 Jun 2023 16:12:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DB19942450;
        Sun,  4 Jun 2023 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1685920325; bh=WEWALjOupcqnv3sqrNFWKhE/C8Uto/AQ6DaPQbUMHL0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=skCcmN69kviM9RpO8lvcObEdj6jg4uAdBC1y7rKUxJhiBw1gGZ+IWStGRzl5E8N7k
         b+5QDz/6VtZ0V1yI0xwRYYAq6NG3rmoXh87skqKpkLOL3FM8XYjjdJ5KyFh+Mqhgrh
         Q+FcT7dNj3UzTpkp2wUGFsYvG9TMWNolPpeAe1539H8B31eiTl9950mqw/Xic+bcrI
         b6psjKG/We3fy9yrBW7iN3w5VsuUcWhB+xjUm21h8fT4dvYtCwow2xEsiy/IwLhAwP
         a6K45rdCuP39fqcLXaN3o8HjIIUgyEXZBG5fV9jGfCR5KDgTVLCnhUwQDtQlSgHGrb
         i9FTHHN2cbedA==
Date:   Mon, 05 Jun 2023 08:11:55 +0900
From:   "Hector Martin \"marcan\"" <marcan@marcan.st>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the asahi-soc tree
User-Agent: K-9 Mail for Android
In-Reply-To: <20230605085816.4f54bb43@canb.auug.org.au>
References: <20230605085816.4f54bb43@canb.auug.org.au>
Message-ID: <E17AC653-8534-4189-ACDF-F6CCD1C1D9F0@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks, looks like a missing include=2E I'll fix it up when I get home in =
a bit=2E Sorry for the noise!

(And apologies for top-posting, I'm on mobile right now)

On June 5, 2023 7:58:16 AM GMT+09:00, Stephen Rothwell <sfr@canb=2Eauug=2E=
org=2Eau> wrote:
>Hi all,
>
>After merging the asahi-soc tree, today's linux-next build (x86_64
>allmodconfig) failed like this:
>
>In file included from include/linux/io=2Eh:13,
>                 from drivers/soc/apple/mailbox=2Ec:22:
>drivers/soc/apple/mailbox=2Ec: In function 'apple_mbox_send':
>drivers/soc/apple/mailbox=2Ec:151:24: error: implicit declaration of func=
tion 'FIELD_PREP' [-Werror=3Dimplicit-function-declaration]
>  151 |         writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg=2Emsg1=
),
>      |                        ^~~~~~~~~~
>arch/x86/include/asm/io=2Eh:103:42: note: in definition of macro 'writeq_=
relaxed'
>  103 | #define writeq_relaxed(v, a)    __writeq(v, a)
>      |                                          ^
>drivers/soc/apple/mailbox=2Ec: In function 'apple_mbox_poll_locked':
>drivers/soc/apple/mailbox=2Ec:188:28: error: implicit declaration of func=
tion 'FIELD_GET' [-Werror=3Dimplicit-function-declaration]
>  188 |                 msg=2Emsg1 =3D FIELD_GET(
>      |                            ^~~~~~~~~
>
>Caused by commit
>
>  0d1f3f7f8486 ("soc: apple: mailbox: Add ASC/M3 mailbox driver")
>
>I have used the asshi-soc tree from next-20230602 for today=2E
>

- Hector
