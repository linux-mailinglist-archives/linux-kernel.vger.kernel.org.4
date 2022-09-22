Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4C5E6BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiIVTnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiIVTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:43:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B810AB22
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:43:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a26so23404423ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/QKOwekVmpIN1iELZeeAaMGxiIyfBaqOqMFigiI0UNg=;
        b=RrgQ++2W9ZlzvN2o0ReqZrP46rzCUJJS+f/Ky8rCAFxfn0B7wLR79CaWsJoP6YTUF3
         gF8wuO8ik8e7CraRROmztE4xYaK5rBgOCWyz+11p+qhGYZ+K1VrBYyKYZQsoh3Va+OG0
         Urp/FnUsSrDZeR7u+SOSgXqrxA/ynh1+eOG9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/QKOwekVmpIN1iELZeeAaMGxiIyfBaqOqMFigiI0UNg=;
        b=gtPmyczFwuq5SbF5kPqBbHWl9A2djRrWmz7yTqW/6159U5XBtWqnd9xO0KWnf3HW/l
         tbIlP4UUxcSju+MPrRa66gDMvAlKJE5DDGLdHVSwYxze09KVW9IqOqzQhGZe4gqH9MuR
         NBZ04+Hfa43JvPsM60Kol5i5nWrAEBVV76RrK72vz2EWdIoCwKcxyjlPQnd0rhNwEWe/
         xG8DWqQ6Yzwc+40uIQMDTCdmdsY4vvFrpEnKITqZBaujt7wDUrjelE495UOaaTifBBWw
         QObWRa2Wt9BtN9fdvaULwiIRw/Hdq+Gz5CdPACehottXx0NllQF1Ptn1ZWZdAms4Z8ma
         qXzA==
X-Gm-Message-State: ACrzQf3bHyaiQY7W8z/r3PvuDL14F6ZDpojOiW6Vj1Wpl8p3TaXP0UnR
        Ww/5+6yMEXGmQeFWHKUW/vir/eC6k8zcrEs/
X-Google-Smtp-Source: AMsMyM61imUPWFnfrYMMZuUSZEk3F91g35zpGtKqAGNkBK+wBaYrN+NhhOPl+Ae4rephCWZw4LRQdA==
X-Received: by 2002:a17:906:cc0d:b0:779:857f:3ee7 with SMTP id ml13-20020a170906cc0d00b00779857f3ee7mr4191167ejb.713.1663875831670;
        Thu, 22 Sep 2022 12:43:51 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id u17-20020a170906781100b00741a0c3f4cdsm3035688ejm.189.2022.09.22.12.43.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 12:43:51 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so2001178wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:43:51 -0700 (PDT)
X-Received: by 2002:a05:600c:5488:b0:3b5:634:731 with SMTP id
 iv8-20020a05600c548800b003b506340731mr2225058wmb.188.1663875831036; Thu, 22
 Sep 2022 12:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <12079576.O9o76ZdvQC@kreacher>
In-Reply-To: <12079576.O9o76ZdvQC@kreacher>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Sep 2022 12:43:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XtrDvMOHz2=LADEiQC4oh6Yz7Z5qopcg0r2xCYT6XELw@mail.gmail.com>
Message-ID: <CAD=FV=XtrDvMOHz2=LADEiQC4oh6Yz7Z5qopcg0r2xCYT6XELw@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Return -EINPROGRESS from rpm_resume() in the
 RPM_NOWAIT case
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 22, 2022 at 11:04 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The prospective callers of rpm_resume() passing RPM_NOWAIT to it may
> be confused when it returns 0 without actually resuming the device
> which may happen if the device is suspending at the given time and it
> will only resume when the suspend in progress has completed.  To avoid
> that confusion, return -EINPROGRESS from rpm_resume() in that case.
>
> Since none of the current callers passing RPM_NOWAIT to rpm_resume()
> check its return value, this change has no functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
