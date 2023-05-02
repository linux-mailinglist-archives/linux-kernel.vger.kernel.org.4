Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA31E6F3B7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjEBArg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBArf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:47:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183E1FCC;
        Mon,  1 May 2023 17:47:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so3716690b3a.2;
        Mon, 01 May 2023 17:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682988454; x=1685580454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7upDMlCiFyS9IqWKLFQuuQHQDW2CbteKNbLQt2kIjHg=;
        b=kXmO8ctKGoDAHkIsPM3FvfZ3vXjOcJmhIZZH4ENpiHZqdCpC/FQi3SHUGaSpe1vGqf
         3RSZZkR7TFUIUJ/0k6hvfjGlBsri/B8lGlkmVIaUI6OY5BVgr7gfAhcGTJitmMvuRuVt
         ynhRnEF8/tR9sjzrNVvrl7I2Pbzp4o7UMFkxzBbXAZQS+M74I+6jpSHFkSc5FW4bJtWz
         cd98fD5hkVFG4p08TT0ZHuURAenGAr46Cxijxl0e493YaWVP67jIyx6+WOhhfNkmQTw4
         h5PqShzKIoR8FlKzUV80x9WhftxmAUXYCzhD0fAgLskYv0xBgaNAjN7U5WFHOv0L8OLg
         q9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682988454; x=1685580454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7upDMlCiFyS9IqWKLFQuuQHQDW2CbteKNbLQt2kIjHg=;
        b=JUmL6OocVsKckyIRAV/sK0mKsy3RsDJHpHN0iPsE41NkwyW8Y+ZXUsZ+GoKTgXqisn
         UwkC8pzcXnd/y3fQcpM/U6SLDlbPnaaTXByAIawa76xuuJhvKcLYdDOfKeRMtyybml5I
         Klr6dXJvz3oute9xbTWShLCQ5aO3gxM0SlSJifIPs7I4o0wgKx0cgc0V7XrQmyh7K77A
         R9XBB0q2TbsQzc4A3QohlZ97ONgBqds9/woyC+uEsj0F9N8h3gI0zaVsSpoE87Ydykxi
         Txb0ElfRARle8qDtd3weqbfQr5QSW79zeTqBszJfRGxaQvHHPgLLsgaGcEy8Cj0Dxz+V
         Je6A==
X-Gm-Message-State: AC+VfDzMWpdg+1ENLAxSNM0d3f3cJ4e6Ug6bYEBcYcoeB8xOWO7xstxf
        wLeuRYk8wS8xNMdZxVhxN0kIdHFq86o=
X-Google-Smtp-Source: ACHHUZ5Fw/kJT3CfItCahveMnIypup9kYq/96EjO9dmQNdmqIpax72ICZXOLeSamYMHoydHUCu6SHQ==
X-Received: by 2002:a05:6a00:1591:b0:639:a518:3842 with SMTP id u17-20020a056a00159100b00639a5183842mr23411910pfk.7.1682988453686;
        Mon, 01 May 2023 17:47:33 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id t12-20020a63dd0c000000b00513973a7014sm17359099pgg.12.2023.05.01.17.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:47:32 -0700 (PDT)
Date:   Mon, 1 May 2023 17:47:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] Input: pwm-vibra - add support for enable GPIO
Message-ID: <ZFBdobY1yxMXYfFt@google.com>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:34:28PM +0200, Luca Weiss wrote:
> Some pwm vibrators have a dedicated enable GPIO that needs to be set
> high so that the vibrator works. Add support for that optionally.

So this is not simply a power supply in your case controlled by a GPIO?
We truly can have both GPIO and a separate regulator?

Thanks.

-- 
Dmitry
