Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816F70FC76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjEXRSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjEXRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:18:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A98FC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:18:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso10173145e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684948706; x=1687540706;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL0229BoBpNJOI+Nzjlz2oCun7fW2ym7znDfwinMLQM=;
        b=jj0MwJzaDakiH6V2M55C66XVl7NKA/xqDkbt9zy8hCStHwIC07N6BsrjPdXP5v/oz3
         yyEjZTqPdYj1Hd1mh7Z2t+8ZRUmwNnEwmEtXsn7Xhbau9CKn4Bv7ID1J2sSdfPpv/9q1
         XqVNWUrY9dRw4meJnYIURwZRSAWf91CnFX71DqXYLOv71cRiBeOZ24doCwOmrLc1xbr3
         EweDp3dVMlVDixurzRWNZYFox3mtuHH1o1/1KueqwZzfcsgUdn8ZfTsfi6V8khLGv6fo
         +qiLB3uBSHIPkqkZXw2Py8TFkrlx75CbG+crEAkMJY7WAcV8Y0E0a8GBYMmRn8afGhY6
         b2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684948706; x=1687540706;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DL0229BoBpNJOI+Nzjlz2oCun7fW2ym7znDfwinMLQM=;
        b=elu++vC/NJtuNDhyEYYO8I+bYaYuOx1gMfllP0MXLzwN0cHVyGOwtL8yMd3ZU+nKZc
         llnxZOeXoKEw7OxjvVEGCcUxF/jPWDRWDf2xuGy5nu17ANoU+iGuEklQGytK3FNqYjLn
         Ybx/8NvUCj9Nr3ZqKq7/TMOjSSQuaCs8fZnYlt/ndwApGM599PAENQ0xphYzwFadBTlF
         T+MVFGfc52LZyZxEeZh9KyIHCi6985yAzAcwpThJ7u1OO1z7QLpeO/Q9ECHc5IKjTh5G
         aZ0mBLCqjyqaeYzzZcPSf1oSS1aSbO6S6GVvt6BV1UNNcCbOdhSeVa5yde7Tke/LXJpy
         6fdQ==
X-Gm-Message-State: AC+VfDwFWg4NYZ762A+51kZma7PqFVfBIyFeq4O2elRxjQYobKyWEoMh
        ww4VNMbPSOn4CT6N4Rvspj7cjg==
X-Google-Smtp-Source: ACHHUZ7EtdSlJtb5r5XsSMh9tkQ/f0DDFMNu9ia48hiYqe6yWGQPoYuj/WNNHA1F/l+o3arN16XDbA==
X-Received: by 2002:a05:600c:3783:b0:3f6:3486:1396 with SMTP id o3-20020a05600c378300b003f634861396mr346875wmr.33.1684948706082;
        Wed, 24 May 2023 10:18:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003eddc6aa5fasm2917304wmd.39.2023.05.24.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 10:18:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 456A41FFBB;
        Wed, 24 May 2023 18:18:25 +0100 (BST)
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 00/24] Drivers for Gunyah hypervisor
Date:   Wed, 24 May 2023 18:13:16 +0100
In-reply-to: <20230509204801.2824351-1-quic_eberman@quicinc.com>
Message-ID: <87cz2pveam.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Elliot Berman <quic_eberman@quicinc.com> writes:

> Gunyah is a Type-1 hypervisor independent of any
> high-level OS kernel, and runs in a higher CPU privilege level. It does
> not depend on any lower-privileged OS kernel/code for its core
> functionality. This increases its security and can support a much smaller
> trusted computing base than a Type-2 hypervisor.
>
<snip>
>
> The series relies on two other patches posted separately:
>  - https://lore.kernel.org/all/20230213181832.3489174-1-quic_eberman@quic=
inc.com/
>  -
> https://lore.kernel.org/all/20230213232537.2040976-2-quic_eberman@quicinc=
.com/

I couldn't find this one, but is this what it should have been:

  b4 am -S -t 20230213232537.2040976-1-quic_eberman@quicinc.com
  Grabbing thread from lore.kernel.org/all/20230213232537.2040976-1-quic_eb=
erman%40quicinc.com/t.mbox.gz
  Analyzing 9 messages in the thread
  Checking attestation on all messages, may take a moment...
  ---
    =E2=9C=93 [PATCH 1/3] mailbox: Allow direct registration to a channel
      + Tested-by: Sudeep Holla <sudeep.holla@arm.com>
    =E2=9C=93 [PATCH 2/3] mailbox: omap: Use mbox_bind_client
      + Tested-by: Sudeep Holla <sudeep.holla@arm.com>
    =E2=9C=93 [PATCH 3/3] mailbox: pcc: Use mbox_bind_client
      + Tested-by: Sudeep Holla <sudeep.holla@arm.com>
    ---
    =E2=9C=93 Signed: DKIM/quicinc.com
  ---
  Total patches: 3
  ---
  Cover: ./20230213_quic_eberman_mailbox_allow_direct_registration_to_a_cha=
nnel.cover
   Link: https://lore.kernel.org/r/20230213232537.2040976-1-quic_eberman@qu=
icinc.com
   Base: base-commit 09e41676e35ab06e4bce8870ea3bf1f191c3cb90 not known, ig=
noring
   Base: applies clean to current tree
         git checkout -b 20230213_quic_eberman_quicinc_com HEAD
         git am ./20230213_quic_eberman_mailbox_allow_direct_registration_t=
o_a_channel.mbx
  =F0=9F=95=9918:10:45 alex@zen:linux.git  on =EE=82=A0 review/gunyah-v12 [=
$?]=20
  =E2=9E=9C  git am 20230213_quic_eberman_mailbox_allow_direct_registration=
_to_a_channel.mbx=20
  Applying: mailbox: Allow direct registration to a channel
  Applying: mailbox: omap: Use mbox_bind_client
  Applying: mailbox: pcc: Use mbox_bind_client


<snip>
>
> Elliot Berman (24):
<snip>

>   mailbox: Add Gunyah message queue mailbox

This patch touches a file that isn't in mainline which makes me wonder
if I've missed another pre-requisite patch?

<snip>
>  Documentation/virt/gunyah/message-queue.rst   |   8 +
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
