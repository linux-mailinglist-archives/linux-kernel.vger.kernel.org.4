Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE6611D26
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJ1WG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1WGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:06:24 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521E924C94F;
        Fri, 28 Oct 2022 15:06:24 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id j7so2129433pjn.5;
        Fri, 28 Oct 2022 15:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW/fmlZo93bisFJjq8W8NGa3Xmal48CxnwVNy4n7HOY=;
        b=LCmz69RtdM88J5fJXALvT2hxxU1pZcX7l79xLCqrTT0KoVPh+mZTz1Atw/RtmVGX+G
         D1wae7o11DKXBrfPo2sNoZJWUYgMmn0YUBk9sI81EfGf5gA7thbCSZ55OAVgcg0M17nP
         dXsMnpm8vXkysCsyUAn3pog8vk/XG77zp43EZ3sbujP3FU+WZm79cwxjzc8R+Ld6BWc3
         MdkfzoiaDoeAzPTWfV0R6EEEYyczXDI0kSeTWM6CuBBRhusyCtM7lRUvuZEojL4fgHqt
         mwaPYZSQHfs7vtl7Jq88MomvZJvDG5yqF1qjKl0wBouMGzCmsd3vV8dHQaEhySqVNa2/
         CfZg==
X-Gm-Message-State: ACrzQf1/jlr263OxAG5U0JDHcPYRq1AOx/70G5soLwvpYluOa2IM689M
        A+cnNr490vFjjzg9wNGI6MQ=
X-Google-Smtp-Source: AMsMyM4Yf6S5ROuJpbqCTPTJ/6vboqn4ww5So/e55vdq4Xftz1iMhVFm+xLjDmsOxUFgfb9XdodYxQ==
X-Received: by 2002:a17:902:7297:b0:17f:93b5:5ecc with SMTP id d23-20020a170902729700b0017f93b55eccmr1156591pll.93.1666994756063;
        Fri, 28 Oct 2022 15:05:56 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b0018693643504sm3513438pln.40.2022.10.28.15.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:05:55 -0700 (PDT)
Message-ID: <712bf977-26c5-db5b-158a-9b3d8b0f2125@acm.org>
Date:   Fri, 28 Oct 2022 15:05:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 14/17] ufs: mcq: Add completion support of a cqe
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <b93232de6c7e9bd57cdb7cd99071577ed2cea35b.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b93232de6c7e9bd57cdb7cd99071577ed2cea35b.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> Add support for completing requests from Completion Queue.
> Some HC support vendor specific registers that provide a
> bit-map of all CQ's which have at least one completed CQE.
> Add this support.
> The MCQ specification doesn't provide the Task Tag or its
> equivalent in the Completion Queue Entry.
> So use an indirect method to find the Task Tag from the
> Completion Queue Entry.

Please change "HC" into "host controllers" since it is an uncommon 
abbreviation.

> +	int tag;
> +
> +	tag = ufshcd_mcq_get_tag(hba, hwq, cqe);

Please combine the above declaration and assignment into a single line.

Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
