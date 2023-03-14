Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87E06B99D5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCNPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCNPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:37:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1C9AB0AB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:36:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so63573048edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678808157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev005/KuLD4nel9Kg1+/+WzgyLUtBvia3LQUdWprBvA=;
        b=aGZBpzQ7pMlEsfaKbnnGUWxk3IUhqdMFGoFZTLIFgqUmaOxsQqXBB6Z08VYQF/9sfZ
         5tu3nXDVRNK6vR3RxFYd8eqMfdyuxCiYkNTc1Dehefq/Yb7K7RBrPCJfLG5pZCRG5p1i
         tmI/cVF6k53WOK3opjv9OcYYsv3+H5aQATVeGiglYBwA3qj5BjIdSzn01AoWj9vz/f5i
         t/sLPq1T/02ahSUCIxd8bp8IBe2h/X8NhxqWgrVUCkRUi0cfa4xmxv60MYxm3qsVwyGL
         hNYXfB0uiGokjdpn2jz8VR3I6hcgbT8n/s8xDpyTY6wgGfamU/Ukz9s6Mp4Hmogigr1+
         d4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678808157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev005/KuLD4nel9Kg1+/+WzgyLUtBvia3LQUdWprBvA=;
        b=nTPX6lRNnKh/SmMtb5TZNdTu7TNbJL77m4JF4brUl0k0HazC/yyASj56oJsJUeZrw2
         qh7x0j1xSRj+XFwNe2EPx6oE9788JZ0uULJ6l5B57RBt6zKsnClyN/ZguUqTY4N4pEnN
         KW4eJtON7WTTjslp9koeJlyTBxQ2rJXhA+1BtzZtOZoB5cj+6w8E1cjWKMydXp/RP3XM
         RsXpMQfo1juRYy3mIbNffpEFJqvR2iLniOpok6RCWalj/h1QPeLVJPDvODPpDAt4DofO
         Z6YMQHn2uScly29XOJJdNhKJRpqAto+KGihieiPNL/d1RN6BZRGBgRQe52u7cQLyKA14
         JtzQ==
X-Gm-Message-State: AO0yUKXbJHn1zmWu06yja10DECpLtMkfK8fUH0sGyp0a7d433mQvMQVA
        0ppsnzjlXdrpwwuu0Bi36uf58A==
X-Google-Smtp-Source: AK7set9F8IbQmvFhdJvbJjYaClMJwNmUEEJaEnY+uVvsDv1qaNkcLwHznxcryeTTvC4J5NTwXt18FQ==
X-Received: by 2002:a17:906:5792:b0:922:7b95:416a with SMTP id k18-20020a170906579200b009227b95416amr2793260ejq.36.1678808156935;
        Tue, 14 Mar 2023 08:35:56 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709064e4600b008cd1f773754sm1297838ejw.5.2023.03.14.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:35:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
Date:   Tue, 14 Mar 2023 16:35:54 +0100
Message-Id: <167880811569.329316.7671442810659168728.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207234735.201812-1-robh@kernel.org>
References: <20230207234735.201812-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023 17:47:35 -0600, Rob Herring wrote:
> The GICv3 ITS is an MSI controller, therefore its node name should be
> 'msi-controller'.
> 
> 

Applied, thanks! Let me know if anyone else wants to take it instead.

[1/1] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
      https://git.kernel.org/krzk/linux-dt/c/fce7defb8a46c31cf9384fee6e4b1e4920c46ff7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
