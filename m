Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251A66B1673
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCHXXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHXXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:23:51 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F02F6130B;
        Wed,  8 Mar 2023 15:23:51 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso421365pjs.3;
        Wed, 08 Mar 2023 15:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPW92Dasd2mUk7DSK54fSQ8QqsFTSIbZdwDi7vyBvfQ=;
        b=B6BQFFYOuqoVumTCsF8ZkwxXZg7xdLWY2e+f7ICb16rS2gN4ujUmThVvyKnSsTyqgI
         jy65wtRkXvu214SKQrDzcKeH1SbdTnp0QfY20x/Pkb6gzGV2+AJgb5Jm1GH6mC6t+dzM
         Lkd6ujlrGnlYK1oBzfy/E8BEd/+0f/QqXxkaywFqjbDpxD+3/dYc86F/mfF/gaxr57Kv
         0MxbtgHVxxrf46svaGlBZLaUDvPWYgm4hud9MqpCVI+prSxer/0x6iGcIRw4zL663KSQ
         bMUDP7lBa0xl82VcUjADMFuH+46aTbluaUKRku+UvAi2wWrmhmH1L97cahB8qKHEdFAW
         FKWw==
X-Gm-Message-State: AO0yUKU1RkBWYd65BXGLC8/fUhNS1E5W1AuXkEChPYNLxnXocaeMrhjz
        9zZGGnrJiZukl4o1dBY0Ksk=
X-Google-Smtp-Source: AK7set/0SDwLYEGqj5v7WIBk9ECGJ6DtN6kB8LZpqq1MIpGU3c+ZgxDYyl7JjPTqXLGkF3EqA3j7YA==
X-Received: by 2002:a17:902:bf06:b0:19c:ff15:5bd8 with SMTP id bi6-20020a170902bf0600b0019cff155bd8mr16311598plb.46.1678317830178;
        Wed, 08 Mar 2023 15:23:50 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id jx15-20020a170903138f00b0019468fe44d3sm10294228plb.25.2023.03.08.15.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 15:23:49 -0800 (PST)
Message-ID: <e2f1dea7-7f34-127b-ddcb-b21737f26498@acm.org>
Date:   Wed, 8 Mar 2023 15:23:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v1 2/4] ufs: mcq: Add supporting functions for mcq
 abort
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <b84abc7ea5bddc78ab3c70e9a7b5108a5bc9448f.1678247309.git.quic_nguyenb@quicinc.com>
 <fa4bfc9e-2e75-2e00-2b64-816f4bc26eda@acm.org>
 <f4f5eef5-c0d4-0de6-71df-c70f0ce4064a@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f4f5eef5-c0d4-0de6-71df-c70f0ce4064a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 14:27, Bao D. Nguyen wrote:
> This is to give us the flexibility to override this parameter in the 
> downstream driver if needed.

Please do not introduce functionality before it is needed. See also 
https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it.

Thanks,

Bart.

