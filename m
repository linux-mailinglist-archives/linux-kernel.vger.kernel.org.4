Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B717311C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbjFOIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244222AbjFOIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:07:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B535D1A1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:07:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7239622384;
        Thu, 15 Jun 2023 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686816462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mP4cVRtg1Zot55n0E8/s57K6td9e+eRW0Qf0nPD1Puw=;
        b=BVHS5z7riMfLlFWJBxKJqLBmf89d1jTwJx+4T8dCuEmV7DQb+ZeKILBUIfUhB3S0yUr8oY
        1g33oCoV4gG6iEM8qP9bQ8pbW/Pv70eHExTt+Oc3SbOqKd0vDdIXdfs9nRaJyf5DgQ7exb
        mEpX3Js72X8/uECyoIezrCo9VJw79+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686816462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mP4cVRtg1Zot55n0E8/s57K6td9e+eRW0Qf0nPD1Puw=;
        b=8gtEFc3JYefULzfkiyeMTf+PGnyUpEtqxxUpIYO8Z6dyye8tCwUlgTUi/IH6mCgeOB9/jN
        EOE4SoIJ2rFtwVDw==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 4F3212C141;
        Thu, 15 Jun 2023 08:07:42 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 411914A037D; Thu, 15 Jun 2023 10:07:42 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        jszhang@kernel.org, ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel
 module
In-Reply-To: <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
        (Nylon Chen's message of "Thu, 15 Jun 2023 15:52:27 +0800")
References: <20230615072302.25638-1-nylon.chen@sifive.com>
        <20230615-unvisited-deceit-9beab8ce987a@wendy>
        <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
X-Yow:  I'll eat ANYTHING that's BRIGHT BLUE!!
Date:   Thu, 15 Jun 2023 10:07:42 +0200
Message-ID: <mvmwn052lo1.fsf@suse.de>
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

> I mean, when we use the flag "-fasynchronous-unwind-tables,"

Why?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
