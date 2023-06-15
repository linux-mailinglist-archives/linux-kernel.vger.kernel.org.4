Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F232D731344
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFOJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245488AbjFOJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:11:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418631FE8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:11:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DBAE82189E;
        Thu, 15 Jun 2023 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686820309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjcdizOEFWmMO6xt7/fP21f8bxNsubkeN1M9YVs3Uy8=;
        b=KhI4HW/OBeYkha3aAqTXigt/inAF1d7dCGQnkw3H5HDm3fYiynwA6/TqG2VPclvfgG3We5
        Cz9/f8B3DcPId1cUgD9V3lfPxO0Nmh+/EHfxZ6V9VwaNfaxgy0jAJTFuzO0FPlRceehGY3
        PHN6I7q+ezScnR5Im7GAyrke0+rWWdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686820309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjcdizOEFWmMO6xt7/fP21f8bxNsubkeN1M9YVs3Uy8=;
        b=p9O3Y2znZuj/32VZHJUBbjweXNIg+jNHag/4ZErWSkYLRjYIxhjfJw25CjTrAHGMs2e8ji
        RiPw/but4qaxJNDQ==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id B216B2C141;
        Thu, 15 Jun 2023 09:11:49 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id A367C4A037D; Thu, 15 Jun 2023 11:11:49 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        jszhang@kernel.org, ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel
 module
In-Reply-To: <20230615084310.GA780@hsinchu15> (Nylon Chen's message of "Thu,
        15 Jun 2023 16:43:11 +0800")
References: <20230615072302.25638-1-nylon.chen@sifive.com>
        <20230615-unvisited-deceit-9beab8ce987a@wendy>
        <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
        <20230615-luxurious-rewire-84ff9d639fea@wendy>
        <20230615084310.GA780@hsinchu15>
X-Yow:  Not enough people play SKEE-BALL..  They're always thinking about
 COCAINE or and ALIEN BEINGS!!
Date:   Thu, 15 Jun 2023 11:11:49 +0200
Message-ID: <mvmo7lh2ip6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 15 2023, Nylon Chen wrote:

> Because LLVM currently has it enabled by default(https://reviews.llvm.org/D145164), it will generate this
> relocation type.
>
>>From what I know, GCC will also enable it in the future.

That's why the kernel explicitly disables it.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
