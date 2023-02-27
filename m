Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C66D6A4EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjB0Wsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjB0WsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:48:25 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B159EDF;
        Mon, 27 Feb 2023 14:47:58 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id z2so8430728plf.12;
        Mon, 27 Feb 2023 14:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lG6vB3dP9H3e//Mg7ICB0IjrePifa0YDIvFrmLOhqlQ=;
        b=yB6u+k7H/fps2LM42gtr0Rpne8TG6JTKSX9Vi/v/Yo7yNjZKEHeIKCCzRhY6NSSaew
         tGs9ccX9NsnjPCIfmaJVe7DTdNk2kWcc2kIyCR1AbEuRiDQ6kF9VqP5x8NtUeC6ZYjyI
         5QGjQnNP0j9bQNcwVDiDw4P7Zee5NRre9DTw9OlbBcIoiM9dZjNP+EdXTmhIBenJaJwo
         44C8boVKjD3OJ5ah/x7X16cJy7KCVfcOU5YbUuwvZHv/3TbW9e6QdSb2hLpUX7pRBVqc
         FL8ZJYvnLfxYRMNQP1YT5eCy72Mh26plXQZEzq/hG1inY+jKgJ6W6AdlBX50DEeOztsG
         TpBw==
X-Gm-Message-State: AO0yUKWrcw3S6u+sbwbmbAo2hbPltWo/HL5lZH+MCatsOnIVwZZqyfDy
        m048VMoVr3+6iMXR5xloe4inLnAGNRI=
X-Google-Smtp-Source: AK7set9vcQ/F8WhIG+6XsqcHSIU5HVBhAJ1lVW44QSnhAm+ORXEIjQ6fFA1tdKOn1Sl1SStdekryLg==
X-Received: by 2002:a17:902:db04:b0:19d:90f:6c50 with SMTP id m4-20020a170902db0400b0019d090f6c50mr583309plx.58.1677538070772;
        Mon, 27 Feb 2023 14:47:50 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:6cf3:f584:1162:e48a? ([2620:15c:211:201:6cf3:f584:1162:e48a])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b00186b69157ecsm5088744pli.202.2023.02.27.14.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 14:47:49 -0800 (PST)
Message-ID: <99993a45-acc6-176f-d846-e278f173171c@acm.org>
Date:   Mon, 27 Feb 2023 14:47:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
References: <20230222030427.957-1-powen.kao@mediatek.com>
 <20230222030427.957-5-powen.kao@mediatek.com>
 <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
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

On 2/23/23 02:14, Ziqi Chen wrote:
> Calling registers dump function in ufshcd_print_trs() is not reasonable, 
> eg.. for each aborted request, it would print out all hwq registers, 
> it's not make sense.
> 
> I think we should move it out of ufshcd_print_trs().

+1


