Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565A85FF233
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJNQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJNQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:22:13 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A5E1D29A7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:22:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y80so4279901iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQXWoKpRmTOgqqGrbzG/1Mzsebe1fiO8UA8Yjh42UqY=;
        b=N2niElHU2mySrSo2SQ7DYpy3Govx2BMLSUpvxKimhBOj13Zgmd0UHNUZr1XJBzbUDh
         AvgpSWaLp/p7QMAu6bWzoSiIybK5AuB70g4OMn2fU8NY8M6lvRy3kOALGSS9MlkEOu4c
         KhL1dkan+hyRLL6JFsB2WsJ3WJbTsn/dKYRPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQXWoKpRmTOgqqGrbzG/1Mzsebe1fiO8UA8Yjh42UqY=;
        b=kSaE8y8CbavuJIr34ZJGrwtZJ7fuZ/DkN/XUV4xppW+lJnrE3124aajc2n5A4clmGf
         q61an+gbUs60wO6YAOHTqO8QN4nHqS+ioqH2TqB44s9Phxsi0VPA69pkqWdqXHCnv2z7
         Q9E2QdIiVoG+yAFLm+GJgP+aX5ygeybwjXExVJMgN/gtb+uEF0wAidubEemzY99nObDy
         mM93lNABCgCynPP/CF9XZyElyTxljuzfUqm+77amtl5Zida2as8WupgDk/8OKIzrhMyC
         vpe+7PFS7zU1xWXeY8cvp8iwLQNIf6uCod0xILaMs3T1oEIVu3teuoDF7SYx7CKj//Nn
         F14A==
X-Gm-Message-State: ACrzQf1M9JZRgfqLXdKqRexuC1+nsUbb0cLmSWrF09HnLcg8SbduCDHf
        Xd1pu+Vvv/KwSVNbZT/NtcyMn5/VRw5z0Q==
X-Google-Smtp-Source: AMsMyM5jZZRrhNJ2UVldBVfhy7C4DuqwBvrNXBlnkGuPxQup4pIQyE18Bnf9fb2iQMypqnZqvgi2ew==
X-Received: by 2002:a05:6638:2410:b0:363:ffb3:fc08 with SMTP id z16-20020a056638241000b00363ffb3fc08mr2985525jat.50.1665764531813;
        Fri, 14 Oct 2022 09:22:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o18-20020a92dad2000000b002e97becb248sm996780ilq.29.2022.10.14.09.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:22:11 -0700 (PDT)
Message-ID: <38bda8e2-0948-ed48-f2e2-670c15c38298@linuxfoundation.org>
Date:   Fri, 14 Oct 2022 10:22:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] usbip: convert sysfs snprintf to sysfs_emit
Content-Language: en-US
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221014110606.599352-1-zhangxuezhi3@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221014110606.599352-1-zhangxuezhi3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 05:06, Xuezhi Zhang wrote:
> From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst
> and show() should only use sysfs_emit() or sysfs_emit_at()
> when formatting the value to be returned to user space.
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Greg, Please pick this up.

thanks,
-- Shuah
