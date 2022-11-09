Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F30623538
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiKIU5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKIU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:57:13 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74131DDD;
        Wed,  9 Nov 2022 12:54:51 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3082940pjk.1;
        Wed, 09 Nov 2022 12:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG4IsDj4ttcnVL9qCS0Z60sFF7QrBlyG3WDlRrvo46c=;
        b=oAEwcH+CB254X0/z5jZrBZRx9tgdXgzQr9e79X09uKxBXgf+qVq75ffGk5CoHtXohQ
         Scn62T1FcMvibV1RdO6DC2RN7Cf3SyryW+DwJwZnZ/ElKkxRSMmu1IePT9QjfJU5UJ9+
         /8f6D+IPju/6TOts/X6zkU+BUc9SIn84V6A7O/dHdLJYrjqTh1dCoao3zNTzeXggA4Rm
         jZ2joR0ffQTg7L6Ksad2BIb6u7GQewKn66/cJgzXnbkQindnp3dj2AGQkUJpbWC5HViB
         8RhLMlaT+Uoh9d5HromNUYsYID/0boc5UV3xpUiESdZq9wY4QQVH8rnSohulOK+u27LV
         JuZQ==
X-Gm-Message-State: ACrzQf0ddbJPNDbzhvAqvT23GS5V434zZhrchTWStmqC9uHmWEZjt5db
        J+kYNWY87QXvPUTGM9hqwGc=
X-Google-Smtp-Source: AMsMyM6bgoygW+ebU4ATNDoqSFx0OjVrlceNj5CPRQbKTLpN3ufOotnbpyHXUKPtBqhlrHJU04iGdQ==
X-Received: by 2002:a17:90a:d493:b0:213:ce33:4a4d with SMTP id s19-20020a17090ad49300b00213ce334a4dmr56623477pju.140.1668027291325;
        Wed, 09 Nov 2022 12:54:51 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id z27-20020aa7991b000000b005626a1c77c8sm8680722pff.80.2022.11.09.12.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 12:54:50 -0800 (PST)
Message-ID: <a2b535ca-876a-2615-13a6-e13600616276@acm.org>
Date:   Wed, 9 Nov 2022 12:54:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 01/16] ufs: core: Optimize duplicate code to read
 extended feature
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <0cf160f6fe7426340f8a5e68dc95edc751311e84.1668022680.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0cf160f6fe7426340f8a5e68dc95edc751311e84.1668022680.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 11:41, Asutosh Das wrote:
> The code to parse the extended feature is duplicated twice
> in the ufs core. Replace the duplicated code with a
> function.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
