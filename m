Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E3C6885CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBBR6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBBR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:58:29 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D87769B37;
        Thu,  2 Feb 2023 09:58:29 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so6155455pjq.1;
        Thu, 02 Feb 2023 09:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7TfipDVShtVQTpW0FSroHYDXAV2hY7mVhCYjGpL6gc=;
        b=P2lauL47xfc3/Kio2VmxgkUa7xmTL2E8vTyXqFMVCcF1s7RjyJXXsM7Uy6MDABNit0
         VMair7Xs/5VTz6L3DiYrUte0gFmSbIb5TnLoN9tt31SOzw6N6GuqoiUXA6UAXks+g3Ze
         NibRuyuS8tJcpv4GJxEMk9O6Id7uGlVrK8/nUd3aJYCFOLjkd9BowAIQxcrkkjZ8y1Rq
         oSKAZtycgeENdCySICJ4hjCGrTEGG6TH33mlDqJhynAFgJTtevxCdmsyx4zz68Tv7Vlp
         xiU4PlLX4K1ersU0Ej6FMxwdYgZMHMfLGfPXgn/vm7KBKFKgX4I6T9734pTTXav8kIYK
         DdOA==
X-Gm-Message-State: AO0yUKU9Gh9LN7oWpGv9PKH6v2RkvY0H6vKYZzcBRlG7WnUpAK5Ra3Tb
        gT5/yauYgAsnRRleoK3N+kg=
X-Google-Smtp-Source: AK7set9fAe9AwWa6YZu7dLL1f5KXAYAdfqmCS8CzDzM3SLiYLJXSp7Qf2MdVsRSKwQ+rNh1jXn/8cg==
X-Received: by 2002:a17:90b:4d04:b0:22c:6fdb:88c2 with SMTP id mw4-20020a17090b4d0400b0022c6fdb88c2mr7390323pjb.30.1675360708533;
        Thu, 02 Feb 2023 09:58:28 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:bf7f:37aa:6a01:bf09? ([2620:15c:211:201:bf7f:37aa:6a01:bf09])
        by smtp.gmail.com with ESMTPSA id ne19-20020a17090b375300b00228eea35201sm3542973pjb.12.2023.02.02.09.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 09:58:27 -0800 (PST)
Message-ID: <45a935b2-9603-8244-3d1c-6e5ad0445a81@acm.org>
Date:   Thu, 2 Feb 2023 09:58:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/1] scsi: ufs: Add hibernation callbacks
Content-Language: en-US
To:     Anjana Hari <quic_ahari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        konrad.dybcio@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_narepall@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com
References: <20230202161045.3956-1-quic_ahari@quicinc.com>
 <20230202161045.3956-2-quic_ahari@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230202161045.3956-2-quic_ahari@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 08:10, Anjana Hari wrote:
> Adds freeze, thaw and restore callbacks for hibernate and restore
> functionality.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
