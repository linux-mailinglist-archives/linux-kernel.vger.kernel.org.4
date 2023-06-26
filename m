Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C27B73DC89
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFZKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFZKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:52:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46E68F;
        Mon, 26 Jun 2023 03:52:46 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qDjps-0003wC-QK; Mon, 26 Jun 2023 12:52:44 +0200
Message-ID: <2137328a-fc99-9a4a-8679-10f27a9dc916@leemhuis.info>
Date:   Mon, 26 Jun 2023 12:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: fix BAM DMA crash and reboot
Content-Language: en-US, de-DE
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20230621143627.189134-1-krzysztof.kozlowski@linaro.org>
 <fce2d704-6801-afd9-ea9d-607c7ff8f46c@linaro.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <fce2d704-6801-afd9-ea9d-607c7ff8f46c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687776766;1fdd88e2;
X-HE-SMSGID: 1qDjps-0003wC-QK
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.23 16:37, Krzysztof Kozlowski wrote:
> On 21/06/2023 16:36, Krzysztof Kozlowski wrote:
>> SM8350 HDK and MTP boards were silently dying and rebooting during BAM
>> DMA probe:
>>
>>   [    1.574304] vreg_bob: Setting 3008000-3960000uV
>>   [    1.576918] bam-dFormat: Log Type - Time(microsec) - Message -
>>   Optional Info
>>   Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
>>   S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.0-00637.1-LAHAINA-1
>>   S - IMAGE_VARIANT_STRING=SocLahainaLAA
>>   S - OEM_IMAGE_VERSION_STRING=crm-ubuntu77
>>   S - Boot Interface: UFS
>>
>> It seems that BAM DMA is locally controller (not by firmware) and
>> requires proper initialization by the driver prior to use, at least on
>> HDK8350 and MTP8350, but probably on all boards.
>>
>> Fixes: f1040a7fe8f0 ("arm64: dts: qcom: sm8350: Add Crypto Engine support")

BTW, did this make any progress? It's not yet in -next afaics; might be
nice to have this merged so it goes to Linus together with f1040a7fe8f0.

>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Many thx for fixing and involving regzbot. FWIW, this...

> #regzbot fix: f1040a7fe8f069d2259ab3dab9190210005ceb33

...didn't work, as you got things backwards: The fix command is used in
reply to a report to specify which commit fixes it. I'll take care of
fixing that (and also mediate about the docs, maybe this
misunderstanding can be avoided by improving things).

Side note: using a

 Link:
https://lore.kernel.org/lkml/d239ad07-fbdd-16fa-3555-5bcf33c67059@linaro.org/

(or Closes:) in the patch description would have been the ideal way for
regzbot here. Those Links are also what Linus wants to see so everyone
can when needed understand the backstory (now or in the future), which
is why regzbot relies on them.

Whatever, not all that important. Thx again for giving regzbot a try.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

