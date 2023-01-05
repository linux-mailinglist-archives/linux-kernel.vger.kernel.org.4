Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E301C65EED0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjAEOeq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Jan 2023 09:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjAEOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:20:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45A25C90B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5452861AB6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0856C433D2;
        Thu,  5 Jan 2023 14:20:20 +0000 (UTC)
Date:   Thu, 5 Jan 2023 09:20:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>
Subject: Re: [RFC PATCH 21/25] kvx: Add support for ftrace
Message-ID: <20230105092019.4bc166b6@gandalf.local.home>
In-Reply-To: <20230105135526.0fc5f250@fixe.home>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
        <20230103164359.24347-22-ysionneau@kalray.eu>
        <20230105135526.0fc5f250@fixe.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2023 13:55:26 +0100
Clément Léger <clement.leger@bootlin.com> wrote:

> > +/* The longest insns we check are for the far call: make + icall */
> > +#define MAX_SYLLABLES_TO_CHECK (KVX_INSN_MAKE_IMM64_SIZE + INSN_ICALL_SYLLABLE_SIZE)
> > +
> > +static int read_insns_and_check(u32 *insns, u8 insns_len, u32 *addr)
> > +{
> > +	u32 insns_read[MAX_SYLLABLES_TO_CHECK];
> > +	int syllables = insns_len / KVX_INSN_SYLLABLE_WIDTH;
> > +	int i;
> > +
> > +	if (syllables > MAX_SYLLABLES_TO_CHECK) {
> > +		pr_err("%s: shouldn't have more than %d syllables to check\n",
> > +		       __func__, MAX_SYLLABLES_TO_CHECK);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (kvx_insns_read(insns_read, insns_len, addr)) {
> > +		pr_err("%s: error when trying to read syllable\n", __func__);
> > +		return -EFAULT;
> > +	}
> > +
> > +	for (i = 0; i < syllables; i++) {
> > +		if (insns[i] != insns_read[i]) {
> > +			pr_err("%s: Instruction verification failed at PC 0x%lx\n",
> > +			       __func__,
> > +			       (unsigned long)addr + i * KVX_INSN_SYLLABLE_WIDTH);
> > +			pr_err("%s: \tExpect  0x%x\n", __func__, insns[i]);
> > +			pr_err("%s: \tRead    0x%x\n", __func__, insns_read[i]);
> > +			return -EFAULT;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}  
> 
> Hi Yann,
> 
> Is this still needed ? I'm guessing the instructions should always be
> correctly written no ? If not, something probably went horribly wrong ;)

I would definitely keep it. Code modifications can be quite fragile. Most
of the time things don't go wrong, but when they do, having these checks
makes it obvious to where the problem happened. Problems here is usually
some code mapping that got incorrectly flagged to be traced, when it
shouldn't be. Reporting these errors helps find what that was.

-- Steve


> 
> > +
> > +static int write_insns_and_check(u32 *insns, u8 insns_len, u32 *insn_addr)
> > +{
> > +	int ret;
> > +
> > +	ret = kvx_insns_write_nostop(insns, insns_len, insn_addr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Check that what have been written is correct. */
> > +	return read_insns_and_check(insns, insns_len, insn_addr);
> > +}
> > +
