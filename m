Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEB263B41F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiK1VZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiK1VZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:25:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F610FC3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:25:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9541861444
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A81C433C1;
        Mon, 28 Nov 2022 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669670708;
        bh=QyQpbwM2iq85jti+16w+BD2y4rt2SNKwSui5E1/hDn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TeyaG5xSCqGoBcMxGdJVXaYX9gTvfiBYpCWqbUvBWZDwOhvlQZjfAGtKTIFbgU7Uz
         SLJurDKduRbrTfvQcZEWdqqC0UUHnX+IfIf3f/s81car5ggtb8byW+unQ8TOD2zO4n
         ggBHD4p3q6t7IMbaueLdXvFpMQS4zLJq5KWNFjNg=
Date:   Mon, 28 Nov 2022 13:25:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Sam James <sam@gentoo.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] Add missing <linux/string.h> include for strcmp.
Message-Id: <20221128132507.98fab35cba20ce3f81810fcc@linux-foundation.org>
In-Reply-To: <A222B1E6-69B8-4085-AD1B-27BDB72CA971@goldelico.com>
References: <A222B1E6-69B8-4085-AD1B-27BDB72CA971@goldelico.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 18:15:55 +0100 "H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> starting with v6.1-rc7 I can't build my tree any more:
> 
>   HOSTCC  scripts/mod/modpost.o - due to target missing
> In file included from include/linux/string.h:5,
>                  from scripts/mod/../../include/linux/license.h:5,
>                  from scripts/mod/modpost.c:24:
> include/linux/compiler.h:246:10: fatal error: asm/rwonce.h: No such file or directory
>   246 | #include <asm/rwonce.h>
>       |          ^~~~~~~~~~~~~~
> compilation terminated.
> 
> Bisect did show your patch as the first bad one:
> 
> commit 50c697215a8c "Add missing <linux/string.h> include for strcmp."
> 
> Reverting it makes compile succeed.

Thanks.  I queued a reversion patch.
