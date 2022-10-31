Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7216138F1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiJaO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJaO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:27:11 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F0E0B4;
        Mon, 31 Oct 2022 07:27:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 62CF5734;
        Mon, 31 Oct 2022 14:27:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 62CF5734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1667226427; bh=ruopkUMYYycAQwlBJGAP3mIbG5nq4ZRRWPHqbOezbK8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o6ULFpKJO6ni66t4SFraBGUPzuCEiYT4TL7QVwp0Y52vkcSECFFrCFAg16n0iJypu
         BXajC7u/i1fje2yBq7y77edQcjwW9Wqtd5knVYMSRzftFaIYl9Er6CQgtGS7pWwcJV
         m2mlDAHcEcdkYm7m2ZTLNwy8+SOsEdG1JUsm8DrczQENdA2hqqThTdAAZtydvLaDlR
         bF5YE/XETryKytSikM/iKoP9nvjHdkZUzGfqGbU3yu2x80KWL5kwRJP3OFpLBexz+D
         4h3MNQFoYuC8ZT53ecvdunQzs0vmSP/PN2yTPxvrRS6TInYkEecqV8BWGV12+bPL2H
         iQk9FuPzIIISA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the jc_docs tree
In-Reply-To: <20221031170537.722220c4@canb.auug.org.au>
References: <20221031170537.722220c4@canb.auug.org.au>
Date:   Mon, 31 Oct 2022 08:27:06 -0600
Message-ID: <87a65c3w79.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> After merging the jc_docs tree, today's linux-next build (htmldocs)
> produced these warnings:
>
> Documentation/core-api/timekeeping.rst:16: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:26.
> Declaration is '.. c:function:: ktime_t ktime_get(void)'.

[...]

> Presumably introduced by commit
>
>   d24c911bd031 ("docs/zh_CN: core-api: Add timekeeping Chinese translation")
>
> but I have no idea why :-(

"Why" is the ".. c:function::" definitions in core-api/timekeeping.rst.
The translation duplicated those, leading to the warnings you mention.
I should have caught that, but the old (fast!) version of sphinx I used
to check things doesn't put out that warning.  I'm just going to have to
be more patient, I guess.

I've reverted the commit in question.  I'm not sure what the best
practice should be for translating documents with those declarations in
them.  Perhaps the function prototype should just go into a literal
block without the c:function declaration?

Thanks,

jon
