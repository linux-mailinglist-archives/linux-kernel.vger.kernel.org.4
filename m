Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585536368D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiKWS3u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 13:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiKWS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:29:31 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BF91039;
        Wed, 23 Nov 2022 10:29:29 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id h24so11776990qta.9;
        Wed, 23 Nov 2022 10:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsfzpsvEfdcI9CvvzszRzTXDzyFxBt5oFZ6I9d30cN4=;
        b=EQgLsa0V6JWSTTnkVZ1zOIL0hNZxEmTgsNr1elhU/jLMI2nl5KOa12SmdDitOO4LRq
         1gtTbHzFvZYmfu7kQjQDzqxeR2/5kmychNQVhLqKRcqj5GeuNzvURcV4v04vssrzUKwN
         DfaNeLcdGb+Z4Yv09YhtiCBbvEi4EdT4XpZibU0rXElEmm88jY5IZ0RrQiwPRF+lIavw
         XHvKagJt7davw1i8rP8N7xfr943NIGQNPsgLz6XurWO6wTF1oGG8WDVp7+vqvb4+LYsC
         zAHLWTLEw9UE6NQgoou4eDsa6GPplQMe8jxDB4IjmdxtVUT/7Qqxm3grjCfPCK/9X4Kn
         N3ig==
X-Gm-Message-State: ANoB5pncgfz7eAD1pHPgJnZ/G2F3ZsIiHhOzxgG8szuwtlDjEu7KwXCM
        RfJ9Nz18LHddsFwbEwTZaMHEaugXmCrppWFvRok=
X-Google-Smtp-Source: AA0mqf5ZpJMMPblx9yNvIFnKauwtR7arezg4/1XgYsmT2uGdGDdg0YCJQntrnvKUNiI480FE4ydc/Sze2y2lXj3j8oo=
X-Received: by 2002:ac8:1482:0:b0:3a5:1e6f:7e05 with SMTP id
 l2-20020ac81482000000b003a51e6f7e05mr10093865qtj.357.1669228168694; Wed, 23
 Nov 2022 10:29:28 -0800 (PST)
MIME-Version: 1.0
References: <TYCP286MB23236DCB8906D61FAC7A508CCA029@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <e78ddf03-b67e-a045-cd72-f0edbc586cb2@gmail.com>
In-Reply-To: <e78ddf03-b67e-a045-cd72-f0edbc586cb2@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 19:29:17 +0100
Message-ID: <CAJZ5v0jwY-cH1F3iJzGakzQG7v-ex7_-AC3cm6tUkfTd81_srw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: make remove callback of ACPI driver void
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Dawei Li <set_pte_at@outlook.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        u.kleine-koenig@pengutronix.de, dvhart@infradead.org,
        andy@infradead.org, lenb@kernel.org, arnd@arndb.de,
        peterhuewe@gmx.de, kys@microsoft.com, kronos.it@gmail.com,
        dmitry.torokhov@gmail.com, bleung@chromium.org,
        sujith.thomas@intel.com, vithampi@vmware.com, lee@kernel.org,
        wim@linux-watchdog.org, jgross@suse.com, davem@davemloft.net,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:00 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 11/13/22 17:26, Dawei Li wrote:
> > For bus-based driver, device removal is implemented as:
> > 1 device_remove()->
> > 2   bus->remove()->
> > 3     driver->remove()
> >
> > Driver core needs no inform from callee(bus driver) about the
> > result of remove callback. In that case, commit fc7a6209d571
> > ("bus: Make remove callback return void") forces bus_type::remove
> > be void-returned.
> >
> > Now we have the situation that both 1 & 2 of calling chain are
> > void-returned, so it does not make much sense for 3(driver->remove)
> > to return non-void to its caller.
> >
> > So the basic idea behind this change is making remove() callback of
> > any bus-based driver to be void-returned.
> >
> > This change, for itself, is for device drivers based on acpi-bus.
> >
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Acked-by: Lee Jones <lee@kernel.org>
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Dawei Li <set_pte_at@outlook.com>
>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>  # for drivers/platform/surface/*

Applied as 6.2 material, thanks!
