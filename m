Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBF6B652D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCLLBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCLLBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:01:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EEB2FCD0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:01:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bi9so12229403lfb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678618860;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jYZfawWjXMVBxW1629eKjPSTUkMUocoPnX/odlKuSj4=;
        b=S5eoAJzG0AGeu7iJZkhF+L+RCfXKNMel8Xj/1qGhcyiBZczhYSttm6HGRVYfNxIxBl
         S+jVntgrto6Z7fUxYDqP+QLGYvswVNp53pbPx2kQyAgwVncb9dBatXXfmAJ7QsQFseWk
         rNl0ye0bYKY9cO0glhOg1uuaSFDmcHIGoH0DxKn47wR1BFKYwIQvu+A9m89Dn2v42dsy
         fGpR7fI5mIYl25LnIa8+NhSJX+KC6wU/x/vtrZ5PhmcIcz07gvGqqCnL/jH+Riflp83z
         VCGq4euRw20W7ayVVRQ+8qv8rcD0cHGMGBhWtZqIaP2uZ8wpwGUoKBvpXc/Dq+a3mXBa
         HaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678618860;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYZfawWjXMVBxW1629eKjPSTUkMUocoPnX/odlKuSj4=;
        b=kEpwNnWD0tiTNxHdC2rFf6/TdCFqEsY/yr8s0uzA1uZYzn85n6pdONskRcAyLCbya4
         2fc45YpBU3zeDD1PtjmSL1K7uYBU882546Y/XDsrsETt/ohkh2p0YZe5JU5qRalr3HzV
         aVtPlr6dgWxraQwTQNcOHSoHrgQx3bTBkjfCTRg7dqLgdxupKy7j8WzeMQLPmkySNkDH
         DwXkzYobZkuwC3JVdg6v7fam4PtdcHf9wVn5c/49yIBddZM6Ruvp4fqvweUlBcoLUaMK
         Mb9t/sVAprGPys0lpRoArYapx8IM6fP4jhp0JLlcbm/29neEb57v5THWxFT3gQxi110n
         K/vA==
X-Gm-Message-State: AO0yUKUjKF2KIbSIGhsffVl8E0puOHSCnYPEr+JZ4X4sNHdWFUDWMCQg
        /BbLx23D0VSXF9lMpsOHgdWCNbLQ1g39zmAx
X-Google-Smtp-Source: AK7set9HFZ6HQr51DKEi5M8kZRFn7I470FdVnEk0sD07IgicPRn6sM+jq/jzgYL0h2h/T7cBNdZUaw==
X-Received: by 2002:ac2:5106:0:b0:4db:3a92:2c85 with SMTP id q6-20020ac25106000000b004db3a922c85mr8944143lfb.67.1678618860468;
        Sun, 12 Mar 2023 04:01:00 -0700 (PDT)
Received: from letter4.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id e8-20020ac25468000000b004e83fedf354sm222828lfn.122.2023.03.12.04.00.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 04:01:00 -0700 (PDT)
Message-ID: <640db0ec.c20a0220.562d8.073b@mx.google.com>
Date:   Sun, 12 Mar 2023 04:01:00 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b65d54e3-b78b-654b-4932-03afefa2e950@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 12/03/2023 11:49, Sergey Lisov wrote:
>>>
>>> Anyway, I said last time this looks compatible-specific, so I don't
>>> think we need another property.
>>>
>>> Best regards,
>>> Krzysztof
>> 
>> I agree, but I'm afraid of introducing regressions by enabling this
>> workaround on systems that don't actually need it.
> 
> I don't understand why would you enable it for systems which do not need it?

OK, then how do I find out which boards have the bug? My only idea is
"search for samsung,exynos7-dw-mshc through all devicetrees, find vendor
kernels for each of those boards, and check if they have the workaround".
Is it really that better than enabling it selectively only for
known-affected boards?

