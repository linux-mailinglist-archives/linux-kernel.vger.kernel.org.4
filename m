Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9BA602EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJROjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiJROiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC8D7E28;
        Tue, 18 Oct 2022 07:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8534861587;
        Tue, 18 Oct 2022 14:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E374FC43140;
        Tue, 18 Oct 2022 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666103932;
        bh=mO+3YfEd7CFPsfy4iAyYaopzc+dReNXPT5+RUek7450=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ibm8S8g8XF47ujhZ0Tm02CueB4sq6GJNOY4w47jExwJdQijyWEO3PxsZDi3dipGeN
         eBwvzT9JTP5nJJu4SouMCAj47b+YrG5PnjyBib1DlQK04qmlTdEgZdZBpl3gDM16zK
         NW/E0AEgQn7kUaygf2Nhv0pCDEzihjo7hD5p2gmn1aIMVOA5k7S0hoVkmg3HLeS2ZC
         YQWvJF8478M8X3QcKpqp8Bp3q5sQNvqAv3aLcylvnQykj4jr+xQMqY9JNhQNAWbkvD
         vw+XAqcYnDUHfx2sbFHjmYfm4Apq/5z/iJM9iBjwPN53Y8WlWLqp31EPy5JvTyn0hG
         ErRdbcezqwsvQ==
Received: by mail-lf1-f41.google.com with SMTP id o12so14395553lfq.9;
        Tue, 18 Oct 2022 07:38:52 -0700 (PDT)
X-Gm-Message-State: ACrzQf2BNXe8cobL3o7yWp/1Ij1W0YjCAqJ77jLM+E6i59iPcy+WX9Wj
        FI+F739pkmqqIZHPFfrX/4nhoViBPcLcwc7Kj7U=
X-Google-Smtp-Source: AMsMyM503hANnruuWN4dlsslERqCgimDSRwovgrBuXxY2dal5SbxnKLqTuQyAoJ3cuK3c0Mp6v60xoLP82G/EVBcV1c=
X-Received: by 2002:a05:6512:314a:b0:4a2:d0b9:aa20 with SMTP id
 s10-20020a056512314a00b004a2d0b9aa20mr1262475lfi.110.1666103930868; Tue, 18
 Oct 2022 07:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221018020519.never.337-kees@kernel.org> <CAMj1kXGjF63wK7m8BqC=WX6sA425BTVwQWk9ERN3gG8s==4mjw@mail.gmail.com>
 <8d40dad4-4b20-2ec3-a8e1-706dd415f0d2@igalia.com>
In-Reply-To: <8d40dad4-4b20-2ec3-a8e1-706dd415f0d2@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 18 Oct 2022 16:38:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4D8fWV2hNa+R9-c_dLBCo37_qQjB2zBM2DvNG69oCxw@mail.gmail.com>
Message-ID: <CAMj1kXF4D8fWV2hNa+R9-c_dLBCo37_qQjB2zBM2DvNG69oCxw@mail.gmail.com>
Subject: Re: [PATCH 0/5] pstore: Use zstd directly by default for compression
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 at 16:11, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> On 18/10/2022 05:20, Ard Biesheuvel wrote:
> > [...]
> > So again, I suggest to simply drop this non-feature, and standardize
> > on either zlib or zstd using the library interface exclusively. If
> > someone present a compelling use case, we can always consider adding
> > it back in some form.
> >
> > As for the choice of algorithm, given the equal performance using the
> > default compression level, and the difference in code size, I don't
> > see why zstd should be preferred here. If anything, it only increases
> > the likelihood of hitting another error if we are panicking due to
> > some memory corruption issue.
>
> I think it's a good argument - would zlib be simpler in code than zstd?

I think it should be rather straight-forward. Note that this is what
we had before 2016 when all the 'features' were starting to get added.

> I've checked the zstd patch from Kees - not complex per se, but would be
> great if we could have a simple mechanism, without the need of the ifdef
> there for example...
>
> Cheers,
>
>
> Guilherme
