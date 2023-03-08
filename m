Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF96AFDED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCHEeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCHEdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:33:46 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5C233FB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:33:44 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3284XTSB021512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 23:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678250011; bh=6eBgwYhaNsb4f/VJduAEdAamqyPQbmcvtbGKcjhn+dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WRBmdcZklPchT78WOnIX3P0Og7aUqTg5IKmtNVe2ZIluXfgn0YGdyjlMVYigi5KFk
         Fy0B0Ag6cu+xIiaPtINwfv5rROw9L5nSM8FKUcA24hP0nmdi9oOr8t23tH/9HviDsW
         i/a5XvPsh9LAQTjjNFaol+GjpyUBaOi628vkt2B5DEnbKfX9cErDTndn++efqwa+yr
         MG/P6ICe8z95RW2zU8qOrn2OwWGhmfsLyCY3Q0TFJPh3Uc+ZEhb1Xb621102qkrDrC
         ILRC4qaJxtImbA2xIwVIoT3UHlg6spgvl8d/kJgzVfbsnfUqV23WpMQ8GiBaOYroH0
         hJTDoS97WsoNg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CDDF915C3443; Tue,  7 Mar 2023 23:33:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, Lee Jones <joneslee@google.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: fix another off-by-one fsmap error on 1k block filesystems
Date:   Tue,  7 Mar 2023 23:33:21 -0500
Message-Id: <167824999281.2129363.10471803960046031746.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <Y+58NPTH7VNGgzdd@magnolia>
References: <Y+58NPTH7VNGgzdd@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 10:55:48 -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Apparently syzbot figured out that issuing this FSMAP call:
> 
> struct fsmap_head cmd = {
> 	.fmh_count	= ...;
> 	.fmh_keys	= {
> 		{ .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
> 		{ .fmr_device = /* ext4 dev */, .fmr_physical = 0, },
> 	},
> ...
> };
> ret = ioctl(fd, FS_IOC_GETFSMAP, &cmd);
> 
> [...]

Applied, thanks!

[1/1] ext4: fix another off-by-one fsmap error on 1k block filesystems
      commit: c993799baf9c5861f8df91beb80e1611b12efcbd

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
