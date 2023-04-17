Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6F6E5525
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjDQX2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQX2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:28:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D114206;
        Mon, 17 Apr 2023 16:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x6Tb/1glyhIgb9nFztTGyypXkQWVb4VZNHeMA+wudDc=; b=KI1+KRymhMaN6X70SEyNbfDIZX
        zH8iLtOL+9UykrysNI8mtYWACgJ7L3lraWhTvETp8KOFgxL1U7HujV28lGhKU4Rf39ihJgTU9dCGf
        W9DO9lIA0cHm+czSPICUPWPL3Ql6o+UqA+j6F9PH0rXM0h7FpGREUa30S16H5ETRQwfDouacv2LPw
        GM1ER4buMSudkrBZ3cxoL/GlZ1K4r/rj8umNk6ni/jpVWYyJKnJ597fKbgFMKr9H8h2oKiTLsqqf5
        2Ewns7V87D7wT9Z26Mh2zpmS5BvuYb/+JLPs2khNdZ2uUqF6M0E5kpADpr+N5MwT8aK3r2e2/MPT+
        47pEw0Ig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poYGe-000P1R-0u;
        Mon, 17 Apr 2023 23:28:16 +0000
Date:   Mon, 17 Apr 2023 16:28:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Viktor Malik <vmalik@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Song Liu <song@kernel.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] module: fix building stats for 32-bit targets
Message-ID: <ZD3WEDSlsg+ki3Ie@bombadil.infradead.org>
References: <20230417220254.3215576-1-arnd@kernel.org>
 <20230417220254.3215576-2-arnd@kernel.org>
 <ZD3E+AYPzq/EO2Gs@bombadil.infradead.org>
 <cd9d08ea-ffa5-4932-b296-7a58203ef701@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9d08ea-ffa5-4932-b296-7a58203ef701@app.fastmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:49:29AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 18, 2023, at 00:15, Luis Chamberlain wrote:
> > On Tue, Apr 18, 2023 at 12:02:47AM +0200, Arnd Bergmann wrote:
> >> I have no idea if there is a risk of these variables actually
> >> overflowing 'long' on 32-bit machines. If they provably can't, it
> >> would be better to do the opposite patch.
> >
> > I had originally used atomic64_t and added a debugfs knob for it but
> > Linus had advised against it because its not a stat we care too much
> > on 32-bit and atomic64 is nasty on 32-bit [0].
> >
> > So I went with atomic_long and the cast becuase we're just reading.
> > 
> > Is there a way to fix this without doing the fully jump? If not oh well.
> 
> I've sent a v2 now that does it the other way round, which is
> clearly much more efficient. Have only done minimal build testing
> so far, but it passes the randconfigs that failed before.

Thanks! You're too fast.

  Luis
