Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4BF6B6439
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCLJe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCLJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:34:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9936C3346A;
        Sun, 12 Mar 2023 01:33:53 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id g18so9737657ljl.3;
        Sun, 12 Mar 2023 01:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678613626;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+WqGN7kCqGcblySR26LsjP4JEJqyi8NL3x8rHmKp1k=;
        b=GAcXgtUZBhniYminGvu2stHstqt+Vx3UMZNbrhfrlNUnwx4snSPLrFvAlTUtVxWx7e
         eYefWUjhYhN1jTXl/XAkk7P3Ia/OiMcB3O11fVzzSXIOmlZKh1dEbgiYEp4S3bVr3rSh
         sloIbpgsrV2mXZGynrKxapAqwnrp7IZ0GngY4HIvVsaR2heNn5Q4u1dFu71e3Gc0QRpz
         UgF3z/9t7oakhR38t89xxZEHm1gf63Ye49bM6jXDzRtWoRsXlGJYSXqDVcDUMYrDahFN
         g5xq9FDdxVJol7WwUg4oq0jYHdQ5PKHIMbpERMDpt10uxXEeqXrlD0ZE8WfC2XkC9swc
         0BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678613626;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+WqGN7kCqGcblySR26LsjP4JEJqyi8NL3x8rHmKp1k=;
        b=v++h1FK/zvjUOaSqLtB0MXreFIa3PqWweRJbmsucLUAJZANO6TExQOZoQmEaioJKzR
         /h1/vlHG690mdzJH2RmFdl2p7L9Hucp1xWIYUX5d8m9ho/sERy0Fa7XmrSW2NcvsQzLY
         OX8AYDH3/vaTn5i0GsruGf9fhog5Kdz5kc3rdWqonrAwJl3T9mc6BhkuGVmdBGxO3ViS
         4lTUt99HLiWQbWECJPiwV7pTJU9iJwaYBSX079cOpPi62km5+zLecrXexWk8B0nxBnDw
         5DqZtfzQt/6R3o56COcLGs/9vRKKGv94z+W0kfkbykOgsHfE5nxsYg7E9SEnfxRCvKal
         4EVA==
X-Gm-Message-State: AO0yUKV30SoD7EFFEBOFGfZWDqBYUgrzUS/9LMUacCxGh5z9LfFUs51G
        2nPk76USXlTg6y/eE2+kKMzUnTZiaIs0fw==
X-Google-Smtp-Source: AK7set9mPvHwYyfwQo2Qk0SV3T0i80ug9e2C1WyJi6GKQN9rWQcbI3axq2UQRlP4V3uRIP+OuSO71Q==
X-Received: by 2002:a2e:8290:0:b0:295:c39d:9a99 with SMTP id y16-20020a2e8290000000b00295c39d9a99mr9077508ljg.27.1678613625721;
        Sun, 12 Mar 2023 01:33:45 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.227])
        by smtp.gmail.com with ESMTPSA id f27-20020a2eb5bb000000b00295a8d0722asm600659ljn.93.2023.03.12.01.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 01:33:45 -0800 (PST)
Subject: Re: [PATCH 3/8] usb: dwc3: core: Skip setting event buffers for host
 only controllers
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
 <20230310163420.7582-4-quic_kriskura@quicinc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <eb6b3c79-8d76-f70c-43b4-d190c892b4a3@gmail.com>
Date:   Sun, 12 Mar 2023 12:33:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230310163420.7582-4-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 7:34 PM, Krishna Kurapati wrote:

> On some SoC's like SA8295P where the teritiary controller is host-only

   Likewise, tertiary. :-)

> capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
> Trying to setup them up during core_init leads to a crash.
> 
> For DRD/Peripheral supported controllers, event buffer setup is done
> again in gadget_pullup. Skip setup or cleanup of event buffers if
> controller is host-only capable.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
[...]

MBR, Sergey
