Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F064ACBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiLMBDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiLMBDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:03:04 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093C63A6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:03:02 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s10so1836994ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c4uydtI+TJBxOHIdUWp7WaxP1AbUhc5qkc9V6EJvCic=;
        b=EEdB7Du271URciEUZOFlwc+L+uTXvnK00CZKbKg9UqPqnIdokWLS99gx8neaY6Qime
         mU18qWCUImn9sISphSIkjx68Am3qUuykYENCcvzeQQ3R7Awa9tfyPpSeub/FCZcs0e0M
         Fn7nubnlMx0U5HmdCvKJjz6jecoh26tWUcJ4CihrMn35UwC5Ozhh8Syq/P+VDu5e9DhH
         +TFIMHEwBKnp53TtMBbKqZ5o9gGLJ5kI/Gud9EdQqTcMByhFFKrwJfJ42ZhQUwy06Edu
         DB7Oqt0MdVb0Sn0Bi5pGhQcBrD607m/d0amc5XjWKHjKM6vlyBa/LdaPaCIb8QXAcEbd
         9ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4uydtI+TJBxOHIdUWp7WaxP1AbUhc5qkc9V6EJvCic=;
        b=6Pps+QrfzS00ZVedDlZbkqDsqlcFNRiAmYGmwhg6sz4vWWX5Z1ZLyzfN5FZuDZ51H1
         UJnK/YCLs6thSQbbqTi7F9+MrrOrvx1xaxEUFUWav/4K382np+9a7BvsqnnNbB72I3SW
         DlQPUxWL6CANTS/SeHzhsXSTmb/rnUPSuqX68Mvm9aQKJi6dJf39Epn6UTcZC3IhQ0x1
         x5JPi+U6VKz3Hoo0yiciTrpQIFPg7Xk1gua9arMtOTG0RH7LK+AAtMyzI2brladZz3GH
         owSIiZZ7UXy2tQNNVbXKzAtCuhRK3ayC40UtpCnaJrrtLACZjpI4J+6XstYj43KEoRWG
         VlWw==
X-Gm-Message-State: ANoB5pn0qsE+S8++1hlDCYpno6JdCPe7g7X+5ZLtjwGlheLnLyuicO7k
        WAQzBFied5oxXpkOTDHUg9rMAw==
X-Google-Smtp-Source: AA0mqf6/0+m1rsZkaUSHO7NwIJA9CMcebS/GmvIxG6UAb/gfbNFdP87gMoYB+be+y+4Mw4ambQTXOg==
X-Received: by 2002:a2e:3a15:0:b0:27a:129f:770d with SMTP id h21-20020a2e3a15000000b0027a129f770dmr4414846lja.45.1670893380349;
        Mon, 12 Dec 2022 17:03:00 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.107])
        by smtp.gmail.com with ESMTPSA id u16-20020a05651c131000b0027760138c53sm137967lja.72.2022.12.12.17.02.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 17:02:59 -0800 (PST)
Date:   Tue, 13 Dec 2022 04:02:54 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
CC:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, airlied@gmail.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_2/5=5D_dt-bindings=3A_msm/dp=3A_a?= =?US-ASCII?Q?dd_data-lanes_and_link-frequencies_property?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a9e2f269-b9df-814f-adcd-f5577f590fa7@quicinc.com>
References: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com> <1670539015-11808-3-git-send-email-quic_khsieh@quicinc.com> <5a3865ed-8847-db04-3d60-f35438250bef@linaro.org> <5aa16223-dbf6-996c-1985-794302dcce91@quicinc.com> <be1411e8-1d07-7643-977c-a306016fd660@linaro.org> <b6d90c1f-5365-7197-be63-96c3d8cf0746@quicinc.com> <e53844b7-601b-f355-302b-cc871962a446@linaro.org> <8b306c8f-3089-4aaf-7fc1-038a8330c89a@quicinc.com> <CAA8EJpr5RYyQa7xu1_xJ0F-dn-H9aOf0KE-CDgDCwnZu3HPgXg@mail.gmail.com> <a9e2f269-b9df-814f-adcd-f5577f590fa7@quicinc.com>
Message-ID: <46971A33-D9A4-4A84-9058-62F69C5618F4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 December 2022 02:41:55 GMT+03:00, Abhinav Kumar <quic_abhinavk@quici=
nc=2Ecom> wrote:
>Hi Dmitry
>
>On 12/12/2022 2:35 PM, Dmitry Baryshkov wrote:
>> On Mon, 12 Dec 2022 at 19:51, Kuogee Hsieh <quic_khsieh@quicinc=2Ecom> =
wrote:
>>>=20
>>>=20
>>> On 12/8/2022 4:35 PM, Dmitry Baryshkov wrote:
>>>> On 09/12/2022 02:22, Kuogee Hsieh wrote:
>>>>>=20
>>>>> On 12/8/2022 4:11 PM, Dmitry Baryshkov wrote:
>>>>>> On 09/12/2022 01:38, Kuogee Hsieh wrote:
>>>>>>>=20
>>>>>>> On 12/8/2022 3:33 PM, Dmitry Baryshkov wrote:
>>>>>>>> On 09/12/2022 00:36, Kuogee Hsieh wrote:
>>>>>>>>> Add both data-lanes and link-frequencies property into endpoint
>>>>>>>>>=20
>>>>>>>>> Changes in v7:
>>>>>>>>> -- split yaml out of dtsi patch
>>>>>>>>> -- link-frequencies from link rate to symbol rate
>>>>>>>>> -- deprecation of old data-lanes property
>>>>>>>>>=20
>>>>>>>>> Changes in v8:
>>>>>>>>> -- correct Bjorn mail address to kernel=2Eorg
>>>>>>>>>=20
>>>>>>>>> Changes in v10:
>>>>>>>>> -- add menu item to data-lanes and link-frequecnis
>>>>>>>>>=20
>>>>>>>>> Changes in v11:
>>>>>>>>> -- add endpoint property at port@1
>>>>>>>>>=20
>>>>>>>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc=2Ecom>`
>>>>>>>>=20
>>>>>>>> Applying: dt-bindings: msm/dp: add data-lanes and link-frequencie=
s
>>>>>>>> property
>>>>>>>> =2Egit/rebase-apply/patch:47: trailing whitespace=2E
>>>>>>>>=20
>>>>>>>> =2Egit/rebase-apply/patch:51: trailing whitespace=2E
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Also the dt_binding_check fails with an error for this schema=2E =
And
>>>>>>>> after fixing the error in the schema I faced an example validatio=
n
>>>>>>>> error=2E Did you check that the schema is correct and that the
>>>>>>>> example validates against the schema?
>>>>>>>=20
>>>>>>> yes, but i run "make dt_binding_check
>>>>>>> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/display/msm/dp=
-controller=2Eyaml"
>>>>>>> at mu v5=2E15 branch since
>>>>>>=20
>>>>>> I wouldn't ask you to post the log here=2E But I don't think that
>>>>>> either of the errors that I see here is related to 5=2E15 vs 6=2E1-=
rc=2E
>>>>>>=20
>>>>>> In fact after applying this patch against 5=2E15 I saw the expected
>>>>>> failure:
>>>>>>=20
>>>>>> Documentation/devicetree/bindings/display/msm/dp-controller=2Eyaml:
>>>>>> properties:required: ['port@0', 'port@1'] is not of type 'object',
>>>>>> 'boolean'
>>>>>> Documentation/devicetree/bindings/display/msm/dp-controller=2Eyaml:
>>>>>> properties: 'required' should not be valid under {'$ref':
>>>>>> '#/definitions/json-schema-prop-names'}
>>>>>> Documentation/devicetree/bindings/display/msm/dp-controller=2Eyaml:
>>>>>> ignoring, error in schema: properties: required
>>>>>>=20
>>>>>>>=20
>>>>>>> "make dt_binding_check" does not work at msm-next branch=2E
>>>>>>=20
>>>>>> I went ahead and just checked=2E
>>>>>>=20
>>>>>> `make dt_binding_check DT_SCHEMA_FILES=3Ddisplay/msm`  works cleanl=
y
>>>>>> in msm-next and reports a single example-related warning in
>>>>>> msm-next-lumag=2E I pushed a patch to fix that warning (wich can
>>>>>> hopefully be picked up by Abhinav into msm-fixes)=2E So you can ass=
ume
>>>>>> that both these branches have consistent error-free display/msm
>>>>>> schemas=2E
>>>>>>=20
>>>>> I have clean msm-next branch (without my data-lines yaml patch
>>>>> applied) and run "make dt_binding_check
>>>>> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/display/msm/dp-c=
ontroller=2Eyaml",
>>>>> then I saw below error messages=2E
>>>>>=20
>>>>> Have you run into this problem?
>>>>=20
>>>> No=2E
>>>=20
>>> Did you do anything to fix "older dtschema instance"?
>>=20
>> I did not since I hadn't had such a problem=2E I can refer again to the
>> steps I provided you beforehand=2E The email was sent 6 days ago=2E No
>> answer from your side since that time=2E
>>=20
>>> I had run  "pip3 install dtschema --upgrade" and still not work=2E
>>=20
>> Can you please post a full log of this command?
>>=20
>>>=20
>>> D you know how to fix this problem?
>>>=20
>>> Thanks,
>>>=20
>>> kuogee
>>>=20
>>> sort: -:2: disorder: 2022=2E1
>>> ERROR: dtschema minimum version is v2022=2E3
>>> make[2]: *** [check_dtschema_version] Error 1
>>> make[1]: *** [dt_binding_check] Error 2
>>> make: *** [__sub-make] Error 2
>>=20
>> Please add the output of:
>>=20
>> which dt-validate
>> dt-validate -V
>>=20
>> And also a full log of your failing kernel build=2E
>>=20
>>=20
>>=20
>>> I had run "pip3 install dtschema --upgrade" according Rob Herring resp=
onse=2E
>>> but it still shows same problem=2E
>>> Please let know how can I fix this problem=2E
>>>=20
>>>>=20
>>>>>=20
>>>>>     HOSTCC  scripts/basic/fixdep
>>>>>     HOSTCC  scripts/dtc/dtc=2Eo
>>>>>     HOSTCC  scripts/dtc/flattree=2Eo
>>>>>     HOSTCC  scripts/dtc/fstree=2Eo
>>>>>     HOSTCC  scripts/dtc/data=2Eo
>>>>>     HOSTCC  scripts/dtc/livetree=2Eo
>>>>>     HOSTCC  scripts/dtc/treesource=2Eo
>>>>>     HOSTCC  scripts/dtc/srcpos=2Eo
>>>>>     HOSTCC  scripts/dtc/checks=2Eo
>>>>>     HOSTCC  scripts/dtc/util=2Eo
>>>>>     LEX     scripts/dtc/dtc-lexer=2Elex=2Ec
>>>>>     HOSTCC  scripts/dtc/dtc-lexer=2Elex=2Eo
>>>>>     HOSTCC  scripts/dtc/dtc-parser=2Etab=2Eo
>>>>>     HOSTLD  scripts/dtc/dtc
>>>>> sort: -:2: disorder: 2022=2E1
>>>>> ERROR: dtschema minimum version is v2022=2E3
>>>>> make[2]: *** [check_dtschema_version] Error 1
>>>>> make[1]: *** [dt_binding_check] Error 2
>>>>> make: *** [__sub-make] Error 2
>>>>=20
>>>> This means that somewhere in your path you have an older dtschema
>>>> instance=2E
>>>>=20
>>>> When you sent me a question regarding this error, I asked for the
>>>> additional info=2E You provided none=2E Instead you went on sending t=
he
>>>> untested patch that doesn't work=2E
>>>=20
>>> since i can not test it on msm-next so that I did test it at my v5-15
>>> branch=2E
>>=20
>> Wrong=2E
>>=20
>>>=20
>>> besides, i think i have to sent the whole series patches include this
>>> one to address your new comments on other patch=2E
>>>=20
>>> is this correct?
>>=20
>> No=2E Please fix your system first, validate your patches and send them
>> afterwards=2E You can not expect others to do your job=2E
>>=20
>
>Just finished working with kuogee on this=2E This issue had been reported=
 by few others earlier (example https://lore=2Ekernel=2Eorg/lkml/bc9be279-a=
130-d5e7-4397-bbb389d14403@intel=2Ecom/T/)=2E

Thanks a lot for helping Kuogee!


>
>So let me summarize the fix:
>
>1) We do need up upgrade the dtschema first
>
>pip3 install git+https://github=2Ecom/devicetree-org/dt-schema=2Egit@main

I'd stick to the released version, unless there is any indication that the=
 trunk has any significant features=2E Rob, Krzysztof, please correct me if=
 I'm wrong=2E


>
>2) Python version issues were hitting some of the developers so even if w=
e had the right version installed the PATH wasnt pointing to the right one

Yes, that is what I expected, when I asked for the pip command log and for=
 the `which' command output=2E

I usually install dtschema to my user's dir and add ~/=2Elocal/bin to PATH=
=2E

>
>3) We had to install yamllint
>
>We have documented these now for the benefit of others internally=2E
>
>With all these 3 done, we can compile msm-next-lumag using
>make dt_binding_check DT_SCHEMA_FILES=3Ddisplay/msm
>
>Apologies for the setup issues on our end=2E These are resolved now and k=
uogee will post a v12 for this=2E

Great, I'm looking forward to seeing it and finally merging it!


>
>Thanks
>
>Abhinav
>> --
>> With best wishes
>> Dmitry

--=20
With best wishes
Dmitry
