Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680396AD27C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCFXCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCFXCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:02:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567A74323
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:02:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 246186101E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 23:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40185C433EF;
        Mon,  6 Mar 2023 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678143750;
        bh=z4sKn8XHdxqogRnv1bHWPwJ47JBIU4XjNoik02EMrd0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=RiUalQzLZcse5Kd9cue/OUhp3iiL16jlmEqzap38tBTZqDAnx5DGyJrQ/OsE8eryN
         SFeDeuubgAALOTbJAPOIIvTW7cCQRoNtRTpn+0hkPqyjiVNK+MkQrhwltmWC1B91Hb
         2hnE3nH4Sx0r/10bNFTijg0JrjrEskymsL1/O8IsiTCTvAOHa/TZnG+IFwiyWZAogA
         StFlaD0hM8r2Q1Wl9Sh0YqvB1dZx+RpndmJSybVaHk9nMiurGL8Szi8WSX7gu3rmbG
         1hberQNHBk6Kpnca0Ppqfz1Zr3WX2k+3zcZQhzNU8GOKQS4zNlxW5N/bOSSaNd0afR
         g6Lou0smAP2Sw==
Date:   Mon, 06 Mar 2023 15:02:23 -0800
From:   Kees Cook <kees@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
CC:     mhiramat@kernel.org, akpm@linux-foundation.org,
        masahiroy@kernel.org, paulmck@kernel.org, hannes@cmpxchg.org,
        ojeda@kernel.org, thunder.leizhen@huawei.com,
        christophe.leroy@csgroup.eu, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/Kconfig: extend -Wno-array-bounds to gcc 13
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdkd7pUu_oxt4=CW3fxXz2y7evtU9J5Gd7oQuyi1MkDMCw@mail.gmail.com>
References: <20230306220947.1982272-1-trix@redhat.com> <CAKwvOdkd7pUu_oxt4=CW3fxXz2y7evtU9J5Gd7oQuyi1MkDMCw@mail.gmail.com>
Message-ID: <C01C39FE-E776-48DA-84F2-402B49A705A8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 6, 2023 2:20:50 PM PST, Nick Desaulniers <ndesaulniers@google=2Eco=
m> wrote:
>+ Kees
>https://lore=2Ekernel=2Eorg/lkml/20230306220947=2E1982272-1-trix@redhat=
=2Ecom/
>
>On Mon, Mar 6, 2023 at 2:10=E2=80=AFPM Tom Rix <trix@redhat=2Ecom> wrote:
>>
>> With gcc 13=2E0=2E1 on x86, there are several false positives like
>>
>> drivers/net/ethernet/microchip/sparx5/sparx5_psfp=2Ec:167:31:
>>   error: array subscript 4 is above array bounds of =E2=80=98const stru=
ct sparx5_psfp_gce[4]=E2=80=99 [-Werror=3Darray-bounds=3D]
>>   167 |                 gce =3D &sg->gce[i];
>>       |                        ~~~~~~~^~~
>> In file included from drivers/net/ethernet/microchip/sparx5/sparx5_psfp=
=2Ec:8:
>> drivers/net/ethernet/microchip/sparx5/sparx5_main=2Eh:506:32: note: whi=
le referencing =E2=80=98gce=E2=80=99
>>   506 |         struct sparx5_psfp_gce gce[SPX5_PSFP_GCE_CNT];
>>       |                                ^~~
>>
>> The code lines for the reported problem
>>         /* For each scheduling entry */
>>         for (i =3D 0; i < sg->num_entries; i++) {
>>                 gce =3D &sg->gce[i];
>>
>> i is bounded by num_entries, which is set in sparx5_tc_flower=2Ec
>>         if (act->gate=2Enum_entries >=3D SPX5_PSFP_GCE_CNT) {
>>                 NL_SET_ERR_MSG_MOD(extack, "Invalid number of gate entr=
ies");
>>                 return -EINVAL;
>>         }
>> =2E=2E
>>         sg->num_entries =3D act->gate=2Enum_entries;
>>
>> So disable array-bounds as was done on gcc 11 and 12

GCC 13 isn't released yet, and we've been working to make Linux warning-fr=
ee under -Wareay-bounds=2E (And we succeeded briefly with GCC 11=2E)

I'd much rather get GCC fixed=2E This is due to the shift sanitizer reduci=
ng the scope of num_entries (via macro args) to 0-31, which is still >4=2E =
This seems like a hinting bug in GCC: just because the variable was used in=
 a shift doesn't mean the compiler can make any value assumptions=2E

-Kees



--=20
Kees Cook
