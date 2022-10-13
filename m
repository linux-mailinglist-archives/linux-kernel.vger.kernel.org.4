Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89515FE197
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiJMSmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJMSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D38B6026
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665686360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ji+NyK6PnYbavkYjDFsnOf76oGImlagiYlW5om5fOkg=;
        b=Le56xPjTNc25BHyHgjI38C+RguFasI5URT+KV9mJaHGxFZ/a3Uf6yjgXFgoXGPCLYmP907
        AzYSkBQ3pjt/dV2DMZAgRwYe/xTW8UYGnqr9YuLr7TtuEkzujMQ40b5qbDeSWspsw2DZRT
        M3Y38kgExUf/pi1UaxgAFCFEdMlLWOs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-pgkOP4lWMnq5PGbJSSkoLg-1; Thu, 13 Oct 2022 14:39:17 -0400
X-MC-Unique: pgkOP4lWMnq5PGbJSSkoLg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1466D185A7A8;
        Thu, 13 Oct 2022 18:39:17 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E0AA40F16A;
        Thu, 13 Oct 2022 18:39:15 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
        <Y0gLyLbdOCetX5LN@sirena.org.uk> <Y0gteD0QYVlYxSZh@zx2c4.com>
Date:   Thu, 13 Oct 2022 20:39:13 +0200
In-Reply-To: <Y0gteD0QYVlYxSZh@zx2c4.com> (Jason A. Donenfeld's message of
        "Thu, 13 Oct 2022 09:23:36 -0600")
Message-ID: <87mt9zwotq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jason A. Donenfeld:

> It's also easy, nearly trivial, to download toolchains. Arnd provides a
> bunch with his crosstool. "Must use a toolchain from your distro" is a
> requirement that affects nobody.

But not everything will be built with the cross-compiler.  For the
kernel build tools and other userspace components, you'll need a native
toolchain that can build programs that can actually run on the build
host.  At the very least, this means that the right search paths have to
be baked into the tools, and I'm not sure this will happen automatically
for popular distributions.  (I only know that it wouldn't happen for
glibc, but you can't really rebuild that.)  This seems unexplored
territory to me.  The existence of working cross-tools doesn't tell us
much how native builds and integration with installed native libraries
will play out in practice.

There's also going to be much greater variance of compilers people
actually use if everyone just picks an upstream release branch snapshot
at some point in time.

None of this may be sufficient reason to support old toolchains.  But if
you require more recent versions, you really should tell people to
upgrade to new distributions, or use newer toolchain versions
specifically built for the distribution by their distribution vendor.
And not to try to build their own toolchain.


Thanks,
Florian

