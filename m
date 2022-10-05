Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C35F5788
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJEP36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiJEP3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:29:50 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F07EE03;
        Wed,  5 Oct 2022 08:29:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 31721385;
        Wed,  5 Oct 2022 15:29:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 31721385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664983786; bh=fhWAv3XoJ4MKi2R/EsBnzcg48N1lTjy8sf1fdDB1rzg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Yflxwk16JAgvC0ItDDpzlPeOb7IoN4akI7urQVYJL3vCtS5riyOkNXUojjfB6cYsq
         wbxWoXmyj3F2Yy1nURLmwGUnIfZTfcMy/TA3pkYiax1uC0ieJoIFVFAZU6OQbvjICA
         zVrCJOYm5WY/25d2gAHQ+SC76ylrOGDAa4/kfB0r5L0qpCdyRquvzzP2whkkOK5gYZ
         kaeTw4DmMl8ruInK+y7vag1MIXKB2pUxF0UdFJbc9X2rxKkEqY4FCgcKtbqPBW/sHO
         hwd3JreqLR+2gS0uGUunue83dXXbm04B3kymQXx2Si5Kz9+uEfdoP6Pdcj4sCZLPYR
         ybCckH34l62dQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 5/5] docs: improve the HTML formatting of kerneldoc
 comments
In-Reply-To: <20221005065909.33ba2523@sal.lan>
References: <20221004201222.281845-1-corbet@lwn.net>
 <20221004201222.281845-6-corbet@lwn.net> <20221005065909.33ba2523@sal.lan>
Date:   Wed, 05 Oct 2022 09:29:45 -0600
Message-ID: <87tu4i9tli.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> Nitpick: you forgot to close the parenthesis on your comment ;-)

Hey, I gotta provide something for people to complain about :)

>> +    #
>> +    print ".. container:: kernelindent\n\n";
>
> I liked the new alignment: it makes easier to identify what belongs
> to each definition block.
>
> As I didn't test the patches, it sounds worth mentioning that it makes
> sense to check if this won't badly affect epub and/or LaTeX/PDF outputs.
>
> The LaTeX output generator in particular has a problem with long
> lines with fixed-width lines: if the text doesn't fit into one line, it
> either truncates it or makes the text go outside the margins.
>
> If the container affects the PDF outputs, we need to double-check if
> this would break its output.

The __container:: directive is pretty much defined as contributing a
<div> do the HTML output, so I do not expect problems.  That said, I've
not yet tested it, and clearly need to.

> Also, when the container directive was introduced? Does it affect
> the minimal Sphinx version we support? It seems that this was old
> enough to not require any changes at the minimal version, but,
> from https://www.sphinx-doc.org/en/master/changes.html, it seems
> that LaTeX support for it was added only at Sphinx v4.1 on this PR:
>
> 	https://github.com/sphinx-doc/sphinx/pull/9166
>
> So, we need to double-check if are there any changes before and after
> such version at the places container is used - or change the kerneldoc
> to only emit such tags on PDF depending on the Sphinx version.

I've tested things as far back as 2.4.5, where all is well.  I don't
currently have a machine that is capable of running earlier versions;
I'll need to conjure one of those up, I guess.

(Either that or just bite the bullet and move the minimum version
forward!)

Thanks,

jon
