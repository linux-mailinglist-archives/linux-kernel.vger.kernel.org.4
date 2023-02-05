Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509468AF6B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBELAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBELAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:00:30 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E4193FB;
        Sun,  5 Feb 2023 03:00:28 -0800 (PST)
Received: from [2001:67c:1810:f055:bde0:6d5b:d664:e19a]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pOcl1-0003DL-By; Sun, 05 Feb 2023 12:00:27 +0100
Message-ID: <b2007bc9-b05f-eb17-a373-9587b01d3788@leemhuis.info>
Date:   Sun, 5 Feb 2023 12:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] venus: firmware: Correct non-pix start and end
 addresses
Content-Language: en-US, de-DE
To:     Matthias Kaehlcke <mka@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Fritz Koenig <frkoenig@chromium.org>,
        Nathan Hebert <nhebert@chromium.org>
References: <20221005083730.963322-1-stanimir.varbanov@linaro.org>
 <20221005083730.963322-3-stanimir.varbanov@linaro.org>
 <Y9LSMap+jRxbtpC8@google.com>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Y9LSMap+jRxbtpC8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675594829;3718c9dd;
X-HE-SMSGID: 1pOcl1-0003DL-By
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 26.01.23 20:19, Matthias Kaehlcke wrote:

> On Wed, Oct 05, 2022 at 11:37:29AM +0300, Stanimir Varbanov wrote:
>> The default values for those registers are zero.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/firmware.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
>> index 3851cedc3329..71e43611d1cf 100644
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>> @@ -38,8 +38,8 @@ static void venus_reset_cpu(struct venus_core *core)
>>  	writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
>>  	writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
>>  	writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
>> -	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
>> -	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>> +	writel(0, wrapper_base + WRAPPER_NONPIX_START_ADDR);
>> +	writel(0, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>>  
>>  	if (IS_V6(core)) {
>>  		/* Bring XTSS out of reset */
> 
> I found that this commit prevents the AOSS from entering sleep mode during
> system suspend at least on sc7180 and sc7280. AOSS not entering sleep mode
> leads to a (apparently significant) increase in S3 power consumption, on
> trogdor and herobrine it prevents the system from staying suspended, because
> the embedded controller detect the condition and wakes the sytem up again.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced a837e5161cfffbb32
#regzbot title meida: venus: firmware: AOSS doesn't seel anymore on at
least sc7180 and sc7280
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> Testing is slightly involved, since unfortunately this is not the only issue
> in v6.2-rcN that impacts AOSS sleep.
> 
> To reach AOSS sleep you also have to revert this commit:
> 
> 3a39049f88e4 soc: qcom: rpmhpd: Use highest corner until sync_state

FWIW, for anyone that like me is wondering about that story, it can be
found here:
https://lore.kernel.org/all/Y9v%2Fz8CYik3faHh7@google.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> And apply something like the diff below (or enable the bwmon driver).
> 
> On a trogdor device you will see something like this when AOSS doesn't
> enter sleep mode during system suspend:
> 
>   [   32.882869] EC detected sleep transition timeout. Total sleep transitions: 0
>   [   32.882886] WARNING: CPU: 7 PID: 5682 at drivers/platform/chrome/cros_ec.c:146 cros_ec_sleep_event+0x100/0x10c
>   [   32.900393] Modules linked in: uinput veth uvcvideo videobuf2_vmalloc venus_enc venus_dec videobuf2_dma_contig videobuf2_memops onboard_usb_hub cros_ec_typec typec hci_uart btqca xt_MASQUERADE venus_core v4l2_mem2mem videobuf2_v4l2 videobuf2_common qcom_q6v5_mss qcom_pil_v
>   [   32.940015] CPU: 7 PID: 5682 Comm: cat Tainted: G        W          6.1.0-rc2+ #295 d14276115b3f6b03fc99220174e5d7724847cbd6
>   [   32.951525] Hardware name: Google Villager (rev1+) with LTE (DT)
>   [   32.957695] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   [   32.964848] pc : cros_ec_sleep_event+0x100/0x10c
>   [   32.969596] lr : cros_ec_sleep_event+0x100/0x10c
> 
> I'm also happy to help with testing if you have a candidate fix.
>
> --
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0adf13399e64..c1f6952764c5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3488,7 +3488,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>                 };
> 
>                 pmu@9091000 {
> 		-                       compatible = "qcom,sc7280-llcc-bwmon";
> 		+                       // compatible = "qcom,sc7280-llcc-bwmon";
> 		                        reg = <0 0x9091000 0 0x1000>;
> 
>                         interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> 			@@ -3528,7 +3528,7 @@ opp-7 {
> 			                };
> 
>                 pmu@90b6400 {
> 		-                       compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
> 		+                       // compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
> 		                        reg = <0 0x090b6400 0 0x600>;
> 
>                         interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
