Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3228470A510
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 06:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjETEEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 00:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjETEEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 00:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E60110F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 032406177C
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 04:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB6DC433D2;
        Sat, 20 May 2023 04:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684555481;
        bh=fnCGmrlOBLhvjGa9MX2iGqRuD5qwQrNA9llxmcNiWZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BhrPR3KrvQdQnMKffMFNgQhQ27pfjXggtfsY+d9Ade5exLY+0dUgwY+pE39sRisyS
         qgKsQeShHclHx2qV+K5hAwLUpMd03ZsZTu/WANBWrLCS6WzaJRb/QFzbsNRs6NpiNF
         FbBy8sgzlC3AMCE6cGYesoVAP+QGgUOrBIfAMJEcfex0ROUoxIFDCtnLvkh5A/TQIK
         5zsY8gQpOv/9F+sMQ2Gszv7sshkP3BhJi3mDK0VevxHB0GTIn9Vxy2FHKZMGEPyE1X
         46VG2Swu+SNm53LYbipi7/zBHDbClK+SVCBHwXSGnEXIsQ97oztBIx/Ps0wIkDkF/7
         2zDbZkTzrD1bg==
Date:   Fri, 19 May 2023 21:04:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     alexandre.torgue@foss.st.com, davem@davemloft.net,
        edumazet@google.com, joabreu@synopsys.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, peppe.cavallaro@st.com,
        simon.horman@corigine.com
Subject: Re: [PATCH v3] net: stmmac: compare p->des0 and p->des1 with __le32
 type values
Message-ID: <20230519210439.4a3bb326@kernel.org>
In-Reply-To: <20230520015527.215952-1-minhuadotchen@gmail.com>
References: <20230519152715.7d1c3a49@kernel.org>
        <20230520015527.215952-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023 09:55:27 +0800 Min-Hua Chen wrote:
> >Can you try to fix the sparse tool instead? I believe it already
> >ignores such errors for the constant of 0, maybe it can be taught=20
> >to ignore all "isomorphic" values?
> > =20
>=20
> I downloaded the source code of sparse and I'm afraid that I cannot make
> 0xFFFFFFFF ignored easily. I've tried ~0 instead of 0xFFFFFF,
> but it did not work with current sparse.
>=20
> 0 is a special case mentioned in [1].
>=20
> """
> One small note: the constant integer =E2=80=9C0=E2=80=9D is special.=20
> You can use a constant zero as a bitwise integer type without
> sparse ever complaining. This is because =E2=80=9Cbitwise=E2=80=9D (as th=
e name
> implies) was designed for making sure that bitwise types don=E2=80=99t
> get mixed up (little-endian vs big-endian vs cpu-endian vs whatever),
> and there the constant =E2=80=9C0=E2=80=9D really _is_ special.
> """
>=20
> For 0xFFFFFFFF, it may look like a false alarm, but we can silence the
> sparse warning by taking a fix like mine and people can keep working on
> other sparse warnings easier.

We can make working with sparse easier by making sure it doesn't
generate false positive warnings :\

> (There are around 7000 sparse warning in ARCH=3Darm64 defconfig build and
> sometimes it is hard to remember all the false alarm cases)
>=20
> Could you consider taking this patch, please?

No. We don't take patches to address false positive static=20
checker warnings.
