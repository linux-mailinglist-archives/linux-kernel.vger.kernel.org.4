Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3085B7931
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiIMSLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiIMSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:11:05 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E74642D3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:17:49 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1278624b7c4so33985437fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DRrSt1g1MwWWIcrp8RvrIGoWocVBN6Pz07Q5HTcSUe4=;
        b=OgNrTzvafqsbqCKy9d8AO957d5rSQDMlcymT2RJaj627dRsLVvZwbojoy3oDjPb2LY
         9kYbZN+9OotFDdln4t7sWUr30bJjf/A+X5uQT5MEgD/otHEy57ZBdTEDrlfsa2l85MtE
         /XtetIM2X/Odqh1MZkDS5gfQCk2qjrZW3aAmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DRrSt1g1MwWWIcrp8RvrIGoWocVBN6Pz07Q5HTcSUe4=;
        b=FUtXthJBtuQ7d3CxiTEvSnMBdzWyGa6FVuGR2/QDSumxwNyRLwu8z4MSjP07Smb5P0
         0+q5I5cpQrbFpyy8vCzVBYOe1kqGf9Fjfk8PmXrvwIVwv0hIl3mkDzfkLcTMruf7iCJc
         cw1cPjcgRrcbG7e6lunIgv4CMKLRq1WQIa5jl1esdXmNgrxA+X8/EnvAEh0NZYNmV2Mv
         neP12913UuU90Tz9uokNYoN8eJemOaLW23GoOwmN427D2XF5oKo2Q7T/yGhMJKX16Q+G
         R/+bzKLA0jLnoC1RcAXQvH+rROeX/Uhnix2cVZGlQHtg3v3Mwj9tOsRU3NjLcjqa5LTw
         rSiA==
X-Gm-Message-State: ACgBeo38RwGbHEBlfswUx7FcFjxG2VR07fSfdmepGfekvz8+zaNJdcSP
        X9HJy/qaoRLZGHS4kZfyLrCJU55l30w6clvJgGUlYQ==
X-Google-Smtp-Source: AA6agR6lGJjOKjRAA18P3LgKh5BJ1kmfGGmXulrZufDWxYKMksK2fHr5gTpOX1MQI/0k7i50uYVHYUMQQIqLU22CZh4=
X-Received: by 2002:a05:6808:3021:b0:335:182f:a66a with SMTP id
 ay33-20020a056808302100b00335182fa66amr137569oib.295.1663089469116; Tue, 13
 Sep 2022 10:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220913145549.2839948-1-jthies@google.com>
In-Reply-To: <20220913145549.2839948-1-jthies@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 13 Sep 2022 10:17:37 -0700
Message-ID: <CACeCKadOcKsmpvdtYf5QhUxcMA82angLzZBHx2yZ9QHJPv=bsw@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Notify the PM of wake events
 during resume
To:     Jameson Thies <jthies@google.com>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Jameson,

On Tue, Sep 13, 2022 at 7:55 AM Jameson Thies <jthies@google.com> wrote:
>
> cros_ec_handle_event in the cros_ec driver can notify the PM of wake
> events. When a device is suspended, cros_ec_handle_event will not check
> MKBP events. Instead, received MKBP events are checked during resume by
> cros_ec_report_events_during_suspend. But
> cros_ec_report_events_during_suspend cannot notify the PM if received
> events are wake events, causing wake events to not be reported if
> received while the device is suspended.
>
> Update cros_ec_report_events_during_suspend to notify the PM of wake
> events during resume by calling pm_wakeup_event.
>
> Signed-off-by: Jameson Thies <jthies@google.com>
Although I've already provided the tag, here it is again:

Reviewed-by: Prashant Malani <pmalani@chromium.org>
