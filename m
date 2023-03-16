Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C844F6BC2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCPAon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCPAok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:44:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACABB3D936
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:44:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s22so295899lfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678927476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdHTO7r/qWwc37NG0KfD//nV1f0Fmimh5IOse5pWXK4=;
        b=anqrjvcHRO2REMCEyQGrabPAJZqSVGYWfgKG1db9qduO6iQ7lLe/059twBJhcgOZZS
         3UZIbz5/EQDTu43xcmjd16na1X3x2YC5rcTK3vsPlLzn08yLGf2/wfFpcmS9XnCVBrIu
         WmWVblowCFMCx1lH943DX/6qJilgY0yhqMYLkK++Fb1b7oYIRBFE7+EAXLAini9MdkSE
         PCnIJ7Ruh3eNy1lDQnZfo9RH7+AmqVEfQQ6qcuV81uD6ONFd90uFD650t+jPEN8l59gk
         fH8v/W9gkxPTzhwRaZknBKuytJB4G4UtDom2E7hSgF8QIwc3XRTE3Zu4HMnrh1ujlHfQ
         ZnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678927476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdHTO7r/qWwc37NG0KfD//nV1f0Fmimh5IOse5pWXK4=;
        b=nPiXxV6HCkbjMt40fSY7Hr/IIbRUXitzfqYFl0/iLhwUI4jLMAp8lVF26ffyYecj8H
         45m737y64TDjwCfP/X8LVoF91I8blsNAv11LUOgl0CNBxEEO4fs+nxAUI6moWPGpGmsz
         DZ49cuqRGXgAV7Fh5N+Zhq7WwS/TZyBpajXkBHW7fmWK46vlB+zckrc9OJbwl9lSQFFT
         O8rLYYX0sbh17DD63ybf08aANnLTK1H/UQrY8qFR3SY7eJff1I+NcoXGS+9LhTK/MisX
         OWDqKanY3gpmkDn2A7poXbOe8vyGfRaUkYuPZGSWXlqqwpb2mbFrVTOhf9KZgUZkolBp
         s+jg==
X-Gm-Message-State: AO0yUKVIiby+dQKLpICSI6kCKfi1SLyR8mWzBfB5HbpsZeMk49Mmcr/G
        lgW//wfYYK3IWCE4798i4+h7VQ==
X-Google-Smtp-Source: AK7set+zuznVSzozkhNOwTFpILN2nC7k2EOJ81hKG8EJr1QUVhV300YfCExMPAk3hSCFdXwgZtcG0g==
X-Received: by 2002:ac2:597c:0:b0:4a4:68b9:19da with SMTP id h28-20020ac2597c000000b004a468b919damr2488893lfp.2.1678927475910;
        Wed, 15 Mar 2023 17:44:35 -0700 (PDT)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q19-20020ac25293000000b004dc4b00a1f3sm1001254lfm.253.2023.03.15.17.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 17:44:35 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Subject: Re: [PATCH v14 00/14] Add PSR support for eDP
Date:   Thu, 16 Mar 2023 02:44:34 +0200
Message-Id: <167892745598.2525998.13449367044508002295.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Mar 2023 22:03:03 +0530, Vinod Polimera wrote:
> Changes in v2:
>   - Use dp bridge to set psr entry/exit instead of dpu_enocder.
>   - Don't modify whitespaces.
>   - Set self refresh aware from atomic_check.
>   - Set self refresh aware only if psr is supported.
>   - Provide a stub for msm_dp_display_set_psr.
>   - Move dp functions to bridge code.
> 
> [...]

Applied, thanks!

[01/14] drm: add helper functions to retrieve old and new crtc
        https://gitlab.freedesktop.org/lumag/msm/-/commit/ef708af6054c
[02/14] drm/bridge: use atomic enable/disable callbacks for panel bridge
        https://gitlab.freedesktop.org/lumag/msm/-/commit/49291dbf1cd8
[03/14] drm/bridge: add psr support for panel bridge callbacks
        https://gitlab.freedesktop.org/lumag/msm/-/commit/26966d5bc7dd
[04/14] drm/msm/disp/dpu: check for crtc enable rather than crtc active to release shared resources
        https://gitlab.freedesktop.org/lumag/msm/-/commit/c235a0d4a185
[05/14] drm/msm/disp/dpu: get timing engine status from intf status register
        https://gitlab.freedesktop.org/lumag/msm/-/commit/15b04e280119
[06/14] drm/msm/disp/dpu: wait for extra vsync till timing engine status is disabled
        https://gitlab.freedesktop.org/lumag/msm/-/commit/b2afc29853c3
[07/14] drm/msm/disp/dpu: reset the datapath after timing engine disable
        https://gitlab.freedesktop.org/lumag/msm/-/commit/392a21678a7f
[08/14] drm/msm/dp: use atomic callbacks for DP bridge ops
        https://gitlab.freedesktop.org/lumag/msm/-/commit/20536d1c512b
[09/14] drm/msm/dp: Add basic PSR support for eDP
        https://gitlab.freedesktop.org/lumag/msm/-/commit/c0b993bbfe9e
[10/14] drm/msm/dp: use the eDP bridge ops to validate eDP modes
        https://gitlab.freedesktop.org/lumag/msm/-/commit/de9512e23adc
[11/14] drm/msm/disp/dpu: use atomic enable/disable callbacks for encoder functions
        https://gitlab.freedesktop.org/lumag/msm/-/commit/f62087459d8a
[12/14] drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver
        https://gitlab.freedesktop.org/lumag/msm/-/commit/1bd583580cba
[13/14] drm/msm/disp/dpu: update dpu_enc crtc state on crtc enable/disable during self refresh
        https://gitlab.freedesktop.org/lumag/msm/-/commit/0f2a8f000c21
[14/14] drm/msm/dp: set self refresh aware based on PSR support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/0c3f3cfd8ef2

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
