Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A26AC0FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCFNbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCFNbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:31:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F92E816;
        Mon,  6 Mar 2023 05:31:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB7060EA7;
        Mon,  6 Mar 2023 13:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3B0C433EF;
        Mon,  6 Mar 2023 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678109464;
        bh=PDxyfh9GHMbzLUrz8oTviZIgmt7uMmsCk/rf8ALQYc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upOM5hJF7UWkvjo7vYwexQOjCdV0rEZ2b+EF6JqmhjVnmQs1N0Oswfxb9fRsWczZd
         yTRhNbbO9d56vIpIEtSvTS2KyJLqZMnwF8bL2uBal36UoebQK5i4ywwSXCE9U2NcbX
         hNIExKqj9a4N5MdFIKWW+QTrzUywgyLpV4vfS3AKggppPsB2azyZ24FemR15ANH9Su
         +EeIzLQWFb9NtmVs2idMOvVfMvGnl4gw1DVQsvnFczPzC2xKzf7yFauzNNns/wo+Az
         bS6e8dgDY5hk6pB+BJoWMh5aW2WEeC6CZ7D0VLoAZwCATO1WZBK9VqP6A4GsBdwtRo
         6QYUpPRA02nZg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZAwK-00031b-Jh; Mon, 06 Mar 2023 14:31:45 +0100
Date:   Mon, 6 Mar 2023 14:31:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] drm/msm: use drmm_mode_config_init()
Message-ID: <ZAXrQF5l+Uu0iJ3M@hovoldconsulting.com>
References: <20230306100722.28485-1-johan+linaro@kernel.org>
 <20230306100722.28485-10-johan+linaro@kernel.org>
 <26986caf-1245-88f2-60d0-5930c86ea31b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26986caf-1245-88f2-60d0-5930c86ea31b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:38:37PM +0200, Dmitry Baryshkov wrote:
> On 06/03/2023 12:07, Johan Hovold wrote:
> > Switch to using drmm_mode_config_init() so that the mode config is
> > released when the last reference to the DRM device is dropped rather
> > than unconditionally at unbind() (which may be too soon).
> 
> This also means that drm_bridge_detach() might be called at some point 
> after unbind(), which might be too late.

Indeed.

Please disregard this patch. It's not needed to fix the bind error paths
anyway.

Johan
