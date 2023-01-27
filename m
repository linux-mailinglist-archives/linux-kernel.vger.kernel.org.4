Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC167ECE9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjA0R7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjA0R7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:59:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400B80029
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:58:59 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fl24so4021976wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4/3pp0HtNFhDGsx2C/KQB+H4Bh6uN2vy4tMssC8orA=;
        b=QxKKB9s46hophXakrt/hDNgI5V23ayIGQVuMDVyYv60I1k/sJ6jhP1maC+4IiGRxgp
         lQShEzXuxbIAvd7iXsWanMUdEYbnISFnsOWbC6VJskcs3PHRIb5Bf9r2uhYWIRm74Dzw
         tdueKlrFFv/CBNwrnGc9iwrKzvaGXrTrzC3CJwyiVYkMaqonAl7MynZaO1hj9gvEWkcI
         QmoWVbniUi8zkgp2oD0qUVpE9Q3E/Byw7o+wYhGcJIUP/K/2u89673w4WJpL/0cWrQUe
         UTn+3+j99wPBjMZFsnDZa8o80zQMLYWbeBq/TaAS54kVNt5cEXd2n/b6xjpMnkkDI6JT
         Gtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4/3pp0HtNFhDGsx2C/KQB+H4Bh6uN2vy4tMssC8orA=;
        b=amsQC3nAQKc2HN/Z2oWsAiTzYA/TH0C/p8WX/8xbXw1ow71UWZlCzZ7ZN0JoPxC6XA
         Z4UBI09+kOqWJ57ZzgAGly2CRiwNqpkNI8QZnNZVf7LmsOFelswwvPyuIyYXSSkaUi8X
         ptZNgCdS7FHCOHdGjPIDpaH1/jrtXB9aHmIJlvBCeBId/WpC0fcSAGOjTRArb9slHCZl
         UchCJVEO/HC0yWZOTXYNSibIUTSjxlrqUayyseDkeDlCATEWjY6yqmUYGxCYvz3oGOjT
         gj++R41m04rXnrs8AjJFs7NgBAFH+hUZIhFhUKP0Fo9AZ00rtEft/+N2qPoi6dWY6WqG
         PSWg==
X-Gm-Message-State: AFqh2krezLeenBh27xgUmoNgZOfGj8aF4QwIuj93am6UrO8Aiey2JG/s
        b6S7c8yO1e/IiwE3QOd7vLo=
X-Google-Smtp-Source: AMrXdXvNTPwj4cemkaOMxVKHEhwQGm4HuykOww+mQpA07rnd2kqZWmX31ukrCrdwsHUUU6ClEmdUpQ==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5b:5f73 with SMTP id c12-20020a05600c0a4c00b003dc0d5b5f73mr14881327wmq.19.1674842337893;
        Fri, 27 Jan 2023 09:58:57 -0800 (PST)
Received: from suse.localnet (host-82-60-215-65.retail.telecomitalia.it. [82.60.215.65])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c069200b003db305bece4sm4888766wmn.45.2023.01.27.09.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:58:57 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Date:   Fri, 27 Jan 2023 18:58:55 +0100
Message-ID: <1920277.PYKUYFuaPT@suse>
In-Reply-To: <Y9LdmUw8TkoJOWvM@casper.infradead.org>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <Y9LdmUw8TkoJOWvM@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 26 gennaio 2023 21:07:53 CET Matthew Wilcox wrote:
> On Thu, Jan 26, 2023 at 03:33:46PM +0100, Fabio M. De Francesco wrote:
> > If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> > calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> > address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> > proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> > address in order to fix this issue. Consensus has been reached on this
> > solution.
> >=20
> > Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
> > kunmap_flush_on_unmap() on an aligned-down to page address computed with
> > the PTR_ALIGN_DOWN() macro.
>=20
> You missed a spot.  Sent the version I've had in my tree for a few days.

I'm sorry for missing the other call site.
=46urthermore, your patch has a better commit message.=20

However, I'm also sorry because I would have expected a different kind of=20
support from you. My patch could have been improved with v2.

Anyway, I assume that you missed that I had asked you and Al if anybody wer=
e=20
interested in doing these changes and probably you missed also that Ira=20
encouraged me to send a patch, whereas you did not show any interest...
https://lore.kernel.org/lkml/3146373.5fSG56mABF@suse/

=46abio

P.S.: Helge wrote to me privately but you cannot know it.


