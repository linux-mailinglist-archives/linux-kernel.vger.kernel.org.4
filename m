Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EC7624292
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKJMsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKJMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:48:51 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F656C705
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:48:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g7so3019854lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VgSS+FKD9qOkR6VmuIi8ueaQEoUmTC0BHcBE7yNJo8=;
        b=IwdHWLq6Ru9etUSIT9kqFn5ZmiEUgY20UE8wpBKxwbFoUMF7YPK7e3/S/NqkymRxjV
         +/pFRkDQtgLiQUVMvg8YbSX7lmbJ+t179rxtyXStARVXLW/VLB7QgcmHSYikxc6odOB6
         0rYQUFioZmEF73hQWuI/tJT1izOjaiArUJMwVQHuCfumC1Md4XfcrCYVx1t5m+oOLiap
         A+7UHiOW6dse98QCms/QzRSAcZcGM7aF/aXRDAvEkY/heyy97/AI+x+EYtBWSQ7WzFDL
         GOpgsXZjY0wdsSXddBTjk7yAfNzPvbzIN7b7Ow14VhrCw9vMcUCXhrHf9eIA00AiHZqd
         T+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+VgSS+FKD9qOkR6VmuIi8ueaQEoUmTC0BHcBE7yNJo8=;
        b=D5UC4xHlv9hXGpXtI/00Qlwre1deK89Q92HsYi1fDOUdaNIgK5yf7dqEE6Ag4arjkn
         rp+jvUApbk5W/XU3AszgPQRrCac0jMPGfVQXTyQRKUXF/HCQs1s8q8W/d+VcIq0PB02S
         dITw9l5lk/uphOJV8QVveuqheSSHHNyeo5uVI0PIlu7+s+ty6s2sKoQzx/6jZ2dQEqIM
         vja21chMZFULoegA5gJZz4vk6fGDqnd5X2QUZY00fIWcex71ZDvwt45TLtJPc1EfQiF+
         BlYMEwBb5L5tZN3ERq9D0NThpgIO+wWuGpivStDE7zre7qm7GRkgu8rydyND+KUYoNu4
         aYcw==
X-Gm-Message-State: ACrzQf27CYZ8wVS6+UkCVzOMl4IQKqbD69UMmipx7R+vwbtG6+v+3qbg
        Cnxpdj76I+qPQr9KFhxxJl6wtQ==
X-Google-Smtp-Source: AMsMyM7IxkEtq+xNX6St29phQMhoOFrUuo4jbeG7wbsN7d7k3qmzOeUgCu4sgj0cTk3Jb6uw8vvSew==
X-Received: by 2002:a05:6512:6d4:b0:4a2:f89:db7d with SMTP id u20-20020a05651206d400b004a20f89db7dmr21173642lff.125.1668084529418;
        Thu, 10 Nov 2022 04:48:49 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512358500b004a27d2ea029sm2729460lfr.172.2022.11.10.04.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 04:48:49 -0800 (PST)
Message-ID: <d18be4c5-0bb0-970d-2cf4-d788a4a64876@linaro.org>
Date:   Thu, 10 Nov 2022 13:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] regulator: qcom_smd: Fix PMR735a S3 regulator spec
To:     Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, patches@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20221110121225.9216-1-konrad.dybcio@linaro.org>
 <Y2zvGxmUyl/kpieu@sirena.org.uk>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y2zvGxmUyl/kpieu@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 13:31, Mark Brown wrote:
> On Thu, Nov 10, 2022 at 01:12:25PM +0100, Konrad Dybcio wrote:
>> PMR735a has a wider range than previously defined. Fix it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> No Fixes tag, as the patch is only in -next, so the hash will change.
> 
> No, it won't

Fixes: 0cda8c43aa24 ("regulator: qcom_smd: Add PMR735a regulators")

Konrad
