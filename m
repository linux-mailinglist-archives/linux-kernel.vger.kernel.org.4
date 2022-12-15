Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1101764E22D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLOUMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLOUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:12:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245DE2EF6A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:12:34 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f20so126745lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma29jYxLICPfJYdRmS8iS0Sz2Ww6x0xzpK34aJyoY38=;
        b=WAMocIyQLya3cZ3eoRREWyL3BJuNCw4hHzTN4zu8lxDR5ZNKjTqCzsxYDNl+EGJJam
         gwjij75zZhMjukUfT79v+h+7g9RMduI6pfuM5dCQ9kFJGj914ZIi+iCdEMUkSEN3iKvZ
         Kjh0w0DYmCEhqLYN6dcPY+roorUbtIZ7LGas8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ma29jYxLICPfJYdRmS8iS0Sz2Ww6x0xzpK34aJyoY38=;
        b=q99EeitVZ1VqePr2KSE6nrWQ2RWd6Mo5m4ZqjhNxIN/FTZL1klRZbmNaEkzh05eOSE
         S7Dk4XGOtpr/oZ2hy1kegamULUIh4MX2R5izOQVaKcpZmgyOsSIM7YACWF3s0URPvCxj
         kj1RYTP45pmAtnrBNod/ePiKXCoKVRUnqTf9cieYrhrt34el6s3z7A46fcn8szz0HOah
         yx6Bp6X3d77kbhSyEzwpVnFl7C+Pm7LNelESY38EZ2P59qq9epuUuk3DqYsnseC68nLv
         ScsiRoAcKx4Rywhepp6zhFo3dWZQ2ZTtEamcypyh3Ay9ZEeMwNar0W4YoUCWpZR2vntc
         i1Qg==
X-Gm-Message-State: AFqh2koj1MRAtP+uZX9aJ+/eveaNFOgY17dR3fAYI2eNpXjWae/o/mwK
        PCXGrnqHAzQ2GvAtf9zWDth2cyfpTK3Da0Cx9p64Dg==
X-Google-Smtp-Source: AMrXdXt3ybfdYsbW+NzMUL4sJXmfO6ubzbiioxX2yF9TmOb2VxGIBXIKmk+OiSkMyH6erDrmmUsl31yNVnS26c1UhTo=
X-Received: by 2002:a05:651c:3c7:b0:27d:75b3:8fd0 with SMTP id
 f7-20020a05651c03c700b0027d75b38fd0mr510146ljp.39.1671135152456; Thu, 15 Dec
 2022 12:12:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Dec 2022 15:12:31 -0500
MIME-Version: 1.0
In-Reply-To: <98cc6d55-f9c7-a369-6004-42b242d01339@quicinc.com>
References: <1670967848-31475-1-git-send-email-quic_khsieh@quicinc.com>
 <1670967848-31475-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52eHYCqxUJqQXoaQ8vyqCk-QfouSun+zUp3yo5DufWbwg@mail.gmail.com>
 <b38af164-08bc-07e7-dfaf-fb4d6d89d7db@quicinc.com> <CAE-0n53Cb6TFGfM6AYup5aP4=24j0ujVPi463oVqmzfNV2B4RA@mail.gmail.com>
 <98cc6d55-f9c7-a369-6004-42b242d01339@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 15 Dec 2022 15:12:31 -0500
Message-ID: <CAE-0n52j8vYYTRSpBo82MHqLiSjxikL=2P6NQwa0-DW__sc6WA@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, dianders@chromium.org,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        robdclark@gmail.com, robh+dt@kernel.org, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-12-15 09:08:04)
>
> On 12/14/2022 4:38 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2022-12-14 14:56:23)
> >> On 12/13/2022 3:06 PM, Stephen Boyd wrote:
> >>> Quoting Kuogee Hsieh (2022-12-13 13:44:05)
> >
> >> Therefore I think add data-lanes and link-frequencies properties in th=
e
> >> DP PHY binding directly will not helps.
> >>
> > I didn't follow your logic. Sorry.
>
> Sorry, probably i did not understand your proposal clearly.
>
> 1) move both data-lanes and link-frequencies property from dp controller
> endpoint to phy
>
> 2) phy_configure() return succeed if both data-lanes and link
> frequencies are supported. otherwise return failed.
>
> is above two summary items correct?

Yes.

>
> Currently phy_configure()=C2=A0 is part of link training process and call=
ed
> if link lanes or rate changes.
>
> however, since current phy_configure() implementation always return 0,
> the return value is not checking.
>
> This proposal is new, can we discuss more detail at meeting and decide
> to implement it or not.
>
> Meanwhile can we merge current implementation (both data-lanes and
> link-frequqncies at dp controller end point) first?
>

I don't think we can merge this patch because it depends on a DT binding
change. If the PHY approach works then I'd prefer we just go with that.
