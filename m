Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7232B65D07F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjADKRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjADKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:17:39 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA371E3D8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:17:36 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id v14so24056598qtq.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUwAn0nEqMKSXDK8OVReUF5AGlB7lvlwoglxNqDeTrQ=;
        b=G2UlY+vTZhbCEpEX4HUW7MJlwuVIWUWpTBrPoOZCOxkUIh+n6AOvrWwsAJLJlT+dFg
         gs+bDVCBvshnhFTHco5ehzQkmsUCsLrnVKd6v3Dn8A5xwGimi9gr7iaJPQXKomnduGj0
         OeVoeo7JBPZo2VIr0MFZTLOIyJTBIYZBxeHQhmKOmmD1siEp2HgbTQn/f/N3BE3ljzzz
         Cjl78UosNEypXhZKU59I9UijmvEru8EP04Q+gyVqogD0XPlYMK/SpElxQkGOfzcJ5lev
         gjXCxlmssHrKqVS+K6LOPgl1jxh866UxPRg0U0CSfzy/BkxXxtTvmImiv4ajESOgbF/e
         rWpg==
X-Gm-Message-State: AFqh2koIASkQnTKC0+uiuz7cq9RmGgUroB8N9GZ0xnU7SLc7Qvk+9YpB
        weELzSNWL1b6vvJfiOqVhqqNdgFLy0cshQ==
X-Google-Smtp-Source: AMrXdXuUpI06gPVrGGIJd04FSZaoAX2EZgqyPq0x9M78NaeC2O31u/I5ywwEHp4Ps5GlXfrWVl3xmQ==
X-Received: by 2002:ac8:60ce:0:b0:3a5:50c6:bdce with SMTP id i14-20020ac860ce000000b003a550c6bdcemr67003908qtm.47.1672827455567;
        Wed, 04 Jan 2023 02:17:35 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a445000b007023fc46b64sm11225384qkp.113.2023.01.04.02.17.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 02:17:35 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 186so35962912ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:17:34 -0800 (PST)
X-Received: by 2002:a25:aae1:0:b0:6fc:1c96:c9fe with SMTP id
 t88-20020a25aae1000000b006fc1c96c9femr6122796ybi.36.1672827454676; Wed, 04
 Jan 2023 02:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20230104081408.4074275-1-linmq006@gmail.com>
In-Reply-To: <20230104081408.4074275-1-linmq006@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Jan 2023 11:17:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAUX-nht=erTjycx617gDin8eiZRb55ry4idN37umPnQ@mail.gmail.com>
Message-ID: <CAMuHMdXAUX-nht=erTjycx617gDin8eiZRb55ry4idN37umPnQ@mail.gmail.com>
Subject: Re: [PATCH v2] um: vector: Fix memory leak in vector_config
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jan 4, 2023 at 9:18 AM Miaoqian Lin <linmq006@gmail.com> wrote:
> kstrdup() return newly allocated copy of the string.
> Call kfree() to release the memory when uml_parse_vector_ifspec() fails.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - only call kfree() when uml_parse_vector_ifspec() fails.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
