Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EFF697AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjBOLlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBOLlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:41:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF34CA3B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676461233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bP0bXUiaDH/boozQCsBpj6Xk/aGxK9UqogMEXux8y/Y=;
        b=brksby3zKizpsYmBpESE8Ek6lfNCW1eFO/rIcZBKxNAXRIORyJvFW085oQSSO69WQpZmlW
        tqlo3Hc33qa0YapMrRsnDK8hH5+83e1ErWsUs2n25ArBx9tHHaVDMblE18qGXcaUizR3IG
        LQacDRjgVFCdSodZnABg7XufMf69Ryg=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-GXZR54EXPP-PKtP6aQc3Hw-1; Wed, 15 Feb 2023 06:40:31 -0500
X-MC-Unique: GXZR54EXPP-PKtP6aQc3Hw-1
Received: by mail-vk1-f197.google.com with SMTP id x197-20020a1f7cce000000b00401684aa41aso3890052vkc.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP0bXUiaDH/boozQCsBpj6Xk/aGxK9UqogMEXux8y/Y=;
        b=VCgODEPRasKY1xxiJc/CUVpzWwSwjKXQaDKHSX8Pi1EfjDUXM24z+wgyaM5OZNmzsq
         kEQqxfFF/H08dmMMRyYy0F7BJOvWPstI2uQIPqBEPtYnYqF7qVk/HWATd02GbNo4C60r
         BAXjO+jFAUxAno3r6kdwuURSg4e2DHbl+z1/yQSU79tnL3QFOzaJXhxWSFmuaW0HxRlr
         nZegyKIl3GhAXZhPsToTfA3p+SmFQs/zOI/XmbNNkHiikHq70ijTDZN+zckhuUTUsInx
         EGU7m7f8Smr1qkEsS9sRLtGOFxT0QOYPMWogZvqnU0FvpRul/DAT/toz9meFiicJsxnM
         WZtg==
X-Gm-Message-State: AO0yUKWn5XvsD8gDvZK5nwIVFn2jzfI12KlcPf0edcvMCcsZ14y10R9f
        rtUM29GrDECLeK2IqBjApRDzXelpsZENaClu0li/33QAvmwrR7y2D3yFbBVp7pfZAiTCV9pITfu
        8HmfI7/OFEz1IvJS3fzWztMr5j24Q9OB21TH3wVIE
X-Received: by 2002:a05:6102:34c7:b0:411:bd2e:11ac with SMTP id a7-20020a05610234c700b00411bd2e11acmr286376vst.75.1676461231215;
        Wed, 15 Feb 2023 03:40:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/ec/Q3TOlkRzgnxVJ/+TUUmx2nTPikt2SH7K2yD2bJse3Fds41BApWtp1vT1H9cn99iNHGJGfx8IKaZowROyE=
X-Received: by 2002:a05:6102:34c7:b0:411:bd2e:11ac with SMTP id
 a7-20020a05610234c700b00411bd2e11acmr286371vst.75.1676461230930; Wed, 15 Feb
 2023 03:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net>
In-Reply-To: <20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Wed, 15 Feb 2023 11:40:15 +0000
Message-ID: <CAOgh=FwCk1qMUAqkv+aih_=6vJ0SjqyzS9-gW+v+YjEse6V0Yw@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: Invert fallback armpmu_filter() return value
To:     Janne Grunau <j@jannau.net>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 11:36, Janne Grunau <j@jannau.net> wrote:
>
> Fixes a regression in "perf: Rewrite core context handling" for arm_pmu
> based drivers without a filter function pointer as the Apple M1 PMU.
> The event is ignored if filter() returns 'true' opposite to
> filter_match(). The refactoring failed to invert the return value if
> arm_pmu has no filter() function pointer of its own.
>
> Fixes: bd2756811766 ("perf: Rewrite core context handling")
> Signed-off-by: Janne Grunau <j@jannau.net>

Makes sense we return the inverse of armpmu_filter everywhere else in the code.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/perf/arm_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 9b593f985805..9cb22f36cf66 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -556,7 +556,7 @@ static bool armpmu_filter(struct pmu *pmu, int cpu)
>         if (ret && armpmu->filter)
>                 return armpmu->filter(pmu, cpu);
>
> -       return ret;
> +       return !ret;
>  }
>
>  static ssize_t cpus_show(struct device *dev,
>
> ---
> base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
> change-id: 20230215-arm_pmu_m1_regression-b6dd48d0c792
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>
>

