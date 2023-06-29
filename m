Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5770742BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjF2STE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjF2SSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:18:44 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 11:18:40 PDT
Received: from resqmta-c1p-023465.sys.comcast.net (resqmta-c1p-023465.sys.comcast.net [IPv6:2001:558:fd00:56::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9E2D7F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:18:40 -0700 (PDT)
Received: from resomta-c1p-023412.sys.comcast.net ([96.102.18.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resqmta-c1p-023465.sys.comcast.net with ESMTP
        id Etl0quD2IVh3YEwBdqOqUG; Thu, 29 Jun 2023 18:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1688062569;
        bh=mWTnVt9e/Fb+ASjag2lt89PvPdIMQDGYRRlGDqMbUnQ=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=pmHmw2UrXerHlMVVHS8RNplB07FJvicNrMb5gXUgcVoWaY3sF97pdeNHe4bmXn5rZ
         xVOhKZCoepk50mP1gvjTR1VcVLxzuTIQb7I7ruGXSz4H06HVMMcetTJLQpd+aiODIL
         ansOg1wPygUXsS6gY/iixusPCfF9Jxn3QdnPxjCuzJCdJj1BCfshd99V7vZYvB7gRp
         CF2JWh5d/nED2tJ9fTV0S68QdodTJXMQPauvmyJqoYYd7RsOA9Vfg4Ixo5V3M2LPYc
         rSdYwAre0TPdQta1A6m/Bla3bTa7N5rMfpDUD4oKqBNCOaIpOPvdIr3hgRpldQV8yk
         WyexuLGjyNenA==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-c1p-023412.sys.comcast.net with ESMTPSA
        id EwBWqLftphq3SEwBXq8dQY; Thu, 29 Jun 2023 18:16:07 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     David Howells <dhowells@redhat.com>
Cc:     <netdev@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@kvack.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
Date:   Thu, 29 Jun 2023 14:16:02 -0400
MIME-Version: 1.0
Message-ID: <7d33f8a7-eb75-4a0d-bb10-aa4ab497c016@mattwhitlock.name>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MIME_QP_LONG_LINE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 29 June 2023 11:54:29 EDT, David Howells wrote:
> Matt Whitlock, Matthew Wilcox and Dave Chinner are of the opinion that data=

> in the pipe must not be seen to change and that if it does, this is a bug.
> Apart from in one specific instance (vmsplice() with SPLICE_F_GIFT), the
> manual pages agree with them.  I'm more inclined to adjust the
> documentation since the behaviour we have has been that way since 2005, I
> think.

Anecdotally, my use case had been working fine for years until I upgraded=20
from 5.15.x to 6.1.x in February of this year. That's when my backups=20
started being corrupted. I only noticed when I was trying to restore a lost=20=

file from backup earlier this week.
