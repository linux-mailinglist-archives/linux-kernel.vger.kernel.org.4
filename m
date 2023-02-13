Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B2694BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjBMQEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjBMQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF051C585
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676304244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+3XeIGkgLxorQE2MKfz/0QshNsn2TACmyCRtPNykmc=;
        b=c0546usbhk94rsZ6ZkjdA/GlCtuy0hCYsAQLr+sBBBT1AjvmwY20wAAIRQnAPBNujr9yLB
        bYBddkVnlhyhlPxyFNMX4yPKs4NGJ63nS+xsBlBC/UEQ1hQkRVaI3/AGaaOq+UU41UVilw
        2MYBJFWP7WG048Qpa73yfEs7XdXEIOE=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-yOr3cIaRPa-_VEtv443xRw-1; Mon, 13 Feb 2023 11:04:03 -0500
X-MC-Unique: yOr3cIaRPa-_VEtv443xRw-1
Received: by mail-vk1-f198.google.com with SMTP id bq33-20020a056122232100b003ea473c36b3so4929687vkb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+3XeIGkgLxorQE2MKfz/0QshNsn2TACmyCRtPNykmc=;
        b=yevDk85LLjJfY1ol3ff5sygI3nn/PMgtHmKsoE9AXjzOmN7nPCv/yhCPjWEiMu3rrp
         xIHeoBxH+DB+8G2ZFL2XGAK4mygirHyWiyI1YEMTLwNg6Iln18sP0c3zwx3sOpTXT2fS
         rPJtLynyl0PLki0xndFudqe4Om8xbQ20SihpD3dbncHXlC0/ko+FdALDSECJaiRZJITp
         mF2yno7w+NPFXaz33GOC+92zUiOLImd25pm7aX+NwTc8Dji8BcmNss/bVIP7hyTg8RcG
         j0x8DoUI7sKxdXhmq7OAmZhzV2XiAINz+Y9t4Aj2c4V+begadNsb97kOjRscrXEawjT8
         jy1g==
X-Gm-Message-State: AO0yUKXw07ll1d5CStW4C1Mv1XtZNCPntWrv6M2O/L66u1WRioTXfTvC
        iFBhw0rZO2Kcpu8yxd9o4r6arg20DKoSf7vTJnBdp3yc6/e7fs1ptXdYSFmMukB+/S0CpeeLIKz
        twvVcIyC5ExfyUeNS/ew7AidyN5QaCMruG3Zp3vW1
X-Received: by 2002:a05:6102:3750:b0:411:bd2e:11ac with SMTP id u16-20020a056102375000b00411bd2e11acmr2920850vst.75.1676304242481;
        Mon, 13 Feb 2023 08:04:02 -0800 (PST)
X-Google-Smtp-Source: AK7set8f2Uc45pxarfLQxoAEndqNBof2SbJiNo6wh8cEftHeFujSHMV+bZPuLuaL05xaIESBdpPxqaZ9Sv0rQStmnOQ=
X-Received: by 2002:a05:6102:3750:b0:411:bd2e:11ac with SMTP id
 u16-20020a056102375000b00411bd2e11acmr2920835vst.75.1676304242260; Mon, 13
 Feb 2023 08:04:02 -0800 (PST)
MIME-Version: 1.0
References: <'CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com'>
 <20230213151339.661225-1-yakoyoku@gmail.com> <Y+pbtZUaRM+gkOUC@righiandr-XPS-13-7390>
In-Reply-To: <Y+pbtZUaRM+gkOUC@righiandr-XPS-13-7390>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 13 Feb 2023 16:03:46 +0000
Message-ID: <CAOgh=FySHZSceM_JKjSNX5qTXBSv3Kv3KP6yT27VXADt-_oB5w@mail.gmail.com>
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        miguel.ojeda.sandonis@gmail.com, alex.gaynor@gmail.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dxu@dxuuu.xyz,
        gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 at 15:48, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Mon, Feb 13, 2023 at 12:13:39PM -0300, Martin Rodriguez Reboredo wrote:
> > On Mon, Feb 13, 2023 at 1:19 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> > > On Fri, Feb 10, 2023 at 4:26 PM Andrea Righi <andrea.righi@canonical.com> wrote:
> > > >
> > > > nm can use "R" or "r" to show read-only data sections, but
> > > > scripts/is_rust_module.sh can only recognize "r", so with some versions
> > > > of binutils it can fail to detect if a module is a Rust module or not.
> > >
> > > Do you know which versions? If so, it would be nice to document it here.
> > >
> > > > Moreover, with this patch applied I can also relax the constraint of
> > > > "RUST depends on !DEBUG_INFO_BTF" and build a kernel with Rust and BTF
> > > > enabled at the same time (of course BTF generation is still skipped for
> > > > Rust modules).
> > >
> > > Even if that build succeeds, can you load the modules? i.e. the
> > > constraint was there due to
> > > https://github.com/Rust-for-Linux/linux/issues/735.
> >
> > Issue was that the kernel couldn't even load C modules, Rust CUs must be
> > skipped in vmlinux for it to work, and because of that the constraint
> > !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE [1] cannot be relaxed until
> > version 1.24+ of Pahole is the minimum requirement by the kernel. I'm OK
> > with this change but keep in mind that it won't remedy that condition.
> >
> > Link: https://lore.kernel.org/bpf/20230111152050.559334-1-yakoyoku@gmail.com/ [1]
>
> Oh yes, I'm using pahole 1.24, that's probably why it's all working for
> me. So we can't just drop !DEBUG_INFO_BTF, but we can definitely relax
> the constraint to "!DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE".

Yup the patch is ok, but we can only build with RUST and
DEBUG_INFO_BTF if we have pahole 1.24+ because that is the version
smart enough to exclude the Rust CUs.

If you have a version of pahole < 1.24 and you want to include RUST
you basically should not have DEBUG_INFO_BTF on at all because your
build will fail (unless this change alters the list of CUs passed to
pahole).

What is a little confusing is scripts/is_rust_module.sh and pahole
"--lang_exclude=rust" feature both attempt to do the same thing,
recognize and skip Rust CUs

>
> -Andrea
>

