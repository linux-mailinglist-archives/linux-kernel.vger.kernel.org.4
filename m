Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006FE65BCB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjACJDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjACJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:03:13 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAA3DFE2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:03:12 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so18749278oto.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poZkD94G6LXE4+Lm/TBono3GS6hWH1AHLJnWJtULzYM=;
        b=m9S5Lbx0LlMgu/t2wt8MY6H98PxDcM7jv5rWuWK83sABbX4goFg1Pgqt4cxvB8ZL2R
         mQF3tNTLnCm4xWczGx7Ky0n9JFzBteVBTVYhqVQtqYltJUIKUdoGrcftyZD6eI35OjV3
         18b7f+fWeJLOuL6Ky/PTRk+qRzEyyPnnt/AAUYY2+erKrLa8XRXTvJARLY6cKGNEZVzE
         O7T4VreloHR9N3YuRLgLzgBFeJVkGipSbVj6182UT0xx5zOpIJWgYq+eOvRyLTIN//JK
         2/x8lwEJnKHYKux47VCqRlogU5gPnbhUiBuUinKEcarTNsHVMDQ88aUOTYSASMjH1pvo
         y01A==
X-Gm-Message-State: AFqh2ko55Jh3ZukUrXXqKEJ1rX0dtj/d39mFCDkM2UZ9giOCAqv1Gwc/
        zpafDvZMQ5jRlyi1D/dc+GIWNWiAtnN4EQ==
X-Google-Smtp-Source: AMrXdXuYlC6CFo797LvMOUz+sNQab6p89VGVIUc3f0k2stSPVBQWCTIid8OD/MdhX0VNQwIZBewz5w==
X-Received: by 2002:a9d:4d0e:0:b0:66c:2b60:9077 with SMTP id n14-20020a9d4d0e000000b0066c2b609077mr31224869otf.24.1672736591135;
        Tue, 03 Jan 2023 01:03:11 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id l10-20020a056830334a00b0066eb4e9242esm14550591ott.67.2023.01.03.01.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:03:11 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so13823901otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:03:10 -0800 (PST)
X-Received: by 2002:a25:aae1:0:b0:6fc:1c96:c9fe with SMTP id
 t88-20020a25aae1000000b006fc1c96c9femr5618399ybi.36.1672736107872; Tue, 03
 Jan 2023 00:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20221228161915.13194-1-samuel@sholland.org> <20221228161915.13194-3-samuel@sholland.org>
In-Reply-To: <20221228161915.13194-3-samuel@sholland.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jan 2023 09:54:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXx3MZBHdeD3HrTx0740CF48+7j70NvFmVsJBOePJbbXQ@mail.gmail.com>
Message-ID: <CAMuHMdXx3MZBHdeD3HrTx0740CF48+7j70NvFmVsJBOePJbbXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: sbi: Share the code for unsupported extension warnings
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangmeng <tangmeng@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 5:19 PM Samuel Holland <samuel@sholland.org> wrote:
> This reduces the code size by sharing most of the code and the format
> string across all affected extensions.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
