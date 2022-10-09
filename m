Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87075F8AAF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJIKhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 06:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJIKhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:37:34 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA9EB36
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1665311851;
        bh=J54On5AUhcm4ClBxiTcpnPQn1WKK6Rp1zpMkD36rdaU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Sd1p8jg6QFSVuFZ44YwupxEOOZ02rhipzEXlOZDyx3ZaKSjhiWn8TjJSfQtN902vk
         z6YpjdIGDxd/H1WMblzbIfT7qa9tdAsRb1xJN/K0zHiR3HsTfVRpvgKv3vIdmwelO3
         Z3mqkTztUDiOCylqnajFBFWxV7w3rzhAeBd8dqwI=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 139206680B;
        Sun,  9 Oct 2022 06:37:29 -0400 (EDT)
Message-ID: <19415767029b479a508378abaf8c6c5a1d048add.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: mm: Refactor TLB handlers
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>, Rui Wang <wangrui@loongson.cn>
Cc:     loongarch@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
        linux-kernel@vger.kernel.org
Date:   Sun, 09 Oct 2022 18:37:28 +0800
In-Reply-To: <CAAhV-H6e9ZyC8TkpWK3Etgz4-kEEEU4Hj=i5obMFk=URgCwrgw@mail.gmail.com>
References: <20221004140230.748788-1-wangrui@loongson.cn>
         <CAAhV-H6e9ZyC8TkpWK3Etgz4-kEEEU4Hj=i5obMFk=URgCwrgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-10-09 at 14:13 +0800, Huacai Chen wrote:
> Queued for loongarch-next, thanks.

> And fixes the concurrent modification issue of fast path for huge
> pages.
> This issue will occur in the following steps:
>=20
>    CPU-1 (In TLB exception)         CPU-2 (In THP)
> 1: Load PMD entry (HUGE=3D1)
> 2: Goto huge path
> 3:                                  Store PMD entry (HUGE=3D0)
> 4: Reload PMD entry (HUGE=3D0)
> 5: Fill TLB entry (PA is incorrect)

Is this issue causing problems in practice?  If true should we pick this
for loongarch-fixes and backport into 5.19 & 6.0 too?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
