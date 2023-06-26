Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28CA73EA74
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjFZStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjFZSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:49:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB7E75
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:49:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso3134955e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687805371; x=1690397371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv1/n2phfniMTR7fzfBDNm7NpHXtOa8amFqPDHD/r1s=;
        b=FoJxOakd/eofxqoI3pWxCqqJ4g5VlQBVkCL9LatQL05sO4bDQv1/YzQvC2dPwj4uzm
         lrZVp9DT4Roob5qxX0i2SjnVMPoD+y/vqDx/BfpAkKGZ1dCYb3ofb7Z/YbplHiILqZsn
         zuPcIPYGj07kGF55QuaMsriLSR03kg212kzLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687805371; x=1690397371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv1/n2phfniMTR7fzfBDNm7NpHXtOa8amFqPDHD/r1s=;
        b=M3tZFOLyvV43Fb66JYv+4qOWgyUJ/fP8ggHRgH4U+62iDQ7dJAWFq/7N9DVYkF2Yeq
         P5fmrGt4oQJhBZQz7eA8q9/hHaRa3IPBERXkM/Zy1FMAGQoBQyjD/nQ6IyauPbGffCcQ
         Vb9igl1IPisq1xOSady/pmY5ozQzzhllfLQH3E6MGIueDXR2ER68/JTSYrdBy83he1ii
         eAWLrAxJw1iDhQG6vuVPiuJg1ttmeAa4eKdkPb03lRHqKXcS8wQkVzH6Ihmce8ixaM0O
         RXKLuNL5hDVLfWSEjGd/6kQyrAkkC6BicFwnL8mQ65d6Z5icjLj0uxwCaphO0xzuwdI1
         P85w==
X-Gm-Message-State: AC+VfDwmLamTJFfwLHYmeRwb5j/dO4/qAk0CPm3Um1zh8DgIf3CY2vPo
        JBR8KUIOcP8+fmw15qb++7ucwSxi5EfBLeMmmqW1c7EM
X-Google-Smtp-Source: ACHHUZ6FtU4vS5i0mExRG2ivmwZU6dQf0yFtWseQByEMuTVUtjiobaPYCWrTbWy71jeBetM1INd0ow==
X-Received: by 2002:a05:6512:6c7:b0:4f9:5c04:af07 with SMTP id u7-20020a05651206c700b004f95c04af07mr11329139lff.26.1687805371293;
        Mon, 26 Jun 2023 11:49:31 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id l27-20020ac2555b000000b004fb75943ab3sm534583lfk.258.2023.06.26.11.49.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 11:49:31 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b699a2fe86so30917811fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:49:30 -0700 (PDT)
X-Received: by 2002:a2e:9898:0:b0:2b4:6456:4553 with SMTP id
 b24-20020a2e9898000000b002b464564553mr17200085ljj.47.1687805370152; Mon, 26
 Jun 2023 11:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687802358.git.dsterba@suse.com>
In-Reply-To: <cover.1687802358.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Jun 2023 11:49:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAxb2PQiAp5eKQmZd1=7DLA60O=+=Y3xcsvDa-N6Y+NA@mail.gmail.com>
Message-ID: <CAHk-=wgAxb2PQiAp5eKQmZd1=7DLA60O=+=Y3xcsvDa-N6Y+NA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.5
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, 26 Jun 2023 at 11:21, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.5

Ouch. I did this merge twice.

Your pull request only points to the branch. I didn't immediately
notice - my scripting only complains about non-kernel.org addresses -
but then after doing the merge I went "Hmm, I see no signature".

And then I noticed that you do have a for-6.5-tag that points to your
branch, you just didn't mention it in the pull request.

So then I re-did it all.

Can I ask you to be more careful in your pull request flow, and point
at the tag? I did notice eventually, and I'll go make my scripting
actually complain even about kernel.org pulls without signed tags so
that I'll notice earlier (and not just by mistake when I happen to
check later)

                Linus
