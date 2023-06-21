Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF50D738149
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjFUKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjFUKyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F24C1BE4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A91B1614E2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DEFC433C0;
        Wed, 21 Jun 2023 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687344834;
        bh=8b+uU3Bs2sYqRmJk9/fT6n7FW28WjMTbPY0E1GKJS1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMF6LhlQ8BB9kWB22e32blkxJkHYKdSnN11rulUgtPhi6lIpYQ5GY+v+qP1GwDNVS
         AobbulHyeFXjObvKjs6whBlw2A87+z2ckauyf6gu46egCRue0gNn21iqItpjNmXQXG
         FrUPT2O5nKVyv9rRr31X3tkKP1z8xnBtb188e+tSHJXpDQ7Hh2bw/0CMwX+qIIF1vh
         ujJidCroEGOWsNy3mS7EUGGtTo6RlSw77kU7b6Ug+QRoLi9l4VQN+kSzxFAUPuZdev
         FWauUE17DS5B/0PHHVu4JHfmECqb7W3jPBI/bOw8ORmEK97BRE/UE4ufKgUSCOgaht
         /K4EfiN1xnDBw==
Date:   Wed, 21 Jun 2023 16:23:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] soundwire: bus: Prevent lockdep asserts when stream
 has multiple buses
Message-ID: <ZJLWvSRevDmdP/Cy@matsya>
References: <20230615141208.679011-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615141208.679011-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-23, 15:12, Richard Fitzgerald wrote:
> Give the bus_lock and msg_lock of each bus a different unique key
> so that it is possible to acquire the locks of multiple buses
> without lockdep asserting a possible deadlock.
> 
> Using mutex_init() to initialize a mutex gives all those mutexes
> the same lock class. Lockdep checking treats it as an error to
> attempt to take a mutex while already holding a mutex of the same
> class. This causes a lockdep assert when sdw_acquire_bus_lock()
> attempts to lock multiple buses, and when do_bank_switch() takes
> multiple msg_lock.

Applied both, thanks

-- 
~Vinod
