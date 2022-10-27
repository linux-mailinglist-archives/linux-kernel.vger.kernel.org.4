Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3364460F6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiJ0MCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiJ0MCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:02:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0442A7A779;
        Thu, 27 Oct 2022 05:02:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m15so2258384edb.13;
        Thu, 27 Oct 2022 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nae3MTaQSLKYtpB9ujJglOZE8cA0/GC19l2/IFTBBNc=;
        b=DBs6mLPPobcb3ZQ9TGha9oXMaB+EXK6Bf4FwHAy1XNUBiSwzxRAHTw7ec+jcTYB41N
         PmUi7EQy4fwD1oo7GPcHR/LmK8IM9DEqT94ekRQCbdLwDST8LWjjOV33ZyILzkOWi8E9
         CeqrQTeqqmXZt4G44iwRhCvOF3xqte9n2utdWvjfA9tmWH5dRFnK+EutKMY3yoqXg0TA
         spPEaUWYMTpm1HfWuM1LoustamNC6SPkL/0BIQIWmOIkhk5ZEizN0w76K0KSPYk5F1i5
         m2vE2w5ROP3tntMvj8w5wei75d2bOOcMGY1SFC7NzgnYJlgADqc+U2zNfS59GbAyOTaM
         H+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nae3MTaQSLKYtpB9ujJglOZE8cA0/GC19l2/IFTBBNc=;
        b=E2Y/EaOsMS96TD4rnyKhqenchrzg4uCIcHAmofvBFpPlQjLsgShkyB+GEyf18bQVlI
         vArTjwoAZiO6wMbOgLOYoDv+ZyzHna3cQIHECZD3VdfR0uaiC6PngNcg/CVuS1ZX2j7d
         ip1WFl4q/iO60Ju7Rb/THwRCo/Z9KVBLpqH1l2DGCMlE/POuDBK2A8ivwSjnlpC3MgyJ
         Sk9aIxyz6/wonMWJomjYs+AeaynbaAWPH7an7maeNxPmlGP5e6GVqMKMHT8NnWV9h0hz
         VM7b3f2+G1ZELI55aj5D2q37nroskYPXxJtkOeMpj0YDUrEy8S9miuViIuzzBoZkNByE
         xxIg==
X-Gm-Message-State: ACrzQf1UcxpC7ltpsdL7V/L97PzMk2WJRh+i+O/3CiwDewS5qLvp2qMy
        Awy7xs515Eal8vAgnaQzHOUibR+qxNjEk6SMc9gzMkK468sTRu+4
X-Google-Smtp-Source: AMsMyM4EvkA5Xahm06ht/ZKpqzZTCPn07pdZDlFCtL/quOxAJxUSAVS95eNwvCzgaTflYdChjCVVftaeGqRq2wsDWDY=
X-Received: by 2002:a05:6402:26cf:b0:45d:48d7:928e with SMTP id
 x15-20020a05640226cf00b0045d48d7928emr43709300edd.275.1666872138527; Thu, 27
 Oct 2022 05:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com>
In-Reply-To: <Y1pphVPw0J97AmW4@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 27 Oct 2022 13:01:52 +0100
Message-ID: <CA+V-a8szaPjwumrBgOT9gzMKBjY7hk0zfP8RgzUUDfY+BAsogA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] media: i2c: ov5645: Use runtime PM
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, Oct 27, 2022 at 12:20 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> One more comment.
>
> On Fri, Oct 14, 2022 at 07:34:56PM +0100, Prabhakar wrote:
> > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> >
> >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> >
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_get_noresume(dev);
> > +     pm_runtime_enable(dev);
>
> You won't gain anything by eanbling runtime PM here. Just move it to the
> end of the function before the rest of the calls. Error handling becomes
> more simple.
>
If I move the above calls below I get the below warning:

[    2.633386] ov5645 0-003c: Runtime PM usage count underflow!

This is because of the last patch which moves ov5645_entity_init_cfg()
before registering the subdev. ov5645_entity_init_cfg() calls s_ctrl
due to which we are seeing the above message. Please let me know how
to proceed on this.

Cheers,
Prabhakar
