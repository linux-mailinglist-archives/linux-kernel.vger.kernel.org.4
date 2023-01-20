Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6FA6760CA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjATWu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjATWu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:50:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1807970293;
        Fri, 20 Jan 2023 14:50:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so5121505wmo.5;
        Fri, 20 Jan 2023 14:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TBg2ZGSLJCHCe4StnuS4Rf2XAsBlx+T2xK8kBvKv+5I=;
        b=SJ7Ngi78KdWr+dxt92Brtb7mMmMsDrdUtcVnXudTPfxsCxacHixF+sq839NSklew4L
         GzGHgchDYxFk0G5Aax4ap0njAnvnowwwFrbRZY0iOLvW8bDJiso09wqMc6s/6B8ab5ZJ
         J45WrKTY1F0Ha7DZSBpIvTopG7OorcjJ3xNyQ1KBDG7NalXcVbaZMlt3YM19syr7fYnm
         6Sani86aF9mm2Qe0S1SUv0LJ6t/0xtgsGcndZfKI52r9uLzob9AefVKTJ3uKBaOzz06C
         To94OMUcIUNQ4NZTmRnyJFv1Q6nH9EarFCEeT46nMi3tTBkkVhs3SiQvAWEyKuqlcncf
         CxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBg2ZGSLJCHCe4StnuS4Rf2XAsBlx+T2xK8kBvKv+5I=;
        b=ysbONUR8/PDTouraaogxxsrJ0Iiq+cyKnPG63ZZugBEB4Tq4/iEaZiUji7Pz/0/09b
         iS4mVpSkaHONaYmDiLrZNmbipllshynasi+i2eUutziFXXQP7p3RoCWGNyS9UDoQBRSz
         resWEQXQkyWR8MueADgIS3EF59h0edORkh76KXhDKknKz2xkO4CruOq6nTUhBT4y48lC
         jL5ymhNtSwKuzUCZz4fPeetYNmgRxFhQMH20GWb9d85JAtpol1f11KfGk3FghClQ7dEu
         eCNdCPpy15tWG9v37lD6bd2Tmj3Oo536wOeAEOJoVlUdrB85438SQfaF/OPQYBJWXKZ7
         tzEQ==
X-Gm-Message-State: AFqh2kq6nJ2m1rEJAvjnF2r++OLWNahesINRmgPqWvtnTQ61pfVORaDO
        QjSDUCtmizZKQAMhdnwbMGHYKsCqq96bYDwY
X-Google-Smtp-Source: AMrXdXtn/n4mw/1xYuM53NkndS8FqUOcqZ1AW1INz0Q8ktjH/XJksS8iILG8ofDkgnklJ9s1+mi1/g==
X-Received: by 2002:a05:600c:444b:b0:3da:fd06:a6f1 with SMTP id v11-20020a05600c444b00b003dafd06a6f1mr15392053wmn.31.1674254955845;
        Fri, 20 Jan 2023 14:49:15 -0800 (PST)
Received: from fedora.36 ([78.10.206.44])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003d9aa76dc6asm4974827wmq.0.2023.01.20.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:49:15 -0800 (PST)
Date:   Fri, 20 Jan 2023 23:49:10 +0100 (CET)
From:   =?ISO-8859-2?Q?Micha=B3_Grzelak?= <mchl.grzlk@gmail.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
cc:     =?ISO-8859-2?Q?Micha=B3_Grzelak?= <mchl.grzlk@gmail.com>,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: audio-graph-port: Add capture and
 playback
In-Reply-To: <87lelxlt18.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <c6b1ad16-894d-e9a4-1fd1-cc94ec11df7@student.agh.edu.pl>
References: <20230120011744.550701-1-mchl.grzlk@gmail.com> <87lelxlt18.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463809024-776833584-1674254459=:3790"
Content-ID: <5b8b88f9-a34b-dacf-ccb7-9b5973b44de3@student.agh.edu.pl>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809024-776833584-1674254459=:3790
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <71d82d96-8152-10ea-ddc-26c14e852aa@student.agh.edu.pl>

Hi Kuninori,

Thanks for quick reply.

On Fri, 20 Jan 2023, Kuninori Morimoto wrote:

>
> Hi Micha³
>
> Thank you for your patch
>
>> Running 'make DT_SCHEMA_FILES=renesas,rsnd.yaml dt_binding_check'
>> gives following warning:
>>
>> bindings/sound/renesas,rsnd.example.dtb:
>> sound@ec500000: port:endpoint: Unevaluated properties are not allowed
>> ('capture', 'playback' were unexpected)
>>         From schema: bindings/sound/renesas,rsnd.yaml
>
> Now I'm posting the patch for it.
>
> 	https://lore.kernel.org/r/87358hj2ub.wl-kuninori.morimoto.gx@renesas.com

Thanks also for pointing that out, I should have given more time to
searching for existing patches.

Best regards,
Micha³
---1463809024-776833584-1674254459=:3790--
