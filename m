Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC364D4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLOBGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLOBGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:06:01 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E646674;
        Wed, 14 Dec 2022 17:05:59 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id ay32so3991822qtb.11;
        Wed, 14 Dec 2022 17:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9m0a1H/CtUXuaX24hHVpraAbCzt5wPCF4weiAuRyms=;
        b=V2bTzJm5btyIOLwVZCHmdRewPH9eT9/BtPYJvnYGOtx6k8AMebtZGiFjFv7rPfnWZf
         juI2fv9Z+/CyUbN0SSzpa8rpp/3NdaqDjbNNu+N5RddlEdO1bG9qpj6iYbvRa8LO5zQP
         2x3M87a8MqB7q9wrDriWcdpIc4k15LV03YxHEcGWS+x9/QG0wTprPjPdoQ3U/HLYPAT3
         9vFReAdAAUgCTp2hCj63UcUe4DMcy7PdGjA/DfnLjxLOqd5HVAhv298g37xGVOUfpm4n
         gfL9bOj6+L8Ei/Az+OcOjLYzAD3DqC7/+7l7P9ZgUTFwYyOtILLISJpKvyu6VGm3Hn26
         yBpg==
X-Gm-Message-State: ANoB5pls9c0Y6DDBolougtsHy0cOUKstGqxbIRc8uEX9jUMFSCnPXZZD
        qNYMael4PQ471R4AovFmmXk=
X-Google-Smtp-Source: AA0mqf6CdE3MZ10DeIz46rpJiApvUl6vcThcmknQBFjlGDUawvrbRjXXd213C2g7oodqBy5qitsFSg==
X-Received: by 2002:ac8:4751:0:b0:3a8:11d6:2d09 with SMTP id k17-20020ac84751000000b003a811d62d09mr21980222qtp.36.1671066358765;
        Wed, 14 Dec 2022 17:05:58 -0800 (PST)
Received: from [172.22.37.189] (rrcs-76-81-102-5.west.biz.rr.com. [76.81.102.5])
        by smtp.gmail.com with ESMTPSA id ge17-20020a05622a5c9100b003a82562c90fsm2586480qtb.62.2022.12.14.17.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 17:05:57 -0800 (PST)
Message-ID: <1e224fa1-7cb3-25cb-8e63-df42b137e96a@acm.org>
Date:   Wed, 14 Dec 2022 15:05:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/3] ufs: core: mcq: Add Event Specific Interrupt
 enable and config APIs
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, quic_asutoshd@quicinc.com,
        mani@kernel.org, stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1670990763-30806-1-git-send-email-quic_cang@quicinc.com>
 <1670990763-30806-3-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1670990763-30806-3-git-send-email-quic_cang@quicinc.com>
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

On 12/13/22 20:06, Can Guo wrote:
> Add two APIs to enable ESI and config ESI base addresses.

If this patch is reposted, please change "APIs" into "functions" and add 
a sentence to explain that calls to the exported functions will be added 
by the next patch in this series.

Thanks,

Bart.

