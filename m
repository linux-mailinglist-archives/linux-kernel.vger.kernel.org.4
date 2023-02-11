Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A05693544
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 00:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBKXZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 18:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 18:25:07 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9452B7297;
        Sat, 11 Feb 2023 15:25:06 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so9061641pjw.2;
        Sat, 11 Feb 2023 15:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fONSMRtXQOh+BhpQwqB8Z+bXfioq6fkZn5EXD/78cAs=;
        b=7Q85jx/9BK0/73plBuQzK66+i0fNakSEI9/btC+FLewGVwsB/qQJI4JG9Zs1UvCSHZ
         moyMF+sagnXyFoxNQ+5emuc4teqP6pMB1Yz9/LJUWUgNc6xEBbtEB8CiA2kFuyZefiXG
         tY+b2r3IgAjYuFR35pUFgY0K58BnxSDGIwzkft6Tc/2WB/qr3v9SMvaqJiHb1X7rxKZt
         XElzLjOPIkPABYMP9/KKg1QNahxQhC1pCQTEzHLviY9VSpMd29XmThVLxqZfDmouPpOR
         OAoet0UfXASMxZGczb7BpKAo4kqjOLYdSTi1ZXThtFP6eL5Bv9uxuHAQCzaJP+DovIjH
         uz1Q==
X-Gm-Message-State: AO0yUKU3EBjK1u/hewXLPMJHbZEZiGuX5y0Akv5OAZb3r/oG2CBMRzwh
        +wOjGDe1wfQk8o7lKfbx/i4=
X-Google-Smtp-Source: AK7set9F9ALiczPrICTwj+b3U/yYp6i3Ib4Bs5LbBsag/UFBHfFCXUty+ocn4bn6aj77oRVcoxAIXw==
X-Received: by 2002:a17:902:c941:b0:199:3e82:8ff9 with SMTP id i1-20020a170902c94100b001993e828ff9mr14063472pla.10.1676157905876;
        Sat, 11 Feb 2023 15:25:05 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b0019a5aa7eab0sm5448762plb.54.2023.02.11.15.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 15:25:04 -0800 (PST)
Message-ID: <aed35866-507c-870c-7e8a-c1868bcaa084@acm.org>
Date:   Sat, 11 Feb 2023 15:25:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] scsi: qla1280: Replace arithmetic addition by bitwise OR
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>, Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y+I7/QpQYjBXutLf@ubun2204.myguest.virtualbox.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y+I7/QpQYjBXutLf@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 03:54, Deepak R Varma wrote:
> When adding two bit-field mask values, an OR operation offers higher
> performance over an arithmetic operation. So, convert such addition to
> an OR based expression.

Where is the evidence that supports this claim? On the following page I 
read that there is no performance difference when using a modern CPU: 
https://cs.stackexchange.com/questions/75811/why-is-addition-as-fast-as-bit-wise-operations-in-modern-processors

> Issue identified using orplus.cocci semantic patch script.

Where is that script located? Can it be deleted such that submission of 
patches similar to this patch stops?

Thanks,

Bart.
