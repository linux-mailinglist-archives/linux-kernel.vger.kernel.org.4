Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89472D15C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbjFLVD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbjFLVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F433580;
        Mon, 12 Jun 2023 13:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9083E61D67;
        Mon, 12 Jun 2023 20:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5E1C433D2;
        Mon, 12 Jun 2023 20:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686603522;
        bh=fXkX7oIWIlOkq5NlC9TIb/9beHT/MF0O6/f5nJdTlJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvbcalsxSZLGgQNGH0etZIKYTxfZQAKT7qU7+Ectlargwp207XE0F2iQdMa/q/pM4
         7xgfg2mpIidN4eWd/WOPAsvqo0oZAkxCiYTVp1RrmySWKhuM4uW/DYGxuB6Ua1+ClE
         qUjDT9cChK/za4I+rVcfuu327LtkDqDA1R5W3ag7qUUV8Zal1nNfyF4JfThslBn3tm
         8vgiN+vmVjjiRkmlaHkJTWXsRfxeufxC0OnZS8zmtXn+UqhwNIjBNbiagvWKoCAyXt
         1CZ0YSk0x41DkSuWRLM7TfkmImeqIU+f57HEgUuJzoB/KsRlFYH974YS1gF56t22+F
         LlcDOaDoGcUhw==
Received: by pali.im (Postfix)
        id 1E9D67EB; Mon, 12 Jun 2023 22:58:39 +0200 (CEST)
Date:   Mon, 12 Jun 2023 22:58:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Message-ID: <20230612205839.wxo2h2ahqcdo73rc@pali>
References: <20230612090250.1417940-1-michal.wilczynski@intel.com>
 <20230612175205.eom2guabgfmnzrce@pali>
 <ZIeFjkAAiS+TMa8g@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIeFjkAAiS+TMa8g@smile.fi.intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2023 23:52:30 Andy Shevchenko wrote:
> On Mon, Jun 12, 2023 at 07:52:05PM +0200, Pali Rohár wrote:
> > On Monday 12 June 2023 12:02:50 Michal Wilczynski wrote:
> > > Currently rbtn_add() in case of failure is leaking resources. Fix this
> > > by adding a proper rollback. While at it, remove unnecessary assignment
> > > of NULL to device->driver_data and unnecessary whitespace, plus add a
> > > break for the default case in a switch.
> 
> ...
> 
> > Hello! I'm looking at rbtn_add() function and there is also code:
> > 
> > 	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
> > 	if (!rbtn_data)
> > 		return -ENOMEM;
> > 
> > which is called after rbtn_acquire(). So it looks like when kzalloc
> > fails then there is another leak...
> 
> Side note: In that case we would need a devm wrapper on acquire call.

Does it makes sense to invest time and more resources for these fixes?
Driver is not used on new Dell machines, so I would not expect new
users (instead less users, if they start upgrading HW to new Dell
machines).

Simple fix for this issue: Just move devm_kzalloc() call before
rbtn_acquire(true). And call cleanup rbtn_acquire(false) exactly like
Michal did in this patch.

I think that this should be enough, should cover all failure paths and
does not require to introduce new code or new design, which should be
properly tested for no regression.

What do you think?
