Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E8737D85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFUIe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjFUIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B9819AC;
        Wed, 21 Jun 2023 01:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39BE661452;
        Wed, 21 Jun 2023 08:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8563AC433C8;
        Wed, 21 Jun 2023 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687336488;
        bh=r6U/wiN4yjlHDSDq9vyDDHA8xXXk2YRJxVxtk46DIlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZdO6yM56gukvs/jIK7F/cmrtA3TS7Dg1XxN+QYdCIKQCb33aWA0wcUfJG5tHu68t
         LOAlzGLY+k8vXGAcIVmPSfpmduFrtlspn5hXfWpU41Y2v69RB7ssS6g96B5XVNKQO4
         WnJbqMf96zNpPHnOhOjmYUbFKr1BrWmvJL8b1+q+oz0w52yktL/P3TWLjSDPQ2Crb1
         yWM9OSp1nXwGw8ljzgHttJ3UxjnZV1GNUI+q3D2SllMrdq1kEqqvPyPkX4oBgxm7E3
         NRCvjCwy/xniwou2StPq7pe5U5LUcDXH2VTpFMzTYZo1XV+eC+rHlK3RU+UogAe0mq
         oZp8gtJk02xJQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBtIg-00063W-Bw; Wed, 21 Jun 2023 10:34:51 +0200
Date:   Wed, 21 Jun 2023 10:34:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>
Subject: Re: [PATCH RESEND v2] interconnect: drop unused icc_get() interface
Message-ID: <ZJK2Ki6--nLe8bK0@hovoldconsulting.com>
References: <20230523095248.25211-1-johan+linaro@kernel.org>
 <37dcbd3c-1e41-023c-8bbd-19cf9c9f151b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37dcbd3c-1e41-023c-8bbd-19cf9c9f151b@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:57:17PM -0700, Mike Tipton wrote:
> On 5/23/2023 2:52 AM, Johan Hovold wrote:
> > The icc_get() interface can be used to lookup an interconnect path based
> > on global node ids. There has never been any users of this interface and
> > all lookups are currently done from the devicetree.
> > 
> > Remove the unused icc_get() interface.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> We have downstream debug/test modules that removing icc_get() will 
> break. I'd like to get equivalent debug support in mainline, but until 
> then I'd prefer we not remove this.

I'm sure you've heard this before, but if it's not in mainline it does
not count. We don't carry code upstream for the sole benefit of
out-of-tree users.

> I suspect having a mainline approach for voting paths from debugfs would 
> be useful to others as well. There are similar debugfs control 
> mechanisms in other frameworks already, e.g. clock.
> 
> Instead of removing icc_get() immediately, can we wait for a future 
> patch series that adds debugfs as a consumer?

This function was merged over four years ago and has never been used in
mainline and I doubt a user will suddenly show up in the near future if
we were to keep it.

I guess you can just carry one more patch out-of-tree until you can
mainline a proper debugfs interface (which should probably not even use
this function, as you mentioned yourself).

Johan
