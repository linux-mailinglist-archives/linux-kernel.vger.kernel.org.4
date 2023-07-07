Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A35674B9B5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGGWvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGGWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:51:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B6A10C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:51:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so46961cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688770304; x=1691362304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRS1+vzqoKA6WQhbEprHzN1QDhN5ZxO4uWWH/803Ycw=;
        b=cCoBFJBTSCsx+sWLkqKlnPjv3VkWiOnzh95mffIbbKYhWflksKKw+p/SH7HmfNzhaV
         cfsYo5f9MnvR2SkaQW9UO1HnlRBAuDsio+sY6kO85m2WFPgm5gDZqI/8wDYlrIhuQ/K0
         /yThOsBpOzmvrvwfsSeCoiu8BuanzOgU8cp6Klbg6og+7z8t6TKkCmbwdD3W6HFnmoId
         RSodymi8cSFcd2eZGOe2fqEEtmbFqwZlDNbBr5Ct0nEwSfkC3liiTVJ7RbiTc/UXAERx
         HpyzXuF3qM58iXX11ZC+UcSIyhOiNcraDFe2Zo2U7TketXrauwEahRQ1fXlVMrKdvEP7
         DKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688770304; x=1691362304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRS1+vzqoKA6WQhbEprHzN1QDhN5ZxO4uWWH/803Ycw=;
        b=MG0UAMmOrYz1ZYmiEeiaCkJy8xi4gxY9qrzIpdJvjqtNILqMjrMrp+dE29LqViiuLk
         ZWQpMviTRXEgIjIHnSE4fcBzUz4pPvk7FGpQK/DK53YiCoZsSlamvzbGDMzPp9Y4MeaG
         AuZPVmG6rmXOFZ7xqkBtYKrmqFtbkoC78qPfjy5Bq4+tZo1FgltVl+BLbtF/1KSpS+2x
         dThwItnP90x3MWQYOzMrKILjKAaxnbBPI5b0NCaMmuOxmzCqPP7il5rVslFWuu1YV/mF
         mumS3hRBAmsobRuLEN36Mod61EOSYgkvOSBPaE6tEyhSeS+fX4dmUqIPXBe99b8JjmJF
         VDbw==
X-Gm-Message-State: ABy/qLYxh+r1r1OVxmW04MZ3FHvFiIHC4h7vuj6NnQFdDM/msAjU+Ixh
        BKCtBorDCA8Vv+9c4YYcdekN9CiMkQUcd8GVTsM9
X-Google-Smtp-Source: APBJJlHmPMbf5wZ2gS+TsmPvkLDic/A6ieQ7Tj2Cyb5u75LiPR2cZp/onwlLz1TbJvJUGxd2LjDOVglbhm6qG40Ukq8=
X-Received: by 2002:ac8:5781:0:b0:3fa:45ab:22a5 with SMTP id
 v1-20020ac85781000000b003fa45ab22a5mr27304qta.27.1688770304082; Fri, 07 Jul
 2023 15:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230630171052.985577-1-peter.hilber@opensynergy.com> <20230630171052.985577-2-peter.hilber@opensynergy.com>
In-Reply-To: <20230630171052.985577-2-peter.hilber@opensynergy.com>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 7 Jul 2023 15:51:32 -0700
Message-ID: <CANDhNCpaoRRKGz0XxV3zjA-ux66gU-dT_bGQ_OqDh4ty=VdXLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] timekeeping: Fix cross-timestamp interpolation on
 counter wrap
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
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

On Fri, Jun 30, 2023 at 10:12=E2=80=AFAM Peter Hilber
<peter.hilber@opensynergy.com> wrote:
>
> cycle_between() decides whether get_device_system_crosststamp() will
> interpolate for older counter readings.
>
> cycle_between() yields wrong results for a counter wrap-around where afte=
r
> < before < test, and for the case after < test < before.
>
> Fix the comparison logic.
>
> Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supp=
orting slower devices")
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  kernel/time/timekeeping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 266d02809dbb..8f35455b6250 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1186,7 +1186,7 @@ static bool cycle_between(u64 before, u64 test, u64=
 after)
>  {
>         if (test > before && test < after)
>                 return true;
> -       if (test < before && before > after)
> +       if (before > after && (test > before || test < after))
>                 return true;
>         return false;
>  }

Thanks for catching this and sending it in.
Looks good to me. Curious: Did you actually hit such a wrap around with u64=
s?

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
