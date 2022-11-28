Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A263AEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiK1RQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiK1RQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:16:13 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319E23EA3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669655757;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=bOuOksZJoXbaL7IsTIZbAd8uRA2KdZcmEpIrDDtAX20=;
    b=bq1+a0JKU+qCS698IbnrpsRZW2b+E+c0JRQ7KlLSbtZmeRmpXe/LjPhUk6EgGgg5du
    aWePs6sRvEWbZGPSlTqvnD1pH2nY2LfUmlUBVYR4q5CQpTOt0PjGJYgXAIkAAQrkqTmd
    hhh6dbP+aWhMFtQfiIPg2z5+BYNLt8Ytwl96pCLdxtJgv0HX+qARQ3uKuahVvcYHd0Pl
    3Srok0pCeyQMIuYAhAD4HcBHtV1QBZZiC0QWk7wMaVmZJNynp40Lq/AjLPryAgI4YVHf
    7T97wfCBCDXPxdgSAqyL2KGhIuXWOG9ZbF7poNAwTXu0F/PqYXRBs3cEuimSMsmv3/IX
    HloQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGYk/8="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id v55d69yASHFuCUa
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 28 Nov 2022 18:15:56 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Date:   Mon, 28 Nov 2022 18:15:55 +0100
Subject: [BUG] Add missing <linux/string.h> include for strcmp.
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
To:     Sam James <sam@gentoo.org>
Message-Id: <A222B1E6-69B8-4085-AD1B-27BDB72CA971@goldelico.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
starting with v6.1-rc7 I can't build my tree any more:

  HOSTCC  scripts/mod/modpost.o - due to target missing
In file included from include/linux/string.h:5,
                 from scripts/mod/../../include/linux/license.h:5,
                 from scripts/mod/modpost.c:24:
include/linux/compiler.h:246:10: fatal error: asm/rwonce.h: No such file =
or directory
  246 | #include <asm/rwonce.h>
      |          ^~~~~~~~~~~~~~
compilation terminated.

Bisect did show your patch as the first bad one:

commit 50c697215a8c "Add missing <linux/string.h> include for strcmp."

Reverting it makes compile succeed.

The problem is that HOSTCC is not necessarily the same compiler or even
architecture as CC and pulling in <linux/compiler.h> or <asm/rwonce.h>
files indirectly isn't a good idea then.

My toolchain is providing HOSTCC =3D gcc (MacPorts) and CC =3D =
arm-linux-gnueabihf
(built from gcc source) and all running on Darwin.

If I change the include to <string.h> I can then "HOSTCC =
scripts/mod/modpost.c"
but then it fails for "CC kernel/module/main.c" not finding <string.h>:

  CC      kernel/module/main.o - due to target missing
In file included from kernel/module/main.c:43:0:
./include/linux/license.h:5:20: fatal error: string.h: No such file or =
directory
 #include <string.h>
                    ^
compilation terminated.

So this should be a conditional include depending on CC vs. HOSTCC.
Or moved elsewhere.

BR and thanks,
Nikolaus

