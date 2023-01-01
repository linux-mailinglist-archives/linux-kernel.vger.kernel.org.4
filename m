Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F422265A941
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 08:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjAAHvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 02:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 02:51:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821B926DE
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 23:51:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F275760CFB
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 07:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44987C433EF;
        Sun,  1 Jan 2023 07:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672559499;
        bh=3KFyT2GsRXTISn1ehU/3Q5B8HYDCYRJool6Gn7EU9D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVT9XHrCCRKPJZGP6sAjWt6EvEQ7d1kqqDDFuy7bNW04V9rjD6sseH/WZ5ToWk2cG
         wIKk+DKsh4t8XgckLkvI8eDphNEwjuso1w0lMpKbPNsx4+RBZE9nKlbkMFhkrzEkcE
         0kqisJu7Tg5uj7AHJUK3OswAGgNeNNNtR/0jKdb7O1HODFYoGl2Lex/TPIcxUGGKqY
         IwvGfUxbaoqkIoj/yZYR32EYo9l/6qH2DSY+GkYqDoufD2v9wHxA1hpRwPhoXIt207
         K3JZJ6qxvUti+gZoBihublfnuCSEueC4EiRa+Na3ahvRnRrahKYRli6lxjfn8vlS7A
         ROMSRxcPVKbhQ==
Date:   Sun, 1 Jan 2023 09:51:24 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, x86@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: [PATCH] scripts/gdb: add mm introspection utils
Message-ID: <Y7E7fEBm6p0Q2djI@kernel.org>
References: <20221230163512.23736-1-dmitrii.bundin.a@gmail.com>
 <Y69E0diWostgY2pj@kernel.org>
 <CANXV_XzMVGHy5SP-2=QyO6YvpZAzLU4ZwFL3b8KOucr9rwkzhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXV_XzMVGHy5SP-2=QyO6YvpZAzLU4ZwFL3b8KOucr9rwkzhg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 08:14:30PM +0300, Dmitrii Bundin wrote:
> On Fri, Dec 30, 2022 at 11:07 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > The commit message does not mention it's x86-specific.
> > Not sure how gdb scripts handle per-arch functionality, but at the very
> > least this should be stated in the commit message.
> >
> Thanks for pointing this out. Will fix it. I put the command's code
> under the if utils.is_target_arch("x86") ... else
> gdb.GdbError("Virtual address translation is not supported for this
> arch") as it's done in other scripts and have plans to implement the
> same functionality for ARM in the foreseeable future.
> 
> > Any particular reason to make it ALL CAPS?
> Actually, no. Do you propose to reformat the output with a lower case?

I like lower case more :)

I'd also put the bit number first and would align the columns, e.g
something like:

    bit  0: entry present		: true
    bit  1: read/write access allowed	: true
    bit  2: user access allowed		: true
    bit  3: page level write through	: false
    bit  4: page level cache disabled	: false
    bit  5: entry has been accessed	: true
    bit  7: page size			: false
    bit 11: restart to ordinary		: false
    bit 63: execute disable		: true

-- 
Sincerely yours,
Mike.
