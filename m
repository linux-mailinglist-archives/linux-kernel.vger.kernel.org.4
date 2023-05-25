Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA113710F44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbjEYPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjEYPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F5DA3;
        Thu, 25 May 2023 08:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4753161A59;
        Thu, 25 May 2023 15:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BA0C433D2;
        Thu, 25 May 2023 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685027687;
        bh=wsm0yTQA1FSDgNpqmnm5icREtePTqvY28hJDN18OJqU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ugZC+MiMjPuKfohaf4m+rSZ3crwoCNI5miBOXyJ6bGoQXrS8q65bXxhFjBcXhpDOn
         OI9j+CCCCvtDwb4RBlbO3ceqUbiZ3smMWxWTyxzq6BRTCdgbkQTbg8hkpWSJqQcg9t
         0yuOWwdHXalR8crWmvBLlW/96ZJz0PH2S/UFTjYhiaxocYF3YdvYfK6Z9hgWJ/Tyo6
         jZptdbmTE4328yWNQiE3ZSCdK03jA2m2NuzD5oCxHp93qLzmaSkpVLjEpym3Xl5Wn6
         uiya93O0uIup2DdsYopP7WqZrKCNa8+ck11QHrVsaTLPiKnX/5POkQyMiORcbzFo1C
         xVj8t8TkVslyA==
Date:   Thu, 25 May 2023 08:14:46 -0700
From:   Kees Cook <kees@kernel.org>
To:     Keerthana Kalyanasundaram <keerthanak@vmware.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Makhalov <amakhalov@vmware.com>,
        Ajay Kaher <akaher@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: =?US-ASCII?Q?Re=3A_PROBLEM=3A_Using_Randomize_structure_layout?= =?US-ASCII?Q?_GCC_plugin_doesn=27t_generate_proper_debuginfo?=
User-Agent: K-9 Mail for Android
In-Reply-To: <DF6066B2-35AE-40BE-A217-D3C48DBF6751@vmware.com>
References: <DF6066B2-35AE-40BE-A217-D3C48DBF6751@vmware.com>
Message-ID: <E226151B-FBAD-4FA2-B226-96231783D732@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 25, 2023 3:21:15 AM PDT, Keerthana Kalyanasundaram <keerthanak@vmwar=
e=2Ecom> wrote:
>Hello,
>
>I=E2=80=99m reporting this bug in randomize strcture layout plugin in GCC=
 plugins code of linux kernel tree=2E
>When I compile the kernel with randomize structure layout GCC plugin, the=
 resulting debuginfo does not have the randomised structures=2E
>
>To reproduce this, I have a C sample program and a script to compile the =
program with and without randomize_layout_plugin
>from linux kernel, the resulted debuginfo in both cases are same=2E Thoug=
h the plugin shuffles the structure members, the resulting debuginfo=20
>has unshuffled structure=2E
>
>I have found an old bug in GCC reporting the same https://gcc=2Egnu=2Eorg=
/bugzilla/show_bug=2Ecgi?id=3D84052 This bug has been closed as invalid tho=
ugh there was a conversation between PaX maintainers and GCC devs=2E
>
>I assume this issue has been there since the randomize_layout_plugin has =
been added in kernel=2E Please correct me if I=E2=80=99m wrong=2E

That's correct; it's a known issue with the plugin=2E (As you found with t=
he GCC bug report=2E)

>Please let me know, if you need more information=2E I hope you are able t=
o fix this issue=2E

I'm happy to take patches, but I'm unlikely to have time to figure this ou=
t myself=2E

If you want debug info and randstruct, I recommend switching to using Clan=
g to build the kernel, which has its implementation upstream:
https://docs=2Ekernel=2Eorg/kbuild/llvm=2Ehtml

-Kees



--=20
Kees Cook
