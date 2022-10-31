Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4D613E79
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJaTmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJaTmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:42:20 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105062E1;
        Mon, 31 Oct 2022 12:42:19 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id b11so11259529pjp.2;
        Mon, 31 Oct 2022 12:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTjoZlyOH3AS4ihcAHQZlL8333OqylU4fr8iC7YCBZ0=;
        b=kAvsHJY00j9ihS4IAI0S/bf6k+WXiBVtmkFoczwJajl0YqisKMyrav/bdoncdnOdKE
         eVJo6UVC1Y315qGuqfEf+MbxFRIrmFSwdE+EfQp56rofJynMTsrLCtD7AMJOdS2AFloJ
         AEKRdh7bnKeLUWL+XwZQ+01O8sWAbZuhJ3oM7qrD0z5TgN65+5xtsk9Drnvh3qcVLFB2
         eQ4n6LzPHkapfHwJnCW/Fu5kDAVmrAYmZbtF8hv56AWy3ql2eyUjwC4W5S7zdHIN+47U
         9+reg2kP3y7hs0A+kJk4urgllonWUljwBQwM6359kmwDq+nb7+nI+BRm8xzXo82ZmX5I
         0Hng==
X-Gm-Message-State: ACrzQf1/FfPpTnNtNm3VTsud+ITmUiqd+fcxvOopLl/nUWkTY1NUWh/l
        BXWQnDjMfPAtsVJYJBM3Row=
X-Google-Smtp-Source: AMsMyM5vxUKd0Esy9pZFV9nVA0MDmjfefVBrK2BCX/7PKa0XBQFHHsien+a1DkISONMesDh33Effig==
X-Received: by 2002:a17:90b:4a43:b0:212:fd76:be5d with SMTP id lb3-20020a17090b4a4300b00212fd76be5dmr17018495pjb.152.1667245338857;
        Mon, 31 Oct 2022 12:42:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8574:e82f:b860:3ad0? ([2620:15c:211:201:8574:e82f:b860:3ad0])
        by smtp.gmail.com with ESMTPSA id v18-20020a170902ca9200b00186e8526790sm4790062pld.127.2022.10.31.12.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 12:42:17 -0700 (PDT)
Message-ID: <87a78633-5c9e-49c2-4e8a-8b1c6b21f2f0@acm.org>
Date:   Mon, 31 Oct 2022 12:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 07/17] ufs: core: mcq: Calculate queue depth
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        avri.altman@wdc.com, mani@kernel.org, beanhuo@micron.com,
        quic_richardp@quicinc.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1987fbada1d33c04c9598614ef712e0a48fe065e.1666288432.git.quic_asutoshd@quicinc.com>
 <0fb3f8ae-5ed7-9057-0d2b-8866f36c2441@acm.org>
 <20221031192435.GD9077@asutoshd-linux1.qualcomm.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221031192435.GD9077@asutoshd-linux1.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 12:24, Asutosh Das wrote:
> On Thu, Oct 27 2022 at 14:52 -0700, Bart Van Assche wrote:
>> On 10/20/22 11:03, Asutosh Das wrote:
>>> +u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
>>> +{
>>> +    u32 qd, val;
>>> +    int mac;
>>> +
>>> +    mac = ufshcd_mcq_vops_get_hba_mac(hba);
>>> +    if (mac < 0) {
>>> +        val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
>>> +        mac = FIELD_GET(MCQ_CFG_MAC_MASK, val);
>>> +    }
>>
>> According to the UFSHCI 4.0 specification the MAC value is set by the 
>> host. Can the above code read the MAC value from the host controller 
>> before it has been set by the host? If so, how about leaving out the 
>> code that reads the MAC value from the controller and making it 
>> mandatory to implement the new get_hba_mac vop?
>>
> The reason it is not mandatory to define get_hba_mac vop is UFSHCI 4.0
> specification mentions that the default value of MAC is 32. So even if a 
> vendor
> HC doesn't override the MAC, it'd be 32.
> Hence, the current code first checks for an override, and if there's 
> none uses
> the default value defined in the HC.

Hi Asutosh,

Please ignore the value reported by the controller in the MAC field of 
the MCQConfig register and overwrite the MAC field without reading it 
first. It doesn't seem useful to me to read this field. I think the host 
should decide about the queue depth no matter what the current value of 
the MAC field is.

Thanks,

Bart.

