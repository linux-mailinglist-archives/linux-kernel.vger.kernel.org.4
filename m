Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA89611CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJ1VtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJ1VtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:49:22 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B7824C945;
        Fri, 28 Oct 2022 14:49:21 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id p21so2081704plr.7;
        Fri, 28 Oct 2022 14:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJODnJHrzUQ0dJuxRpB7z2CDN1C20lkbwqTM9JUYhfw=;
        b=ENujUU5MBhOxVJKpYJJQHf4avdc5kfxk8bsEftrP3QC2XehWZ9v+T4dJV/P7mDuSFT
         6dEF6pUPmdOJpAWJomSrUu/OUbYPtYoD6Yl/4fGf5TgYHS/8iFVK7daDZGmrm0/1czjD
         HeRmEJ2Qn0UqStwttHb5prSp2WaC+k+rYMsyluwXYBgCdiSuSXJxizhA+qP85hLgdakQ
         2VwC0E/0xjNfd9eeIhsXblMDoO7svA3K5X+olEj4kWPTTdOw2mEptBVq2M4s2Ioy0yNk
         abAfBNDN64uPZKZDKZLyAS36fdpj5cPgNX8ZzrjmGzSawI0JFdRPBtpHio4gWrJkQK7c
         cpJg==
X-Gm-Message-State: ACrzQf0MogwuC5CE26UZxu7RgH35q8XyQsSVV2zp/jHXXHe/4d6Wj8nc
        GGsuiF7ukO0OI9mjDGejndU=
X-Google-Smtp-Source: AMsMyM5P2LZ8aSwfa5LdH2ue6RAAbIfPpu+99Klju67VAEE5toHo494tXyRAWIZi/fM84K7FJOQ0lA==
X-Received: by 2002:a17:90a:df91:b0:213:8a69:c504 with SMTP id p17-20020a17090adf9100b002138a69c504mr7001564pjv.82.1666993761200;
        Fri, 28 Oct 2022 14:49:21 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001830ed575c3sm3528860plg.117.2022.10.28.14.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:49:20 -0700 (PDT)
Message-ID: <777e523e-1a6f-2b4d-0470-3e293b28c110@acm.org>
Date:   Fri, 28 Oct 2022 14:49:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 11/17] ufs: core: Prepare ufshcd_send_command for mcq
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <c06dfe2ec39f2f1d4914ee3330188a41f1c4408e.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c06dfe2ec39f2f1d4914ee3330188a41f1c4408e.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> Add support to send commands using multiple submission
> queues in MCQ mode.
> Modify the functions that use ufshcd_send_command().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
