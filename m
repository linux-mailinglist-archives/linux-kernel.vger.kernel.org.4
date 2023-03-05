Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3656AB132
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCEPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCEPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:11:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C68B75B;
        Sun,  5 Mar 2023 07:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 861C9B80AD9;
        Sun,  5 Mar 2023 15:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1197BC4339B;
        Sun,  5 Mar 2023 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678029059;
        bh=RlcSs9U00i8cPx/6YbgM4UbWDDp7+QQtC/istVgsnzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jkYkrYwrFpuL0kcaJBxE0tUtrj6qBW0jeVRVX/Q6vwiUmww/+Unl2h76J9w2abQpJ
         fWg+FKORW/99KmwUV3tEVxXXRdUIyMrRoGrw/GPGJUw3ADbox57azGA5QJealTJoUN
         SAef2p/MkKpwZHu5YKk8HJ6str3skuOX4yZUUKNsN8N7rHC3UAxnpXTYTpMqgxDFou
         DTCWnE8YxU58tvLVwfKhsVk//1nXFX9Ujv5+1M3jLMU1mCptr1NsKbL3DFxpmka83q
         Ms5osDzGxH/5P4tDeRpOe2BG+nizbqNsAfb5yXOpg3bUSQ5WfPph4DvmRg55WTlipU
         IGDdC5bqqDycQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-173435e0ec4so8741583fac.12;
        Sun, 05 Mar 2023 07:10:58 -0800 (PST)
X-Gm-Message-State: AO0yUKXfpnCcaackvXTb/Ee7qDzfkAJZ/v6I07qyMeNgFHinWoeFWfrR
        8h3630EKc0OdjyO/YI8P6vBK8HPIMQJckfgLGVM=
X-Google-Smtp-Source: AK7set/dTF6oLMPVw27eM3Q3LyKhvRX4Fie0Hx+7dicG7/Jp2L50eVGaODuaHzUZJs6CZVAL3wiY/h1D6G1xrQgCMgw=
X-Received: by 2002:a05:6870:3a1b:b0:176:4f00:abce with SMTP id
 du27-20020a0568703a1b00b001764f00abcemr2666513oab.8.1678029058279; Sun, 05
 Mar 2023 07:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20221205163157.269335-1-nick.alcock@oracle.com> <20221205163157.269335-4-nick.alcock@oracle.com>
In-Reply-To: <20221205163157.269335-4-nick.alcock@oracle.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 6 Mar 2023 00:10:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASpkAY=t3uOmehTDD7o1-MY9Kzm1C=V2+i0XhHmjjJdUQ@mail.gmail.com>
Message-ID: <CAK7LNASpkAY=t3uOmehTDD7o1-MY9Kzm1C=V2+i0XhHmjjJdUQ@mail.gmail.com>
Subject: Re: [PATCH v10 03/13] kbuild: add tristate checker
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 1:32=E2=80=AFAM Nick Alcock <nick.alcock@oracle.com>=
 wrote:
>
> This new check target uses the tristate.conf machinery just added, and
> modules.builtin.objs, to identify source files that have MODULE_*
> declarations despite not being modules according to Kconfig.  After
> commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), all such declarations will cause
> modprobe to misidentify their containing object file as a module when it
> is not, which might cause it to spuriously fail when trying to load
> something that is built in to the kernel.




Having false-positives in modules.builtin should be OK.


Also, scripts/check-tristates.mk is just a rename of
scripts/Makefile.modbuiltin.


NACK.





--
Best Regards


Masahiro Yamada
