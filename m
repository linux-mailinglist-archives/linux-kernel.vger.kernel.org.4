Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4662AEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbiKOWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbiKOWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:52:10 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860DF0C;
        Tue, 15 Nov 2022 14:52:10 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id x21so10613199qkj.0;
        Tue, 15 Nov 2022 14:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6XCf3Cid6EuKMxTuNB1TmASKOrp/L4jyp5rSOVLLaw=;
        b=ePIog6TmUeNSrll84Y+07x8DeQKymTZ2GvBeYq0WhafOOeC/SaIEz/J0xQy2KR4GES
         c6M3aRdlAEeqmRiD5G3px7OJN7PvQjdxSqDY81spE+YnFoG98uXxxtJqNAl5A9e/rweS
         RGIGD8iEFBc2REN4BjeIC/oOsj5WRieqgNazw5vd7wm/gDWC7CzVFzr3M59vx5EtiwfU
         ncbfTG/6OWnh1TJ55a27Q7diVB6VKnMK732bBRlbRrUb+eEPbh8nnVlUxsjLasPflU9m
         T7BWUP/UHu8GvrLHKKoOH5kN93Dm7DDzuCKTvve1z+kgqIJ4jGA2GCZBrFBj5lz9pzHK
         /oPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6XCf3Cid6EuKMxTuNB1TmASKOrp/L4jyp5rSOVLLaw=;
        b=EvMydKvqr168IFEZlad4Qp81bCpekznMgvdDkAXrf1U8fGaqiYwsLUylkMzo8IUQTR
         QMW92Au2OCvSqXGWknW1quooR0MHfrZAkHnHz2NAPYo6pkOu9NR0r3ptcQslwNHxmQzV
         OJyhmXhrwva2p83tbe+RtGvdPo3g9rYX+fmVQ6haTmgp1tICGNmqOD01Wpui/qWh19LG
         k+w+mrr5kMBRw/tVPPumUuUMVr9rF9upmCoP9Pe8Om/nfsWn2f1u08o5h6JxWuSAbBbr
         72ZyxmfffwNSY8dO3qnmzWegdPO+bc7DWtp33GViGvGvkQXdS64BoJ1+gnXgysVZiwEH
         TT4A==
X-Gm-Message-State: ANoB5pnNgHphnxF5r7ZZMI57OmCO5kwYo244tTU3UcNS7kw13JlGdaST
        qaGlmrOfhgvoTNXWNcb00qSuqneb1FCPjA==
X-Google-Smtp-Source: AA0mqf5v2+sc+VGzI9tzx7I0l4UOokWuJYNlNBXBHCx7ZMl33ikze2zmI5C9d6NSYKmSrwmW83g4fg==
X-Received: by 2002:a37:40b:0:b0:6fa:28d5:4b36 with SMTP id 11-20020a37040b000000b006fa28d54b36mr17215139qke.346.1668552729219;
        Tue, 15 Nov 2022 14:52:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d16-20020a05622a15d000b003a540320070sm7968924qty.6.2022.11.15.14.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:52:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: broadcom: trim addresses to 8 digits
Date:   Tue, 15 Nov 2022 14:52:06 -0800
Message-Id: <20221115225206.4123398-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115105047.95281-1-krzysztof.kozlowski@linaro.org>
References: <20221115105047.95281-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 11:50:47 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Hex numbers in addresses and sizes should be rather eight digits, not
> nine.  Drop leading zeros.  No functional change (same DTB).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
