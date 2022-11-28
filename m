Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8663B4F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiK1WuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiK1WuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:50:12 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4F2A264;
        Mon, 28 Nov 2022 14:50:11 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id y17so3755311plp.3;
        Mon, 28 Nov 2022 14:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KquzmfSi0NA47Qv78KSdk0ORv7ZZ1H4/bzj3n1etGjk=;
        b=MKVX1DEB9ReAJsqO+mBkKcteFHogI+0VYUvXEWn0M8Vjz6B1fEtj54a2b9aXAbGpWC
         3Vr4b4JUu6KTeXNHuiNyIOJllbTU/tvd4G4ptrxVcZPTq27gukYhLOkOn8yzoOlENuAC
         Jxly/jfQ+kSVoPKRzzPGDXd/Jnr+t+y/wP4aTz6znd1Xt5QlFiJ+FX7ScNdZJIWUWhkU
         0xrUCE7aHiKlbxQjW5J+F3LrBwFIJH5Tzi90Q//qoBfBRFvD9/k5hFcjF+ldvPfQ9HIs
         KEe5BEY6t6OCK6Eq4otZe4vUIZ0q4uLHxFZLoOARHykyssyOoKXyrMqrSxqPDfEuCBWi
         Ykbw==
X-Gm-Message-State: ANoB5pmOiBjZTccS5fUEyvhjBvRQgPr6GYbWJ4YIa8UhSDJ7C5nb2OWy
        jRTrCCdlFQm4T9havl6Y4o4=
X-Google-Smtp-Source: AA0mqf7ofGDQp7gg3zNuIrGDTzM2a9viH6fDxsCaInenqybhThOq9z05hR86MA2q0vKUlUmG/qxRiw==
X-Received: by 2002:a17:902:f68a:b0:176:71be:cc64 with SMTP id l10-20020a170902f68a00b0017671becc64mr35951629plg.141.1669675810783;
        Mon, 28 Nov 2022 14:50:10 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:95f2:baa2:773c:2cfe? ([2620:15c:211:201:95f2:baa2:773c:2cfe])
        by smtp.gmail.com with ESMTPSA id x127-20020a628685000000b00572275e68f8sm5435349pfd.166.2022.11.28.14.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 14:50:09 -0800 (PST)
Message-ID: <2b11383b-86fe-5b87-153c-1b4856445c72@acm.org>
Date:   Mon, 28 Nov 2022 14:50:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 09/16] ufs: core: mcq: Configure operation and runtime
 interface
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        avri.altman@wdc.com, mani@kernel.org, beanhuo@micron.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <52b1525a4d680999687a1f0721ea60fd4cec9eb8.1669176158.git.quic_asutoshd@quicinc.com>
 <ef519087-c302-3547-1419-2dcddfb4c646@acm.org>
 <20221128220842.GE20677@asutoshd-linux1.qualcomm.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221128220842.GE20677@asutoshd-linux1.qualcomm.com>
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

On 11/28/22 14:08, Asutosh Das wrote:
> Now it is queued to device management command queue in MCQ mode.
> However, a task tag is needed for device management commands.
> Do you mean that the task tag of device management command be default to 0
> instead in MCQ mode?

Right, we are using shared tags and that is why we need to reserve a tag 
for device management commands. Please ignore my previous comment.

Bart.

