Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABCF6A84CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCBPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCBPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:02:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734F474E3;
        Thu,  2 Mar 2023 07:02:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x3so5791070edb.10;
        Thu, 02 Mar 2023 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677769349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOs2xtLANmmWRA58qsYI25yvqNCALR25geLBmbCSFNE=;
        b=SyLMzto5K1XBgDYuHFOA77jSDPNQIMCbyZ/EMQTi+bSftNWMO3KNmYlC15xO015+Qr
         9OkakOAmEpugug782Wo4cJq2k/MuvsxfGnhdUe4hWZ9re3tU3f4PnGByUuFk4ojOA4Q8
         o28BzrfDRQcowHt64hCaYFxmGxRJFg9Z3TT3HrsCtShJ1kQs7wc9wszYM28CbTafoGR+
         ueh9+rZo59ypBUTp5Awu3UKGTSeMcbbpp0OH8bD130SQsRIa/H+D83h1E1TwqtEYdfbS
         4RHlmskIewUURJPrMc7ayFaadYKiAa1CBXcXxLVvQzmbvXFht3s0a+ljcEKeMEWKI7GL
         byQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677769349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOs2xtLANmmWRA58qsYI25yvqNCALR25geLBmbCSFNE=;
        b=xrW+LuFaqSt4G5VHxH6WwoSzF5IHW+JaYV2tNt0afC9bQ473g2OPXOtGgmZXmWMag3
         4DPopW3jK4DRNnuRy/8lK9MQn9fL2JxAtDF1dzfIvyKu49B6eV78W027nDoVy6sfxoRr
         k6TR5ogisU6klLivYWz2DMkYfeiWg3l7QCkuFzwHS576jzaH3H94inCofMp53W3ewJ1f
         h+3fVEeEADZEe4qgXddNMykKjyWOX82nsPh5T3VrGyOATbFBjDIVkN6aoYhnZRWFNFAJ
         LtiY0J/se0Y0an9SGiNTA2rSFQwacTSS3qV9NUO/sFIVJGoodrch8nc5/gl+0OMzxSM/
         UDsw==
X-Gm-Message-State: AO0yUKU9ae0cdqWTre8f8YFG1j/0uGg8fvvLUqlqyGR3I+L/GiVNDmyv
        52ZPSSxSypAHUzj7GXloMbY=
X-Google-Smtp-Source: AK7set/Q9Ex9rNyfIo1WFPOJMDwMZteEfSwIjznpfwD6AKbgeMu7LvjPqrUNeOVFWk+ixOMlT5gVMg==
X-Received: by 2002:a17:906:d84:b0:88d:619:15fc with SMTP id m4-20020a1709060d8400b0088d061915fcmr7583434eji.21.1677769349214;
        Thu, 02 Mar 2023 07:02:29 -0800 (PST)
Received: from [10.176.235.173] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id hz18-20020a1709072cf200b008b26f3d45fbsm7289730ejc.143.2023.03.02.07.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 07:02:28 -0800 (PST)
Message-ID: <58bb34de-e333-00bd-ae3f-4ddf0e56aa5d@gmail.com>
Date:   Thu, 2 Mar 2023 16:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20230302144330.274947-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.23 3:43 PM, Ulf Hansson wrote:
> REQ_FUA is in general supported for eMMC cards, which translates into so
> called "reliable writes". To support these write operations, the CMD23
> (MMC_CAP_CMD23), needs to be supported by the mmc host too, which is common
> but not always the case.
>
> For some eMMC devices, it has been reported that reliable writes are quite
> costly, leading to performance degradations.
>
> In a way to improve the situation, let's avoid announcing REQ_FUA support
> if the eMMC supports an internal cache, as that allows us to rely solely on
> flush-requests (REQ_OP_FLUSH) instead, which seems to be a lot cheaper.
> Note that, those mmc hosts that lacks CMD23 support are already using this
> type of configuration, whatever that could mean.
>
> Reported-by: Wenchao Chen<wenchao.chen666@gmail.com>
> Signed-off-by: Ulf Hansson<ulf.hansson@linaro.org>
Acked-by: Bean Huo <beanhuo@micron.com>
