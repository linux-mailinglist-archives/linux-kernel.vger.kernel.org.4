Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE6701D27
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 13:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjENLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 07:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjENLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 07:54:26 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246981FCA;
        Sun, 14 May 2023 04:54:25 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pyAIu-0006tG-Qg; Sun, 14 May 2023 13:54:20 +0200
Message-ID: <83a92f91-f126-94e8-a7ef-3da0298c0d4f@leemhuis.info>
Date:   Sun, 14 May 2023 13:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
 PROBE_FORCE_SYNCHRONOUS"
Content-Language: en-US, de-DE
To:     Amit Pundir <amit.pundir@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684065265;a8bf9056;
X-HE-SMSGID: 1pyAIu-0006tG-Qg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 13.05.23 20:08, Amit Pundir wrote:
> On Fri, 24 Mar 2023 at 19:05, Douglas Anderson <dianders@chromium.org> wrote:
>>
>> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
>> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems that
>> prompted the us to switch to synchronous probe showed that the root
>> cause was a missing "rootwait" in the kernel command line
>> arguments. Let's reinstate asynchronous probe.
> 
> Hi, the asynchronous probe is broken on Dragonboard 845c (SDM845)
> running AOSP (Android Open Source Project) with v6.4-rc1
> https://bugs.linaro.org/show_bug.cgi?id=5975.
> Can we please go back to synchronous probe.
> 
> AOSP do not make use of rootwait, IIRC, but it is added by the
> bootloader anyway. And the device fails to boot AOSP regardless of
> "rootwait" bootarg being present or not.
> 
> FWIW I do not see this regression on RB5 (QRB5165/SM8250) running the
> same set of AOSP images.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced ad44ac082fd
#regzbot title regulator: qcom-rpmh: Dragonboard 845c broken due to
asynchronous probe
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

>> Fixes: 58973046c1bf ("regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS")
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
>> index 903032b2875f..4826d60e5d95 100644
>> --- a/drivers/regulator/qcom-rpmh-regulator.c
>> +++ b/drivers/regulator/qcom-rpmh-regulator.c
>> @@ -1462,7 +1462,7 @@ MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
>>  static struct platform_driver rpmh_regulator_driver = {
>>         .driver = {
>>                 .name = "qcom-rpmh-regulator",
>> -               .probe_type = PROBE_FORCE_SYNCHRONOUS,
>> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>                 .of_match_table = of_match_ptr(rpmh_regulator_match_table),
>>         },
>>         .probe = rpmh_regulator_probe,
>> --
>> 2.40.0.348.gf938b09366-goog
>>
