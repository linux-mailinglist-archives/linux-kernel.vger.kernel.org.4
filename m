Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3D72B3B8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 21:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjFKThq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjFKThp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:37:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5B2126
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 12:37:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77acb944bdfso233176139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686512263; x=1689104263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM7OM9iK+U+PV5SZtotWJ9eP4Pea45UXoIm4m6gjQgw=;
        b=fI/JS3uYbxcaUh8+namFMchJfNqzXabCbDqmSZUwXxXs72ORPtoJmidB4ksYDKPQjc
         wwR6C4Q78yzT9T/aIBKJiwUwOmgfvtCn7cYp0ueW+Zv95l5Ca2/f5dOloPLlDmfnlurf
         od85w+3THcorDk7r8x9UYM4OdxNapjiRMIGyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512263; x=1689104263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM7OM9iK+U+PV5SZtotWJ9eP4Pea45UXoIm4m6gjQgw=;
        b=Sekm4qQh96bFSIeMfDZ/ERlTLOVgnS0TJn/TVkiSSDcQzBHfu5RLEHs/7XQZ1mMpLB
         FAl7HuFVaBo08nVI1E2JxhHysF8Lezyn2VQmBjGWh03RPwsw27kc1fbf27Q6dxlZJWW6
         KM6C0DwoFUiXGLMosIX1YEc/HHcoj7srIrPJsUudUqBfw6vABp5nD0JFi5q1Zwfj2T+c
         glq/z0aI6cZ6ICfZXP46j57x8gsDaK0ks1/cC+U7mssyyjywkWPbQc/dGzVWdWR3O5S2
         379wsRFU5XP54TGNcf1a0cTXclGyK5h5Qsa5PZI4WvQBO/Lc80+ya5SJu6zoS12Azkaw
         242A==
X-Gm-Message-State: AC+VfDxEuFV5Th4XVf2jInvnGR1pUZYkVlfx8mmprL3cKvHOKsbNLzgI
        AdbaCYUxOM9w+IcIGW/BhyYHpwRqkoL0muE4fnk+vg==
X-Google-Smtp-Source: ACHHUZ7thqAggR7Av1USvcj3PSsn7/WY2NPYsKDUZC2xNkkpn0rPjeFsgAStZf3RB4OqK/j85lSN+TBvP7MsIU6Fz40=
X-Received: by 2002:a5e:9412:0:b0:779:89db:37b9 with SMTP id
 q18-20020a5e9412000000b0077989db37b9mr6981251ioj.9.1686512263254; Sun, 11 Jun
 2023 12:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230302095551.5510-1-quic_youghand@quicinc.com> <20230302095551.5510-2-quic_youghand@quicinc.com>
In-Reply-To: <20230302095551.5510-2-quic_youghand@quicinc.com>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Sun, 11 Jun 2023 12:37:32 -0700
Message-ID: <CACTWRwtz6HpszX4Dp2jJ5YmcZ2Mg2KxmyipfSQW4W-ELBkkCVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211: Add beacon hint notifier support
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpubbise@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 1:57=E2=80=AFAM Youghandhar Chintala
<quic_youghand@quicinc.com> wrote:
>
> There are connection failures in hidden SSID case when the device is
> with default reg domain WW.
> For WW reg domain most of the 5 GHz channels are passive. When device
> listens to the beacon on that channel, the driver is updating its
> channel flag but firmware is not aware of it and firmware is not
> sending probes on that channels.
> Due to this, we are seeing connection failures when the device is trying
> to connect with hidden SSID AP.
>
> In the case of devices using the ath10k driver, it is required to update
> the change in channel flags to firmware as well. Therefore, we need a
> mechanism to notify the driver from the regulatory core regarding the
> channel flag changes.
> Adding a beacon hint notifier logic, so that drivers can register
> callbacks to get notified whenever there is a change in channel flags.
>
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> ---
>  include/net/cfg80211.h | 7 +++++++
>  net/wireless/reg.c     | 5 ++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 11a370e64143..7a00f5317e1f 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -5096,6 +5096,10 @@ struct wiphy_iftype_akm_suites {
>   * @reg_notifier: the driver's regulatory notification callback,
>   *     note that if your driver uses wiphy_apply_custom_regulatory()
>   *     the reg_notifier's request can be passed as NULL
> + * @beacon_hint_notifier: the driver's beacon hint notification callback=
,
> + *     which will trigger when there is channel flag updates seen in
> + *     beacon hints. The beacon_hint_notifier's request can be passed
> + *     with chan context.
>   * @regd: the driver's regulatory domain, if one was requested via
>   *     the regulatory_hint() API. This can be used by the driver
>   *     on the reg_notifier() if it chooses to ignore future
> @@ -5386,6 +5390,9 @@ struct wiphy {
>         void (*reg_notifier)(struct wiphy *wiphy,
>                              struct regulatory_request *request);
>
> +       void (*beacon_hint_notifier)(struct wiphy *wiphy,
> +                                    struct ieee80211_channel *chan);
Is the second argument required. Your 2/2 patch does not use this
argument and thus will cause build failure. If it is not used, I would
recommend to drop it.
> +
>         /* fields below are read-only, assigned by cfg80211 */
>
>         const struct ieee80211_regdomain __rcu *regd;
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index c3d950d29432..2dc6880a28c5 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -2219,8 +2219,11 @@ static void handle_reg_beacon(struct wiphy *wiphy,=
 unsigned int chan_idx,
>                 channel_changed =3D true;
>         }
>
> -       if (channel_changed)
> +       if (channel_changed) {
>                 nl80211_send_beacon_hint_event(wiphy, &chan_before, chan)=
;
> +               if (wiphy->beacon_hint_notifier)
> +                       wiphy->beacon_hint_notifier(wiphy, chan);
> +       }
>  }
>
>  /*
> --
> 2.38.0
>

Thanks
Abhishek
