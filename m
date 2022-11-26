Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03266392A3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKZAUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKZAUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:20:15 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F859FFB;
        Fri, 25 Nov 2022 16:20:09 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso2414306pjb.1;
        Fri, 25 Nov 2022 16:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=na5Eef0FY+XWQut1bWk+6h4xrDMArS54kGEKttOuCzs=;
        b=JuCvie/HGLKEGBGuiqheFLodVGpRG3OZSyoVFN1qRRG/Z5XBvqtJB21ZPpuwn1ZOYO
         KRV7vx+i9obBanE4GrngFp2NisO6BLBJPAFAAb/6akFaCJXqepCQbeOIEw8aWXfwd2DW
         vi/HvTZo+slcw0vaFgovgefxJ6FV951TDelECzj06M4OUVB01aQrmBbjB4cXtbplPlwb
         DK0jyB9vlGrf6fpt/zpWe2BExyKIeffwZvzWDHDwaBdFpwOTlHae8p9fIYrCeHiEURDp
         9swIFpyBfOStomNFrP9C4hQc26E5+mB4e+9TTySZyjp2jcuCh5Q2EeisQMXIfIyEOH0s
         QqKg==
X-Gm-Message-State: ANoB5pkycV/fun79MaJukPiaG5iE6zvPZpQG+0K5Y4qccNcE3KsrkwUw
        6PnxROSbaRtOWhrNE5xuTMU=
X-Google-Smtp-Source: AA0mqf4yT8h3p5NrmHSWftcUtTaSUa+jwGr3YobBULEFCuv+CfdJJt18WXqKf/JDTxU8cB7KRiEsIA==
X-Received: by 2002:a17:90a:4283:b0:218:4953:58aa with SMTP id p3-20020a17090a428300b00218495358aamr49171431pjg.219.1669422008397;
        Fri, 25 Nov 2022 16:20:08 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z21-20020a63e555000000b004777c56747csm3072583pgj.11.2022.11.25.16.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 16:20:07 -0800 (PST)
Message-ID: <a3f2c913-f57a-4236-2790-5f9f17cc7494@acm.org>
Date:   Fri, 25 Nov 2022 16:20:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 03/16] ufs: core: Introduce Multi-circular queue
 capability
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
 <1a84dab482956b19cb513dc46e9689e07316e357.1669176158.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1a84dab482956b19cb513dc46e9689e07316e357.1669176158.git.quic_asutoshd@quicinc.com>
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
> +module_param_cb(use_mcq_mode, &mcq_mode_ops, &use_mcq_mode, 0644);
> +MODULE_PARM_DESC(mcq_mode, "Control MCQ mode for UFSHCI 4.0 controllers");

Please make this description more detailed. The following information 
should be added:
* 0 disables MCQ.
* 1 enables MCQ.
* MCQ is enabled by default.

Once that information has been added, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
