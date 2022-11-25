Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00C63837E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKYFaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYFaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:30:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B7928737
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 21:30:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJNjc6wVQz4x2c;
        Fri, 25 Nov 2022 16:30:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1669354214;
        bh=EsiGp1szyWNiHZ5wUGzk8Vc7Mu2R3iNcOrDOCAsGpu4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=a9VqojD0ONcxhe21GW3baCALkn7ejvQFE0BnSLR9SSwLQhPNOTWuGJ0EL5LsKLVJ+
         rnnNLwk+J3NVdOijfHecWdC79mFBPzxVP4wIEIN5Yy2V2Ahg/Zey39X73p1BNLNdpZ
         BmNpagswQtzSrXS8LHCyHbaRrO35IQrT9d0hgUgW0zLqFh8X1EDebSfX8xG4FmudGq
         2x/UySpGlv9M1xssuFzoGB8XN4Av/qpdr55IqDypZexvw5VFp1YoKA9rqT0+Pc3+j4
         7WFn65Gd4UD1I/WhM3Wf9GAhFQSWYTPEPiR045LZwyEZlt9AgDzWWZOc7/mjjkO4fV
         f3ajW9uxBVCtA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "zhang.songyi@zte.com.cn" <zhang.songyi@zte.com.cn>,
        "arnd@arndb.de" <arnd@arndb.de>
Cc:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <deng.changcheng@zte.com.cn>
Subject: Re: [PATCH linux-next] powerpc/cell/axon_msi: replace
 DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
In-Reply-To: <9f6a3690-3ac3-8e13-a80c-b0571826c3d7@csgroup.eu>
References: <202211231706198927223@zte.com.cn>
 <9f6a3690-3ac3-8e13-a80c-b0571826c3d7@csgroup.eu>
Date:   Fri, 25 Nov 2022 16:30:08 +1100
Message-ID: <87tu2nbnz3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi,
>
> Le 23/11/2022 =C3=A0 10:06, zhang.songyi@zte.com.cn a =C3=A9crit=C2=A0:
>> From: zhang songyi <zhang.songyi@zte.com.cn>
>>=20
>> Fix the following coccicheck warning:
>> /arch/powerpc/platforms/cell/axon_msi.c:457:0-23: WARNING:
>> fops_msic should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>
> What's the difference between this new patch and the one that is already=
=20
> awaiting application here :=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20211222090655.48=
4551-1-deng.changcheng@zte.com.cn/=20
> ?
>
> The only difference I see it that the already existing patch has a more=20
> complete description of the change, so unless I'm missing something it=20
> would be nice to avoid sending the same changes again and again.

Both patches switch the code to use a function called "unsafe" without
adequately explaining why that is OK.

The commit that added the cocci check script says:

  If the original struct file_operations are known to be safe against remov=
al
  races by themselves already, the proxy creation may be bypassed by creati=
ng
  the files through debugfs_create_file_unsafe().

None of these conversion patches ever contain any explanation which
speaks to that.

In this case I *think* the change is OK and there is no race because the
debugfs file is never removed. But I really wish the submitter would
tell me that in the change log.

cheers
