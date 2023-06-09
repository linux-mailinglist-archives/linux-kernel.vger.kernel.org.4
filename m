Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10436729DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjFIPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjFIPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:07:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8F269A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:07:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75d4aa85303so165027185a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686323247; x=1688915247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmJ5zFCWUL2O8tDvqWovVw/cx5VcmioXKAOPxd/sjek=;
        b=EJjiBXsvAs4s7IV6doN/gB7G9g7FvLlLobTORp9YgNpKhK3Ky9tOM1dyuX4mx0djOo
         k5KfoB5zmIQ5ogdnVbkv3ltQAmxiWJ8V2DLUIe1EzTyPuFUreqvL1eOXlSun/JRKZQSu
         zh2lLExIkJmfQ3GrJMkcDryNvc8A53XizaGYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323247; x=1688915247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmJ5zFCWUL2O8tDvqWovVw/cx5VcmioXKAOPxd/sjek=;
        b=Ep/AeUHLUxqD0EoqaR/ZU9y7t7fFuaZqhqGRcERCHyRIUTymj+XoMY0dOS9lFFCTuh
         ktxIvofCP5ZezB4wzzAZk7/IQxlhtYLXdmIWTbIxasiHwfNrRiLpwCvzQkCsDvh591MV
         cVU6yw2BFEJVaOfdbsFzqetwLV1gPBt3bpB3eKU/OOzohLB9qAJbcmMkiD37LYAO/Shv
         3ot77dCqKOq94AoHE7inyHH1EFzu0Y9BKMakCQoXXmt5OGzrgZYc1xOIZw+HQXhHSrm2
         ypHFJjQlSThcJzsQ8wUgmCf7e+GfRrGgF/Da07kwo85aPe2Xzw45zH3U3tTLGq6jUCt1
         J/zw==
X-Gm-Message-State: AC+VfDzYQEKMSHGSKI0qPRcRy5V6niLzIHxK8DSvWdPFerkbe8VlCiUv
        1nZnD506v4YGU2v6AnoXU2oshxjMJT5S9EWsqKk=
X-Google-Smtp-Source: ACHHUZ5Aj+4ZGnY5qo4VMTXkUXS5ocZGuuwXnzrI6YydeEW+nUof2sTjbDfKUgmtPBvd9hYcSPjOEA==
X-Received: by 2002:a05:620a:8c93:b0:75f:4eb:6bd8 with SMTP id ra19-20020a05620a8c9300b0075f04eb6bd8mr115497qkn.77.1686323247009;
        Fri, 09 Jun 2023 08:07:27 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id e9-20020a05620a12c900b0075b13a89c30sm1094867qkl.3.2023.06.09.08.07.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:07:26 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3f98276f89cso423061cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:07:26 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d02:b0:33d:cd39:c1cd with SMTP id
 i2-20020a056e021d0200b0033dcd39c1cdmr397198ila.14.1686322880679; Fri, 09 Jun
 2023 08:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230607215224.2067679-1-dianders@chromium.org>
 <20230607144931.v2.8.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
 <y3l4x3kv7jgog3miexati5wbveaynnryzqvj6sc4ul6625f2if@w7nqgojfavfw>
 <CAD=FV=W-fXpm4JCczrNgAS2M9u2VLd2jAkJvE9XJgQpvoE5rjA@mail.gmail.com> <CAO-hwJ+3M1iYgaAFEtf-63U20ccGfdiRoi3197YoZmyvMYsGzQ@mail.gmail.com>
In-Reply-To: <CAO-hwJ+3M1iYgaAFEtf-63U20ccGfdiRoi3197YoZmyvMYsGzQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 9 Jun 2023 08:01:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4aYuLC-8xgSD1VkCGnKEm4oRdYkHSajx7pL8aGu6YqA@mail.gmail.com>
Message-ID: <CAD=FV=X4aYuLC-8xgSD1VkCGnKEm4oRdYkHSajx7pL8aGu6YqA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] HID: i2c-hid: Support being a panel follower
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, hsinyi@google.com,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-arm-msm@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 9, 2023 at 2:27=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> > I suspect that it's not worth it, but I'll do this if you feel
> > strongly about it.
> >
> > I guess the simplest way I can think of to move this to its own file
> > would be to put the whole private data structure (struct i2c_hid) in a
> > private header file and then add prototypes for i2c_hid_core_resume()
> > and i2c_hid_core_suspend() there. Then I could add something like
> > i2c_hid_core_handle_panel_follower() that would have all the
> > registration logic. I'd still need special cases in the core
> > suspend/resume/remove code unless I add a level of abstraction. While
> > the level of abstraction is more "pure", it also would make the code
> > harder to follow.
> >
> > Unless I hear a strong opinion (or if this series changes
> > significantly), I'll plan to keep things in the same file and just use
> > a Kconfig.
> >
>
> Right, a separate file might not be the best then :(
>
> Do you envision this to be used on the ACPI side of i2c-hid? Because
> if this is OF only, then maybe it would be interesting to put it there
> (in i2c-hid-of.c), instead of having it in the core. IIRC i2c-hid-of
> also has ways to set up/down regulators, so maybe it'll be better
> there?

There is no reason why this problem would be limited to devices using
devicetree. Even if ACPI could somehow magically power sequence the
touchscreen and panel together, doing it behind the back of the kernel
driver would be a bad idea anyway so folks using ACPI would need the
same code. I don't have tons of experience with ACPI nor how to hook
this up there, but I purposely made the API for registering the panel
follower such that the client doesn't pass anything devicetree
specific. If someone could figure out how to detect a link between a
panel and a touchscreen for ACPI and add this code to
drm_panel_add_follower() then it would automatically work for the ACPI
case as well.

-Doug
