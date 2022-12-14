Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E2A64D203
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLNV4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLNV4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:56:21 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C921A24091
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:56:20 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f9so2909854pgf.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5hphzZuwvE1cfu805fma1OCvsgxMuaC9NASC7Ut/QdA=;
        b=fRK1cUQxtzyxu17lkIrP0FYGhQYBUq5yMOg/cLC+bCQ1aczzSMDw6nmPJKPz4+0HYJ
         cDJP2+Yq5EpOtxcsOq1fZGvs5FkHrpS3xNgGMFdy/bqhRULat5ESZYVIO1gHnnyIHaJL
         zbZjZgANyXFoDIwDT5mN+b7Ul0r9Y9MsGP/uX+aOHsMv4MBbgRNEOkYXzww2I3/ESevJ
         FfnZIdXFI2T240RX71ShlJHakFFXfY2qYKhcXd6ElSBqESzwlpAw6RDXq05WrTIIt9xb
         rKXh8627SrYN9+UwFUTr6Vrh7vLqaV7SQNc6q/TxqdPKpDryo8KrXUmCUg9uQoDVG2YR
         jGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hphzZuwvE1cfu805fma1OCvsgxMuaC9NASC7Ut/QdA=;
        b=i6OeAByD5BFwpg9Bg6CqiUJWnS279bzpsibCafsXue31JxovlqSVdrDt9AJJlZGX9K
         PpewErr6Wy8iTA2ztD84IHR0jZO0fWUOfu4D5PCzXIscoUy1wPxj3Er9dx0tex6V4qZG
         sfScHdQIbyUy+j3UwPQzfl02nOFuivuyGRAHnDQ5yN/gHeIwHBQOWrNHDon3YIPZ1x4S
         3M94woYiQAbJSCUQCSKpeA8UUYPO6CyWSeOJxu5uEtwGuKCcEJzRhjOOw8DFlf4G+n54
         XeChwUry4MXuDOgnV6lBpMzokuNDZoirka+ZyZGWgkMH7c7ddBUiTuVms9ZA1NClFLK1
         4etQ==
X-Gm-Message-State: ANoB5pnXeLMMQdhyilRAelGNgYhmGq2gDqSISvqWSey3B1nBQ14M5BEO
        HauwZXOvfE4j0BVYlJoc9XTKFGd9mZU2vpxZc/Mbaw==
X-Google-Smtp-Source: AA0mqf4mO+XCDC7wHKlPwOrpShA5EsIeD/HJ8BbRLleFcQIsD4uq2Bhj5tzIRiRSSugKVWKo3woRC8oBsz8qJptXrzc=
X-Received: by 2002:a63:334e:0:b0:479:2227:3aa1 with SMTP id
 z75-20020a63334e000000b0047922273aa1mr1065030pgz.595.1671054980062; Wed, 14
 Dec 2022 13:56:20 -0800 (PST)
MIME-Version: 1.0
References: <Yyj7wJlqJkCwObRn@lx2k> <20221211084631.3942082-1-bigunclemax@gmail.com>
In-Reply-To: <20221211084631.3942082-1-bigunclemax@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 14 Dec 2022 13:55:43 -0800
Message-ID: <CAGETcx8g57m+0WANjEk3wRu8v-Aw4uPv3npERt=5-wyKhZ2vJg@mail.gmail.com>
Subject: Re: fw_devlink=on breaks probing devices when of_platform_populate()
 is used
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     olof@lixom.net, ansuelsmth@gmail.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, zajec5@gmail.com, fido_max@inbox.ru,
        =bigunclemax@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 12:46 AM Maksim Kiselev <bigunclemax@gmail.com> wrote:
>
>
> Hi, I have the same problem.
> https://lore.kernel.org/all/CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com/
>
> I think the root of the problem was the choice of 'compatible'
> device tree property to marking mtd partition node as a nvmem provider.
>
> This property used only inside 'mtd_nvmem_add' function to setup
> 'no_of_node' flag.
>
> > config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
>
> This is how this flag processed by 'nvmem_register' function.
>
> >       if (config->of_node)
> >               nvmem->dev.of_node = config->of_node;
> >       else if (!config->no_of_node)
> >               nvmem->dev.of_node = config->dev->of_node;
>
> Thats all, there is no such driver which compatible with 'nvmem-cells'.
>
>
> So, maybe we should change the 'compatible' property to something else?

Sorry about the accidental HTML in my previous reply. Resending as plain text.

I have a patch series [1](v1 sent out a while back) that stops
depending on the existence of "compatible" property for fw_devlink to
work. I had a few issues that I have fixes for that were tested in the
thread. I've been meaning to send out a v2 with all those fixes rolled
in. I'll try to get that out this week. Hopefully that'll address the
issues assuming Maksim's analysis about "compatible" is correct. If
not, I can take a closer look after that.

[1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/

-Saravana
