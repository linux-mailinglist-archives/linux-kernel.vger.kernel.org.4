Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827036211E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiKHNDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiKHNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:03:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA52D554EF;
        Tue,  8 Nov 2022 05:03:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61251B81A9A;
        Tue,  8 Nov 2022 13:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99853C433D6;
        Tue,  8 Nov 2022 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667912580;
        bh=AkKnvGBH75slHzzHE2jOu7sJWLUsxZlpFfrdZcyFTDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ns+E8Tv7GPN5IgSqRS+SQMVv63+PFMmAcROp3vocZleoS0OhimwEkzyKlTsJPbRpK
         b89ftBToApCSbcTIw+xwsBD8M5qupBHwoYIZP93SnFoxXBWKZiJ6xPj8KVYrYesB59
         bDecqOSum9jPc6lPx3kM3CRgMioAOmHiZpUYaw5WI1EooChmwOdvSp3JOjphWcGFEy
         fl06d96hdvcuJHPuPRqVA6kNDC+nqyninhzcx8O+uqmQfnRChAOpI3hqg4cs6oJwBf
         WevwRPSQzVHGCrscqW79e2OYEizuf1fq7BS6TzubN6vrhpWiGt4X0wsCHDOyJjWpbN
         vT0F9X4YnxIjA==
Message-ID: <af3bc209-5c89-e0c4-1534-7d190d5daae0@kernel.org>
Date:   Tue, 8 Nov 2022 14:02:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ina3221: add support for summation channel control
To:     Ninad Malwade <nmalwade@nvidia.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux@roeck-us.net, jdelvare@suse.com,
        nicolinc@nvidia.com, rkasirajan@nvidia.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20221108045243.24143-1-nmalwade@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221108045243.24143-1-nmalwade@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 05:52, Ninad Malwade wrote:
> Add support to initialize summation channel control via kernel device
> tree property "summation-bypass". The channel which has this property
> is excluded from channel summation.
> 
> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You skipped not only one, but all DT maintainers and mailing lists...

> ---
>  .../devicetree/bindings/hwmon/ina3221.txt          |  2 ++
>  drivers/hwmon/ina3221.c                            | 14 ++++++++++++--

DT bindings and driver changes are separate patches.


>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> index fa63b6171407..c6e8e6aafcce 100644
> --- a/Documentation/devicetree/bindings/hwmon/ina3221.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> @@ -29,6 +29,7 @@ Texas Instruments INA3221 Device Tree Bindings
>    Optional properties:
>    - label: Name of the input source
>    - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> +  - summation-bypass: exclude from channel summation.

Convert to DT schema first.


Best regards,
Krzysztof

