Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E7D63B344
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiK1UdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiK1UdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:33:09 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428922AC52;
        Mon, 28 Nov 2022 12:33:08 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id d3so6349339plr.10;
        Mon, 28 Nov 2022 12:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftKGuI0EeUZhD1QDVOqqqnsiiCfbTt1mUy91/ldF0Uc=;
        b=Pd/fQzms6yju3QaUsP06DbILNQ6OxllXnKE4FuOMyxaJxDN3dLtRzhwt0HMuI0DhCc
         Y1Olqwcw5kdu4hER/rC3ih47ImWBee0ehw0hMrJnxOChFPgXHWPBub8xBtLyyYsRFy9w
         HjUCFUcgKNrPOmFRQtPrgAfh7NBr/zj0Q7XBj0AYM051EYXdYMnp6gUWpVKgQA/OSSjB
         S+eu7mLgrEfoWT8guIPfi7biQbvWnyxE1UBCAEWVSsCRfiH2VFQQ1LtEuSVvKiQPKKhd
         iEQt+lrhoQyLuaMOUghQ+pBkcfuR/CiGXicHFg262uCtRTwuPURfRvzU1DswuEQBVY+F
         7Yjg==
X-Gm-Message-State: ANoB5plKVEQqtWKshpUVE7PBdDc/OKVtKfUJ2VoGjxeaLtBjY1uS1HA/
        UXPuXOM8aC9gdV8133sLAz8=
X-Google-Smtp-Source: AA0mqf7KbOuLp9LZHNnmD4KWoKV1AKSUMMAeJAt/SYOleMl5tTXg3bYqTPPwQuqwjFT+ZJCIZSrVRw==
X-Received: by 2002:a17:90a:dc06:b0:218:9196:1cd1 with SMTP id i6-20020a17090adc0600b0021891961cd1mr49355887pjv.230.1669667587615;
        Mon, 28 Nov 2022 12:33:07 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:95f2:baa2:773c:2cfe? ([2620:15c:211:201:95f2:baa2:773c:2cfe])
        by smtp.gmail.com with ESMTPSA id v2-20020a626102000000b005609d3d3008sm8674844pfb.171.2022.11.28.12.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 12:33:06 -0800 (PST)
Message-ID: <89037602-f09a-f0da-69f7-f6aae72acc76@acm.org>
Date:   Mon, 28 Nov 2022 12:33:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 07/16] ufs: core: mcq: Calculate queue depth
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>
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
 <ae139f730dcec6462f9218856bf974eda4a29e1d.1669176158.git.quic_asutoshd@quicinc.com>
 <20221128151512.GF62721@thinkpad>
 <20221128195430.GD20677@asutoshd-linux1.qualcomm.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221128195430.GD20677@asutoshd-linux1.qualcomm.com>
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

On 11/28/22 11:54, Asutosh Das wrote:
> On Mon, Nov 28 2022 at 07:15 -0800, Manivannan Sadhasivam wrote:
>> On Tue, Nov 22, 2022 at 08:10:20PM -0800, Asutosh Das wrote:
>>> +static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)
>>
>> Again, no inline please.
>>
> It spits out the following warning for all files that include this 
> header, when
> inline is removed:
> warning: 'ufshcd_mcq_vops_get_hba_mac' defined but not used 
> [-Wunused-function]

My understanding is that the "no inline" rule applies to .c files only 
and also that functions defined in header files should be declared 
"static inline".

Thanks,

Bart.
