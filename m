Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE673FC28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjF0Ms4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjF0Msi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:48:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E20D2715
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:48:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa99b57a38so20143415e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687870115; x=1690462115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3Hsnn9nuU1IAVV480V8WkPLNcto+coQLL0W/NX/3l4=;
        b=HY/XVe/dNSo1WrR0FefuOTZsftkbYl7EcD9kxoeRrcaUuwmx6FUKtsKV5TijKBJG4E
         RWhPXjagWrM5LGXb9Q+/Nlp/yBb0NM5p4pQKF/YC3ZylyEeJPIJkjO+aKyl4Q6UUm/0q
         qziKG8O7OWOAdYwkYBG3MHIWorzWXSxDvpYI2G67VZJExX38vTbkcn67dUu8XedIlMR8
         T5pw9sN8wDibHfE6QNrYgwIVaC+zvivXzBoX5VnduF+ufOPHpAwI2awnKHYYAOND7dQR
         Rix/zbasqYnMYMPKMoYVU6c57owGRiksAygrMVSRk111YWP6a+yd02/OSXV0xk+ECXv9
         juUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870115; x=1690462115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3Hsnn9nuU1IAVV480V8WkPLNcto+coQLL0W/NX/3l4=;
        b=cJGgZNdvlYKKDH/vb7CTPsYw54mxmU23j/JVEEU4XUZBDL48bFpGoKt2/NEVC54BCD
         eD9JN8YC8OiWWT/Wg8XbxjYSYq/X5rVAvrKnOzcNO4LRbSMfROe/CnKjCWKjH0Xs/O8z
         4jIzVlCdO5m8FqxNYGKvQV3jUvJ/8inAYAmSh5TzkZ7jXQKjIsbueprQYvbIXwl6fnHK
         NgDZl7L1+h2aIwaAXhPtWiGn4drmOYM1xcp9Fi95O1K+vZXJQ2kxk7rIFOJT3xVTo3zq
         W78orIqIg1S2VKKluhuPxun8eWtWf8lc9/jZrCXJVvkkkJpZ4DVqQ16t0cuF85HtvI9U
         q/Sw==
X-Gm-Message-State: AC+VfDxBalU35J2o1YBMfnY772cRylPHSe0eKJmGJiFHAYOYMh0c4u5S
        beyPHD/LXftd9NwU2L8+kWgVsFocA23jIStRzt5D1ZtTyIfhjJH1J7g=
X-Google-Smtp-Source: ACHHUZ6nKZ+xQGjQwNL7vnuwPY6tOwDsgDays8fdMVGu+tdaqNLmk9FvUTfPykneltWt+BEhWkZQqF/Msdt+uBKn0ds=
X-Received: by 2002:adf:d0c8:0:b0:314:4db:e0b1 with SMTP id
 z8-20020adfd0c8000000b0031404dbe0b1mr95543wrh.11.1687870115369; Tue, 27 Jun
 2023 05:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230620202824.380313-1-russell.h.weight@intel.com>
 <ZJfB9zXhizbqmIrm@yilunxu-OptiPlex-7050> <c5c95368-eac3-4250-b50a-50f0a526b753@sirena.org.uk>
 <CAEP57O-EsrW0KgSDDnDDEYrvL-SEtO-Ji6oShNzvP3y0o9AqCw@mail.gmail.com>
 <ZJpZJhostb4G1UMt@yilunxu-OptiPlex-7050> <4fac60f2-ae53-4735-a847-6ebd3e824c61@sirena.org.uk>
In-Reply-To: <4fac60f2-ae53-4735-a847-6ebd3e824c61@sirena.org.uk>
From:   Jim Wylder <jwylder@google.com>
Date:   Tue, 27 Jun 2023 07:48:24 -0500
Message-ID: <CAEP57O8M8Tzq1rFuw6eoEsrqvJ2TXDzpKK_dcGbU1-2UfAOy9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
To:     Mark Brown <broonie@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 6:58=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Jun 27, 2023 at 11:36:06AM +0800, Xu Yilun wrote:
>
> > I'm a bit prefer to exclude the reg addr, as it is in stable tree now
> > and doesn't see strong reason to change it. And suggest regmap-i2c does
> > the same as spi do, that is to reserve space for reg addr/padding by
> > reducing the max_raw_read/write value, see:
>
> It seems better to keep things like this in the core since every time a
> bus has to open code something that's something that the bus can get
> wrong, as we've seen here.  This would mean some churn now but going
> forwards it'd be less error prone.

Agreed.
