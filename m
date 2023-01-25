Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8267B5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbjAYP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjAYP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:28:21 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1922F4ED8;
        Wed, 25 Jan 2023 07:28:18 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id c21so9364927vkn.10;
        Wed, 25 Jan 2023 07:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoOZ7GrVDWL5GTrsJaPsMKv/w6eYLsmHBJwN603oceU=;
        b=PDrcp7wiqW8cCMtOl7K8yMdZzOiq1GIGdiikKgSzmobR6Dg3fnNLHlaKWcjxw0qjHi
         hJ+QTgb4Yk3xwebYIW/XaKzgrujTGAmZB7tAbswEtSdvhw8k5g4owPYywak0CeI9Bu4i
         XZ0f293X6d4Z6z9u2JXQgzZvrXLZIcgeV14wsitxwpEHYJRHeV4qlXw3L3HyLgV4+r1c
         hEu35qqtj+6z1UUfjLEwyxj3fw1yIjow3jcgfMgZNc2zXdZNHQcD2t2NgaycmwYA6eU6
         VhL0HJXPgFk4O6yCF9uE8bX/bzjJfZAhMe3ueVN5P7V3GfFQi0dgnP4udZ7MIEGQm5se
         7Adg==
X-Gm-Message-State: AO0yUKV3pivU8xb/2VNIbaOdib01/nvteBmBenqadl4P9SCjHEJQcQlT
        ovXad24Ie6aHqilvnh+VPXDH7EnUDzIA4A==
X-Google-Smtp-Source: AK7set+y+6x3G1wJL21DXX5AGIgI7ChcABQpctdnIRcFfNobupRr3Ngr8Lo4b84f06OgQNtqnaanFA==
X-Received: by 2002:a1f:2b86:0:b0:3e4:7599:4086 with SMTP id r128-20020a1f2b86000000b003e475994086mr1815987vkr.12.1674660496959;
        Wed, 25 Jan 2023 07:28:16 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z197-20020a3765ce000000b006bb2cd2f6d1sm3654200qkb.127.2023.01.25.07.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:28:16 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id d132so1895928ybb.5;
        Wed, 25 Jan 2023 07:28:16 -0800 (PST)
X-Received: by 2002:a25:e650:0:b0:80b:8b72:39fc with SMTP id
 d77-20020a25e650000000b0080b8b7239fcmr400699ybh.202.1674660495879; Wed, 25
 Jan 2023 07:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <20230104183033.755668-7-pierre.gondois@arm.com> <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
 <20230124140420.4srnufcvamvff77v@bogus> <Y8/tl999NQwbPL/R@wendy>
 <20230124144839.2szjjv256j3pdaif@bogus> <20230124145541.2xwtr7ro2bjnsjd7@bogus>
 <20230125145423.pid3hsstswzuez73@bogus>
In-Reply-To: <20230125145423.pid3hsstswzuez73@bogus>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 16:28:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZ+_kdMp+0VfYAJZRHBWiyobQQJwEM_kHN6yeVVGxSvg@mail.gmail.com>
Message-ID: <CAMuHMdWZ+_kdMp+0VfYAJZRHBWiyobQQJwEM_kHN6yeVVGxSvg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arch_topology: Build cacheinfo from primary CPU
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Wed, Jan 25, 2023 at 3:54 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Tue, Jan 24, 2023 at 02:55:41PM +0000, Sudeep Holla wrote:
> > Geert, can you please try with the patch Conor pointed out and see if
> > that helps to fix the allocation failures[1]
> >
>
> Sorry for the nag, but did you get the chance to test -next with [1]
> and see if it fixes the cacheinfo memory failure you were observing ?

> [1] https://lore.kernel.org/all/20230103035316.3841303-1-leyfoon.tan@starfivetech.com/

After applying that patch, the issue is gone.
Thanks, sending my Tb!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
