Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D356392DA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKZAw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKZAwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:52:25 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A972A426;
        Fri, 25 Nov 2022 16:52:25 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so8993933pjk.1;
        Fri, 25 Nov 2022 16:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWY+oFob71zcGNoB4QxLTbUSKbIFCrDLOt093KFruu4=;
        b=NhwHS76ByNTYMSMAS5nSnVxrXS5Q4rvYQs/GRfic5w9Iowymf/jXRVaiYkFyU+spQJ
         LVUJbWHxBlME7r+L8bgWi2sIvpMGM+Q7prt3OcY4yczXSB/q6LOFcVtSZho7cdFBLyg/
         rACe2a+zhIbawlY91+q1TOgRDJSxn0WM+OZjpM/ZUgSWtCiGWw56aMOKk84OKWgFedfX
         vaJLwDUPNRSj5NuKYN0EAhgb6InCMKlVWnOhmseu4HUmUR+b/Wvbb74fS31x5bic8yRt
         WMWFnYkUo68m4Xt/6IyU/8G1sZbGHF5GJMPBaP2JAYMFr2jhux9XRxaOiHZ91q+unGcW
         onYg==
X-Gm-Message-State: ANoB5pk0NuW9+BlS2SML5RfgjuiCjoH1TJq1XgDts0Iskf0xqeVNovfq
        fhlQ2v2Lt/q50uUU4rzsY3c=
X-Google-Smtp-Source: AA0mqf7FjiTtC9iNp0feg12bQ/s1eycHwDHFjbVSilPVwh8m65vIgzK/DSRrE1ka6WKVsQCVi3xYqQ==
X-Received: by 2002:a17:90a:7e8a:b0:217:f784:689a with SMTP id j10-20020a17090a7e8a00b00217f784689amr43901737pjl.0.1669423944414;
        Fri, 25 Nov 2022 16:52:24 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b001708c4ebbaesm3954226plh.309.2022.11.25.16.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 16:52:23 -0800 (PST)
Message-ID: <2d04069e-9756-a6ec-b1cd-82a6d8afe382@acm.org>
Date:   Fri, 25 Nov 2022 16:52:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 05/16] ufs: core: mcq: Add Multi Circular Queue support
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <91d17ea9623b06d66027699257816bb2fb7176cb.1669176158.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <91d17ea9623b06d66027699257816bb2fb7176cb.1669176158.git.quic_asutoshd@quicinc.com>
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
> Add support for multi-circular queue (MCQ) which has been added
> in UFSHC v4.0 standard in addition to the Single Doorbell mode.
> The MCQ mode supports multiple submission and completion queues.
> Add support to configure the number of queues.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
