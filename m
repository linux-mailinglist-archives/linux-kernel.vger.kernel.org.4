Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04D72CC84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjFLR1X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbjFLR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:27:09 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589C8107;
        Mon, 12 Jun 2023 10:27:06 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-30fbaf12bbaso441816f8f.1;
        Mon, 12 Jun 2023 10:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590825; x=1689182825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+blguC2WbFz1aop25IT0egRp+jWYhhHvAbXh2rsQ/A=;
        b=kzn7UCa2Zh8EEBtRt6HdE9kHlzv+y/KBkACyY9XPkLQ+FbsmxNKxLiQN8eDME9gtxx
         mu8bxunGEyqP4IVElg64/3t1xJIY1l8/y9XNv76W0GMWxrMrp140/3iM5B/oyhLgHxm5
         RIcGvz2k4tFbWYsNiZBsRCERQOJMDVNXuycivKzBxCk97fAiVJV0QJo/cTELISlvKPhc
         M52TMZS9Yw4f6P/TNA3LtCsXhzftsIqQNqT41OdcxYauZhtgg53XXn5g0jsvo6yBNYLK
         7U1Z4trU7JocE85B+iYkQ4kXSSV+2hUPn83lCKSuT5UxyNEJS/VBKe8ZVzaWqY7lbnkD
         ye8w==
X-Gm-Message-State: AC+VfDzjPWv09x/VbDsI/gb7Gki6v/XkkkrmDVutby4W/tK0AwNWXtXS
        pQKFhwnERKAONFYaaUyKl6U2xlJCPabJAGj645S+LvNk
X-Google-Smtp-Source: ACHHUZ5tqaxaXGpXNUsFFwTH4j3zwIwzjKa8AuxeigYxWQ6JdX+BGhVgG2D55Qj6mgLJ7ePBAapnUmx+imekqnQbsdM=
X-Received: by 2002:a5d:48c7:0:b0:30a:d0a0:266e with SMTP id
 p7-20020a5d48c7000000b0030ad0a0266emr7096018wrs.2.1686590824776; Mon, 12 Jun
 2023 10:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230606095641.5357-1-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20230606095641.5357-1-TonyWWang-oc@zhaoxin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:26:53 +0200
Message-ID: <CAJZ5v0h539BYRN53perdsRViUqU2YG96abRuB2xpTHqYKfFvkw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acpi_pad: mark Zhaoxin CPUs NONSTOP TSC correctly
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 11:56 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>
> Zhaoxin CPUs support NONSTOP TSC feature, so do not mark these CPUs
> TSC unstable when use the acpi_pad driver.
>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  drivers/acpi/acpi_pad.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 02f1a1b1143c..7a453c5ff303 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -66,6 +66,7 @@ static void power_saving_mwait_init(void)
>         case X86_VENDOR_AMD:
>         case X86_VENDOR_INTEL:
>         case X86_VENDOR_ZHAOXIN:
> +       case X86_VENDOR_CENTAUR:
>                 /*
>                  * AMD Fam10h TSC will tick in all
>                  * C/P/S0/S1 states when this bit is set.
> --

Applied as 6.5 material, thanks!
