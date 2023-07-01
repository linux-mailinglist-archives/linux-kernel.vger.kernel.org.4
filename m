Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55647445E4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjGABis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGABiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD63C3F;
        Fri, 30 Jun 2023 18:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A1986181E;
        Sat,  1 Jul 2023 01:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA41C433C8;
        Sat,  1 Jul 2023 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688175524;
        bh=8tuPFYQini8cA31rl8RqFlqMpM/YpLu7utwQ2IOkLdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+6ushJQuZQ+/DiTNSJEeNv73mjLgpLtjmSo0uQQaZBH+XlnVU945qa+FTGFQ/ysL
         7BfmUj4eNjs9xlt6E644/IOTFqWyNpehx53LT2HATZYDKI4gX4zEUl+EPNjanfPbv3
         B6FugksYaED3wEe4c4dug0P3ofkY9sGfqKZrdUYGwL/EgAUg7DMvmSqyosc9wfuoJv
         usdZqjyiaHpd3Nzh/N76ALqHJkhyQs0THugr+sTY4OS0cEVT1ZOekgnZtTVRr4w3bf
         5cEAks4NKBFdD4hOFmEp1jRwCNiQtZFkz/j4xOgBsb3dJhG0eqvZfJnbui4yING4/6
         m6O3X4Oives8w==
Date:   Fri, 30 Jun 2023 18:38:43 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Message-ID: <ZJ+Do990LVNQx4rp@uf8f119305bce5e.ant.amazon.com>
References: <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Daniel,

On Fri, Jun 30, 2023 at 12:11:25PM +0200, Daniel Lezcano wrote:
> 
> 
> 
> Hi Rafael,
> 
> On 30/06/2023 10:16, Rafael J. Wysocki wrote:
> > On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:
> 
> [ ... ]
> 
> > So what about adding a new zone attribute that can be used to specify
> > the preferred caching time for the temperature?
> > 
> > That is, if the time interval between two consecutive updates of the
> > cached temperature value is less than the value of the new attribute,
> > the cached temperature value will be returned by "temp".  Otherwise,
> > it will cause the sensor to be read and the value obtained from it
> > will be returned to user space and cached.
> > 
> > If the value of the new attribute is 0, everything will work as it
> > does now (which will also need to be the default behavior).
> 
> I'm still not convinced about the feature.
> 
> Eduardo provided some numbers but they seem based on the characteristics
> of the I2C, not to a real use case. Eduardo?

Why I2C is not a real use case?



-- 
All the best,
Eduardo Valentin
