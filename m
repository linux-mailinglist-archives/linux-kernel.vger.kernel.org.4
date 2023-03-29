Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E56CD05C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjC2Cuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjC2Cuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:50:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F040185;
        Tue, 28 Mar 2023 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PhL1kNeyCbsXGb4SeDXDXhtAbmiDiUTVtDQLjcpbgL8=; b=ByPI8v16Mxms00CZNkxaxTLwIO
        f3WKuIpyJBAPiSfJQFGAjhpqxPHsQ12g1R8wnCwJOekk1EGd2y3kb+9gORn5UVS6YCFmiFKUQmXMr
        dp3/UmaROYiJWJvSYfKqhNvCFTa0ademCOy2+e1e03BaTkv4AO40044el+GHWYNXHB0TUTq8Dgm0m
        wNEWR3TLq76HO4bryuNbo9D9nTvwU/8fOw40T7nRi/6V6nTBfhQ4RLZMb6EH2BmC8o+O+E+pz3rDc
        e1YJ4YdU6zXgx+laFc5/4wVt4R/tiLdn2Ili/TwKa6idwFsMG2xSZgoyHffi5UyWJotJvVodjE4On
        c+rDosew==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phLtc-00GP4j-1Q;
        Wed, 29 Mar 2023 02:50:44 +0000
Date:   Tue, 28 Mar 2023 19:50:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZCOnhIiU2w2+Txxm@bombadil.infradead.org>
References: <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
 <ZB1p5zRp7rlGGuCP@kroah.com>
 <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
 <87h6uamdzw.fsf@esperi.org.uk>
 <ZB2zrHSzmi8FXABI@kroah.com>
 <ZB3mw4G8GdGwSP41@bombadil.infradead.org>
 <87tty6lbed.fsf@esperi.org.uk>
 <ZCGBfbZztfBpgIXf@kroah.com>
 <87355qnt27.fsf@esperi.org.uk>
 <87wn32m4sm.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn32m4sm.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick, you *need* something we *want* but the form requires work.
Removing the module license tag and all that other module boiler
plate from modules which cannot possibly be modules is obviously
welcomed. But there's a few issues, one of them is when we don't
have SPDX license pegged on files. We *all* want SPDX files properly
annotated on files. We *want* to automate the module license from
the SPDX tag.

It sounds hard but let's go for the long shot of striving to automate
the module license from the SPDX tags.

Let's break this down into a few steps that also benefit your goals:

1) Fix all all code which use the module license tag but cannot possibly
be modules to ensure they all have proper SPDX tags. This is a welcomed
effort.

2) Create an an association of existing module licenses from mod-objs object
lists.

3) Verify these make sense with us.

4) With that list we can then infer a module license from things which
*can* be modules.

The trick is today we use the module license *for* that inference,
however, look at the tristate, and see if you can add a POSSIBLE_MODULE
as I noted and hinted before. That get's you a module license
replacement. The final nail to all this is use that to replace all
module licenses and have this done automatically.

  Luis
