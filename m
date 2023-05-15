Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6D70241D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjEOGII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbjEOGHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC52123
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19C4F60FE4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E20EC4339B;
        Mon, 15 May 2023 06:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684130717;
        bh=f6bqMU+euOnxpPgqmR9h+2rAd+JPlhMh/M8elKFs1VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPQ+1Cdaf+upl9IkJQltBUGaJM7a91WJKbJBF6Zwd2EkvCJ8r5imfCvCgkN4Z+n9p
         3O2lyXPsvOtYvvruTpEyv2YXA9QmDWpTFcU6bfGjy6R2xmO4hMVDikh9smPCnPiL47
         TcSl/eJ655OnhkDDbgP1IerZhUfrsreBgObcqGvrb+ciQ1E0tpGHjDFYF/H8fwQbaW
         ty+W0ZuOqxZPaLb1ftnD7ZNWrO2QV5/KDz1Pkdv8gG+9kc6sAnE+HmEhTo+kmrsZUu
         2CIkzU2gEWwxjcVGh4vTzqMefcvnQQKoeox3qyH1Q5KT3Xz77psRTkn8V0ljpazSY3
         np4oSFILWhwWg==
Date:   Mon, 15 May 2023 14:05:13 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Tim Van Patten <timvp@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, lalithkraj@google.com,
        robbarnes@google.com, rrangel@chromium.org,
        Tim Van Patten <timvp@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Move host command to
 prepare/complete
Message-ID: <ZGHLmVZbpBC7pNS7@google.com>
References: <20230512113556.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512113556.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:35:57AM -0600, Tim Van Patten wrote:
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> .prepare() and cros_ec_lpc_complete() during .complete(). This moves the
> host command that the AP sends and allows the EC to log entry/exit of
> AP's suspend/resume more accurately.

This is an old series.  It should preserve the version number and change logs
(at least until v8[5]).

Went through the series again, and put all concerns together:

* Should it print more logs during suspend/resume?  See v1[1].
  * Which is more like local patches for debugging some specific issues.

* Should it move the callbacks?  See v2[2].
  * Is it appropriate to call cros_ec_suspend() when PM is still in prepare
    phase and call cros_ec_resume() when PM is already in complete phase?

* Should it print return value of cros_ec_resume()?  See v3[3] and v7[4].
  * By referencing other use cases, they just defer it to PM.

[1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220701095421.1.I78ded92e416b55de31975686d34b2058d4761c07@changeid/
[2]: https://patchwork.kernel.org/project/chrome-platform/patch/20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid/
[3]: https://patchwork.kernel.org/project/chrome-platform/patch/20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid/
[4]: https://patchwork.kernel.org/project/chrome-platform/patch/20220823095915.v7.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid/
[5]: https://patchwork.kernel.org/project/chrome-platform/patch/20221028171820.v8.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid/

> Signed-off-by: Tim Van Patten <timvp@chromium.org>
> Reviewed-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: Tim Van Patten <timvp@google.com>

It shouldn't need duplicate S-o-b.
