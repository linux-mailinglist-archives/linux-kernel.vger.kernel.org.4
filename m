Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253515F13B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiI3UdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiI3UdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:33:06 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BC1D7BFC;
        Fri, 30 Sep 2022 13:33:02 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id w2so5233321pfb.0;
        Fri, 30 Sep 2022 13:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yZ3CLoEWbUsNwnFTHokhMiNfQQdxMtKbg95qd8xX+Qs=;
        b=76OxGXMV28zLtnRfRipcIJHTBx3g9NNiwoOp8ozjTcWGYJPKG3GewZkAgFFq3MpNjq
         kV/wYaDl3PHAbRvEa51DJl77r8nQsaidPe1RKPM5ztSPrTqgYZEHWIfkdT8oVRnHobrM
         4oJRGqUkkTC/OUPcMyDK2AQLYM8ba7m5nz0cSpnYQWPE+7b79ocHtJRE0RzR/WJ943fB
         nLYzCecGJGLFSAXrWJMkNtqfhvMhhnD06Jnb0omW/MIa/emb3JLZiBGW5d5TexUAdxAy
         MPIrA8zfaNEtZ+LWfUZoiIoE5KS7x3M+D3hgw09SnipR7bYB2SXnGyqS19Ac46O8rWHv
         Piag==
X-Gm-Message-State: ACrzQf0byMLDAPguRLRKzTffchNdr28m5sVcywDub24tl7Mlid5mV36Q
        9cB3Th4qpLK1ifKHjNhzxIw=
X-Google-Smtp-Source: AMsMyM7cg0Nv3Oa527FRcJVGwCF4Q6c3aQHYr58EDZimjc5R13fS3zWqoKMxu5ewbftHD+1yDp8sog==
X-Received: by 2002:a05:6a00:2314:b0:546:ce91:89a3 with SMTP id h20-20020a056a00231400b00546ce9189a3mr10703571pfh.77.1664569981596;
        Fri, 30 Sep 2022 13:33:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9b89:d9c:f74c:7711? ([2620:15c:211:201:9b89:d9c:f74c:7711])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001755e4278a6sm2301441plb.261.2022.09.30.13.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 13:33:00 -0700 (PDT)
Message-ID: <c3673ae6-4300-4709-febd-953552a9c81c@acm.org>
Date:   Fri, 30 Sep 2022 13:32:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 15/16] ufs: core: mcq: Enable Multi Circular Queue
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, quic_richardp@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, beanhuo@micron.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <c670b4f07fec06652d281ff0a390f3d2ef347d70.1663894792.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c670b4f07fec06652d281ff0a390f3d2ef347d70.1663894792.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 18:05, Asutosh Das wrote:
> MCQ is enabled in the Host Controller.

Patch descriptions should be written in the imperative mood so please 
change the above into something like the following:

Enable MCQ in the host controller.

Thanks,

Bart.

