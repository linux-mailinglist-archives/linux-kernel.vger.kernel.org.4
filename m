Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681FA728285
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbjFHOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFHOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22561730;
        Thu,  8 Jun 2023 07:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E19864AE0;
        Thu,  8 Jun 2023 14:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA543C433EF;
        Thu,  8 Jun 2023 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234025;
        bh=Th1LxrT8KdmLSh3YIuh2Q25jf9THPmdHaJyxevJaMSo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rTUDLf9qOVFeZzKzI8cahDWYq5vldNr97JiP2rUutibt8l76hmUuot/905aAv91iM
         Tsdvp8LqZ5x/4fYbVPOaPJujmOtLx3YTv1dxppAPQTc2RVZTc4Aoy3pP/PZEiLdgj1
         ydRlumN2v4zSUsYf43NHnMCpq0x0wA2CmcZckRgCtnqknj/zgsvATxXZM8WjTa5doz
         F/IlysnPgKhT+4bYt2Dz1XT513JS+ix6GGG5xvr7EuzmUzzog9kwOasRqK7LbVkfUR
         Yb7ljPaJ5ruM+5Tk0NSaUkM01wxdllsI/yNAUdBmwFokTJpi1uDmABIpHSCLSPu7U4
         OVmiEUrlmIkdw==
Date:   Thu, 8 Jun 2023 16:20:11 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Fei Shao <fshao@chromium.org>
cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Kitt <steve@sk2.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/2] Fix Goodix touchscreen power leakage for
 MT8186 boards
In-Reply-To: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
Message-ID: <nycvar.YFH.7.76.2306081619470.5716@cbobk.fhfr.pm>
References: <20230524114233.RESEND.v4.2.I424e840ae6de3cdbd67394cf4efd24534f6434ba@changeid>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Fei Shao wrote:

> These changes are based on the series in [1], which modified the
> i2c-hid-of-goodix driver and removed the workaround for a power leakage
> issue, so the issue revisits on Mediatek MT8186 boards (Steelix).
> 
> The root cause is that the touchscreen can be powered in different ways
> depending on the hardware designs, and it's not as easy to come up with
> a solution that is both simple and elegant for all the known designs.
> 
> To address the issue, I ended up adding a new boolean property for the
> driver so that we can control the power up/down sequence depending on
> that.
> 
> Adding a new property might not be the cleanest approach for this, but
> at least the intention would be easy enough to understand, and it
> introduces relatively small change to the code and fully preserves the
> original control flow.

Please apologize the delay. Now applied.

-- 
Jiri Kosina
SUSE Labs

