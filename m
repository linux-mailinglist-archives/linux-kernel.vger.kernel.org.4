Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1154674548F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 06:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGCEfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 00:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGCEfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 00:35:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F131AC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 21:34:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso62265581fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688358893; x=1690950893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=goxlq+XMoSpGyBcMFz56BQhM9ko0AvyeslUGkC2zPCk=;
        b=hh32aAd+TkkqfTRB5rL7ub828DV77gPvSUzd/UszVmY80b35nhH5iNcGMrUwrD/Mve
         Df3yXoEVHJ2H9LfTZsm3bJsLuIYVna2+XGdjW2tWODcnkVNc+i1+c0L4tVkrdSmC+ZuI
         mMVBlQwLQb7B78JJo9oYXllAjvvCuS001VIXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688358893; x=1690950893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goxlq+XMoSpGyBcMFz56BQhM9ko0AvyeslUGkC2zPCk=;
        b=VZ3ODYD4FP40SX9LK3wSdY9jrsO4K+t1k4UKLGUDOk2PkLeLGvpksPcmm6OGwvScGb
         YfLA9xQbXaFzXyitmC41OH/umOQsz43GobRf1arpPdM0773JlyqL0VdgV3YNgKWmfAh1
         R0VC1vTH1O0RyusGIo30v3smGX+RS6PZ/p3DaZcoVW3b2yhja8SXo+hdWQCL8Mb4JZ8w
         me7S8h36QOT/G/IKJ431xKSsZwKbtuNO564Fi4261Dkv8RVVrVvjDdbvlHXlo2wmJXQB
         jqlyWsrVlRqxwH/zrA0VI8ch+T+UQuuGdFzTGEfUIhKLAMhP65valeLnspDe3Av2sV9h
         7/xg==
X-Gm-Message-State: ABy/qLbhbBURckeOMCcmTlzXE9S29l6ZegQuoDzzmB1C3UtXlOhRp1KG
        xHerCAD5mg9LiFGa8kgGwTB0XlmwhTHwXIYFgPuU5KOr
X-Google-Smtp-Source: APBJJlGvUigZpOv45OqaFX0FKRVSmDXxjdXR2zvAvv4WykajJExg/D7euetH4o21eGP/IVqNpOB8eg==
X-Received: by 2002:a2e:b058:0:b0:2b5:8cfd:5223 with SMTP id d24-20020a2eb058000000b002b58cfd5223mr5594446ljl.32.1688358893525;
        Sun, 02 Jul 2023 21:34:53 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id v1-20020a056402184100b0050488d1d376sm9885235edy.0.2023.07.02.21.34.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 21:34:52 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51d88f1c476so4417719a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 21:34:52 -0700 (PDT)
X-Received: by 2002:aa7:c912:0:b0:51a:216e:7df9 with SMTP id
 b18-20020aa7c912000000b0051a216e7df9mr6539213edt.30.1688358892255; Sun, 02
 Jul 2023 21:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
In-Reply-To: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jul 2023 21:34:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
Message-ID: <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
To:     lkp <oliver.sang@intel.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 at 19:04, kernel test robot <oliver.sang@intel.com> wrote:
>
> commit: 408579cd627a15bd703fe3eeb8485fd02726e9d3 ("mm: Update do_vmi_align_munmap() return semantics")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [  215.088258][    T1] WARNING: suspicious RCU usage

I think the

        validate_mm(mm);

call (mm/mmap.c:2561) needs to be moved up to before the

        if (unlock)
                mmap_read_unlock(mm);

that is just a couple of lines earlier.

Can you verify that that fixes the warning?

                 Linus
