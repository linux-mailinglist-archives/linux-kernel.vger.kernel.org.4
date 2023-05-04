Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439146F664D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEDHuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:50:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F89D;
        Thu,  4 May 2023 00:50:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso159358e87.3;
        Thu, 04 May 2023 00:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683186618; x=1685778618;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7qcxbhpq4DlZrEuB4qJZQjihch1uZdLLO2V4Nkj9Lk=;
        b=W4hIED+DIc3rCaZ3+VpiLd+RX0K+JgjUphxU/1x0ig3Rn1neSOumrbC74z4s+60wr9
         APYDK6BGwvfLCpomnFyyYix1H19hbcOn2Wp/cHvIf9BriY3X6NVAXxuGCSq863Gypji7
         vp0PRmbDtIRh2IWY+a8Bz24BF8tJ3/NMFfcSTxBAARm8EDLdwVpoeoynj/VMePVVlN8Y
         q76OHYaQupCVZ3Vai53IvqTmjz4Crwia9NeDK9e5bA/u2odDBGwkCcdySF82fsElXQQW
         wBU1Rx58uOCrWgc96veHao7+/H5UVWkC48laD8cwvpG3crFdNB2y4oTbFC7PPwFPA7YX
         oMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683186618; x=1685778618;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7qcxbhpq4DlZrEuB4qJZQjihch1uZdLLO2V4Nkj9Lk=;
        b=hd1iPWzH23ET+PT7A8oji2gLPhTKZXkdNbg+4dGCejjnPvxtBvl1aH+K6F6Cc5Ic15
         ZVCL23onb84G5tbtENRqbqbuXfGOfO+B+mEeS0Qt4RbGfQVJ6YpiNB4nLpT+tlqRj/Bl
         7gvSaByZxwD+s48YN+r5U03DLz1SM/BCF08JyggGrjGHyou1DiyHfU78xAo1SDErSGFm
         WeD/vP30Gj5a2/2Dj+q7if7op/EWmBeaIPzCckRcCTFr0EMHu004EdPW2qYxBNf40Zz2
         7P2UPGmZxzHvV18VCsBE5xrlkrBe1lG0bNz8q62SZkeI5FrXZRoYjgujvQ7WVQUFu2tI
         Kh0w==
X-Gm-Message-State: AC+VfDwd3IgFppz5IOO/Z2D5iffauVjFhxO0ZzTbTW0KcueFVXogHWuG
        qjX5MIRhnKaRBJGHMUUuPsrIc1wYT74=
X-Google-Smtp-Source: ACHHUZ7nZnvqYqu5xtFBc8gl/7xGXGFUYXDjDgIq62SjFr1Oi1D+3g6QfHjF+g+6GDiDY7NtuVoNCQ==
X-Received: by 2002:a05:6512:38b1:b0:4ec:a9c5:f3ae with SMTP id o17-20020a05651238b100b004eca9c5f3aemr1471256lft.11.1683186617409;
        Thu, 04 May 2023 00:50:17 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.76.17])
        by smtp.gmail.com with ESMTPSA id j16-20020a19f510000000b004f14535a962sm88326lfb.174.2023.05.04.00.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 00:50:16 -0700 (PDT)
Subject: Re: [PATCH v5] usb: dwc3: core: add support for realtek SoCs custom's
 global register start address
To:     Stanley Chang <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230504034423.20813-1-stanley_chang@realtek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <96706396-7023-b895-169a-788aad11adcb@gmail.com>
Date:   Thu, 4 May 2023 10:50:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230504034423.20813-1-stanley_chang@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/4/23 6:44 AM, Stanley Chang wrote:

> The Realtek RTD1xxx SoCs were designed, the global register address
> offset at 0x8100.

  Can't parse that, perhaps "with" is missing?

> The default address offset is constant at
> DWC3_GLOBALS_REGS_START (0xc100). Therefore, add a check if the
> compatible name of the parent is "realtek,rtd1xxx-dwc3", then global

   Wildcards are not allowed in the "compatible" props...

> register start address will remap to 0x8100.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
[...]

MBR, Sergey
