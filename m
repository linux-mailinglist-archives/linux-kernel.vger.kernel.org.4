Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F243D601058
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJQNh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJQNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:37:23 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C6F638F2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:37:21 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:37:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1666013838; x=1666273038;
        bh=O8U0/rSJcp6Znld+LgNmARLp2ZlKY3y+428lcdHw/Ck=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=FP9YI0LpS3NtMj7aU54Mch6ZnaBxrpwwrUPWiZeYoMw0G3T3yqCAT/tciY5CEYWi7
         rYyKgglMC+Jhl0jZMYKR6qHzuoUuah1oeWr7SZ+x39iKu8jJPoV5diyyp+FCOa4pQN
         TKuVBN2XwYw1mVYNNGfa5hDUCz9MQcLtLOx8yApg=
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     phone-devel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, Newbyte <newbie13xd@gmail.com>
Subject: Re: [Freedreno] [PATCH v3 06/10] drm/msm/dsi: Migrate to drm_dsc_compute_rc_parameters()
Message-ID: <0642a664-3eed-21b7-a417-c6c607908f51@connolly.tech>
In-Reply-To: <20221017085944.2r24uqg73irmziqm@SoMainline.org>
References: <20221009184824.457416-1-marijn.suijten@somainline.org> <20221009185058.460688-1-marijn.suijten@somainline.org> <5c178d7e-5022-f5e5-791d-d3800114b42b@quicinc.com> <20221013093646.c65mbjc6oekd7gha@SoMainline.org> <32af4444-9c88-eb0f-eda7-24fa0418aff6@quicinc.com> <20221017085944.2r24uqg73irmziqm@SoMainline.org>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/10/2022 09:59, Marijn Suijten wrote:
> On 2022-10-13 09:02:44, Abhinav Kumar wrote:
>> On 10/13/2022 2:36 AM, Marijn Suijten wrote:
>>> On 2022-10-12 16:03:06, Abhinav Kumar wrote:
>>>> [..]
>>>> But I would like to hold back this change till Vinod clarifies because
>>>> Vinod had mentioned that with drm_dsc_compute_rc_parameters() he was
>>>> seeing a mismatch in the computation of two values.
>>>>
>>>> slice_bpg_offset and the final_offset.
>>>
>>> Unsurprisingly so because final_offset, and slice_bpg_offset through
>>> initial_offset depend directly on bits_per_pixel.  The main takeaway of
>>> this series is that Vinod was interpreting this field as integer instea=
d
>>> of containing 4 fractional bits.  If he updates his the panel driver [1=
]
>>> to set bits_per_pixel =3D 8 << 4 instead of just 8 to account for this,
>>> the values should check out once again.
>>>
>>> [1]: https://git.linaro.org/people/vinod.koul/kernel.git/commit/?h=3Dto=
pic/pixel3_5.18-rc1&id=3D1d7d98ad564f1ec69e7525e07418918d90f247a1
>>>
>>> Once Vinod (or someone else in the posession of a Pixel 3) confirms
>>> this, I can respin this series and more explicitly explain why the FIXM=
E
>>> was put in place, instead of being resolved outright?
>>>
>>> - Marijn
>>
>> Makes perfect sense to me.
>>
>> Will just wait for Vinod's tested-by.
>
> Unfortunately Vinod doesn't have access to this device anymore, but
> Caleb recently sent the support series including display driver for
> Pixel 3 and is picking up the testing.  User "Newbyte" from #linux-msm
> promised to test on the LG G7 to have even more input samples.

Hi,

I'm hoping to pick the Pixel 3 stuff back up at some point, but right now t=
here
seem to be quite a few issues outside of DSC which make testing it a bit of=
 a pain.

I gave Marijn's series [1] a go but wasn't able to get anything usable out =
of the
panel, however I doubt this is a DSC issue as I've always needed some hacks=
 to
get the panel working - I've never had any success with it without skipping=
 both
the initial panel reset and sending the PPS payload.

I think if Marijn has managed to initialise a panel properly then the lack =
of
Pixel 3 for validation shouldn't be a blocker to merge these fixes.

[1]:
https://lore.kernel.org/linux-arm-msm/20221009184824.457416-1-marijn.suijte=
n@somainline.org/

>
> - Marijn

--
Kind Regards,
Caleb

