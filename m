Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D777381DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjFUK5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjFUK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:57:46 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ABE1A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1687345063;
        bh=2m0Nc/TiyHFuh8a446e407hgjiDQ9WC/BQzH8iC0ShQ=;
        h=Subject:From:To:Cc:Date:From;
        b=PwLKolzRh4n2uw1xmWXMFyhfHjPRQ0ne81kpxu81GlXbfb2Us6ZgGzTCr0dRmlwgL
         OqkX+T2/3oE+xgbqiCYs37AfVwVjZ2v7PE3CNR2psxN2qowODxeKPWKD1QRSjO/kr8
         F8i3flOmO2PwhOqbCefkZrvjYjIBJ4Eum/bJFOKQ=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 4A54D66338;
        Wed, 21 Jun 2023 06:57:42 -0400 (EDT)
Message-ID: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
Subject: A question about prefetchw detection in "x86/asm: Cleanup prefetch
 primitives"
From:   Xi Ruoyao <xry111@xry111.site>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Date:   Wed, 21 Jun 2023 18:57:40 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In commit a930dc4543a2 ("x86/asm: Cleanup prefetch primitives"), a chunk
of code was added:

	/* 3DNow or LM implies PREFETCHW */
	if (!cpu_has(c, X86_FEATURE_3DNOWPREFETCH))
		if (cpu_has(c, X86_FEATURE_3DNOW) || cpu_has(c, X86_FEATURE_LM))
			set_cpu_cap(c, X86_FEATURE_3DNOWPREFETCH);

But Glibc does not contain a similar logic in the CPU feature detection
code, causing a test failure on old CPUs
(https://sourceware.org/bugzilla/show_bug.cgi?id=3D30328).

I intend to implement the same logic for Glibc.  I can understand "3DNow
implies PREFETCHW", but is there a bibliographical reference about "LM
implies PREFETCHW" so I can convince the Glibc maintainers for the
change?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
