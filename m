Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01D95F13D5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiI3UnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiI3UnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:43:17 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F01F0CF7;
        Fri, 30 Sep 2022 13:43:16 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so7891994pjb.0;
        Fri, 30 Sep 2022 13:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uoEBw3W7OsVpJKjKmaRc7fAyy8A7s8XC6z9MFE/z6qU=;
        b=5V3cJRaaQb+m8Mtu/kuSeb7TW8zCmtH5VeV6H5vypjB+JEM2WXafqeJg/5NCo22TG4
         r7D0emyf/U/oBOM3AKycZ7lqqIHL0P3LrxCH87d4lM2G0i/YqxT47voiokFYGqYJp/vc
         PWL6yOcmBYf1VWTezx9OkEKSr/hHqitqcvB1BzKrbobzEzzdwhfMDkHCNn738AMBLBu2
         g1K3O/VmzHnZ887SHi6E51TFDXnwyPcDDpIIIx7VGnvZZ9zWYpphktYK81z9U4oN9Czs
         jMnrljtaq68bHpaB+NFPyiu72S+TW75vxa+L0gqnL8y74UOmUnJJGpl/yZl3B/47K6ys
         VNvA==
X-Gm-Message-State: ACrzQf3YkCoBWiLwSWYul0ZiOVjyGIRn+gKdqRCKaEyTkEt39ATk0Vyp
        FrK1alENrqYdBDo6kRAMnt8=
X-Google-Smtp-Source: AMsMyM4oysXNB5xj/YYoe4sPyHFFiEwustUoMOQMKZ2ye4ucnpG1LlnuIPuKoUzQJwSRc3nqWkpQKQ==
X-Received: by 2002:a17:902:d4c2:b0:17c:9872:4b50 with SMTP id o2-20020a170902d4c200b0017c98724b50mr4077985plg.146.1664570596289;
        Fri, 30 Sep 2022 13:43:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9b89:d9c:f74c:7711? ([2620:15c:211:201:9b89:d9c:f74c:7711])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b0016ee4b0bd60sm2326691plb.166.2022.09.30.13.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 13:43:15 -0700 (PDT)
Message-ID: <10da95ab-f4f8-f079-d4c5-863e134ecf1e@acm.org>
Date:   Fri, 30 Sep 2022 13:43:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 12/16] ufs: core: Prepare for completion in mcq
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <21bb8fc81fa4394645cd6719374eee3a5d605c2d.1663894792.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <21bb8fc81fa4394645cd6719374eee3a5d605c2d.1663894792.git.quic_asutoshd@quicinc.com>
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
> Modifies completion path APIs and adds completion queue
> entry.

Please use the imperative mood for patch descriptions.

Thanks,

Bart.
