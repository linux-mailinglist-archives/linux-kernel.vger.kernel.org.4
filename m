Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4A6392BC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKZA2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKZA2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:28:35 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76B23BF7;
        Fri, 25 Nov 2022 16:28:34 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id q71so5095882pgq.8;
        Fri, 25 Nov 2022 16:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02B0A+9dfd/6K+TKW176rF7H0il+WmJb1ZFVmjxqaYk=;
        b=1r6h31MRBElGM7o8XzV4vhPiupZUYFlrpuk8y8z6GKqY4zsCj1lULDJ32JkzjoEH03
         JgcCviE265CZXlXFjrK3OzDOYI38PQEfzzx2wV74mumE/DfUotrMGLrwH/4GKMc3uUhN
         9IvHNuexhQ9tDEgi9H/czQIdwZpEx1Fm+P4/bB2HC4unuZMhk0M3DCSMACifadQU4UW/
         QbBFJsRYxlNY9P+0DU1tuki5RAipWMo7sLLUg7FpkJPWus7mxYRWEiKPxgytMfgZzgU9
         Y7AmL3g4QcuZ+mku3LRgDhdtfCGUpCkyrDL0MLXDh7mMMmD3GuYwK+vmQaHBrGd5WGEJ
         We3w==
X-Gm-Message-State: ANoB5pkSKd0Q6E7qhr6R6U4tOgJ+sEkC9X4ZnBetsBHwWrEQc+c9U+en
        q7QA3PI6bXBaz1lfidyKupc=
X-Google-Smtp-Source: AA0mqf7Wvw9JtyFNz5yV+eR5i95xq6njfYDimI0c+vKoZpd2sZONeAF1C+Sr3lYLW9/idqDN7Suqyw==
X-Received: by 2002:aa7:9097:0:b0:56c:674a:16f0 with SMTP id i23-20020aa79097000000b0056c674a16f0mr24417247pfa.10.1669422513603;
        Fri, 25 Nov 2022 16:28:33 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709027e0a00b001886ff822ffsm3946351plm.186.2022.11.25.16.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 16:28:32 -0800 (PST)
Message-ID: <9c9ce51e-2298-5417-8242-090ab7a626d2@acm.org>
Date:   Fri, 25 Nov 2022 16:28:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 04/16] ufs: core: Defer adding host to scsi if mcq is
 supported
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
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <b75e35e1c23b428a6c55396c0fcda5ea22b4e33e.1669176158.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b75e35e1c23b428a6c55396c0fcda5ea22b4e33e.1669176158.git.quic_asutoshd@quicinc.com>
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

On 11/22/22 20:10, Asutosh Das wrote:
> If MCQ support is present, enabling it after MCQ support
> has been configured would require reallocating tags and memory.
> It would also free up the already allocated memory in
> Single Doorbell Mode. So defer invoking scsi_add_host() until
> MCQ is configured.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
