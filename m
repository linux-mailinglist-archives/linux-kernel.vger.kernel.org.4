Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E50611D31
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJ1WHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJ1WHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:07:08 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88F24D8B4;
        Fri, 28 Oct 2022 15:07:07 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id f140so5919005pfa.1;
        Fri, 28 Oct 2022 15:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11MBp1IM6epfNRa6WGxmP78EmlDXuWEW75mkkBPDIXA=;
        b=lbbnygZxGgltx8HpFmusKi7cKH25H39l9P0wLek8+6gSfr9IbFR3BnbVisS+y4Qcn7
         GLUC6xY6FrNKrU1FzmI8S+W0bxchNKF02kBAEKJRX7+fmaIdw1ut5vuWY9V+sMP/i5I5
         XAYIyCO9aYeVwAEyx5Hp/hDYe9Ov+5qjVmYO3TMDUrFvxWTW1G58vVX0UbPyKDQ16o3G
         BuRv2iD2iM1mhnhsBjfO3NO9HDs1bsMlKdIXn51G/mG0bcGmSj47LaumiLjB1gwockIY
         i9FkL7j7vQraYjllB3UJlYdscwFIcXG5dR8iYY2q+00IsMVy3hAuAlNh924dmel3Rdvq
         X97Q==
X-Gm-Message-State: ACrzQf1svx8VHDA3p9aOAIgy1iv2/8AXyGggdB5vkzDdiEgVDZ9IZlyy
        nP/5ZWbMMc6a3SFMt1yUZow=
X-Google-Smtp-Source: AMsMyM5ZR7gB2M86QUhS73IyhHAVsWAx2CN/XCjDT1JJcUEnNIyk/Qbs+phWsEJ0mQ3ASQxEgo4YMQ==
X-Received: by 2002:a63:441a:0:b0:46f:79ee:917c with SMTP id r26-20020a63441a000000b0046f79ee917cmr1408721pga.165.1666994826846;
        Fri, 28 Oct 2022 15:07:06 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902d51100b001782aab6318sm3609249plg.68.2022.10.28.15.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:07:06 -0700 (PDT)
Message-ID: <aec55553-cfd3-07d0-06a6-832e76ecfc24@acm.org>
Date:   Fri, 28 Oct 2022 15:07:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 15/17] ufs: core: mcq: Add completion support in poll
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
 <4422b890dd7cb2f4c396669012c4247467c7b8e2.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4422b890dd7cb2f4c396669012c4247467c7b8e2.1666288432.git.quic_asutoshd@quicinc.com>
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
> Complete cqe requests in poll. Assumption is that
> several poll completion may happen in different CPUs
> for the same Completion Queue. Hence a spin lock
> protection is added.

Completion Queue -> completion queue

Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
