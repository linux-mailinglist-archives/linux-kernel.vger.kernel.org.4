Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2877703B93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbjEOSES convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244250AbjEOSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:03:54 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466AB203FC;
        Mon, 15 May 2023 11:01:27 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so3259239a12.0;
        Mon, 15 May 2023 11:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684173685; x=1686765685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArEG0ZN9pPg0Ay1YuAo3WHIcnmij7Hl9mkI/ml6iOZI=;
        b=LvZ62/DzcFo1NqRyQUx1vsHQCySIiHpEIBsHeq3YdV9GZk6ZKGJeQH3v5n/zESeFfw
         UDIh4nV2qQ3E5RzEVZCtFnFUG5P0QudOZmzI+upfHDZv+4mEjtyxdgGRRUSSFbT5V928
         5XXcO29HK0EYpiDb9uVb84ojcujRltGHSwFwDP+89HnwGw1KpHg2wcjlOVWzY8atS0W9
         rWx6zWAvEfnFx1yborOoHgLHNb7Tx94R8qMsdEBDX0Q2Zij0RBY5s7rP29YIjORgkwYK
         Uds56QJRnvq8HCBFlowKVgODc3sFTZG4l9v1V0M8of7+oa03i2IsOqKvirJLIUrn0+53
         ZNCQ==
X-Gm-Message-State: AC+VfDxXtR8yezWIMbhw0AfBLrY2PB+f+KdKUNh1TtJwCpNWNm6ZvHjs
        k6qPJEWM6bjmBrl5hcFa0t7wD/PtgpJO6RIwbhSIc+uz
X-Google-Smtp-Source: ACHHUZ7XZLt68OO1jFz+jSBGw5Cn3iv65K+J/VTX8/Xtsm1RXquiBLjHPP1ZCqFvG0M6++WsleEspObPI73p7BiOoes=
X-Received: by 2002:a17:906:73dc:b0:94f:4ec3:f0f5 with SMTP id
 n28-20020a17090673dc00b0094f4ec3f0f5mr7240108ejl.4.1684173684713; Mon, 15 May
 2023 11:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230511125312.24207-1-petr.pavlu@suse.com> <ZGDfP6e/Ubgt49YN@kevinlocke.name>
In-Reply-To: <ZGDfP6e/Ubgt49YN@kevinlocke.name>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 May 2023 20:01:13 +0200
Message-ID: <CAJZ5v0jVwHt-EoZ4YHc+8Df2W9FmO1OxfpjbTDPyW_gsAoYQ=w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: cpufreq: Prevent a warning when another frequency
 driver is loaded
To:     Kevin Locke <kevin@kevinlocke.name>,
        Petr Pavlu <petr.pavlu@suse.com>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 3:16 PM Kevin Locke <kevin@kevinlocke.name> wrote:
>
> On Thu, 2023-05-11 at 14:53 +0200, Petr Pavlu wrote:
> > Address it by changing the return code in acpi-cpufreq and pcc-cpufreq
> > for this case from -EEXIST to -ENODEV which silences the warning in
> > call_driver_probe().
> >
> > The change has also a benefit for users of init_module() as this return
> > code is propagated out from the syscall. The previous -EEXIST code made
> > the callers, such as kmod, wrongly believe that the module was already
> > loaded instead of that it failed to load.
>
> Thanks for addressing this issue so quickly!
>
> I can confirm that with this patch applied I no longer receive
> kernel: acpi-cpufreq: probe of acpi-cpufreq failed with error -17
> at boot.  Additionally, modprobe acpi-cpufreq now produces
> modprobe: ERROR: could not insert 'acpi_cpufreq': No such device
> rather than silently failing (without --first-time) to load the
> module as it did before, which seems good to me.
>
> Tested-by: Kevin Locke <kevin@kevinlocke.name>

Applied as 6.4-rc material, thanks!
