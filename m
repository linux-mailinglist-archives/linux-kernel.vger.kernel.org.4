Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A066435ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiLEUnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiLEUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:43:29 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417FD1209A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:43:27 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id q7so14917409ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 12:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HmaZKD4MQBPxWz7myy+7Xl+FJO9eTlwx8WOUjYiCzSo=;
        b=mnCoB6HI9JGjaPcUmGYmhX9UeoDTZST4gvYm5hJpf6rgCm8hvZVCydPLypzk3Fz1ZG
         02aR0TIv+KYzQIhm3DXlLxPtOziybd/aQ9mLt7fqw1BGrnepIgwHqevggXb1/5NTNMFl
         JiWx0hKOvHiI/EF7skV0Qr4MbflsNlWWrXc45yumu1FHJgcc1tajtplho9mLF19aOXm7
         rXVK/mPBVNeBZ9ISEG2y7GteSkR5SVTq10WfoiyjbeEgSysAWCD9ZBH+ghj7YGr78XTw
         XJMVw17Y2F1Q7q06dZ+KXJ0o6VVFJlcDERdlK1R+2wj1vpQdZaGS6y5vITgmUdCm/3bF
         /LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmaZKD4MQBPxWz7myy+7Xl+FJO9eTlwx8WOUjYiCzSo=;
        b=RHaQjRqLWn6MkiRQa/2pFW8Keh7bPo3TKOfJyxwPe3z2q7kIjiyR6ImDoLZPasUSZl
         whLt/dPnwtolgVZmQrqdR6rmxG9IuNnemN/oR9cddJpJ4JO45rrX9eDXeswYf5VBBS/T
         sJEdLj7Z7LHxV9zTI9MNCN2hyg4CwYYSgJ2f0RhWbvZfAID36pedzW47uvFLeHPe4A5j
         Makod9Yupd3/3gbaKvmTKWlftsbsPb7VXfaGcYS7t36yWJme5gYJugsQumfQVVqt7Tfb
         PZ+aoAP0ghHD+9tKFaYkpsp16PbGIJJ5q69F8l0BLbWZTKbFfmq7UcSq/IRETLcbX4p5
         wsYg==
X-Gm-Message-State: ANoB5pmV8+Bhr4liujyyl11VsAEq/29Z3t6NToH5wig7VNXw3h+IrkrG
        /eGAOvDuTFQMUOC10lmEFmGBnA==
X-Google-Smtp-Source: AA0mqf5xzi3HZkNjdnxCGu52MWyOjT/GrhJPV1I9+r3FwX5sb6XBSx85qfDj813B3AB/1ZPxOBNzwg==
X-Received: by 2002:a05:651c:1592:b0:277:2123:120e with SMTP id h18-20020a05651c159200b002772123120emr27765161ljq.4.1670273005668;
        Mon, 05 Dec 2022 12:43:25 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id s22-20020a056512315600b004b55b404d36sm1198865lfi.156.2022.12.05.12.43.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:43:25 -0800 (PST)
Date:   Mon, 05 Dec 2022 23:43:21 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
CC:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_3/5=5D_drm/msm/dp=3A_parser_d?= =?US-ASCII?Q?ata-lanes_as_property_of_dp=5Fout_endpoint?=
User-Agent: K-9 Mail for Android
In-Reply-To: <1670267670-15832-4-git-send-email-quic_khsieh@quicinc.com>
References: <1670267670-15832-1-git-send-email-quic_khsieh@quicinc.com> <1670267670-15832-4-git-send-email-quic_khsieh@quicinc.com>
Message-ID: <FF3CEDC6-E548-49BD-9695-DCF68C617024@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 December 2022 22:14:28 GMT+03:00, Kuogee Hsieh <quic_khsieh@quicinc=
=2Ecom> wrote:
>Add capability to parser data-lanes as property of dp_out endpoint=2E
>Also retain the original capability to parser data-lanes as property
>of mdss_dp node to handle legacy case=2E
>
>Changes in v6:
>-- first patch after split parser patch into two
>
>Changes in v7:
>-- check "data-lanes" from endpoint first
>
>Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc=2Ecom>

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>

>---

--=20
With best wishes
Dmitry
