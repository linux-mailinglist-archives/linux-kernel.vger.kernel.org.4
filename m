Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E75721878
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjFDQNq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 4 Jun 2023 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:13:44 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56508B3;
        Sun,  4 Jun 2023 09:13:43 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96fc07d7e6bso81201166b.1;
        Sun, 04 Jun 2023 09:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685895222; x=1688487222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB2Pk7LaCOIDMRL6UqKdMxKSwM8bP2MfrOVz+JJM6Wk=;
        b=RZBNKkCCsupRLCUuLxhby92kIXSoEQbuFGwT8Iz9bWnWGHE2ZIvSUSnSfW3Z5DWZZr
         BWw30p4AESPFuQ+Ub+B86eWGANEIRsguArhKBL5QmmxrcvYSKG6GT1v80WKa03opZ9xU
         zEG8M9ywifTofTHnOjgeEYSoqLSVNMk27VOWn+mdkFiimpBUGGMcl3rDQzZrN+zavFQ0
         ywaKYpxN8N4CeUM9iErrU89/M/dlo1igT3HTAs3GCfUk2+n58Qt+FKDUZoQ67iYxB663
         n9ZFzctTmrcEQH8yG8ffTxlcVUl4mZaMPu2Jc1QyJw8QKic4Ay3gqxB/KHHhMT6rqxmS
         qNnQ==
X-Gm-Message-State: AC+VfDyZhyNMXsfxiSBNyYEVh/n73+kyRTqGnm6VdKZVLyYg/KIZT6Pp
        KuEvxD8w6AxntKsk4uFzRCSGtuFIRTMPztMXgoI=
X-Google-Smtp-Source: ACHHUZ4o/XAUWrrN3YEUVlphWtsHh4juwhMe0A5KiJ5rZexwbh8w4h1U4k/cuW5UPLOVkAyWlrgAmdrrdf7AJsa8Lcc=
X-Received: by 2002:a17:906:73cc:b0:929:b101:937d with SMTP id
 n12-20020a17090673cc00b00929b101937dmr10488832ejl.1.1685895221737; Sun, 04
 Jun 2023 09:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230602085546.376086-1-d.dulov@aladdin.ru>
In-Reply-To: <20230602085546.376086-1-d.dulov@aladdin.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 18:13:30 +0200
Message-ID: <CAJZ5v0iyDvApQVjY=BopVSXZSg3tqmcYBnDQN2HORp3Oy8atEQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel_powerclamp: Check for a possible array out
 of bounds access.
To:     Daniil Dulov <d.dulov@aladdin.ru>, Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc list trimmed.

On Fri, Jun 2, 2023 at 11:12 AM Daniil Dulov <d.dulov@aladdin.ru> wrote:
>
> ratio may be equal to MAX_TARGET_RATIO - 1 that will result in
> out of bound access.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d6d71ee4a14a ("PM: Introduce Intel PowerClamp Driver")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index fb04470d7d4b..9deaf2b8ccf6 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -277,7 +277,8 @@ static unsigned int get_compensation(int ratio)
>                 comp = (cal_data[ratio].steady_comp +
>                         cal_data[ratio - 1].steady_comp +
>                         cal_data[ratio - 2].steady_comp) / 3;
> -       } else if (cal_data[ratio].confidence >= CONFIDENCE_OK &&
> +       } else if (ratio < MAX_TARGET_RATIO - 1 &&
> +               cal_data[ratio].confidence >= CONFIDENCE_OK &&
>                 cal_data[ratio - 1].confidence >= CONFIDENCE_OK &&
>                 cal_data[ratio + 1].confidence >= CONFIDENCE_OK) {
>                 comp = (cal_data[ratio].steady_comp +
> --

Rui, Srinivas, can you have a look at this, please?
