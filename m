Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E000C60CCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiJYNB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiJYNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:00:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFEC2AE07
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:59:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g24so5878916plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=96LIRsB1HO0sDOnMeXu2SEznERllTdLPf2hbAGzeCLU=;
        b=PkVoI/Hr7i19dP0wRJPePLbOQ7glExOzvk/WGmo4cI97w3fM5MNUY+1PManPMa8FDD
         Dkq/HQXoPv0Na/pu3ymBNVK4Cr2g9FQi8qeSkOWattoDE3iY2JIMWCjr/MzRCpO4l8Bg
         byYuDXY256tAWAWU5RdrSdl89vhfAuCaGKtGuzho5Hnh84mR9nU4edqhtSsd8I28ldwy
         90FK675CX+JCIs7JNmMOzSO1SVo4ogGgUrpQIPu6DRZIORRUW7lzBXpTgDtGo5bXQ2sT
         O/qJ3B0UBFdG56brTiQgZDAQSxWElUNNJKzWdFbNVNkSW8kFScxV8MPOnn79DQynSmqa
         o9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96LIRsB1HO0sDOnMeXu2SEznERllTdLPf2hbAGzeCLU=;
        b=CItEQODkVbEjiGyDquqJYt43gpsoXFVJWqmY4Exe2/Rp1u8YIruMDIDsLUvVGxZObN
         MjAEHOivIctUQUbJAO9jnhY7sTDCbLKY9xJyfyOBt5syhTO3VzAXH/MvDa7NSTy5n3lz
         ofektp1Ka6DXG/BlKDOMeBtetyUZXDS/NLL/6f5G8qbJCsR7Ckx+lWag2P1i4LsOp1Og
         93nVg21QqNsn/mzkUqGIGUko/iAsw65FfIf8Ia+3rR48czlLfruWgezD/ZFdc2Ic7uw3
         MhNyk7nLcqLu5S28zM3GXc4aoDUe5mCPpT8FSztEU92yPnx8gQ7q+xgemLQcMPq0nSA4
         Kt8g==
X-Gm-Message-State: ACrzQf0oG1S/2PARdkG0tIHN//8f0eLyatp1q5A6mtw+SFnGOoacK4T+
        vy2miJwpJw6SiKwl0NfV/uzIMqw8eAKylvm7Kz1Rnw==
X-Google-Smtp-Source: AMsMyM7n5GqCSaV7RGwB6j3SK/8pFh8/LRkYLfo8mm+igx2icUz6k/ZADp9s6iOyGqNaupMZQhGn/TBs0JzpUPluAoE=
X-Received: by 2002:a17:90b:1d8b:b0:20d:30a5:499e with SMTP id
 pf11-20020a17090b1d8b00b0020d30a5499emr80769484pjb.84.1666702750270; Tue, 25
 Oct 2022 05:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221025123432.1227269-1-sudeep.holla@arm.com>
In-Reply-To: <20221025123432.1227269-1-sudeep.holla@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Oct 2022 14:58:33 +0200
Message-ID: <CAPDyKFoQCvga_gjsvHfi3W=zETX2J9c8SnXH5xD6QDaVQ_C8-Q@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Fix handling of unavailable/disabled idle states
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 14:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Platforms can provide the information about the availability of each
> idle states via status flag. Platforms may have to disable one or more
> idle states for various reasons like broken firmware or other unmet
> dependencies.
>
> Fix handling of such unavailable/disabled idle states by ignoring them
> while parsing the states.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: a3381e3a65cb ("PM / domains: Fix up domain-idle-states OF parsing")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

I think this should be tagged for stable kernels too. Rafael, can you
pick this up as a fix for v6.1rc[n]?

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> Hi Ulf,
>
> As you already know, this change alone doesn't fix the issue reported here[1].
> It also needs the fixes you have posted [2].
>
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/all/20221018145348.4051809-1-amit.pundir@linaro.org
> [2] https://lore.kernel.org/all/20221021151013.148457-1-ulf.hansson@linaro.org

Well, I think it's better if we replace [1] with a patch that only
disables the cluster idle state. In that case, it would be sufficient
with $subject patch. In that case, we can just manage [2] separately.

Amit, can you submit a new version and test it together with $subject patch?

Kind regards
Uffe

>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ead135c7044c..6471b559230e 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2952,6 +2952,10 @@ static int genpd_iterate_idle_states(struct device_node *dn,
>                 np = it.node;
>                 if (!of_match_node(idle_state_match, np))
>                         continue;
> +
> +               if (!of_device_is_available(np))
> +                       continue;
> +
>                 if (states) {
>                         ret = genpd_parse_state(&states[i], np);
>                         if (ret) {
> --
> 2.38.1
>
