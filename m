Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8761874E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiKCSTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKCSTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:19:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6913D57
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:19:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g7so4238506lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkYzItvrSUXCjUZclqVlz4B1VRMJvcHSmP7Vz+/CqCc=;
        b=Ql3Wst5IDeTBu02tDij8+8WotMSKPkvfwkpBGQrs5DCDmlReH9R39/cKMIGZ9nQTw4
         CTNpSr+1rRsxJju1xOVWyv58dG7vruDtKj2QiyrwZZlt55RVpxRZMSd1GUviTtWFTlQt
         bE6yo4OanX1qxxPqrtbBfkv3g2/e5P7r/JJ4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkYzItvrSUXCjUZclqVlz4B1VRMJvcHSmP7Vz+/CqCc=;
        b=6dNBdWQkeWbm2TXRkI9sA5jrvhvk18SvpvXeORY8gp+xLPFdlqgRbc/2jA682/eOyY
         3RVxSNndjI2DygVhbYWNL2JY+XYbiJ+KQuwQwUIJEAOALx4Fp19SNEYFJ6wnYbE7hadQ
         ydLFJXkiCxbtRRug0FFQrozRB2WXheXOgntfJzHltb9VYHTwqj5CP89YPQZ3yyn3bPpI
         F8NLnbk+kmJvKgjjRSdr8jmj/UUcb+CAHR+sDxoD3dUo1MoiRvG0GsV+Q4aoprSSwSag
         w72j1Sg8tU7Cc15SrbkLz7iFgSVtEHmM67lP6leH2OWVadgDb7kfoT2gr4urasvOb/Gt
         0sSw==
X-Gm-Message-State: ACrzQf2VQnmAPCmcReqq27SntnG4b0jnl8ZXyRg+BstwOWsvPwNT7g2U
        Sh+HK1aWcxypmut/2dpdNp5romwh1SVsn9HWMHRwyw==
X-Google-Smtp-Source: AMsMyM50DKyuqpFk3z0RRrS/jQXXsTcb+YgJ2uT1ZBFhUVkjX0OEggksGtq8mwZhheS/vIGyWyzlrWJVtBWPTzBnqNs=
X-Received: by 2002:a05:6512:3403:b0:48c:9727:50b0 with SMTP id
 i3-20020a056512340300b0048c972750b0mr11849146lfr.309.1667499549321; Thu, 03
 Nov 2022 11:19:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Nov 2022 11:19:08 -0700
MIME-Version: 1.0
In-Reply-To: <Y2PAXX2oYL6iFTlB@hovoldconsulting.com>
References: <20221101233421.997149-1-swboyd@chromium.org> <Y2JL9/HFrb3E+CYY@hovoldconsulting.com>
 <CAE-0n51Wuc6gVmsTOu4Nf4yx+6Wp-Oi3XZy06syhCMVmePWPEw@mail.gmail.com> <Y2PAXX2oYL6iFTlB@hovoldconsulting.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Nov 2022 11:19:08 -0700
Message-ID: <CAE-0n5319JSX16Z3H5vKQSL9UDetOdfb38zo_vp0C=uX1jddWQ@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gdsc: Remove direct runtime PM calls
To:     Johan Hovold <johan@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, patches@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2022-11-03 06:21:33)
> On Wed, Nov 02, 2022 at 09:53:49AM -0700, Stephen Boyd wrote:
> > Quoting Johan Hovold (2022-11-02 03:52:39)
>
> > > > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Cc: Johan Hovold <johan+linaro@kernel.org>
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Cc: Taniya Das <quic_tdas@quicinc.com>
> > > > Cc: Satya Priya <quic_c_skakit@quicinc.com>
> > > > Cc: Douglas Anderson <dianders@chromium.org>
> > > > Cc: Matthias Kaehlcke <mka@chromium.org>
> > > > Reported-by: Stephen Boyd <swboyd@chromium.org>
> > >
> > > We typically don't add Reported-by tags for bugs we find and fix
> > > ourselves.
> >
> > Heh, I didn't see anything like that in Documentation/ so it seems fine.
> > I debugged my problem and reported it.
>
> I'd say the documentation is pretty clear on this matter:
>
>   Reported-by: names a user who reported a problem which is fixed by this
>   patch; this tag is used to give credit to the (often underappreciated)
>   people who test our code and let us know when things do not work
>   correctly.
>
>   - Documentation/process/5.Posting.rst
>
>   The Reported-by tag gives credit to people who find bugs and report
>   them and it hopefully inspires them to help us again in the future.
>   Please note that if the bug was reported in private, then ask for
>   permission first before using the Reported-by tag.
>
>   - Documentation/process/submitting-patches.rst

I don't see anything above that says I can't add this tag if I reported
(by sending an email about the problem to the list), debugged, and
solved the problem by sending a patch.

>
> Just like you don't add a Tested-by tag for every patch you submit, it
> is implied that you found the issue you fix unless you explicitly
> attribute that to a third party using Reported-by.

I don't see how this is the same. It certainly is not explicit, as you
say.

I wouldn't have added the tag if I didn't send an email to the list with
the lockdep splat and follow that up with a bisection report for
suspend/resume being broken. Shouldn't we value those sorts of bug
report emails? I will add a link to the report in the commit text to
clarify.

>
> This is the first time I see anyone trying to use Reported-by this way,
> and even if you think the documentation isn't clear enough on this, our
> praxis is.
>

Ok, so is it just a shock to see this for the first time? What is the
problem with the tag? Can you elaborate on your concerns? I would like
to understand.
