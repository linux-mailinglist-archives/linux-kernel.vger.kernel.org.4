Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905206D0C23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjC3RDP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 13:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjC3RDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:03:14 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9068CDE1;
        Thu, 30 Mar 2023 10:03:02 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id b20so79164073edd.1;
        Thu, 30 Mar 2023 10:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/KbnSxhnq7r/BJGaT2uIIZ7/VijfJAKOcA2Wk4mxY8=;
        b=efh2A2J6K0fg2CWZsByICa9dOJY/YVhaghE6X/q+LX/OtmrBXK6GUknJlYcBw4NaY0
         5D9B0PlLw/teAjXwt8H/vYi7M5oL2xDfxrUnxW7PPt7oDSz5Qbgya7wMP/VC3S7V5+wK
         zY5eXQLvCMZC4QVliOK6E47ta8HVCKEt6gEmHj03d0bycMqZJM1/rsXg2dpW2ZgwdMBH
         UpNRfWJ6XtGkVb5Yfi4XQNKs5YccWm/vvuxIDZn9SUiqGrp+E9r5j2Yvxk87gY52o2rq
         E5UWWfTKEk6wRLlaJhtihTSL10Ly1f/rwsmg1xeEtazCDtzM/dtDfSQE1tNlLQSGNM9T
         AY3A==
X-Gm-Message-State: AAQBX9fuESeWbc+9wNHALKF8yOnxSpaZdBNI/yCeYhtA04ukYjhbBLX3
        Rin5QNPpHSwtnNqyrNAmKvUHhiQkXDQn3k66Lc/2TCKv
X-Google-Smtp-Source: AKy350ZyXCC/zSpvuF5XryWC5RMUG12fz1RjKDNv6lkip14/Z3rT1hNMfr/ntxZvIUirn+EF/rtOdvtrfcx5qJVhq/4=
X-Received: by 2002:a17:907:6b8e:b0:8d7:edbc:a7b6 with SMTP id
 rg14-20020a1709076b8e00b008d7edbca7b6mr4264181ejc.2.1680195781199; Thu, 30
 Mar 2023 10:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230324202628.76966-1-W_Armin@gmx.de>
In-Reply-To: <20230324202628.76966-1-W_Armin@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 19:02:50 +0200
Message-ID: <CAJZ5v0g8K6wHpefig=2RNspp018FqYiZQoCP3hEScJwM4HY7qw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ACPI: SBS: Fix various issues
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 9:26 PM Armin Wolf <W_Armin@gmx.de> wrote:
>
> On my Acer Travelmate 4002WLMi, the system locks up upon
> suspend/shutdown. After a lot of research, it turned out
> that the sbs module was the culprit. The driver would not
> correctly mask out the value used to select a battery using
> the "Smart Battery Selector" (subset of the "Smart Battery Manager").
> This accidentally caused a invalid power source to be selected,
> which was automatically corrected by the selector. Upon
> notifing the host about the corrected power source, some batteries
> would be selected for re-reading, causing a endless loop.
> This would lead to some workqueues filling up, which caused the
> lockup upon suspend/shutdown.
>
> The first patch fixes an issue inside the ec driver regarding the
> removal of query handlers discovered thru ACPI. The second patch fixes
> a kernel oops on module removal caused by a race condition when removing
> custom EC query handlers. The last patch finally fixes the
> suspend/shutdown issues.
>
> As a side note: This was the first machine on which i installed Linux,
> to finally fixing this took ~5 years of tinkering.
>
> Tested on a Acer Travelmate 4002WLMi.
> ---
> Changes in v3:
> - Rework solution for the kernel oops on module removal
> Changes in v2:
> - make acpi_ec_add_query_handler() static to fix warning
>
> Armin Wolf (3):
>   ACPI: EC: Limit explicit removal of query handlers to custom query
>     handlers
>   ACPI: EC: Fix oops when removing custom query handlers
>   ACPI: SBS: Fix handling of Smart Battery Selectors
>
>  drivers/acpi/ec.c  | 17 ++++++++++++++---
>  drivers/acpi/sbs.c | 27 ++++++++++++++++++---------
>  2 files changed, 32 insertions(+), 12 deletions(-)
>
> --

All applied as 6.4 material with a minor comment adjustment in the first patch.

Thanks!
