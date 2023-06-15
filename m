Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD987310F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbjFOHi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbjFOHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:38:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA1270E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:37:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8CAC2223B2;
        Thu, 15 Jun 2023 07:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686814612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/mNKNRzgrkQfqOq8GTGe9odKYtIpMuAwcvj9zeiuqgw=;
        b=Lu8WGmF85lTLuhf5Gyy3Yo5wo0x0osKeUw+ji8hm68oDiiHp8xzEYhzNjgUDvPAtNFtZbl
        L3OPxe2EWc76ocU3E6In49ZpwBYkPXtkFXkZAbwocmewhrLDCK1D5sPqHgpyqP2g1Zz5YH
        RpAiG7e/Wfd25vCKyWrMEEhvOwgTLBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686814612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/mNKNRzgrkQfqOq8GTGe9odKYtIpMuAwcvj9zeiuqgw=;
        b=vjBv/v3Z+RpYnN8Hx46rPshftjifDI2uhymBnnTN2V1ayq7u9EPO4luNWSHxWHwJ6wDf+j
        yD8RN6TIfRNYuVAQ==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 4A2322C141;
        Thu, 15 Jun 2023 07:36:51 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 38C684A037D; Thu, 15 Jun 2023 09:36:51 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        jszhang@kernel.org, ajones@ventanamicro.com,
        conor.dooley@microchip.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel
 module
In-Reply-To: <20230615072302.25638-1-nylon.chen@sifive.com> (Nylon Chen's
        message of "Thu, 15 Jun 2023 15:23:02 +0800")
References: <20230615072302.25638-1-nylon.chen@sifive.com>
X-Yow:  ...PENGUINS are floating by...
Date:   Thu, 15 Jun 2023 09:36:51 +0200
Message-ID: <mvm5y7p41nw.fsf@suse.de>
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

> Fix the 'unsupported relocation type' error caused by
> enabling the -fasynchronous-unwind-tables flag,
> which generates relocation types that are not supported.

arch/riscv/Makefile has
KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
