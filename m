Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4207694A87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjBMPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjBMPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:13:47 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E34FC173;
        Mon, 13 Feb 2023 07:13:46 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id cz14so10425729oib.12;
        Mon, 13 Feb 2023 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGmJRYZjuyKGnRHpGVizxnrzjN+7Vw2t02eSzRstU5Q=;
        b=PNMLrT9zqA8YoihoJQong+odBSNSFgl2TbQXdC1LARkW4QkK5O5Yr7jmQzWSmkiCWq
         entTpI4XVsFz2ZyauJ3MUKVDjejrjLNvHUJFwxwMh0G2Duha+/0pIorH5FcCTarKXR7L
         7BXomvOwsUNuJSDuklDtMguMsMzKkHEFssH8Mxm/lJqRrTWb/fLxf5UIbHsr+2/der/Z
         YRJqKootI55ekPNdw72g8GvzpOpPJ5IsdLwxk2Abp06uTEJu6cOMAuBTW/8Be8c8CX7H
         RhMwdymTfcS8sxOjogGJFdgPl26DJkszUJo+zD13XBIgbF79jlAQ8ejPNJAo8IyecNcv
         vBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGmJRYZjuyKGnRHpGVizxnrzjN+7Vw2t02eSzRstU5Q=;
        b=QLwDACmm2wC1n8L0Hy8Na2ki+3/FzpeFGL3VpIKGIFdLgm6tBX3RwQxwhOppAA8fbB
         jSmHlqLJ5yf3+TaX+MfaQ+1X6qX0Pk44qLLih3+omGv4tulOwP9kFQJ1ENJioADRMIoL
         ZuY0lZVzAWarfpN+MsfOZLsGdrfvlPafww25sfBQGPhOS2s5p1ng9etuev3duwBkkLOO
         z+FJlVlhsIRQTiESt7dwv5IYqj+JMfHcIjCXT9M30V1LRpJWImUV6fZtAZ69fNEW1gNr
         1wWUhRIprzn5/3TcOSn6UaZpZc1LUW0qYHxmGdlb0S7WMT7abGByTmdk5okb6Ul3mDms
         0RaQ==
X-Gm-Message-State: AO0yUKWKLpdmuQyrJIFlCFePxGb9YTQylGt0qemR0fY/NYbzLUHp2eRs
        l2Oajqb1nnEr2cjqMSuwOS0=
X-Google-Smtp-Source: AK7set98LUGd1uv6XZJTm/wzQDt4BWCFoOioSzKmjlDdwSMhgE3nLVQ9r3PGshQrbekZWCRV7zt04w==
X-Received: by 2002:aca:d0f:0:b0:364:443a:96c3 with SMTP id 15-20020aca0d0f000000b00364443a96c3mr13468625oin.22.1676301225515;
        Mon, 13 Feb 2023 07:13:45 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id s82-20020acac255000000b003785a948b27sm1258952oif.16.2023.02.13.07.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:13:45 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     alex.gaynor@gmail.com, andrea.righi@canonical.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dxu@dxuuu.xyz,
        ecurtin@redhat.com, gary@garyguo.net, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com, yakoyoku@gmail.com
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
Date:   Mon, 13 Feb 2023 12:13:39 -0300
Message-Id: <20230213151339.661225-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <'CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com'>
References: <'CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com'>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 1:19 PM Miguel Ojeda <ojeda@kernel.org> wrote:=0D
> On Fri, Feb 10, 2023 at 4:26 PM Andrea Righi <andrea.righi@canonical.com>=
 wrote:=0D
> >=0D
> > nm can use "R" or "r" to show read-only data sections, but=0D
> > scripts/is_rust_module.sh can only recognize "r", so with some versions=
=0D
> > of binutils it can fail to detect if a module is a Rust module or not.=
=0D
>=0D
> Do you know which versions? If so, it would be nice to document it here.=
=0D
>=0D
> > Moreover, with this patch applied I can also relax the constraint of=0D
> > "RUST depends on !DEBUG_INFO_BTF" and build a kernel with Rust and BTF=
=0D
> > enabled at the same time (of course BTF generation is still skipped for=
=0D
> > Rust modules).=0D
>=0D
> Even if that build succeeds, can you load the modules? i.e. the=0D
> constraint was there due to=0D
> https://github.com/Rust-for-Linux/linux/issues/735.=0D
=0D
Issue was that the kernel couldn't even load C modules, Rust CUs must be=0D
skipped in vmlinux for it to work, and because of that the constraint=0D
!DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE [1] cannot be relaxed until=0D
version 1.24+ of Pahole is the minimum requirement by the kernel. I'm OK=0D
with this change but keep in mind that it won't remedy that condition.=0D
=0D
Link: https://lore.kernel.org/bpf/20230111152050.559334-1-yakoyoku@gmail.co=
m/ [1]=0D
