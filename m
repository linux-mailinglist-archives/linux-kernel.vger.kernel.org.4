Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F013463C857
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiK2T0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiK2T0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:26:22 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D26D94E;
        Tue, 29 Nov 2022 11:23:33 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id j12so14409137plj.5;
        Tue, 29 Nov 2022 11:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/W/iwT5LzDF68TSrdWkr3g5PqsVg1eBGpTUMNlyklIQ=;
        b=iWY9LrO5ej9oyEwDDDjzmlYcmaNtrMKVjiciuYzEE60j5TyUTNSX3Cr9xs4cScEYnD
         la0Rp/XsTosncv2z0i7ZOm251rj8JrSDc/7vl5kXZjg7PRzYczlpQzJnbxcWNE0UM4Lq
         n95zLT/J7fEl75dtrz40Q8+REtG1dp6UPzCOmVeev89LHjTrZUmWjTaswrU6RafVI7Lk
         63euZct4z+OkwyBWvh1w1xf9QKc/lFDE7Wgrvj1mFbmUri7pKHv6q06HGNuIdEW9/C91
         MA2XIgVB5fJwOEE8baP5g2ECjOUbMtvjxaF4/c6F7HGacj2O2XF+B0UfNxWQm9oe9fYE
         HrPg==
X-Gm-Message-State: ANoB5plGL3YrqN7h2R0+++H649OiPZ1K8oWlFGcxLSl6ykf00mCnCjk8
        c8w93aCHD0nyeCPNkLMEye8=
X-Google-Smtp-Source: AA0mqf7Y792+qhzDAjgHcbYP2sthtrZj3JyK4yknOEUznVZwBQDAgvuvHYwRwwOgAsLS6mPomrykcg==
X-Received: by 2002:a17:90b:1217:b0:213:36b7:1b77 with SMTP id gl23-20020a17090b121700b0021336b71b77mr66637468pjb.94.1669749812793;
        Tue, 29 Nov 2022 11:23:32 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7d15:8e62:30bb:9a14? ([2620:15c:211:201:7d15:8e62:30bb:9a14])
        by smtp.gmail.com with ESMTPSA id a28-20020aa795bc000000b00560cdb3784bsm10270626pfk.60.2022.11.29.11.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:23:32 -0800 (PST)
Message-ID: <1d0f6a93-18f2-44b5-c99c-1fc1163aa1fa@acm.org>
Date:   Tue, 29 Nov 2022 11:23:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v7 08/16] ufs: core: mcq: Allocate memory for mcq mode
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669747235.git.quic_asutoshd@quicinc.com>
 <6cfdcaf0bcf8f9a4e5680aff0b7be04c4bc7efc9.1669747235.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6cfdcaf0bcf8f9a4e5680aff0b7be04c4bc7efc9.1669747235.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 10:53, Asutosh Das wrote:
> To read the bqueuedepth, the device descriptor is fetched
> in Single Doorbell Mode. This allocated memory may not be
> enough for MCQ mode because the number of tags supported
> in MCQ mode may be larger than in SDB mode.
> Hence, release the memory allocated in SDB mode and allocate
> memory for MCQ mode operation.
> Define the ufs hardware queue and Completion Queue Entry.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

