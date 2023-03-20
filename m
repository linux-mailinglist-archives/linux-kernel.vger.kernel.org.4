Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908FB6C0BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCTH5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCTH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:57:46 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD6410259
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1679299064;
        bh=VxC0eBySV+UHVLpViRTKZxFwXRZN0yKf8KjRsWMjWtk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mEjFeEAqrHkFNaxJiE9kTo1ygzZrIo8+6qyTMrFlHNzL2bj1xhDZcUhNhpnXu81fQ
         EwXVBkXxniX89j6AmwW6+0atUm8duHG92ZH+UaILg5Vy6fDxS6YFBUEueCMegimsiF
         kNkQHuE9fHrsfutle3QxGBoqmmEbOe4wtaCncwjA=
Received: from [IPv6:240e:358:11f7:6300:dc73:854d:832e:4] (unknown [IPv6:240e:358:11f7:6300:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 97A0B66128;
        Mon, 20 Mar 2023 03:57:32 -0400 (EDT)
Message-ID: <cb620bf530d98e1fe735ff5e634b203070e25115.camel@xry111.site>
Subject: Re: [PATCH V4] LoongArch: Make WriteCombine configurable for
 ioremap()
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Mon, 20 Mar 2023 15:57:24 +0800
In-Reply-To: <20230316064142.1802468-1-chenhuacai@loongson.cn>
References: <20230316064142.1802468-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-16 at 14:41 +0800, Huacai Chen wrote:
> LoongArch maintains cache coherency in hardware, but when paired with
> LS7A chipsets the WUC attribute (Weak-ordered UnCached, which is similar
> to WriteCombine) is out of the scope of cache coherency machanism for
> PCIe devices (this is a PCIe protocol violation, which may be fixed in
> newer chipsets).
>=20
> This means WUC can only used for write-only memory regions now, so this
> option is disabled by default, making WUC silently fallback to SUC for
> ioremap(). You can enable this option if the kernel is ensured to run on
> hardware without this bug.
>=20
> Kernel parameter writecombine=3Don/off can be used to override the Kconfi=
g
> option.
>=20
> Suggested-by: WANG Xuerui <kernel@xen0n.name>
> Reviewed-by: WANG Xuerui <kernel@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

LGTM.

I still prefer an automatic way, but anyway we can implement it later
after a bug-free LS7A successor is launched.

Should we Cc: stable@vger.kernel.org and make a PR for 6.3 as well?  To
me it's a "bug fix" and needed for stable releases, but I'm not sure.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
