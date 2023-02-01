Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97C4686667
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjBANK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBANKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:10:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A35AD24;
        Wed,  1 Feb 2023 05:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 091E5B8216D;
        Wed,  1 Feb 2023 13:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B74C433D2;
        Wed,  1 Feb 2023 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257020;
        bh=tc5RBoAbPDHLWgGNDHVYQ5oSgfUdKxCbFnVps/wxie4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UZMCn7XhmKmIKs1F/7P6MY5WuyXP00B9jQCZx7cVZgAvXi46pdOdjreZ2A7vNgLyp
         LYb5RCHw2k6h+z8SLTWTuB4UPVFqAuOKiGTW1RGd8gfotohJraeHls6BLXIMnrYMuC
         SnY4Qt713d1MWomGAFzT+tKY1grlWdFO5Znqumdkn9FbRvH1DfMWR5CbndSFSuZMU0
         mlpUj7H28BKkw0he6MHGQd8L+7oyt7Uvym3uoU0xW/WeVvt/aZChJg2IoqgQoVGgPn
         UnoK1EfO2IKYYtQRJnjhWTfFG2la0tfwBz6z8bQIG3Ap0IVPU6QhZ+iQrU5NJyaGJm
         6i+44RdNaJ0KQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-169b190e1fdso2370290fac.4;
        Wed, 01 Feb 2023 05:10:20 -0800 (PST)
X-Gm-Message-State: AO0yUKVVOynk9XXZaRPMFp4iwSNkuWafhpz+ccTGWnvXdusylJqtGZ94
        xfzO7falXUHYVSidabjhGg4PmCJrUdibwmwtbgU=
X-Google-Smtp-Source: AK7set9eeuRXoEILC3ebTeGQ2zgxmbedtCw8W+83bajzWiiZmuqL7KutlJcZUJPpTpVBV5EX/6ZtjnQbDJh/8vvM3fQ=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr187472oaf.287.1675257019969; Wed, 01 Feb
 2023 05:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20230122141428.115372-1-masahiroy@kernel.org> <20230122141428.115372-7-masahiroy@kernel.org>
In-Reply-To: <20230122141428.115372-7-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Feb 2023 22:09:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNARHak6v_YGqwf-vohKZJx7nAc4jAzzCwhrvioboXVsFEQ@mail.gmail.com>
Message-ID: <CAK7LNARHak6v_YGqwf-vohKZJx7nAc4jAzzCwhrvioboXVsFEQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] kbuild: do not re-run setlocalversion for kernelrelease
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 11:14 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Revert:
>   - 7b8ea53d7f18 ("makefile: not need to regenerate kernel.release
>     file when make kernelrelease")
>
>   - 01ab17887f4c ("Makefile: "make kernelrelease" should show the
>     correct full kernel version")
>
> I think the original behavior was better - 'make kernelrelease' should
> print $(KERNELRELEASE) used in the last build, not the one that will
> be used in the next build. Therefore, it is an error if you run it in
> the pristine source tree.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



I locally got a question about this, and
on second thought, this might be annoying
because you need to build something to get kernelrelease.

I will drop this commit.




--
Best Regards
Masahiro Yamada
