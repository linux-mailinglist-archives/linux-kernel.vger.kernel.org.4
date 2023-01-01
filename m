Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FAC65AA26
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjAAOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 09:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAAOPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 09:15:45 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C51C27
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 06:15:44 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id s127so12197511vsb.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuFZ44C0YwmT4jbmclaWDxvon1oy7DdQSZfYjsKH4cQ=;
        b=N/kMHF5WTq1tgq6B6XOEexI/55/xBznFtAd9XO0WI7UFrpGg5jrceQTb4WWWvkgq1J
         3jm1ENfR8nC+z0+2ne3yaBWnozUf1UwIyA5wttlGrhpzYeP407LzjxzXi/nP4L2vgZF7
         QKqIviE0B9miQXRUhXy89dN4RxHx6Bb1fAKT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuFZ44C0YwmT4jbmclaWDxvon1oy7DdQSZfYjsKH4cQ=;
        b=GqQBZZUnPFndFJzB6sFvTKpeg+Sqqo6Krs+xiiXYnTOuSUXYQZw+Eec+eRN8dpcYdU
         6Kf52GaByPVQqxFzay2NU8++kHrfinpvxBXKgoAYqiPgzYX+aGfEeplnaC2thCo19Y9V
         LE2rOnnyu9JyEhPG9sOUoGwD7t+cmjgrRhFEBeHlLUzGM/JbLEmN0Gktr0D3k+wqq1bs
         3Q3o6RBPHGSSvVzaP46a4GuhP2x9RfZfDO0TfCaqCf1GXSu7djs+nopbyzsQ9ZmZiAJO
         5f1s+iWs14g0qJG8EI7jJjBp0FNk40kBEdYolLcks/X9LSkoDCxMDXQGbSvmXcPCQ9SR
         cOfw==
X-Gm-Message-State: AFqh2krwjUTpcxnd74YUnIDocQbAmNrlRELx7YnCujfeLEPV+hyA/LHF
        p/tq7OZxNR4gxJrJ2TqWGr+r6g==
X-Google-Smtp-Source: AMrXdXsbE1ujfH3UvrOCh00ab4c+8GIQ8cVkAOHEyemQY3k8lu28j2I94hTI3D8EXeSJ7XVxY0VDFQ==
X-Received: by 2002:a05:6102:3138:b0:3cd:b27:ed75 with SMTP id f24-20020a056102313800b003cd0b27ed75mr3121359vsh.10.1672582543570;
        Sun, 01 Jan 2023 06:15:43 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id c15-20020ae9ed0f000000b006ff8a122a1asm18504012qkg.78.2023.01.01.06.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 06:15:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] torture: Fix hang during kthread shutdown phase
Date:   Sun, 1 Jan 2023 09:15:31 -0500
Message-Id: <6630F427-88C6-4DEE-B069-35B81835E387@joelfernandes.org>
References: <Y7FI71mW7ZJZDiTI@kroah.com>
Cc:     linux-kernel@vger.kernel.org, Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, stable@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>
In-Reply-To: <Y7FI71mW7ZJZDiTI@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 1, 2023, at 3:48 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> =EF=BB=BFOn Sun, Jan 01, 2023 at 01:20:01AM -0500, Joel Fernandes wrote:
>> On Sun, Jan 1, 2023 at 1:16 AM Joel Fernandes (Google)
>>> Cc: Paul McKenney <paulmck@kernel.org>
>>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>>> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
>>> Cc: <stable@vger.kernel.org> # 6.0.x
>>=20
>> Question for stable maintainers:
>> This patch is for mainline and 6.0 stable. However, it should also go
>> to 6.1 stable. How do we tag it to do that? I did not know how to tag
>> 2 stable versions. I guess the above implies > 6.0 ?
>=20
> The above implies 6.0 and newer already which included 6.1, so all is
> good.

Thanks a lot for clarification,

 - Joel=20


>=20
