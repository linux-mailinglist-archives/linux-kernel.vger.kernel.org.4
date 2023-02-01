Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8703685DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBADFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjBADFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:05:43 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE09A5D2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:05:42 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id bb40so8144247qtb.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2BzMaWSUkj8EDnF8fjbvdcop5Q3Avd1JgESuZNfB+o=;
        b=Is/6fOxIVI8M0bd8R7Fy/4Ihdq6UXuaz4tnnYG5hYI5231f+oLXxe/Ik/pKsUXsxsS
         jiOkbeNd2+Z141DkDk6AxqJvIoxEIHwdDGudSbge3kcH6Onnwg4+/nsCLiPXThQSH90G
         o7Qdx7yHnoKqwwm82XE5YreaSJcZPXgnNMOfKyDerLjzS78i9D3uYI0ze/bvBSbUm5N+
         yyELOTVNIG/v0THZh9i1dNVDRNkiPA4bWwQ7rItS36DaJWeNoN3JenGtHRdhxdyarpht
         eO5GKma5LsT6e5ckz6YMtp9IuHHdv82KocJSpe6d5Z3hclzE5Gnf9rYa/MctwsYwmUq5
         PBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2BzMaWSUkj8EDnF8fjbvdcop5Q3Avd1JgESuZNfB+o=;
        b=Z76+58eZOd6WS7zfQYJ5KyC5GFNdwj92fIh+3XEGZhHp0OYwlHSZQpLkSxnRQuSrJ8
         s+lYwQ+ObUtwy901iarvGuECht9HHBKbnGy6mtwOZmH+v5mIDKyZdfFnMLDVVOy5pi6J
         fgUQ6Z7Yet/KljzR+k656B4HsWyXXEmzY8VcJg96V5nzaNCb8Z6rOSkdZYK2tCDtPEJA
         zRFfmqKVSqtieO3l3KYgzc7NZLu61aP9N6dGcPSY/HjbBgHEO3qjx6MZukTQrwD+rK9a
         TAjF6qLSQYgZi057tSdeF1Wuibm/V1HjZo1IgCRsqoJwhuj6Ot3HSA1+yohQoTXWxQUZ
         vcQw==
X-Gm-Message-State: AO0yUKWrn2Nbdr52M/TyDqTqB158VDc6Dhogu1P1Aohs7d7yggIiA6xV
        MdkaeHeTG/PXu/SJA9CYcUy6Og==
X-Google-Smtp-Source: AK7set9Uvevz/T7MAM3nTgoNdTHemNw5IFZm6aotpv9qD/FICRJqTFmELsTReDvgcu32Pzdpsj9qTQ==
X-Received: by 2002:a05:622a:11d0:b0:3b9:b9ae:1476 with SMTP id n16-20020a05622a11d000b003b9b9ae1476mr1134250qtk.40.1675220740964;
        Tue, 31 Jan 2023 19:05:40 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id q1-20020ae9e401000000b006fc2f74ad12sm11306592qkc.92.2023.01.31.19.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 19:05:40 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>
Subject: Re: [PATCH v2 2/4] Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855
Date:   Tue, 31 Jan 2023 21:05:38 -0600
Message-Id: <20230201030538.56293-1-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <a18751a0-f51b-0a3a-58ff-2062a9dc46fb@linaro.org>
References: <a18751a0-f51b-0a3a-58ff-2062a9dc46fb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 31/01/2023 05:38, Steev Klimaszewski wrote:
>> Added regulators,GPIOs and changes required to power on/off wcn6855.
>> Added support for firmware download for wcn6855.
>> 
>> This is based on commit d8f97da1b92d ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")

>Drop. If that commit is merged, how is it useful to keep it in git
>history forever?

Sorry if that wasn't clear enough, what I meant to say here is that I used that
commit id as the basis for my work, and it's not based on having access to the
schematics or spec sheets.

-- steev


