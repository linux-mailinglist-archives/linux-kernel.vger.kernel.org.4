Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8968C996
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjBFWhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBFWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:37:08 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14768E065;
        Mon,  6 Feb 2023 14:37:05 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 5so4854211qtp.9;
        Mon, 06 Feb 2023 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOsvo1Wy7rEBzdeEtnpUfAafl2KXxjzL9FtW2ispnjA=;
        b=KU85o3MbVzoHlkVJzhppe87qpv+MKx9lyyDdf3URpIiYW2Zidjluq5+t4NqrkTLUBv
         BRl/cCx5UTdh3aUIwMxRLKf3K19OUGtgV5HFrKptL15UYJmmTGvHZi6n1tGBM6Vf7Qec
         Fv2CPnc+/XIvJmWxKMyYwgaTKiV0NvjpGqskadXDL55OTeZQWVisLyUct3nRPo0Kq+cz
         3t+AtT7cMBjD/SfOlG/cCwpZ41t9OHqLYe3AnL8skDCedkkVLY3cSzbQ/y1Nym/wuNGd
         /htZGYXMc15GtuW+cC7bkrX2Xh3bzxXSEw5FuC89ogwPJcdKxuVchUBDZKlyGTgv95hH
         uqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOsvo1Wy7rEBzdeEtnpUfAafl2KXxjzL9FtW2ispnjA=;
        b=w7fUaezWw9cspCHD/ry2dsEJLiAK0h1U1k6WOAW0wzcyNlVLXc+/2FGFeJhZ6mkU13
         p+cMnhBBxrcMSkJH+tixr5Hhg5MyXovOPiSn0vRjsOQVMjzI/6KcOUCGU4Qc2mYtuepn
         s1GTvvg4uwcTwvkZ35RSCMKdKP7TZMNDmE8AeSwAH72A9DwoCdy2NN9WJjMAs0v9ZJVH
         yx78FzWgGvwiw9WTKVo1Y8tj285uFY0Tv+HLwCDnxq95wfRKFamRxAGTsGGfxlkOnxSg
         1tcGi1RaWIO1BGAderKUrAT9kXiWgdXR7UBUj3A6nW6s1YvA+W6AL9ip+CyECKSOkls8
         Pc1Q==
X-Gm-Message-State: AO0yUKUqirSz/wykDMS7gKgWNc7j4Kp/I3QQYln8Gm1YCoAlupBMyoiI
        7jWbjtYVGj0a/wMo4DeoSwg=
X-Google-Smtp-Source: AK7set9txcfpHUlXwqrs8TNPgMT1nzGtwN0jT40D3fyWqV4erahgPF9QgZAv8Qf/7l444RGWli3bLw==
X-Received: by 2002:a05:622a:1101:b0:3a7:e9a2:4f4a with SMTP id e1-20020a05622a110100b003a7e9a24f4amr2153637qty.8.1675723024034;
        Mon, 06 Feb 2023 14:37:04 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 136-20020a370c8e000000b00706aeebe71csm8301291qkm.108.2023.02.06.14.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 14:37:02 -0800 (PST)
Message-ID: <177ee7b1-9954-be71-a1c0-024bed9902db@gmail.com>
Date:   Mon, 6 Feb 2023 14:36:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 10/22] mips/cpu: Make sure play_dead() doesn't return
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
References: <cover.1675461757.git.jpoimboe@kernel.org>
 <b131d3e00967034d86692b894a66c6a656e7de3f.1675461757.git.jpoimboe@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <b131d3e00967034d86692b894a66c6a656e7de3f.1675461757.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/23 14:05, Josh Poimboeuf wrote:
> play_dead() doesn't return.  Make that more explicit with a BUG().
> 
> BUG() is preferable to unreachable() because BUG() is a more explicit
> failure mode and avoids undefined behavior like falling off the edge of
> the function into whatever code happens to be next.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

