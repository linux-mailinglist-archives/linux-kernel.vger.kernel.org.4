Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3166AB5C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjANMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 07:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjANMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:30:01 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67A68A4E;
        Sat, 14 Jan 2023 04:29:59 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p188so25393525yba.5;
        Sat, 14 Jan 2023 04:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=faXJuelmEPQHepNci7Jyq7Zd60hd8EQZYiBQ3z2kjyM=;
        b=Mv4WwHts0zZ87qmpPESPpNVuOiak+8Mi8GHbbqSVveqBLufVJi3hJtRm1kLVm7e5oX
         Dxl76OkqbtpLZvqZXqMe2wQ2CQ4Ssivnpmjau27M6b1c8xOWANkI7c+Fxb+C6ESEhWCm
         yBZqKxlrJUkyyykLu6l1E8R2m5xDyx3UkddmrfOF0TJ+pX2nsOWJ8199rSliNeiOsA+t
         My4PtdGYHcb+fHmUelhtuTPlIoZxoApmg4xvmWU7B/aLVO30I0OYEOIkAUYMvEobJjqm
         1Vmu7YpKa9V1oCr/0X0E420H8mkQMyPTKEdgMLfQFss17nKNcsUJ0kWrf1+CmTXN0Ec2
         A+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faXJuelmEPQHepNci7Jyq7Zd60hd8EQZYiBQ3z2kjyM=;
        b=QKHwLMp6/hHEJc+bZuNwEvwjzOCqz2M9qJibx3z/YrOry1/dha+8bTma4SJBNr/M8Q
         pr177gWGkPogJKCgzvjRzI7AZsgfBjchcxr+JNcXzqxh1SDCAFLEkK0Z1r8eLZ6lrqKf
         9uavSkBhyJaNli44yW1SZk+bWq2ECEhhqQsXk36+pxvSy9PN5noitpWVYXuU9WGpF6U7
         B4dKY+JYGMAAsVR/4BI4dzPbleX2t1dqC8SABWx/oewLYKQjWrezoG+Gm3jBkIbn2/BW
         fv2i0ichCfIucGdOrcuyzAyBpslihacRHm6222J4sXnGHbnbpkixDRf+rToh9Ft048Kv
         OUGA==
X-Gm-Message-State: AFqh2krgmI2ULZwAQPy0WIP4m6JBweIL1+GV9UGIejyRj/nC4+fGvCUZ
        LjYO9MNi93Xjjp6UWS8+/cIBlBLdApaOylzbFDGZZs/hTfjOHJgNdZ4=
X-Google-Smtp-Source: AMrXdXtTAEe2Q9D7PS3afx+B9DMLHW/45KNCK72GApiDL/C7HrWhTH7bnh91qr/0KBqaxTnUVjQyS8i7xRfk0HqaLmA=
X-Received: by 2002:a25:7e84:0:b0:7cd:5175:cb53 with SMTP id
 z126-20020a257e84000000b007cd5175cb53mr519452ybc.581.1673699399206; Sat, 14
 Jan 2023 04:29:59 -0800 (PST)
MIME-Version: 1.0
References: <202212272003.rgQDX8DQ-lkp@intel.com> <Y6r4mXz5NS0+HVXo@zn.tnic>
 <CANiq72kc60aPcx5LwFhOGL4AXOhZsZj32iOg75K5ZxLaaRaYkg@mail.gmail.com>
 <Y7i1h3lCMKfxB532@zn.tnic> <CANiq72khMLU6tF8vGD9fs7mLNAAQu8wJ2n1SLM3th2QMMfGPPA@mail.gmail.com>
 <Y8Ax/I5qOcVDZljG@zn.tnic> <20230114021835.06749ef7.gary@garyguo.net>
In-Reply-To: <20230114021835.06749ef7.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 13:29:48 +0100
Message-ID: <CANiq72=ZPTiiG-8+TjBdpi1tP=3+JfLsO7JRR-F-UOqF4Awf_Q@mail.gmail.com>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
To:     Gary Guo <gary@garyguo.net>
Cc:     Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Yujie Liu <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 3:19 AM Gary Guo <gary@garyguo.net> wrote:
>
> This is a definitely a bindgen bug. I'll have a think about how to fix
> it...

Added your PR to the list at
https://github.com/Rust-for-Linux/linux/issues/353, thanks Gary!

Cheers,
Miguel
