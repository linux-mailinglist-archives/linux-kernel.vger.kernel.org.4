Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810C0631A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKUHWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKUHWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:22:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0729B634D;
        Sun, 20 Nov 2022 23:22:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B358260E65;
        Mon, 21 Nov 2022 07:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5EAC433C1;
        Mon, 21 Nov 2022 07:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669015352;
        bh=WJG5+ANBw3FNv8nSoyzix1RmK2851uIlja2ML+dxAGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqeoS5rbkczlGuKqlnIHgiRck4mOCvfARtsq3dZXoxw6tSmt9h/OKmgdVhke86be1
         jXMR+pSaqlbUkRAIJGLySlqQRlqU9R+osgivlYdqM/G+Awz6v6Uo9uUndBJ1a77BzC
         Qp8NzTeq5zNV/Co5EOUa3r0iKhf0fRNZ+FktRCFeu+dBZjhC6xgn9Jmrl/6x9zTtXW
         ZHzZOeI4Lv3HerisUjz4P/8scjLMLP9jLXGNlPFbiecf+Lw6DDpUKaKDX5tQnBA07G
         oQs+2HasKXtlDgaA8QiDRVWoNl/vV5k+fDhGwpvlMCyz38T9mqC/9RkRCmk0ixYcB6
         TJ+2kosPeV4Wg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ox17x-0002R1-V9; Mon, 21 Nov 2022 08:22:02 +0100
Date:   Mon, 21 Nov 2022 08:22:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <Y3snGQet8yc7HnJK@hovoldconsulting.com>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:27:48PM +0530, Viresh Kumar wrote:
> This removes the special code added by the commit 2083da24eb56 ("OPP:
> Allow multiple clocks for a device"), to make it work for Qcom SoC.
> 
> In qcom-cpufreq-hw driver, we want to skip clk configuration that
> happens via dev_pm_opp_set_opp(), but still want the OPP core to parse
> the "opp-hz" property so we can use the freq based OPP helpers.
> 
> The DT for Qcom SoCs is fixed now and contain a valid clk entry, and we
> no longer need the special handling of the same in the OPP core.

Didn't this affect also sc8280xp? Perhaps you can hold off with applying
this one for a bit until the needed devicetree changes are in linux-next
for all the affected platforms.

(It looks like Mani's series only updated sm8450 and I guess Bjorn
hasn't picked up that one up yet either.)

Johan
