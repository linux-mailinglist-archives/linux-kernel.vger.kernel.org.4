Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5663C854
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiK2T0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiK2T0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:26:16 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE0711BD;
        Tue, 29 Nov 2022 11:23:11 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so13276735pjo.3;
        Tue, 29 Nov 2022 11:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zETXquZGMcVWweqj8mgh5HOi04CnNj7jDVi4H0cu8AI=;
        b=IYXsT/5u8zNQoEFZ6qXx6qQW6Tf4d4cR2hK/wNohPZs5kulAlC6AvnGFcH+iqazSmr
         bKX1xb3qs8WRfAtD5TSKgrv+ZEt6COijZi2AQR/GgCXhPI1ywFuo24i3WVVAucMGgBzJ
         ddVSMLW7TWv9fqtPKT6wy2yt8Iixih2hf3ZsEe7B6H/z8Vwpcdcj67bFT/bVClrIt5R9
         hJWDd0Csf2/So5sOLzKbuhvgAEG+KzfrfuvSTGY2o0vEEANhq+vs1iwr+aXO6tmeEmqx
         jAAiFPb6xnl+I/81VqEo7+7/tH8Oqik+TPQX3CEzpUmzy92hLX1pISQNk8ySxBv3jhLa
         n2Lg==
X-Gm-Message-State: ANoB5pllep2F4lTt6BOSLoF/LSniaZBgAFt/dx6NhAtJz9boqK0MbK7R
        +EqbXP5+nPJpfB1eOjSLApc=
X-Google-Smtp-Source: AA0mqf4NYPNjeuMxg8hLIadVfCB7Co/WiQiQZXahjPmrYW7M5r513HoiLmE2ZQ696ZRLCYY6FJZ9Fg==
X-Received: by 2002:a17:902:cccd:b0:186:fd58:c706 with SMTP id z13-20020a170902cccd00b00186fd58c706mr39180783ple.4.1669749790466;
        Tue, 29 Nov 2022 11:23:10 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7d15:8e62:30bb:9a14? ([2620:15c:211:201:7d15:8e62:30bb:9a14])
        by smtp.gmail.com with ESMTPSA id p21-20020a631e55000000b004597e92f99dsm8510462pgm.66.2022.11.29.11.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:23:09 -0800 (PST)
Message-ID: <90bf11b2-70bf-8780-dfa6-40c8df5a682f@acm.org>
Date:   Tue, 29 Nov 2022 11:23:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v7 07/16] ufs: core: mcq: Calculate queue depth
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669747235.git.quic_asutoshd@quicinc.com>
 <9497b4a0f72e8cbc712e328d1f9ae38635eb2284.1669747235.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9497b4a0f72e8cbc712e328d1f9ae38635eb2284.1669747235.git.quic_asutoshd@quicinc.com>
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

On 11/29/22 10:53, Asutosh Das wrote:
> The ufs device defines the supported queuedepth by
> bqueuedepth which has a max value of 256.
> The HC defines MAC (Max Active Commands) that define
> the max number of commands that in flight to the ufs
> device.
> Calculate and configure the nutrs based on both these
> values.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

