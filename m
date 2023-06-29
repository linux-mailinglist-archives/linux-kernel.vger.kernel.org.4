Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2297420EB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjF2HZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjF2HYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:24:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695BB10CF;
        Thu, 29 Jun 2023 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wns3r0TTkIooNvD1nufpc4D+UpqT9oVqnVmjgNsg158=; b=wk8f3Ib590Oy6Zk6oaPuaebYyp
        PNgub5jvZc2a2nGa/t8NRBfvMssafOLeHs4kGfPWvs7Es7yAkQvgR41CHKrI94CuSlpjWPBP8h8tT
        Qt/LS9G/p93aQX4C8FOU1IA/PGHNvtpqSpi67gZaq67CWG8UBy9mVTJuZ5gWd+u/nR9jQS6sBbPsW
        YTfgFAhLQF+dDuuoi1rPvZyI2XdG8diejw2UATw17JQsqNoXBEBhBD1FIWjdUs+lAqqaZw/AZYpMO
        eyN4dqglT4JM+ddzrBmkrjLDh8vmBi9X0Ic0V62roT8/JK37qLf7UPphIYrTTgBKqd8uhOgRA1Ov8
        d7OOFclg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEm0K-000CNP-22;
        Thu, 29 Jun 2023 07:23:48 +0000
Date:   Thu, 29 Jun 2023 00:23:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arne Welzel <arne.welzel@corelight.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        John Stultz <jstultz@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Marco Elver <elver@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Horman <simon.horman@corigine.com>,
        Song Liu <song@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] hardening updates for v6.5-rc1
Message-ID: <ZJ0xhCenJr+Dzs/8@infradead.org>
References: <202306271729.813C8788@keescook>
 <ZJvRFZeYq6ZWLAWj@infradead.org>
 <202306280920.CB69D0F75@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306280920.CB69D0F75@keescook>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:29:42AM -0700, Kees Cook wrote:
> > will be completely misued before we have a compiler actually supporting
> > available widely enough that we have it in the usual test bots.
> 
> How do you see it being misused? Your mention of the test bots, I think,
> means you're worried the annotations will go unchecked for valid syntax?

Exactly.

> FWIW, I've got builders with the GCC and Clang patches that should catch
> this.

Are we going to get them wired up for automatic checks somewhere?

