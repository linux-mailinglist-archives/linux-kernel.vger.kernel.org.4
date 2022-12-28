Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6329657256
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiL1DdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiL1Dc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:32:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDCE635B;
        Tue, 27 Dec 2022 19:32:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19969612E8;
        Wed, 28 Dec 2022 03:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5C2C433EF;
        Wed, 28 Dec 2022 03:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672198376;
        bh=bc+s+NbQoL95udEHZ4Axbwh4eI0R3gw4cmHickwG5nE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=OH0Lyt6+n6l25DKimmA9JD3OXpI2oBTwGv8S45TDcXtmj1INpaG/92riGhvA2uqOP
         Fh5jmHd/wyKaiUkmrkOzqxfiqC1xnx2GZCmFvg/kIjNCBY22/W0xtXfUwhM7VzTqa/
         KmaQFpc6wEJisymhk1dhLvZVGY21VCtSTezLoNV8+kiY0p39cVb9j5WmQuE9wWqBCX
         0iIFqgv7JQehIwPrjV91VhoFYzQhlTrATOGre4OuH9N/ccn5ebfS8FNLTaZPTI9TGK
         hYtjjsQ8NxeH6RlZdMW9ylIJpBtEBwQ9sWkARHwE3I/ad1lEC9Rvm1BF+jIQd7ps6o
         JkMs24OYDECMQ==
Date:   Tue, 27 Dec 2022 19:32:55 -0800
From:   Kees Cook <kees@kernel.org>
To:     Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Kees Cook <keescook@chromium.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
User-Agent: K-9 Mail for Android
In-Reply-To: <20221227234000.jgosvixx7eahqb3z@begin>
References: <20221022182828.give.717-kees@kernel.org> <20221022182949.2684794-2-keescook@chromium.org> <20221227234000.jgosvixx7eahqb3z@begin>
Message-ID: <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 27, 2022 3:40:00 PM PST, Samuel Thibault <samuel=2Ethibault@aqu=
ilenet=2Efr> wrote:
>Hello,
>
>Kees Cook, le sam=2E 22 oct=2E 2022 11:29:49 -0700, a ecrit:
>> TIOCSTI continues its long history of being used in privilege escalatio=
n
>> attacks[1]=2E Prior attempts to provide a mechanism to disable this hav=
e
>> devolved into discussions around creating full-blown LSMs to provide
>> arbitrary ioctl filtering, which is hugely over-engineered -- only
>> TIOCSTI is being used this way=2E 3 years ago OpenBSD entirely removed
>> TIOCSTI[2], Android has had it filtered for longer[3], and the tools th=
at
>> had historically used TIOCSTI either do not need it, are not commonly
>> built with it, or have had its use removed=2E
>
>No=2E The Brltty screen reader entirely relies on TIOCSTI to be able to
>support input from various Braille devices=2E Please make sure to keep
>TIOCSTI enabled by default, otherwise some people would just completely
>lose their usual way of simply typing on Linux=2E

Yup, it remains default enabled:

> [=2E=2E=2E]
>> +config LEGACY_TIOCSTI
>> +	bool "Allow legacy TIOCSTI usage"
>> +	default y
>> +	help
>> +	  Historically the kernel has allowed TIOCSTI, which will push
>> +	  characters into a controlling TTY=2E This continues to be used
>> +	  as a malicious privilege escalation mechanism, and provides no
>> +	  meaningful real-world utility any more=2E
>
>Yes it does=2E

Can you send a patch to adjust this language?

Also, what does FreeBSD use for screen readers?

-Kees


--=20
Kees Cook
