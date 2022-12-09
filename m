Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E58648282
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLIMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLIMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:42:57 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D251AF0E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 04:42:56 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id j16so3438607qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 04:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igBuNDpaHFuZEiBvHZ2c4/iSakohbRrwsz40HKIGNEA=;
        b=yZZBXbZxeZz5QZrL1Dt+BF4rJDeHdP6+MsHJiU+Jq7Kgdyhns9NGtYv82PhDfAB5b7
         o1L1h5aCpY6Kl6QWL5vQUcDCBzfj9Wv7dpj+GqW3+EM4r13+uqoo5EhpmjM41VVfTWho
         pQs/OiHYUdfi6exiEnxhQ1ME/h85omQJeRUbPtJQPcPPNOJRnbLd3XCd0/2j4scAEaPN
         8VMihd4/sNJpfFNVvZAEawyEKh/iTRPJqXqZhI7vpH6TK6dNctKCYl1nwcTNgN4fQ+Rt
         bvAgeXk2H5aIRUyOLZogd6PkidHEshj2c6Hzk7glLWx2Q9lBUZIJCnyPGnlwef5IgeOW
         xshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igBuNDpaHFuZEiBvHZ2c4/iSakohbRrwsz40HKIGNEA=;
        b=LVj9iNfVXAIFG7Ar6ZKA//GZAxJ3Yz0MuaYYAVmCHdNvMlxvWVG3TgeqUInSeooA+u
         SOy/XP6yNCKrB7Kyf5jUki9urfu9oB+MciYboA8OJUzF9uWksfh+e3MrxBo5Jq9DUJ4X
         5R0K8pZgBt9AA5ugqimTIl2K+NLFz4Dd4WUfRULw/Mmv0LINnHsRcaeOM8u9b3DgGHcD
         UGja3Sxa1/4NiRZUEVqPMKAlMZXESSLWY72exxTljERqyeTExcb0uPJ6+s5Sqc+yXzCg
         ln1ySZT1w9asGNLDZcKFDrI1liFQVVk2Y0Q+/BOhap9vUUIoYTeHr4apiP/KSDfeI0Pi
         LK+A==
X-Gm-Message-State: ANoB5pm47E/myEi7wOGpC5b4n49/fzjS2GsfQfhN6oZIApbCfhRh4t2n
        Yda28t143sUOXm3MMrw6VEIY
X-Google-Smtp-Source: AA0mqf7h3NrKKgZHoxcpultPrxTev9dn4y0DQnPSJpPUwiCdCUj+2QZZrVKFSHDsG7JKVvD1HYx8eA==
X-Received: by 2002:ac8:745:0:b0:3a8:325:47e with SMTP id k5-20020ac80745000000b003a80325047emr3161524qth.54.1670589775249;
        Fri, 09 Dec 2022 04:42:55 -0800 (PST)
Received: from bruce.bluespec.com ([38.70.11.69])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05620a458d00b006fa16fe93bbsm1051872qkb.15.2022.12.09.04.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 04:42:54 -0800 (PST)
Date:   Fri, 9 Dec 2022 07:42:52 -0500
From:   Darius Rad <darius@bluespec.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vineet Gupta <vineetg@rivosinc.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
Message-ID: <Y5MtTLtrDnCW6Dik@bruce.bluespec.com>
Mail-Followup-To: Florian Weimer <fweimer@redhat.com>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vineet Gupta <vineetg@rivosinc.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, greentime.hu@sifive.com,
        vincent.chen@sifive.com, andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
References: <b1dae947-d52a-d28e-5ddc-c1ad6d29828c@rivosinc.com>
 <mhng-84ad9495-ef4b-4343-89ee-dfe45ab69ff7@palmer-ri-x1c9>
 <CA++6G0D8RdjgvzQf-gMdakcF-Jj_PMjP=MBtAbSC0Qcu_WrTTQ@mail.gmail.com>
 <877cz0nbce.fsf@oldenburg.str.redhat.com>
 <Y5MoPdYimQtqQvkM@bruce.bluespec.com>
 <874ju4lpum.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874ju4lpum.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 01:32:33PM +0100, Florian Weimer via Libc-alpha wrote:
> * Darius Rad:
> 
> > On Fri, Dec 09, 2022 at 11:02:57AM +0100, Florian Weimer wrote:
> >> * Andrew Waterman:
> >> 
> >> > This suggests that ld.so, early-stage libc, or possibly both will need
> >> > to make this prctl() call, perhaps by parsing the ELF headers of the
> >> > binary and each library to determine if the V extension is used.
> >> 
> >> If the string functions use the V extension, it will be enabled
> >> unconditionally.  So I don't see why it's okay for libc to trigger this
> >> alleged UAPI change, when the kernel can't do it by default.
> >> 
> >
> > Because the call to enable can fail and userspace needs to deal with that.
> 
> Failure is usually indicated by an AT_HWCAP or AT_HWCAP2 bit remaining
> zero, or perhaps a special CPU register (although that is more unusual).

That would indicate that the extension is not present, which is one of, but
not the only way it can fail.

The vector extension relies on dynamically allocated memory in the kernel,
which can fail.

It also provides the opportunity for the kernel to deny access to the
vector extension, perhaps due to administrative policy or other future
mechanism.

// darius

