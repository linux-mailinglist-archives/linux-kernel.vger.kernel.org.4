Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3E66FF9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbjEKTRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjEKTQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:16:59 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8510C9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:16:57 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-549f0b45ac6so2848846eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683832617; x=1686424617;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XzcRe6yd6VanMO45q3Pd2IcrvmL4N7rPMDOmqVQflaU=;
        b=YhTJEYJkK+lb4xUc9WSZbvj5e3BtoXiT9anGPX3XpLDMQaORuLL2h4RKNEmZtxh89F
         BzDZ7yUWXZEJIzWJkrbhYqLkmlDt71bLUKpAq/fgYdRWG8BUl9HnM5fh30RW68Pbkrxz
         Xj81CVGmLwFh5lXja6R/nkTds+7xOSvxVW6Y1Eu9eH67AAuFt95PbCod6Ed6XEV9ZQO1
         sCwIzZubbH5lJ5Ne/Ec17mCaUZ4L/IN0ryUbk6yRPdESIgeD082ao2i9rQ/HhHNhdoOJ
         r5iIrJaWQT35Ha6J5P/LF69IQ34hKWRnbSJReV0Tu0sTsvV3w8SUWHD0wjpOGkwCp3Ho
         4iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683832617; x=1686424617;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzcRe6yd6VanMO45q3Pd2IcrvmL4N7rPMDOmqVQflaU=;
        b=Yzf/elcfTtFn11LZ7//9f4K1Be8pn4kFWI1DGK7KKaaHNWiKhcQFrZbGTTal6mByQI
         QXyw0RI8vG/HrlsxGv2dTSzsQrK6KxvcsT+P+/szlk8dMvEWF3J+77xhNP/J8IYVZlwg
         t71TshKJT85V5SUOd5Y4YH1iTxiyA9+zeWcypB44ezaVUA1gtzTsSHDYhuZgTYIAuKQM
         2ZEN1SuLxWTRfNF7FLNZMdGqfWn9irqEANRvbe45meEOVHqWCIooNSaTTY/7dJ3q2XWE
         SbdtlD3nSPRfwOxEeznQjEnYX7F32BpP1ej+LL/QRXfR+C0iveUfdSe6F0KNemfwLkQl
         NjLw==
X-Gm-Message-State: AC+VfDwZj7dFokNT6mttI8ufx9Rz4iTLdLU6zZ8Han6I50Kg+CGuPMK1
        HDqnkTuESqnZ5c5vKM7vTP2Lrtx4m/tsSV5tuXA=
X-Google-Smtp-Source: ACHHUZ6FxwYRl9h59UfryJKJPNVWO2/PO+x7fTIqMMo9RqSAKtlCvsiZNXOe2o0rBJTAAt5I9XJuXTAXUaugx1DUtxI=
X-Received: by 2002:a4a:6c1c:0:b0:54f:83c7:d4cc with SMTP id
 q28-20020a4a6c1c000000b0054f83c7d4ccmr4434011ooc.8.1683832616424; Thu, 11 May
 2023 12:16:56 -0700 (PDT)
MIME-Version: 1.0
Sender: ericgloriapaul@gmail.com
Received: by 2002:a05:6358:5e0c:b0:11a:758f:2411 with HTTP; Thu, 11 May 2023
 12:16:55 -0700 (PDT)
From:   Stepan CHERNOVETSKY <chernovetskyistepan@gmail.com>
Date:   Thu, 11 May 2023 20:16:55 +0100
X-Google-Sender-Auth: Gukf_qhK3bpEFqxns9UR7nF4fiE
Message-ID: <CAApFGfQbM_VxVx1XkZTRmPwL2n1Rn6ap3f1fwGmVjK-pY_CXXQ@mail.gmail.com>
Subject: I Need Your Urgent Attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DEAR_SOMETHING,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ericgloriapaul[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir/Madam,

Please do not be embarrassed for contacting you through this medium; I
got your contact from Google people search and then decided to contact
you. My goal is to establish a viable business relationship with you
there in your country.

I am CHERNOVETSKYI Stepan. from Kyiv (Ukraine); I was a
businessman, Investor and Founder of Chernovetskyi Investment Group
(CIG) in Kyiv before Russia=E2=80=99s Invasion of my country. My business h=
as
been destroyed by the Russian military troops and there are no
meaningful economic activities going on in my country.

I am looking for your help and assistance to buy properties and other
investment projects, I consider it necessary to diversify my
investment project in your country, due to the invasion of Russia to
my country, Ukraine and to safeguard the future of my family.

Please, I would like to discuss with you the possibility of how we can
work together as business partners and invest in your country through
your assistance, if you can help me.

Please, if you are interested in partnering with me, please respond
urgently for more information.

Yours Sincerely,
CHERNOVETSKYI Stepan.
CEO/President Chernovetskyi Investment Group (CIG)
