Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E89611CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJ1Vrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1Vro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:47:44 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1E24BAB6;
        Fri, 28 Oct 2022 14:47:44 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id l2so5921885pld.13;
        Fri, 28 Oct 2022 14:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFrGHfetuBgL/SnOurCB1y7VCm5G+cM3KwFDzCof9iI=;
        b=0Yjb8Fnr4jKaoV6sZ2TnDZ8s/Gky89SMhVAx+k6CgAJgIAPaxi0j2kkJI37iGitEdb
         0KLTqd6DP5kr4mzBaSJaUMTumUD8VHNpkfri0WnS4/zrC+wyUvx30BWfaXIGvU3r+ZmM
         A/IHd1/jjVJAYadsMYgqJJjZCbx6ZyDVzob1xWZmt1N3GKYSxQJWepsB1qVCVDFneFKC
         nIpKszZo9KZ7wi4KjwCBzQ/9Onln+yAf3BMWr9sB86YF16qQTb2AQZw1Yb5wiy2TWjf/
         eM70ykdXOpw+0+0358He/uBn9vmm/wtfBJxeOHsEN4qd6AB5ogpU4N8qgY3pQ8bHLEQI
         Ym1Q==
X-Gm-Message-State: ACrzQf1AihdV4tphrcjJkJItkyOD0Ue997u8gYfa4ld3oHevR1jbdGng
        RAvzMsWIiyKnKTG5cK13KzXq/hjWlyo=
X-Google-Smtp-Source: AMsMyM4iWB2Mojn7T5n2sI1tb4EqtFT0stMNgH03wtyAZ0x38sRGmjUUFAFpl97KH9PWbk9HES4bfQ==
X-Received: by 2002:a17:902:8491:b0:183:c3d2:2112 with SMTP id c17-20020a170902849100b00183c3d22112mr1059833plo.133.1666993663559;
        Fri, 28 Oct 2022 14:47:43 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001869f2120a6sm3571947plg.108.2022.10.28.14.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:47:42 -0700 (PDT)
Message-ID: <035082d1-af66-3938-59f5-e4730e4516bb@acm.org>
Date:   Fri, 28 Oct 2022 14:47:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 10/17] ufs: core: mcq: Use shared tags for MCQ mode
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
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <2fea9d4f0b8dfc2e2c82d176f0c928b0525d8110.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2fea9d4f0b8dfc2e2c82d176f0c928b0525d8110.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> Enable shared taggs for MCQ. For UFS, this should

taggs -> tags

Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
