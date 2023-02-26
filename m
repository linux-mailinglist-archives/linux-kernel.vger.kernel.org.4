Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5DC6A2CF6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 02:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBZBmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 20:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBZBmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 20:42:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6879B2D62
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:42:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2805C60BA6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 01:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C2DC433A0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 01:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677375769;
        bh=evQtqprYp2YzoSjohCbMzh6BUpQ0pST41R4LboOjlmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G9yZ6QxremJYTZ0/uQyiFrR9KL2qD0k/RgbSfNDwDuZtltw0mmJTLQCIIjrg1kNLk
         5SnZvLc5DEBTVFDQBlcDhHspCp/SvKiqFVCC2wbZA6/abSD54XRF2qSdm71XQ2NrIf
         5GYcgXsyx6vGOQP6JQ7vf+eiEITLpZ1ROdI/qvBP7hJQJjl+JqO8nSpxIqCIi1zxpb
         RH6wzT2mySEwFMOU3QPO9ORNlxYPx9y1flHBWRUOLk/OCf2CrAcKhKOKhW3VBN5b7d
         +nCVr6Pg7bIGMxo4EaN014vnqNWd6kBnnCElAibBYPuk16NujQTvd5y+9g06ol3ff+
         rDLg3CrmlEJ4Q==
Received: by mail-ed1-f53.google.com with SMTP id d30so12288558eda.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:42:49 -0800 (PST)
X-Gm-Message-State: AO0yUKXDpp5sFYxiAPjlvSbbhrBYz0tjb2LPLoGxLcQolcnRknnXTq+9
        9ZEuTYqUF6RGHzPF5zB8xt96Qw6e29jkC5WGY/B/hw==
X-Google-Smtp-Source: AK7set+06E8/lgR4vi5ax3Z4E+4KAX8LwoMZDwzJy6deIDj1DixOwKIdDx6+jtAd2S7wpllbXTHl+wYvPx7xmZAlV7A=
X-Received: by 2002:a50:9fa8:0:b0:4ad:6052:ee90 with SMTP id
 c37-20020a509fa8000000b004ad6052ee90mr9628677edf.7.1677375767605; Sat, 25 Feb
 2023 17:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20230221184908.2349578-1-kpsingh@kernel.org> <20230221184908.2349578-2-kpsingh@kernel.org>
 <Y/d9qajJnR/ZcHvB@zn.tnic>
In-Reply-To: <Y/d9qajJnR/ZcHvB@zn.tnic>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sat, 25 Feb 2023 20:42:35 -0500
X-Gmail-Original-Message-ID: <CACYkzJ5=Ru1MvMWKHmfuHO-+nVPSgM8n3JSeCfFTvZgSFcmOmA@mail.gmail.com>
Message-ID: <CACYkzJ5=Ru1MvMWKHmfuHO-+nVPSgM8n3JSeCfFTvZgSFcmOmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation/hw-vuln: Document the interaction
 between IBRS and STIBP
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        jpoimboe@kernel.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        corbet@lwn.net, bp@suse.de, linyujun809@huawei.com,
        jmattson@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:52 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 21, 2023 at 07:49:08PM +0100, KP Singh wrote:
> > ... Consequently, STIBP needs to be explicitly
> > +   enabled to guard against cross-thread attacks in userspace.
>
> needs?
>
> That sounds like something the user needs to do. But we do it by
> default. Let's rephrase:
>
> "Systems which support enhanced IBRS (eIBRS) enable IBRS protections once at
> boot and they're automatically protected against Spectre v2 variant
> attacks, including cross-thread branch target injections on SMT systems
> (STIBP). IOW, eIBRS enables STIBP too.
>
> Legacy IBRS systems clear the IBRS bit on exit to userspace and
> therefore explicitly enable STIBP for that."

+   Systems which support enhanced IBRS (eIBRS) enable IBRS protection once at
+   boot, by setting the IBRS bit, and they're automatically protected against
+   Spectre v2 variant attacks, including cross-thread branch target injections
+   on SMT systems (STIBP). In other words, eIBRS enables STIBP too.
+
+   Legacy IBRS systems clear the IBRS bit on exit to userspace and
+   therefore explicitly enable STIBP for that


I did add one phrase, we really need to stress on the IBRS bit here.
Had we been enabling KERNEL_IBRS accidentally with eIBRS, it would
still mess things up as the bit being set is important.

This is why my original patch felt "obtuse" as it focused on
KERNEL_IBRS instead of IBRS or eIBRS :).


>
> Simple.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
