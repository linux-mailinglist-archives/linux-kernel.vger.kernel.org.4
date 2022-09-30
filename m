Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A049A5F1178
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiI3SUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiI3SUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:20:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6430AB3B05
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:20:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u21so2861812edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NjV6JEfhHgDYfkPbHulbQigSi/rTRxz40ubXfPpUaX0=;
        b=jzGpsEEEQ5dG8pjjpuCsPWf7SrU/Vfs9DpaZdd5znvXL0pnXSYKdc8r+n8GZgLHinI
         DHTO4jMa7eDYjiWYWVEm2fqycUD/GGadj9zwiJO9cjDWiBE870dyme66tAyqswGcq7KS
         /9A38Vt/eNysPDRv+mS28Vs9NUbpYgaEHfaxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NjV6JEfhHgDYfkPbHulbQigSi/rTRxz40ubXfPpUaX0=;
        b=Y2SH7EyNWKTlL6xLWVMe7pGn3Nv7HqnOTyQ3wU2Cz/0U82J6uU+NAdIdunQVxjvuiJ
         rsK1KcIUuU8p7+hqg7FOH9VtT+uHcWUPbBw4FmJrsAIEIVmkx3ygrgnwfwmzTtsPPvV3
         fCo2Jczsh6x61ZbmESCaGB6IEYCzFJp0OOJDJdFRo0jhf70JBHkQMoURjRfdVBPHccPJ
         ETW71mmN3wpclQKSPu3qV8epc0u5qdaptIcePGtp9aiBIgMhkDdOB/JMMwXIcGaAdwiv
         h3hQXz0g/nYQGELNkRA3Ohvcjz5l4Gub0AsELFnaO7H9CugNZU7KxzwPP/gLu03/OCYV
         VfEw==
X-Gm-Message-State: ACrzQf0GfDK8fBEbmxrtwIlGgJ1UUFhm8IC2K4pX1tJHayVOzWubgh2f
        8QjQqEks5Yss5fqqw8Z58nmb0X4pmkzbhWy0
X-Google-Smtp-Source: AMsMyM6AR5z/tMAtffB8D1uWXFcCiXECjlD5oMfRogoXyDjv7ltxEY+qbM6FKifM/pqPJyHlh+1egA==
X-Received: by 2002:a05:6402:4505:b0:451:1551:7b14 with SMTP id ez5-20020a056402450500b0045115517b14mr8902144edb.300.1664562044697;
        Fri, 30 Sep 2022 11:20:44 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id l22-20020a056402125600b00458898fe90asm1318051edw.5.2022.09.30.11.20.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 11:20:43 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id u10so7923889wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:20:43 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr6808655wra.617.1664562042954; Fri, 30
 Sep 2022 11:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220930153643.2018907-1-judyhsiao@chromium.org>
In-Reply-To: <20220930153643.2018907-1-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Sep 2022 11:20:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vz_tijVmqf=J5ytH_5Pafr1s80zzxJV73ffRVObLMDbQ@mail.gmail.com>
Message-ID: <CAD=FV=Vz_tijVmqf=J5ytH_5Pafr1s80zzxJV73ffRVObLMDbQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add dtsi for sc7280 boards that using rt5682
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Judy,

On Fri, Sep 30, 2022 at 8:36 AM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Put sound node and lpass_cpu node settings for boards that use rt5682
> codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
> choices of headset codec for herobrine projects. Common audio setting
> for the internal speaker is in sc7280-herobrine.dtsi.
>
> Change Since V4
> - Rebase and include sc7280-herobrine-villager-r0.dts change.
>
> Changes Since V3:
> - Remove Change-Id in the commit message.
> - Add dependency in cover letter.
>
> Changes Since V2:
> - Fix sc7280-herobrine-audio-rt5682.dtsi syntax.
>
> Changes Since V1:
> - Not to include the herobrine-villager-r0.dts changes in this patch
>   series to avoid conflict.
>
> Judy Hsiao (3):
>   arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
>   arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
>   arm64: dts: qcom: sc7280: Include sc7280-herobrine-audio-rt5682.dtsi
>     in herobrine-r1 and villager-r0
>
>  .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 122 ++++++++++++++++++
>  .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
>  .../dts/qcom/sc7280-herobrine-villager-r0.dts |   1 +
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  30 +++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

Your two posts today were a bit confusing. You really need something
in the explaining what's going on. Specifically:

1. You posted a "v5" upstream a week ago [1].

2. Then you posted another "v5" [2] today.

3. Finally, you posted this "v5" [3] today.

They are all marked "v5" and there's nothing to explain why there are
3 versions of v5.

--

Better would have been:

a) Use some type of "prefix" in the subject line to help people
understand that the contents are the same as the previous "v5" patch
and this is just a new posting. Usually people will use "REPOST" or
"RESEND". So, for instance, the subject line for your cover letter
could have been "[RESEND PATCH v5 0/3] Add dtsi for sc7280 boards that
using rt5682". All of the individual patches would have also had the
"RESEND" in their subject.

b) You should explain somewhere _why_ you're re-sending the patches.
If you've got a cover letter (like you do), the cover letter is the
perfect place to explain why you're resending the patch. If you didn't
have a cover letter, you can explain "after the cut".

Brian's patch [4] is a great example of this. He has both the hint in
the subject line and an explanation: "Resending, because I missed the
mailing lists on the first version."

--

In your case, I assume you were trying to get Bjorn's email address
correct as I requested a week ago. Thus, I would have expected your
first patch from today [2] to say something like "I'm resending patch
v5 to get Bjorn's email address correct. Other than that this is
exactly the same as the previous v5". Then, I would have expected your
second patch from today [3] to say something like "Oops, I still
didn't get Bjorn's email address right in the earlier patch today.
Trying yet again. Contents of all of the v5 patches are identical"

--

In any case, I'm not expecting you to send yet-another v5, but hopefully:
* This explains to Bjorn what's going on this time.
* You'll know better for next time.


[1] https://lore.kernel.org/r/20220923140918.2825043-1-judyhsiao@chromium.org
[2] https://lore.kernel.org/r/20220930152613.2018360-1-judyhsiao@chromium.org
[3] https://lore.kernel.org/r/20220930153643.2018907-1-judyhsiao@chromium.org
[4] https://lore.kernel.org/r/20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid/
