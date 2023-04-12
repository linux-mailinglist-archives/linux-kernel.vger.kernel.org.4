Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54556DF6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDLNMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjDLNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:12:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA077DA8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:12:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v9so16762740pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681305139; x=1683897139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D0hP3jv/htpFn6noooEWQxBH2VirSMKKiLKRhrd4CVQ=;
        b=fZEKcEqQe/+CzECq7x8VyAs7MJhvwLRndGyF7cG0pmc00tX1LdoME0zIIdPDsvy7Rl
         aVhZ1fvndJuiHUJLvPrvV9tW0Wqk7iU611OxZI7S5DSEIA/D4WVLVLUVyb/J5oVrKbUn
         KidNfSwDklp1sz5DHvQ3D9yMNEClqJFRhETNQ+FUVCl3Okr+KD9fruNFmdwqIMrQ089S
         OHybyntxkI3zNcWBWNduFlj5QkLw0LdrnAEUOXTE50k0Y8Wpvc0D7xSRql/zlOXyt6Kf
         J4uAfDRTWwSNZ0D6He50GQjnF+bW6K0cLqa/eH4l4jTHV1UeAqLoji2F/m69lVeLUfH6
         um0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681305139; x=1683897139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0hP3jv/htpFn6noooEWQxBH2VirSMKKiLKRhrd4CVQ=;
        b=MJf7yf1gHGlp2m0bw/F7AZ/qfA7DLQ7Zyuz+Ejm+T5SkrZNDt8pWFTPF6AyGWtL4DI
         T/8KFzCvfQaJctg8SVr4IsatvsenY1409WKgHdHx3LQwblea4YlISEqlUUBifIhuskqZ
         YidNfx4IPWFHBaKUAmLZPMvIUyeuhDWHrCNqKR4Q843Dh+KN3b2CdUkakcbusBX7ByVp
         5cjg2P1J61WSHGHBFtl1dRj0mw2K2M2TWFtrkbqo3lZeXRunziYUgDFuQEu0GZAJUuWa
         JIhLVGUQYpEOb9jaDA3Zwkmc/EZGkYewoA/4yexGcstNSjspdosCinX6bfx+Eglcd7fp
         JgVQ==
X-Gm-Message-State: AAQBX9eJ48qSzzYHXhD47uKMozfNy+UvkoCUTfsd3aa1IPER8OaJ2QJa
        8k/6wLtw44ZNyg5T5xuYdh3cfbbE7wjwppT7Hu+OeQ==
X-Google-Smtp-Source: AKy350bhP6d0Gog2cImJQebeSNPkXwz2gy/C204IjldUdXRq0Jxh4JzCGilWwcsESB01fHh3V/okPvPsFHPoEYowYW0=
X-Received: by 2002:a17:903:22ca:b0:1a4:f282:91c7 with SMTP id
 y10-20020a17090322ca00b001a4f28291c7mr4899727plg.6.1681305139610; Wed, 12 Apr
 2023 06:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230404155121.1824126-1-james.clark@arm.com> <20230404155121.1824126-2-james.clark@arm.com>
In-Reply-To: <20230404155121.1824126-2-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 12 Apr 2023 14:12:08 +0100
Message-ID: <CAJ9a7VicZH1uqbdtN9ATWh=4tP7P64PEo_DfLDjRC9LJHL6NcQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] coresight: Fix loss of connection info when a
 module is unloaded
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 at 16:51, James Clark <james.clark@arm.com> wrote:
>
> child_fwnode should be a read only property based on the DT or ACPI. If
> it's cleared on the parent device when a child is unloaded, then when
> the child is loaded again the connection won't be remade.
>
> child_dev should be cleared instead which signifies that the connection
> should be remade when the child_fwnode registers a new coresight_device.
>
> Similarly the reference count shouldn't be decremented as long as the
> parent device exists. The correct place to drop the reference is in
> coresight_release_platform_data() which is already done.
>
> Reproducible on Juno with the following steps:
>
>   # load all coresight modules.
>   $ cd /sys/bus/coresight/devices/
>   $ echo 1 > tmc_etr0/enable_sink
>   $ echo 1 > etm0/enable_source
>   # Works fine ^
>
>   $ echo 0 > etm0/enable_source
>   $ rmmod coresight-funnel
>   $ modprobe coresight-funnel
>   $ echo 1 > etm0/enable_source
>   -bash: echo: write error: Invalid argument
>
> Fixes: 37ea1ffddffa ("coresight: Use fwnode handle instead of device names")
> Fixes: 2af89ebacf29 ("coresight: Clear the connection field properly")
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index d3bf82c0de1d..5733294ce5cd 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1419,13 +1419,8 @@ static int coresight_remove_match(struct device *dev, void *data)
>                 if (csdev->dev.fwnode == conn->child_fwnode) {
>                         iterator->orphan = true;
>                         coresight_remove_links(iterator, conn);
> -                       /*
> -                        * Drop the reference to the handle for the remote
> -                        * device acquired in parsing the connections from
> -                        * platform data.
> -                        */
> -                       fwnode_handle_put(conn->child_fwnode);
> -                       conn->child_fwnode = NULL;
> +
> +                       conn->child_dev = NULL;
>                         /* No need to continue */
>                         break;
>                 }
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
