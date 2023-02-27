Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD486A47B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjB0RSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjB0RR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:17:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0966A7D;
        Mon, 27 Feb 2023 09:17:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6665360EC4;
        Mon, 27 Feb 2023 17:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC198C433EF;
        Mon, 27 Feb 2023 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677518273;
        bh=vafCIT6H1I4k0W6RFiw6dTjBQ+VyQHZVQ//gt0JC+fE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tpL0kByaUk37GU31DjSD6PYQ5VIEm52R2JBYCJ42CKOr0Mx8IMcRkjT+FV0C9PFkL
         o3VrN1WaeUs8pwiRzhHs3lBEr2X0pVk/e2ZkjbyQAyT3zFm1eIerisWDy6CufqMOOQ
         Y2oSJfM2O4rsIJf8k6wZk0xJOepi2qC6izBB5PKf9O8cSd3qQJN3KGXAVTRHUSWv1i
         T2gZpra1OhXI2M4Tj36OU0mzGFnTu/tTl5fXhKglfMhlS0qMwRqPSWP5hdot3Vp3Ig
         IvijMtuwjK5vdTcvH1omABXrWv/UfFJJH/XKP24T5Enhyt2E3Xk9DrOimRz86VOjcI
         alw+JW4KvjpZw==
Received: by mail-vs1-f42.google.com with SMTP id x14so12217039vso.9;
        Mon, 27 Feb 2023 09:17:53 -0800 (PST)
X-Gm-Message-State: AO0yUKUDPc6zPv+cZBJyVFM5cABd3GnqXWU12bn3guqr/+unTgZlrgRk
        qqkS8lcQQ6U6A/dCHFJwCrs/sTrR3sr61igIeQ==
X-Google-Smtp-Source: AK7set9NuVEKfi72PjX1EY+Wg3qJ8QkdMjcM1qKsL8dFIkVmkbYyZCYJNZ3p3Ep3WZ2ONWrRKwkBPb2l6lq/IeUGTy8=
X-Received: by 2002:ab0:53d5:0:b0:68a:5c52:7f2b with SMTP id
 l21-20020ab053d5000000b0068a5c527f2bmr10777056uaa.1.1677518272796; Mon, 27
 Feb 2023 09:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20230223213418.891942-1-frowand.list@gmail.com> <20230223213418.891942-2-frowand.list@gmail.com>
In-Reply-To: <20230223213418.891942-2-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Feb 2023 11:17:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLR9sm+GRU8EP4eO_Ln2UhD=ztdAU834CzP8RSv2s2jQg@mail.gmail.com>
Message-ID: <CAL_JsqLR9sm+GRU8EP4eO_Ln2UhD=ztdAU834CzP8RSv2s2jQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] of: create of_root if no dtb provided
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 3:34=E2=80=AFPM Frank Rowand <frowand.list@gmail.co=
m> wrote:
>
> When enabling CONFIG_OF on a platform where of_root is not populated by
> firmware, we end up without a root node. In order to apply overlays and
> create subnodes of the root node, we need one. Create this root node
> by unflattening an empty builtin dtb.
>
> If firmware provides a flattened device tree (FDT) then the FDT is
> unflattened via setup_arch().  Otherwise, setup_of() which is called
> immediately after setup_arch(), and will create the default root node
> if it does not exist.

Why do we need a hook after setup_arch() rather than an initcall?

Rob
