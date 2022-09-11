Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB895B51B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIKW5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIKW5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:57:14 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A6A21E2B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:57:12 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1278624b7c4so19046812fac.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date;
        bh=pVS7bTONLkZB3+cDrU8TPMMOnP+Z4vmVq9BPhDF4ly4=;
        b=L5yOeUqc2rtJy2Lee262h1//ZOpxGCQKa1YIzyiaDjObJsUY3dG0q3Y4PTk6VRl1lP
         +KinOOuiAy3wCGHamWeC0rNY4rIzzKr4RyTjs0q643DO8zqlideTQzVYzVEYbvO4Lboq
         ftpXb8AZE1g49+iprxzizCxoj5qJBIIAL+CHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pVS7bTONLkZB3+cDrU8TPMMOnP+Z4vmVq9BPhDF4ly4=;
        b=mWaBWPQcY52qadiBiOVSiVP2oFGRnXgg9pvlveOX5x/2n/FwqYRXBPBnB+Ta2gkQJI
         wzKEEgIAkqahCNhEclTFrFzxl5rhYzMZkyN+loNrWcfRuWjo7em8yB68mPNMDbVBW3qs
         KOxs+RA1sskOZ57nAwVytRJBzHtFU6xYxQgFo1EL31c88zTKCpBwvDSNuTIFuoMKI0mD
         ef137CvevSJ3iOUk6ClU+AVUwKpLjUBjb2BnSDUgSB1JrezXFnZ5yts3tnRjyukDHQ01
         SI3UARBeeYyVS7X2AbNiXZIXdfI8H04a0Xi8SMaal+K0V63wkFDE2cPLmpjXsUKHWIwi
         naRA==
X-Gm-Message-State: ACgBeo3Ahtq/smVC+y/xCLodoApbOyrJCT7iTX7VCZ3Upzv6GsxBBzlY
        EvCOnjiPtCUR8rUnew+i5Thcwvdfzc1jkayAQ2HQbnHCw0E=
X-Google-Smtp-Source: AA6agR7Gknt665dcjQGkcGHk1lrhFk+/hwDPLVqBvqwsv4VUJpmZ6ZfUing+21n82woe2ytImsGVHGiVUyZIogehABc=
X-Received: by 2002:a05:6871:6a1:b0:127:3a21:7e00 with SMTP id
 l33-20020a05687106a100b001273a217e00mr10579741oao.44.1662937032318; Sun, 11
 Sep 2022 15:57:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Sep 2022 17:57:11 -0500
MIME-Version: 1.0
In-Reply-To: <1662643422-14909-7-git-send-email-quic_srivasam@quicinc.com>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com> <1662643422-14909-7-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Sun, 11 Sep 2022 17:57:11 -0500
Message-ID: <CAE-0n53xOdgbPcsQr40N0HbCaC7gpM=QLByoUh1qhQ-=PzA90Q@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] remoteproc: qcom: Add efuse evb selection control
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-09-08 06:23:40)
> Add efuse evb selection control and enable it for starting ADSP.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
