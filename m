Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CA85F7AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJGPk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJGPky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:40:54 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECECB9799
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:40:52 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso5976480fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sVZhTxCn7nOjA8TUENpf4qgkei/TXKTV0i5yG057AbQ=;
        b=Pop33u2ithZ968mG/ueOeNioGNiCZvTmS6TR9+5Gl7yNKGE7N5/lsBHfrZkt+bVLMG
         ddBkeuMw3FC/iiZBcHOagiO5zhUeFu1XyD78wKQBCSGvceqFhYFFNFfp8L/2bkgMECrc
         xacqeZci3apuIdq8K1kDVdPVWFMLSYZLe3u6KCF4fogD/EPlW6/jnPtrzmUMdCFxtrTF
         j6B5H52a73qIuUHq2zUeM5j0Df0ba4jLTbEmP4D0OlTV0dkuAezH7MA0E6q1gqG8WPWz
         4VhLU2cws10ey7xVhzWUrkFlZy/jCdoWp+1zYDsP0D+Sb4+50U6GiC8I3aGP+70VhdDP
         omfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVZhTxCn7nOjA8TUENpf4qgkei/TXKTV0i5yG057AbQ=;
        b=gPkSe/+OTY4wWRJdjqnwUUjDNZfTjWjGVoJr/Nc5c0rB+RGNypbqxA6vy843aZnKGg
         Ez9gE6so8ajWPbFpImA2h5kglv7Sm0cpXIh0uKXufH+0k4oRA/nubIOaBeF6XD9K5agi
         UVPYHpLSuMUQV3G+64AYAEAOV+POeFEjoKh6mw2k751XJ4g4nAbTxl4g6MWMFjBFGOaz
         2CwNX9eVmv5kgfL5NDxMvvzTYlEEyjXIPRLjkC8y7oMpVYkCkmhUMwzMBKKIrMLBPB+/
         DP85waIEB0KhEP/QrZSMaou9Aowk6OKdGkEPDicEhZOPFD/tY5w+HNsqgUUJJP5RKwYc
         GKRw==
X-Gm-Message-State: ACrzQf1ZnV/Gtry3Z0NBFjqVJU1Ww5WE8MqsH2EbHh3u06TKqgXi25Eu
        A9H09Li9pcfrme+PFlna/kDbMjwZN4M1HyOxYg==
X-Google-Smtp-Source: AMsMyM7lyqmYhb3Fp6vPpxI96nj7XBIJr+zs6H9kA6gRrAoO1ksOGu+efsT9ZDbtWpamjMv+Olm02zQ23a1hXe4QzJo=
X-Received: by 2002:a05:6870:168c:b0:132:9664:f6d5 with SMTP id
 j12-20020a056870168c00b001329664f6d5mr2884124oae.243.1665157252324; Fri, 07
 Oct 2022 08:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-6-xin3.li@intel.com>
In-Reply-To: <20221006154041.13001-6-xin3.li@intel.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 7 Oct 2022 11:40:41 -0400
Message-ID: <CAMzpN2gYp0WXQYX1GHad3jCvoBBbO4yiEk_sJrfNUF1zGGapsg@mail.gmail.com>
Subject: Re: [PATCH 5/6] x86/gsseg: move load_gs_index() to its own header file
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
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

On Thu, Oct 6, 2022 at 12:13 PM Xin Li <xin3.li@intel.com> wrote:
>
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>
> <asm/cpufeature.h> depends on <asm/special_insns.h>, so in order to be
> able to use alternatives in native_load_gs_index(), factor it out into
> a separate header file.
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>

This could be moved into <asm/segment.h> instead of creating a new header file.

--
Brian Gerst
