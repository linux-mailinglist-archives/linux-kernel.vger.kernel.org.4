Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BBB63B0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiK1SBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiK1SAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:00:39 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD3227DFE;
        Mon, 28 Nov 2022 09:47:46 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id b4so11207409pfb.9;
        Mon, 28 Nov 2022 09:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZKuvJhFRP5fDD1GxgFohQBtxaDdSsjAdzx3M27SwEE=;
        b=yN4RJ/hOAMDCk0uORpcJusF+Sht+RaDxcesaQHwI1yVVMqupcYHCmOr7x5Du6s75p2
         Nq4NSEYUMbcduw8AlF/2RXpP+J14qgbVqwe+6pisY9M0yc3+a5dkr8MXIoy3mjoBXMVH
         6LupHLW8BdPrCzlpcve7fpFpM0hjMsIoQL+BSe3EXnTZTG/FEnHoZ+3W7YT7Gy8iFPvu
         zyRZzt1YXu5ojYED7qGsqsDlBIgsMexHClZJduZmDWz1Ad5WG65HQ7QwdUp94pS4ttuX
         BxgOLnT1MpwI4y8yiAVtrsXeH8UO+NBy+SR+13HLGYuPIcV11ALmcpIhGfkPVdRKby/l
         ZLGA==
X-Gm-Message-State: ANoB5plilEvB8qS7yQzVvAP+XTHDOGwCU13BgkgtBuViFIWSEHqycAT9
        H6/G5R2Mlazl6r4K+meppPA=
X-Google-Smtp-Source: AA0mqf5b56D5U7xlFZNXY9EV8a41oSDS7cAF4ID7GMgiHEd0+TF/j14hxb2MwuUJBqsLZOBxMzTEmQ==
X-Received: by 2002:a63:1466:0:b0:476:cac7:16ad with SMTP id 38-20020a631466000000b00476cac716admr29993503pgu.128.1669657665374;
        Mon, 28 Nov 2022 09:47:45 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:95f2:baa2:773c:2cfe? ([2620:15c:211:201:95f2:baa2:773c:2cfe])
        by smtp.gmail.com with ESMTPSA id x189-20020a6231c6000000b0056cee8af3a6sm8304685pfx.54.2022.11.28.09.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:47:44 -0800 (PST)
Message-ID: <de0c1d8a-42bb-4e29-4da0-7b0cfc9c2ffe@acm.org>
Date:   Mon, 28 Nov 2022 09:47:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 14/16] ufs: mcq: Add completion support of a cqe
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <32219cb9b058d7329ad8234a8a287701af1a0e34.1669176158.git.quic_asutoshd@quicinc.com>
 <20221128170015.GM62721@thinkpad>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221128170015.GM62721@thinkpad>
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

On 11/28/22 09:00, Manivannan Sadhasivam wrote:
> On Tue, Nov 22, 2022 at 08:10:27PM -0800, Asutosh Das wrote:
>> Add support for completing requests from Completion Queue.
>> Some host controllers support vendor specific registers
>> that provide a bitmap of all CQ's which have at least one
>> completed CQE. Add this support.
>> The MCQ specification doesn't provide the Task Tag or its
>> equivalent in the Completion Queue Entry.
>> So use an indirect method to find the Task Tag from the
>> Completion Queue Entry.
>>
>> Co-developed-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> What is this reported by for?

I think that tag should be left out. "Reported-by: kernel test robot" 
should only be used for patches that fix bugs reported by the kernel 
test robot. I assume that a fix has been folded in into this patch that 
was reported by the kernel test robot. If that is the case, the 
"Reported-by: kernel test robot" tag is inappropriate.

Bart.

