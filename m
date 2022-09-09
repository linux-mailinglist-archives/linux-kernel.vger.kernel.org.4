Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1E5B431A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiIIXiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIIXiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:38:19 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA985ABF15;
        Fri,  9 Sep 2022 16:38:17 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso3005150pjm.5;
        Fri, 09 Sep 2022 16:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9nKlQ9Dbx5obc3qdOBegZ5d8VUInUyb/dGuThOLDpF0=;
        b=b6PEv+pliHOHODYBgrX6iRvy9Tqv+Hs9Hr71OG1VLyyBZOwFGASFJmuBVWcvJL2bdB
         8w1LQGnDiZKxZOYTZrXOL1B2g0+cpA0oqD63IlsSX7GE9zPGVXZx1euY0EdOowyhwFJi
         EpC9crPc9QKXdi90B6d2Qju9Xh6tpTPDJFkcw5kg/4jRLl3sCkcHb8Qvv8PSNC0+zk4U
         3HCjT2POPn8WWR7jEjS3JscCBPWlg4ju/jqQ3VX8QgzDfY+3myqx8v7IFwo+1hF991eI
         dJhrOzGmQE+X74MafZA5xrfyHvFDh0qSB0HTYavwyRN0ck/fattFmZn5IXkfq7ABODKk
         oCxA==
X-Gm-Message-State: ACgBeo1fYdY67+IA1Gcr2NiQr59glG+dzRYlSplMfR026emcFbNFfx7G
        5xWVypGZSf2myJItjjO80pM=
X-Google-Smtp-Source: AA6agR7taukX9V0LD0Kf8VdNFALATvaMZsi3zPOKlcH2b0pE3tYU4oRDgFAil4Is8lxfVqSesFl/DQ==
X-Received: by 2002:a17:90b:4a4c:b0:1fe:24ac:2bb3 with SMTP id lb12-20020a17090b4a4c00b001fe24ac2bb3mr12141351pjb.79.1662766696852;
        Fri, 09 Sep 2022 16:38:16 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 7-20020a630b07000000b0041cef96cab0sm1016389pgl.90.2022.09.09.16.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 16:38:16 -0700 (PDT)
Message-ID: <c85af2ae-42b2-89e4-0dc1-17658379ac3a@acm.org>
Date:   Fri, 9 Sep 2022 16:38:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH v3 1/4] ufs: core: prepare ufs for multi circular
 queue support
Content-Language: en-US
To:     "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, mani@kernel.org, quic_cang@quicinc.com,
        beanhuo@micron.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
 <37d36dd9-f467-233c-babd-4e7c1c953c6c@acm.org>
 <4ef3ee8f-1210-3a03-da14-1bfdf6def297@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4ef3ee8f-1210-3a03-da14-1bfdf6def297@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 15:48, Asutosh Das (asd) wrote:
> Hello Bart,
> Thanks for the comments.
> 
> On 9/8/2022 2:58 PM, Bart Van Assche wrote:
>> On 9/2/22 15:41, Asutosh Das wrote:
>>> Preparatory changes for upcoming multi circular queue.
>>
>> One patch per change please and also describe each individual change. 
>>  From 
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes: 
>> "Separate each logical change into a separate patch".
>>
> The intent of this change was to have all the non-mcq related changes to 
> the ufshcd as a separate patch.
> I would add more details to the commit message of this change.
> If there's anything specific in this patch that may need changes, please 
> let me know.

Please follow the "one change per patch" rule. This is a widely followed 
rule in the Linux kernel community. This rule exists because it is the 
responsibility of the developer(s) who post a patch series to make it 
easy for reviewers to review their work.

Thanks,

Bart.
