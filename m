Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76FE6717E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjARJiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjARJfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:35:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0396A193DE;
        Wed, 18 Jan 2023 00:54:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F81BB8118F;
        Wed, 18 Jan 2023 08:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D8DC433F0;
        Wed, 18 Jan 2023 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674032086;
        bh=qpbIsiLmAWo/Yyxp9eZJRCZtQ25fsobPBsJ/XpH9rEA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YhCyzSQcoTw8iqjo7c+CNIZCUhXds2k7rVb4XcN+Joyx3dW8gmlKluhfsTdV3fZnk
         Iz/A/2/KJqWZgb5dto5rbgTDx2HxISQyNyOvPDB3IC69jd1xhL4gLmFmRq29q4K9eF
         R1MdX8X/dqciwv9WSJhx3AiF0ixAjtKGqI1J8QIyYRXMIcZSL7Pfae6XvKRahJjr5M
         HoFCeHmLT7BnzDvklHdLeuatRGc2TIMBnxKgYUQRpYLdDwhCj68WLntkVR/AiX+XOY
         kwxMEVSNtdsO8rOkSoLI50KY1EWy6g6QYy/vfrlN9Mdw3Z/DJse9EfEO7wZjEuxDao
         0P70JC9bKnDbA==
Date:   Wed, 18 Jan 2023 09:54:46 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Aditya Garg <gargaditya08@live.com>
cc:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "orlandoch.dev@gmail.com" <orlandoch.dev@gmail.com>,
        "ronald@innovation.ch" <ronald@innovation.ch>
Subject: Re: [PATCH v3] HID: Recognize sensors with application collections
In-Reply-To: <9E66CF6F-99A0-4CC5-9FA0-3A9DCFCA0388@live.com>
Message-ID: <nycvar.YFH.7.76.2301180953340.1734@cbobk.fhfr.pm>
References: <8DA00FF4-DB08-4CEC-A5B4-47A71DC09C13@live.com> <01D620E2-18CA-40F6-A330-454CBC20C542@live.com> <EFCEA45A-C6F4-477A-B011-9C9E6E61E488@live.com> <9E66CF6F-99A0-4CC5-9FA0-3A9DCFCA0388@live.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023, Aditya Garg wrote:

> From: Ronald Tschalär <ronald@innovation.ch>
> 
> According to HUTRR39 logical sensor devices may be nested inside
> physical collections or may be specified in multiple top-level
> application collections (see page 59, strategies 1 and 2). However,
> the current code was only recognizing those with physical collections.
> 
> This issue turned up in the T2 MacBook Pros which define the ALS in
> a top-level application collection.
> 
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

Makes sense. Queued in for-6.3/hid-core. Thanks,

-- 
Jiri Kosina
SUSE Labs

