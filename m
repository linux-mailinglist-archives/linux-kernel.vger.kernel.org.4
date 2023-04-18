Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589376E65B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjDRNUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDRNUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F7125B7;
        Tue, 18 Apr 2023 06:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1976634C6;
        Tue, 18 Apr 2023 13:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C74C433A8;
        Tue, 18 Apr 2023 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681824037;
        bh=Le15qIzyA/mY+IzjQpWhhnFQ+7le2f1lWEaMFgytmLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c8xLAmkHsW0nkFOtLrh4KvwqPUnhEusajMKpACR9nuj3twoW/V8YNROQsok5u2nKc
         KeGZeUWm/UzuqpHNB1EOBUpjJ5vD5KGEnONAvdeoohedaDIfLZaK9yvUrnZRlYmbw4
         0t/iII+Oq0MuAazZaM78bgQ0Pw3rmHAwJ8kX5nr1GG3FiiKTyqIkkFSFJgzRasZdzD
         vCZLveQXUOiZ9IrCrs9dDEBuOXuJrWIWsK3VDOYLtC/eTQQHORopKncJLiFleruiee
         Qo+elQzPXkUESOoiwDJ/mjWWtplej1OBZYyIlWGsQylNUtcXphQoOHo4ASzLUa42/L
         vQJmCFcjlsROA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-54c12009c30so564632627b3.9;
        Tue, 18 Apr 2023 06:20:37 -0700 (PDT)
X-Gm-Message-State: AAQBX9cqGHRSpa11Xq8BE7IqeIEY33xtq557g2IForSrSCXkxpGLEiCB
        f8PfgGW1ATzpU4EX5RKysufFTYnOr+22NaMSFw==
X-Google-Smtp-Source: AKy350a8yALkehpzCW88Q0oQmGRQSLLwBnO5deySk641wmLRpvvXPbtgYUISPzJM/0+Di1T6M1RxMnbDeIHHj+X38k8=
X-Received: by 2002:a81:c406:0:b0:54d:913b:c9e8 with SMTP id
 j6-20020a81c406000000b0054d913bc9e8mr11219324ywi.5.1681824036131; Tue, 18 Apr
 2023 06:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230413163353.3408208-1-arnd@kernel.org>
In-Reply-To: <20230413163353.3408208-1-arnd@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 18 Apr 2023 08:20:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ5V57OazJOWqgi52=FHJbdqp6c+_HhRGRJYKcBC8FqWw@mail.gmail.com>
Message-ID: <CAL_JsqJ5V57OazJOWqgi52=FHJbdqp6c+_HhRGRJYKcBC8FqWw@mail.gmail.com>
Subject: Re: [PATCH] of: move dummy of_device_get_match_data() helper
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:33=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The previous patch only moved the regular declaration but missed
> the inline function that is used with CONFIG_OF=3Dn:
>
> drivers/tty/serial/samsung_tty.c:2034:10: error: implicit declaration of =
function 'of_device_get_match_data' is invalid in C99 [-Werror,-Wimplicit-f=
unction-declaration]
>
> Fixes: f5a2dc751657 ("of: Move of_device_get_match_data() declaration")

Despite multiple reports and having fixed it, I still managed to apply
the wrong version of patch. Anyways, I already fixed it.

Rob
