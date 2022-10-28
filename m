Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7174611D36
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJ1WHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJ1WHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:07:31 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D2124D892;
        Fri, 28 Oct 2022 15:07:30 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id q1so5937209pgl.11;
        Fri, 28 Oct 2022 15:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcpk8CmaMkGFoybxiTAHyQGaGi/qPUntpcpAOZKAFN0=;
        b=rjx3M8PDZLXIcEWpLwPo9k0dL44wtLIw1aiJyibSTvifT4utvBMi3nBDVgWTGQoIxx
         qoYSUzoGO4NRY1SnkZRMTbPGwUicjA58ELkgcT3HVetVfpztRDEeN3fwLgY872yYcRpz
         JVKFzrbxTKEmmYqAWPmHAI1dX01M+OYy2wrHYxGZH2oPkqWRW9gNvu9BmKKBbkESIlYC
         2t2ByqZItJYbFPEMwVd7mCe7ZXQeHvRHF5aiQz2IZI3dDadGSVP+6IJ2KXhGqdRgpmmP
         vOdHpfi+e70BUrd51hHkKH3apD47PCFqVIoHbSNI6Jqaqiq2QAsydlGVSAw28zpQg+nx
         fjDA==
X-Gm-Message-State: ACrzQf1TJfcHvd9jsYutaAJhkhsJW4WysxU7GMpcuGsnZGa8xskcLu0M
        m7kLPhTgiLc83MzOTXAuWb0s2MRJJo8=
X-Google-Smtp-Source: AMsMyM7q5jdgy66puytik9g5+Lb6M9f+36JxwW+qB34UjjwetMgf6YTetQX0VCWuEzod2J5PBCZ4UQ==
X-Received: by 2002:a05:6a00:14d2:b0:56c:b1c5:c5da with SMTP id w18-20020a056a0014d200b0056cb1c5c5damr1326952pfu.2.1666994849556;
        Fri, 28 Oct 2022 15:07:29 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001714c36a6e7sm3464387pll.284.2022.10.28.15.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:07:28 -0700 (PDT)
Message-ID: <a3cf0510-a502-b623-4abc-cd02b9074501@acm.org>
Date:   Fri, 28 Oct 2022 15:07:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 16/17] ufs: core: mcq: Enable Multi Circular Queue
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
 <4c7e03d7d99e305a8e5ae0547fa9648a2a910fe2.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4c7e03d7d99e305a8e5ae0547fa9648a2a910fe2.1666288432.git.quic_asutoshd@quicinc.com>
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

On 10/20/22 11:03, Asutosh Das wrote:
> Enable MCQ in the Host Controller.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

