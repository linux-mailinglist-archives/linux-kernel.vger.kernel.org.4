Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F6685DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjBADNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjBADNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:13:52 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0638E91
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:13:51 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id t24-20020a4a8258000000b005170b789faaso1330070oog.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3YwzPamfjwuuQEM2RnT++paWIr3qoCEOZrgbHTxW64=;
        b=MOgnvtiSozTzruoGwOmugYaSILZTBMfknxbWXgCDJACJwzf+1UZiN6+wiVvYcGk7hS
         3Ykc1fwKnTojw9Wm5OgQ8BpUoCLku3rvaI6tXVMYcDPxb8EO0TGKuEg2lJdlHlffzY5a
         iAboOfuZ4vOqXbRUNRdi0zokHiNFc/+JgGWKVrYe96+3Kr5blF0F6cweRCcXlGX4x1db
         IGJ7W4sTAxOhfIK1M43AFkfPidRW9hlU8lEti2zi/bOGTaWXtJWHZOId244O+adzZvKb
         OHDLWj+X3dgw5XqRV8SZ9NJ1hPRrN6QWZ4qCWmkmFHyhZTcb1x9WI92nbJdES5N0a+9m
         QO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3YwzPamfjwuuQEM2RnT++paWIr3qoCEOZrgbHTxW64=;
        b=Iug7VMbKtAwyRQO4xVVDMHNQj4F36qf7vwyVKweN4jvpIJOG1Z8VoqQxAkKyfhPKmx
         bvazj8ULmtle5gqMNas7JuFncjswtr7lsfwDoIZQOqufvVUsv9b/z7USKLdxElIfxQOy
         xlIexxdnx60RbG17FeV2R93/oY8695JK3gf1IfPY0x7v6G1fmwi2usMsvkoUiFStlZ7z
         VWppBQUwGq/AdvhfVx+5ZkXnFtbNB1J3/sv0uf5nE/1qTXDeSxphP2g5gRpcvtIxzsfV
         KZE7N4sMiyHt1gIbIT2/UVhyCl2iyBSNWU+TJSlGhjoChIDUbhwJ9OzwQLqKaT0g/5R0
         7+3w==
X-Gm-Message-State: AO0yUKVRnpc5rjhr8sLJIEbWeHP0lsA5FLwvwFMrDa0bj2n99mZIiaKi
        BZForRPij5fZDjZktzuriEGDtA==
X-Google-Smtp-Source: AK7set9KsGzjn5wBbpVtqFW2yRyYfDcWH3ZWqT6jjr/GW26QHQ0Hxu1/dF14CQcqYitui3cWEdRFBw==
X-Received: by 2002:a4a:a2c9:0:b0:517:640f:5905 with SMTP id r9-20020a4aa2c9000000b00517640f5905mr464907ool.3.1675221230905;
        Tue, 31 Jan 2023 19:13:50 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id k68-20020a4a4a47000000b005176974faf3sm3557618oob.35.2023.01.31.19.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 19:13:50 -0800 (PST)
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
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: thinkpad-x13s: Add bluetooth
Date:   Tue, 31 Jan 2023 21:13:49 -0600
Message-Id: <20230201031349.56405-1-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <c515aae3-88e4-948c-a856-7b45dd2caed9@linaro.org>
References: <c515aae3-88e4-948c-a856-7b45dd2caed9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 31/01/2023 05:38, Steev Klimaszewski wrote:
>> Signed-off-by: Steev Klimaszewski <steev@kali.org>
>> ---
>>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 68 +++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> index f936b020a71d..951438ac5946 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> @@ -24,6 +24,8 @@ / {
>>  	aliases {
>>  		i2c4 = &i2c4;
>>  		i2c21 = &i2c21;
>> +		serial0 = &uart17;
>> +		serial1 = &uart2;
>>  	};
>>  
>>  	wcd938x: audio-codec {
>> @@ -712,6 +714,32 @@ &qup0 {
>>  	status = "okay";
>>  };
>>  
>> +&uart2 {
>> +	status = "okay";
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_state>;
>> +
>> +	bluetooth {
>> +		compatible = "qcom,wcn6855-bt";
>> +
>> +/*

> Why dead code should be in the kernel?

As mentioned in the cover letter, this is a bit closer to an RFC than ready to
go in, and I do apologize that it wasn't clear enough.  I do not have access to
the schematics, and based on my reading of the schema for bluetooth, these
entries are supposed to be required, however, like the wcn6750, I have dummy
data entered into the qca_soc_data_wcn6855 struct.  I know that these should be
there, I just do not have access to the correct information to put, if that
makes sense?


<snip>

>Does not look like you tested the DTS against bindings. Please run `make
>dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>for instructions).

Correct I had not, but I have now, and will make the corrections test and they
will be included in v3.

>Best regards,
>Krzysztof

I appreciate the guidance for what I was doing incorrectly.

-- steev
